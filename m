Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F1DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4108720643
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mAgHybls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgERJI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 05:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgERJI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 05:08:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218B0C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 02:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Dj7W1Pok/CM8/GgPOS9QU5HxmHWDMiIGXPcFERI+MEo=; b=mAgHyblsdaRv7HLoi7eAJsYO5K
        i/Md+BZD2vEHGCZqs7Rnfv705qFNh/1Z91MNUfg/yGoGQo2LEeL5BFODSEsFvAZpoj9gCCqEurBfZ
        MTuNPfJZTJiGszihacf/Q96R2DeC/z2w75Ed3zk9DHLtperaLxMJJym4lTodP+s+CaWNVs7eGpgaX
        /EantW9teQ+OsVpY218MWTnfP/HfLmmoMYeCg4bjzqsHBgzBeb4Rtzyqi8LF3+wRsjCUn9iTggPUm
        Dafcrsz9KAodI3txulb7E+ofn/322gQDCEpmz9UGKwpQv6IcBtqCWd3+6OUAgTU6eL+57m3mlpn6W
        nG1Lgw+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jabkv-00026Y-3j; Mon, 18 May 2020 09:08:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A413F3011E8;
        Mon, 18 May 2020 11:08:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5FC402B3CDC70; Mon, 18 May 2020 11:08:14 +0200 (CEST)
Date:   Mon, 18 May 2020 11:08:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, mingo@elte.hu, irogers@google.com,
        kim.phillips@amd.com, jolsa@redhat.com
Subject: Re: [PATCH 1/3] perf/x86/rapl: move RAPL support to common x86 code
Message-ID: <20200518090814.GZ2957@hirez.programming.kicks-ass.net>
References: <20200515215733.20647-1-eranian@google.com>
 <20200515215733.20647-2-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515215733.20647-2-eranian@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 02:57:31PM -0700, Stephane Eranian wrote:
> To prepare for support of both Intel and AMD RAPL.
> Move rapl.c to arch/x86/events. Rename config option.
> Fixup header paths.
> 
> Signed-off-by: Stephane Eranian <eranian@google.com>
> ---
>  arch/x86/events/Kconfig            | 8 ++++----
>  arch/x86/events/Makefile           | 1 +
>  arch/x86/events/intel/Makefile     | 2 --
>  arch/x86/events/{intel => }/rapl.c | 9 ++++++---
>  4 files changed, 11 insertions(+), 9 deletions(-)
>  rename arch/x86/events/{intel => }/rapl.c (98%)
> 
> diff --git a/arch/x86/events/Kconfig b/arch/x86/events/Kconfig
> index 9a7a1446cb3a0..e542c32b0a55f 100644
> --- a/arch/x86/events/Kconfig
> +++ b/arch/x86/events/Kconfig
> @@ -9,12 +9,12 @@ config PERF_EVENTS_INTEL_UNCORE
>  	Include support for Intel uncore performance events. These are
>  	available on NehalemEX and more modern processors.
>  
> -config PERF_EVENTS_INTEL_RAPL
> -	tristate "Intel rapl performance events"
> -	depends on PERF_EVENTS && CPU_SUP_INTEL && PCI
> +config PERF_EVENTS_X86_RAPL

This is going to make everybody's kconfig prompt for this again. Best to
to a backwards compat thing or just leave it have Intel in the name.
