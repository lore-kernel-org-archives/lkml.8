Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B54AC2D0F8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 23:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DB6520740
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 23:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RJkM1fsp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731237AbgELXDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 19:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELXDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 19:03:08 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9B6C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 16:03:07 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id k13so5030816uap.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 16:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VVGG3CRHq+jMPhSKNQacjB20sK+W6r3eGE6m484RvIg=;
        b=RJkM1fsp1d0B3ymLQFCkSuuxeC/0Hh3BOrNNFdhaIYDLyQwhKMBk4toh9+zPGZOYJq
         gd6WOJxQ+arvAXu7ehjEJKJROp5rpoPHQwGiGJ81dI2tdwrK0ugEBYiUNQOQvkxelUM/
         UPHwRSxDH4HEaFvLkToHrX3+aTs93E8lWpsaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VVGG3CRHq+jMPhSKNQacjB20sK+W6r3eGE6m484RvIg=;
        b=TCMdDGn8ptP0mkoQik3vJw4YYch6ZR/kzxQrb/kaGylJaBHIPhbf3bNoWaiSwKm1mp
         xJ+gCnw3Pp798LFuNsVRnyWDg47eImuWYiGMksfA843GmrRHv3mwptN23UvoG+dloufx
         SZqM9EVj/3bXGee903QXE0jWhq2mrVPjTYlXddYsagYNrpia5+GmzU7iRMf40+uIdNv6
         vZuiWg4L1Dr1wdK6FnGhRrCcFdX4a5XVXqsSrLKgYkKQchUujsp9G6o0PqOym7TS8q8N
         ABmEhEh0/czVSleswn1WT2XIXD3XUm72A9Iaz3p1MchAFvgqT+zyK1FuBlc1WbFjAfUL
         0Tyw==
X-Gm-Message-State: AGi0PuZn/FjFPO0N6bXke50byu6ln87OeYZ9dMwdpgB+gLiFCSvniyUh
        b/qxUnKSOmaq9A4M9RxHVR95mLQLa4E=
X-Google-Smtp-Source: APiQypKBVk+6IIA5WzebQZYVCh+POXOc2Ulejmvhrs/2ZVrJgOmEvVF7LyvFAQ74g127Hlwt6L9VVw==
X-Received: by 2002:ab0:375a:: with SMTP id i26mr17874845uat.120.1589324585916;
        Tue, 12 May 2020 16:03:05 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id a18sm303794vsp.10.2020.05.12.16.03.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 16:03:04 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id s11so8966144vsm.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 16:03:04 -0700 (PDT)
X-Received: by 2002:a05:6102:4d:: with SMTP id k13mr17522823vsp.198.1589324583765;
 Tue, 12 May 2020 16:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <1589307480-27508-1-git-send-email-rbokka@codeaurora.org> <1589307480-27508-3-git-send-email-rbokka@codeaurora.org>
In-Reply-To: <1589307480-27508-3-git-send-email-rbokka@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 12 May 2020 16:02:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UZQRfBTbh2CLnwsRSpbXFf=8iF2MG20hdj47s42aP8HQ@mail.gmail.com>
Message-ID: <CAD=FV=UZQRfBTbh2CLnwsRSpbXFf=8iF2MG20hdj47s42aP8HQ@mail.gmail.com>
Subject: Re: [RFC v1 2/3] drivers: nvmem: Add driver for QTI qfprom-efuse support
To:     Ravi Kumar Bokka <rbokka@codeaurora.org>
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Tue, May 12, 2020 at 11:19 AM Ravi Kumar Bokka <rbokka@codeaurora.org> wrote:
>
> This patch adds new driver for QTI qfprom-efuse controller. This driver can
> access the raw qfprom regions for fuse blowing.
>
> The current existed qfprom driver is only supports for cpufreq, thermal sensors
> drivers by read out calibration data, speed bins..etc which is stored
> by qfprom efuses.
>
> Signed-off-by: Ravi Kumar Bokka <rbokka@codeaurora.org>
> ---
>  drivers/nvmem/Kconfig        |  10 +
>  drivers/nvmem/Makefile       |   2 +
>  drivers/nvmem/qfprom-efuse.c | 476 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 488 insertions(+)
>  create mode 100644 drivers/nvmem/qfprom-efuse.c
>
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index d7b7f6d..c9345c5 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -121,6 +121,16 @@ config QCOM_QFPROM
>           This driver can also be built as a module. If so, the module
>           will be called nvmem_qfprom.
>
> +config QTI_QFPROM_EFUSE

nit: it's really weird that the config above has the "QCOM" prefix and
you have "QTI".  Can you just use "QCOM"?


> +       tristate "QTI_QFPROM_EFUSE Support"
> +       depends on HAS_IOMEM
> +       help
> +         Say y here to enable QFPROM-Efuse support. This driver provides access
> +          QTI qfprom efuse via nvmem interface.
> +
> +          This driver can also be built as a module. If so, the module
> +          will be called nvmem_qfprom-efuse.
> +
>  config NVMEM_SPMI_SDAM
>         tristate "SPMI SDAM Support"
>         depends on SPMI
> diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
> index a7c3772..1d8fe43 100644
> --- a/drivers/nvmem/Makefile
> +++ b/drivers/nvmem/Makefile
> @@ -27,6 +27,8 @@ obj-$(CONFIG_MTK_EFUSE)               += nvmem_mtk-efuse.o
>  nvmem_mtk-efuse-y              := mtk-efuse.o
>  obj-$(CONFIG_QCOM_QFPROM)      += nvmem_qfprom.o
>  nvmem_qfprom-y                 := qfprom.o
> +obj-$(CONFIG_QTI_QFPROM_EFUSE) += nvmem_qfprom-efuse.o
> +nvmem_qfprom-efuse-y           := qfprom-efuse.o
>  obj-$(CONFIG_NVMEM_SPMI_SDAM)  += nvmem_qcom-spmi-sdam.o
>  nvmem_qcom-spmi-sdam-y         += qcom-spmi-sdam.o
>  obj-$(CONFIG_ROCKCHIP_EFUSE)   += nvmem_rockchip_efuse.o
> diff --git a/drivers/nvmem/qfprom-efuse.c b/drivers/nvmem/qfprom-efuse.c
> new file mode 100644
> index 0000000..2e3c275
> --- /dev/null
> +++ b/drivers/nvmem/qfprom-efuse.c
> @@ -0,0 +1,476 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/nvmem-provider.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +
> +#define QFPROM_BLOW_STATUS_BUSY 0x1
> +#define QFPROM_BLOW_STATUS_READY 0x0
> +
> +/* Blow timer clock frequency in Mhz for 10nm LPe technology */
> +#define QFPROM_BLOW_TIMER_OFFSET 0x03c
> +#define QFPROM_BLOW_TIMER_RESET_VALUE 0x0
> +
> +/* Amount of time required to hold charge to blow fuse in micro-seconds */
> +#define QFPROM_FUSE_BLOW_POLL_PERIOD 100

Am I reading this correctly that your timeout is 10 microseconds and
you're polling every 100 microseconds?  That seems weird.  Why not
just poll every "fuse_blow_time_in_us / 10" or something?


> +#define QFPROM_BLOW_STATUS_OFFSET 0x048
> +
> +#define QFPROM_ACCEL_OFFSET 0x044
> +
> +/**
> + * struct qfprom_efuse_platform_data - structure holding qfprom-efuse
> + * platform data
> + *
> + * @name: qfprom-efuse compatible name
> + * @fuse_blow_time_in_us: Should contain the wait time when doing the fuse blow
> + * @accel_value: Should contain qfprom accel value
> + * @accel_reset_value: The reset value of qfprom accel value
> + * @qfprom_blow_timer_value: The timer value of qfprom when doing efuse blow
> + * @qfprom_blow_reset_freq: The frequency required to set when fuse blowing
> + * is done
> + * @qfprom_blow_set_freq: The frequency required to set when we start the
> + * fuse blowing
> + * @qfprom_max_vol: max voltage required to set fuse blow
> + * @qfprom_min_vol: min voltage required to set fuse blow
> + */
> +struct qfprom_efuse_platform_data {
> +       const char *name;

You don't need the name for anything.  Remove.


> +       u8 fuse_blow_time_in_us;
> +       u32 accel_value;
> +       u32 accel_reset_value;
> +       u32 qfprom_blow_timer_value;
> +       u32 qfprom_blow_reset_freq;
> +       u32 qfprom_blow_set_freq;
> +       u32 qfprom_max_vol;
> +       u32 qfprom_min_vol;
> +};
> +
> +/**
> + * struct qfprom_efuse_priv - structure holding qfprom-efuse attributes
> + *
> + * @qfpbase: iomapped memory space for qfprom base
> + * @qfpraw: iomapped memory space for qfprom raw fuse region
> + * @qfpmap: iomapped memory space for qfprom fuse blow timer
> +

Please error-check your kernel-docs with:
  scripts/kernel-doc -rst drivers/nvmem/qfprom-efuse.c > /dev/null

It reports (among other things) that you have a bad line here.


> + * @dev: qfprom device structure
> + * @secclk: clock supply
> + * @vcc: regulator supply
> +
> + * @qfpraw_start: qfprom raw fuse start region
> + * @qfpraw_end: qfprom raw fuse end region
> + * @qfprom_efuse_platform_data: qfprom platform data
> + */
> +struct qfprom_efuse_priv {
> +       void __iomem *qfpbase;
> +       void __iomem *qfpraw;
> +       void __iomem *qfpmap;
> +       struct device *dev;
> +       struct clk *secclk;
> +       struct regulator *vcc;
> +       resource_size_t qfpraw_start;
> +       resource_size_t qfpraw_end;
> +       struct qfprom_efuse_platform_data efuse;
> +};
> +
> +/*
> + * restore the gcc_sec_ctrl_clk frequency to default value(19.2 MHz)
> + */
> +static int qfprom_reset_clock_settings(const struct qfprom_efuse_priv *priv)
> +{
> +       int ret;
> +
> +       ret = clk_set_rate(priv->secclk, priv->efuse.qfprom_blow_reset_freq);
> +       if (ret) {
> +               dev_err(priv->dev, "clk_set_rate() failed to enable secclk\n");
> +               return ret;
> +       }
> +
> +       return 0;

Slightly shorter:

ret = clk_set_rate(...);
if (ret)
  dev_err(...);

return ret;

> +}
> +
> +/*
> + * set the gcc_sec_ctrl_clk to 4.8 MHz
> + */
> +static int qfprom_set_clock_settings(const struct qfprom_efuse_priv *priv)
> +{
> +       int ret;
> +
> +       ret = clk_set_rate(priv->secclk, priv->efuse.qfprom_blow_set_freq);
> +

nit: remove extra blank line.

> +       if (ret) {
> +               dev_err(priv->dev, "clk_set_rate() failed to enable secclk\n");
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +/*
> + * set and reset the voltage for 1.8V and OFF(0V) on VDD_QFPROM (LDO11)
> + */
> +static int qfprom_set_voltage_settings(const struct qfprom_efuse_priv *priv,
> +                                      int min_uV, int max_uV)
> +{
> +       int ret;
> +
> +       ret = regulator_set_voltage(priv->vcc, min_uV, max_uV);
> +

nit: remove extra blank line.

> +       if (ret) {
> +               dev_err(priv->dev, "regulator_set_voltage() failed!\n");
> +               return ret;
> +       }

See above where I suggest that you shouldn't be playing with the
voltage at all.  Just enable and disable.  Then get rid of this
function and callers should just call regulator_enable() /
regulator_disable().


> +
> +       ret = regulator_enable(priv->vcc);

You have regulator_enable() in both the turn on and turn off case.
Presumably that means that every time your code is called there's
another refcount keeping this regulator on.  That's definitely a bug.


> +       if (ret) {
> +               dev_err(priv->dev, "failed to enable regulator\n");
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +/*
> + * resets the value of the blow timer, accel register and the clock
> + * and voltage settings
> + */
> +static int qfprom_disable_fuse_blowing(const struct qfprom_efuse_priv *priv)
> +{
> +       int ret;
> +
> +       ret = qfprom_set_voltage_settings(priv, 0, priv->efuse.qfprom_max_vol);
> +       if (ret) {
> +               dev_err(priv->dev, "qfprom_set_voltage_settings failed\n");

qfprom_set_voltage_settings() already printed an error.  Don't need to
print all the way down.


> +               return ret;
> +       }
> +
> +       ret = qfprom_reset_clock_settings(priv);
> +       if (ret) {
> +               dev_err(priv->dev, "qfprom_reset_clock_settings failed\n");

qfprom_reset_clock_settings() already printed an error.  Don't need to
print all the way down.


> +               return ret;
> +       }
> +
> +       writel(QFPROM_BLOW_TIMER_RESET_VALUE, priv->qfpmap +
> +                 QFPROM_BLOW_TIMER_OFFSET);
> +       writel(priv->efuse.accel_reset_value,
> +              priv->qfpmap + QFPROM_ACCEL_OFFSET);
> +
> +       return 0;
> +}
> +
> +/*
> + * sets the value of the blow timer, accel register and the clock
> + * and voltage settings
> + */
> +static int qfprom_enable_fuse_blowing(const struct qfprom_efuse_priv *priv)
> +{
> +       int ret;
> +
> +       ret = qfprom_disable_fuse_blowing(priv);
> +       if (ret) {
> +               dev_err(priv->dev, "qfprom_disable_fuse_blowing()\n");
> +               return ret;
> +       }

Why is the first line of qfprom_enable_fuse_blowing() a call to
qfprom_disable_fuse_blowing()?  That doesn't make sense.  Please
remove.


> +
> +       writel(priv->efuse.qfprom_blow_timer_value, priv->qfpmap +
> +              QFPROM_BLOW_TIMER_OFFSET);
> +       writel(priv->efuse.accel_value, priv->qfpmap + QFPROM_ACCEL_OFFSET);
> +
> +       ret = qfprom_set_clock_settings(priv);
> +       if (ret) {
> +               dev_err(priv->dev, "qpfrom_set_clock_settings()\n");

Presumably you should undo your writel() in the error case.

qfprom_set_clock_settings() already printed an error.  Don't need to
print all the way down.


> +               return ret;
> +       }
> +
> +       ret = qfprom_set_voltage_settings(priv, priv->efuse.qfprom_min_vol,
> +                                         priv->efuse.qfprom_max_vol);
> +       if (ret) {
> +               dev_err(priv->dev, "qfprom_set_voltage_settings()\n");

Presumably you should undo your writel() and clock settings in the error case.

qfprom_set_voltage_settings() already printed an error.  Don't need to
print all the way down.

> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +/*
> + * verifying to make sure address being written or read is from qfprom
> + * raw address range
> + */
> +bool addr_in_qfprom_range(const struct qfprom_efuse_priv *priv, u32 reg,
> +                         size_t bytes)

Function should be static.



> +{
> +       if (((reg + bytes) > reg) && (reg >= priv->qfpraw_start) &&

The ((reg + bytes) > reg) is a weird check.  I guess you're checking
for overflow?  If nothing else this deserves a comment.


> +           ((reg + bytes) <= priv->qfpraw_end)) {
> +               return 1;
> +       }
> +
> +       return 0;

No need to convert from bool to bool with an if statement.  Your code
reads like:

if (a)
  return true;
return false;

When instead you can just say:

return a;


...but also I think this function doesn't actually make sense at all.
You should rely on the nvmem size checking and also have the client's
concept of the register range start at 0.  See below.


> +}
> +
> +/*
> + * API for reading from raw qfprom region
> + */
> +static int qfprom_efuse_reg_read(void *context, unsigned int reg, void *_val,
> +                                size_t bytes)
> +{
> +       struct qfprom_efuse_priv *priv = context;
> +       u32 *value = _val;

Is it really legal to assume the buffer passed is word-aligned?
Someone with more nvmem subsystem experience might know better than I
do, but I wouldn't assume this.


> +       u32 align_check;
> +       int i = 0, words = bytes / 4;
> +
> +       dev_info(priv->dev,
> +                "reading raw qfprom region offset: 0x%08x of size: %zd\n",
> +                reg, bytes);
> +
> +       if (bytes % 4 != 0x00) {
> +               dev_err(priv->dev,
> +                       "Bytes: %zd to read should be word align\n",
> +                       bytes);
> +               return -EINVAL;
> +       }

You should be able to get rid of the above check if you set word_size
to 4, right?


> +
> +       if (!addr_in_qfprom_range(priv, reg, bytes)) {

It feels like you should just rely on the "nvmem->size" in the "econfig".


> +               dev_err(priv->dev,
> +                       "Invalid qfprom raw region offset 0x%08x & bytes %zd\n",
> +                       reg, bytes);

This doesn't feel like the kind of case that should be printing an
error message.  It should be up to the client to do that.  Just
silently return -EINVAL.


> +               return -EINVAL;
> +       }
> +
> +       align_check = (reg & 0xF);
> +
> +       if (((align_check & ~3) == align_check) && value != NULL)

Rather than all this align check, shouldn't you just be able to set
"stride" to 4?  As far as I understand it then the core should handle
this guarantee.  If the core isn't and it's causing you problems then
you should submit a patch to the core.  If (for some reason) you still
need an alignment check, it seems like a much less roundabout way to
do your calculations is "if (reg & 0x3)"

Also: IMO there's no need to check value against NULL.  The client is
other Linux code, not userspace.  It can be trusted not to give you a
NULL buffer.  Worst case if it does is that you get a nice clean
crash.


> +               while (words--)
> +                       *value++ = readl(priv->qfpbase + reg + (i++ * 4));

Adding "reg" to "qfpbase" really seems to violate some abstractions.
Do you have 1 memory range, or do you have 3?  Here you're taking a
register that's in the raw range but accessing it as an offset from
the "qfp_sec_base".  IMO you should just define a single register
range.  If you really need 3 register ranges then you should treat
them separately.

Note also that it feels like you're exposing the wrong number to the
client.  If a client wants to access byte 0 of your range they need to
pass 0x120, right?  It feels like the client should just be passing 0
and (if you need to) you should worry about offsetting.

Also: I think you can use ioread32_rep() to do your reading rather than
open-coding, right?


> +
> +       else
> +               dev_err(priv->dev,
> +                       "Invalid input parameter 0x%08x fuse blow address\n",
> +                       reg);
> +
> +       return 0;
> +}
> +
> +/*
> + * API for writing to raw qfprom region - fuse blowing
> + * returns success or failure code as per the conditions
> + */
> +static int qfprom_efuse_reg_write(void *context, unsigned int reg, void *_val,
> +                                 size_t bytes)
> +{
> +       struct qfprom_efuse_priv *priv = context;
> +       u32 *value = _val;

Same comments as read wondering whether it's legit to assume that the
buffer passed in is word-aligned.


> +       u32 align_check;
> +       u32 blow_status = QFPROM_BLOW_STATUS_BUSY;

Don't init values if you don't need to.


> +       int ret;
> +       int i = 0, words = bytes / 4;
> +
> +       dev_info(priv->dev,
> +                "writing to raw qfprom region : 0x%08x of size: %zd\n",
> +                reg, bytes);
> +
> +       if (bytes % 4 != 0x00) {
> +               dev_err(priv->dev, "Bytes: %zd should be word align\n", bytes);
> +               return -EINVAL;
> +       }

Same comments as in read about using word_size.


> +
> +       if (!addr_in_qfprom_range(priv, reg, bytes)) {
> +               dev_err(priv->dev,
> +                       "Invalid qfprom raw region offset 0x%08x & bytes %zd\n",
> +                        reg, bytes);
> +               return -EINVAL;
> +       }

Same comments as in read.


> +
> +       align_check = (reg & 0xF);
> +       if (value && ((align_check & ~3) == align_check)) {
> +               ret = qfprom_enable_fuse_blowing(priv);
> +               if (ret) {
> +                       dev_err(priv->dev, "qfprom_enable_fuse_blowing");
> +                       return ret;
> +               }

Same comments as in read.


> +
> +               ret = readl_relaxed_poll_timeout(priv->qfpmap +
> +                               QFPROM_BLOW_STATUS_OFFSET, blow_status,
> +                               (blow_status  != QFPROM_BLOW_STATUS_BUSY),
> +                               QFPROM_FUSE_BLOW_POLL_PERIOD,
> +                               priv->efuse.fuse_blow_time_in_us);
> +
> +               if (ret) {
> +                       dev_err(priv->dev, "Timeout blow status ready\n");
> +                       return ret;
> +               }

Need to disable fuse blowing in the error case.  Right now you leave
the regulator and clock enabled.


> +
> +               if (blow_status == QFPROM_BLOW_STATUS_READY) {

...and what happens if blow_status is no longer busy (so you didn't
timeout) but it's not QFPROM_BLOW_STATUS_READY?  Is that even
possible?  If not then remove this check.  If so then (presumably?)
you need to return an error.


> +                       while (words--)
> +                               writel(*value++,
> +                                      priv->qfpbase + reg + (i++ * 4));

Similar comments as in read that you should be able to use iowrite32_rep()


> +
> +                       ret = readl_relaxed_poll_timeout(priv->qfpmap +
> +                               QFPROM_BLOW_STATUS_OFFSET, blow_status,
> +                               (blow_status  != QFPROM_BLOW_STATUS_BUSY),
> +                               QFPROM_FUSE_BLOW_POLL_PERIOD,
> +                               priv->efuse.fuse_blow_time_in_us);
> +
> +                       if (ret) {
> +                               dev_err(priv->dev, "Timeout blow-status ready");

Need to disable fuse blowing in the error case.  Right now you leave
the regulator and clock enabled.


> +                               return ret;
> +                       }
> +               }
> +
> +               ret = qfprom_disable_fuse_blowing(priv);
> +               if (ret)
> +                       return ret;
> +       } else {
> +               dev_err(priv->dev, "Invalid input parameter fuse blow address");
> +               return -EINVAL;
> +       }
> +
> +       dev_info(priv->dev, "written successfully raw qfprom region\n");
> +
> +       return 0;
> +}
> +
> +static int qfprom_efuse_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct resource *qfpbase, *qfpraw, *qfpmap;
> +       struct nvmem_device *nvmem;
> +       struct nvmem_config *econfig;
> +       struct qfprom_efuse_priv *priv;
> +       const struct qfprom_efuse_platform_data *drvdata;
> +       int ret;
> +
> +       dev_info(&pdev->dev, "[%s]: Invoked\n", __func__);

Please remove.  Your driver doesn't need to announce itself.


> +
> +       drvdata = of_device_get_match_data(&pdev->dev);
> +       if (!drvdata)
> +               return -EINVAL;
> +
> +       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->efuse.fuse_blow_time_in_us = drvdata->fuse_blow_time_in_us;
> +       priv->efuse.accel_value = drvdata->accel_value;
> +       priv->efuse.accel_reset_value = drvdata->accel_reset_value;
> +       priv->efuse.qfprom_blow_timer_value = drvdata->qfprom_blow_timer_value;
> +       priv->efuse.qfprom_blow_reset_freq = drvdata->qfprom_blow_reset_freq;
> +       priv->efuse.qfprom_blow_set_freq = drvdata->qfprom_blow_set_freq;
> +       priv->efuse.qfprom_max_vol = drvdata->qfprom_max_vol;
> +       priv->efuse.qfprom_min_vol = drvdata->qfprom_min_vol;
> +       priv->dev = dev;
> +
> +       qfpbase = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +       priv->qfpbase = devm_ioremap_resource(dev, qfpbase);
> +       if (IS_ERR(priv->qfpbase)) {
> +               ret = PTR_ERR(priv->qfpbase);
> +               goto err;
> +       }
> +
> +       qfpraw = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +
> +       priv->qfpraw = devm_ioremap_resource(dev, qfpraw);
> +       if (IS_ERR(priv->qfpraw)) {
> +               ret = PTR_ERR(priv->qfpraw);
> +               goto err;
> +       }
> +
> +       priv->qfpraw_start = qfpraw->start - qfpbase->start;
> +       priv->qfpraw_end = qfpraw->end - qfpbase->start;

See above comments, but the math to calculate "qfpraw_start" and
"qfpraw_end" really seems to violate abstractions and implies that you
should just define one memory range, not 3.


> +
> +       qfpmap = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> +
> +       priv->qfpmap = devm_ioremap_resource(dev, qfpmap);
> +       if (IS_ERR(priv->qfpmap)) {
> +               ret = PTR_ERR(priv->qfpmap);
> +               goto err;
> +       }
> +
> +       priv->vcc = devm_regulator_get(&pdev->dev, "vcc");
> +       if (IS_ERR(priv->vcc)) {
> +               ret = PTR_ERR(priv->vcc);
> +               if (ret == -ENODEV)
> +                       ret = -EPROBE_DEFER;
> +
> +               goto err;
> +       }
> +
> +       priv->secclk = devm_clk_get(dev, "secclk");
> +       if (IS_ERR(priv->secclk)) {
> +               ret = PTR_ERR(priv->secclk);
> +               if (ret != -EPROBE_DEFER)
> +                       dev_err(dev, "secclk error getting : %d\n", ret);
> +               goto err;
> +       }
> +
> +       ret = clk_prepare_enable(priv->secclk);

You really need your clock prepared and enabled _all the time_?  Maybe
just prepare it here and then do the enable/disable when you need it?


> +       if (ret) {
> +               dev_err(dev, "clk_prepare_enable() failed\n");
> +               goto err;
> +       }
> +
> +       econfig = devm_kzalloc(dev, sizeof(*econfig), GFP_KERNEL);
> +       if (!econfig)
> +               return -ENOMEM;
> +
> +       econfig->dev = dev;
> +       econfig->name = "qfprom-efuse";
> +       econfig->stride = 1;
> +       econfig->word_size = 1;

See above about suggestions, specifically about changing ".stride" and
".word_size".


> +       econfig->reg_read = qfprom_efuse_reg_read;
> +       econfig->reg_write = qfprom_efuse_reg_write;
> +       econfig->size = resource_size(qfpraw);
> +       econfig->priv = priv;
> +
> +       nvmem = devm_nvmem_register(dev, econfig);
> +
> +       return PTR_ERR_OR_ZERO(nvmem);
> +
> +err:
> +       clk_disable_unprepare(priv->secclk);
> +       return ret;
> +}
> +
> +static const struct qfprom_efuse_platform_data sc7180_qfp_efuse_data = {
> +       .name = "sc7180-qfprom-efuse",
> +       .fuse_blow_time_in_us = 10,
> +       .accel_value = 0xD10,
> +       .accel_reset_value = 0x800,
> +       .qfprom_blow_timer_value = 25,
> +       .qfprom_blow_reset_freq = 19200000,
> +       .qfprom_blow_set_freq = 4800000,
> +       .qfprom_max_vol = 1904000,
> +       .qfprom_min_vol = 1800000,

Can you explain why this patch needs to specify voltage at all?  I'd
expect that the voltage constraints would be specified in the device
tree and the driver shouldn't worry about it.  The only case you
really would need to specify this would be if you're expected to be on
a rail that's shared with other components and they have a different
(but compatible) operating range to yours.  Do you actually have this?


> +};
> +
> +static const struct of_device_id qfprom_efuse_of_match[] = {
> +       {
> +               .compatible = "qcom,sc7180-qfprom-efuse",
> +               .data = &sc7180_qfp_efuse_data
> +       },
> +       {/* sentinel */},
> +};
> +
> +MODULE_DEVICE_TABLE(of, qfprom_efuse_of_match);
> +
> +static struct platform_driver qfprom_efuse_driver = {
> +       .probe = qfprom_efuse_probe,

You need a remove to unprepare / disable your clock, right?  Unless
you change that to not leave it prepared/enabled all the time.


> +       .driver = {
> +               .name = "sc7180-qfprom-efuse",

You don't need to put "sc7180" in the driver name.  This driver will
be used for other hardware eventually too with just a different
compatible match.


> +               .of_match_table = qfprom_efuse_of_match,
> +       },
> +};
> +
> +module_platform_driver(qfprom_efuse_driver);
> +MODULE_DESCRIPTION("QTI QFPROM Efuse driver");
> +MODULE_LICENSE("GPL v2");
> --
> Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.
>
