Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A181C33CB1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 17:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67E720716
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 17:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hJnxUJNV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgA0RVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 12:21:39 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:42109 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgA0RVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 12:21:38 -0500
Received: by mail-il1-f196.google.com with SMTP id x2so4428849ila.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 09:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FlVv3OiGshIByx4bdZlL96riWYmzI3zF0LMlVGex22I=;
        b=hJnxUJNVX5ujJFbvBapdFCAEPbl+jm/DXbMzBPzjb1o5n3mHiupGbT11C+eTMrk/eb
         aIaF/wk5AEY5Gy6TQOgc0YHh39SYb3mqFxK9xAEyoCVMJ3tm4yl/OgCF54m7tg379ad8
         +EThVtfC4feIY2LUh2aTTCP+tMXfZe4bEpZjbi7zZDTc6S3mk3g00zF2JMnZW0XJIK7I
         DkV2rFDwhCKCdlX7DKJMgAMifhHjJR6YXNNGI/0vvuF8nc/lFKZu7Eh3uLW0ao+lETWW
         dNHxipd1PAaPeR1Mb5Zrt+22E9dcyC3udphRNJTQNJ92svPoEjN1g0E9jNCHgusMtRvk
         xj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FlVv3OiGshIByx4bdZlL96riWYmzI3zF0LMlVGex22I=;
        b=cT/55wnIqEZThhpKiyTKK+TFbHbbtI0Sk0wW+L3ZUH3llA7CCahjNUCyFdT8ujvPL7
         v8rLH2qfqieIrWMLQJ1KBpSpBv1iV5fDnmsHZMaA89svydbvTliZa+pyEDNs3K1DaaSz
         sPVxiKb7BAYC+pmomx1rIxj6FqpdJpW6T16G/sIQzqb8sXmbmwhNgoutDclOBdPDXpSo
         Ef/un63E2b0uT7zP5my8rDrwO/PEe1hP3hgflQf/IcZw2KPntrPMQfE7S8ABPKS+qmlj
         zbWcOUKwzlG6mOD4h//lfIvWvS0RXqArsGuga4wwTPdHfTier/dn4NNo6zSLvuA6r/XW
         vnOw==
X-Gm-Message-State: APjAAAW4OJ7yf+0qkKn5iSOSbuAFOWh4Bo7AAcel0flQ0xRmNZI8aXbt
        958rb15UwjKXnDYVDfRix5ZIue2uE46EQXG1yrCVyw==
X-Google-Smtp-Source: APXvYqyLTGq5aOlxrG7MkaZqmL6uBRSlRlJwQsi2obu0iJ2cN7wGMd3Jj1iPrdrlgmXvYTf5rfI6vBhi5oLzEXMHUS4=
X-Received: by 2002:a92:d642:: with SMTP id x2mr15910283ilp.169.1580145697386;
 Mon, 27 Jan 2020 09:21:37 -0800 (PST)
MIME-Version: 1.0
References: <20191226220205.128664-1-semenzato@google.com> <20191226220205.128664-2-semenzato@google.com>
 <20200106125352.GB9198@dhcp22.suse.cz> <CAA25o9S7EzQ0xcoxuWtYr2dd0WB4KSQNP4OxPb2gAeaz0EgomA@mail.gmail.com>
 <20200108114952.GR32178@dhcp22.suse.cz> <CAA25o9Q4XP8weCNcTr1ZT9N7Y3V=B90mK8mykLOyy=-4RJ_uHQ@mail.gmail.com>
 <20200127141637.GL1183@dhcp22.suse.cz> <CAA25o9QuA_9EoivWo-DuJsWoHCdBm2wio3G8JYxuTfQErT42kg@mail.gmail.com>
 <CAJZ5v0iDtk+WWHV8F2C+9EdeMSx_JKYDEiarProoE55kiBOjkg@mail.gmail.com>
In-Reply-To: <CAJZ5v0iDtk+WWHV8F2C+9EdeMSx_JKYDEiarProoE55kiBOjkg@mail.gmail.com>
From:   Luigi Semenzato <semenzato@google.com>
Date:   Mon, 27 Jan 2020 09:21:25 -0800
Message-ID: <CAA25o9RHKerPJNW6h5d6W48q1qA3wYJAmhOBU3XiBHwMcEChhA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Documentation: clarify limitations of hibernation
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geoff Pike <gpike@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 8:28 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Jan 27, 2020 at 5:13 PM Luigi Semenzato <semenzato@google.com> wrote:
> >
> > On Mon, Jan 27, 2020 at 6:16 AM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Fri 24-01-20 08:37:12, Luigi Semenzato wrote:
> > > [...]
> > > > The purpose of my documentation patch was to make it clearer that
> > > > hibernation may fail in situations in which suspend-to-RAM works; for
> > > > instance, when there is no swap, and anonymous pages are over 50% of
> > > > total RAM.  I will send a new version of the patch which hopefully
> > > > makes this clearer.
> > >
> > > I was under impression that s2disk is pretty much impossible without any
> > > swap.
> >
> > I am not sure what you mean by "swap" here.  S2disk needs a swap
> > partition for storing the image, but that partition is not used for
> > regular swap.
>
> That's not correct.
>
> The swap partition (or file) used by s2disk needs to be made active
> before it can use it and the mm subsystem is also able to use it for
> regular swap then.

OK---I had this wrong, thanks.

> >  If there is no swap, but more than 50% of RAM is free
> > or reclaimable, s2disk works fine.  If anonymous is more than 50%,
> > hibernation can still work, but swap needs to be set up (in addition
> > to the space for the hibernation image).  The setup is not obvious and
> > I don't think that the documentation is clear on this.
>
> Well, the entire contents of RAM must be preserved, this way or
> another, during hibernation.  That should be totally obvious to anyone
> using it really.

Yes, that's obvious.

> Some of the RAM contents is copies of data already there in the
> filesystems on persistent storage and that does not need to be saved
> again.  Everything else must be saved and s2disk (and Linux
> hibernation in general) uses active swap space to save these things.
> This implies that in order to hibernate the system, you generally need
> the amount of swap space equal to the size of RAM minus the size of
> files mapped into memory.
>
> So, to be on the safe side, the total amount of swap space to be used
> for hibernation needs to match the size of RAM (even though
> realistically it may be smaller than that in the majority of cases).

This all makes sense, but we do this:

-- add resume=/dev/sdc to the command line
-- attach a disk (/dev/sdc) with size equal to RAM
-- mkswap /dev/sdc
-- swapon /dev/sdc
-- echo disk > /sys/power/state

and the last operation fails with ENOMEM.  Are we doing something
wrong?  Are we hitting some other mm bug?

Thanks!
