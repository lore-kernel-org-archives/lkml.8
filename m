Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A555C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 16:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6088C2073A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 16:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgAOQhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 11:37:22 -0500
Received: from foss.arm.com ([217.140.110.172]:39732 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbgAOQhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 11:37:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D710328;
        Wed, 15 Jan 2020 08:37:21 -0800 (PST)
Received: from [10.1.199.115] (e120195-lin.cambridge.arm.com [10.1.199.115])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 610E43F718;
        Wed, 15 Jan 2020 08:37:20 -0800 (PST)
Subject: Re: [RFC v5 44/57] objtool: arm64: Implement functions to add switch
 tables alternatives
To:     Julien Thierry <jthierry@redhat.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will@kernel.org
References: <20200109160300.26150-1-jthierry@redhat.com>
 <20200109160300.26150-45-jthierry@redhat.com>
From:   Raphael Gault <raphael.gault@arm.com>
Message-ID: <370e38b3-3c0c-e552-16fa-36571dd8e66b@arm.com>
Date:   Wed, 15 Jan 2020 16:37:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200109160300.26150-45-jthierry@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julien,

On 1/9/20 4:02 PM, Julien Thierry wrote:
> This patch implements the functions required to identify and add as
> alternatives all the possible destinations of the switch table.
> This implementation relies on the new plugin introduced previously which
> records information about the switch-table in a
> .discard.switch_table_information section.

I think you forgot to update the name of the section with respect to 
what was done in the previous patch (.discard.switch_table_info instead 
of .discard.switch_table_information).

> 
> Signed-off-by: Raphael Gault <raphael.gault@arm.com>
> [J.T.: Update arch implementation to new prototypes,
>         Update switch table information section name,
>         Do some clean up,
>         Use the offset sign information,
>         Use the newly added rela to find the corresponding jump instruction]
> Signed-off-by: Julien Thierry <jthierry@redhat.com>
> ---
>   tools/objtool/arch/arm64/arch_special.c       | 251 +++++++++++++++++-
>   .../objtool/arch/arm64/include/arch_special.h |   2 +
>   tools/objtool/check.c                         |   4 +-
>   tools/objtool/check.h                         |   2 +
>   4 files changed, 255 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/objtool/arch/arm64/arch_special.c b/tools/objtool/arch/arm64/arch_special.c
> index 5239489c9c57..a15f6697dc74 100644
> --- a/tools/objtool/arch/arm64/arch_special.c
> +++ b/tools/objtool/arch/arm64/arch_special.c
> @@ -1,15 +1,262 @@
>   // SPDX-License-Identifier: GPL-2.0-or-later
>   
> +#include <stdlib.h>
> +#include <string.h>
> +
>   #include "../../special.h"
> +#include "../../warn.h"
> +#include "arch_special.h"
> +#include "bit_operations.h"
> +#include "insn_decode.h"
> +
> +/*
> + * The arm64_switch_table_detection_plugin generate an array of elements
> + * described by the following structure.
> + * Each jump table found in the compilation unit is associated with one of
> + * entries of the array.
> + */
> +struct switch_table_info {
> +	u64 switch_table_ref; // Relocation target referencing the beginning of the jump table
> +	u64 dyn_jump_ref; // Relocation target referencing the set of instructions setting up the jump to the table
> +	u64 nb_entries;
> +	u64 offset_unsigned;
> +} __attribute__((__packed__));
> +
> +static bool insn_is_adr_pcrel(struct instruction *insn)
> +{
> +	u32 opcode = *(u32 *)(insn->sec->data->d_buf + insn->offset);
> +
> +	return ((opcode >> 24) & 0x1f) == 0x10;
> +}
> +
> +static s64 next_offset(void *table, u8 entry_size, bool is_signed)
> +{
> +	if (!is_signed) {
> +		switch (entry_size) {
> +		case 1:
> +			return *(u8 *)(table);
> +		case 2:
> +			return *(u16 *)(table);
> +		default:
> +			return *(u32 *)(table);
> +		}
> +	} else {
> +		switch (entry_size) {
> +		case 1:
> +			return *(s8 *)(table);
> +		case 2:
> +			return *(s16 *)(table);
> +		default:
> +			return *(s32 *)(table);
> +		}
> +	}
> +}
> +
> +static u32 get_table_entry_size(u32 insn)
> +{
> +	unsigned char size = (insn >> 30) & ONES(2);
> +
> +	switch (size) {
> +	case 0:
> +		return 1;
> +	case 1:
> +		return 2;
> +	default:
> +		return 4;
> +	}
> +}
> +
> +static int add_possible_branch(struct objtool_file *file,
> +			       struct instruction *insn,
> +			       u32 base, s64 offset)
> +{
> +	struct instruction *dest_insn;
> +	struct alternative *alt;
> +
> +	offset = base + 4 * offset;
> +
> +	dest_insn = find_insn(file, insn->sec, offset);
> +	if (!dest_insn)
> +		return 0;
> +
> +	alt = calloc(1, sizeof(*alt));
> +	if (!alt) {
> +		WARN("allocation failure, can't add jump alternative");
> +		return -1;
> +	}
> +
> +	alt->insn = dest_insn;
> +	alt->skip_orig = true;
> +	list_add_tail(&alt->list, &insn->alts);
> +	return 0;
> +}
> +
> +static struct switch_table_info *get_swt_info(struct section *swt_info_sec,
> +					      struct instruction *insn)
> +{
> +	u64 *table_ref;
> +
> +	if (!insn->jump_table) {
> +		WARN("no jump table available for %s+0x%lx",
> +		     insn->sec->name, insn->offset);
> +		return NULL;
> +	}
> +	table_ref = (void *)(swt_info_sec->data->d_buf +
> +			     insn->jump_table->offset);
> +	return container_of(table_ref, struct switch_table_info,
> +			    switch_table_ref);
> +}
> +
> +static int add_arm64_jump_table_dests(struct objtool_file *file,
> +				      struct instruction *insn)
> +{
> +	struct switch_table_info *swt_info;
> +	struct section *objtool_data;
> +	struct section *rodata_sec;
> +	struct section *branch_sec;
> +	struct instruction *pre_jump_insn;
> +	u8 *switch_table;
> +	u32 entry_size;
> +
> +	objtool_data = find_section_by_name(file->elf,
> +					    ".discard.switch_table_info");
> +	if (!objtool_data)
> +		return 0;
> +
> +	/*
> +	 * 1. Identify entry for the switch table
> +	 * 2. Retrieve branch instruction
> +	 * 3. Retrieve base offset
> +	 * 3. For all entries in switch table:
> +	 *     3.1. Compute new offset
> +	 *     3.2. Create alternative instruction
> +	 *     3.3. Add alt_instr to insn->alts list
> +	 */
> +	swt_info = get_swt_info(objtool_data, insn);
> +
> +	/* retrieving pre jump instruction (ldr) */
> +	branch_sec = insn->sec;
> +	pre_jump_insn = find_insn(file, branch_sec,
> +				  insn->offset - 3 * sizeof(u32));
> +	entry_size = get_table_entry_size(*(u32 *)(branch_sec->data->d_buf +
> +						   pre_jump_insn->offset));
> +
> +	/* retrieving switch table content */
> +	rodata_sec = find_section_by_name(file->elf, ".rodata");
> +	switch_table = (u8 *)(rodata_sec->data->d_buf +
> +			      insn->jump_table->addend);
> +
> +	/*
> +	 * iterating over the pre-jumps instruction in order to
> +	 * retrieve switch base offset.
> +	 */
> +	while (pre_jump_insn && pre_jump_insn->offset <= insn->offset) {
> +		if (insn_is_adr_pcrel(pre_jump_insn)) {
> +			u64 base_offset;
> +			int i;
> +
> +			base_offset = pre_jump_insn->offset +
> +				      pre_jump_insn->immediate;
> +
> +			/*
> +			 * Once we have the switch table entry size
> +			 * we add every possible destination using
> +			 * alternatives of the original branch
> +			 * instruction
> +			 */
> +			for (i = 0; i < swt_info->nb_entries; i++) {
> +				s64 table_offset = next_offset(switch_table,
> +							       entry_size,
> +							       !swt_info->offset_unsigned);
> +
> +				if (add_possible_branch(file, insn,
> +							base_offset,
> +							table_offset)) {
> +					return -1;
> +				}
> +				switch_table += entry_size;
> +			}
> +			break;
> +		}
> +		pre_jump_insn = next_insn_same_sec(file, pre_jump_insn);
> +	}
> +
> +	return 0;
> +}
>   
>   int arch_add_jump_table_dests(struct objtool_file *file,
>   			      struct instruction *insn)
>   {
> -	return 0;
> +	return add_arm64_jump_table_dests(file, insn);
>   }
>   
> +static struct rela *find_swt_info_jump_rela(struct section *swt_info_sec,
> +					    u32 index)
> +{
> +	u32 rela_offset;
> +
> +	rela_offset = index * sizeof(struct switch_table_info) +
> +		      offsetof(struct switch_table_info, dyn_jump_ref);
> +	return find_rela_by_dest(swt_info_sec, rela_offset);
> +}
> +
> +static struct rela *find_swt_info_table_rela(struct section *swt_info_sec,
> +					     u32 index)
> +{
> +	u32 rela_offset;
> +
> +	rela_offset = index * sizeof(struct switch_table_info) +
> +		      offsetof(struct switch_table_info, switch_table_ref);
> +	return find_rela_by_dest(swt_info_sec, rela_offset);
> +}
> +
> +/*
> + * Aarch64 jump tables are just arrays of offsets (of varying size/signess)
> + * representing the potential destination from a base address loaded by an adr
> + * instruction.
> + *
> + * Aarch64 branches to jump tables are composed of multiple instructions:
> + *
> + *     ldr<?>  x_offset, [x_offsets_table, x_index, ...]
> + *     adr     x_dest_base, <addr>
> + *     add     x_dest, x_target_base, x_offset, ...
> + *     br      x_dest
> + *
> + * The arm64_switch_table_detection_plugin will make the connection between
> + * the instruction setting x_offsets_table (dyn_jump_ref) and the actual
> + * table of offsets (switch_table_ref)
> + */
>   struct rela *arch_find_switch_table(struct objtool_file *file,
>   				    struct instruction *insn)
>   {
> -	return NULL;
> +	struct section *objtool_data;
> +	struct rela *res = NULL;
> +	u32 nb_swt_entries = 0;
> +	u32 i;
> +
> +	objtool_data = find_section_by_name(file->elf,
> +					    ".discard.switch_table_info");
> +	if (objtool_data)
> +		nb_swt_entries = objtool_data->sh.sh_size /
> +				 sizeof(struct switch_table_info);
> +
> +	for (i = 0; i < nb_swt_entries; i++) {
> +		struct rela *info_rela;
> +
> +		info_rela = find_swt_info_jump_rela(objtool_data, i);
> +		if (info_rela && info_rela->sym->sec == insn->sec &&
> +		    info_rela->addend == insn->offset) {
> +			if (res) {
> +				WARN_FUNC("duplicate objtool_data rela",
> +					  info_rela->sec, info_rela->offset);
> +				continue;
> +			}
> +			res = find_swt_info_table_rela(objtool_data, i);
> +			if (!res)
> +				WARN_FUNC("missing relocation in objtool data",
> +					  info_rela->sec, info_rela->offset);
> +		}
> +	}
> +
> +	return res;
>   }
> diff --git a/tools/objtool/arch/arm64/include/arch_special.h b/tools/objtool/arch/arm64/include/arch_special.h
> index a82a9b3e51df..b96bcee308cf 100644
> --- a/tools/objtool/arch/arm64/include/arch_special.h
> +++ b/tools/objtool/arch/arm64/include/arch_special.h
> @@ -3,6 +3,8 @@
>   #ifndef _ARM64_ARCH_SPECIAL_H
>   #define _ARM64_ARCH_SPECIAL_H
>   
> +#include <linux/types.h>
> +
>   #define EX_ENTRY_SIZE		8
>   #define EX_ORIG_OFFSET		0
>   #define EX_NEW_OFFSET		4
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index e0c6bda261c8..80ea5bbd36ab 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -33,8 +33,8 @@ struct instruction *find_insn(struct objtool_file *file,
>   	return NULL;
>   }
>   
> -static struct instruction *next_insn_same_sec(struct objtool_file *file,
> -					      struct instruction *insn)
> +struct instruction *next_insn_same_sec(struct objtool_file *file,
> +				       struct instruction *insn)
>   {
>   	struct instruction *next = list_next_entry(insn, list);
>   
> diff --git a/tools/objtool/check.h b/tools/objtool/check.h
> index 91adec42782c..15165d04d9cb 100644
> --- a/tools/objtool/check.h
> +++ b/tools/objtool/check.h
> @@ -66,6 +66,8 @@ int check(const char *objname, bool orc);
>   
>   struct instruction *find_insn(struct objtool_file *file,
>   			      struct section *sec, unsigned long offset);
> +struct instruction *next_insn_same_sec(struct objtool_file *file,
> +				       struct instruction *insn);
>   
>   #define for_each_insn(file, insn)					\
>   	list_for_each_entry(insn, &file->insn_list, list)
> 

Cheers,

-- 
Raphaël Gault
