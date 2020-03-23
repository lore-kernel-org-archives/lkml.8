Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAEDC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 22:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1082073E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 22:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOQyT2Hh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgCWWi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 18:38:27 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46126 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgCWWi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 18:38:26 -0400
Received: by mail-ot1-f66.google.com with SMTP id 111so15180394oth.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 15:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gu80lHMEhTHjncO4g/gq1vFZP4xk7NOR08ZBWiLNNKo=;
        b=jOQyT2HhWKETiqswng1tiRgCPcdF9YcWLzhqPU986HJUtdHE/mL6THRWTt/v4I6pHG
         P603qVCd0pOoV+ZC7BgJaydSndeJC1obn8+MBb+SVYNnzSYr2GZ7aR5h3FYfIRa6xHhc
         RYxRmdPMc4aVFu1QlxHyJpvctdV5fzrDU/DAdqNsDkbIhzodW5GhHPeUnV1jnl9uUKao
         Vf1a6InlSlaPA0mrHfR9EpJunh382SD1wOcqsxpfJ2mOtw9lkxGNOui2F6VN9tatq6vU
         sbR2ZqhSyy6BKVDoKNlZ40iGML0/6st7dKw9+lkq3hoeAnr9Pif4JvpvjibCq++9EZc8
         YWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gu80lHMEhTHjncO4g/gq1vFZP4xk7NOR08ZBWiLNNKo=;
        b=NG6Rfd3XXPKZVyaJRMYHcm3wfk/ZSLwHdUueA83+QfvjTBSj2gOVxJG8+KrTitcsG1
         wrzbYqwDdDkpYAGnx9e8ky8aQN/aCQFvESwB+C4qH3WacsqvP91HxGMiiX7furGst8bn
         ODR+ky/mDmzwIrClXR4QLESUwOjjCiol9+Jc8jUvPeiHvi5x4RyDNoPnJymwLm1KQNR4
         Nu9BZzljR8yRFO6Ob6Pw/fOCB4cYVpZdCc9id7Q7AVccFehpP+vxa/brnW8DoweU7dKS
         iUnCoaNtiiKjTFvWAKy/vZZ6FYmo9Z+atS5OMbiI+gjdlGpIOKme/rVnYHn0py7vpfih
         MSIA==
X-Gm-Message-State: ANhLgQ1KJQoCT/dqoCc3KFp1ohi7n7P7nsxTSYhwVA/v1MejIF7xeb6T
        Hn7Aa3W9Og7KlC8Ic/Ty5XHhRpF+Sn0fUFKiR3s=
X-Google-Smtp-Source: ADFU+vs6gYNhEuSaOtN3tbOtrPOFhNGCoZyD6ZzgKMo7ZKhWCTQ32v4pwuhGPfKBssy2QAI2ZOx3kjGVmfwlI3kk3mk=
X-Received: by 2002:a9d:412:: with SMTP id 18mr19172704otc.134.1585003106203;
 Mon, 23 Mar 2020 15:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAP6exY+LnUXaOVRZUXmi2wajCPZoJVMFFAwbCzN3YywWyhi8ZA@mail.gmail.com>
 <D31718CF-1755-4846-8043-6E62D57E4937@zytor.com> <CAP6exYJHgqsNq84DCjgNP=nOjp1Aud9J5JAiEZMXe=+dtm-QGA@mail.gmail.com>
 <8E80838A-7A3F-4600-AF58-923EDA3DE91D@zytor.com> <CACdnJusmAHJYauKvHEXNZKaUWPqZoabB_pSn5WokSy_gOnRtTw@mail.gmail.com>
 <A814A71D-0450-4724-885B-859BCD2B7CBD@zytor.com> <CAP6exYJdCzG5EOPB9uaWz+uG-KKt+j7aJMGMfqqD3vthco_Y_g@mail.gmail.com>
 <CF1457CD-0BE2-4806-9703-E99146218BEC@zytor.com> <CAP6exYJj5n8tLibwnAPA554ax9gjUFvyMntCx4OYULUOknWQ0g@mail.gmail.com>
 <C2B3BE61-665A-47FD-87E0-BDB5C30CEFF4@zytor.com> <CAP6exY+avh0G3nuqbxJj2ZgKkRdvwGTKeWyazqXJHbp+X-2u+A@mail.gmail.com>
In-Reply-To: <CAP6exY+avh0G3nuqbxJj2ZgKkRdvwGTKeWyazqXJHbp+X-2u+A@mail.gmail.com>
From:   ron minnich <rminnich@gmail.com>
Date:   Mon, 23 Mar 2020 15:38:15 -0700
Message-ID: <CAP6exYLEg+iu4Hs0+vdk0b6rgB5ZT7ZTvuhe--biCg9dGbNCTQ@mail.gmail.com>
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

nvm, it's only mentioned as a parameter for bootloaders.

Testing this change now.

On Mon, Mar 23, 2020 at 3:29 PM ron minnich <rminnich@gmail.com> wrote:
>
> sounds good, I'm inclined to want to mention only initrdmem= in
> Documentation? or just say initrd is discouraged or deprecated?
>
> On Mon, Mar 23, 2020 at 2:41 PM <hpa@zytor.com> wrote:
> >
> > On March 23, 2020 12:40:15 PM PDT, ron minnich <rminnich@gmail.com> wrote:
> > >I'm wondering -- adding initrdmem= is easy, do you think we'll ever be
> > >able to end uses of initrd= in the ARM and MIPS world? Is it ok to
> > >have these two identical command line parameters? I'm guessing just
> > >changing initrd= would be hard.
> > >
> > >Do we just accept initrd= from this day forward, as well as initrdmem=?
> > >
> > >On Mon, Mar 23, 2020 at 12:06 PM <hpa@zytor.com> wrote:
> > >>
> > >> On March 23, 2020 11:54:28 AM PDT, ron minnich <rminnich@gmail.com>
> > >wrote:
> > >> >On Mon, Mar 23, 2020 at 11:19 AM <hpa@zytor.com> wrote:
> > >> >> Pointing to any number of memory chunks via setup_data works and
> > >> >doesn't need to be exposed to the user, but I guess the above is
> > >> >reasonable.
> > >> >
> > >> >so, good to go?
> > >> >
> > >> >>
> > >> >> *However*, I would also suggest adding "initrdmem=" across
> > >> >architectures that doesn't have the ambiguity.
> > >> >
> > >> >agreed. I can look at doing that next.
> > >> >
> > >> >ron
> > >>
> > >> I would prefer if we could put both into the same patchset.
> > >> --
> > >> Sent from my Android device with K-9 Mail. Please excuse my brevity.
> >
> > Yes, accept both.
> > --
> > Sent from my Android device with K-9 Mail. Please excuse my brevity.
