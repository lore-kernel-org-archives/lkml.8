Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2054C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 22:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3332073E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 22:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2wAilem"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgCWWaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 18:30:08 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43196 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbgCWWaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 18:30:08 -0400
Received: by mail-ot1-f68.google.com with SMTP id a6so15133213otb.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 15:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7xuwzah1KpHJkLOz91jhq3KDmKBMU3J3yEWXM0zKiSs=;
        b=f2wAilemv2cepdIyhj1pRHqKZ9gz4f0c8rTr95DJ2EbN6783nKoPivA+UhFTRhWs/Q
         UyeF9SpMxD/AKq2cbiVEkyZQo/f7XweUUoC6CfeB1cu9eQlaMotiuYa/v7qBFgvHYDe1
         2HGowobmGf/YJVt4UoEzpssIKC0dW3G39f1AJCne4g+ToelKwc3+Eq+s8gBCQEXZdo+6
         Mc7bWTy+Swvg42CBTXqAL71rfVBsGuk4nuDYbJ24JChW6Yr4mt7ZCczKxei/VgFOn2T0
         ilpcIXKKQv9FqGY+Mflm4uImAwshVHjz0ueTdBwlqPKMAHXWWbG16KaWesT4BojGVlsK
         9gog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7xuwzah1KpHJkLOz91jhq3KDmKBMU3J3yEWXM0zKiSs=;
        b=cv5FPtMm27CIqsAvWvDofH+ucjNJs5snWK4CZ0Rw7xI8XJAN0TBWn64ifgFTL6nYRu
         BH7yNv5MRnFJx2DmkB4akBgjY0JYKYQnh/EV7YcjSN5nBQAEphf4L74u7RDqEdtnySPz
         BF136eVIrTyLlGvUJas66bvzM4sdHXSsqh5MOJK2Tb1960Yj27qupdeLizeHBoZ00I2+
         z3T2RL/sJ1lvYIW97aDh46g73fCU78OzEz4+hoUKpq8WfCoCSgHuz2SBLed3IPKs+cLM
         BI9XvVF1dLziszrtJajiV9/10xIm+TrLudPiMrA9M7R4wjeLyc/gSWpHyDZmt5BsM7Ox
         PwFA==
X-Gm-Message-State: ANhLgQ3KxQ+TsHnNQWUJASGj60Ym+QmkWiRnRxknlT5e2p5WXDiOxErX
        lrA/NGhBsgjp3dtyqnm+JCvhbh260rq2vtvilds=
X-Google-Smtp-Source: ADFU+vuf25mRLd64B4sl2VQO4n8bJb3x5zZQ9fqszN43KI/quzaDFPTOJrflaOKgbOvBWr82hNuh7hRIXcVzivFpJtk=
X-Received: by 2002:a9d:5906:: with SMTP id t6mr1511452oth.338.1585002606961;
 Mon, 23 Mar 2020 15:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAP6exY+LnUXaOVRZUXmi2wajCPZoJVMFFAwbCzN3YywWyhi8ZA@mail.gmail.com>
 <D31718CF-1755-4846-8043-6E62D57E4937@zytor.com> <CAP6exYJHgqsNq84DCjgNP=nOjp1Aud9J5JAiEZMXe=+dtm-QGA@mail.gmail.com>
 <8E80838A-7A3F-4600-AF58-923EDA3DE91D@zytor.com> <CACdnJusmAHJYauKvHEXNZKaUWPqZoabB_pSn5WokSy_gOnRtTw@mail.gmail.com>
 <A814A71D-0450-4724-885B-859BCD2B7CBD@zytor.com> <CAP6exYJdCzG5EOPB9uaWz+uG-KKt+j7aJMGMfqqD3vthco_Y_g@mail.gmail.com>
 <CF1457CD-0BE2-4806-9703-E99146218BEC@zytor.com> <CAP6exYJj5n8tLibwnAPA554ax9gjUFvyMntCx4OYULUOknWQ0g@mail.gmail.com>
 <C2B3BE61-665A-47FD-87E0-BDB5C30CEFF4@zytor.com>
In-Reply-To: <C2B3BE61-665A-47FD-87E0-BDB5C30CEFF4@zytor.com>
From:   ron minnich <rminnich@gmail.com>
Date:   Mon, 23 Mar 2020 15:29:55 -0700
Message-ID: <CAP6exY+avh0G3nuqbxJj2ZgKkRdvwGTKeWyazqXJHbp+X-2u+A@mail.gmail.com>
Subject: Re: [PATCH 1/1] x86 support for the initrd= command line option
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Matthew Garrett <mjg59@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sounds good, I'm inclined to want to mention only initrdmem= in
Documentation? or just say initrd is discouraged or deprecated?

On Mon, Mar 23, 2020 at 2:41 PM <hpa@zytor.com> wrote:
>
> On March 23, 2020 12:40:15 PM PDT, ron minnich <rminnich@gmail.com> wrote:
> >I'm wondering -- adding initrdmem= is easy, do you think we'll ever be
> >able to end uses of initrd= in the ARM and MIPS world? Is it ok to
> >have these two identical command line parameters? I'm guessing just
> >changing initrd= would be hard.
> >
> >Do we just accept initrd= from this day forward, as well as initrdmem=?
> >
> >On Mon, Mar 23, 2020 at 12:06 PM <hpa@zytor.com> wrote:
> >>
> >> On March 23, 2020 11:54:28 AM PDT, ron minnich <rminnich@gmail.com>
> >wrote:
> >> >On Mon, Mar 23, 2020 at 11:19 AM <hpa@zytor.com> wrote:
> >> >> Pointing to any number of memory chunks via setup_data works and
> >> >doesn't need to be exposed to the user, but I guess the above is
> >> >reasonable.
> >> >
> >> >so, good to go?
> >> >
> >> >>
> >> >> *However*, I would also suggest adding "initrdmem=" across
> >> >architectures that doesn't have the ambiguity.
> >> >
> >> >agreed. I can look at doing that next.
> >> >
> >> >ron
> >>
> >> I would prefer if we could put both into the same patchset.
> >> --
> >> Sent from my Android device with K-9 Mail. Please excuse my brevity.
>
> Yes, accept both.
> --
> Sent from my Android device with K-9 Mail. Please excuse my brevity.
