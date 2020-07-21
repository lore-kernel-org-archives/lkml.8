Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262B6C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0906C20720
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbgGUI7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 04:59:17 -0400
Received: from albireo.enyo.de ([37.24.231.21]:51974 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726919AbgGUI7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 04:59:17 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1jxo79-0002DH-Dg; Tue, 21 Jul 2020 08:59:07 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1jxo79-00066m-99; Tue, 21 Jul 2020 10:59:07 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Kevin Buettner <kevinb@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] copy_xstate_to_kernel: Fix typo which caused GDB regression
References: <20200718002003.6e0a2aef@f32-m1.lan>
Date:   Tue, 21 Jul 2020 10:59:07 +0200
In-Reply-To: <20200718002003.6e0a2aef@f32-m1.lan> (Kevin Buettner's message of
        "Sat, 18 Jul 2020 00:20:03 -0700")
Message-ID: <87tuy1s0pw.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Kevin Buettner:

> This commit fixes a regression encountered while running the
> gdb.base/corefile.exp test in GDB's test suite.
>
> In my testing, the typo prevented the sw_reserved field of struct
> fxregs_state from being output to the kernel XSAVES area.  Thus the
> correct mask corresponding to XCR0 was not present in the core file
> for GDB to interrogate, resulting in the following behavior:
>
> [kev@f32-1 gdb]$ ./gdb -q testsuite/outputs/gdb.base/corefile/corefile testsuite/outputs/gdb.base/corefile/corefile.core
> Reading symbols from testsuite/outputs/gdb.base/corefile/corefile...
> [New LWP 232880]
>
> warning: Unexpected size of section `.reg-xstate/232880' in core file.
>
> With the typo fixed, the test works again as expected.
>
> Signed-off-by: Kevin Buettner <kevinb@redhat.com>
> ---
>  arch/x86/kernel/fpu/xstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index 6a54e83d5589..9cf40a7ff7ae 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -1022,7 +1022,7 @@ int copy_xstate_to_kernel(void *kbuf, struct xregs_state *xsave, unsigned int of
>  		copy_part(offsetof(struct fxregs_state, st_space), 128,
>  			  &xsave->i387.st_space, &kbuf, &offset_start, &count);
>  	if (header.xfeatures & XFEATURE_MASK_SSE)
> -		copy_part(xstate_offsets[XFEATURE_MASK_SSE], 256,
> +		copy_part(xstate_offsets[XFEATURE_SSE], 256,
>  			  &xsave->i387.xmm_space, &kbuf, &offset_start, &count);
>  	/*
>  	 * Fill xsave->i387.sw_reserved value for ptrace frame:

Does this read out-of-bounds, potentially disclosing kernel memory?
Not if the system supports AVX, I assume.
