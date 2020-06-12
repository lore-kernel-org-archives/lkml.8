Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFD2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 17:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA9F1207ED
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 17:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="aNrTtBaI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgFLRwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 13:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgFLRwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 13:52:55 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80861C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 10:52:54 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0af40048a70bbbe71adfd0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:f400:48a7:bbb:e71a:dfd0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 64B6E1EC01B7;
        Fri, 12 Jun 2020 19:52:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1591984371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kG6EUCeSj6POYagjaW4AM51ET/bvqa7j1f4YuWkH9TU=;
        b=aNrTtBaI8u0TmoVNJs+mzmra4hfeUaZqJIRMOVqa8ELSJC3uDFlSROrYPiPxwjVmEjBZk/
        ccD3ZROHnKBW7hyPSv1+tWmZ8IhLTm8e6w/a0Jg7Ta3VhU9p1Rt/PNcHKj4uj2ZoKufmBG
        NBvdarm7WpxirdaXVP9uWyLoV/Ll+EY=
Date:   Fri, 12 Jun 2020 19:52:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     x86-ml <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/msr: Filter MSR writes
Message-ID: <20200612175251.GF22660@zn.tnic>
References: <20200612105026.GA22660@zn.tnic>
 <20200612163406.GA1026@linux.intel.com>
 <20200612164602.GC22660@zn.tnic>
 <20200612165709.GB1026@linux.intel.com>
 <20200612170303.GD22660@zn.tnic>
 <20200612174307.GD1026@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200612174307.GD1026@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 10:43:07AM -0700, Sean Christopherson wrote:
> The problem is a fault on WRMSR doesn't mean the MSR doesn't exist, it only
> means WRMSR faulted.  WRMSR can for all intents and purpose trigger completely
> arbitrary microcode flows, e.g. WRMSR 0x79 can fundamentally change the
> behavior of the CPU.

Yes, that case is in the commit message.

> And it's not like the WRMSR->taint is atomic, e.g. changing a platform scoped
> MSR that affects voltage settings or something of that nature could easily
> tank the system on a successful WRMSR before the kernel can be marked tainted.

Yes, yes, I'll taint before the WRMSR.

> 0400 only allows a privelged user to read the parameter, e.g. for parameters
> that are snapshotted at module load time and/or changing the param while the
> module is running would cause breakage.
> 
> 0600 allows a priveleged user to read and write the parameter, which AFAICT
> is safe here.

Ok, we can do that.

> 0644 allows a priveleged user to read and write the parameter, and allows an
> unpriveleged user to read the param.

Not so sure about that. Why would the unprivileged user need to read it?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
