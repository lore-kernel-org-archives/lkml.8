Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3FAC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 03:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E0CC2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 03:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kma7Tvna"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgCKDOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 23:14:17 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:43200 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbgCKDOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 23:14:17 -0400
Received: by mail-vs1-f67.google.com with SMTP id 7so386405vsr.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 20:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xYwUciegLoUmC80zL9vJOXVRDnxOH2mkTDk31tr500o=;
        b=kma7TvnaUs14CAynENNhB9yMyXCLNtcX+aYaWo+QKVGodAO3cUufnRsCqYxRF+OqQG
         OJnWRsCWKVXflciiGN1gFbuiCGI2OnYJ/8yprBahXg4gqa3Jr1YNGNE8DETggWwqF/IK
         OvFgZTSZgTNZXZhXlkbh/RQF5OXbFr0sK67jE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xYwUciegLoUmC80zL9vJOXVRDnxOH2mkTDk31tr500o=;
        b=jTHFTDuZ7asCEF0JNR6/6WXVPUcSKhaveGg2phn14HVp0UZ/PpTDvXJX4SPnSdzvgH
         hqVGhpXvP2TD6MTmps2YX+GZSzEaEmbeKHzzEHhv8VdnXCT1uw+hkqrejyvrzdMORiUf
         o+U/PNS6DaimGMNIMx/3H5Q4Wu9TVvWW0ePVOLF1jy9txWb0jAN3oJxyui18qk83N2xc
         dCOK+CbR/QvtUUPsaL5pFsnIgcMj3kcl4pfZ1A7C79P3aIBjJi/0BJbeGxbgkj0x4x2m
         XNM15YwXOsDcScvDI2Knq8eIv8OS0dgFI4ZvBKLZfydG0AnLI0365ngxrPESPo7BGJvv
         BUPg==
X-Gm-Message-State: ANhLgQ2KDhZR+bap8Oksz3oHnKBsTyWjGjuSNtZfHCIwEBETftjorzQQ
        C846AxZ9hkg/xxIIbLIQA8q0ITmbojeeF8MYcZEVLw==
X-Google-Smtp-Source: ADFU+vv6UMRH1wtcZGia0LIimAxqqwzcUCmpByfY2SG1i3IMsl7POB0lt6NB5QfIGWx8nIhwio7eOjvKXR6Tc1ZJNVs=
X-Received: by 2002:a67:fe05:: with SMTP id l5mr700513vsr.186.1583896456343;
 Tue, 10 Mar 2020 20:14:16 -0700 (PDT)
MIME-Version: 1.0
References: <1581910527-1636-1-git-send-email-weiyi.lu@mediatek.com> <1581910527-1636-8-git-send-email-weiyi.lu@mediatek.com>
In-Reply-To: <1581910527-1636-8-git-send-email-weiyi.lu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 11 Mar 2020 11:14:05 +0800
Message-ID: <CANMq1KCL0qi3kXmhya7T_vBYreNmrCQGh6XTrk9qhU9eOWWnLQ@mail.gmail.com>
Subject: Re: [PATCH v12 07/10] soc: mediatek: Add extra sram control
To:     Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 11:35 AM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
>
> For some power domains like vpu_core on MT8183 whose sram need to
> do clock and internal isolation while power on/off sram.
> We add a cap "MTK_SCPD_SRAM_ISO" to judge if we need to do
> the extra sram isolation control or not.
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>

Still looks good to me, and addresses Matthias' comments AFAICT:

Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

> ---
>  drivers/soc/mediatek/mtk-scpsys.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index 2a9478f..98cc5ed 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -26,6 +26,7 @@
>
>  #define MTK_SCPD_ACTIVE_WAKEUP         BIT(0)
>  #define MTK_SCPD_FWAIT_SRAM            BIT(1)
> +#define MTK_SCPD_SRAM_ISO              BIT(2)
>  #define MTK_SCPD_CAPS(_scpd, _x)       ((_scpd)->data->caps & (_x))
>
>  #define SPM_VDE_PWR_CON                        0x0210
> @@ -57,6 +58,8 @@
>  #define PWR_ON_BIT                     BIT(2)
>  #define PWR_ON_2ND_BIT                 BIT(3)
>  #define PWR_CLK_DIS_BIT                        BIT(4)
> +#define PWR_SRAM_CLKISO_BIT            BIT(5)
> +#define PWR_SRAM_ISOINT_B_BIT          BIT(6)
>
>  #define PWR_STATUS_CONN                        BIT(1)
>  #define PWR_STATUS_DISP                        BIT(3)
> @@ -234,6 +237,14 @@ static int scpsys_sram_enable(struct scp_domain *scpd, void __iomem *ctl_addr)
>                         return ret;
>         }
>
> +       if (MTK_SCPD_CAPS(scpd, MTK_SCPD_SRAM_ISO))     {
> +               val = readl(ctl_addr) | PWR_SRAM_ISOINT_B_BIT;
> +               writel(val, ctl_addr);
> +               udelay(1);
> +               val &= ~PWR_SRAM_CLKISO_BIT;
> +               writel(val, ctl_addr);
> +       }
> +
>         return 0;
>  }
>
> @@ -243,8 +254,15 @@ static int scpsys_sram_disable(struct scp_domain *scpd, void __iomem *ctl_addr)
>         u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
>         int tmp;
>
> -       val = readl(ctl_addr);
> -       val |= scpd->data->sram_pdn_bits;
> +       if (MTK_SCPD_CAPS(scpd, MTK_SCPD_SRAM_ISO))     {
> +               val = readl(ctl_addr) | PWR_SRAM_CLKISO_BIT;
> +               writel(val, ctl_addr);
> +               val &= ~PWR_SRAM_ISOINT_B_BIT;
> +               writel(val, ctl_addr);
> +               udelay(1);
> +       }
> +
> +       val = readl(ctl_addr) | scpd->data->sram_pdn_bits;
>         writel(val, ctl_addr);
>
>         /* Either wait until SRAM_PDN_ACK all 1 or 0 */
> --
> 1.8.1.1.dirty
