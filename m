Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8213C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D73E207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o0p4+Jbo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgIBQp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgIBQp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:45:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D9AC061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 09:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KlqdMA9Ymkva2L993Ie06kUO8p+MwX4KAMlWqqYhqi8=; b=o0p4+JboOuQwfd5Df12KScy2MD
        +nAvnnMkAe7FA7Y6DGSqL2pqAcDunGGH0vyvdJMESv+TYPEQUcLpYi9pO7iC82L/HhNOBgZJnBogf
        D4xCnI/s6vCIJIL4E3m9v7fieRWrBZB46AEHKUjINYiVTkkLxy+pAmjfXkjoUcdGX7E4vXDc6KOR8
        Iki3Jgkn3ubyGcSqf/z1tMYDqtCJJT7NZWo5oM4h8A6q6eGcykHo6QoFUOEHTsPPRGVQhYy19IeE1
        BPrH8OXTmi0MUa1o7a/HwOP5+lmGcEcjt2QKj3sJAF9nvxbgibgvumc7ax8LFzzSq3zzIIRhcvCrG
        wZClltzQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDVtF-0008J6-RQ; Wed, 02 Sep 2020 16:45:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 89AC03011C6;
        Wed,  2 Sep 2020 18:45:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 73B662C580820; Wed,  2 Sep 2020 18:45:38 +0200 (CEST)
Date:   Wed, 2 Sep 2020 18:45:38 +0200
From:   peterz@infradead.org
To:     Feng Tang <feng.tang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] tools/x86: add kcpuid tool to show raw CPU features
Message-ID: <20200902164538.GN1362448@hirez.programming.kicks-ass.net>
References: <1598514543-90152-1-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598514543-90152-1-git-send-email-feng.tang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 03:49:03PM +0800, Feng Tang wrote:
> End users frequently want to know what features their processor
> supports, independent of what the kernel supports.
> 
> /proc/cpuinfo is great. It is omnipresent and since it is provided by
> the kernel it is always as up to date as the kernel. But, it can be
> ambiguous about processor features which can be disabled by the kernel
> at boot-time or compile-time.

Let me once again suggest we use CPUID faulting to 'fix' this.

We really should clear the CPUID bits when the kernel explicitly
disables things.

https://lkml.kernel.org/r/1552431636-31511-18-git-send-email-fenghua.yu@intel.com
