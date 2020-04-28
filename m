Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B777C83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F26B20730
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="PryLDU8f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgD1QT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 12:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbgD1QTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 12:19:55 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F79C03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 09:19:55 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k12so3465868wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 09:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NopApeXh01c7L2Io03QMx8cqkS9YkQo3viws4wlNnSg=;
        b=PryLDU8fNN6N3kbaEKSnFW3ZljxLU0aEKb/QT9PXimf+nSVuMU7ucP99uGmeVTuXFL
         0p/ee18S1smX9x1e3ceylcDz2SWJwa72ZTbsMwetmBYWEVX4cF27O41AGTzVcwrn8u5g
         PbIsYOtqM23NIaTvc9y3sESXaAwIbJCxITZ2P2HQx3/XwghUA3gnM5d5HELhhFuWkpcF
         jsrnu3vL/GB66Xo166FKKryG/ir7ksho4hffwu3LLfhCcE98upCyoVzWUi8wsLFGyxd+
         bjwNjleFhAVyz2XyiubXZlKf1ikUnHD9bAdfHhukEalyqgFJiEGxZrgQIzqPY+WYytnp
         esGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NopApeXh01c7L2Io03QMx8cqkS9YkQo3viws4wlNnSg=;
        b=D9rVm+2CI4J4fpL63PcrIJLUBIWqSUJesRelBQ9EcdVlGSu28WzENlCvy5whQP35o9
         YA09/V375mWaXY6YwPxa12wAQPgNC/2C8UG7JCJPNFW0B/1DT/ZZtjpVB/XeJhKUfbG2
         18fN+gtiFrTknm/8zTeWV3KKxcK+g94YAqqgmdiBPXZl2G7/78Z11y14aJGfaYV7c2L9
         +ekk6q5ODNdJD70f/NwmEn2UUx6/YpjsHRwgerYm+FYmCv0rZyeZz5sDRfh4+70gQ49y
         oYyEK/FvnqPlHppE3qtO1AjZIktY/KoX4CzTJFnHLcXOIOOGlzmIGFEzkW5qiHtIFu7e
         VcIw==
X-Gm-Message-State: AGi0PuZ1V5hyORvv5g/GSfJvitz3f3tcKfb2IoRxdy8TeATU4LE8CopA
        Pc5ywW+QU+b77TtciNzRUnWPHIGb2Iyzr/MDtuii6w==
X-Google-Smtp-Source: APiQypL3EsQ0jh1kA70/8Mgecdub3pq/2jqTXvhu/nseZ/tzt8oMEkOy7SFss8lrIFNxrKhvMfuy0TfvWG9Tvdn0UgM=
X-Received: by 2002:a1c:2457:: with SMTP id k84mr5090599wmk.96.1588090793272;
 Tue, 28 Apr 2020 09:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
 <4cd617827cc28875ef36f3632122a83cff2ea4a7.1587742492.git-series.maxime@cerno.tech>
 <63f9e71a-1beb-7a67-ea48-dbc579fa3161@i2se.com> <20200428155711.efpq6vbqcq52gjk5@gilmour.lan>
In-Reply-To: <20200428155711.efpq6vbqcq52gjk5@gilmour.lan>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 28 Apr 2020 17:19:38 +0100
Message-ID: <CAPY8ntBkKebzCM8uG0=YN_XngWS=Kgmgs_LBXmJb1nY3uPEWUw@mail.gmail.com>
Subject: Re: [PATCH v2 79/91] drm/vc4: hdmi: Deal with multiple debugfs files
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>,
        Tim Gover <tim.gover@raspberrypi.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan and Maxime

On Tue, 28 Apr 2020 at 16:57, Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi Stefan,
>
> On Sat, Apr 25, 2020 at 11:26:31PM +0200, Stefan Wahren wrote:
> > Am 24.04.20 um 17:35 schrieb Maxime Ripard:
> > > The HDMI driver was registering a single debugfs file so far with the name
> > > hdmi_regs.
> > >
> > > Obviously, this is not going to work anymore when will have multiple HDMI
> > > controllers since we will end up trying to register two files with the same
> > > name.
> > >
> > > Let's use the ID to avoid that name conflict.
> >
> > even with this patch there is a name conflict in debugfs using Linux
> > 5.7-rc1. Dave Stevenson addressed this by using different card names
> > [1]. Since this patch won't apply anymore here is my suggestion:
> >
> > diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> > index 29287ab..7209397 100644
> > --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> > +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> > @@ -1181,9 +1181,14 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi
> > *vc4_hdmi)
> >
> >      card->dai_link = dai_link;
> >      card->num_links = 1;
> > -    card->name = "vc4-hdmi";
> >      card->dev = dev;
> >
> > +    if (vc4_hdmi->variant->encoder_type == VC4_ENCODER_TYPE_HDMI1) {
> > +        card->name = "vc4-hdmi1";
> > +    } else {
> > +        card->name = "vc4-hdmi";
> > +    }
> > +
>
> Thinking about this some more, we don't really need VC4_ENCODER_TYPE_HDMI0 and
> HDMI1, and it can all work with the same encoder type for both, so I'll drop
> them.
>
> To address this issue though, we can add a card name string to the variant, like
> I did for debugfs. Is that alright for you?

My patch doesn't fix everything with the audio debugfs entries anyway.
I'm working against 5.4 on our downstream tree, and even with my patch
I get
[    7.459508] debugfs: Directory 'fef00700.hdmi' with parent
'vc4-hdmi' already present!
[    7.511017] debugfs: Directory 'fef05700.hdmi' with parent
'vc4-hdmi1' already present!
I seem to recall I reduced the number of complaints over 'vc4-hdmi',
but internal to sound/soc-core the node is still registered twice.

There was discussion about this a few months back.
https://lore.kernel.org/lkml/1jblpvraho.fsf@starbuckisacylon.baylibre.com/
seemed to conclude that it wasn't totally trivial to solve.

Regards,
  Dave
