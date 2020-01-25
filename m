Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B7CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 17:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B602420801
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 17:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="mwKXJKhE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgAYRyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 12:54:49 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47910 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbgAYRys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 12:54:48 -0500
Received: from zn.tnic (p200300EC2F1CE9005D0519DC199D089A.dip0.t-ipconnect.de [IPv6:2003:ec:2f1c:e900:5d05:19dc:199d:89a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 70B101EC0CD0;
        Sat, 25 Jan 2020 18:54:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579974886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8/QEBnGZzWynfauzlDvurEb7IGLRdsmpQsi9B2RTlqQ=;
        b=mwKXJKhEBXerhu5Iv/tiq5hHqE/knLsBaUoBlRwrAeQgrNZaJbvSQOAcy5ZpjgPFzCXukX
        WUwfpn7Y3zY1Q5fFVCCTMSe4gFVcIcOnBIxjyRfQFk93bV2tZLPDdvmuibHSMMx9U/vfVQ
        bSDLFGCv3NGTGZru5u1dLSARpv2Co6w=
Date:   Sat, 25 Jan 2020 18:54:42 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        x86 <x86@kernel.org>
Subject: Re: [tip: core/rcu] rcu: Enable tick for nohz_full CPUs slow to
 provide expedited QS
Message-ID: <20200125175442.GA4369@zn.tnic>
References: <157994897654.396.5667707782512768142.tip-bot2@tip-bot2>
 <20200125131425.GB16136@zn.tnic>
 <20200125161050.GE2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200125161050.GE2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2020 at 08:10:50AM -0800, Paul E. McKenney wrote:
> How big?  (Seriously, given that the fix may depend on the number of CPUs.)

[    7.660017] smp: Brought up 2 nodes, 256 CPUs

> So the problem appears to be that some of the boot-time processing
> is looping in the kernel, which is preventing the grace period from
> completing.  One could argue that such code should be fixed, but on the
> other hand, boot time is a bit special.  Later in -rcu's dev branch,
> there are commits that forgive this boot-time misbehavior, but this is
> a bit late in process to dump all of those commits into -tip.

Aha.

> The RT guys might need the warning, and it was them that I was thinking
> of when adding it. 

But "boot time is a bit special". Or do they care about deadlines during
boot too?

> But let's see what works for mainline first.  And
> since your box was booting fine without the warning before, I bet that
> it boots just fine with that warning removed.

Yes, it does.

> So could you please try out the (untested) patch below?

Warning's gone.

> If that works, I will re-introduce the warning with proper protection
> for the merge window following this coming one.

My big box is at your service if you need stuff tested later.

Thx Paul.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
