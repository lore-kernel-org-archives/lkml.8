Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32254C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 06:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2444B206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 06:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387967AbgCLGzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 02:55:16 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40444 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387831AbgCLGzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 02:55:15 -0400
Received: by mail-ed1-f66.google.com with SMTP id a24so6058417edy.7;
        Wed, 11 Mar 2020 23:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iBI+IMhc856gLvqD38/aabvbUecRCqO7veLE4i2WwDg=;
        b=kspCSTbc1WQOhOosI5JQaCtAgO9ff2RCHOoB6StUI2luGhjtAmgRglmJ9KrJfJ4RhW
         13Qxt3hAehhpeSt+GYeBZtFLYKPRYr7Sn8cv3OJsb8J46jV0mR8ekmZANjzOHW4jRXyz
         QQABLnVninZiUccmDXf8x3LPSnT1E0eeNmPTChWg1sbhxdvEEmfTBvpHoK0mJdv4VugK
         Hw7eCU37G40boH4t6Y5nqWu5BCZNzRJPCxz+mM3FfONSNCXKPmB9Jc9K1AP1RAW95ScF
         Wh0zhE3msE/wRs0CaYxEC2hJNMICEOFKZoSzkIaHwLrIldWODo8UPkDDm8fx9FEaxPoI
         XMIQ==
X-Gm-Message-State: ANhLgQ1sIwS67YqPgP04bmuGdpKAnQVV2n0wwXShksIYYr36TKoODwnj
        negHv3iK+CrMeUZ2egNd5f7dTbDNorU=
X-Google-Smtp-Source: ADFU+vvXT++46RysC5o/6LlFS03X9qDHncr8qIQsuPaLOoJPXUTNQDTCIY8vJv8vT0BCIJ+D0zrDmw==
X-Received: by 2002:a17:906:a856:: with SMTP id dx22mr4950473ejb.143.1583996110905;
        Wed, 11 Mar 2020 23:55:10 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id h22sm3003634edq.28.2020.03.11.23.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 23:55:10 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id a25so5964427wrd.0;
        Wed, 11 Mar 2020 23:55:10 -0700 (PDT)
X-Received: by 2002:adf:f2c7:: with SMTP id d7mr9301781wrp.104.1583996110307;
 Wed, 11 Mar 2020 23:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200309204326.27403-1-thirtythreeforty@gmail.com>
 <20200309204326.27403-3-thirtythreeforty@gmail.com> <CAGb2v64_cWagG54iMmzmOwtUmv91xJchtzKW25M=y9DbfFDzkQ@mail.gmail.com>
In-Reply-To: <CAGb2v64_cWagG54iMmzmOwtUmv91xJchtzKW25M=y9DbfFDzkQ@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 12 Mar 2020 14:54:59 +0800
X-Gmail-Original-Message-ID: <CAGb2v67eNenKf5S0sNESOOJM3pY3Mqa5ZCXCwy5nBwE3oQ5hEg@mail.gmail.com>
Message-ID: <CAGb2v67eNenKf5S0sNESOOJM3pY3Mqa5ZCXCwy5nBwE3oQ5hEg@mail.gmail.com>
Subject: Re: [RESEND PATCH 2/5] phy: sun4i-usb: add support for the USB PHY on
 suniv SoC
To:     George Hilliard <thirtythreeforty@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-usb <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 2:51 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Tue, Mar 10, 2020 at 4:43 AM George Hilliard
> <thirtythreeforty@gmail.com> wrote:
> >
> > The suniv SoC has one USB OTG port connected to a MUSB controller.
> >
> > Add support for its USB PHY.
> >
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>
> Not sure why Icenowy's SoB is here. If she was the original author, you
> are supposed to keep her name as the author.
>
> > Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
> > ---
> >  drivers/phy/allwinner/phy-sun4i-usb.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
> > index 856927382248..5fb0c42fe8fd 100644
> > --- a/drivers/phy/allwinner/phy-sun4i-usb.c
> > +++ b/drivers/phy/allwinner/phy-sun4i-usb.c
> > @@ -98,6 +98,7 @@
> >  #define POLL_TIME                      msecs_to_jiffies(250)
> >
> >  enum sun4i_usb_phy_type {
> > +       suniv_f1c100s_phy,
> >         sun4i_a10_phy,
> >         sun6i_a31_phy,
> >         sun8i_a33_phy,
> > @@ -859,6 +860,14 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
> >         return 0;
> >  }
> >
> > +static const struct sun4i_usb_phy_cfg suniv_f1c100s_cfg = {
> > +       .num_phys = 1,
> > +       .type = suniv_f1c100s_phy,
> > +       .disc_thresh = 3,
> > +       .phyctl_offset = REG_PHYCTL_A10,
> > +       .dedicated_clocks = true,
> > +};
> > +
> >  static const struct sun4i_usb_phy_cfg sun4i_a10_cfg = {
> >         .num_phys = 3,
> >         .type = sun4i_a10_phy,
> > @@ -973,6 +982,8 @@ static const struct sun4i_usb_phy_cfg sun50i_h6_cfg = {
> >  };
> >
> >  static const struct of_device_id sun4i_usb_phy_of_match[] = {
> > +       { .compatible = "allwinner,suniv-f1c100s-usb-phy",
> > +         .data = &suniv_f1c100s_cfg },
> >         { .compatible = "allwinner,sun4i-a10-usb-phy", .data = &sun4i_a10_cfg },
>
> Please use the same style (and ignore checkpatch.pl on this one).
>
> ChenYu
>
> >         { .compatible = "allwinner,sun5i-a13-usb-phy", .data = &sun5i_a13_cfg },
> >         { .compatible = "allwinner,sun6i-a31-usb-phy", .data = &sun6i_a31_cfg },


Also, please stick to the same ordering in the driver and the bindings.

FWIW, `sort` places "suniv" after all sun([4-9]|50)i variants.

ChenYu

> > --
> > 2.25.0
> >
