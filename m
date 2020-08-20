Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCADFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E1532078D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gtubPbuX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731812AbgHTKYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731809AbgHTKYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:24:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24642C061757;
        Thu, 20 Aug 2020 03:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qdnfNm3IUzTMwmlQEg5cRLJ7F7h28cIGXcZ5YJRE3sU=; b=gtubPbuXkk4dOz+fGtiw5/nuXj
        8DQU8y8NymTK/NQey14TfABLazVfI+wLeUuyp9U76iCTN4a8XSbHT0snK5IwEmrSJhLVUso8D8RlF
        pw9la++GvNu2tBpQYVhnvnglAUTWDH2YYuuVW691JsUFvlAZX9dmjLoNaaGbWBhaK0zGVM38912E/
        Yl1jQuTPnZpEzUqv+Cgc8Oc/FT5hqFo6TiDzHVbfPIv0eCsgKTK5clHJ5c0vLk2ipNtNlmGj43J1s
        yFpaWoWouEqs7CKciXZHWJfUEuX2ti5XXLaBCv5A8jl31/7ui9Juhqpr64jchD3RYLCNUXMPNC2/n
        lnfl1GKw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8hjW-0004sh-38; Thu, 20 Aug 2020 10:23:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 833B6302526;
        Thu, 20 Aug 2020 12:23:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 73D8928B7E826; Thu, 20 Aug 2020 12:23:44 +0200 (CEST)
Date:   Thu, 20 Aug 2020 12:23:44 +0200
From:   peterz@infradead.org
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>
Subject: Re: [tip: x86/urgent] x86/entry, selftests: Further improve user
 entry sanity checks
Message-ID: <20200820102344.GP2674@hirez.programming.kicks-ass.net>
References: <881de09e786ab93ce56ee4a2437ba2c308afe7a9.1593795633.git.luto@kernel.org>
 <159388495037.4006.7851835406474127743.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159388495037.4006.7851835406474127743.tip-bot2@tip-bot2>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 04, 2020 at 05:49:10PM -0000, tip-bot2 for Andy Lutomirski wrote:

> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> index f392a8b..e83b3f1 100644
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -49,6 +49,23 @@
>  static void check_user_regs(struct pt_regs *regs)
>  {
>  	if (IS_ENABLED(CONFIG_DEBUG_ENTRY)) {
> +		/*
> +		 * Make sure that the entry code gave us a sensible EFLAGS
> +		 * register.  Native because we want to check the actual CPU
> +		 * state, not the interrupt state as imagined by Xen.
> +		 */
> +		unsigned long flags = native_save_fl();
> +		WARN_ON_ONCE(flags & (X86_EFLAGS_AC | X86_EFLAGS_DF |
> +				      X86_EFLAGS_NT));

This triggers with AC|TF on my !SMAP enabled machine.

something like so then?

diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index a8f9315b9eae..76410964585f 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -18,8 +18,15 @@ static __always_inline void arch_check_user_regs(struct pt_regs *regs)
 		 * state, not the interrupt state as imagined by Xen.
 		 */
 		unsigned long flags = native_save_fl();
-		WARN_ON_ONCE(flags & (X86_EFLAGS_AC | X86_EFLAGS_DF |
-				      X86_EFLAGS_NT));
+		unsigned long mask = X86_EFLAGS_DF | X86_EFLAGS_NT;
+
+		/*
+		 * For !SMAP hardware we patch out CLAC on entry.
+		 */
+		if (boot_cpu_has(X86_FEATURE_SMAP))
+			mask |= X86_EFLAGS_AC;
+
+		WARN_ON_ONCE(flags & mask);
 
 		/* We think we came from user mode. Make sure pt_regs agrees. */
 		WARN_ON_ONCE(!user_mode(regs));
