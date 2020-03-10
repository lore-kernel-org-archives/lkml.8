Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22EDC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F67222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EWtWPNdS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgCJU7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 16:59:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51458 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgCJU7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 16:59:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=a+XDis4Tmx90hHSPR6tuJGr7gvvV3SscmiwwFKQv5zo=; b=EWtWPNdShHkkO7dQGRj3SgEVo+
        PFvvXL38QtXGgO58ivEWw3G+uqOW/iTrvgTajhYav8VdETmIwPiorCs1h4M3Fap5FDTme1kt/PE9h
        pcLJfJxGPHLOuP3kCPpWGWW/ezKR5dTi7ToIp+kxEeqkr23SU4r3TLPfoi7NZHfvk2pKMGylTGlcz
        kFsOEgFbIymbhJF8rX0dGdDaqn4Bn4hFqp9Tn27r2AUYelp1eC1Y9JTEyXFB+KKqrDhGXIM7BbhQ6
        nH+ffkVsH0zRQmV7mJR2vKZDWPj+lQ3uMOJM8+FqqI0JTNj/3VlC3kUN4dyjLGC6iOqvbUgxDms6c
        myh+iCLA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jBly8-0004a6-JB; Tue, 10 Mar 2020 20:59:16 +0000
Subject: Re: [PATCH] panic: Add sysctl/cmdline to dump all CPUs backtraces on
 oops event
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, tglx@linutronix.de,
        akpm@linux-foundation.org, kernel@gpiccoli.net
References: <20200310163700.19186-1-gpiccoli@canonical.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <93f20e59-41b1-48ad-b0eb-e670b18994d5@infradead.org>
Date:   Tue, 10 Mar 2020 13:59:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310163700.19186-1-gpiccoli@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi-

On 3/10/20 9:37 AM, Guilherme G. Piccoli wrote:
> 
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
> ---
> 
> As a P.S. note, my choice to put the backtrace dump in the end of
> oops_enter() was from previous experience (in which I used this
> approach in a kprobes to collect more data on oops), but I'd
> gladly accept suggestion in case there's a better place to dump
> this. Thanks in advance for the reviews!
> Cheers,
> 
> Guilherme
> 
> 
>  .../admin-guide/kernel-parameters.txt         |  8 +++++++
>  Documentation/admin-guide/sysctl/kernel.rst   | 15 +++++++++++++
>  include/linux/kernel.h                        |  6 ++++++
>  kernel/panic.c                                | 21 +++++++++++++++++++
>  kernel/sysctl.c                               | 11 ++++++++++
>  5 files changed, 61 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 4c6595b5f6c8..888b1fab3f6e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3333,6 +3333,14 @@
>  			This will also cause panics on machine check exceptions.
>  			Useful together with panic=30 to trigger a reboot.
>  
> +	oops_all_cpu_backtrace=
> +			[KNL] Should kernel generates backtraces on all cpus

			                    generate backtraces on all CPUs

> +			when oops occurs - this should be a last measure resort
> +			in case	a kdump cannot be collected, for example.
> +			Defaults to 0 and can be controlled by the sysctl
> +			kernel.oops_all_cpu_backtrace.
> +			Format: <integer>
> +
>  	page_alloc.shuffle=
>  			[KNL] Boolean flag to control whether the page allocator
>  			should randomize its free lists. The randomization may
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index 218c717c1354..460112c3f656 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -573,6 +574,20 @@ numa_balancing_scan_size_mb is how many megabytes worth of pages are
>  scanned for a given scan.
>  
>  
> +oops_all_cpu_backtrace:
> +================
> +
> +Determines if kernel should NMI all CPUs to dump their backtraces when

I would much prefer that to be written without using NMI as a verb.

> +an oops event occurs. It should be used as a last resort in case a panic
> +cannot be triggered (to protect VMs running, for example) or kdump can't
> +be collected. This file shows up if CONFIG_SMP is enabled.
> +
> +0: Won't show all CPUs backtraces when an oops is detected.
> +This is the default behavior.
> +
> +1: Will NMI all CPUs and dump their backtraces when an oops is detected.

Same here.

> +
> +
>  osrelease, ostype & version:
>  ============================
>  



Thanks.
-- 
~Randy

