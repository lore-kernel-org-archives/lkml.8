Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67025C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F5D92223C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587138742;
	bh=/J+nb8RRN8uQr4miJ5pXtTRPZ6bHsl9bOvRY95IOH8k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CIAPj7HUVtyhqpYINgyUL34TcojDkm4+vgE4Bu2e7zgeNvjPup9McoFoaKKmkiFwz
	 ZOsMMDOI5zCD7Z02f6Oe7iNwQVKDcbTMV6uMmWVICKzRxS1wS42UTHlndxUYg6gdsL
	 Kh5p8P/fbMapcVfSxn6+nyOlEbVQ5XCJKI5u+ues=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbgDQPwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 11:52:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:59230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbgDQPwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 11:52:20 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ED9D22243
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 15:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587138739;
        bh=/J+nb8RRN8uQr4miJ5pXtTRPZ6bHsl9bOvRY95IOH8k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=M1euMgXIjdbZtfUU9lO3yb/qDhVdNTU6nouCORvCQAtvZlhG4qWJ6Dcg7tgsA9rUb
         r0QC8zGC+IsVeohCgk1u8LSk3UMt/B+e/KL7jHoh8JSXqAvYtxBqUcew5ye/OIae2e
         VASO1gWCMbCO/9dSMt1qItYRsgY9vW3c2yLitLJE=
Received: by mail-wm1-f53.google.com with SMTP id g12so3516816wmh.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 08:52:19 -0700 (PDT)
X-Gm-Message-State: AGi0PuY6FrhPqkR8iQZvPJvqklF1b4gIYoOYqlXL+6/LqQ2xsgXEbMqD
        Bf8RvqpxF8lQRErAK+otl3UbHHzVP0olwyK2QLtRbw==
X-Google-Smtp-Source: APiQypLCvELdaDlJqkIR/8eax17Nwlr8T1cTj2ui8OQWpnHtRM6m1duxXveAVEFXfhycA/bWdK6RP7+3XgHquHb1m3s=
X-Received: by 2002:a1c:4186:: with SMTP id o128mr3987095wma.21.1587138737993;
 Fri, 17 Apr 2020 08:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <1570212969-21888-1-git-send-email-chang.seok.bae@intel.com>
 <alpine.DEB.2.21.1911151926380.28787@nanos.tec.linutronix.de>
 <20191115191200.GD22747@tassilo.jf.intel.com> <A78C989F6D9628469189715575E55B236B50834A@IRSMSX104.ger.corp.intel.com>
 <CALCETrXc=-k3fQyxjBok0npjTMr6-Ho7+pkvzDUdG=b52Qz=9g@mail.gmail.com>
 <A78C989F6D9628469189715575E55B236B508C1A@IRSMSX104.ger.corp.intel.com>
 <CALCETrWb9jvwOPuupet4n5=JytbS-x37bnn=THniv_d8cNvf_Q@mail.gmail.com>
 <29FD6626-4347-4B79-A027-52E44C7FDE55@intel.com> <20200413200336.GA11216@sasha-vm>
 <20200414003205.GF397326@tassilo.jf.intel.com> <20200417133021.GT1068@sasha-vm>
In-Reply-To: <20200417133021.GT1068@sasha-vm>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 17 Apr 2020 08:52:06 -0700
X-Gmail-Original-Message-ID: <CALCETrW6LLmFR5Y6tmH=nPThCHefysf_nNwxHOFp4tAY4Spunw@mail.gmail.com>
Message-ID: <CALCETrW6LLmFR5Y6tmH=nPThCHefysf_nNwxHOFp4tAY4Spunw@mail.gmail.com>
Subject: Re: [PATCH v9 00/17] Enable FSGSBASE instructions
To:     Sasha Levin <sashal@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Pedro Alves <palves@redhat.com>,
        Simon Marchi <simark@simark.ca>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tip-On Fri, Apr 17, 2020 at 6:30 AM Sasha Levin <sashal@kernel.org> wrote:
>
> On Mon, Apr 13, 2020 at 05:32:05PM -0700, Andi Kleen wrote:
> >> Is my attempt at understanding the current situation correct?
> >
> >Yes.
> >
> >Nothing breaks, and it's a nice improvement for context switch
> >performance, in NMI/PMU performance, and also gives user space two free
> >registers to play around with.
>
> Thomas, Andy,
>
> Could you list your outstanding objections to this patchset? I know it
> might be rehashing stuff you've already mentioned in this thread but I
> think that there's a disconnect between folks and it'll help with
> restarting everything.
>

My outstanding objections are:

1. The previous submission was broken.  This should obviously be fixed.

2. The issues documented here need to be addressed:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=56f2ab41b652251f336a0f471b1033afeaedd161

3. Adding FSGSBASE fundamentally changes the user ABI, and the changes
will be observable.  This means that something could break, especially
in the case where ptrace is in use and the tracee uses the new
instructions.  The old behavior cannot sanely be preserved with
FSGSBASE enabled.  This isn't a showstopper, but whoever resubmits
this thing needs to document what changes and what use cases might
break.  I'm hopeful that the only thing that will break is actual
human beings using a tool like gdb to manually poke at the registers.
This is fine -- the behavior of the registers is different and human
beings debugging need to be aware of this.  But the existing automated
stuff that gdb, lldb, etc do needs to continue working.  This
especially includes using gdb to force the tracee to call a function,
e.g. 'p function()'.

4. The exising ptrace API does not provide a sane way to ask what the
base value associated with a selector would be.  This means that,
under the natural way to make FSGSBASE and ptrace work together (e.g.
as implemented in the previous submission), the tracer has no good way
to emulate 'MOV [whatever], %gs' in the tracee.

Now maybe no one cares about #4.  I certainly have the impression that
the *gdb developers* don't care.  But gdb isn't exactly a good example
of a piece of software that tries to work correctly when dealing with
unusual software.  Maybe other things like rr will care more.  It
might be nice to avoid a situation where a piece of careful software
(like rr?) can support kernel 5.y, but breaks in 5.y+1 because of
FSGSBASE, and only starts working again in 5.y+3 because we added the
ptrace API that's needed.

So maybe the first version should have a PTRACE_LOAD_SEGMENT that
sticks a selector in FS or GS and changes the base accordingly, even
if no current userspace has spoken up and said they need it.  And a
selftest.

--Andy
