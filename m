Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F24C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D82A2206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=anholt-net.20150623.gappssmtp.com header.i=@anholt-net.20150623.gappssmtp.com header.b="VG2CJ5t+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgFBTbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgFBTbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:31:50 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4E9C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 12:31:50 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id z9so3380351ljh.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 12:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anholt-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IQbEYa0oW0Il8mjfCzR4SoEfB7EUDs8d+32KPqK0uG4=;
        b=VG2CJ5t+FQePnvjuONDwr6Dql0NvazBNVRqadOsYgGBHsWUl15Ct8FtXwYihJnDz4P
         roesHC2nlZ1W+rf0yu/PrUqwzwy9amDLGR8maWs7F7LOLxt51R6tgnYvEXzcAPzEY5/C
         A3syAi0TEP9TFKGEiO5g+0hlkjSzNyG6QQG+3cF+LfRsQdyWyzrXblFKTUdRm84VvTRM
         90fejGTEfsQCFOcBHCCd2S/eQs0TKYCv7mMunvHHl4cPh9vJDYMGI2Qj6UNQZhNYyl4A
         6YKeBUUuielCOD2+N2SFexpH6ft4bMjwWpo58iuHfwApd6/fnY69lPErh6E1cNhXyw4o
         9R7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IQbEYa0oW0Il8mjfCzR4SoEfB7EUDs8d+32KPqK0uG4=;
        b=TcnwGhroKHSzTibcxSmslVOxPNG19IH87akTDUKAxFwRUbZtOFbaDwXYjtX85Xy0//
         596Kv8BjCSA6WXNCSw4XQvIfPVesydstNoKp76hkC0sBJ4ADbTQX/vo2TcEh7EEbguXO
         7j37BUdOa+8DrpkYRR1pOP+6cIVagtRKyjk/5ynY4Ua/+32RBIdzxpD3CeLpIfGLrGgw
         UlMgCeFJLi3i8EZO2EZCuQCnqfa0ufkB2cntbdHSy0oNO3qnvAo4tnH7y+q7pIuQKz2w
         HPYpM0RgltcsRr/yPxMFq6Jgx2NGrhsQNBG83CkmebvCLOq4U1G6dt0BeWVOGzMrkE0j
         DLWw==
X-Gm-Message-State: AOAM532vu0WJD+zt4yb7bGXJdvUehlXygr61IavJ8NIm5PCGitOlYtX8
        KmGJ4FaAkvPcsPFx7VjdC5TA1V1xiFBATjD4F9Da0Q==
X-Google-Smtp-Source: ABdhPJxA2pW7yh8mSs3AzE0QrgE8KUJRrdHsiJaMgBJ2xDsVXK8ITtIHOEPS1WjP3x7YzPtQAVEFE55uqBSjObbn8hU=
X-Received: by 2002:a2e:9147:: with SMTP id q7mr326807ljg.430.1591126308681;
 Tue, 02 Jun 2020 12:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
 <d2c1850e38e14f3def4c0307240e6826e296c14b.1590594512.git-series.maxime@cerno.tech>
 <CADaigPU7c=1u47R9GzvGCH_Z2fywY1foGYEy=KbBikjUQpwUFg@mail.gmail.com>
 <20200602141228.7zbkob7bw3owajsq@gilmour> <CAPY8ntDZWJeu14mL5a0jqUWHFOEWm2OOBBkh4yjjP0oLU83UCQ@mail.gmail.com>
In-Reply-To: <CAPY8ntDZWJeu14mL5a0jqUWHFOEWm2OOBBkh4yjjP0oLU83UCQ@mail.gmail.com>
From:   Eric Anholt <eric@anholt.net>
Date:   Tue, 2 Jun 2020 12:31:37 -0700
Message-ID: <CADaigPUHPhdrt9JkTfaw0iT7Z8z3Si-v2VJ-s+dhnFQaDNkAaA@mail.gmail.com>
Subject: Re: [PATCH v3 032/105] drm/vc4: crtc: Enable and disable the PV in
 atomic_enable / disable
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 2, 2020 at 8:02 AM Dave Stevenson
<dave.stevenson@raspberrypi.com> wrote:
>
> Hi Maxime and Eric
>
> On Tue, 2 Jun 2020 at 15:12, Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > Hi Eric
> >
> > On Wed, May 27, 2020 at 09:54:44AM -0700, Eric Anholt wrote:
> > > On Wed, May 27, 2020 at 8:50 AM Maxime Ripard <maxime@cerno.tech> wrote:
> > > >
> > > > The VIDEN bit in the pixelvalve currently being used to enable or disable
> > > > the pixelvalve seems to not be enough in some situations, which whill end
> > > > up with the pixelvalve stalling.
> > > >
> > > > In such a case, even re-enabling VIDEN doesn't bring it back and we need to
> > > > clear the FIFO. This can only be done if the pixelvalve is disabled though.
> > > >
> > > > In order to overcome this, we can configure the pixelvalve during
> > > > mode_set_no_fb, but only enable it in atomic_enable and flush the FIFO
> > > > there, and in atomic_disable disable the pixelvalve again.
> > >
> > > What displays has this been tested with?  Getting this sequencing
> > > right is so painful, and things like DSI are tricky to get to light
> > > up.
> >
> > That FIFO is between the HVS and the HDMI PVs, so this was obviously
> > tested against that. Dave also tested the DSI output IIRC, so we should
> > be covered here.
>
> DSI wasn't working on the first patch set that Maxime sent - I haven't
> tested this one as yet but will do so.
> DPI was working early on to both an Adafruit 800x480 DPI panel, and
> via a VGA666 as VGA.
> HDMI is obviously working.
> VEC is being ignored now. The clock structure is more restricted than
> earlier chips, so to get the required clocks for the VEC without using
> fractional divides it compromises the clock that other parts of the
> system can run at (IIRC including the ARM). That's why the VEC has to
> be explicitly enabled for the firmware to enable it as the only
> output. It's annoying, but that's just a restriction of the chip.

I'm more concerned with "make sure we don't regress pre-pi4 with this
series" than "pi4 displays all work from the beginning"
