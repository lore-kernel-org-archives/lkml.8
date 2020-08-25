Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A471EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 17:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E9BA20782
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 17:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598377323;
	bh=kYKBKWPdmIGbowfnANRtKnPRq86WNOXztM21yJfgy/8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mGGXK0pfxXLsJacGEyB8zOe2CAh70yDsbnB0d+mQu9kQQVWoWBHx/cl3q/UqSdtt1
	 FOYtUxi72v3G/X2IYu3eqWe20ai8EGD0L6IctT76quB2yryQ5wx1DsFKo2KSa3Oeun
	 x6/bJIJZkjkEoJ+Zs5mfg//cQvVOuG19M6bUgRoE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgHYRmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 13:42:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbgHYRmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 13:42:00 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E81CB2087C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 17:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598377320;
        bh=kYKBKWPdmIGbowfnANRtKnPRq86WNOXztM21yJfgy/8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Oij2eI5JkXzLlsBn/eF7PnI3rfkUCoAgdebAy7NdWTrmhYYqTFRf/LrRywr7qP4c6
         sZshwlstASSBuHHm/09pXiY0y/BT2PCOzWU63a40UUb7V8tfNu+zdZZm49K5mqEvO5
         l9iJq7Dc9WrOBnGnRTjeERTJxrPl3crUYiGmA5uQ=
Received: by mail-wm1-f45.google.com with SMTP id x5so3380970wmi.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 10:41:59 -0700 (PDT)
X-Gm-Message-State: AOAM530bbOIwr7plu1u3WaWC11W/1TDnS2/aStWF5hgqqYTQpy8GGbGa
        ueJmE101c1GC5YUSzirO+d2Nc+/o9uRiDQEVKJeCKw==
X-Google-Smtp-Source: ABdhPJzfBFAV7N2kTP8Aaatm/dxdRuETsg1NbmfZjmQIwU7edH4V2JOF6K2tvjsYlUsZLF5qFw+Xzl0W4w9yIEaSX58=
X-Received: by 2002:a1c:7e02:: with SMTP id z2mr3108351wmc.138.1598377318393;
 Tue, 25 Aug 2020 10:41:58 -0700 (PDT)
MIME-Version: 1.0
References: <875z98jkof.fsf@nanos.tec.linutronix.de> <3babf003-6854-e50a-34ca-c87ce4169c77@citrix.com>
 <20200825043959.GF15046@sjchrist-ice> <CALCETrUP1T2k3UzZMsXMfAD83xbYEG+nAv3a-LeBjNW+=ijJAg@mail.gmail.com>
 <20200825171903.GA20660@sjchrist-ice> <CALCETrWy2x-RByfknjjKxRbE0LBPk2Ugj1d58xYHb91ogbfnvA@mail.gmail.com>
 <dfce335fefe043868301bacf57120759@intel.com>
In-Reply-To: <dfce335fefe043868301bacf57120759@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 25 Aug 2020 10:41:46 -0700
X-Gmail-Original-Message-ID: <CALCETrWw4Jr2iqpPdH-YoAT7oUUNbyWsm2P2+ghYsQ=R8bc9Ew@mail.gmail.com>
Message-ID: <CALCETrWw4Jr2iqpPdH-YoAT7oUUNbyWsm2P2+ghYsQ=R8bc9Ew@mail.gmail.com>
Subject: Re: TDX #VE in SYSCALL gap (was: [RFD] x86: Curing the exception and
 syscall trainwreck in hardware)
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
        "Mallick, Asit K" <asit.k.mallick@intel.com>,
        Gordon Tetlow <gordon@tetlows.org>,
        David Kaplan <David.Kaplan@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 10:36 AM Luck, Tony <tony.luck@intel.com> wrote:
>
> > > Or malicious hypervisor action, and that's a problem.
> > >
> > > Suppose the hypervisor remaps a GPA used in the SYSCALL gap (e.g. the
> > > actual SYSCALL text or the first memory it accesses -- I don't have a
> > > TDX spec so I don't know the details).
>
> Is it feasible to defend against a malicious (or buggy) hypervisor?
>
> Obviously, we can't leave holes that guests can exploit. But the hypervisor
> can crash the system no matter how clever TDX is.

Crashing the system is one thing.  Corrupting the system in a way that
could allow code execution is another thing entirely.  And the whole
point of TDX is to defend the guest against the hypervisor.
