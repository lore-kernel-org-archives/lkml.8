Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AF8C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 23:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65420206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 23:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnROSGwW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634466AbgDNX4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 19:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732201AbgDNX4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 19:56:16 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAF2C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 16:56:16 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d77so15153382wmd.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 16:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=be0q2rjhwVc9Yi+ssBzQr/Anw/EWaI6N7hXKtZkKaXo=;
        b=BnROSGwWErO6usd963RDM9CrXkCe/C3WwHV48iMWS0xU8hgTUZ6IWFLCdsfosVR613
         kYN2FjLWavy4GevURW0TJrJoGlULIB9Qzg0KL508TX7wa5P8A1qQNME4XQ+qfxwNKgVB
         UJ0tz410q4X2itfyjMsbRcsK6McJcmuUBol6WGkE/h7G1LJRcj0ZaVIsg7S7CGpp2sTR
         ektMAVG03Gal6IV44EzW7P3p9b7SVXb24TihSxfjWnVufsL/3x8dMbXP6OXtVPE2RK1S
         ddfo7xwCXOaPOhGci5ijR/vgEIg26wkJFS0vv/hn3YLOAWXIfB9tVU4hBGja4OoeO/CY
         EtTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=be0q2rjhwVc9Yi+ssBzQr/Anw/EWaI6N7hXKtZkKaXo=;
        b=o1HLhwvu3mLjr6xReMCoWA9r7LbHf2UcRg/Z3+64XH/LXwfkBEWO1vPn3M8KXvnTKE
         rRvjBcyXrkFiB1P5mCOfnziuTRDRBBoH1cY4r4iHNAOEEwIUfQ6ImMhinMfH8LIfIFsE
         ivsftFewumr8UCNsQJIFdlfOC/47nGiQ8dFaKGjrXbECRNmYYrZ4OnZEtsJSHMtZWdbz
         eYMtfOdE37XaWKIghcMmznBnGk9MEV4REFXAki76CJfguhRFHRn24NsYJQpJnKi7Nsif
         SNvRn5WS2YxFBgYWal5mUq3MoP8j3l0KkOML07tut1O4b/+6aieiihnTECIs4qDQXgW9
         rkUQ==
X-Gm-Message-State: AGi0PuajBrwHDX0PEi/LHrwM3nQar6/e43+lfICS4YEfIynIWRnbTv92
        A85B/ohibpd9pWFe9HWJX9nM9vBLnqdhpVdUA/jlVuIhfYU=
X-Google-Smtp-Source: APiQypIoyQf9rsh8NwC2QO9zZBBORwk52k2MlKH4VNIqO9Di2R2EXDJTUqqyGfZiHfI3Qc/9JXUmoX7tIVXjMb1GkOI=
X-Received: by 2002:a1c:a4c2:: with SMTP id n185mr2396333wme.104.1586908575106;
 Tue, 14 Apr 2020 16:56:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200411054106.25366-1-james.hilliard1@gmail.com> <87lfmymilm.fsf@intel.com>
In-Reply-To: <87lfmymilm.fsf@intel.com>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Tue, 14 Apr 2020 17:56:03 -0600
Message-ID: <CADvTj4oyK1f5fLM63GZybqdFReEa7sqQqqPyhtRWtLeyWzoDFw@mail.gmail.com>
Subject: Re: [PATCH] component: Silence bind error on -EPROBE_DEFER
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     dri-devel@lists.freedesktop.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 5:07 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
>
> On Fri, 10 Apr 2020, James Hilliard <james.hilliard1@gmail.com> wrote:
> > If a component fails to bind due to -EPROBE_DEFER we should not log an
> > error as this is not a real failure.
> >
> > Fixes:
> > vc4-drm soc:gpu: failed to bind 3f902000.hdmi (ops vc4_hdmi_ops): -517
> > vc4-drm soc:gpu: master bind failed: -517
>
> I'd think the probe defer is useful information anyway. Maybe just tone
> down the severity and/or the message?
That's probably not needed as there's dev_dbg logging for -EPROBE_DEFER
elsewhere from what it looks like.

For example:
https://github.com/torvalds/linux/blob/v5.6/drivers/base/dd.c#L621
>
> BR,
> Jani.
>
> >
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> >  drivers/base/component.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/base/component.c b/drivers/base/component.c
> > index e97704104784..157c6c790578 100644
> > --- a/drivers/base/component.c
> > +++ b/drivers/base/component.c
> > @@ -256,7 +256,8 @@ static int try_to_bring_up_master(struct master *master,
> >       ret = master->ops->bind(master->dev);
> >       if (ret < 0) {
> >               devres_release_group(master->dev, NULL);
> > -             dev_info(master->dev, "master bind failed: %d\n", ret);
> > +             if (ret != -EPROBE_DEFER)
> > +                     dev_info(master->dev, "master bind failed: %d\n", ret);
> >               return ret;
> >       }
> >
> > @@ -611,8 +612,10 @@ static int component_bind(struct component *component, struct master *master,
> >               devres_release_group(component->dev, NULL);
> >               devres_release_group(master->dev, NULL);
> >
> > -             dev_err(master->dev, "failed to bind %s (ops %ps): %d\n",
> > -                     dev_name(component->dev), component->ops, ret);
> > +             if (ret != -EPROBE_DEFER) {
> > +                     dev_err(master->dev, "failed to bind %s (ops %ps): %d\n",
> > +                             dev_name(component->dev), component->ops, ret);
> > +             }
> >       }
> >
> >       return ret;
>
> --
> Jani Nikula, Intel Open Source Graphics Center
