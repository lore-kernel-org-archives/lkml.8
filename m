Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FA9C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 627F920809
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="dEkb4hGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgG2OqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgG2OqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:46:15 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481E4C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 07:46:15 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id p14so2978051wmg.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 07:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3iyFpM5/BXg/ovW1sf4meruZ9t5/ZCB/YXrufU01eIM=;
        b=dEkb4hGGoi60zjTJt0jGB+G3PDfjSdeL573SQ9ZlTLlJpbzG1mvzCSBPrSHaxFWnHq
         wesmd8C4xEWXcwAD1Ofb4i9NEiD0kjobimkh8lNMT9P7zphud59M7gvsf8rI5o+/IJSU
         MrAngD03i3HCsyt1Txo66Vf05UVhTcKOoix5sObcfZxIe1Lu0X16HuAqOm7PFHcOyyn9
         IlFo3DYouLlgCOXmEcZXqNVlVopPHNoQptmn8p1/GsNEbwE2oXZFBGVupjZCh3ouCWrD
         x01FzIMzGrNJkedjSqdos6FURUez3YonBiw2dRVOvO/TXWYZG67ueiYM2ONC0XXo2vJL
         axcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3iyFpM5/BXg/ovW1sf4meruZ9t5/ZCB/YXrufU01eIM=;
        b=udrS6ZrfqgFGTF0e84LtW8VjIzIpmO/JoYT3KMtl6TMhfwVW409I5jANm9DFGPfi4v
         UVRwPn9Y+gjcn1YICSO8Nj8kDQbbbpRrTHGS7vbfdCKr+SS9Cyp9ZVC+fgNT5czbLUPF
         0F0u0ljEcdBayGMLIlHyJ2syiNsBsmf7vMy1HuGdZIWGCOoIbE8ediihaV1setd1n2fM
         T0YhiISfe01+rRu3tbBR3xmyrFPEz1QS6WjhMKnJBkjMH0i5Dl5nw9CNecfggjfKK4TW
         gSEvIrrHNIVNWlhh7VSDShHQbSIXlHpsyFuwqqQnm3EXrqAHPPiC+NZIbu8bNe2Id47b
         OO8w==
X-Gm-Message-State: AOAM531hB6Y+F9o4nuLKCiAJqnUYKNEnZrvc09xzgfKXtrCwvrtsJb5K
        Fgsm7CtCL7msIYitaOBSVw0SlOXB8zKd1Fa0a8wHxg2UAaU=
X-Google-Smtp-Source: ABdhPJw/p50BFEtwezXo1Ruo1n5u3zHVab9meBJ37HMrBT8un5GezRt6kNuz774MxcXHPwwK69ieab/DodPZnsYLezc=
X-Received: by 2002:a1c:1d52:: with SMTP id d79mr6877815wmd.82.1596033973615;
 Wed, 29 Jul 2020 07:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
 <a1f22aadc60a2f32022831a6348c8bbd6e1954c3.1594230107.git-series.maxime@cerno.tech>
 <CAPY8ntBLWrfagZ5-kQz+5Mkw4_KaaTP63_L3D4owJAfA5kFpzw@mail.gmail.com> <20200729144251.us6a2pgkjjmm53ov@gilmour.lan>
In-Reply-To: <20200729144251.us6a2pgkjjmm53ov@gilmour.lan>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Wed, 29 Jul 2020 15:45:57 +0100
Message-ID: <CAPY8ntD9MS_4G20v=Em-GyV0RjV=2gK0Tq+026WziKtv4a55wQ@mail.gmail.com>
Subject: Re: [PATCH v4 29/78] drm/vc4: crtc: Add a delay after disabling the
 PixelValve output
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>,
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

On Wed, 29 Jul 2020 at 15:42, Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi,
>
> On Wed, Jul 29, 2020 at 03:09:21PM +0100, Dave Stevenson wrote:
> > On Wed, 8 Jul 2020 at 18:43, Maxime Ripard <maxime@cerno.tech> wrote:
> > >
> > > In order to avoid pixels getting stuck in the (unflushable) FIFO between
> > > the HVS and the PV, we need to add some delay after disabling the PV output
> > > and before disabling the HDMI controller. 20ms seems to be good enough so
> > > let's use that.
> > >
> > > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > > ---
> > >  drivers/gpu/drm/vc4/vc4_crtc.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
> > > index d0b326e1df0a..7b178d67187f 100644
> > > --- a/drivers/gpu/drm/vc4/vc4_crtc.c
> > > +++ b/drivers/gpu/drm/vc4/vc4_crtc.c
> > > @@ -403,6 +403,8 @@ static void vc4_crtc_atomic_disable(struct drm_crtc *crtc,
> > >         ret = wait_for(!(CRTC_READ(PV_V_CONTROL) & PV_VCONTROL_VIDEN), 1);
> > >         WARN_ONCE(ret, "Timeout waiting for !PV_VCONTROL_VIDEN\n");
> > >
> > > +       mdelay(20);
> >
> > mdelay for 20ms seems a touch unfriendly as it's a busy wait. Can we
> > not msleep instead?
>
> Since the timing was fairly critical, sleeping didn't seem like a good
> solution since there's definitely some chance you overshoot and end up
> with a higher time than the one you targeted.

Fair enough. I know timing is "entertaining" around some of the 2711
pipeline setup.

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
