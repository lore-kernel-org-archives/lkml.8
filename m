Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6051BC10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 10:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B5D2192A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 10:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SIsS5H8U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbgCKKjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 06:39:33 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42022 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbgCKKjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 06:39:32 -0400
Received: by mail-ed1-f65.google.com with SMTP id n18so2232086edw.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 03:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DxijMBuiLsxw7t2g7CXkgOmSgK6hDMEET+2/cVCHNEY=;
        b=SIsS5H8UD/WV5ztOazlBsTFhkcLn+Sd6aqlxqzxFJswOvQwDJg8Oi97FHQh9V0BBah
         KPbNTo5AVaMBj0UWgqSLWBhCe7pEYpkwPCl8Dyihpl9nyTdpwsbwGMb74soIr9cx28e/
         scRiIsLRYPj6pzdtqAxx0x9wwUBnUETEb6+0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DxijMBuiLsxw7t2g7CXkgOmSgK6hDMEET+2/cVCHNEY=;
        b=Vneyon57nyVV5IacUomVSoibTdw3Wc1bNbWbnVYZ381MdCS56LwHcZIw8SZtpinpGP
         3mrpchgW3y/08SexZeoXAJeQvn044f35AZgsLkz5d4Mp1W8b+2UGuuHpqaHw24pIVQNh
         EhMFmmHaVr13/ZW1Wboe1Mh7a/aL9UGfcqZjrSV2mIyZr96Szhym3R5DeY1TRUW/Whfp
         ohj/fvQPQVbX7p3xtzFQ9lWgLQKybC0sboC3iYgG1jI7PqJSLDeXx8X7iP0ikRmmWSqq
         GDVQWpNggUSSGmCRu41qCFtQfMWaZ9ooCuBv0aVNRHqM2X1ecpxzbcCPi/mtqYzhcYAX
         DCSw==
X-Gm-Message-State: ANhLgQ0HK+6O+4mogl9d94ZerMqUCHz2ZxdJOu3Fa2qLcAorqs87Zmy3
        TZayiWYiATuiKt71f8O2z0Vz9apIU4M=
X-Google-Smtp-Source: ADFU+vun97Wv2R4AyTElHPejTdUsP3x4SRrRJ1k/6Jc5aDTaxpslgYTUNPdMXFyDv4X0XX9PkKulJg==
X-Received: by 2002:a50:8a62:: with SMTP id i89mr2159934edi.173.1583923169728;
        Wed, 11 Mar 2020 03:39:29 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id i17sm3138551edj.72.2020.03.11.03.39.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 03:39:28 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id f7so1499947wml.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 03:39:28 -0700 (PDT)
X-Received: by 2002:a7b:c3cf:: with SMTP id t15mr3055951wmj.183.1583923167823;
 Wed, 11 Mar 2020 03:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <20191220130800.61589-1-tfiga@chromium.org> <20191220151939.GA19828@paasikivi.fi.intel.com>
In-Reply-To: <20191220151939.GA19828@paasikivi.fi.intel.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 11 Mar 2020 19:39:15 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AvAk3D34VsC3kKqHZQY9=wHHttf6_R0orEcfWsiA2PHA@mail.gmail.com>
Message-ID: <CAAFQd5AvAk3D34VsC3kKqHZQY9=wHHttf6_R0orEcfWsiA2PHA@mail.gmail.com>
Subject: Re: [PATCH] media: i2c: ov5695: Fix power on and off sequences
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dongchun Zhu <dongchun.zhu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On Sat, Dec 21, 2019 at 12:19 AM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Tomasz,
>
> On Fri, Dec 20, 2019 at 10:08:00PM +0900, Tomasz Figa wrote:
> > From: Dongchun Zhu <dongchun.zhu@mediatek.com>
> >
> > From the measured hardware signal, OV5695 reset pin goes high for a
> > short period of time during boot-up. From the sensor specification, the
> > reset pin is active low and the DT binding defines the pin as active
> > low, which means that the values set by the driver are inverted and thus
> > the value requested in probe ends up high.
> >
> > Fix it by changing probe to request the reset GPIO initialized to high,
> > which makes the initial state of the physical signal low.
> >
> > In addition, DOVDD rising must occur before DVDD rising from spec., but
> > regulator_bulk_enable() API enables all the regulators asynchronously.
> > Use an explicit loops of regulator_enable() instead.
> >
> > For power off sequence, it is required that DVDD falls first. Given the
> > bulk API does not give any guarantee about the order of regulators,
> > change the driver to use regulator_disable() instead.
> >
> > The sensor also requires a delay between reset high and first I2C
> > transaction, which was assumed to be 8192 XVCLK cycles, but 1ms is
> > recommended by the vendor. Fix this as well.
> >
> > Signed-off-by: Dongchun Zhu <dongchun.zhu@mediatek.com>
> > Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> > ---
> >  drivers/media/i2c/ov5695.c | 41 +++++++++++++++++++++-----------------
> >  1 file changed, 23 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/media/i2c/ov5695.c b/drivers/media/i2c/ov5695.c
> > index d6cd15bb699ac..8d0cc3893fcfc 100644
> > --- a/drivers/media/i2c/ov5695.c
> > +++ b/drivers/media/i2c/ov5695.c
> > @@ -971,16 +971,9 @@ static int ov5695_s_stream(struct v4l2_subdev *sd, int on)
> >       return ret;
> >  }
> >
> > -/* Calculate the delay in us by clock rate and clock cycles */
> > -static inline u32 ov5695_cal_delay(u32 cycles)
> > -{
> > -     return DIV_ROUND_UP(cycles, OV5695_XVCLK_FREQ / 1000 / 1000);
> > -}
> > -
> >  static int __ov5695_power_on(struct ov5695 *ov5695)
> >  {
> > -     int ret;
> > -     u32 delay_us;
> > +     int i, ret;
> >       struct device *dev = &ov5695->client->dev;
> >
> >       ret = clk_prepare_enable(ov5695->xvclk);
> > @@ -991,21 +984,24 @@ static int __ov5695_power_on(struct ov5695 *ov5695)
> >
> >       gpiod_set_value_cansleep(ov5695->reset_gpio, 1);
> >
> > -     ret = regulator_bulk_enable(OV5695_NUM_SUPPLIES, ov5695->supplies);
> > -     if (ret < 0) {
> > -             dev_err(dev, "Failed to enable regulators\n");
> > -             goto disable_clk;
> > +     for (i = 0; i < OV5695_NUM_SUPPLIES; i++) {
> > +             ret = regulator_enable(ov5695->supplies[i].consumer);
>
> The regulator voltage takes some time before it settles. If the hardware
> requires a particular order, then presumably there should be a small delay
> to ensure that. 1 ms should be plenty.

The regulator API guarantees that when regulator_enable() returns, the
voltage is stable. Regulator ramp up delays can be also configured via
DT to take care for per-platform variability.

>
> I also think it'd be necessary to add a comment here explaining the
> requirements for enabling regulators, as otherwise I expect someone to
> "fix" this sooner or later.

True. Let me add a comment.

>
> Same for powering off.
>

Same as above.

Best regards,
Tomasz
