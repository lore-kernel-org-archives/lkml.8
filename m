Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D41AC352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 20:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CE1C2076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 20:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfKW6F7x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbgDPUYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 16:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727870AbgDPUYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 16:24:47 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1383AC03C1A7;
        Thu, 16 Apr 2020 13:15:31 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id q31so2719321qvf.11;
        Thu, 16 Apr 2020 13:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RrhoCocMui3bsFc5qkdYNErfeCVARryDRP7TYadbG5M=;
        b=QfKW6F7xCXl6+vxdlzAiOL5ivPMy1SHP4U5CM8CVeegJchb5+KDPwsbTufj449g+u4
         SD8E5bdY6BjaDM0KbK7iKkgwtLkedOn6so4ibg1BTWRdPCngH3jq4GS1rAXU0x3tqAW+
         +Z+52kZuoEnBLuNVBNWfPaISsumvknew1jf03TvmuKfwG9QZs3ABAS2cvd1he0XhnLDQ
         aeKzpcLxXOlZl4GkR6FTBIMSIghnearpfUmTipNkoasRCwGXVJ76zE+VYDzzcJFVV3tu
         IXG/BpW9slI84n6+qwgUnA2Ga9rgXPyqvF4yPDwBPGswDWoEGlWhip+xHunJQ8F1C6C2
         YMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RrhoCocMui3bsFc5qkdYNErfeCVARryDRP7TYadbG5M=;
        b=TxR6pCTybx7DLqPkCXvASkTm+yOx7i0dc6NJmog2VSZj+3AGhajz9sgFok9ha1iUXs
         RtT2iDxh3ZWF8/XcGuTUN+kKdFAEm90L/1rlx6IrsnTMFO0Qv20vZ9XtqQoTgLbOcXNv
         ReYUVdLLb+VKp33KS6OJAZbvEDnXKJS3EeiT/CrGYLagMlgnnfEGN8n8nRcmbGgsENNk
         HjXmyHiGSpuymfx8FbXewudisdAEjGXDzMQjxwJBqEVOJfVeN7cbWWZG2700+FumEDhr
         rOLDPfZz3SFZc7R5zyD6SQrv3VuVrLygedOMnm6iF/wV1JKF3tZQMhPJzUR4xcT/4ftO
         RHYA==
X-Gm-Message-State: AGi0PuYjXvJ5m3N8DRwcO/SOeJu8RuwbMRSZeGADg46s/CBi+9z2qZir
        MggCqmTbmvvtLqneYfyo1rdgbmBa/sW2+mIjYFqyq3ycFoE=
X-Google-Smtp-Source: APiQypLEw9l7W2hSliB15jHFogvAHufSRGn0ZYH76LQ8VoeRoID9myxCgGr4Pn9PvD87gHrPUOj8sgZxasNifp8qNh4=
X-Received: by 2002:a0c:f748:: with SMTP id e8mr11834286qvo.237.1587068130311;
 Thu, 16 Apr 2020 13:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200414151955.311949-1-adrian.ratiu@collabora.com>
 <20200414151955.311949-2-adrian.ratiu@collabora.com> <CAFqH_52eKB4jtmn5e4HQubv8ijOPqDqncp1dRGahhU3NOorJMQ@mail.gmail.com>
 <87lfmvjmt5.fsf@collabora.com>
In-Reply-To: <87lfmvjmt5.fsf@collabora.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 16 Apr 2020 22:15:19 +0200
Message-ID: <CAFqH_513KB+En_xbpXSBG6Q38kYxWCgw0KO3NVxCb6fqHDaKBA@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] drm: bridge: dw_mipi_dsi: add initial regmap infrastructure
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Adrian Pop <pop.adrian61@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Collabora Kernel ML <kernel@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        linux-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

[snip]

> >>
> >> +static void dw_mipi_dsi_get_hw_version(struct dw_mipi_dsi
> >> *dsi) +{ +       regmap_read(dsi->regs, DSI_VERSION,
> >> &dsi->hw_version); +       dsi->hw_version &= VERSION; +
> >> if (!dsi->hw_version) +               dev_err(dsi->dev, "Failed
> >> to read DSI hw version register\n");
> >
> > Is this an error that should be ignored? If you can't get the HW
> > version, probably, there is something wrong with your hardware
> > so, don't you need to return an error?
> >
>
> After thinking a bit more about it, that error should be a
> warning.
>
> I added it because in some cases (for eg. if the peripheral clock
> is disabled) the reads can return 0 which is obviously an invalid
> version and the bridge will error in the next step when not
> finding a layout.
>

If you'll error anyway, why wait? IIUC at this point the clock *must*
be enabled, and if not, something is wrong with the driver, I don't
see any advantage on delay the error. do you have a use case where
this is called and peripheral clock disabled?

> So I'll make this a warning in v7 and explicitely mention that
> reads version == 0 can be caused by a disabled pclk.
>

-- Enric
