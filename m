Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBC3C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 11:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EACE7206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 11:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ahVcX9y0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgEFLas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 07:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726356AbgEFLar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 07:30:47 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6517EC061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 04:30:47 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id m13so1034922otf.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 04:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i/mnRlrL4hTk5ZWZZBpQB+A2vYhFKnlQEEPlCkWsPZE=;
        b=ahVcX9y0875VtYAfqeLGE8/rEUacYR6cv0gOwEAGAK2TtEt3EZqIgzdUxj8+oqmEtg
         x9e9VKyqjWNyJMH3BbsQqcIEjgMedce3ldo/d88jKQw534PPBjFG3b1ecntQ/L+MSrcl
         ZSsO+EEouEiGHHSZtucCvwmF6m6HWcUfia96aiIq5kRGKvsJhToKu+3nBY4adWL1wQj9
         Zgu3L2lTon+z/3KU5UDDwaKQWxILJ9o47N4Yzpd9MGuGXRq/E0gFe5pgMh3uEVm/hpkD
         otLpeiuEMsLF4/Qq9XuYwSDdlDq6/9PsatWSJf8CRiWCWwW7t7ejcu+eVg5Gn6WRWeku
         k3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i/mnRlrL4hTk5ZWZZBpQB+A2vYhFKnlQEEPlCkWsPZE=;
        b=jSPgcNMVGnNS70CRntsOLO/BgPG2AJHTcoTx6ZIlW4zE7dqGC2YPZ8mL20qOej0zCu
         2Y5/YokTZf5sTtjfUMHKl8AsiKWPzbkjgODKxLIV1HyjsqeebamVadeoBihOg2IfJKvS
         XS0Ts2D6qOlO23fDlS5Tr/xkc/1fTiP7EzHAfKAtBimKLAHi0jscx7obLf6P0oDeKdZp
         W0FGwHbMEFdeSon8Fs/1fgV1AT+v1e2IONb7/AEPV8XOfK3wPtv14zKiJrO9++JyQiq6
         22zf0ACpLwlj4k8Es4tPAaigMyEpfyWop5Ck/9S3ahMUCKftd77/pZOsCB75lOipTwG7
         zWYA==
X-Gm-Message-State: AGi0PuZqGdfuxptiy9BuCR66QzqyOt163eU1+Sx00T1Tc//XYpCSsVBf
        mxd59RbZfGSD5R4MBTlVfZsDuBq4ax9aF2vCWOLY6g==
X-Google-Smtp-Source: APiQypI10Opg1+VL0qGtAj9swPO65KogncWTx9LO8yV8j8xz4TIqaR59fBT2pvHi/zHAbFL61M3nNSKybpyU+5oO17k=
X-Received: by 2002:a9d:7645:: with SMTP id o5mr5754004otl.272.1588764646808;
 Wed, 06 May 2020 04:30:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200505100129.104673-1-robert.foss@linaro.org>
 <20200505100129.104673-2-robert.foss@linaro.org> <20200505154913.GA17438@bogus>
In-Reply-To: <20200505154913.GA17438@bogus>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 6 May 2020 13:30:35 +0200
Message-ID: <CAG3jFytNwG0tZJnf-qCGEzY_cXucMDYxmCn8z4QW+EHrab8m_A@mail.gmail.com>
Subject: Re: [PATCH v10 1/3] media: dt-bindings: ov8856: Document YAML bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Maxime Ripard <maxime@cerno.tech>,
        linux-media <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Maxime Ripard <mripard@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>, Ben Kao <ben.kao@intel.com>,
        Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Rob!

On Tue, 5 May 2020 at 17:49, Rob Herring <robh@kernel.org> wrote:
>
> On Tue,  5 May 2020 12:01:29 +0200, Robert Foss wrote:
> > From: Dongchun Zhu <dongchun.zhu@mediatek.com>
> >
> > This patch adds documentation of device tree in YAML schema for the
> > OV8856 CMOS image sensor.
> >
> > Signed-off-by: Dongchun Zhu <dongchun.zhu@mediatek.com>
> > Signed-off-by: Robert Foss <robert.foss@linaro.org>
> > Reviewed-by: Maxime Ripard <mripard@kernel.org>
> > ---
> >
> > - Changes since v9:
> >   * Remove remote-endpoint property
> >   * Marco: Make port property required again
> >   * Sakari: Remove Ben as a maintainer
> >   * Sakari: Replace data-lanes with const items
> >   * Sakari: Remove clock-lanes property
> >   * Sakari & Rob Herring: Change type of link-frequency
> >     work around dt-schema bug
> >
> > - Changes since v8:
> >   * Maxime: Added r-b
> >
> > - Changes since v7:
> >   * Marco: Make 'port' property optional
> >   * Maxime & Sakari: Add 'link-frequencies' property to dt binding
> >   * robher: Improve description for 'port' property
> >
> > - Changes since v6:
> >   * Marco: remove qcom specifics from DT example
> >
> > - Changes since v5:
> >   * Add assigned-clocks and assigned-clock-rates
> >   * robher: dt-schema errors
> >
> > - Changes since v4:
> >   * Fabio: Change reset-gpio to GPIO_ACTIVE_LOW, explain in description
> >   * Add clock-lanes property to example
> >   * robher: Fix syntax error in devicetree example
> >
> > - Changes since v3:
> >   * robher: Fix syntax error
> >   * robher: Removed maxItems
> >   * Fixes yaml 'make dt-binding-check' errors
> >
> > - Changes since v2:
> >
> > - Changes since v1:
> >   Fixes comments from Sakari, Tomasz
> >   * Add clock-frequency and link-frequencies in DT
> >
> >  .../devicetree/bindings/media/i2c/ov8856.yaml | 142 ++++++++++++++++++
> >  MAINTAINERS                                   |   1 +
> >  2 files changed, 143 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/i2c/ov8856.yaml
> >
>
> Reviewed-by: Rob Herring <robh@kernel.org>
