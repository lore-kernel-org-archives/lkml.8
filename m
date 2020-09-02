Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FB8C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EAF721582
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zThraQsh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgIBRAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 13:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbgIBRAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 13:00:03 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1ACC061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 10:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1ijinwDURNcT23LgdlcDu1vqMoWk9wcCno9jomFWSjM=; b=zThraQshEWVgRCPPWW4vYT1nbm
        ymy3s/vfxvTFQJhj7glM0m7i0r3bakOZGBU/cOK3pYnt56ig+8wnMr7aTRMObuNq5EaYUDp8qp7aL
        mUFovg1J7oJuQo/VNskZ2zskwA/gtmizKP/cl8SG9n4DJuz2s5/RkiQFIUzUjYP93xhHQTXgIKA5B
        N7F2G7LrlBaYC85eAZC75NQJE8qxOAk6JiwQuZLUIkmN4+Pb8yyClRoxZn8Ka9qm5gIcJefXbUxDQ
        xVFk5UTwfxcOhKAvDf/lr+EV1baMNCnXODpfIzhdPmePIxIQdrkNhHeOHEwCmwS2S8oqDNKOTMUkr
        /va3Z9zw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDW6z-0003uO-Lq; Wed, 02 Sep 2020 16:59:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D26903056DE;
        Wed,  2 Sep 2020 18:59:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BBE4D2B997097; Wed,  2 Sep 2020 18:59:50 +0200 (CEST)
Date:   Wed, 2 Sep 2020 18:59:50 +0200
From:   peterz@infradead.org
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] tools/x86: add kcpuid tool to show raw CPU features
Message-ID: <20200902165950.GP1362448@hirez.programming.kicks-ass.net>
References: <1598514543-90152-1-git-send-email-feng.tang@intel.com>
 <20200902164538.GN1362448@hirez.programming.kicks-ass.net>
 <6afa8f68-4e88-ade1-fbe9-7cc7a0d2e42c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6afa8f68-4e88-ade1-fbe9-7cc7a0d2e42c@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 09:52:33AM -0700, Dave Hansen wrote:
> On 9/2/20 9:45 AM, peterz@infradead.org wrote:
> > On Thu, Aug 27, 2020 at 03:49:03PM +0800, Feng Tang wrote:
> >> End users frequently want to know what features their processor
> >> supports, independent of what the kernel supports.
> >>
> >> /proc/cpuinfo is great. It is omnipresent and since it is provided by
> >> the kernel it is always as up to date as the kernel. But, it can be
> >> ambiguous about processor features which can be disabled by the kernel
> >> at boot-time or compile-time.
> > 
> > Let me once again suggest we use CPUID faulting to 'fix' this.
> > 
> > We really should clear the CPUID bits when the kernel explicitly
> > disables things.
> > 
> > https://lkml.kernel.org/r/1552431636-31511-18-git-send-email-fenghua.yu@intel.com
> 
> Wouldn't we also have to turn on faulting for all the bits that are
> enumerated, but of which the kernel is unaware?
> 
> Right now, a bit that we clearcpuid= and one about which the kernel is
> totally unaware look the same.

I mostly care about the things the kernel disables (and thus knows
about), the rest is a pass-through IIRC.
