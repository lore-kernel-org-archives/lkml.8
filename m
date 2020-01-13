Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8852EC33CB0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 06:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5520C207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 06:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WxS0Vug8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387395AbgAMGUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 01:20:42 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42175 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732572AbgAMGUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 01:20:42 -0500
Received: by mail-qk1-f193.google.com with SMTP id z14so7520539qkg.9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jan 2020 22:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rbidIxb647dakpGFJlRyQ3/ihwOOmZc8NjZm9uAOe7Y=;
        b=WxS0Vug8xhyLR97I/t2SZL6RKMcPSykb1/Bq9crc1+OYZoBfukLaCJ9Tc9EkP/uu4X
         Z/um91CPIbStVhvRelpbdaq1iHMzd7+XSjtZ8VepD8xsTX0rMGUdOyTvMt7hl6oHtKMp
         1B6kNdZiMwE4Ii6DDhLJyCHRDlv0pDydLfxB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rbidIxb647dakpGFJlRyQ3/ihwOOmZc8NjZm9uAOe7Y=;
        b=W0wNI0ACJmt3ZaLrpK3BEfM9KNkOjdl6MSXj/BY9xUJiQjejBdLW7dMxLpi4uP35rm
         QKRm1TtbpMrH8XuO5oiI5TdxwaA5R3HLR3U1j6uokY7wValWBEzq8T3i4veLNEWw2G7D
         gB2zJVY6qfdjgj9+eh2QpkdQgQ+yNAVHXT14zsDD1/IyEiHn4VH6Mk4aVE8R5we2Dqff
         U96VMJzT5X/GaaK21g39mJNKfz9eFklReRYj2rbbo1OZjLrFXgeobX7jnWzpwsAOCRYi
         +sLT935Yf2aKl2f3TAluiIHX0GZXC93s3FTAJ0iLvOkv+xRS/VB2PDVOek5Y6+kuI3w+
         xedQ==
X-Gm-Message-State: APjAAAWgskoCssHo3OT0DV9naDwH2LHRDbL9iqXjx2PzNauydQuv8hAs
        lRbQFZXlvSC0n8XoBUPIyRua2E9F/63PkZEi5GAFTA==
X-Google-Smtp-Source: APXvYqyg+DfzeIRu42KEs7ygYGGHEH4ohvCGoNjEgPqdFrdCkhfaR1L7mh+JsDSUmfVNYFE5Ptt8z7b4B+RTP5IqduA=
X-Received: by 2002:a05:620a:6d7:: with SMTP id 23mr14062530qky.299.1578896440489;
 Sun, 12 Jan 2020 22:20:40 -0800 (PST)
MIME-Version: 1.0
References: <1578639862-14480-1-git-send-email-jiaxin.yu@mediatek.com> <1578639862-14480-4-git-send-email-jiaxin.yu@mediatek.com>
In-Reply-To: <1578639862-14480-4-git-send-email-jiaxin.yu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 13 Jan 2020 14:20:29 +0800
Message-ID: <CANMq1KBxL55A8vDwNsqNpDmdNUxkpJ+JPByDaTEFwxnPQM8ESw@mail.gmail.com>
Subject: Re: [PATCH v11 3/3] watchdog: mtk_wdt: mt2712: Add reset controller
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
> Add reset controller for 2712.
> Besides watchdog, MTK toprgu module alsa provide sub-system (eg, audio,
> camera, codec and connectivity) software reset functionality.
>
> Signed-off-by: yong.liang <yong.liang@mediatek.com>
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> Reviewed-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

This is somewhat ok I guess, as Philipp review the same code before
you split it into 2 patches.

> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Guenter Roeck <groeck7@gmail.com>

Those 2 need to be dropped.

> ---
>  drivers/watchdog/mtk_wdt.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> index e88aacb0404d..d6a6393f609d 100644
> --- a/drivers/watchdog/mtk_wdt.c
> +++ b/drivers/watchdog/mtk_wdt.c
> @@ -9,6 +9,7 @@
>   * Based on sunxi_wdt.c
>   */
>
> +#include <dt-bindings/reset-controller/mt2712-resets.h>
>  #include <dt-bindings/reset-controller/mt8183-resets.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
> @@ -67,6 +68,10 @@ struct mtk_wdt_data {
>         int toprgu_sw_rst_num;
>  };
>
> +static const struct mtk_wdt_data mt2712_data = {
> +       .toprgu_sw_rst_num = MT2712_TOPRGU_SW_RST_NUM,
> +};
> +
>  static const struct mtk_wdt_data mt8183_data = {
>         .toprgu_sw_rst_num = MT8183_TOPRGU_SW_RST_NUM,
>  };
> @@ -314,6 +319,7 @@ static int mtk_wdt_resume(struct device *dev)
>  #endif
>
>  static const struct of_device_id mtk_wdt_dt_ids[] = {
> +       { .compatible = "mediatek,mt2712-wdt", .data = &mt2712_data },
>         { .compatible = "mediatek,mt6589-wdt" },
>         { .compatible = "mediatek,mt8183-wdt", .data = &mt8183_data },
>         { /* sentinel */ }
> --
> 2.18.0
