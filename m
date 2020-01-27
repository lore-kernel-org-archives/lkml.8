Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E6FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 16:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F4420702
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 16:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580142517;
	bh=ThiGhaYyLUUG8C38RbBOPdy3VIEY8Jx/tW4eIXD8FbA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=G8sbcH1v7LEaQBpDOpZhbwOdNz+XZYdHgG4JHDM9DaC27cd2z2EAlS3/TweLSwUAt
	 a1t3BVpIITtKL2va+saEZQqKSrKTWcTRjkAK0Iidua5gAaY1Bo6xo1N3tiXLWTTdej
	 ElmRt1SnLldEZqVvp2Zu/GopHexmfSLlQ3t9xzhM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgA0Q2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 11:28:36 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42080 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgA0Q2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 11:28:35 -0500
Received: by mail-ot1-f68.google.com with SMTP id 66so8928309otd.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 08:28:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jk0WC+x0mPaz/vAe6MTjly0FnoGTyiMYbm4PE77IrJc=;
        b=SWZCYwqmNH75/clCB35GTMD/2yo3whM9xW2MykmuPH67CtgfVmA1EbX/KEe1tiAcmR
         +TctnH/LllTT5YWMrwRMLwt9Sw5ga+NTu6B/nnnJrae2zWaThZqt17S0qD3+SsaGi5pP
         TwPtPfph7dojv/d5MkM3wbAAv50OiDmUQjFxn7eVLf6tr67JuboLY4WhRXzKeBB8vxwa
         I7U+czNu4JjLe1yv0YaOeLqO0tu4ye8PnrjNk2tR/mPbh3/Hn8ysVV1lYyQO9/709w+5
         XWJQur7zyGuA0P7BKznoQ9fnRwjA1W5FMiW/bI3ck9rM/gBGR96pHcw0s+zqY6LMkJQ6
         +Ibg==
X-Gm-Message-State: APjAAAUwrNxhDqcmiLJWFRs4xNy77o4f6MiXtARl3LXcTvxuJT2sbdhZ
        o3eT63cIr/Lug3aRgEvG5GQi2N9YcrnoQdBS4E0=
X-Google-Smtp-Source: APXvYqwYejxMegSnomQTuvhqcQfW89ajNLHE77TT4KoIGx8pBr8+PZXOwxMU3ebtnem4NTnutrRZ6lpHZDXnggd/0LM=
X-Received: by 2002:a9d:62c7:: with SMTP id z7mr12712154otk.189.1580142515134;
 Mon, 27 Jan 2020 08:28:35 -0800 (PST)
MIME-Version: 1.0
References: <20191226220205.128664-1-semenzato@google.com> <20191226220205.128664-2-semenzato@google.com>
 <20200106125352.GB9198@dhcp22.suse.cz> <CAA25o9S7EzQ0xcoxuWtYr2dd0WB4KSQNP4OxPb2gAeaz0EgomA@mail.gmail.com>
 <20200108114952.GR32178@dhcp22.suse.cz> <CAA25o9Q4XP8weCNcTr1ZT9N7Y3V=B90mK8mykLOyy=-4RJ_uHQ@mail.gmail.com>
 <20200127141637.GL1183@dhcp22.suse.cz> <CAA25o9QuA_9EoivWo-DuJsWoHCdBm2wio3G8JYxuTfQErT42kg@mail.gmail.com>
In-Reply-To: <CAA25o9QuA_9EoivWo-DuJsWoHCdBm2wio3G8JYxuTfQErT42kg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Jan 2020 17:28:24 +0100
Message-ID: <CAJZ5v0iDtk+WWHV8F2C+9EdeMSx_JKYDEiarProoE55kiBOjkg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Documentation: clarify limitations of hibernation
To:     Luigi Semenzato <semenzato@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geoff Pike <gpike@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 5:13 PM Luigi Semenzato <semenzato@google.com> wrote:
>
> On Mon, Jan 27, 2020 at 6:16 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Fri 24-01-20 08:37:12, Luigi Semenzato wrote:
> > [...]
> > > The purpose of my documentation patch was to make it clearer that
> > > hibernation may fail in situations in which suspend-to-RAM works; for
> > > instance, when there is no swap, and anonymous pages are over 50% of
> > > total RAM.  I will send a new version of the patch which hopefully
> > > makes this clearer.
> >
> > I was under impression that s2disk is pretty much impossible without any
> > swap.
>
> I am not sure what you mean by "swap" here.  S2disk needs a swap
> partition for storing the image, but that partition is not used for
> regular swap.

That's not correct.

The swap partition (or file) used by s2disk needs to be made active
before it can use it and the mm subsystem is also able to use it for
regular swap then.

>  If there is no swap, but more than 50% of RAM is free
> or reclaimable, s2disk works fine.  If anonymous is more than 50%,
> hibernation can still work, but swap needs to be set up (in addition
> to the space for the hibernation image).  The setup is not obvious and
> I don't think that the documentation is clear on this.

Well, the entire contents of RAM must be preserved, this way or
another, during hibernation.  That should be totally obvious to anyone
using it really.

Some of the RAM contents is copies of data already there in the
filesystems on persistent storage and that does not need to be saved
again.  Everything else must be saved and s2disk (and Linux
hibernation in general) uses active swap space to save these things.
This implies that in order to hibernate the system, you generally need
the amount of swap space equal to the size of RAM minus the size of
files mapped into memory.

So, to be on the safe side, the total amount of swap space to be used
for hibernation needs to match the size of RAM (even though
realistically it may be smaller than that in the majority of cases).
