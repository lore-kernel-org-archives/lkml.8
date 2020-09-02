Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5944C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5ECE2067C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ehr15v6/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgIBRBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 13:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728788AbgIBRBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 13:01:49 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F0EC061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 10:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iwyKWeurV0U3w6yu8w0BQPdMXUK2mvLQyCEX2rbplBw=; b=Ehr15v6/C4EYcrA3Yt+djMgKo8
        A1DqcEyrGEWMtvNZyL6swSt91TzsMEdUw2aBY08qV7UOh5/mVHqR6Bxulj4TJrzrxA+NEdAb/fyyG
        FJKorVdcr9eZTX+/8HZFErOnWr4tjOPSGcyQr0Ek3NKfnD0jJtT+LRl7flnZ4aerXfxfGP/xOVYJK
        qv90z+tU3nUP3beVLBvdKE2nodw6EHmova1haW/RzSfrJGxt6sJBlUj/xynLJeuzKOlyoRlH9Sk3w
        90clDH4dckwUyPQgUSOVp6aYt43ZOjD9XszAVoF/QsXDZ6rYGb/O0aGwf1cAjlaoS0VOOQE1wd1Fg
        oVBGLzQw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDW8k-0004sZ-4Q; Wed, 02 Sep 2020 17:01:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 82575307697;
        Wed,  2 Sep 2020 19:01:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6FC732B9E8F06; Wed,  2 Sep 2020 19:01:40 +0200 (CEST)
Date:   Wed, 2 Sep 2020 19:01:40 +0200
From:   peterz@infradead.org
To:     Borislav Petkov <bp@alien8.de>
Cc:     Feng Tang <feng.tang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] tools/x86: add kcpuid tool to show raw CPU features
Message-ID: <20200902170140.GQ1362448@hirez.programming.kicks-ass.net>
References: <1598514543-90152-1-git-send-email-feng.tang@intel.com>
 <20200902164538.GN1362448@hirez.programming.kicks-ass.net>
 <20200902165501.GC21537@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902165501.GC21537@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 06:55:01PM +0200, Borislav Petkov wrote:
> On Wed, Sep 02, 2020 at 06:45:38PM +0200, peterz@infradead.org wrote:
> > We really should clear the CPUID bits when the kernel explicitly
> > disables things.
> 
> Actually, you want to *disable* the functionality behind it by clearing
> a bit in CR4 - and yes, not all features have CR4 bits - so that
> luserspace doesn't "probe" the existence of certain instructions.
> 
> Example: you can still try to run RDRAND and succeed even if the
> corresponding CPUID bit is clear.

Well yes, but as you say, we don't have that :/ Clearing it in CPUID is
the best we can do.
