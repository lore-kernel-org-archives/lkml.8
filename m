Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101C0C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3393206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OCr7V9Pv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgGXNpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbgGXNpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:45:11 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD75EC0619E4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 06:45:10 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id e15so4904914vsc.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 06:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g/+5UoxaK0B/ouWKXhlnGp7tlvNSVwLA+fl6kPFBy3Q=;
        b=OCr7V9PvnMgT+sB96Edxhs4Fa6YvkPB8pV2zkvYSzisExSkRA2oHnRwBTYa1D+8Pke
         T833lNyfbhaGuRGE36rEbzToZ+w4ajlTEeaiN2xCMgTuug0VRSy0K9578WWtKKFTS3CC
         w5K3xXdFEA+2XsYJ0VQ9GBTd9aaj8pyS1o/vQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g/+5UoxaK0B/ouWKXhlnGp7tlvNSVwLA+fl6kPFBy3Q=;
        b=qtYIjn3RsgHR0MFpNXhKnPOW8vshKppgmXtJ5dLQ41+aeB6gFd8D6A6u7Turx/dByR
         9hO7TsIU3xV437WVpvRUPbzLYQiZsgh/rBqf5E+SKvK/6bhzWZkoID4MAnzJYxggLnzX
         x8cMw8jguea6EoaC/hdZTDmQu2NYacDJhXWhGqEw4d9hk2R4bMv53GTpcdpqrTnfQ/TE
         YtZACES8jXuSt3F3OQCZpwTNeq98OV1ZBEbSqonPsb12hyMYjxH6hb+NyrQ2EclpMAzm
         sCrkFGxZSYdlEpXxTuPflOTmCnzw26TdLp905fD2YalkU4dTALae5V33hl4d8x1k9Zth
         bCSQ==
X-Gm-Message-State: AOAM531RGLs5LNPPuBTIT2RZEPRgmHpfRkrWHErOQjU5Ueo0bkGSs8Am
        W4qNODwjnIcjPARaoJU5R5V/M3+Xwj7y880+C9yBKA==
X-Google-Smtp-Source: ABdhPJzF8Cn+eUjgEJZZxSH4zV2/AuLt79M3/GOySgsHJwoMPWl9y7OO1PDUxu5v46KpEurVhelGQjKWin7Y5j6dqJQ=
X-Received: by 2002:a67:f5c6:: with SMTP id t6mr7555224vso.14.1595598309872;
 Fri, 24 Jul 2020 06:45:09 -0700 (PDT)
MIME-Version: 1.0
References: <1595475600-23180-1-git-send-email-hsin-hsiung.wang@mediatek.com> <1595475600-23180-3-git-send-email-hsin-hsiung.wang@mediatek.com>
In-Reply-To: <1595475600-23180-3-git-send-email-hsin-hsiung.wang@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 24 Jul 2020 21:44:58 +0800
Message-ID: <CANMq1KAmVbNnXMV0Zw9ZBPtnnj283uemF+ctztaEzZi8ikB-jw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] soc: mediatek: pwrap: add arbiter capability
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Argus Lin <argus.lin@mediatek.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 11:40 AM Hsin-Hsiung Wang
<hsin-hsiung.wang@mediatek.com> wrote:
>
> Add arbiter capability for pwrap driver.
> This patch is preparing for adding mt6873/8192 pwrap support.
>
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-pmic-wrap.c | 67 ++++++++++++++++++++++++++++++------
>  1 file changed, 56 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index c897205..8d76ed4 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -24,11 +24,13 @@
>  #define PWRAP_MT8135_BRIDGE_WDT_SRC_EN         0x54
>
>  /* macro for wrapper status */
> +#define PWRAP_GET_SWINF_2_FSM(x)       (((x) >> 1) & 0x00000007)

I find this macro name a bit weird, because you are actually using
this mask on PWRAP_WACS2_RDATA register value (just like
PWRAP_GET_WACS_FSM below).

Should it be something like PWRAP_GET_WACS_ARB_FSM?!

>  #define PWRAP_GET_WACS_RDATA(x)                (((x) >> 0) & 0x0000ffff)
>  #define PWRAP_GET_WACS_FSM(x)          (((x) >> 16) & 0x00000007)
>  #define PWRAP_GET_WACS_REQ(x)          (((x) >> 19) & 0x00000001)
>  #define PWRAP_STATE_SYNC_IDLE0         BIT(20)
>  #define PWRAP_STATE_INIT_DONE0         BIT(21)
> +#define PWRAP_STATE_INIT_DONE1         BIT(15)
>
>  /* macro for WACS FSM */
>  #define PWRAP_WACS_FSM_IDLE            0x00
> @@ -74,6 +76,7 @@
>  #define PWRAP_CAP_DCM          BIT(2)
>  #define PWRAP_CAP_INT1_EN      BIT(3)
>  #define PWRAP_CAP_WDT_SRC1     BIT(4)
> +#define PWRAP_CAP_ARB          BIT(5)
>
>  /* defines for slave device wrapper registers */
>  enum dew_regs {
> @@ -340,6 +343,8 @@ enum pwrap_regs {
>         PWRAP_DCM_DBC_PRD,
>         PWRAP_EINT_STA0_ADR,
>         PWRAP_EINT_STA1_ADR,
> +       PWRAP_SWINF_2_WDATA_31_0,
> +       PWRAP_SWINF_2_RDATA_31_0,
>
>         /* MT2701 only regs */
>         PWRAP_ADC_CMD_ADDR,
> @@ -1108,16 +1113,30 @@ static void pwrap_writel(struct pmic_wrapper *wrp, u32 val, enum pwrap_regs reg)
>
>  static bool pwrap_is_fsm_idle(struct pmic_wrapper *wrp)
>  {
> -       u32 val = pwrap_readl(wrp, PWRAP_WACS2_RDATA);
> +       u32 val;
> +       bool ret;
> +
> +       val = pwrap_readl(wrp, PWRAP_WACS2_RDATA);
> +       if (!HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
> +               ret = (PWRAP_GET_WACS_FSM(val) == PWRAP_WACS_FSM_IDLE);
> +       else
> +               ret = (PWRAP_GET_SWINF_2_FSM(val) == PWRAP_WACS_FSM_IDLE);
>
> -       return PWRAP_GET_WACS_FSM(val) == PWRAP_WACS_FSM_IDLE;
> +       return ret;

Those !HAS_CAP tests are a little hard to read. Also, ret isn't really needed.

So I'd do this:
if (HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
    return PWRAP_GET_SWINF_2_FSM(val) == PWRAP_WACS_FSM_IDLE;

return PWRAP_GET_WACS_FSM(val) == PWRAP_WACS_FSM_IDLE;

>  }
>
>  static bool pwrap_is_fsm_vldclr(struct pmic_wrapper *wrp)
>  {
> -       u32 val = pwrap_readl(wrp, PWRAP_WACS2_RDATA);
> +       u32 val;
> +       bool ret;
> +
> +       val = pwrap_readl(wrp, PWRAP_WACS2_RDATA);
> +       if (!HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
> +               ret = (PWRAP_GET_WACS_FSM(val) == PWRAP_WACS_FSM_WFVLDCLR);
> +       else
> +               ret = (PWRAP_GET_SWINF_2_FSM(val) == PWRAP_WACS_FSM_WFVLDCLR);
>
> -       return PWRAP_GET_WACS_FSM(val) == PWRAP_WACS_FSM_WFVLDCLR;
> +       return ret;

ditto

>  }
>
>  /*
> @@ -1172,13 +1191,21 @@ static int pwrap_read16(struct pmic_wrapper *wrp, u32 adr, u32 *rdata)
>                 return ret;
>         }
>
> -       pwrap_writel(wrp, (adr >> 1) << 16, PWRAP_WACS2_CMD);
> +       if (!HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))

ditto, I'd reverse all these tests.

> +               pwrap_writel(wrp, (adr >> 1) << 16, PWRAP_WACS2_CMD);
> +       else
> +               pwrap_writel(wrp, adr, PWRAP_WACS2_CMD);

Not 100% convinced if worth it, but you could also do:

if (HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
   val = adr;
else
   val = (adr >> 1) << 16;

pwrap_writel(wrp, val, PWRAP_WACS2_CMD);

>
>         ret = pwrap_wait_for_state(wrp, pwrap_is_fsm_vldclr);
>         if (ret)
>                 return ret;
>
> -       *rdata = PWRAP_GET_WACS_RDATA(pwrap_readl(wrp, PWRAP_WACS2_RDATA));
> +       if (!HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
> +               *rdata = PWRAP_GET_WACS_RDATA(pwrap_readl(wrp,
> +                                             PWRAP_WACS2_RDATA));
> +       else
> +               *rdata = PWRAP_GET_WACS_RDATA(pwrap_readl(wrp,
> +                                             PWRAP_SWINF_2_RDATA_31_0));

Similarly:

if (HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
   val = pwrap_readl(wrp, PWRAP_SWINF_2_RDATA_31_0);
else
   val = pwrap_readl(wrp, PWRAP_WACS2_RDATA);

*rdata = PWRAP_GET_WACS_RDATA(val);

(or set the register address in an `reg` variable)

>
>         pwrap_writel(wrp, 1, PWRAP_WACS2_VLDCLR);
>
> @@ -1228,8 +1255,13 @@ static int pwrap_write16(struct pmic_wrapper *wrp, u32 adr, u32 wdata)
>                 return ret;
>         }
>
> -       pwrap_writel(wrp, (1 << 31) | ((adr >> 1) << 16) | wdata,
> -                    PWRAP_WACS2_CMD);
> +       if (!HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB)) {
> +               pwrap_writel(wrp, BIT(31) | ((adr >> 1) << 16) | wdata,
> +                            PWRAP_WACS2_CMD);
> +       } else {
> +               pwrap_writel(wrp, wdata, PWRAP_SWINF_2_WDATA_31_0);
> +               pwrap_writel(wrp, BIT(29) | adr, PWRAP_WACS2_CMD);
> +       }
>
>         return 0;
>  }
> @@ -2022,6 +2054,7 @@ MODULE_DEVICE_TABLE(of, of_pwrap_match_tbl);
>  static int pwrap_probe(struct platform_device *pdev)
>  {
>         int ret, irq;
> +       u32 rdata;
>         struct pmic_wrapper *wrp;
>         struct device_node *np = pdev->dev.of_node;
>         const struct of_device_id *of_slave_id = NULL;
> @@ -2116,14 +2149,22 @@ static int pwrap_probe(struct platform_device *pdev)
>                 }
>         }
>
> -       if (!(pwrap_readl(wrp, PWRAP_WACS2_RDATA) & PWRAP_STATE_INIT_DONE0)) {
> +       if (!HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
> +               rdata = pwrap_readl(wrp, PWRAP_WACS2_RDATA) &
> +                                   PWRAP_STATE_INIT_DONE0;
> +       else
> +               rdata = pwrap_readl(wrp, PWRAP_WACS2_RDATA) &
> +                                   PWRAP_STATE_INIT_DONE1;
> +       if (!rdata) {

Maybe:

if (HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
   mask_done = PWRAP_STATE_INIT_DONE1;
else
   mask_done = PWRAP_STATE_INIT_DONE0;

if (!(pwrap_readl(wrp, PWRAP_WACS2_RDATA) & mask_done)) {


>                 dev_dbg(wrp->dev, "initialization isn't finished\n");
>                 ret = -ENODEV;
>                 goto err_out2;
>         }
>
>         /* Initialize watchdog, may not be done by the bootloader */
> -       pwrap_writel(wrp, 0xf, PWRAP_WDT_UNIT);
> +       if (!HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
> +               pwrap_writel(wrp, 0xf, PWRAP_WDT_UNIT);
> +
>         /*
>          * Since STAUPD was not used on mt8173 platform,
>          * so STAUPD of WDT_SRC which should be turned off
> @@ -2132,7 +2173,11 @@ static int pwrap_probe(struct platform_device *pdev)
>         if (HAS_CAP(wrp->master->caps, PWRAP_CAP_WDT_SRC1))
>                 pwrap_writel(wrp, wrp->master->wdt_src, PWRAP_WDT_SRC_EN_1);
>
> -       pwrap_writel(wrp, 0x1, PWRAP_TIMER_EN);
> +       if (!HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
> +               pwrap_writel(wrp, 0x1, PWRAP_TIMER_EN);
> +       else
> +               pwrap_writel(wrp, 0x3, PWRAP_TIMER_EN);
> +
>         pwrap_writel(wrp, wrp->master->int_en_all, PWRAP_INT_EN);
>         /*
>          * We add INT1 interrupt to handle starvation and request exception
> --
> 2.6.4
