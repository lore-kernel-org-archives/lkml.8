Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05CBC33CB0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 06:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD97A20678
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 06:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oKpCh9Ne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733267AbgAMGTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 01:19:43 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33822 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729184AbgAMGTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 01:19:43 -0500
Received: by mail-qk1-f194.google.com with SMTP id j9so7565541qkk.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jan 2020 22:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NjRr9TqgpmMrAVeoghWMBXd1ZgBA7Z+irKgKROJlv7w=;
        b=oKpCh9Neh3fc+aXwIUAB/tiw2nGsLH7HPBN6SUxCflRgo2UsaHKF1Rx2aVu8+gljzZ
         82jSMTQrtUZPpw4BrXfu7LlSCMQ4FrkT1hkkvRuqbOe0jJCR/c8pmBhfckyeDIv30JV3
         e4w9ziCKuzgYiOIWc9HP5tVfOg/50fPFhMPOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NjRr9TqgpmMrAVeoghWMBXd1ZgBA7Z+irKgKROJlv7w=;
        b=eEzDfCHx37DYwBAQcmnIP/rAwsWQAPsmmv09a4ckibbRku0r5BjVZOQQMvff+adsAs
         ur/E089zK9CmT4JvwsSgmtNs39BK70e8dy9F7WyDf15Vk3Qaz3a8CtTm1GqZP86dntwb
         yE668EjfkzOkpBHOUHrTvvCFMIanb0CxRjSkKyMcgeB/hU4DspCjQXsgI+7A0gsFUpCq
         pDSdKVGiGxkdGs1GdHxKNV4uByo+CuJltSWzGyQm6D66R/O7o9mBC5jRgdZeddeEDGsV
         b+NaYNZ0rzX1YFG2Y+1j+tATo/PXbBUr/JWpZJhrDn+rnqgjOp+cLFkV/Fm0qHQTBMIZ
         1xWA==
X-Gm-Message-State: APjAAAUphsZ+pn1LSIL9nz9H14U0F8lI04xXhmx+bHIOdpbZWkkUj2O7
        FGUyOiBNSTZPcqtoD+MVnabicuRNUoMWB5WbsuDw0g==
X-Google-Smtp-Source: APXvYqzA0S+930GfQqHyxhU3+UoYDL7XD6vSsgbjWChKCawPdFoGi9QyBy3cS03ZIJQTrcCFM5FAqgiEixxHtgbOZGk=
X-Received: by 2002:a37:6551:: with SMTP id z78mr15344155qkb.144.1578896382357;
 Sun, 12 Jan 2020 22:19:42 -0800 (PST)
MIME-Version: 1.0
References: <1578639862-14480-1-git-send-email-jiaxin.yu@mediatek.com> <1578639862-14480-3-git-send-email-jiaxin.yu@mediatek.com>
In-Reply-To: <1578639862-14480-3-git-send-email-jiaxin.yu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 13 Jan 2020 14:19:31 +0800
Message-ID: <CANMq1KBPLCVW=LkmbYFjGwGCo=EeGShW3pom=AS+uEczuCUV_A@mail.gmail.com>
Subject: Re: [PATCH v11 2/3] watchdog: mtk_wdt: mt8183: Add reset controller
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     Yong Liang <yong.liang@mediatek.com>, wim@linux-watchdog.org,
        linux@roeck-us.net, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-watchdog@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        chang-an.chen@mediatek.com, freddy.hsin@mediatek.com,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 3:04 PM Jiaxin Yu <jiaxin.yu@mediatek.com> wrote:
>
> Add reset controller API in watchdog driver.
> Besides watchdog, MTK toprgu module alsa provide sub-system (eg, audio,
> camera, codec and connectivity) software reset functionality.
>
> Signed-off-by: yong.liang <yong.liang@mediatek.com>
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>

Since there was a doubt about the history of the tags, trying to detangle:

> Reviewed-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

This comes from v7 (https://patchwork.kernel.org/patch/11311039/),
that also had MT2712, but otherwise the patch is functionally similar.

> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Guenter Roeck <groeck7@gmail.com>

I don't see these tags anywhere in the history, please drop them.

> ---
>  drivers/watchdog/mtk_wdt.c | 99 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 98 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> index 9c3d0033260d..e88aacb0404d 100644
> --- a/drivers/watchdog/mtk_wdt.c
> +++ b/drivers/watchdog/mtk_wdt.c
> @@ -9,6 +9,8 @@
>   * Based on sunxi_wdt.c
>   */
>
> +#include <dt-bindings/reset-controller/mt8183-resets.h>
> +#include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> @@ -16,10 +18,11 @@
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
> +#include <linux/reset-controller.h>
>  #include <linux/types.h>
>  #include <linux/watchdog.h>
> -#include <linux/delay.h>
>
>  #define WDT_MAX_TIMEOUT                31
>  #define WDT_MIN_TIMEOUT                1
> @@ -44,6 +47,9 @@
>  #define WDT_SWRST              0x14
>  #define WDT_SWRST_KEY          0x1209
>
> +#define WDT_SWSYSRST           0x18U
> +#define WDT_SWSYS_RST_KEY      0x88000000
> +
>  #define DRV_NAME               "mtk-wdt"
>  #define DRV_VERSION            "1.0"
>
> @@ -53,8 +59,90 @@ static unsigned int timeout;
>  struct mtk_wdt_dev {
>         struct watchdog_device wdt_dev;
>         void __iomem *wdt_base;
> +       spinlock_t lock; /* protects WDT_SWSYSRST reg */
> +       struct reset_controller_dev rcdev;
> +};
> +
> +struct mtk_wdt_data {
> +       int toprgu_sw_rst_num;
>  };
>
> +static const struct mtk_wdt_data mt8183_data = {
> +       .toprgu_sw_rst_num = MT8183_TOPRGU_SW_RST_NUM,
> +};
> +
> +static int toprgu_reset_update(struct reset_controller_dev *rcdev,
> +                              unsigned long id, bool assert)
> +{
> +       unsigned int tmp;
> +       unsigned long flags;
> +       struct mtk_wdt_dev *data =
> +                container_of(rcdev, struct mtk_wdt_dev, rcdev);
> +
> +       spin_lock_irqsave(&data->lock, flags);
> +
> +       tmp = readl(data->wdt_base + WDT_SWSYSRST);
> +       if (assert)
> +               tmp |= BIT(id);
> +       else
> +               tmp &= ~BIT(id);
> +       tmp |= WDT_SWSYS_RST_KEY;
> +       writel(tmp, data->wdt_base + WDT_SWSYSRST);
> +
> +       spin_unlock_irqrestore(&data->lock, flags);
> +
> +       return 0;
> +}
> +
> +static int toprgu_reset_assert(struct reset_controller_dev *rcdev,
> +                              unsigned long id)
> +{
> +       return toprgu_reset_update(rcdev, id, true);
> +}
> +
> +static int toprgu_reset_deassert(struct reset_controller_dev *rcdev,
> +                                unsigned long id)
> +{
> +       return toprgu_reset_update(rcdev, id, false);
> +}
> +
> +static int toprgu_reset(struct reset_controller_dev *rcdev,
> +                       unsigned long id)
> +{
> +       int ret;
> +
> +       ret = toprgu_reset_assert(rcdev, id);
> +       if (ret)
> +               return ret;
> +
> +       return toprgu_reset_deassert(rcdev, id);
> +}
> +
> +static const struct reset_control_ops toprgu_reset_ops = {
> +       .assert = toprgu_reset_assert,
> +       .deassert = toprgu_reset_deassert,
> +       .reset = toprgu_reset,
> +};
> +
> +static int toprgu_register_reset_controller(struct platform_device *pdev,
> +                                           int rst_num)
> +{
> +       int ret;
> +       struct mtk_wdt_dev *mtk_wdt = platform_get_drvdata(pdev);
> +
> +       spin_lock_init(&mtk_wdt->lock);
> +
> +       mtk_wdt->rcdev.owner = THIS_MODULE;
> +       mtk_wdt->rcdev.nr_resets = rst_num;
> +       mtk_wdt->rcdev.ops = &toprgu_reset_ops;
> +       mtk_wdt->rcdev.of_node = pdev->dev.of_node;
> +       ret = devm_reset_controller_register(&pdev->dev, &mtk_wdt->rcdev);
> +       if (ret != 0)
> +               dev_err(&pdev->dev,
> +                       "couldn't register wdt reset controller: %d\n", ret);
> +       return ret;
> +}
> +
>  static int mtk_wdt_restart(struct watchdog_device *wdt_dev,
>                            unsigned long action, void *data)
>  {
> @@ -155,6 +243,7 @@ static int mtk_wdt_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
>         struct mtk_wdt_dev *mtk_wdt;
> +       const struct mtk_wdt_data *wdt_data;
>         int err;
>
>         mtk_wdt = devm_kzalloc(dev, sizeof(*mtk_wdt), GFP_KERNEL);
> @@ -190,6 +279,13 @@ static int mtk_wdt_probe(struct platform_device *pdev)
>         dev_info(dev, "Watchdog enabled (timeout=%d sec, nowayout=%d)\n",
>                  mtk_wdt->wdt_dev.timeout, nowayout);
>
> +       wdt_data = of_device_get_match_data(dev);
> +       if (wdt_data) {
> +               err = toprgu_register_reset_controller(pdev,
> +                                                      wdt_data->toprgu_sw_rst_num);
> +               if (err)
> +                       return err;
> +       }
>         return 0;
>  }
>
> @@ -219,6 +315,7 @@ static int mtk_wdt_resume(struct device *dev)
>
>  static const struct of_device_id mtk_wdt_dt_ids[] = {
>         { .compatible = "mediatek,mt6589-wdt" },
> +       { .compatible = "mediatek,mt8183-wdt", .data = &mt8183_data },
>         { /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, mtk_wdt_dt_ids);
> --
> 2.18.0
