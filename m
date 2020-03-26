Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC30DC2D0E8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81AA02073E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585263868;
	bh=6pcjGJJSGR1d/J2j5J8p6DT7L5qF5IgIjSvQ+yDaIIg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yYI2inKS4U6BhUWrIW7rcgERsdUWcmlT2gKd49MK5Yrakcq8uaO9H+Ub/A+iTLlMN
	 XIwS8s8xcpp16fDelJWFh00CG/J0XyR1Z6dx+EnvW867hkE5cPQ164tAWAFkoK8GiH
	 dg0s677ibvR3+SmDaeqHrSSx7G5C6ucHuPgu2wrI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbgCZXE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 19:04:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbgCZXE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 19:04:27 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76A7220857
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 23:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585263865;
        bh=6pcjGJJSGR1d/J2j5J8p6DT7L5qF5IgIjSvQ+yDaIIg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oEYLp2wdyBbzCEfC/0Fe4pQu7k1S9tcKac7S3Jr4BINVZMcUNi0nnNz4j93y5CSzp
         HoEJDghg/oSGbv0f8vURN/zNYQfFwxTDH70w4hpQkZ81oDA524/MgyGhp576+c9HbB
         spBvzLkZc9Y5uGibJNZ1BFfOwW9e/RZC4TMa/Qi8=
Received: by mail-wm1-f47.google.com with SMTP id c81so9404241wmd.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 16:04:25 -0700 (PDT)
X-Gm-Message-State: ANhLgQ2PRqxuv0+ppHV31K+pMUl8gydbJB/a7QlLnaI4++xjANuVAXg4
        InXSPWI82Y5u4Z6zfHLUtSP22/UdR9YHSulvROBWwA==
X-Google-Smtp-Source: ADFU+vtG2sWH24WDFYuyH/5yO8CzSYhb3pg/Bgj5KTnzXUZz/cnHDYZva20h/3f7IzXlq/AkWwYwg+x3EAoZkNxNAts=
X-Received: by 2002:a1c:f407:: with SMTP id z7mr2236114wma.36.1585263863761;
 Thu, 26 Mar 2020 16:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <CACdnJusd7m-c0zLmAjSq9Sb9HxyCkhyyp5W=4FMdysgu7_g=Sw@mail.gmail.com>
 <BB670F86-9362-4A8C-8BE6-64A5AF9537A7@amacapital.net> <CACdnJus6H3LQww8hkTMpPKN7u_sb1PXmgPwQOCSVZR_fi7GMrA@mail.gmail.com>
 <CALCETrU4W7q=QyTX_iq_kN4nVK58WoOD0F_NBt7z8p7xiE7hfA@mail.gmail.com> <CACdnJuu9sqzUWjPJRPOY6pKDJxTqwwf6NQEWQewXtufPQHikOg@mail.gmail.com>
In-Reply-To: <CACdnJuu9sqzUWjPJRPOY6pKDJxTqwwf6NQEWQewXtufPQHikOg@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 26 Mar 2020 16:04:12 -0700
X-Gmail-Original-Message-ID: <CALCETrVwqtpwBigzHJU7so=q0rJ2tUfxGKCJE7oY2RJA156wHg@mail.gmail.com>
Message-ID: <CALCETrVwqtpwBigzHJU7so=q0rJ2tUfxGKCJE7oY2RJA156wHg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/12] x86: Trenchboot secure late launch Linux kernel support
To:     Matthew Garrett <mjg59@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Ross Philipson <ross.philipson@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "Daniel P. Smith" <dpsmith@apertussolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        trenchboot-devel@googlegroups.com,
        Ard Biesheuvel <ardb@kernel.org>, leif@nuviainc.com,
        eric.snowberg@oracle.com, piotr.krol@3mdeb.com,
        krystian.hebel@3mdeb.com, michal.zygowski@3mdeb.com,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 4:00 PM Matthew Garrett <mjg59@google.com> wrote:
>
> On Thu, Mar 26, 2020 at 3:52 PM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Thu, Mar 26, 2020 at 2:28 PM Matthew Garrett <mjg59@google.com> wrote:
> > > https://trustedcomputinggroup.org/wp-content/uploads/TCG_PlatformResetAttackMitigationSpecification_1.10_published.pdf
> > > - you want to protect in-memory secrets from a physically present
> > > attacker hitting the reset button, booting something else and just
> > > dumping RAM. This is avoided by setting a variable at boot time (in
> > > the boot stub), and then clearing it on reboot once the secrets have
> > > been cleared from RAM. If the variable isn't cleared, the firmware
> > > overwrites all RAM contents before booting anything else.
> >
> > I admit my information is rather dated, but I'm pretty sure that at
> > least some and possibly all TXT implementations solve this more
> > directly.  In particular, as I understand it, when you TXT-launch
> > anything, a nonvolatile flag in the chipset is set.  On reboot, the
> > chipset will not allow access to memory *at all* until an
> > authenticated code module wipes memory and clears that flag.
>
> Mm, yes, this one might be something we can just ignore in the TXT case.
>
> > > When you say "re-launch", you mean perform a second secure launch? I
> > > think that would work, as long as we could reconstruct an identical
> > > state to ensure that the PCR17 values matched - and that seems like a
> > > hard problem.
> >
> > Exactly.  I would hope that performing a second secure launch would
> > reproduce the same post-launch PCRs as the first launch.  If the
> > kernel were wise enough to record all PCR extensions, it could replay
> > them.
>
> That presumably depends on how much state is in the measured region -
> we can't just measure the code in order to assert that we're secure.
>
> > In any case, I'm kind of with Daniel here.  We survived for quite a
> > long time without EFI variables at all.  The ability to write them is
> > nice, and we certainly need some way, however awkward, to write them
> > on rare occasions, but I don't think we really need painless runtime
> > writes to EFI variables.
>
> I'm fine with a solution that involves jumping through some hoops, but
> it feels like simply supporting measuring and passing through the
> runtime services would be fine - if you want to keep them outside the
> TCB, build a kernel that doesn't have EFI runtime service support and
> skip that measurement?

I'm certainly fine with the kernel allowing a mode like this.  At the
end of the day, anyone building something based on secure launch
should know what they're doing.

On the other hand, unless I've missed something, we need to support a
transition from "secure" measured mode to unmeasured and back if we're
going to support secure launch and S3 at the same time. But maybe S3
is on its way out in favor of suspend-to-idle?
