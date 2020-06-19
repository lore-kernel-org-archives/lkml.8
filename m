Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE17C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD1322158C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cdcVINB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388996AbgFSTcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388960AbgFSTcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:32:17 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96932C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 12:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3QzKeVygR1Og2gnr7c4ILqWHyNCSEx2U2v1kqCy0+HM=; b=cdcVINB6e402t8tTeuprfHRaQx
        ieoW0tyn4qvbs/UOQIJpBelH9jI/VNXpf0Bi0UvKn1KXtAGPCzxY9UI0lWkxgpbDc4+NSrbz9FLMF
        4ZGfllz0WvM0/+kpgpMvKqujaR93bAtTEeDnhB51l6nGgf7z/1w0J8HRjFNmKuwxRWM62V+iMoYkX
        y7U2YLgokqBmpTVDCMSDPaJIOiL+DywMvCwiUVqJoIb+XH+xrcZcbiwMvN3r+XKYwb7KcI2jvD3IK
        NlEOrfKhUgiz/0elInanFdO+bGPiOVGux3+MMeGiwgwnLdClIKtuMPUxZ3l+Yw9jCFVYJBUC5c5L5
        QCsgVycQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmMjm-0005kh-BI; Fri, 19 Jun 2020 19:31:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3ECC1302753;
        Fri, 19 Jun 2020 21:31:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2BE7A2C28ECDD; Fri, 19 Jun 2020 21:31:40 +0200 (CEST)
Date:   Fri, 19 Jun 2020 21:31:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, acme@kernel.org, tglx@linutronix.de,
        bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, dave.hansen@intel.com,
        yu-cheng.yu@intel.com, bigeasy@linutronix.de, gorcunov@gmail.com,
        hpa@zytor.com, alexey.budankov@linux.intel.com, eranian@google.com,
        ak@linux.intel.com, like.xu@linux.intel.com,
        yao.jin@linux.intel.com
Subject: Re: [PATCH 17/21] x86/fpu: Use proper mask to replace full
 instruction mask
Message-ID: <20200619193140.GI576888@hirez.programming.kicks-ass.net>
References: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
 <1592575449-64278-18-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592575449-64278-18-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 07:04:05AM -0700, kan.liang@linux.intel.com wrote:

> KVM includes the header file fpu/internal.h. To avoid 'undefined
> xfeatures_mask_all' compiling issue, xfeatures_mask_all has to be
> exported.

> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index 587e03f..eb2e44e 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -58,6 +58,7 @@ static short xsave_cpuid_features[] __initdata = {
>   * XSAVE buffer, both supervisor and user xstates.
>   */
>  u64 xfeatures_mask_all __read_mostly;
> +EXPORT_SYMBOL_GPL(xfeatures_mask_all);

*groan*...

AFAICT KVM doesn't actually use any of those functions, can't we have
something like BUILD_KVM (like BUILD_VDSO) and exclude those functions
from the KVM build?

I so detest exporting random crap because kvm..
