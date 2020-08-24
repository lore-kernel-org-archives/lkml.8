Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF2EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 12:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CF0B20838
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 12:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1fAtQ2n4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+rvejp7S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgHXMZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 08:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbgHXMYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 08:24:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9C5C061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 05:24:52 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598271889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=J3kOSuANczljR0oJzMVSEz4vNtkQBEm/4UZxW4w9Euw=;
        b=1fAtQ2n4yDiLzitucu4ui1UzVtZ4vm815sBCxB4sZTUtT+szYObEPI1qtxX/gDTg6ot2aN
        u5+nZ1FBV0VoNPUoQJqPuNHhpkl5gGKonx5ZS29SG1JB97c5c53165SUo6e1OGW4IupU9G
        2xzOFMYu++TETiPirg+PFf4keMJMg1LAGwKUH2hpdooxkGnyKRisE3Ql7pdoeiouZFfu6s
        +KuSUaspwcFAztI9CqW5a4HGt8nQcD1ZfqtxwwnMLn9nfq9DwIq44mg9rbd/gDpkhq9JWf
        O2703fBS+An4p8U/MJr+WvPHY28HNPtFdeMdJAn7cKADBHrgadVsnT15PIvcxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598271889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=J3kOSuANczljR0oJzMVSEz4vNtkQBEm/4UZxW4w9Euw=;
        b=+rvejp7S4z6QjE2z59+T2BBhaKwkna4Y2itxsd3pmlThQGXj6wfpx1dKZZ096ml2oshK5e
        Jma4W26YCUJV4kAA==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Pu Wen <puwen@hygon.cn>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Dirk Hohndel <dirkhh@vmware.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Gordon Tetlow <gordon@tetlows.org>,
        David Kaplan <David.Kaplan@amd.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [RFD] x86: Curing the exception and syscall trainwreck in hardware
Date:   Mon, 24 Aug 2020 14:24:48 +0200
Message-ID: <875z98jkof.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's a sad state of affairs that I have to write this mail at all and it's
nothing else than an act of desperation.

The x86 exception handling including the various ways of syscall entry/exit
are a constant source of trouble. Aside of being a functional disaster
quite some of these issues have severe security implications.

There are similar issues on the virtualization side including the handling
of essential MSRs which are required to run a guest OS and even more so
with the upcoming virt specific exceptions of various vendors.

We are asking the vendors for more than a decade to fix this situation, but
even the most trivial requests like an IRET variant which does not reenable
NMIs unconditionally and other small things which would make our life less
miserable aren't happening.

Instead of fixing the underlying design fails first and creating a solid
base the vendors add even more ill defined exception variants on top of
the existing pile. Unsurprisingly these add-ons are creating more
problems than they solve, but being based on the existing house of cards
that's obviously expected.

This really has to stop and the underlying issues have to be resolved
before more problems are inflicted upon operating systems and hypervisors.
The amount of code to workaround these issues is already by far larger than
the actual functional code. Some of these workarounds are just bandaids
which try to prevent the most obvious damage, but they are mostly based on
the hope that the unfixable corner cases never happen.

There is talk about solutions for years, but it's just talk and we have not
yet seen a coordinated effort accross the x86 vendors to come up with a
sane replacement for the x86 exception and syscall trainwreck.

The important word here is 'coordinated'. We are not at all interested
in different solutions from different vendors. It's going to be
challenging enough to maintain ONE parallel exception/syscall handling
implementation.  In other words, the kernel is going to support exactly
ONE new exception/syscall handling mechanism and not going to accomodate
every vendor.

So I call on the x86 vendors to sit together and come up with a unified
and consolidated base on which each of the vendors can build their
differentiating features.

Aside of coordination between the x86 vendors this also requires
coordination with the people who finally have to deal with that on the
software side. The prevailing hardware engineering principle "That can
be fixed in software" does not work; it never worked - especially not in
the area of x86 exception and syscall handling.

This coordination must include all major operating systems and hypervisors
whether open source or proprietary to ensure that the different
requirements are met. This kind of coordination has happened in the context
of the hardware vulnerability mitigations already in a fruitful way so
this request is not asking for something impossible.

If the x86 vendors are unable to talk to each other and coordinate on a
solution, then the ultimate backstop might be to take the first reasonable
design specification and the first reasonable silicon implementation of it
as the ONE alternative solution to the existing trainwreck. How the other
vendors are going to deal with that is none of our business. That's the
least useful and least desired outcome and will only happen when the x86
vendors are not able to get their act together and sort that out upfront.

Thanks,

	Thomas
