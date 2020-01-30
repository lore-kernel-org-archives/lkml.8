Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91E6C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ACE520674
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580417414;
	bh=9kXbhBG4xuaQybl4w4IYdEWhkzjKdd9T6d14cLwB5Tk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=V5kEioZ4GzEUcwfeDJ7ovQSMk8h4zjdiDs6OVZ9uNlf02Dm76/aPZHTUZxVcUSN9f
	 ZW2a9tndCl/K0lhqEIbk8Fo3Iw+f/Jtch4puUURUPIj4dCAjBrOJT6jQ5p8X5tNwuc
	 hPHv/OUUL+E+laflUyH0RrYK/Tiq3hL4ma8g2/XI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbgA3UuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:50:13 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43564 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgA3UuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 15:50:13 -0500
Received: by mail-oi1-f193.google.com with SMTP id p125so5005654oif.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 12:50:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z08RuybXoEe11iM07MN6xxLwPZjJpKeFz19KOn5eV6I=;
        b=musdL956l+CiGUH2vRsps4EGEPAfb32bciHotBEVhgWfTDf2PeminbXsWWTkNxeLW3
         jfyj2hmhGmwL8kuZmyPuUedr867ixK5xWjLz1AAapbc/Hcy0XhBT5d241U7wnpTmoVuQ
         vevgx/VDB6ncSDggy7LZUsMJpcGcNo9K4gG9E3hBWc1H7k9FAnD1J9WObs/7TC0ox+6x
         Bt3d94fyYCqWsE9uyJKR8NxglnrMcglJU+kFrz/s59pA+onHYgWwHyCoTgv5HpGMjdcr
         dfp+Rp7O/4m/mkyrMNRozsy8uR1DNFgADDDFFIpT8bfsreafcVE4d0pYJi8dQ7QNAulV
         Q+yg==
X-Gm-Message-State: APjAAAWuQjPhNVYWMLsayzT6KIuRML1Bul6Gwd5V+DbGUQLsPbyopk7S
        mUk+oLr/cgbFjJJTyxdFzFFqd0Heag0ArjokstyLxQ==
X-Google-Smtp-Source: APXvYqxhvR32zpaQQHSAuKUvzAmU5Z/UEzC5dQVq3xkECvKrwDvLK4GU/XaYkAjmz0/3jkCxe0yvMUuLrDpz/HXAcCE=
X-Received: by 2002:aca:d6c8:: with SMTP id n191mr4314332oig.103.1580417412327;
 Thu, 30 Jan 2020 12:50:12 -0800 (PST)
MIME-Version: 1.0
References: <20191226220205.128664-1-semenzato@google.com> <20191226220205.128664-2-semenzato@google.com>
 <20200106125352.GB9198@dhcp22.suse.cz> <CAA25o9S7EzQ0xcoxuWtYr2dd0WB4KSQNP4OxPb2gAeaz0EgomA@mail.gmail.com>
 <20200108114952.GR32178@dhcp22.suse.cz> <CAA25o9Q4XP8weCNcTr1ZT9N7Y3V=B90mK8mykLOyy=-4RJ_uHQ@mail.gmail.com>
 <20200127141637.GL1183@dhcp22.suse.cz> <CAA25o9QuA_9EoivWo-DuJsWoHCdBm2wio3G8JYxuTfQErT42kg@mail.gmail.com>
 <CAJZ5v0iDtk+WWHV8F2C+9EdeMSx_JKYDEiarProoE55kiBOjkg@mail.gmail.com> <CAA25o9RHKerPJNW6h5d6W48q1qA3wYJAmhOBU3XiBHwMcEChhA@mail.gmail.com>
In-Reply-To: <CAA25o9RHKerPJNW6h5d6W48q1qA3wYJAmhOBU3XiBHwMcEChhA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Jan 2020 21:50:00 +0100
Message-ID: <CAJZ5v0jiZMtv8s7AQBz212=aEm75hniJr9jXsMma8YxhRYZFJw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Documentation: clarify limitations of hibernation
To:     Luigi Semenzato <semenzato@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geoff Pike <gpike@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 6:21 PM Luigi Semenzato <semenzato@google.com> wrote:
>
> On Mon, Jan 27, 2020 at 8:28 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Mon, Jan 27, 2020 at 5:13 PM Luigi Semenzato <semenzato@google.com> wrote:
> > >
> > > On Mon, Jan 27, 2020 at 6:16 AM Michal Hocko <mhocko@kernel.org> wrote:
> > > >
> > > > On Fri 24-01-20 08:37:12, Luigi Semenzato wrote:
> > > > [...]
> > > > > The purpose of my documentation patch was to make it clearer that
> > > > > hibernation may fail in situations in which suspend-to-RAM works; for
> > > > > instance, when there is no swap, and anonymous pages are over 50% of
> > > > > total RAM.  I will send a new version of the patch which hopefully
> > > > > makes this clearer.
> > > >
> > > > I was under impression that s2disk is pretty much impossible without any
> > > > swap.
> > >
> > > I am not sure what you mean by "swap" here.  S2disk needs a swap
> > > partition for storing the image, but that partition is not used for
> > > regular swap.
> >
> > That's not correct.
> >
> > The swap partition (or file) used by s2disk needs to be made active
> > before it can use it and the mm subsystem is also able to use it for
> > regular swap then.
>
> OK---I had this wrong, thanks.
>
> > >  If there is no swap, but more than 50% of RAM is free
> > > or reclaimable, s2disk works fine.  If anonymous is more than 50%,
> > > hibernation can still work, but swap needs to be set up (in addition
> > > to the space for the hibernation image).  The setup is not obvious and
> > > I don't think that the documentation is clear on this.
> >
> > Well, the entire contents of RAM must be preserved, this way or
> > another, during hibernation.  That should be totally obvious to anyone
> > using it really.
>
> Yes, that's obvious.
>
> > Some of the RAM contents is copies of data already there in the
> > filesystems on persistent storage and that does not need to be saved
> > again.  Everything else must be saved and s2disk (and Linux
> > hibernation in general) uses active swap space to save these things.
> > This implies that in order to hibernate the system, you generally need
> > the amount of swap space equal to the size of RAM minus the size of
> > files mapped into memory.
> >
> > So, to be on the safe side, the total amount of swap space to be used
> > for hibernation needs to match the size of RAM (even though
> > realistically it may be smaller than that in the majority of cases).
>
> This all makes sense, but we do this:
>
> -- add resume=/dev/sdc to the command line
> -- attach a disk (/dev/sdc) with size equal to RAM
> -- mkswap /dev/sdc
> -- swapon /dev/sdc
> -- echo disk > /sys/power/state
>
> and the last operation fails with ENOMEM.  Are we doing something
> wrong?  Are we hitting some other mm bug?

I would expect this to work, so the fact that it doesn't work for you
indicates a bug somewhere or at least an assumption that doesn't hold.

Can you please remind me what you do to trigger the unexpected behavior?
