Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F58C352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 11:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B40B20733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 11:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="FaZcVpT5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgBJLs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 06:48:28 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38556 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgBJLs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 06:48:27 -0500
Received: by mail-wm1-f68.google.com with SMTP id a9so10230953wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 03:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1aQqSSjewIOk+NSQDYZdBuMf/MgfILJe523/C8XJcy8=;
        b=FaZcVpT5JDHcbUCWe+ralMxFLwrZvkzrej68mEa1ypXrQBM08yXsExEj1fzIr+Ddq0
         /mCpv9nLEwmfxxtAPis0PuMAJAsun0WHWQ/UjZvJukQmj4idIQ5QrGpC2m/oCnp5ekRt
         RMSIdIofZYVa7bnSKRFMuGsiLFDWSxcekBzTUbXJQF8c4cZIlXF6DGqHRyAbZRZ4k6ps
         R0zCvMErCqMI9GPaQ0dCKcg/KA5LCCN27O/pVE7am24L0i8KjWByplOrt5w4H/mL+/3f
         1b80zYLcG1FaS3R8hD30XXkeo0KEtQwLErR26kO9xMP38IEV/BK0kvAPRNf//7GK6kkj
         G/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1aQqSSjewIOk+NSQDYZdBuMf/MgfILJe523/C8XJcy8=;
        b=acNQ4yZFEPBR+4/Jc0SB9powPpSzW9wtX9gaZ7tZ774UmkD+Lr0TwwCH/RrK/3Q9wj
         UmfpUl5MTtQIondS03FhOkXdIa0lBO0wCG8/M/qugyNtsWzMgGtkeHKdGlaIgNIM5D+b
         gZ/5gXZiyd2W31wwvrQqM7sXnaaVmaV7qSeplwscCZEG6+fWSRExts2PKHIwF2MtXjnH
         SBeQS2y4gI8vlyIyvROSZLKBHf2J0mmQ3/3xrYx49/iHYeagAv8KSlaXqGnZFfN+IXUg
         WH3LvpH+bgjwZh2Wt8aFQbEM+GeuJohxmNffCcQNXjj1gSNk3gXKrX/3zAJ81IJLlpXd
         2kKA==
X-Gm-Message-State: APjAAAWES3gQEZ3paaZx1cLR9RqRBMiMAevAoPF6zkG81hcLB/v8dFPZ
        dQ+uUyTX9N5r5YvifiBQ/dJA9+nymMMRrWz4yKMnCw==
X-Google-Smtp-Source: APXvYqyi6XtrJMXk9ZlugaSIfF0G093AdaIblomhIXPduCLz03AchNEqASxw/DZcOJfykRMfgdT69usn7374kSRrGGk=
X-Received: by 2002:a7b:ce98:: with SMTP id q24mr14757971wmj.41.1581335305184;
 Mon, 10 Feb 2020 03:48:25 -0800 (PST)
MIME-Version: 1.0
References: <1576155618-7933-1-git-send-email-srinivas.neeli@xilinx.com>
In-Reply-To: <1576155618-7933-1-git-send-email-srinivas.neeli@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Date:   Mon, 10 Feb 2020 12:48:14 +0100
Message-ID: <CAHTX3dKSq1oTzkoRv3wK3rhkc1r0rOiQhFKmgsYbtG_uvOfAJg@mail.gmail.com>
Subject: Re: [PATCH] rtc: zynqmp: Clear alarm interrupt status before
 interrupt enable
To:     Srinivas Neeli <srinivas.neeli@xilinx.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Srinivas Goud <sgoud@xilinx.com>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>,
        linux-rtc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        git <git@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

=C4=8Dt 12. 12. 2019 v 14:01 odes=C3=ADlatel Srinivas Neeli
<srinivas.neeli@xilinx.com> napsal:
>
> Fix multiple occurring interrupts for alarm interrupt. RTC module doesn't
> clear the alarm interrupt status bit immediately after the interrupt is
> triggered.This is due to the sticky nature of the alarm interrupt status
> register. The alarm interrupt status register can be cleared only after
> the second counter outruns the set alarm value. To fix multiple spurious
> interrupts, disable alarm interrupt in the handler and clear the status
> bit before enabling the alarm interrupt.
>
> Fixes: 11143c19eb57 ("rtc: add xilinx zynqmp rtc driver")
> Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
> ---
>  drivers/rtc/rtc-zynqmp.c | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/rtc/rtc-zynqmp.c b/drivers/rtc/rtc-zynqmp.c
> index 5786866c09e9..d311e3ef1f21 100644
> --- a/drivers/rtc/rtc-zynqmp.c
> +++ b/drivers/rtc/rtc-zynqmp.c
> @@ -38,6 +38,8 @@
>
>  #define RTC_CALIB_DEF          0x198233
>  #define RTC_CALIB_MASK         0x1FFFFF
> +#define RTC_ALRM_MASK          BIT(1)
> +#define RTC_MSEC               1000
>
>  struct xlnx_rtc_dev {
>         struct rtc_device       *rtc;
> @@ -124,11 +126,28 @@ static int xlnx_rtc_alarm_irq_enable(struct device =
*dev, u32 enabled)
>  {
>         struct xlnx_rtc_dev *xrtcdev =3D dev_get_drvdata(dev);
>

here shouldn't be empty line.

> -       if (enabled)
> +       unsigned int status;
> +       ulong timeout;
> +
> +       timeout =3D jiffies + msecs_to_jiffies(RTC_MSEC);
> +
> +       if (enabled) {
> +               while (1) {
> +                       status =3D readl(xrtcdev->reg_base + RTC_INT_STS)=
;
> +                       if (!((status & RTC_ALRM_MASK) =3D=3D RTC_ALRM_MA=
SK))
> +                               break;
> +
> +                       if (time_after_eq(jiffies, timeout)) {
> +                               dev_err(dev, "Time out occur, while clear=
ing alarm status bit\n");
> +                               return -ETIMEDOUT;
> +                       }
> +                       writel(RTC_INT_ALRM, xrtcdev->reg_base + RTC_INT_=
STS);
> +               }
> +
>                 writel(RTC_INT_ALRM, xrtcdev->reg_base + RTC_INT_EN);
> -       else
> +       } else {
>                 writel(RTC_INT_ALRM, xrtcdev->reg_base + RTC_INT_DIS);
> -
> +       }

And here it was good to have empty line.

>         return 0;
>  }
>
> @@ -183,8 +202,8 @@ static irqreturn_t xlnx_rtc_interrupt(int irq, void *=
id)
>         if (!(status & (RTC_INT_SEC | RTC_INT_ALRM)))
>                 return IRQ_NONE;
>
> -       /* Clear RTC_INT_ALRM interrupt only */
> -       writel(RTC_INT_ALRM, xrtcdev->reg_base + RTC_INT_STS);
> +       /* Disable RTC_INT_ALRM interrupt only */
> +       writel(RTC_INT_ALRM, xrtcdev->reg_base + RTC_INT_DIS);
>
>         if (status & RTC_INT_ALRM)
>                 rtc_update_irq(xrtcdev->rtc, 1, RTC_IRQF | RTC_AF);
> --
> 2.7.4

Other then these two above things look good.

Alexandre: Any issue with this patch?

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
