Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163EFC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC3582067C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EShKUjMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgHSIIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 04:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgHSIHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 04:07:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DA4C061389
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 01:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fGk4v6s6eN3JR296fKsBOkY17sDWO96rtqu7J+SOg4A=; b=EShKUjMZcuL7FOhoFSQn2wu1hg
        T3dsIsxb91aHIDC92mKvAWXyo+W3ZIeezLA+0YA6Lard83NUE4ga4k8aHgh1HPmUdaVR9voAhIkxA
        3NXWVZJXA+ZsRreTZk0wHgO64YPYKI/JXirFQWvUKaPjM/Lg6NJ8B9vp+3nY4L8gmlyUHb/2cmXqe
        EVQCoVcAinbT4MqsJ296aUa+9vpcgJl0RyND+/56h35PljPv5PPpszSx2e94hutYPgMG2FIlHoRw5
        FIY/cwDzj1Gxwr3U4SFs6Eu+y110c4Biw4dBV1GmaJaUN+CdFcDmrQHZny4f9KsUFDyTm3iVdEprb
        oTFf+/nA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8J7O-0005qD-F3; Wed, 19 Aug 2020 08:06:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5872C301A7A;
        Wed, 19 Aug 2020 10:06:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 441592110B86A; Wed, 19 Aug 2020 10:06:45 +0200 (CEST)
Date:   Wed, 19 Aug 2020 10:06:45 +0200
From:   peterz@infradead.org
To:     Libing Zhou <libing.zhou@nokia-sbell.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, bp@suse.de,
        x86@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com
Subject: Re: [PATCH] x86/nmi: Fix nmi_handle duration miscalculation
Message-ID: <20200819080645.GX2674@hirez.programming.kicks-ass.net>
References: <20200817090441.44501-1-libing.zhou@nokia-sbell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817090441.44501-1-libing.zhou@nokia-sbell.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 05:04:41PM +0800, Libing Zhou wrote:
> In nmi_check_duration(), the 'whole_msecs' value should
> get from 'duration' to reflect actual time duration,
> but not 'action->max_duration'.

Fixes: 248ed51048c4 ("x86/nmi: Remove irq_work from the long duration NMI handler")

> Signed-off-by: Libing Zhou <libing.zhou@nokia-sbell.com>
> ---
>  arch/x86/kernel/nmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
> index 4fc9954a9560..c51ee659e520 100644
> --- a/arch/x86/kernel/nmi.c
> +++ b/arch/x86/kernel/nmi.c
> @@ -102,7 +102,7 @@ fs_initcall(nmi_warning_debugfs);
>  
>  static void nmi_check_duration(struct nmiaction *action, u64 duration)
>  {
> -	u64 whole_msecs = READ_ONCE(action->max_duration);
> +	u64 whole_msecs = duration;
>  	int remainder_ns, decimal_msecs;
>  
>  	if (duration < nmi_longest_ns || duration < action->max_duration)

The, IMO, saner solution is:

---
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 4fc9954a9560..47381666d6a5 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -102,7 +102,6 @@ fs_initcall(nmi_warning_debugfs);
 
 static void nmi_check_duration(struct nmiaction *action, u64 duration)
 {
-	u64 whole_msecs = READ_ONCE(action->max_duration);
 	int remainder_ns, decimal_msecs;
 
 	if (duration < nmi_longest_ns || duration < action->max_duration)
@@ -110,12 +109,12 @@ static void nmi_check_duration(struct nmiaction *action, u64 duration)
 
 	action->max_duration = duration;
 
-	remainder_ns = do_div(whole_msecs, (1000 * 1000));
+	remainder_ns = do_div(duration, (1000 * 1000));
 	decimal_msecs = remainder_ns / 1000;
 
 	printk_ratelimited(KERN_INFO
 		"INFO: NMI handler (%ps) took too long to run: %lld.%03d msecs\n",
-		action->handler, whole_msecs, decimal_msecs);
+		action->handler, duration, decimal_msecs);
 }
 
 static int nmi_handle(unsigned int type, struct pt_regs *regs)
