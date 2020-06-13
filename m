Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0201C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 09:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CD5C20739
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 09:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZQnZS0C9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgFMJj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 05:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgFMJj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 05:39:26 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF20BC03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 02:39:26 -0700 (PDT)
Received: from zn.tnic (p200300ec2f205d007935628ee6b9317f.dip0.t-ipconnect.de [IPv6:2003:ec:2f20:5d00:7935:628e:e6b9:317f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D36A91EC0328;
        Sat, 13 Jun 2020 11:39:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592041161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=li2OEgSEHpw4CWS8i4pMIpqx0g8A/AZxtVhFiy4t2MY=;
        b=ZQnZS0C9+eBjKxHikT8+zLwHpaiK7MgofMF6hgIOohlsH2eoog+2hdrlxhyI8PnkGUi1hJ
        ANa8Pi/iUnXM8ifiNI0CpqGmf2N07zKvMNike1Z1SbaxlN1wn08k6ZPpnUx6SBBg4kSvFn
        iHP61rQP9cK8P0IPy9uYTgrewnMEA38=
Date:   Sat, 13 Jun 2020 11:39:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/msr: Filter MSR writes
Message-ID: <20200613093914.GA584@zn.tnic>
References: <20200612105026.GA22660@zn.tnic>
 <CAHk-=wjKr+eAdPg3q7S6N4Cwd1aMEOHc5qLaKE-wwhouZRo=uw@mail.gmail.com>
 <20200612174801.GE22660@zn.tnic>
 <20200612203935.GH2497@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200612203935.GH2497@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 10:39:35PM +0200, Peter Zijlstra wrote:
> On Fri, Jun 12, 2020 at 07:48:01PM +0200, Borislav Petkov wrote:
> > On Fri, Jun 12, 2020 at 10:20:03AM -0700, Linus Torvalds wrote:
> > > Since you already added the filtering, this looks fairly sane.
> > > 
> > > IOW, what MSR's do we expect people to maybe write to normally? You
> > > added MSR_IA32_ENERGY_PERF_BIAS as an allowed MST, maybe there are
> > > others?
> > 
> > Right, this MSR is being written by cpupower in tools/. My search was
> > confined within the kernel source only so there very likely are others.
> 
> So that tool writing to /dev/msr has already caused pain; the direct
> result is that the intel pstate driver doesn't want to use an MSR shadow
> variable to avoid RDMSR because that'd loose input.
> 
> https://lkml.org/lkml/2019/3/25/310
> 
> (sorry, that's what google found me)
> 
> So ideally we'd just disallow it too. It already has a sysfs file (per
> those patches):
> 
>   Documentation/admin-guide/pm/intel_epb.rst

Damn, that has fallen off my radar completely and the reason for me
requesting the sysfs interface is the *same* - kill the direct MSR
access.

Rafael, how about I refresh those patches and teach cpupower to access
the sysfs interface too and we drop that MSR from the whitelist too?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
