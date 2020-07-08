Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AD8C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A8BF206E2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bILbsUSm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgGHSwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 14:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGHSwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 14:52:38 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12449C061A0B;
        Wed,  8 Jul 2020 11:52:38 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t27so35026816ill.9;
        Wed, 08 Jul 2020 11:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I8Ek3sbHV+Qpe9fOcOzWZlvnSZlEgpYlcwZ61n1jFP4=;
        b=bILbsUSmkg8pSmFk4+CWhpqPMprhbG7sR2glHtRT9QDUqRqiE6KUCWnWL+lW/Wg7Hs
         9+uRAEnwnVxl6QiBEUPX/AaGTdHpGjKJfwwmTHNJQigTFPkrkVAJrEXnl3P4y36WdTbw
         5D7XgNlUkbVcjlVie5UYwGcvc+wvptuPAY1mZ2FhNjYLRBU6NWlyUcLOWavOZZclmi8o
         8tna/B7Sl+jiQV0AVQh5c6UlFtfI2HPP171JUmp92wlXbpLHQeIWdTNPJE990xHts1WQ
         Gyk0FQzJfV+xpRCMAWIq0aYOy45b/AOv5S7eI24/bapQiBwcPZmaDjs+bu1x0VRNZJwx
         Mjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I8Ek3sbHV+Qpe9fOcOzWZlvnSZlEgpYlcwZ61n1jFP4=;
        b=qAhTjPtHNVuouMz6HLX6xYlBJD/9h0Z25xYFK7rQ0eTDtpPwFXiYieO7JBD6XL2rZ1
         VjhFDQeNpu4H7ikbrMtAC/n41HYxsJogC7y2SED0NTRrjMSw2mbP0iHymYjT7ufoZnjb
         qYYJwZUkjzyb8JhN4TSCfKsuNK0nBg1pSV7M16scsL1YOqaZt/RyzLNNZ3ezdx0V+YZJ
         8d0K7M4SBhcbXWt6aExdhyGe5l9d3JMEzT4ts5ZaVAB7VwKrIx6Pr8iOluDOFoBNqY/O
         n9ehV9UzBxXuB3dGuxjD7IschI+GcntLksBGTX+tMb6srzMRqviM7LJsqGsPbi4+9plX
         6CZg==
X-Gm-Message-State: AOAM532UoAEmMviMpzoVjHAi9WduQxx+2uftwhjVwuLFLXQApAXov6ED
        VJQd4tnJZqJBOkwa0czGDfLFpWesuYf2x+egFMIr13hHMGGl4Q==
X-Google-Smtp-Source: ABdhPJyJZHa3+V4fpz8geqJjVvpO/S7oXioSIGMEpHorK088WAqCy+3mjXN0Kpk3TMCdJ5FhXhqWnqtdYqmwlj3svCg=
X-Received: by 2002:a92:5b4b:: with SMTP id p72mr12269260ilb.285.1594234357448;
 Wed, 08 Jul 2020 11:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAFXsbZrFRH2=+OgBARRkku2O0Okv=jg-uZaN+1Cv1tEwq-8k5Q@mail.gmail.com>
 <CAOMZO5C42kbRM7T3kphdOFZPCPHz6kS+32X3CPncrAnhiP3HFw@mail.gmail.com>
In-Reply-To: <CAOMZO5C42kbRM7T3kphdOFZPCPHz6kS+32X3CPncrAnhiP3HFw@mail.gmail.com>
From:   Chris Healy <cphealy@gmail.com>
Date:   Wed, 8 Jul 2020 11:52:26 -0700
Message-ID: <CAFXsbZpy_mmhr2vHATqCajRi5-4AgwHOLd+wqCr_DMwjOuZwVQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: vf610-zii-dev-rev-c.dts: Configure fibre port
 to 1000BaseX
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 8, 2020 at 11:41 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Chris,
>
> In the Subject you could remove the .dts from the dts name:
>
> ARM: dts: vf610-zii-dev-rev-c: Configure fibre port to 1000BaseX
>
> On Sun, Jul 5, 2020 at 9:51 PM Chris Healy <cphealy@gmail.com> wrote:
> >
> > The SFF soldered onto the board expects the port to use 1000BaseX.  It
> > makes no sense to have the port set to SGMII, since it doesn't even
> > support that mode.
> >
> > Signed-off-by: Chris Healy <cphealy@gmail.com>
> > ---
> >  arch/arm/boot/dts/vf610-zii-dev-rev-c.dts | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
> > b/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
> > index 778e02c000d1..de79dcfd32e6 100644
> > --- a/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
> > +++ b/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
> > @@ -164,7 +164,7 @@
> >                      port@9 {
> >                          reg = <9>;
> >                          label = "sff2";
> > -                        phy-mode = "sgmii";
> > +                        phy-mode = "1000base-x";
>
> Looks like tabs were converted to spaces.

I'll make both changes and submit a v2, thanks.
