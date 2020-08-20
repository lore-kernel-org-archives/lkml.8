Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B546C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 19:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D4E3207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 19:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UWsCN7ZH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgHTT1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 15:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHTT1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 15:27:12 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CABFC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 12:27:11 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id m34so1599351pgl.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 12:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qKgKzXlPm6LlH3TbAFNrfgNmPXIVx+pBSmSBh3BlDpQ=;
        b=UWsCN7ZHQMvpNR61FNwCDzsjQMvWe6z3zaWJDySvgM4qXJ2owLnhOmarFsydiJefHl
         mDOA211lJBz+xb0hnkIYj4LlBhKFpo+A3Fbev9eGS7j3zbuAEtnSe964H/tnXlBeEhtx
         bndqvASP4kmEsMAvVUvD+VV369LU6QcLbwLjiEdcsW4h5cYGvg5tOA7vBJ2pwplx8Q/T
         prJmHDO7Cv649ZkSCOwz1tl4ClMdYHNUQpI6sPTEa4zmWHZBTDvvg+oiG6SxAdAbjEwR
         Hwwa2sMzIQpY7dp4emZy+lXP7J4nBQfNXGNPfDSuzWbIEt/+8X3UZj9nTFJnZUJrW9MD
         /Aaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qKgKzXlPm6LlH3TbAFNrfgNmPXIVx+pBSmSBh3BlDpQ=;
        b=OJc9i5JVWvd9+jk/0azubvjQ1LFWLSBYBaNhXTBnBz0jLg/55nC5yvuZqE1cHRy9Uq
         HPr4vRUFBqag/n9Gxipx00IiT45ZFQmUbA7wq6uXla9yzEUSmD00iC3OYeS/jMRTcL9G
         76fdoeekdaQL9YPiycDlmkTroMHnZjcJFSUHEXSbXBjpEAfaWrjmmAhl8mZhCO8ZiObC
         fBJmwX8WNqB7cP0iaTr9gYodTr82UBKHWAy3CbSmccIaj9TK85AoFmUZeWdymP+FnUQb
         W+kXReGOv29pEmmAAMa4xGa/xkkE7dGwNGpq8R8iMzfFfN5noA3vh1oxrAGHjE4FlZXj
         SgkQ==
X-Gm-Message-State: AOAM530jDtbdnZlwlt6+g/IEkfVI48tb1shf1rO87opmCXB+smvUa4g8
        F/ksJA/pZcy4uhCgaPkHaq0vfg==
X-Google-Smtp-Source: ABdhPJxpcaQBmyqJzVhRAz2xEFhbGD8umb7dYhhPDrVdIuIn+UoqxIHj92yxXw+U4tTEBt4uqrmX6g==
X-Received: by 2002:a62:e704:: with SMTP id s4mr183082pfh.177.1597951630770;
        Thu, 20 Aug 2020 12:27:10 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id gj2sm2781576pjb.21.2020.08.20.12.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 12:27:10 -0700 (PDT)
Date:   Thu, 20 Aug 2020 13:27:08 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 04/10] remoteproc: imx_rproc: make syscon optional
Message-ID: <20200820192708.GA3938186@xps15>
References: <20200724080813.24884-1-peng.fan@nxp.com>
 <20200724080813.24884-5-peng.fan@nxp.com>
 <20200818214350.GA3822080@xps15>
 <DB6PR0402MB276017AA0C124172D9BC3483885D0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <20200819194504.GB3845366@xps15>
 <DB6PR0402MB2760B72DA179BED8434690E1885A0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB6PR0402MB2760B72DA179BED8434690E1885A0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 02:04:10AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH 04/10] remoteproc: imx_rproc: make syscon optional
> > 
> > On Wed, Aug 19, 2020 at 12:51:27AM +0000, Peng Fan wrote:
> > > > Subject: Re: [PATCH 04/10] remoteproc: imx_rproc: make syscon
> > > > optional
> > > >
> > > > Hi Peng,
> > > >
> > > > On Fri, Jul 24, 2020 at 04:08:07PM +0800, Peng Fan wrote:
> > > > > Make syscon optional, since i.MX8QM/QXP/7ULP not have SRC to
> > > > > control
> > > > M4.
> > > > > But currently i.MX8QM/QXP/7ULP not added, so still check regmap
> > > > > when start/stop to avoid unhappy things.
> > > >
> > > > On the i.MX8QM/QXP/7ULP processors, the remote processors are not
> > > > handled by the remoteproc cores, as implemented in this patch.  In
> > > > such a scenario how does the remoteproc core know the remote
> > > > processor has crashed and how does it recover from such a condition?
> > >
> > > For 7ULP dual boot case, A7 is under control of M4, so if m4 crash, I
> > > suppose
> > > A7 would not work properly.
> > 
> > In that case I assume the whole system gets rebooted, which puts the A7 in a
> > state where it can "attach" with the M4 again.
> 
> Yes. Whole system get rebooted.
> 
> > 
> > >
> > > For 8QM/QXP partition case, M4 is in a standalone partition, if M4
> > > crash or reboot, the system controller unit will restart M4 and notify
> > > Acore that M4 restart.
> > 
> > And how does that notification work exactly?  Does rproc_report_crash() get
> > called somewhere in that process in order for the remoteproc core to attach
> > to the M4 again?
> 
> Yes. We registered a interrupt notification handler with system controller unit.
> When M4 rebooted, the system controller will raise interrupt to A53 core.
> Then the notification callback will be invoked, the callback will call
> rproc_report_crash. I not included this part code in the patchset, since
> this patchset is to add initial support for 8M case.

All this information is really appreciated.

> 
> Thanks,
> Peng.
> 
> > 
> > Many thanks for the help,
> > Mathieu
> > 
> > >
> > > Thanks,
> > > Peng.
> > >
> > > >
> > > > Thanks,
> > > > Mathieu
> > > >
> > > > >
> > > > > Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > > ---
> > > > >  drivers/remoteproc/imx_rproc.c | 11 +++++++++--
> > > > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/remoteproc/imx_rproc.c
> > > > > b/drivers/remoteproc/imx_rproc.c index 82594a800a1b..4fad5c0b1c05
> > > > > 100644
> > > > > --- a/drivers/remoteproc/imx_rproc.c
> > > > > +++ b/drivers/remoteproc/imx_rproc.c
> > > > > @@ -162,6 +162,9 @@ static int imx_rproc_start(struct rproc *rproc)
> > > > >  	struct device *dev = priv->dev;
> > > > >  	int ret;
> > > > >
> > > > > +	if (!priv->regmap)
> > > > > +		return -EOPNOTSUPP;
> > > > > +
> > > > >  	ret = regmap_update_bits(priv->regmap, dcfg->src_reg,
> > > > >  				 dcfg->src_mask, dcfg->src_start);
> > > > >  	if (ret)
> > > > > @@ -177,6 +180,9 @@ static int imx_rproc_stop(struct rproc *rproc)
> > > > >  	struct device *dev = priv->dev;
> > > > >  	int ret;
> > > > >
> > > > > +	if (!priv->regmap)
> > > > > +		return -EOPNOTSUPP;
> > > > > +
> > > > >  	ret = regmap_update_bits(priv->regmap, dcfg->src_reg,
> > > > >  				 dcfg->src_mask, dcfg->src_stop);
> > > > >  	if (ret)
> > > > > @@ -325,9 +331,10 @@ static int imx_rproc_probe(struct
> > > > > platform_device
> > > > *pdev)
> > > > >  	regmap = syscon_regmap_lookup_by_phandle(np, "syscon");
> > > > >  	if (IS_ERR(regmap)) {
> > > > >  		dev_err(dev, "failed to find syscon\n");
> > > > > -		return PTR_ERR(regmap);
> > > > > +		regmap = NULL;
> > > > > +	} else {
> > > > > +		regmap_attach_dev(dev, regmap, &config);
> > > > >  	}
> > > > > -	regmap_attach_dev(dev, regmap, &config);
> > > > >
> > > > >  	/* set some other name then imx */
> > > > >  	rproc = rproc_alloc(dev, "imx-rproc", &imx_rproc_ops,
> > > > > --
> > > > > 2.16.4
> > > > >
