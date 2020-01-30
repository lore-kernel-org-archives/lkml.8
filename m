Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89A0C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 21:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A314A214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 21:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H0LSjrQU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbgA3Vg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 16:36:29 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:42910 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbgA3Vg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 16:36:28 -0500
Received: by mail-il1-f193.google.com with SMTP id x2so4365228ila.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 13:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kmgy5YTSkXUKRp9/UQMqxu8UXHwptRgFx1MTR1gZUIM=;
        b=H0LSjrQU/4CzttjbWryHXy45XnpaVRoca6QGkYwwS64Ww91BP+5cIftV5PIATABtiJ
         25w1rzjalnFZgC242KYn+YVVHiwLIk4ycXfivd63b8+m+6tBGzj2Y1FDNepPeJEEVKZZ
         VBnp+gr9Fk0AQr75uC0hGa+fic10OQsJ+raS+5ZeH/RfHJYbbhTIPGshk11F43/Gq1xU
         SuzolbF0/1FY8rvMaKM4apstLBLStfHWk4MkC9eQRsNku68N1LezXh2ymjhD9YVzqGWj
         JFmtsUpF9oJciDSpiazzrXacDIgzwWdPe0+VBk3BSF3unEhnh/jFHUs8VfnZwPRzcOGI
         AByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kmgy5YTSkXUKRp9/UQMqxu8UXHwptRgFx1MTR1gZUIM=;
        b=rrCcxa0SDjOOe53ZKvaDFNqxFFD9ZwwueMkoHHqhihe/1yYfhyZ0yA1efxF8OfJGtS
         q5OQj2ETN6+wQM3eS/cVJIeTWy2i4ZIZJB1MqSERBImqcyTJQHCW23YbYn5a9gbMdxbj
         qkqeii3qz3aYNVrcg+c2HBZqcSielYeUuhO8LW0U/LQCbk/rBGSFO47Ak4V3x3EC3X0b
         JBXYghR8sQLkoX1UltPvxiKH6C625vsHT5I6Qq6ttZ5ce9GZ/wKeDTvy+WWg3saeoaO+
         ntkpd03lAhlzQKO52cGsCoOcHmYTfY/cQxZrWPBa8Z9uWOBFPONnREXYaUjsU2seRTgM
         nXNA==
X-Gm-Message-State: APjAAAUWkLGJGh52lFmiu0q2uYnIP07HDZyoPyjugC6yNZDYngRsR9VG
        Kv5lTgRdWyeErsouEZ3yd2AlFfGm2GybO9OARo3wUw==
X-Google-Smtp-Source: APXvYqyu1fWItrJTm3ohjsVH59mPGsRMemdS97sOlb4Svz/AGOO15vK5GcJ5xpQ3UXwHFEJIufsZnYjkaDUJ7W2Jqmo=
X-Received: by 2002:a92:d642:: with SMTP id x2mr6410444ilp.169.1580420186925;
 Thu, 30 Jan 2020 13:36:26 -0800 (PST)
MIME-Version: 1.0
References: <20191226220205.128664-1-semenzato@google.com> <20191226220205.128664-2-semenzato@google.com>
 <20200106125352.GB9198@dhcp22.suse.cz> <CAA25o9S7EzQ0xcoxuWtYr2dd0WB4KSQNP4OxPb2gAeaz0EgomA@mail.gmail.com>
 <20200108114952.GR32178@dhcp22.suse.cz> <CAA25o9Q4XP8weCNcTr1ZT9N7Y3V=B90mK8mykLOyy=-4RJ_uHQ@mail.gmail.com>
 <20200127141637.GL1183@dhcp22.suse.cz> <CAA25o9QuA_9EoivWo-DuJsWoHCdBm2wio3G8JYxuTfQErT42kg@mail.gmail.com>
 <CAJZ5v0iDtk+WWHV8F2C+9EdeMSx_JKYDEiarProoE55kiBOjkg@mail.gmail.com>
 <CAA25o9RHKerPJNW6h5d6W48q1qA3wYJAmhOBU3XiBHwMcEChhA@mail.gmail.com>
 <CAJZ5v0jiZMtv8s7AQBz212=aEm75hniJr9jXsMma8YxhRYZFJw@mail.gmail.com>
 <CAA25o9R26U6RKvSAL9ckz+d-hH+5aZ0ufQPqiefn4dOhSiDS0w@mail.gmail.com> <CAJZ5v0i=v_+n1yVdmO7L1FYpe=3WQHM03NQqHNfTCTKG5MVtNQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0i=v_+n1yVdmO7L1FYpe=3WQHM03NQqHNfTCTKG5MVtNQ@mail.gmail.com>
From:   Luigi Semenzato <semenzato@google.com>
Date:   Thu, 30 Jan 2020 13:36:15 -0800
Message-ID: <CAA25o9RSWPX8L3s=r6A+4oSdQyvGfWZ1bhKfGvSo5nN-X58HQA@mail.gmail.com>
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

On Thu, Jan 30, 2020 at 1:29 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Jan 30, 2020 at 10:11 PM Luigi Semenzato <semenzato@google.com> wrote:
> >
> > On Thu, Jan 30, 2020 at 12:50 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Mon, Jan 27, 2020 at 6:21 PM Luigi Semenzato <semenzato@google.com> wrote:
> > > >
> > > > On Mon, Jan 27, 2020 at 8:28 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > >
> > > > > On Mon, Jan 27, 2020 at 5:13 PM Luigi Semenzato <semenzato@google.com> wrote:
> > > > > >
> > > > > > On Mon, Jan 27, 2020 at 6:16 AM Michal Hocko <mhocko@kernel.org> wrote:
> > > > > > >
> > > > > > > On Fri 24-01-20 08:37:12, Luigi Semenzato wrote:
> > > > > > > [...]
> > > > > > > > The purpose of my documentation patch was to make it clearer that
> > > > > > > > hibernation may fail in situations in which suspend-to-RAM works; for
> > > > > > > > instance, when there is no swap, and anonymous pages are over 50% of
> > > > > > > > total RAM.  I will send a new version of the patch which hopefully
> > > > > > > > makes this clearer.
> > > > > > >
> > > > > > > I was under impression that s2disk is pretty much impossible without any
> > > > > > > swap.
> > > > > >
> > > > > > I am not sure what you mean by "swap" here.  S2disk needs a swap
> > > > > > partition for storing the image, but that partition is not used for
> > > > > > regular swap.
> > > > >
> > > > > That's not correct.
> > > > >
> > > > > The swap partition (or file) used by s2disk needs to be made active
> > > > > before it can use it and the mm subsystem is also able to use it for
> > > > > regular swap then.
> > > >
> > > > OK---I had this wrong, thanks.
> > > >
> > > > > >  If there is no swap, but more than 50% of RAM is free
> > > > > > or reclaimable, s2disk works fine.  If anonymous is more than 50%,
> > > > > > hibernation can still work, but swap needs to be set up (in addition
> > > > > > to the space for the hibernation image).  The setup is not obvious and
> > > > > > I don't think that the documentation is clear on this.
> > > > >
> > > > > Well, the entire contents of RAM must be preserved, this way or
> > > > > another, during hibernation.  That should be totally obvious to anyone
> > > > > using it really.
> > > >
> > > > Yes, that's obvious.
> > > >
> > > > > Some of the RAM contents is copies of data already there in the
> > > > > filesystems on persistent storage and that does not need to be saved
> > > > > again.  Everything else must be saved and s2disk (and Linux
> > > > > hibernation in general) uses active swap space to save these things.
> > > > > This implies that in order to hibernate the system, you generally need
> > > > > the amount of swap space equal to the size of RAM minus the size of
> > > > > files mapped into memory.
> > > > >
> > > > > So, to be on the safe side, the total amount of swap space to be used
> > > > > for hibernation needs to match the size of RAM (even though
> > > > > realistically it may be smaller than that in the majority of cases).
> > > >
> > > > This all makes sense, but we do this:
> > > >
> > > > -- add resume=/dev/sdc to the command line
> > > > -- attach a disk (/dev/sdc) with size equal to RAM
> > > > -- mkswap /dev/sdc
> > > > -- swapon /dev/sdc
> > > > -- echo disk > /sys/power/state
> > > >
> > > > and the last operation fails with ENOMEM.  Are we doing something
> > > > wrong?  Are we hitting some other mm bug?
> > >
> > > I would expect this to work, so the fact that it doesn't work for you
> > > indicates a bug somewhere or at least an assumption that doesn't hold.
> > >
> > > Can you please remind me what you do to trigger the unexpected behavior?
> >
> > Yes, I create processes that use a large amount of anon memory, more
> > than 50% of RAM, like this:
> >
> > dd if=/dev/zero bs=1G count=1 | sleep infinity
> >
> > I think dd has a 2 GB limit, or around that number, so you'll need a
> > few of those.
>
> And then you get -ENOMEM from hibernate_preallocate_memory(), or from
> somewhere else?

That is correct.  More precisely, preallocate_image_memory() doesn't
get enough pages, and then preallocate_image_highmem() either gets
nothing, or in any case too little.
