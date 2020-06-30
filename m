Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51726C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 219FE20675
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fnXoA7TF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389180AbgF3O5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 10:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389173AbgF3O5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 10:57:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831C9C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 07:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r4wqCm59salpNzf8euha6lnmXeqxLrfcxHvL38kgN8U=; b=fnXoA7TFcj83tUlvU5PiaUUfdb
        yFNxQ0S/e5/FcBqt+Ie9d1msMUoe2bUp1qG2mezQ/lvUaNrotGTPUaLe3ehY0MS+7pgKp2LnsutVm
        5SbxRBoT8OF8pud+9xoAeA5HcGMjtohSzYZjOJ7NAFYbV/+iO9nQ1FCETJ1VgXdR14NZT80qKo/M3
        NoYNHdcQHqhILhseIf6uoJMke2DOpeTQOKyMtBh/As0n+VO3eUPSYkoc6/gr1I8+VEJoE6p5nz6I5
        kh/9r1ZDe3lRTsnRKs9E8kK3LYPOiQbPfvOqy0ssRtFb2rVsIrv8cepX7do/X4lKa0UcKIu1ujrRZ
        zbNxEFMw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqHhL-0004wR-Ke; Tue, 30 Jun 2020 14:57:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0033A30015A;
        Tue, 30 Jun 2020 16:57:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2E22320CF3986; Tue, 30 Jun 2020 16:57:21 +0200 (CEST)
Date:   Tue, 30 Jun 2020 16:57:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, acme@kernel.org, tglx@linutronix.de,
        bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, dave.hansen@intel.com,
        yu-cheng.yu@intel.com, bigeasy@linutronix.de, gorcunov@gmail.com,
        hpa@zytor.com, alexey.budankov@linux.intel.com, eranian@google.com,
        ak@linux.intel.com, like.xu@linux.intel.com,
        yao.jin@linux.intel.com, wei.w.wang@intel.com
Subject: Re: [PATCH V2 09/23] perf/x86/intel: Check Arch LBR MSRs
Message-ID: <20200630145721.GR4781@hirez.programming.kicks-ass.net>
References: <1593195620-116988-1-git-send-email-kan.liang@linux.intel.com>
 <1593195620-116988-10-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593195620-116988-10-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 11:20:06AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The KVM may not support the MSRs of Architecture LBR. Accessing the
> MSRs may cause #GP and crash the guest.
> 
> The MSRs have to be checked at guest boot time.
> 
> Only using the max number of Architecture LBR depth to check the
> MSR_ARCH_LBR_DEPTH should be good enough. The max number can be
> calculated by 8 * the position of the last set bit of LBR_DEPTH value
> in CPUID enumeration.

But But But, this is architectural, it's in CPUID. If KVM lies to us, it
gets to keep the pices.

This was different when it was not enumerated and all we had was poking
the MSRs, but here KVM can simply mask the CPUID bits if it doesn't
support the MSRs.

If KVM gives us the CPUID bits, we should let it crash and burn if it
then doesn't provide the MSRs.
