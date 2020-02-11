Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1B8C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D593920870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581424779;
	bh=kzLCgKTPkI+N6fyK0lx70rE29ThRwi68n5bZdG+YZWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ogtJOst5opUXxAqzRgjEXVbuO6rtluPPhQ7rjhF6CDvM7U0FwuzH+vA8pm0bU6aXo
	 /u+PwLDoV4RQY3oaaAu0obnFiB/0oPqt8IZnUGvpbISIQYwAPl+Tgj3hV8dZK8eEyM
	 G1dniUtWMs+x29N9HoEoTb+2xgJWlflOLwUYFq2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbgBKMjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:39:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:54150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727954AbgBKMji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:39:38 -0500
Received: from linux-8ccs (p5B2812F9.dip0.t-ipconnect.de [91.40.18.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDBA3206DB;
        Tue, 11 Feb 2020 12:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581424778;
        bh=kzLCgKTPkI+N6fyK0lx70rE29ThRwi68n5bZdG+YZWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2V2oxVmA3ZU9a3hXs6yXvGpPxs249Jihi0gD1I+npFyX5WLNIBfkEiWnv+t6HTIsq
         alLzC957QPlWyp7aJSFqZnxFabvuVMly0YqQHOsvF1W2x+m3S8AOba6/o9VdNFMHFa
         BQnWtgzovTJpLev0wCvkAr5HrszBO0shgMuryLYc=
Date:   Tue, 11 Feb 2020 13:39:32 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        arjan@linux.intel.com, rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH 10/11] module: Reorder functions
Message-ID: <20200211123932.GA29598@linux-8ccs>
References: <20200205223950.1212394-1-kristen@linux.intel.com>
 <20200205223950.1212394-11-kristen@linux.intel.com>
 <202002060440.E7ED91B@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <202002060440.E7ED91B@keescook>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Kees Cook [06/02/20 04:41 -0800]:
>On Wed, Feb 05, 2020 at 02:39:49PM -0800, Kristen Carlson Accardi wrote:
>> If a module has functions split out into separate text sections
>> (i.e. compiled with the -ffunction-sections flag), reorder the
>> functions to provide some code diversification to modules.
>>
>> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
>
>Probably a good idea to add Jessica to CC in next version:
>	Jessica Yu <jeyu@kernel.org>

Thanks :)

>Reviewed-by: Kees Cook <keescook@chromium.org>
>
>-Kees
>
>> ---
>>  kernel/module.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 85 insertions(+)
>>
>> diff --git a/kernel/module.c b/kernel/module.c
>> index b56f3224b161..231563e95e61 100644
>> --- a/kernel/module.c
>> +++ b/kernel/module.c
>> @@ -53,6 +53,8 @@
>>  #include <linux/bsearch.h>
>>  #include <linux/dynamic_debug.h>
>>  #include <linux/audit.h>
>> +#include <linux/random.h>
>> +#include <asm/setup.h>
>>  #include <uapi/linux/module.h>
>>  #include "module-internal.h"
>>
>> @@ -3245,6 +3247,87 @@ static int find_module_sections(struct module *mod, struct load_info *info)
>>  	return 0;
>>  }
>>
>> +/*
>> + * shuffle_text_list()
>> + * Use a Fisher Yates algorithm to shuffle a list of text sections.
>> + */
>> +static void shuffle_text_list(Elf_Shdr **list, int size)
>> +{
>> +	int i;
>> +	unsigned int j;
>> +	Elf_Shdr *temp;
>> +
>> +	for (i = size - 1; i > 0; i--) {
>> +		/*
>> +		 * TBD - seed. We need to be able to use a known
>> +		 * seed so that we can non-randomly randomize for
>> +		 * debugging.
>> +		 */
>> +
>> +		// pick a random index from 0 to i
>> +		get_random_bytes(&j, sizeof(j));
>> +		j = j % (i + 1);
>> +
>> +		temp = list[i];
>> +		list[i] = list[j];
>> +		list[j] = temp;
>> +	}
>> +}
>> +
>> +/*
>> + * randomize_text()
>> + * Look through the core section looking for executable code sections.
>> + * Store sections in an array and then shuffle the sections
>> + * to reorder the functions.
>> + */
>> +static void randomize_text(struct module *mod, struct load_info *info)
>> +{
>> +	int i;
>> +	int num_text_sections = 0;
>> +	Elf_Shdr **text_list;
>> +	int size = 0;
>> +	int max_sections = info->hdr->e_shnum;
>> +	unsigned int sec = find_sec(info, ".text");
>> +
>> +	if (!IS_ENABLED(CONFIG_FG_KASLR) || !kaslr_enabled())
>> +		return;

Maybe put this conditional before the call to randomize_text() in
move_module()? Just for code readability reasons (i.e., we only call
randomize_text() when CONFIG_FG_KASLR || kaslr_enabled()). But this is
just a matter of preference.

>> +
>> +	if (sec == 0)
>> +		return;
>> +
>> +	text_list = kmalloc_array(max_sections, sizeof(*text_list), GFP_KERNEL);
>> +	if (text_list == NULL)
>> +		return;
>> +
>> +	for (i = 0; i < max_sections; i++) {
>> +		Elf_Shdr *shdr = &info->sechdrs[i];
>> +		const char *sname = info->secstrings + shdr->sh_name;
>> +
>> +		if (!(shdr->sh_flags & SHF_ALLOC) ||
>> +		    !(shdr->sh_flags & SHF_EXECINSTR) ||
>> +		    strstarts(sname, ".init"))
>> +			continue;
>> +
>> +		text_list[num_text_sections] = shdr;
>> +		num_text_sections++;
>> +	}
>> +
>> +	shuffle_text_list(text_list, num_text_sections);
>> +
>> +	for (i = 0; i < num_text_sections; i++) {
>> +		Elf_Shdr *shdr = text_list[i];
>> +		unsigned int infosec;
>> +		const char *sname;
>> +
>> +		sname = info->secstrings + shdr->sh_name;

sname doesn't appear to be used after this (?)

>> +		infosec	= shdr->sh_info;
>> +
>> +		shdr->sh_entsize = get_offset(mod, &size, shdr, infosec);

get_offset() expects a section index as the last argument, but sh_info
is 0 for text sections (SHT_PROGBITS). It's really only used in
arch_mod_section_prepend() though, which is only defined for parisc.
We could perhaps save the section index in sh_info in the previous for
loop (hacky, I have to double check if this is actually safe, but it
seems sh_info only has signficance for SHT_REL* and SHT_SYMTAB
sections).

>> +	}
>> +
>> +	kfree(text_list);
>> +}
>> +
>>  static int move_module(struct module *mod, struct load_info *info)
>>  {
>>  	int i;
>> @@ -3282,6 +3365,8 @@ static int move_module(struct module *mod, struct load_info *info)
>>  	} else
>>  		mod->init_layout.base = NULL;
>>
>> +	randomize_text(mod, info);

Hm, I wonder if we should not incorporate the randomize_text() logic into
layout_sections() instead of move_module(), since logically speaking
layout_sections() determines all the section offsets and stores them
in sh_entsize, whereas move_module() does all the allocations and
copying to final destination. Just a thought.


Thanks!

Jessica
