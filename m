Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AB5C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 15:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBF3C20772
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 15:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="rcV8xvqQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgFBPCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 11:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgFBPCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 11:02:46 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52642C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 08:02:46 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f5so3472900wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 08:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ie4XwPUUWuHUs6FpQc71seJRalOxPBnrHjEeZHur870=;
        b=rcV8xvqQ9pPbeXXUaiQ/IjScOQcZmPZgnBs587oPVmCd3+x1Ol79xSWBWAkedejyog
         avM37VtRjXAmg1llx2WbnE0Bc2LRYohlI/hp6EaqXOo5OlFJ6HREm4XxCFvpA3MYRoeE
         4v4sIWbUUqGgKydRX315TGSREnqTA8r57cXrvVxcWngHLMpdtFVSiuCKeaWv+2IG8Jk3
         FyA2tUj1kGPE99oxoNNjsIPXVPxdUShKlY5qjAiV4ZR5Ug6LI0ay8NpiPNSHr3VTuk4n
         iCBZEeEYjuryK4ouCKVKYCfPkxG4uUHEYu67H+aEf1AFloavvIhZVSzJtXN+0E/wH7Wv
         MjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ie4XwPUUWuHUs6FpQc71seJRalOxPBnrHjEeZHur870=;
        b=fw3StN0NG1LM7yUMthKquHjZLlIo6vA3mj5IIQ4c3cQiE7brd24gSinvyqty/xdngb
         WaZG3AczJvahwuMR4WwpCiqIpiTfH3CjiS2J2QSEWWlescPYQf01RyngkzAZA0UKaZWX
         6eBoQOyNDSl+p5Hr2jlrahRr4K2Y1adTQ8/uTSKB1R1kgSW1z1O6DWGPVRfqB6EmoFxc
         T6er+wDHS+21za2XO8Z2h9xpPj2XG9v1J/uVsjoXmKQnKNrzSRlGGMJlboe0CtC5qemX
         Go3UaaxSrD78wnMLHWQv0yMPeN3h7ntyj6gFuPgPNimV7rJ1jSlNiDDSK4GEt39lZVg7
         xsgA==
X-Gm-Message-State: AOAM531hFT7MByOOpZ+uGh+/iq8auF0gV/fYCqR2uEel4R/5bkNrjCfd
        ALoHVC1zkM3mUIvKuJeeWDRQ4xDOo65Qfy1QK+8V8dkl
X-Google-Smtp-Source: ABdhPJw+qlivYu2F8CIkQRiCrVBEGIQXfJye4OGlUJ/N4SBalG1P/TzpCkBTffuFw04vbpL4M63++mj+iMJssStM1iQ=
X-Received: by 2002:a7b:c186:: with SMTP id y6mr4835128wmi.82.1591110165044;
 Tue, 02 Jun 2020 08:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
 <d2c1850e38e14f3def4c0307240e6826e296c14b.1590594512.git-series.maxime@cerno.tech>
 <CADaigPU7c=1u47R9GzvGCH_Z2fywY1foGYEy=KbBikjUQpwUFg@mail.gmail.com> <20200602141228.7zbkob7bw3owajsq@gilmour>
In-Reply-To: <20200602141228.7zbkob7bw3owajsq@gilmour>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 2 Jun 2020 16:02:28 +0100
Message-ID: <CAPY8ntDZWJeu14mL5a0jqUWHFOEWm2OOBBkh4yjjP0oLU83UCQ@mail.gmail.com>
Subject: Re: [PATCH v3 032/105] drm/vc4: crtc: Enable and disable the PV in
 atomic_enable / disable
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Eric Anholt <eric@anholt.net>,
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

Hi Maxime and Eric

On Tue, 2 Jun 2020 at 15:12, Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi Eric
>
> On Wed, May 27, 2020 at 09:54:44AM -0700, Eric Anholt wrote:
> > On Wed, May 27, 2020 at 8:50 AM Maxime Ripard <maxime@cerno.tech> wrote:
> > >
> > > The VIDEN bit in the pixelvalve currently being used to enable or disable
> > > the pixelvalve seems to not be enough in some situations, which whill end
> > > up with the pixelvalve stalling.
> > >
> > > In such a case, even re-enabling VIDEN doesn't bring it back and we need to
> > > clear the FIFO. This can only be done if the pixelvalve is disabled though.
> > >
> > > In order to overcome this, we can configure the pixelvalve during
> > > mode_set_no_fb, but only enable it in atomic_enable and flush the FIFO
> > > there, and in atomic_disable disable the pixelvalve again.
> >
> > What displays has this been tested with?  Getting this sequencing
> > right is so painful, and things like DSI are tricky to get to light
> > up.
>
> That FIFO is between the HVS and the HDMI PVs, so this was obviously
> tested against that. Dave also tested the DSI output IIRC, so we should
> be covered here.

DSI wasn't working on the first patch set that Maxime sent - I haven't
tested this one as yet but will do so.
DPI was working early on to both an Adafruit 800x480 DPI panel, and
via a VGA666 as VGA.
HDMI is obviously working.
VEC is being ignored now. The clock structure is more restricted than
earlier chips, so to get the required clocks for the VEC without using
fractional divides it compromises the clock that other parts of the
system can run at (IIRC including the ARM). That's why the VEC has to
be explicitly enabled for the firmware to enable it as the only
output. It's annoying, but that's just a restriction of the chip.

  Dave
