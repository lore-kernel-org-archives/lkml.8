Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F344C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F9512053B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TrduBo8S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgENSVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 14:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726075AbgENSVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:21:38 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812DAC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 11:21:36 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id j127so1029945vke.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 11:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4CC+EjiVCaV9eglUZLMRyaVMzLlb5xttJb4rr/w58aE=;
        b=TrduBo8SGLShS7Y+F+1Gl/xmRgxKk9XxfiqMis12ziV7O+3W4YoTNyRdgydtd5jm5f
         OYa9M57U1T7+s45CB33iLxikQWgjQ59kyLNrAHq25Ag74KNAjFq/ZzpjTiL2nlDGbZaF
         Di/YKprVi4Nsvk/jXT0GvaMSdszXfY+ORWMrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4CC+EjiVCaV9eglUZLMRyaVMzLlb5xttJb4rr/w58aE=;
        b=nHyN0EEfIOyabtRjiylqj2Inyy7NE+b+JdKd7pCg+gE7scu1NytMuqtzdefCD2q/jg
         ln0+1C/rBSeh/ulljuYlfgzQ2y2pzSFtFVC+iktQx+Yd9evDM5Zdd0PWMwU8NvF7kwT/
         m0u+ByGstCCGyXQ0dRFr1m/sPLd7F1QeLit6cQFQMz4e2jWqdWv0c6fUdf1WryGE8iN1
         BKV3SRfvpaQdrsq+ZopjJlU17DeyJ+v7ouKlK2uMtV7bcrRpyBCytl/TxGvK/T+eu1Yn
         Qo9p2FHsPkzwFrv7yjGzXIPtampbNcltqY9EifvakZJpuxKmZvbIdbzAiAY7JbW4YjV6
         MbKA==
X-Gm-Message-State: AOAM531bCpF7UpDfeEUgxAdGSYw5U1K33kAtlUBJwCQjwnXIJmPKMOjt
        Z/iCR6mV9xXU8SGYv1uPswgxau//RnA=
X-Google-Smtp-Source: ABdhPJwqAPF3Zn1SHSpTHbsWAlbTydR2wmi2lJPIgwiNsBeTqGofEtl0fPllwS6DFvJl/CqdVfvR9g==
X-Received: by 2002:a1f:9d4f:: with SMTP id g76mr4998798vke.64.1589480494793;
        Thu, 14 May 2020 11:21:34 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id r72sm919262vkr.5.2020.05.14.11.21.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 11:21:33 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id v26so2486512vsa.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 11:21:33 -0700 (PDT)
X-Received: by 2002:a67:c40c:: with SMTP id c12mr4888979vsk.106.1589480492368;
 Thu, 14 May 2020 11:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <1589307480-27508-1-git-send-email-rbokka@codeaurora.org>
 <1589307480-27508-3-git-send-email-rbokka@codeaurora.org> <ffaccce7-95c0-2f95-ad3b-55f1da42eaee@linaro.org>
 <14e1fa51-066c-6e1b-01a4-2103612de9e9@codeaurora.org>
In-Reply-To: <14e1fa51-066c-6e1b-01a4-2103612de9e9@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 14 May 2020 11:21:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xw-ZYMrvgUTvw2uZPigrRYdVYw85Y5_vvJ+JeqV5U5iw@mail.gmail.com>
Message-ID: <CAD=FV=Xw-ZYMrvgUTvw2uZPigrRYdVYw85Y5_vvJ+JeqV5U5iw@mail.gmail.com>
Subject: Re: [RFC v1 2/3] drivers: nvmem: Add driver for QTI qfprom-efuse support
To:     "Ravi Kumar Bokka (Temp)" <rbokka@codeaurora.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        dhavalp@codeaurora.org, mturney@codeaurora.org,
        sparate@codeaurora.org, c_rbokka@codeaurora.org,
        mkurumel@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice that you didn't respond to any of my feedback [1], only
Srinivas's.  Any reason why?  It turns out that Srinivas had quite a
lot of the same feedback as I did, but please make sure you didn't
miss anything I suggested.  More inline below.

On Thu, May 14, 2020 at 5:26 AM Ravi Kumar Bokka (Temp)
<rbokka@codeaurora.org> wrote:
>
> Hi Srinivas,
> Thanks for your feedback by giving review comments. Please find my
> inline comments.
>
>
> Regards,
> Ravi Kumar.B
>
> On 5/13/2020 6:50 PM, Srinivas Kandagatla wrote:
> >
> >
> > On 12/05/2020 19:17, Ravi Kumar Bokka wrote:
> >> This patch adds new driver for QTI qfprom-efuse controller. This
> >> driver can
> >> access the raw qfprom regions for fuse blowing.
> >
> > QTI?
>
> guidance I have received from internal Legal/LOST team is that the QCOM
> prefix needs to be changed to QTI everywhere it is used

I'll let Srinivas comment if he cares.  I'm really not sure why a
legal team cares about the Kconfig name in a GPL-licensed Linux
kernel.


> >> The current existed qfprom driver is only supports for cpufreq,
> >> thermal sensors
> >> drivers by read out calibration data, speed bins..etc which is stored
> >> by qfprom efuses.
> >
> > Can you explain bit more about this QFPROM instance, Is this QFPROM par=
t
> > of secure controller address space?
> > Is this closely tied to SoC or Secure controller version?
> >
> > Any reason why this can not be integrated into qfprom driver with
> > specific compatible.
> >
>
> QFPROM driver communicates with sec_controller address space however
> scope and functionalities of this driver is different and not limited as
> existing qfprom fuse Read-Only driver for specific =E2=80=9Cfuse buckets=
=E2=80=99 like
> cpufreq, thermal sensors etc. QFPROM fuse write driver in this patch
> requires specific sequence to write/blow fuses unlike other driver.
> Scope/functionalities are different and this is separate driver.

If the underlying IP blocks are the same it should be one driver and
it should just work in read-only mode for the other range of stuff.


> >> Signed-off-by: Ravi Kumar Bokka <rbokka@codeaurora.org>
> >> ---
> >>   drivers/nvmem/Kconfig        |  10 +
> >>   drivers/nvmem/Makefile       |   2 +
> >>   drivers/nvmem/qfprom-efuse.c | 476
> >> +++++++++++++++++++++++++++++++++++++++++++
> >>   3 files changed, 488 insertions(+)
> >>   create mode 100644 drivers/nvmem/qfprom-efuse.c
> >>
> > ...
> >
> >> diff --git a/drivers/nvmem/qfprom-efuse.c b/drivers/nvmem/qfprom-efuse=
.c
> >> new file mode 100644
> >> index 0000000..2e3c275
> >> --- /dev/null
> >> +++ b/drivers/nvmem/qfprom-efuse.c
> >> @@ -0,0 +1,476 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/*
> >> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> >> + */
> >> +
> >> +#include <linux/clk.h>
> >> +#include <linux/device.h>
> >> +#include <linux/io.h>
> >> +#include <linux/iopoll.h>
> >> +#include <linux/kernel.h>
> >> +#include <linux/module.h>
> >> +#include <linux/mod_devicetable.h>
> >> +#include <linux/nvmem-provider.h>
> >> +#include <linux/of_device.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/regulator/consumer.h>
> >> +
> >> +#define QFPROM_BLOW_STATUS_BUSY 0x1
> >> +#define QFPROM_BLOW_STATUS_READY 0x0
> >> +
> >> +/* Blow timer clock frequency in Mhz for 10nm LPe technology */
> >> +#define QFPROM_BLOW_TIMER_OFFSET 0x03c
> >> +#define QFPROM_BLOW_TIMER_RESET_VALUE 0x0
> >> +
> >> +/* Amount of time required to hold charge to blow fuse in
> >> micro-seconds */
> >> +#define QFPROM_FUSE_BLOW_POLL_PERIOD 100
> >> +#define QFPROM_BLOW_STATUS_OFFSET 0x048
> >> +
> >> +#define QFPROM_ACCEL_OFFSET 0x044
> >> +
> >> +/**
> >> + * struct qfprom_efuse_platform_data - structure holding qfprom-efuse
> >> + * platform data
> >> + *
> >> + * @name: qfprom-efuse compatible name
> >
> > ??
>
> Thanks for your feedback. I will address this change
>
> >> + * @fuse_blow_time_in_us: Should contain the wait time when doing the
> >> fuse blow
> >> + * @accel_value: Should contain qfprom accel value
> >> + * @accel_reset_value: The reset value of qfprom accel value
> >> + * @qfprom_blow_timer_value: The timer value of qfprom when doing
> >> efuse blow
> >> + * @qfprom_blow_reset_freq: The frequency required to set when fuse
> >> blowing
> >> + * is done
> >> + * @qfprom_blow_set_freq: The frequency required to set when we start
> >> the
> >> + * fuse blowing
> >> + * @qfprom_max_vol: max voltage required to set fuse blow
> >> + * @qfprom_min_vol: min voltage required to set fuse blow
> >
> > How specific are these values per SoC?
> >
>
> This voltage level may change based on SoC and/or fuse-hardware
> technology, it would change for SoC with different technology, hence we
> have kept it in SOC specific settings.

Generally I'd expect the SoC specific settings to be in the device
tree.  Drivers don't need to specify this.  Please respond to the
comments I posed in my review.


> >> + */
> >> +struct qfprom_efuse_platform_data {
> >> +    const char *name;
> >> +    u8 fuse_blow_time_in_us;
> >> +    u32 accel_value;
> >> +    u32 accel_reset_value;
> >> +    u32 qfprom_blow_timer_value;
> >> +    u32 qfprom_blow_reset_freq;
> >> +    u32 qfprom_blow_set_freq;
> >> +    u32 qfprom_max_vol;
> >> +    u32 qfprom_min_vol;
> >> +};
> >> +
> >> +/**
> >> + * struct qfprom_efuse_priv - structure holding qfprom-efuse attribut=
es
> >> + *
> >> + * @qfpbase: iomapped memory space for qfprom base
> >> + * @qfpraw: iomapped memory space for qfprom raw fuse region
> >> + * @qfpmap: iomapped memory space for qfprom fuse blow timer
> >> +
> >> + * @dev: qfprom device structure
> >> + * @secclk: clock supply
> >> + * @vcc: regulator supply
> >> +
> >> + * @qfpraw_start: qfprom raw fuse start region
> >> + * @qfpraw_end: qfprom raw fuse end region
> >> + * @qfprom_efuse_platform_data: qfprom platform data
> >> + */
> >> +struct qfprom_efuse_priv {
> >> +    void __iomem *qfpbase;
> >> +    void __iomem *qfpraw;
> >> +    void __iomem *qfpmap;
> >
> > Why are these memory regions split? Can't you just have complete qfprom
> > area and add fixed offset for qfpraw within the driver?
> >
>
> Thanks for your feedback. I will address this change.
> I have separated this memory regions because to identify raw fuse
> regions separately and compare these raw fuse regions from the user
> given input.

How are you addressing?  Can you go back to just having one range?  If
you need to know where the raw fuse region is inside your range just
put the offset in the of_match data.


> >> +    struct device *dev;
> >> +    struct clk *secclk;
> >> +    struct regulator *vcc;
> >> +    resource_size_t qfpraw_start;
> >> +    resource_size_t qfpraw_end;
> > Why do we need to check this range? as long as we set the nvmem_config
> > with correct range then you should not need this check.
> >
>
> There is no harm in this explicit check in QFPROM-fuse driver and based
> on internal review with our security team, this check is important to
> avoid dependency on other upper layer.

There is harm: it adds extra complexity.  Please remove.

You are talking as if it was somehow important for this code to be the
same as the code on other OSes / in other contexts.  It isn't.  This
is a Linux driver and it should not be written to duplicate stuff that
Linux is already doing.


> >> +    struct qfprom_efuse_platform_data efuse;
> > A pointer here should be good enough?
> >> +};
> >> +
> >
>
> Thanks for your feedback. I will address this change
>
> > ...
> >
> >> +/*
> >> + * sets the value of the blow timer, accel register and the clock
> >> + * and voltage settings
> >> + */
> >> +static int qfprom_enable_fuse_blowing(const struct qfprom_efuse_priv
> >> *priv)
> >> +{
> >> +    int ret;
> >> +
> >> +    ret =3D qfprom_disable_fuse_blowing(priv);
> >> +    if (ret) {
> >> +        dev_err(priv->dev, "qfprom_disable_fuse_blowing()\n");
> >> +        return ret;
> >> +    }
> >
> > Why do we need to qfprom_disable_fuse_blowing() for every call to enabl=
e
> > it?
> >
> > Or are we missing some error handling in the caller?
> >
>
> We must disable/vote-off this QFPROM fuse power rail after blowing fuse,
> it is the safe and right approach as per hardware programming guide for
> fuse blowing process. Caller here is user space, can=E2=80=99t control
> fuse-power-rail or can=E2=80=99t be relied to follow the required process=
. There
> could also be unnecessary risk of leaving the vote/power-rail configured
> at specific level after blowing the fuse. As per hardware requirement,
> right after fuse blowing, we need to disable power rail.

Please remove your disable here.  Though the user initiates the call
you can still rely on Linux to make sure two users aren't trying to
blow fuses at the same time.  The Linux driver should always leave
things in a "disabled" state and you can rely on that.

...besides the only way you aren't hitting an underflow on the
regulator enable count is that you are constantly enabling over and
over again.


> >> +
> >> +    writel(priv->efuse.qfprom_blow_timer_value, priv->qfpmap +
> >> +           QFPROM_BLOW_TIMER_OFFSET);
> >> +    writel(priv->efuse.accel_value, priv->qfpmap + QFPROM_ACCEL_OFFSE=
T);
> >> +
> >> +    ret =3D qfprom_set_clock_settings(priv);
> >> +    if (ret) {
> >> +        dev_err(priv->dev, "qpfrom_set_clock_settings()\n");
> >> +        return ret;
> >> +    }
> >> +
> >> +    ret =3D qfprom_set_voltage_settings(priv, priv->efuse.qfprom_min_=
vol,
> >> +                      priv->efuse.qfprom_max_vol);
> >> +    if (ret) {
> >> +        dev_err(priv->dev, "qfprom_set_voltage_settings()\n");
> >> +        return ret;
> >> +    }
> >> +
> >> +    return 0;
> >> +}
> >> +
> >
> > <<
> >> +/*
> >> + * verifying to make sure address being written or read is from qfpro=
m
> >> + * raw address range
> >> + */
> >> +bool addr_in_qfprom_range(const struct qfprom_efuse_priv *priv, u32 r=
eg,
> >> +              size_t bytes)
> >> +{
> >> +    if (((reg + bytes) > reg) && (reg >=3D priv->qfpraw_start) &&
> >> +        ((reg + bytes) <=3D priv->qfpraw_end)) {
> >> +        return 1;
> >> +    }
> >> +
> >> +    return 0;
> >> +}
> >  >>
> > Above function is totally redundant, nvmem core already has checks for
> > this.
> >
>
> There is no harm in this explicit check in QFPROM-fuse driver and based
> on internal review with our security team, this check is important to
> avoid dependency on other upper layer.

Please remove.  You are a Linux driver.


> >> +
> >> +/*
> >> + * API for reading from raw qfprom region
> >> + */
> >> +static int qfprom_efuse_reg_read(void *context, unsigned int reg,
> >> void *_val,
> >> +                 size_t bytes)
> >> +{
> >> +    struct qfprom_efuse_priv *priv =3D context;
> >> +    u32 *value =3D _val;
> >> +    u32 align_check;
> >> +    int i =3D 0, words =3D bytes / 4;
> >> +
> >> +    dev_info(priv->dev,
> >> +         "reading raw qfprom region offset: 0x%08x of size: %zd\n",
> >> +         reg, bytes);
> >
> > In general there is lot of debug info across the code, do you really
> > need all this? Consider removing these!
> >
>
> Thanks for your feedback. I will address this change.
>
> >> +
> >> +    if (bytes % 4 !=3D 0x00) {
> >> +        dev_err(priv->dev,
> >> +            "Bytes: %zd to read should be word align\n",
> >> +            bytes);
> >> +        return -EINVAL;
> >> +    }
> >
> > This word align check is also redundant once you set nvmem_config with
> > correct word_size.
> >
>
> I understand that there may be different approach to handle this. We
> have used this approach and tested this driver thoroughly. Unless there
> is technical limitation, changing this word_size would end up requiring
> re-writing write/read APIs and going through testing again, there is not
> much difference in either approach, we would like to keep this approach
> unless there is technical concern.

The driver isn't done until it lands in Linux.  While it's important
to test the driver before posting upstream it is completely expected
and normal that then posting upstream you will be asked to change
things.  After you change things you will need to re-test.  The fact
that you already tested this the old way is not an excuse.  Please
fix.


> >> +
> >> +    if (!addr_in_qfprom_range(priv, reg, bytes)) {
> >> +        dev_err(priv->dev,
> >> +            "Invalid qfprom raw region offset 0x%08x & bytes %zd\n",
> >> +            reg, bytes);
> >> +        return -EINVAL;
> >> +    }
> >> +
> >> +    align_check =3D (reg & 0xF);
> >> +
> >> +    if (((align_check & ~3) =3D=3D align_check) && value !=3D NULL)
> >> +        while (words--)
> >> +            *value++ =3D readl(priv->qfpbase + reg + (i++ * 4));
> >> +
> >> +    else
> >> +        dev_err(priv->dev,
> >> +            "Invalid input parameter 0x%08x fuse blow address\n",
> >> +            reg);
> >> +
> >> +    return 0;
> >> +}
> > ...
> >
> >> +
> >> +static int qfprom_efuse_probe(struct platform_device *pdev)
> >> +{
> >> +    struct device *dev =3D &pdev->dev;
> >> +    struct resource *qfpbase, *qfpraw, *qfpmap;
> >> +    struct nvmem_device *nvmem;
> >> +    struct nvmem_config *econfig;
> >> +    struct qfprom_efuse_priv *priv;
> >> +    const struct qfprom_efuse_platform_data *drvdata;
> >> +    int ret;
> >> +
> >> +    dev_info(&pdev->dev, "[%s]: Invoked\n", __func__);
> >> +
> >
> > too much debug!
> >
>
> Thanks for your feedback. I will address this change.
>
> >> +    drvdata =3D of_device_get_match_data(&pdev->dev);
> >> +    if (!drvdata)
> >> +        return -EINVAL;
> > Unnecessary check as this driver will not be probed unless there is a
> > compatible match.
> >
>
> Thanks for your feedback. I will address this change.
>
> >
> >> +
> >> +    priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> >> +    if (!priv)
> >> +        return -ENOMEM;
> >> +
> >> +    priv->efuse.fuse_blow_time_in_us =3D drvdata->fuse_blow_time_in_u=
s;
> >> +    priv->efuse.accel_value =3D drvdata->accel_value;
> >> +    priv->efuse.accel_reset_value =3D drvdata->accel_reset_value;
> >> +    priv->efuse.qfprom_blow_timer_value =3D
> >> drvdata->qfprom_blow_timer_value;
> >> +    priv->efuse.qfprom_blow_reset_freq =3D
> >> drvdata->qfprom_blow_reset_freq;
> >> +    priv->efuse.qfprom_blow_set_freq =3D drvdata->qfprom_blow_set_fre=
q;
> >> +    priv->efuse.qfprom_max_vol =3D drvdata->qfprom_max_vol;
> >> +    priv->efuse.qfprom_min_vol =3D drvdata->qfprom_min_vol;
> >> +    priv->dev =3D dev;
> >> +
> >> +    qfpbase =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >> +
> >> +    priv->qfpbase =3D devm_ioremap_resource(dev, qfpbase);
> >> +    if (IS_ERR(priv->qfpbase)) {
> >> +        ret =3D PTR_ERR(priv->qfpbase);
> >> +        goto err;
> >> +    }
> >> +
> >> +    qfpraw =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
> >> +
> >> +    priv->qfpraw =3D devm_ioremap_resource(dev, qfpraw);
> >> +    if (IS_ERR(priv->qfpraw)) {
> >> +        ret =3D PTR_ERR(priv->qfpraw);
> >> +        goto err;
> >> +    }
> >> +
> >> +    priv->qfpraw_start =3D qfpraw->start - qfpbase->start;
> >> +    priv->qfpraw_end =3D qfpraw->end - qfpbase->start;
> >> +
> >> +    qfpmap =3D platform_get_resource(pdev, IORESOURCE_MEM, 2);
> >> +
> >> +    priv->qfpmap =3D devm_ioremap_resource(dev, qfpmap);
> >> +    if (IS_ERR(priv->qfpmap)) {
> >> +        ret =3D PTR_ERR(priv->qfpmap);
> >> +        goto err;
> >> +    }
> >> +
> >> +    priv->vcc =3D devm_regulator_get(&pdev->dev, "vcc");
> >
> > I see no reference to this regulator in dt bindings.
>
> This perameter kept in board specific file i.e., sc7180-idp.dts file

Yes, but it still needs to be in the bindings.


> >> +    if (IS_ERR(priv->vcc)) {
> >> +        ret =3D PTR_ERR(priv->vcc);
> >> +        if (ret =3D=3D -ENODEV)
> >> +            ret =3D -EPROBE_DEFER;
> > Can you explain what is going on here?
> >
>
> As i took other drivers reference, i have kept this check.

Then other drivers are wrong.  Please remove.


> >> +
> >> +        goto err;
> >> +    }
> >> +
> >> +    priv->secclk =3D devm_clk_get(dev, "secclk");
> >> +    if (IS_ERR(priv->secclk)) {
> >> +        ret =3D PTR_ERR(priv->secclk);
> >> +        if (ret !=3D -EPROBE_DEFER)
> >> +            dev_err(dev, "secclk error getting : %d\n", ret);
> >> +        goto err;
> >> +    }
> >> +
> >> +    ret =3D clk_prepare_enable(priv->secclk);
> >> +    if (ret) {
> >> +        dev_err(dev, "clk_prepare_enable() failed\n");
> >> +        goto err;
> >> +    }
> >> +
> >> +    econfig =3D devm_kzalloc(dev, sizeof(*econfig), GFP_KERNEL);
> >> +    if (!econfig)
> > Why not disabling the clk here?
> >> +        return -ENOMEM;
> >
>
> Thanks for your feedback. I will address this change.
>
> >> +
> >> +    econfig->dev =3D dev;
> >> +    econfig->name =3D "qfprom-efuse";
> >> +    econfig->stride =3D 1;
> >> +    econfig->word_size =3D 1;
> >> +    econfig->reg_read =3D qfprom_efuse_reg_read;
> >> +    econfig->reg_write =3D qfprom_efuse_reg_write;
> >> +    econfig->size =3D resource_size(qfpraw);
> >> +    econfig->priv =3D priv;
> >> +
> >> +    nvmem =3D devm_nvmem_register(dev, econfig);
> >> +
> >> +    return PTR_ERR_OR_ZERO(nvmem);
> > probably you should check the nvmem here before returning to disable th=
e
> > clk properly.
> >
>
> Thanks for your feedback. I will address this change.
>
> >> +
> >> +err:
> >> +    clk_disable_unprepare(priv->secclk);
> >> +    return ret;
> >> +}
> >> +
> >> +static const struct qfprom_efuse_platform_data sc7180_qfp_efuse_data =
=3D {
> >> +    .name =3D "sc7180-qfprom-efuse",
> > Redundant.
> >
>
> Thanks for your feedback. I will address this change.
>
> >> +    .fuse_blow_time_in_us =3D 10,
> >> +    .accel_value =3D 0xD10,
> >> +    .accel_reset_value =3D 0x800,
> >> +    .qfprom_blow_timer_value =3D 25,
> >> +    .qfprom_blow_reset_freq =3D 19200000,
> >> +    .qfprom_blow_set_freq =3D 4800000,
> >> +    .qfprom_max_vol =3D 1904000,
> >> +    .qfprom_min_vol =3D 1800000,
> >> +};
> >> +
> >> +static const struct of_device_id qfprom_efuse_of_match[] =3D {
> >> +    {
> >> +        .compatible =3D "qcom,sc7180-qfprom-efuse",
> >> +        .data =3D &sc7180_qfp_efuse_data
> >> +    },
> >> +    {/* sentinel */},
> >> +};
> >> +
> >> +MODULE_DEVICE_TABLE(of, qfprom_efuse_of_match);
> >> +
> >> +static struct platform_driver qfprom_efuse_driver =3D {
> >> +    .probe =3D qfprom_efuse_probe,
> >> +    .driver =3D {
> >> +        .name =3D "sc7180-qfprom-efuse",
> >> +        .of_match_table =3D qfprom_efuse_of_match,
> >> +    },
> >> +};
> >> +
> >> +module_platform_driver(qfprom_efuse_driver);
> >> +MODULE_DESCRIPTION("QTI QFPROM Efuse driver");
> >> +MODULE_LICENSE("GPL v2");
> >>
>
> --
> Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
> member of the Code Aurora Forum, hosted by the Linux Foundation.

[1] https://lore.kernel.org/r/CAD=3DFV=3DUZQRfBTbh2CLnwsRSpbXFf=3D8iF2MG20h=
dj47s42aP8HQ@mail.gmail.com
