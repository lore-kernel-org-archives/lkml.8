Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747D8C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 19:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5065820782
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 19:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g1XjYt4T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2g3lJNGu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgHYTtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 15:49:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51978 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgHYTtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 15:49:09 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598384947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nx2guUxaBEVRMrKDYjrAwhgM23aIhrP6oY6kMfLb3ZY=;
        b=g1XjYt4TEhfIY6zrAYI2vv7JWz6a8/qZG+rhV5sdrhKQwt5rS3GTPX98RLngamtPG9Z0Y3
        ntvwf0MVpAvbdcNSDVleHqSaE4p5MlEYpYwvz7nk29+5U2TCyOKncN04dwSr0OWPdIgPJG
        A0QSLZ0sA0h+HgZx/mQgRmO6I4yG2sHs1lsqMr3E/5CqXK42C+h/ARaLPPjp2MWk1QlXyk
        v8uEnyfhYM2ViD4JqdUrsapwJA+hp33e9/oG1extMtwpcl8QfTKvS1iv25lguijo5REdDp
        E/ZBLpZDhpgjaK4SpEzZRinrpGEDdfHgzczMI7oVnvGJo4BWezDtXkkgGUrtOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598384947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nx2guUxaBEVRMrKDYjrAwhgM23aIhrP6oY6kMfLb3ZY=;
        b=2g3lJNGuoxX9O8r/+8OdIEIqhjw+1a9reAJCb6GL7K9VJOf6bRa85U3T6T4Bopph0LPMC4
        HIa0NGsb+LXwOSCA==
To:     "Luck\, Tony" <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Christopherson\, Sean J" <sean.j.christopherson@intel.com>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Pu Wen <puwen@hygon.cn>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Dirk Hohndel <dirkhh@vmware.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        "Mallick\, Asit K" <asit.k.mallick@intel.com>,
        Gordon Tetlow <gordon@tetlows.org>,
        David Kaplan <David.Kaplan@amd.com>
Subject: RE: TDX #VE in SYSCALL gap (was: [RFD] x86: Curing the exception and syscall trainwreck in hardware)
In-Reply-To: <dfce335fefe043868301bacf57120759@intel.com>
References: <875z98jkof.fsf@nanos.tec.linutronix.de> <3babf003-6854-e50a-34ca-c87ce4169c77@citrix.com> <20200825043959.GF15046@sjchrist-ice> <CALCETrUP1T2k3UzZMsXMfAD83xbYEG+nAv3a-LeBjNW+=ijJAg@mail.gmail.com> <20200825171903.GA20660@sjchrist-ice> <CALCETrWy2x-RByfknjjKxRbE0LBPk2Ugj1d58xYHb91ogbfnvA@mail.gmail.com> <dfce335fefe043868301bacf57120759@intel.com>
Date:   Tue, 25 Aug 2020 21:49:07 +0200
Message-ID: <87ft8ay098.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25 2020 at 17:35, Tony Luck wrote:
>> > Or malicious hypervisor action, and that's a problem.
>> >
>> > Suppose the hypervisor remaps a GPA used in the SYSCALL gap (e.g. the
>> > actual SYSCALL text or the first memory it accesses -- I don't have a
>> > TDX spec so I don't know the details).
>
> Is it feasible to defend against a malicious (or buggy) hypervisor?
>
> Obviously, we can't leave holes that guests can exploit. But the hypervisor
> can crash the system no matter how clever TDX is.

If it crashes and burns reliably then fine, but is that guaranteed?

I have serious doubts about that given the history and fragility of all
of this and I really have zero interest in dealing with the fallout a
year from now.

Thanks,

        tglx
