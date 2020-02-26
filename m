Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADC2C4BA0A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 01:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 103E5222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 01:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tb0I8cSF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbgBZBvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 20:51:53 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33908 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729501AbgBZBvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 20:51:53 -0500
Received: by mail-qk1-f195.google.com with SMTP id 11so1222763qkd.1;
        Tue, 25 Feb 2020 17:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ExNh/gghsj1ImBILJ0ozb3ysT/hRkbhT4G0voLUZVgI=;
        b=tb0I8cSFTYgT7uR05Z3XcyQJudBEyylDCJtGYxlyf+qKYaSVvQWf55BjyB0khyCpLk
         URIaKz8zV1v01cmlqTYofRQsyBn8Q5Xt2rQEalI+Bp/hZVGA+FiZ+yRld1QP6kbZoWGJ
         7Gj0IK6HUXHNGltU2GzHzrFP3clFdNNN+0OktaNn9k/nST5HQ3mzbSEIY+czvohawaQD
         MAhSbkhjjugNTm+rbJ245lRRzWZKczZJpSiFeufw6NQb6WrEVegjDueb6bBFi4UeBGyu
         c6Jc6g0+n6samzd3DBCYRm9UKYyRa0j4nQ79StvG/C232fibx7lajHhp71iMwm8podbN
         axzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ExNh/gghsj1ImBILJ0ozb3ysT/hRkbhT4G0voLUZVgI=;
        b=NOtQedgqen+j1lNgRpn1W1DmL35j+Nf1qePWLA1Oano+VptOeC6juCs/TBgiKMQs3y
         13uMpnN8/Sg5FH7aqGNHt31j8fJL/3MO8mXMeOXV3uKegP3nLNmvCKcO4wUL2arVYDUD
         2jjk634ej9tXOO9ISpZngQcLHqNN+pWiJCJZnIrHhfzWjmIHBtfZT9ckS0E2HvR6v07W
         xqrI0GZoWezFMhYb+2vWcnM0dpEx6OzD7lzmMUW80j4mx9Eik7Nz6ibkUletHjdlArYB
         3vpSO1ju7XkM+UeC5XeTqrJL4vv7t4gbOb+SRh9gM+OJb3m/Z4A7sj+6sTjwH/Di9mXc
         ZRUQ==
X-Gm-Message-State: APjAAAUA7WyoXNVPnsLTzq3q+JIODdY2ffaAmUVMueAaHDlKw4W1lz7b
        UrzMqa20NJglbXLv+uos3K+yPLILeRLpLXuDwok=
X-Google-Smtp-Source: APXvYqyynmPK9+Rdbdj6+s+AmVwrzFwMwUtQnyhXObjLlWE28j9mHJIWKxFk9yjPuy5ceKsGuAuF/TUUtksL5KcdvEY=
X-Received: by 2002:a37:5c9:: with SMTP id 192mr2480838qkf.103.1582681910840;
 Tue, 25 Feb 2020 17:51:50 -0800 (PST)
MIME-Version: 1.0
References: <VE1PR04MB6479BCA376502F6F1251602BE3EC0@VE1PR04MB6479.eurprd04.prod.outlook.com>
 <20200225080350.GA11332@Asurada>
In-Reply-To: <20200225080350.GA11332@Asurada>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Wed, 26 Feb 2020 09:51:39 +0800
Message-ID: <CAA+D8AMFzDs8uXiR-N8harRVmhC+3i8p9HdO2CgxOCX8WVfXAw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ASoC: fsl_easrc: Add EASRC ASoC CPU DAI and
 platform drivers
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     "S.j. Wang" <shengjiu.wang@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 4:05 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Mon, Feb 24, 2020 at 08:53:25AM +0000, S.j. Wang wrote:
> > Hi
> >
> > > >
> > > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > > ---
> > > >  sound/soc/fsl/Kconfig           |   10 +
> > > >  sound/soc/fsl/Makefile          |    2 +
> > > >  sound/soc/fsl/fsl_asrc_common.h |    1 +
> > > >  sound/soc/fsl/fsl_easrc.c       | 2265 +++++++++++++++++++++++++++++++
> > > >  sound/soc/fsl/fsl_easrc.h       |  668 +++++++++
> > > >  sound/soc/fsl/fsl_easrc_dma.c   |  440 ++++++
> > >
> > > I see a 90% similarity between fsl_asrc_dma and fsl_easrc_dma files.
> > > Would it be possible reuse the existing code? Could share structures from
> > > my point of view, just like it reuses "enum asrc_pair_index", I know
> > > differentiating "pair" and "context" is a big point here though.
> > >
> > > A possible quick solution for that, off the top of my head, could be:
> > >
> > > 1) in fsl_asrc_common.h
> > >
> > >         struct fsl_asrc {
> > >                 ....
> > >         };
> > >
> > >         struct fsl_asrc_pair {
> > >                 ....
> > >         };
> > >
> > > 2) in fsl_easrc.h
> > >
> > >         /* Renaming shared structures */
> > >         #define fsl_easrc fsl_asrc
> > >         #define fsl_easrc_context fsl_asrc_pair
> > >
> > > May be a good idea to see if others have some opinion too.
> > >
> >
> > We need to modify the fsl_asrc and fsl_asrc_pair, let them
> > To be used by both driver,  also we need to put the specific
> > Definition for each module to same struct, right?
>
> Yea. A merged structure if that doesn't look that bad. I see most
> of the fields in struct fsl_asrc are being reused by in fsl_easrc.
>
> > >
> > > > +static const struct regmap_config fsl_easrc_regmap_config = {
> > > > +     .readable_reg = fsl_easrc_readable_reg,
> > > > +     .volatile_reg = fsl_easrc_volatile_reg,
> > > > +     .writeable_reg = fsl_easrc_writeable_reg,
> > >
> > > Can we use regmap_range and regmap_access_table?
> > >
> >
> > Can the regmap_range support discontinuous registers?  The
> > reg_stride = 4.
>
> I think it does. Giving an example here:
> https://github.com/torvalds/linux/blob/master/drivers/mfd/da9063-i2c.c

The register in this i2c driver are continuous,  from 0x00, 0x01, 0x02...

But our case is 0x00, 0x04, 0x08, does it work?

best regards
wang shengjiu
