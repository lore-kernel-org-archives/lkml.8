Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5423DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 15:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F37C20838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 15:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cZd8ccnW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbgG3PDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 11:03:51 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56410 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726353AbgG3PDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 11:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596121430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CApRjd3Cyk4gZKdLw8NgMxP6Bz99kChxK+L2ACXnMeE=;
        b=cZd8ccnWky8exAw0uWw7DBCqe/0QWHZFYAGN6yKISbuzemJXzEg1wxycGVaH66A8itX3yV
        JH+9J9krVClpt9WymAm0m+pRLPfZW9hFWG2xZ/PuZleU+5QL/ZsJicdqW0fXsZZHlDyVGd
        lDoCBTcEZQNRM1vDVzIeCNRI76oiNxo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-bnZYmRT9PcKWJb4Bg1mPlw-1; Thu, 30 Jul 2020 11:03:46 -0400
X-MC-Unique: bnZYmRT9PcKWJb4Bg1mPlw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E7A61005504;
        Thu, 30 Jul 2020 15:03:45 +0000 (UTC)
Received: from treble (ovpn-119-23.rdu2.redhat.com [10.10.119.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A2C890E6B;
        Thu, 30 Jul 2020 15:03:43 +0000 (UTC)
Date:   Thu, 30 Jul 2020 10:03:41 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org
Subject: Re: [PATCH v2 9/9] objtool: Abstract unwind hint reading
Message-ID: <20200730150341.udqnykbw7yfsjvin@treble>
References: <20200730094652.28297-1-jthierry@redhat.com>
 <20200730094652.28297-10-jthierry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200730094652.28297-10-jthierry@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 10:46:52AM +0100, Julien Thierry wrote:
> The type of unwind hints and the semantics associated with them depend
> on the architecture. Let arch specific code convert unwind hints into
> objtool stack state descriptions.
> 
> Signed-off-by: Julien Thierry <jthierry@redhat.com>
> ---
>  tools/objtool/arch.h            |  5 +--
>  tools/objtool/arch/x86/decode.c | 54 ++++++++++++++++++++++++++++++
>  tools/objtool/cfi.h             |  3 +-
>  tools/objtool/check.c           | 58 +++++----------------------------
>  tools/objtool/orc_gen.c         |  4 ++-
>  5 files changed, 71 insertions(+), 53 deletions(-)
> 
> diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
> index 2e2ce089b0e9..44107e9aab71 100644
> --- a/tools/objtool/arch.h
> +++ b/tools/objtool/arch.h
> @@ -7,12 +7,11 @@
>  #define _ARCH_H
>  
>  #include <stdbool.h>
> +#include <linux/frame.h>
>  #include <linux/list.h>
>  #include "objtool.h"
>  #include "cfi.h"
>  
> -#include <asm/orc_types.h>
> -
>  enum insn_type {
>  	INSN_JUMP_CONDITIONAL,
>  	INSN_JUMP_UNCONDITIONAL,
> @@ -86,4 +85,6 @@ unsigned long arch_dest_reloc_offset(int addend);
>  
>  const char *arch_nop_insn(int len);
>  
> +int arch_decode_insn_hint(struct instruction *insn, struct unwind_hint *hint);
> +
>  #endif /* _ARCH_H */
> diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
> index 1967370440b3..2099809925af 100644
> --- a/tools/objtool/arch/x86/decode.c
> +++ b/tools/objtool/arch/x86/decode.c
> @@ -6,6 +6,8 @@
>  #include <stdio.h>
>  #include <stdlib.h>
>  
> +#include <linux/frame.h>
> +
>  #define unlikely(cond) (cond)
>  #include <asm/insn.h>
>  #include "../../../arch/x86/lib/inat.c"
> @@ -15,6 +17,7 @@
>  #include "../../elf.h"
>  #include "../../arch.h"
>  #include "../../warn.h"
> +#include <asm/orc_types.h>
>  
>  static unsigned char op_to_cfi_reg[][2] = {
>  	{CFI_AX, CFI_R8},
> @@ -583,3 +586,54 @@ const char *arch_nop_insn(int len)
>  
>  	return nops[len-1];
>  }
> +
> +int arch_decode_insn_hint(struct instruction *insn, struct unwind_hint *hint)
> +{
> +	struct cfi_reg *cfa = &insn->cfi.cfa;
> +
> +	if (hint->type == UNWIND_HINT_TYPE_RET_OFFSET) {
> +		insn->ret_offset = hint->sp_offset;
> +		return 0;
> +	}
> +
> +	insn->hint = true;
> +
> +	switch (hint->sp_reg) {
> +	case ORC_REG_UNDEFINED:
> +		cfa->base = CFI_UNDEFINED;
> +		break;
> +	case ORC_REG_SP:
> +		cfa->base = CFI_SP;
> +		break;
> +	case ORC_REG_BP:
> +		cfa->base = CFI_BP;
> +		break;
> +	case ORC_REG_SP_INDIRECT:
> +		cfa->base = CFI_SP_INDIRECT;
> +		break;
> +	case ORC_REG_R10:
> +		cfa->base = CFI_R10;
> +		break;
> +	case ORC_REG_R13:
> +		cfa->base = CFI_R13;
> +		break;
> +	case ORC_REG_DI:
> +		cfa->base = CFI_DI;
> +		break;
> +	case ORC_REG_DX:
> +		cfa->base = CFI_DX;
> +		break;
> +	default:
> +		WARN_FUNC("unsupported unwind_hint sp base reg %d",
> +			  insn->sec, insn->offset, hint->sp_reg);
> +		return -1;
> +	}
> +
> +	cfa->offset = hint->sp_offset;
> +	insn->cfi.hint_type = hint->type;
> +	insn->cfi.end = hint->end;
> +
> +	insn->cfi.sp_only = hint->type == ORC_TYPE_REGS || hint->type == ORC_TYPE_REGS_IRET;

What does "sp" mean here in sp_only?

> +		if (arch_decode_insn_hint(insn, hint)) {
> +			WARN_FUNC("Bad unwind hint", insn->sec, insn->offset);

No need for a warning here, since the arch-specific function already
prints one.

-- 
Josh

