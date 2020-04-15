Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B48C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 00:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5870E2076C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 00:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=juliacomputing-com.20150623.gappssmtp.com header.i=@juliacomputing-com.20150623.gappssmtp.com header.b="1geKCk2x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392285AbgDOAKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 20:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732131AbgDOAKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 20:10:31 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F96C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 17:10:31 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id h6so15169663iok.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 17:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dFBaMSovQJzB88jkZ9fusFFAPOOqMYaL0ASiy358ufU=;
        b=1geKCk2xtvrxpSzWjIiKaVf0A9V3gjSV/iT5m5QMrbXWPYaCPlOFgY+DkLeKZUP7zW
         4sPTW5+CusZGi07n9LGiM7tXPF4b9RWdal4ALduN6BnZqw0OjJDmxtkqOiXoue7iwrav
         t4FGlibAI7cvHhRZgfx33Xd9YiI0E2iJ/qB2Sf9CQ4WuMkyf7mCCnXlsDXTfEqZKjNFE
         EmxcMD/kaAmlkmmhcS1BUPpQlpaEqCTHxkk7f/Be91M3MvgB1SDcdQ9+f2JyFVfoHBH2
         Lp92WG3japHQ2XDLihjBHCxVhLrbk/EOH9bM6a2ataJZkkhH2puLo2L5MqbqxnyFZ+lt
         rCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dFBaMSovQJzB88jkZ9fusFFAPOOqMYaL0ASiy358ufU=;
        b=ceNyignkTD2ogO3VKi/9RbuL2mIZMbq3lfzPL3smbRKTyA6RQkL8yxjJBXfppQBAA8
         T2nx3T8uqhOpfvoidCk89Dq8LutYvBMrmtLrz+el4oFTlUa5qoW6WHSngywVfJTjWUDQ
         Yhd7FE615lChgiMIMQ6X1uaq4EJxe+FXvSjuHhTzvQKVrClSL+vBC3CcWYbx1S3BWTkn
         rykQSyMO7oXoDvEBpq8DLzZa4aJbderfJg7+9qUaSdnhDZ6+EPj72sNsTMNqPYPoDcbP
         FttgHlmhlWZra9ZkzHUtpygUd1OiLpB20UiPtpQgXvJjGhnQGasUFmRLD82CtX4r6f8Z
         peHg==
X-Gm-Message-State: AGi0PuZG+BtuQ35+RdQoMrpN9kK/8ZKuiV9t7QLVZJKJgwZ1EX4UC/8e
        7GLe3N1ZD0TXD7nceMbY7kFBicX8880wZP/XMbR4jg==
X-Google-Smtp-Source: APiQypJLuqZLCYnv86tOK9eRrHvm5zqZcn4/9NaEAUsY3oQJUOu/JC7RwEzFxq4pp/HfM/UtAqrBubzS1W6dUB9x804=
X-Received: by 2002:a05:6638:2a2:: with SMTP id d2mr14667935jaq.104.1586909430574;
 Tue, 14 Apr 2020 17:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <a5b07aa9-96ea-a9b5-13db-e5dcbd7760e6@intel.com>
 <BEA3CCB8-5127-4E6A-9696-E293C00BFA82@amacapital.net> <CABV8kRxqcCmPKtX3DDOf+47Re1hO1gMeUPhCd6HtDP0-SpcSBw@mail.gmail.com>
 <CALCETrVmsWZ+w6C4RV50DWoL0Qaiy+S6BtXr=QKQEg3MYgAc6w@mail.gmail.com>
In-Reply-To: <CALCETrVmsWZ+w6C4RV50DWoL0Qaiy+S6BtXr=QKQEg3MYgAc6w@mail.gmail.com>
From:   Keno Fischer <keno@juliacomputing.com>
Date:   Tue, 14 Apr 2020 20:09:53 -0400
Message-ID: <CABV8kRxfMNxzy8r2P4GKj-22i+GMj=VDfPWAZB-VSgfrsQsjCA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] x86/arch_prctl: Add ARCH_SET_XCR0 to set XCR0 per-thread
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        Kyle Huey <khuey@kylehuey.com>,
        "Robert O'Callahan" <robert@ocallahan.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> (why would you want to record with an unusual XCR0?)

I was indeed primarily thinking about the replay case when I
originally wrote this patch, but the reason for that is that the machine
that I tend to replay on is fairly new, so the traces we get tend
to be compatible. I have encountered the opposite situation also
where I wanted to send somebody a trace for them to debug, but
their machine didn't support AVX512, so I wanted to disable it.
A while ago we also encountered a similar situation where
PKRU became available on AWS so we couldn't
replay traces from there anymore.
We do of course have CPUID faulting here (which well-behaved
userspace software tends to respect), but the differing return
value from xgetbv messed up the recording nonetheless. In
order to actually make that work, masking those bits out from
XCR0 would have been required. I'm also thinking about the
future where there may be more diversity in XCR0 user state
components and what chips support what.

I assume the objection here will be that we can have our users
reboot with a different kernel command line, which is true enough
and what I will recommend to people for the time being. That said,
part of the appeal for users of rr is that it doesn't require privilege,
so it works in locked down environments like HPC clusters where
users can't easily change the kernel parameters (even KVM can
be an ask here - but is in my experience easier to negotiate with
the sysadmins).

> and replay would use KVM.

Yes, there is still a bit of state management left (e.g. we currently
rely on the kernel for mmap, fork/clone semantics and signal
delivery for deterministic signals) - though of course emulating
all that is much easier than the record side.

> I'm not sure about diversions.

Diversions (terminology note for those not familiar with record
and replay systems - a diversion is a replay that gets turned
back into a real process for the purpose of investigating the
state - think invoking a printing function from the debugger)
are similar to record in that they do handle syscalls (e.g.
for open/read/write for printing, mmap if the process allocates
during a diversion, etc.). We do have more performance
leeway for diversions than we do for records, so we might
be okay without getting too deep into KVM hacking.

I think my overall take-away is that KVM is probably feasible
for replay and diversions, but would require large patches
to KVM to be feasible for record. Unfortunately, that's
also the opposite of where getting a patch like this
into the mainline kernel would be most useful for us.
We do tend to have control over the replay machines,
so if we need to carry a patch like this, it's feasible (as
indeed we have been for the past two years), though
of course we'd like to enable this also for people who
don't want to build their own kernel (as well as for people
for whom that assumption doesn't hold - the assertion that
we control the replay machine is probably quite selfish in
how we in particular use this technology).

Hope that helps,
Keno
