Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7707C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 22:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAB0020720
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 22:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQr8G7+k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731388AbgGUWvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 18:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgGUWvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 18:51:14 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC27C061794;
        Tue, 21 Jul 2020 15:51:13 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b6so61484wrs.11;
        Tue, 21 Jul 2020 15:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zuRS0cBjdAk4JpMAixOi1X4SFouP+cA7vWat6cDR9Ps=;
        b=XQr8G7+kCIdQ6L3ox63LTwpodFAJ/JpDdHcAF+y5jkD6vbDkqjKGdd3jsZM3dWjzeD
         j/xKFUYJxR4aFxEkgTJnltrLx5DMRnhBqihdmlB9GxmWZVAiv7LoOBkm42wZ2tIY9yOp
         LnXgbkZoYXHXdouYTMUq6qoWrhnpIYf6w19g4u4MyZb/X7fAx/T6aPyli41jRsEuh2RJ
         RU8BpNvYhYmWx/UUpNb+XbJztBEFuTyc1dNJbnlwWCQ1b33u49pgfvcyh03+Z0qK2J9H
         NEJlQpbG3WgXe2oUfNf8IWN6DVaLehtlOPYUzO7DksrvHWRqWsMa+a/QOQml/hYFBtb5
         J2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zuRS0cBjdAk4JpMAixOi1X4SFouP+cA7vWat6cDR9Ps=;
        b=JiZ3nBZGCSuX/FiXXRSHny+0zqyk1ywzVjopqD/zyPur2ZZoGpIDtntLx0xlJvh48q
         9VQdLbCHn1xxHWLvmvy99hALqHGHIECCL1O11LYQvvcVF9nq/wFCGUXbX+kBbyP+n/Un
         BD8xm5e1rMkaocZMhvTyfaIkHxVlhvK6xZEo2nKiriAJXcD+rqKHUdL+jj5XgDdtnke9
         /laL/48DbdywCc4nKN5gZLvUyJSC+KkeUf6PbXK41Lr6b0icilVAqaHGP35rfHgCzPkj
         m/+JlMTpL1KGZXHehsKHyLEtBnZiW1uM5GHe9x8LWWdQz1s/CQDFsRjKqo49DkxOWIfC
         hV+A==
X-Gm-Message-State: AOAM533BcuW6/nX5dqoEfRAbAp25Ke7WmvXW7kh0HpSGfKKlEyuwy+lY
        eywPb4p2xdRj+86asARFWmg=
X-Google-Smtp-Source: ABdhPJzwsLBrMPa05EzVTT1R7JfYOeysZ/Vtgw5o8io8SILIabbjk2iE3h8LpsFepchZ40E0tAFAyQ==
X-Received: by 2002:a5d:438c:: with SMTP id i12mr12999296wrq.210.1595371872464;
        Tue, 21 Jul 2020 15:51:12 -0700 (PDT)
Received: from ziggy.stardust ([213.195.122.158])
        by smtp.gmail.com with ESMTPSA id g3sm44372329wrb.59.2020.07.21.15.51.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 15:51:11 -0700 (PDT)
Subject: Re: [PATCH 3/3] soc: mediatek: pwrap: add pwrap driver for
 MT6873/8192 SoCs
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Argus Lin <argus.lin@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com
References: <1594720432-19586-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1594720432-19586-4-git-send-email-hsin-hsiung.wang@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <e80b2e38-1324-a038-5647-6f595381ba47@gmail.com>
Date:   Wed, 22 Jul 2020 00:51:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1594720432-19586-4-git-send-email-hsin-hsiung.wang@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/07/2020 11:53, Hsin-Hsiung Wang wrote:
> MT6873/8192 are highly integrated SoCs and use PMIC_MT6359 for
> power management. This patch adds pwrap master driver to
> access PMIC_MT6359.
> 
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
>   drivers/soc/mediatek/mtk-pmic-wrap.c | 98 ++++++++++++++++++++++++++++++++----
>   1 file changed, 87 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index c897205..6e7f796f 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -24,11 +24,13 @@
>   #define PWRAP_MT8135_BRIDGE_WDT_SRC_EN		0x54
>   
>   /* macro for wrapper status */
> +#define PWRAP_GET_SWINF_2_FSM(x)	(((x) >> 1) & 0x00000007)
>   #define PWRAP_GET_WACS_RDATA(x)		(((x) >> 0) & 0x0000ffff)
>   #define PWRAP_GET_WACS_FSM(x)		(((x) >> 16) & 0x00000007)
>   #define PWRAP_GET_WACS_REQ(x)		(((x) >> 19) & 0x00000001)
>   #define PWRAP_STATE_SYNC_IDLE0		BIT(20)
>   #define PWRAP_STATE_INIT_DONE0		BIT(21)
> +#define PWRAP_STATE_INIT_DONE1		BIT(15)
>   
>   /* macro for WACS FSM */
>   #define PWRAP_WACS_FSM_IDLE		0x00
> @@ -74,6 +76,7 @@
>   #define PWRAP_CAP_DCM		BIT(2)
>   #define PWRAP_CAP_INT1_EN	BIT(3)
>   #define PWRAP_CAP_WDT_SRC1	BIT(4)
> +#define PWRAP_CAP_ARB		BIT(5)

This commit should be two patches (at least). One adding PWRAP_CAP_ARB and then 
another one adding MT6873 support.

Regards,
Matthias

>   
>   /* defines for slave device wrapper registers */
>   enum dew_regs {
> @@ -348,6 +351,10 @@ enum pwrap_regs {
>   	PWRAP_ADC_RDATA_ADDR1,
>   	PWRAP_ADC_RDATA_ADDR2,
>   
> +	/* MT6873 only regs */
> +	PWRAP_SWINF_2_WDATA_31_0,
> +	PWRAP_SWINF_2_RDATA_31_0,
> +
>   	/* MT7622 only regs */
>   	PWRAP_STA,
>   	PWRAP_CLR,
> @@ -627,6 +634,17 @@ static int mt6797_regs[] = {
>   	[PWRAP_DCM_DBC_PRD] =		0x1D4,
>   };
>   
> +static int mt6873_regs[] = {
> +	[PWRAP_INIT_DONE2] =		0x0,
> +	[PWRAP_TIMER_EN] =		0x3E0,
> +	[PWRAP_INT_EN] =		0x448,
> +	[PWRAP_WACS2_CMD] =		0xC80,
> +	[PWRAP_SWINF_2_WDATA_31_0] =	0xC84,
> +	[PWRAP_SWINF_2_RDATA_31_0] =	0xC94,
> +	[PWRAP_WACS2_VLDCLR] =		0xCA4,
> +	[PWRAP_WACS2_RDATA] =		0xCA8,
> +};
> +
>   static int mt7622_regs[] = {
>   	[PWRAP_MUX_SEL] =		0x0,
>   	[PWRAP_WRAP_EN] =		0x4,
> @@ -1045,6 +1063,7 @@ enum pwrap_type {
>   	PWRAP_MT6765,
>   	PWRAP_MT6779,
>   	PWRAP_MT6797,
> +	PWRAP_MT6873,
>   	PWRAP_MT7622,
>   	PWRAP_MT8135,
>   	PWRAP_MT8173,
> @@ -1108,16 +1127,30 @@ static void pwrap_writel(struct pmic_wrapper *wrp, u32 val, enum pwrap_regs reg)
>   
>   static bool pwrap_is_fsm_idle(struct pmic_wrapper *wrp)
>   {
> -	u32 val = pwrap_readl(wrp, PWRAP_WACS2_RDATA);
> +	u32 val;
> +	bool ret;
> +
> +	val = pwrap_readl(wrp, PWRAP_WACS2_RDATA);
> +	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
> +		ret = (PWRAP_GET_SWINF_2_FSM(val) == PWRAP_WACS_FSM_IDLE);
> +	else
> +		ret = (PWRAP_GET_WACS_FSM(val) == PWRAP_WACS_FSM_IDLE);
>   
> -	return PWRAP_GET_WACS_FSM(val) == PWRAP_WACS_FSM_IDLE;
> +	return ret;
>   }
>   
>   static bool pwrap_is_fsm_vldclr(struct pmic_wrapper *wrp)
>   {
> -	u32 val = pwrap_readl(wrp, PWRAP_WACS2_RDATA);
> +	u32 val;
> +	bool ret;
> +
> +	val = pwrap_readl(wrp, PWRAP_WACS2_RDATA);
> +	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
> +		ret = (PWRAP_GET_SWINF_2_FSM(val) == PWRAP_WACS_FSM_WFVLDCLR);
> +	else
> +		ret = (PWRAP_GET_WACS_FSM(val) == PWRAP_WACS_FSM_WFVLDCLR);
>   
> -	return PWRAP_GET_WACS_FSM(val) == PWRAP_WACS_FSM_WFVLDCLR;
> +	return ret;
>   }
>   
>   /*
> @@ -1172,13 +1205,21 @@ static int pwrap_read16(struct pmic_wrapper *wrp, u32 adr, u32 *rdata)
>   		return ret;
>   	}
>   
> -	pwrap_writel(wrp, (adr >> 1) << 16, PWRAP_WACS2_CMD);
> +	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
> +		pwrap_writel(wrp, adr, PWRAP_WACS2_CMD);
> +	else
> +		pwrap_writel(wrp, (adr >> 1) << 16, PWRAP_WACS2_CMD);
>   
>   	ret = pwrap_wait_for_state(wrp, pwrap_is_fsm_vldclr);
>   	if (ret)
>   		return ret;
>   
> -	*rdata = PWRAP_GET_WACS_RDATA(pwrap_readl(wrp, PWRAP_WACS2_RDATA));
> +	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
> +		*rdata = PWRAP_GET_WACS_RDATA(pwrap_readl(wrp,
> +					      PWRAP_SWINF_2_RDATA_31_0));
> +	else
> +		*rdata = PWRAP_GET_WACS_RDATA(pwrap_readl(wrp,
> +					      PWRAP_WACS2_RDATA));
>   
>   	pwrap_writel(wrp, 1, PWRAP_WACS2_VLDCLR);
>   
> @@ -1228,8 +1269,13 @@ static int pwrap_write16(struct pmic_wrapper *wrp, u32 adr, u32 wdata)
>   		return ret;
>   	}
>   
> -	pwrap_writel(wrp, (1 << 31) | ((adr >> 1) << 16) | wdata,
> -		     PWRAP_WACS2_CMD);
> +	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB)) {
> +		pwrap_writel(wrp, wdata, PWRAP_SWINF_2_WDATA_31_0);
> +		pwrap_writel(wrp, BIT(29) | adr, PWRAP_WACS2_CMD);
> +	} else {
> +		pwrap_writel(wrp, BIT(31) | ((adr >> 1) << 16) | wdata,
> +			     PWRAP_WACS2_CMD);
> +	}
>   
>   	return 0;
>   }
> @@ -1485,6 +1531,7 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
>   	case PWRAP_MT7622:
>   		pwrap_writel(wrp, 0, PWRAP_CIPHER_EN);
>   		break;
> +	case PWRAP_MT6873:
>   	case PWRAP_MT8183:
>   		break;
>   	}
> @@ -1921,6 +1968,19 @@ static const struct pmic_wrapper_type pwrap_mt6797 = {
>   	.init_soc_specific = NULL,
>   };
>   
> +static struct pmic_wrapper_type pwrap_mt6873 = {
> +	.regs = mt6873_regs,
> +	.type = PWRAP_MT6873,
> +	.arb_en_all = 0x777f,
> +	.int_en_all = BIT(4) | BIT(5),
> +	.int1_en_all = 0,
> +	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
> +	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
> +	.caps = PWRAP_CAP_ARB,
> +	.init_reg_clock = pwrap_common_init_reg_clock,
> +	.init_soc_specific = NULL,
> +};
> +
>   static const struct pmic_wrapper_type pwrap_mt7622 = {
>   	.regs = mt7622_regs,
>   	.type = PWRAP_MT7622,
> @@ -1999,6 +2059,9 @@ static const struct of_device_id of_pwrap_match_tbl[] = {
>   		.compatible = "mediatek,mt6797-pwrap",
>   		.data = &pwrap_mt6797,
>   	}, {
> +		.compatible = "mediatek,mt6873-pwrap",
> +		.data = &pwrap_mt6873,
> +	}, {
>   		.compatible = "mediatek,mt7622-pwrap",
>   		.data = &pwrap_mt7622,
>   	}, {
> @@ -2022,6 +2085,7 @@ MODULE_DEVICE_TABLE(of, of_pwrap_match_tbl);
>   static int pwrap_probe(struct platform_device *pdev)
>   {
>   	int ret, irq;
> +	u32 rdata;
>   	struct pmic_wrapper *wrp;
>   	struct device_node *np = pdev->dev.of_node;
>   	const struct of_device_id *of_slave_id = NULL;
> @@ -2116,14 +2180,22 @@ static int pwrap_probe(struct platform_device *pdev)
>   		}
>   	}
>   
> -	if (!(pwrap_readl(wrp, PWRAP_WACS2_RDATA) & PWRAP_STATE_INIT_DONE0)) {
> +	if (!HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
> +		rdata = pwrap_readl(wrp, PWRAP_WACS2_RDATA) &
> +				    PWRAP_STATE_INIT_DONE0;
> +	else
> +		rdata = pwrap_readl(wrp, PWRAP_WACS2_RDATA) &
> +				    PWRAP_STATE_INIT_DONE1;
> +	if (!rdata) {
>   		dev_dbg(wrp->dev, "initialization isn't finished\n");
>   		ret = -ENODEV;
>   		goto err_out2;
>   	}
>   
>   	/* Initialize watchdog, may not be done by the bootloader */
> -	pwrap_writel(wrp, 0xf, PWRAP_WDT_UNIT);
> +	if (!(HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB)))
> +		pwrap_writel(wrp, 0xf, PWRAP_WDT_UNIT);
> +
>   	/*
>   	 * Since STAUPD was not used on mt8173 platform,
>   	 * so STAUPD of WDT_SRC which should be turned off
> @@ -2132,7 +2204,11 @@ static int pwrap_probe(struct platform_device *pdev)
>   	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_WDT_SRC1))
>   		pwrap_writel(wrp, wrp->master->wdt_src, PWRAP_WDT_SRC_EN_1);
>   
> -	pwrap_writel(wrp, 0x1, PWRAP_TIMER_EN);
> +	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
> +		pwrap_writel(wrp, 0x3, PWRAP_TIMER_EN);
> +	else
> +		pwrap_writel(wrp, 0x1, PWRAP_TIMER_EN);
> +
>   	pwrap_writel(wrp, wrp->master->int_en_all, PWRAP_INT_EN);
>   	/*
>   	 * We add INT1 interrupt to handle starvation and request exception
> 
