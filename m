Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB4DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 04:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26B7A2072E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 04:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="jsYSBHtl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgFDEk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 00:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgFDEk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 00:40:27 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82071C05BD43
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 21:40:27 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id p5so4531964wrw.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 21:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EcbDwjC6e+J4fqPVguK3ypyyOSloNImurJbFqg0dw7Y=;
        b=jsYSBHtll7SWI36OzbelpQca2Fwg2E/XU+PWy9Mk5O/1kAqQqdSk5rRP/aQwFk0Gut
         e76hK14wijPjAfpC0veKK88jYnMXw+P336ymGxWut+82FdaYsMr+m2jRvCYWLJclvWSw
         hTCMsza2t7ZwtyJviXOd+04tY28QYdP2ufwMCAeifxEhi4K4YSaWwsDFoKovQCAe4LZc
         oslbAIyli2XkXM9u4LrABghP4rW0knYW0bYV05kTnhnCOGkZaIAiR+Zv9S0lCq9Ddmxv
         VbTWY9ByWv/DPPjB5HpvVax56mqs31EjMLBtpD/r995pdOlrkXRv1biTaJqKDy2rFkY+
         01tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EcbDwjC6e+J4fqPVguK3ypyyOSloNImurJbFqg0dw7Y=;
        b=bhXhYL3EhitnW0wIo7C6VB/C+UFZzp5OjUZfPYf+f6ISytytB/rDh6DR4tgYDVuAxk
         lJFawW7cSsZbD5jG1ZnIyGClBfHegpCahpypXS0eJJ4tC1LneqOiP7F5vRf79ptRHHPC
         OZDm7LYZn+H4kZHXQ6oW3x+MIsPZgDz18CEahyjHyva9wfU8geckkx/DQ8CbsgApCzW2
         cuqlBm2OwRrHsJzc7+LqFzX5b2OZe6009oRtr8gW9+dA3licgJw/sdjkiDnXczaplmJJ
         xJ1dhDII6m+bwMEb2LjmPBfAsxG85dSFlgKdVYdCHb18lFjy5cuLsYtehSdEurToTaCs
         zSew==
X-Gm-Message-State: AOAM533RVQnV6ph175QNZrLjednNdzDIVpLETMvG6we5W9k/jPdRKIVd
        CB4FrbU3wtbEHqfqU9Ln2fqcrmzAwiAiSB3X1N84Hg==
X-Google-Smtp-Source: ABdhPJyD1yJ5RtVxkPkI5FqClCwtGcA7KuOhlP2UxgGHBusV4DH7adOegnbN7Qe/BWKOzH4pUVdHbusgpI3iGZ9fhXA=
X-Received: by 2002:adf:e387:: with SMTP id e7mr2470525wrm.70.1591245625299;
 Wed, 03 Jun 2020 21:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200602184212.10813-1-bshanks@codeweavers.com> <20200604001243.GA24742@ranerica-svr.sc.intel.com>
In-Reply-To: <20200604001243.GA24742@ranerica-svr.sc.intel.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 3 Jun 2020 21:39:59 -0700
Message-ID: <CALCETrXrvNZQUqfjF+-=jh1TMBpdB0PT-8J5wWDO83+i3B5Q1w@mail.gmail.com>
Subject: Re: [PATCH] x86/umip: Add emulation/spoofing for SLDT and STR instructions
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Brendan Shanks <bshanks@codeweavers.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andreas Rammhold <andi@notmuch.email>,
        "Moger, Babu" <Babu.Moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 3, 2020 at 5:12 PM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> On Tue, Jun 02, 2020 at 11:42:12AM -0700, Brendan Shanks wrote:
> > Add emulation/spoofing of SLDT and STR for both 32- and 64-bit
> > processes.
> >
> > Wine users have found a small number of Windows apps using SLDT that
> > were crashing when run on UMIP-enabled systems.
> >
> > Reported-by: Andreas Rammhold <andi@notmuch.email>
> > Originally-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > Signed-off-by: Brendan Shanks <bshanks@codeweavers.com>
> > ---
> >  arch/x86/kernel/umip.c | 23 ++++++++++++++---------
> >  1 file changed, 14 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
> > index 8d5cbe1bbb3b..59dfceac5cc0 100644
> > --- a/arch/x86/kernel/umip.c
> > +++ b/arch/x86/kernel/umip.c
> > @@ -64,6 +64,8 @@
> >  #define UMIP_DUMMY_GDT_BASE 0xfffffffffffe0000ULL
> >  #define UMIP_DUMMY_IDT_BASE 0xffffffffffff0000ULL
> >
> > +#define UMIP_DUMMY_TASK_REGISTER_SELECTOR 0x40
> > +
> >  /*
> >   * The SGDT and SIDT instructions store the contents of the global descriptor
> >   * table and interrupt table registers, respectively. The destination is a
> > @@ -244,16 +246,24 @@ static int emulate_umip_insn(struct insn *insn, int umip_inst,
> >               *data_size += UMIP_GDT_IDT_LIMIT_SIZE;
> >               memcpy(data, &dummy_limit, UMIP_GDT_IDT_LIMIT_SIZE);
> >
> > -     } else if (umip_inst == UMIP_INST_SMSW) {
> > -             unsigned long dummy_value = CR0_STATE;
> > +     } else if (umip_inst == UMIP_INST_SMSW || umip_inst == UMIP_INST_SLDT ||
> > +                umip_inst == UMIP_INST_STR) {
> > +             unsigned long dummy_value;
> > +
> > +             if (umip_inst == UMIP_INST_SMSW)
> > +                     dummy_value = CR0_STATE;
> > +             else if (umip_inst == UMIP_INST_STR)
> > +                     dummy_value = UMIP_DUMMY_TASK_REGISTER_SELECTOR;
> > +             else
> > +                     dummy_value = 0;
>
> Perhaps you can return a non-zero value for SLDT if it has an LDT, as
> Andy had suggested. Maybe this can be implemented by looking at
> current->mm->context.ldt
>
> I guess the non-zero value can be (GDT_ENTRY_LDT*8).

You could probably even get away with always returning a nonzero
value.  After all, an empty LDT is quite similar to no LDT.

--Andy
