Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2D0C35DFA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 08:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B7920578
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 08:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDWNGF9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgBYIEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 03:04:01 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37662 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729001AbgBYIEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 03:04:00 -0500
Received: by mail-pf1-f196.google.com with SMTP id p14so6754932pfn.4;
        Tue, 25 Feb 2020 00:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3UwgyNGegYf+ShQWoRWvT/NL7ARqm4MqRGArNYI3who=;
        b=kDWNGF9vw5evEFnyTn5rudlI/14OO67KtZuSmNARz8zTE4vVP7Hhc6JwfRZjCo85Z2
         tvgyuCBpwge1k7uxAL3cVdZdd0QGzOONoXlY+5TvHTzrZZoIbbnkxtUVyXYv0RR+Vity
         fOXvHDB3esTtnVmpSpmzuRqas5eMJ9vZFO4fAMfsF60iMsVd/vW2Bzs8+2d+xXASD2zh
         SUjAI5xrrtkyJAoK+q4wao8cymtP54e+xRZfxO+DeDmxIwT0qBTqrTWjbSlS9EpolcvA
         HhiiBRfm4FTS4F09uPw+SswFfyUOtYA5VfsHVt5vnwZO3TjYll5qx31WeHyUw/SVquMa
         Xd9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3UwgyNGegYf+ShQWoRWvT/NL7ARqm4MqRGArNYI3who=;
        b=Kz8XWTDFQIa+CRV65GaM2DGK6zrupl5l+oZ0G+tJGBzvacECZAoK6hlGYYUCbj0ZP6
         EjzEnDzpJVlZFdCHquwW+Ww9QOCTri9/5VqOOsSLlAK2P0q10lgIAQxYl8eTy2+WKJYj
         UXvWd7ZSgEJ1BOxDYn9xlbi0YF7IriE8gprQegywDgFNVlR8h9/DQiFbb4BjciMVgyFp
         uDQ0uuBF08Zcc5rsJ5t8RiKx77FXzngqrDaWq87houu+YnEQKcQ2L8Z6gSQ3yQwjw2+a
         RzM3IF/fGv1sVHcprzbz8taVvD1NGO7iPuyLLI3zQDkfrMoseiP9IUguDmgr1mEUUG+o
         o+Vg==
X-Gm-Message-State: APjAAAWr6TSox7wmFS8aUUERfLOsCY9rEBsJultDc18i/35+Xy+Gueqy
        clkvLW/rfzeLsWhZcxDcj2Q=
X-Google-Smtp-Source: APXvYqwMRtQpYwUBTrb0+cvHPd0eiLB/R3rhnLG6W+uGQXS+JAd8tDieKTnw2v05Noa4gwMj4BMhpg==
X-Received: by 2002:a63:d344:: with SMTP id u4mr35777777pgi.153.1582617838655;
        Tue, 25 Feb 2020 00:03:58 -0800 (PST)
Received: from Asurada (c-73-162-191-63.hsd1.ca.comcast.net. [73.162.191.63])
        by smtp.gmail.com with ESMTPSA id b18sm15964609pfd.63.2020.02.25.00.03.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Feb 2020 00:03:58 -0800 (PST)
Date:   Tue, 25 Feb 2020 00:03:50 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] ASoC: fsl_easrc: Add EASRC ASoC CPU DAI and
 platform drivers
Message-ID: <20200225080350.GA11332@Asurada>
References: <VE1PR04MB6479BCA376502F6F1251602BE3EC0@VE1PR04MB6479.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6479BCA376502F6F1251602BE3EC0@VE1PR04MB6479.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 08:53:25AM +0000, S.j. Wang wrote:
> Hi
> 
> > >
> > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > ---
> > >  sound/soc/fsl/Kconfig           |   10 +
> > >  sound/soc/fsl/Makefile          |    2 +
> > >  sound/soc/fsl/fsl_asrc_common.h |    1 +
> > >  sound/soc/fsl/fsl_easrc.c       | 2265 +++++++++++++++++++++++++++++++
> > >  sound/soc/fsl/fsl_easrc.h       |  668 +++++++++
> > >  sound/soc/fsl/fsl_easrc_dma.c   |  440 ++++++
> > 
> > I see a 90% similarity between fsl_asrc_dma and fsl_easrc_dma files.
> > Would it be possible reuse the existing code? Could share structures from
> > my point of view, just like it reuses "enum asrc_pair_index", I know
> > differentiating "pair" and "context" is a big point here though.
> > 
> > A possible quick solution for that, off the top of my head, could be:
> > 
> > 1) in fsl_asrc_common.h
> > 
> >         struct fsl_asrc {
> >                 ....
> >         };
> > 
> >         struct fsl_asrc_pair {
> >                 ....
> >         };
> > 
> > 2) in fsl_easrc.h
> > 
> >         /* Renaming shared structures */
> >         #define fsl_easrc fsl_asrc
> >         #define fsl_easrc_context fsl_asrc_pair
> > 
> > May be a good idea to see if others have some opinion too.
> > 
> 
> We need to modify the fsl_asrc and fsl_asrc_pair, let them
> To be used by both driver,  also we need to put the specific
> Definition for each module to same struct, right?

Yea. A merged structure if that doesn't look that bad. I see most
of the fields in struct fsl_asrc are being reused by in fsl_easrc.

> > 
> > > +static const struct regmap_config fsl_easrc_regmap_config = {
> > > +     .readable_reg = fsl_easrc_readable_reg,
> > > +     .volatile_reg = fsl_easrc_volatile_reg,
> > > +     .writeable_reg = fsl_easrc_writeable_reg,
> > 
> > Can we use regmap_range and regmap_access_table?
> > 
> 
> Can the regmap_range support discontinuous registers?  The
> reg_stride = 4.

I think it does. Giving an example here:
https://github.com/torvalds/linux/blob/master/drivers/mfd/da9063-i2c.c
