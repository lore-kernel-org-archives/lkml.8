Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CFEC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 11:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 973A820707
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 11:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="jDIns6L2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgHaL1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 07:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgHaLYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 07:24:22 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A0AC06123A;
        Mon, 31 Aug 2020 04:11:23 -0700 (PDT)
Received: from zn.tnic (p200300ec2f085000329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:5000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 747751EC02C1;
        Mon, 31 Aug 2020 13:11:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1598872282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6DWUFpLyD0dihOF5P86+PovaOqwSm4uuphdxui7Xrvw=;
        b=jDIns6L2Fow2zYngKM/z6o3+stBkjSGWtG75dZ7oqtqaPxtxigor349Wn+PgLw4keVwjjp
        aGyvQWklsUrmaMPkcUNbJSsd80F8bQK6/LPR2n+OcCBSaZdvuOTAI5qxMjjzxfkNrMnbvY
        xet6+Btlqkzw/ZLmYY6co4sAhcafvDM=
Date:   Mon, 31 Aug 2020 13:11:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>, hpa@zytor.com,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        David Rientjes <rientjes@google.com>,
        Cfir Cohen <cfir@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mike Stunes <mstunes@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Martin Radev <martin.b.radev@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v6 47/76] x86/dumpstack/64: Add noinstr version of
 get_stack_info()
Message-ID: <20200831111123.GG27517@zn.tnic>
References: <20200824085511.7553-1-joro@8bytes.org>
 <20200824085511.7553-48-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200824085511.7553-48-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 10:54:42AM +0200, Joerg Roedel wrote:
> diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
> index c49cf594714b..5a85730eb0ca 100644
> --- a/arch/x86/kernel/dumpstack_64.c
> +++ b/arch/x86/kernel/dumpstack_64.c
> @@ -85,7 +85,7 @@ struct estack_pages estack_pages[CEA_ESTACK_PAGES] ____cacheline_aligned = {
>  	EPAGERANGE(VC2),
>  };
>  
> -static bool in_exception_stack(unsigned long *stack, struct stack_info *info)
> +static bool __always_inline in_exception_stack(unsigned long *stack, struct stack_info *info)

Yeah, checkpatch seems to complain correctly here:

ERROR: inline keyword should sit between storage class and type
#88: FILE: arch/x86/kernel/dumpstack_64.c:88:
+static bool __always_inline in_exception_stack(unsigned long *stack, struct stack_info *info)

ERROR: inline keyword should sit between storage class and type
#97: FILE: arch/x86/kernel/dumpstack_64.c:129:
+static bool __always_inline in_irq_stack(unsigned long *stack, struct stack_info *info)

> +int get_stack_info(unsigned long *stack, struct task_struct *task,
> +		   struct stack_info *info, unsigned long *visit_mask)
> +{
> +	task = task ? : current;
> +
> +	if (!stack)
> +		goto unknown;
> +
> +	if (!get_stack_info_noinstr(stack, task, info))
> +		goto unknown;
>  
> -recursion_check:
>  	/*
>  	 * Make sure we don't iterate through any given stack more than once.
>  	 * If it comes up a second time then there's something wrong going on:
> @@ -196,4 +202,5 @@ int get_stack_info(unsigned long *stack, struct task_struct *task,
>  unknown:
>  	info->type = STACK_TYPE_UNKNOWN;
>  	return -EINVAL;
> +
^ Superfluous newline.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
