Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9BDC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D2F7208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q28esEeF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgEHIfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 04:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgEHIfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 04:35:23 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF5AC05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 01:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WM/UApq1Je0S5ose2e/Ls+fkaGBLraijdaLfrbnVPP8=; b=q28esEeFx1ucHAf2B1WQNvaNLw
        egfmFBpTBHJb+pG1o4fP5xAeNuAv9dawDZBBC+lUnOAZKPRCYN8ocrqM7D3z5UAHTOW9AzC1OOIMr
        6kjo1uH/WV/P+wZOfd1Lk5a6yjGPOSD0AVshX/K2PU+iu8J0XgNHK7QwOCmZ4IZ5cm5W686PmGqSi
        0nbh7k8bFshLbmXIfZ87D/tCoXaBceyZuSUNmezOZtr8BmvAUKdRrz10yz9/vuVIcxR7U+wzBZ9g9
        Ck8Tb1dim1hwFMK8SeEDpRvZyslXf0QL6vST8gH0b4Ac5cMYPoMn33EpLftJTUGR1d6NqHGhPHx9S
        5TEwHwHw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWyTH-00047c-UM; Fri, 08 May 2020 08:35:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5E3B73010C8;
        Fri,  8 May 2020 10:35:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 484B12038FB83; Fri,  8 May 2020 10:35:02 +0200 (CEST)
Date:   Fri, 8 May 2020 10:35:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jakub Jelinek <jakub@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, hjl.tools@gmail.com
Subject: Re: [PATCH] Kconfig: default to CC_OPTIMIZE_FOR_PERFORMANCE_O3 for
 gcc >= 10
Message-ID: <20200508083502.GP5298@hirez.programming.kicks-ass.net>
References: <20200507224530.2993316-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507224530.2993316-1-Jason@zx2c4.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 04:45:30PM -0600, Jason A. Donenfeld wrote:
> GCC 10 appears to have changed -O2 in order to make compilation time
> faster when using -flto, seemingly at the expense of performance, in
> particular with regards to how the inliner works. Since -O3 these days
> shouldn't have the same set of bugs as 10 years ago, this commit
> defaults new kernel compiles to -O3 when using gcc >= 10.

Would be nice to get some GCC person's feedback on this. But in general,
I think you're right in that O3 isn't the code-gen disaster it used to
be.

> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  init/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index 9e22ee8fbd75..fab3f810a68d 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1245,7 +1245,8 @@ config BOOT_CONFIG
>  
>  choice
>  	prompt "Compiler optimization level"
> -	default CC_OPTIMIZE_FOR_PERFORMANCE
> +	default CC_OPTIMIZE_FOR_PERFORMANCE_O3 if GCC_VERSION >= 100000
> +	default CC_OPTIMIZE_FOR_PERFORMANCE if (GCC_VERSION < 100000 || CC_IS_CLANG)
>  
>  config CC_OPTIMIZE_FOR_PERFORMANCE
>  	bool "Optimize for performance (-O2)"
> -- 
> 2.26.2
> 
