Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C06C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3313D20748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQBFAeWN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgGJOGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgGJOGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 10:06:46 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047ADC08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 07:06:46 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 17so6040149wmo.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 07:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TH7UjbSD6D+LHAxYu9bFu/OZs5Ly4t7v8emN9EgJW90=;
        b=WQBFAeWNA2jJC0FRQpEjDcDdvXO7ez423gOqgGt/dxEvwSBVC+KriqLpmpbN9QCBZw
         YbEh+KYqkIPUztHYZWaIX9PIObUN7JKOI+g7jTHWYqTB3k1a+O/axi2m9ZldXTy7gKM8
         5eJvg99yYmVHeeKQ2fZBwAkDvuJzUL7huBDBuw4rFKO2pXEWz6xtv8sOC/hP9pJKhOs8
         xnh8PrpfqS0KmjZoW0m7ufNn98w/GJiEr1BFOvSJU8cr+jMvoxhtB4mhgaSCBwhBd//s
         g5kHuyzQvL9JU2ipuZ3cZCOUClE+fWfxihxSzaMPggrZSTNax2PNyITB7nsMD3x2eOAT
         z+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TH7UjbSD6D+LHAxYu9bFu/OZs5Ly4t7v8emN9EgJW90=;
        b=A+1UMnxKhcOfoBBW+FxhZW7+eTXl8qXoQNTvPmkRHLO9KZ1pfK7+NZOT3VYmUlVhpT
         eazice2Dt+Gc4farMhmAeXcnXBFggPYiBx7Pwi+oMl8OFBWJF0Sww6CC8h7wjph4zSZE
         L7/6Lk1jtZ+UdytJpjWlW7k9z5WoygJQj2J9NsiZTrivYhAeYyFZnllt5HzxWbwzdsM+
         Az3OfFu0DYPgkRmbjEoNmc2L3kGhRz6XEniuEir8pNlXNG17o18mVgNv0dfHXJGggXpN
         JDUhKhNBnHQNWRlh8T6Ea0aAhJh4VldXgdB4c/k7yls4ZXC6DwfrAIetanEFrAX/bxtU
         /spQ==
X-Gm-Message-State: AOAM5309JRW3nMY8vOCSfDzduA1D3bsPz+tYE+67kqg77OXmWrHRrpJY
        xW3ljWPE/qfOoFlEekJ02mc=
X-Google-Smtp-Source: ABdhPJz7keE+vdSGSWKFYjWGu1Z2llDJEFMWf1cnDfaEKMsgP+arDfQ95tMh1IIvJX6imXdt9l2TEg==
X-Received: by 2002:a7b:c84d:: with SMTP id c13mr5304299wml.170.1594390004267;
        Fri, 10 Jul 2020 07:06:44 -0700 (PDT)
Received: from ziggy.stardust ([213.195.114.245])
        by smtp.gmail.com with ESMTPSA id u84sm9635537wmg.7.2020.07.10.07.06.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 07:06:43 -0700 (PDT)
Subject: Re: [PATCH 1/4] mfd: mt6360: Refactor and fix code style
To:     Gene Chen <gene.chen.richtek@gmail.com>, lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, shufan_lee@richtek.com,
        cy_huang@richtek.com, benjamin.chao@mediatek.com
References: <1594117856-14343-1-git-send-email-gene.chen.richtek@gmail.com>
 <1594117856-14343-2-git-send-email-gene.chen.richtek@gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <b9540dc6-4d43-45e4-8878-15d2df24a268@gmail.com>
Date:   Fri, 10 Jul 2020 16:06:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1594117856-14343-2-git-send-email-gene.chen.richtek@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/07/2020 12:30, Gene Chen wrote:
> From: Gene Chen <gene_chen@richtek.com>
> 
> Rearrange include file.
> Remove brackets around raw numbers.
> Indicate sub-dev compatible name by using "-"
> Combine mt6360 pmic/ldo resouces into mt6360 regulator resources.
> Rename mt6360_pmu_data by mt6360_data.
> Rename mt6360_pmu by mt6360.

That seems like a lot of cosmetics. Why is this needed?
If you think that's needed it should be split up in different commits, each 
explaining in the commit message why you do that.

Regards,
Matthias

> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>   drivers/mfd/mt6360-core.c  | 293 ++++++++++++++++++++++-----------------------
>   include/linux/mfd/mt6360.h |   2 +-
>   2 files changed, 144 insertions(+), 151 deletions(-)
> 
> diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
> index e9cacc2..5dfc13e 100644
> --- a/drivers/mfd/mt6360-core.c
> +++ b/drivers/mfd/mt6360-core.c
> @@ -5,122 +5,121 @@
>    * Author: Gene Chen <gene_chen@richtek.com>
>    */
>   
> +#include <linux/kernel.h>
> +#include <linux/module.h>
>   #include <linux/i2c.h>
> -#include <linux/init.h>
> +#include <linux/crc8.h>
> +#include <linux/slab.h>
> +#include <linux/regmap.h>
>   #include <linux/interrupt.h>
> -#include <linux/kernel.h>
>   #include <linux/mfd/core.h>
> -#include <linux/module.h>
> -#include <linux/of_irq.h>
> -#include <linux/of_platform.h>
> -#include <linux/version.h>
>   
>   #include <linux/mfd/mt6360.h>
>   
>   /* reg 0 -> 0 ~ 7 */
> -#define MT6360_CHG_TREG_EVT		(4)
> -#define MT6360_CHG_AICR_EVT		(5)
> -#define MT6360_CHG_MIVR_EVT		(6)
> -#define MT6360_PWR_RDY_EVT		(7)
> +#define MT6360_CHG_TREG_EVT		4
> +#define MT6360_CHG_AICR_EVT		5
> +#define MT6360_CHG_MIVR_EVT		6
> +#define MT6360_PWR_RDY_EVT		7
>   /* REG 1 -> 8 ~ 15 */
> -#define MT6360_CHG_BATSYSUV_EVT		(9)
> -#define MT6360_FLED_CHG_VINOVP_EVT	(11)
> -#define MT6360_CHG_VSYSUV_EVT		(12)
> -#define MT6360_CHG_VSYSOV_EVT		(13)
> -#define MT6360_CHG_VBATOV_EVT		(14)
> -#define MT6360_CHG_VBUSOV_EVT		(15)
> +#define MT6360_CHG_BATSYSUV_EVT		9
> +#define MT6360_FLED_CHG_VINOVP_EVT	11
> +#define MT6360_CHG_VSYSUV_EVT		12
> +#define MT6360_CHG_VSYSOV_EVT		13
> +#define MT6360_CHG_VBATOV_EVT		14
> +#define MT6360_CHG_VBUSOV_EVT		15
>   /* REG 2 -> 16 ~ 23 */
>   /* REG 3 -> 24 ~ 31 */
> -#define MT6360_WD_PMU_DET		(25)
> -#define MT6360_WD_PMU_DONE		(26)
> -#define MT6360_CHG_TMRI			(27)
> -#define MT6360_CHG_ADPBADI		(29)
> -#define MT6360_CHG_RVPI			(30)
> -#define MT6360_OTPI			(31)
> +#define MT6360_WD_PMU_DET		25
> +#define MT6360_WD_PMU_DONE		26
> +#define MT6360_CHG_TMRI			27
> +#define MT6360_CHG_ADPBADI		29
> +#define MT6360_CHG_RVPI			30
> +#define MT6360_OTPI			31
>   /* REG 4 -> 32 ~ 39 */
> -#define MT6360_CHG_AICCMEASL		(32)
> -#define MT6360_CHGDET_DONEI		(34)
> -#define MT6360_WDTMRI			(35)
> -#define MT6360_SSFINISHI		(36)
> -#define MT6360_CHG_RECHGI		(37)
> -#define MT6360_CHG_TERMI		(38)
> -#define MT6360_CHG_IEOCI		(39)
> +#define MT6360_CHG_AICCMEASL		32
> +#define MT6360_CHGDET_DONEI		34
> +#define MT6360_WDTMRI			35
> +#define MT6360_SSFINISHI		36
> +#define MT6360_CHG_RECHGI		37
> +#define MT6360_CHG_TERMI		38
> +#define MT6360_CHG_IEOCI		39
>   /* REG 5 -> 40 ~ 47 */
> -#define MT6360_PUMPX_DONEI		(40)
> -#define MT6360_BAT_OVP_ADC_EVT		(41)
> -#define MT6360_TYPEC_OTP_EVT		(42)
> -#define MT6360_ADC_WAKEUP_EVT		(43)
> -#define MT6360_ADC_DONEI		(44)
> -#define MT6360_BST_BATUVI		(45)
> -#define MT6360_BST_VBUSOVI		(46)
> -#define MT6360_BST_OLPI			(47)
> +#define MT6360_PUMPX_DONEI		40
> +#define MT6360_BAT_OVP_ADC_EVT		41
> +#define MT6360_TYPEC_OTP_EVT		42
> +#define MT6360_ADC_WAKEUP_EVT		43
> +#define MT6360_ADC_DONEI		44
> +#define MT6360_BST_BATUVI		45
> +#define MT6360_BST_VBUSOVI		46
> +#define MT6360_BST_OLPI			47
>   /* REG 6 -> 48 ~ 55 */
> -#define MT6360_ATTACH_I			(48)
> -#define MT6360_DETACH_I			(49)
> -#define MT6360_QC30_STPDONE		(51)
> -#define MT6360_QC_VBUSDET_DONE		(52)
> -#define MT6360_HVDCP_DET		(53)
> -#define MT6360_CHGDETI			(54)
> -#define MT6360_DCDTI			(55)
> +#define MT6360_ATTACH_I			48
> +#define MT6360_DETACH_I			49
> +#define MT6360_QC30_STPDONE		51
> +#define MT6360_QC_VBUSDET_DONE		52
> +#define MT6360_HVDCP_DET		53
> +#define MT6360_CHGDETI			54
> +#define MT6360_DCDTI			55
>   /* REG 7 -> 56 ~ 63 */
> -#define MT6360_FOD_DONE_EVT		(56)
> -#define MT6360_FOD_OV_EVT		(57)
> -#define MT6360_CHRDET_UVP_EVT		(58)
> -#define MT6360_CHRDET_OVP_EVT		(59)
> -#define MT6360_CHRDET_EXT_EVT		(60)
> -#define MT6360_FOD_LR_EVT		(61)
> -#define MT6360_FOD_HR_EVT		(62)
> -#define MT6360_FOD_DISCHG_FAIL_EVT	(63)
> +#define MT6360_FOD_DONE_EVT		56
> +#define MT6360_FOD_OV_EVT		57
> +#define MT6360_CHRDET_UVP_EVT		58
> +#define MT6360_CHRDET_OVP_EVT		59
> +#define MT6360_CHRDET_EXT_EVT		60
> +#define MT6360_FOD_LR_EVT		61
> +#define MT6360_FOD_HR_EVT		62
> +#define MT6360_FOD_DISCHG_FAIL_EVT	63
>   /* REG 8 -> 64 ~ 71 */
> -#define MT6360_USBID_EVT		(64)
> -#define MT6360_APWDTRST_EVT		(65)
> -#define MT6360_EN_EVT			(66)
> -#define MT6360_QONB_RST_EVT		(67)
> -#define MT6360_MRSTB_EVT		(68)
> -#define MT6360_OTP_EVT			(69)
> -#define MT6360_VDDAOV_EVT		(70)
> -#define MT6360_SYSUV_EVT		(71)
> +#define MT6360_USBID_EVT		64
> +#define MT6360_APWDTRST_EVT		65
> +#define MT6360_EN_EVT			66
> +#define MT6360_QONB_RST_EVT		67
> +#define MT6360_MRSTB_EVT		68
> +#define MT6360_OTP_EVT			69
> +#define MT6360_VDDAOV_EVT		70
> +#define MT6360_SYSUV_EVT		71
>   /* REG 9 -> 72 ~ 79 */
> -#define MT6360_FLED_STRBPIN_EVT		(72)
> -#define MT6360_FLED_TORPIN_EVT		(73)
> -#define MT6360_FLED_TX_EVT		(74)
> -#define MT6360_FLED_LVF_EVT		(75)
> -#define MT6360_FLED2_SHORT_EVT		(78)
> -#define MT6360_FLED1_SHORT_EVT		(79)
> +#define MT6360_FLED_STRBPIN_EVT		72
> +#define MT6360_FLED_TORPIN_EVT		73
> +#define MT6360_FLED_TX_EVT		74
> +#define MT6360_FLED_LVF_EVT		75
> +#define MT6360_FLED2_SHORT_EVT		78
> +#define MT6360_FLED1_SHORT_EVT		79
>   /* REG 10 -> 80 ~ 87 */
> -#define MT6360_FLED2_STRB_EVT		(80)
> -#define MT6360_FLED1_STRB_EVT		(81)
> -#define MT6360_FLED2_STRB_TO_EVT	(82)
> -#define MT6360_FLED1_STRB_TO_EVT	(83)
> -#define MT6360_FLED2_TOR_EVT		(84)
> -#define MT6360_FLED1_TOR_EVT		(85)
> +#define MT6360_FLED2_STRB_EVT		80
> +#define MT6360_FLED1_STRB_EVT		81
> +#define MT6360_FLED2_STRB_TO_EVT	82
> +#define MT6360_FLED1_STRB_TO_EVT	83
> +#define MT6360_FLED2_TOR_EVT		84
> +#define MT6360_FLED1_TOR_EVT		85
>   /* REG 11 -> 88 ~ 95 */
>   /* REG 12 -> 96 ~ 103 */
> -#define MT6360_BUCK1_PGB_EVT		(96)
> -#define MT6360_BUCK1_OC_EVT		(100)
> -#define MT6360_BUCK1_OV_EVT		(101)
> -#define MT6360_BUCK1_UV_EVT		(102)
> +#define MT6360_BUCK1_PGB_EVT		96
> +#define MT6360_BUCK1_OC_EVT		100
> +#define MT6360_BUCK1_OV_EVT		101
> +#define MT6360_BUCK1_UV_EVT		102
>   /* REG 13 -> 104 ~ 111 */
> -#define MT6360_BUCK2_PGB_EVT		(104)
> -#define MT6360_BUCK2_OC_EVT		(108)
> -#define MT6360_BUCK2_OV_EVT		(109)
> -#define MT6360_BUCK2_UV_EVT		(110)
> +#define MT6360_BUCK2_PGB_EVT		104
> +#define MT6360_BUCK2_OC_EVT		108
> +#define MT6360_BUCK2_OV_EVT		109
> +#define MT6360_BUCK2_UV_EVT		110
>   /* REG 14 -> 112 ~ 119 */
> -#define MT6360_LDO1_OC_EVT		(113)
> -#define MT6360_LDO2_OC_EVT		(114)
> -#define MT6360_LDO3_OC_EVT		(115)
> -#define MT6360_LDO5_OC_EVT		(117)
> -#define MT6360_LDO6_OC_EVT		(118)
> -#define MT6360_LDO7_OC_EVT		(119)
> +#define MT6360_LDO1_OC_EVT		113
> +#define MT6360_LDO2_OC_EVT		114
> +#define MT6360_LDO3_OC_EVT		115
> +#define MT6360_LDO5_OC_EVT		117
> +#define MT6360_LDO6_OC_EVT		118
> +#define MT6360_LDO7_OC_EVT		119
>   /* REG 15 -> 120 ~ 127 */
> -#define MT6360_LDO1_PGB_EVT		(121)
> -#define MT6360_LDO2_PGB_EVT		(122)
> -#define MT6360_LDO3_PGB_EVT		(123)
> -#define MT6360_LDO5_PGB_EVT		(125)
> -#define MT6360_LDO6_PGB_EVT		(126)
> -#define MT6360_LDO7_PGB_EVT		(127)
> -
> -static const struct regmap_irq mt6360_pmu_irqs[] =  {
> +#define MT6360_LDO1_PGB_EVT		121
> +#define MT6360_LDO2_PGB_EVT		122
> +#define MT6360_LDO3_PGB_EVT		123
> +#define MT6360_LDO5_PGB_EVT		125
> +#define MT6360_LDO6_PGB_EVT		126
> +#define MT6360_LDO7_PGB_EVT		127
> +
> +static const struct regmap_irq mt6360_irqs[] =  {
>   	REGMAP_IRQ_REG_LINE(MT6360_CHG_TREG_EVT, 8),
>   	REGMAP_IRQ_REG_LINE(MT6360_CHG_AICR_EVT, 8),
>   	REGMAP_IRQ_REG_LINE(MT6360_CHG_MIVR_EVT, 8),
> @@ -211,15 +210,15 @@ static const struct regmap_irq mt6360_pmu_irqs[] =  {
>   
>   static int mt6360_pmu_handle_post_irq(void *irq_drv_data)
>   {
> -	struct mt6360_pmu_data *mpd = irq_drv_data;
> +	struct mt6360_data *data = irq_drv_data;
>   
> -	return regmap_update_bits(mpd->regmap,
> +	return regmap_update_bits(data->regmap,
>   		MT6360_PMU_IRQ_SET, MT6360_IRQ_RETRIG, MT6360_IRQ_RETRIG);
>   }
>   
> -static struct regmap_irq_chip mt6360_pmu_irq_chip = {
> -	.irqs = mt6360_pmu_irqs,
> -	.num_irqs = ARRAY_SIZE(mt6360_pmu_irqs),
> +static struct regmap_irq_chip mt6360_irq_chip = {
> +	.irqs = mt6360_irqs,
> +	.num_irqs = ARRAY_SIZE(mt6360_irqs),
>   	.num_regs = MT6360_PMU_IRQ_REGNUM,
>   	.mask_base = MT6360_PMU_CHG_MASK1,
>   	.status_base = MT6360_PMU_CHG_IRQ1,
> @@ -266,7 +265,7 @@ static const struct resource mt6360_led_resources[] = {
>   	DEFINE_RES_IRQ_NAMED(MT6360_FLED1_STRB_TO_EVT, "fled1_strb_to_evt"),
>   };
>   
> -static const struct resource mt6360_pmic_resources[] = {
> +static const struct resource mt6360_regulator_resources[] = {
>   	DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_PGB_EVT, "buck1_pgb_evt"),
>   	DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_OC_EVT, "buck1_oc_evt"),
>   	DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_OV_EVT, "buck1_ov_evt"),
> @@ -279,9 +278,6 @@ static const struct resource mt6360_pmic_resources[] = {
>   	DEFINE_RES_IRQ_NAMED(MT6360_LDO7_OC_EVT, "ldo7_oc_evt"),
>   	DEFINE_RES_IRQ_NAMED(MT6360_LDO6_PGB_EVT, "ldo6_pgb_evt"),
>   	DEFINE_RES_IRQ_NAMED(MT6360_LDO7_PGB_EVT, "ldo7_pgb_evt"),
> -};
> -
> -static const struct resource mt6360_ldo_resources[] = {
>   	DEFINE_RES_IRQ_NAMED(MT6360_LDO1_OC_EVT, "ldo1_oc_evt"),
>   	DEFINE_RES_IRQ_NAMED(MT6360_LDO2_OC_EVT, "ldo2_oc_evt"),
>   	DEFINE_RES_IRQ_NAMED(MT6360_LDO3_OC_EVT, "ldo3_oc_evt"),
> @@ -293,18 +289,16 @@ static const struct resource mt6360_ldo_resources[] = {
>   };
>   
>   static const struct mfd_cell mt6360_devs[] = {
> -	OF_MFD_CELL("mt6360_adc", mt6360_adc_resources,
> -		    NULL, 0, 0, "mediatek,mt6360_adc"),
> -	OF_MFD_CELL("mt6360_chg", mt6360_chg_resources,
> -		    NULL, 0, 0, "mediatek,mt6360_chg"),
> -	OF_MFD_CELL("mt6360_led", mt6360_led_resources,
> -		    NULL, 0, 0, "mediatek,mt6360_led"),
> -	OF_MFD_CELL("mt6360_pmic", mt6360_pmic_resources,
> -		    NULL, 0, 0, "mediatek,mt6360_pmic"),
> -	OF_MFD_CELL("mt6360_ldo", mt6360_ldo_resources,
> -		    NULL, 0, 0, "mediatek,mt6360_ldo"),
> -	OF_MFD_CELL("mt6360_tcpc", NULL,
> -		    NULL, 0, 0, "mediatek,mt6360_tcpc"),
> +	OF_MFD_CELL("mt6360-adc", mt6360_adc_resources,
> +		    NULL, 0, 0, "mediatek,mt6360-adc"),
> +	OF_MFD_CELL("mt6360-chg", mt6360_chg_resources,
> +		    NULL, 0, 0, "mediatek,mt6360-chg"),
> +	OF_MFD_CELL("mt6360-led", mt6360_led_resources,
> +		    NULL, 0, 0, "mediatek,mt6360-led"),
> +	OF_MFD_CELL("mt6360-regulator", mt6360_regulator_resources,
> +		    NULL, 0, 0, "mediatek,mt6360-regulator"),
> +	OF_MFD_CELL("mt6360-tcpc", NULL,
> +		    NULL, 0, 0, "mediatek,mt6360-tcpc"),
>   };
>   
>   static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] = {
> @@ -314,63 +308,63 @@ static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] = {
>   	MT6360_TCPC_SLAVEID,
>   };
>   
> -static int mt6360_pmu_probe(struct i2c_client *client)
> +static int mt6360_probe(struct i2c_client *client)
>   {
> -	struct mt6360_pmu_data *mpd;
> +	struct mt6360_data *data;
>   	unsigned int reg_data;
>   	int i, ret;
>   
> -	mpd = devm_kzalloc(&client->dev, sizeof(*mpd), GFP_KERNEL);
> -	if (!mpd)
> +	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
>   		return -ENOMEM;
>   
> -	mpd->dev = &client->dev;
> -	i2c_set_clientdata(client, mpd);
> +	data->dev = &client->dev;
> +	i2c_set_clientdata(client, data);
>   
> -	mpd->regmap = devm_regmap_init_i2c(client, &mt6360_pmu_regmap_config);
> -	if (IS_ERR(mpd->regmap)) {
> +	data->regmap = devm_regmap_init_i2c(client, &mt6360_pmu_regmap_config);
> +	if (IS_ERR(data->regmap)) {
>   		dev_err(&client->dev, "Failed to register regmap\n");
> -		return PTR_ERR(mpd->regmap);
> +		return PTR_ERR(data->regmap);
>   	}
>   
> -	ret = regmap_read(mpd->regmap, MT6360_PMU_DEV_INFO, &reg_data);
> +	ret = regmap_read(data->regmap, MT6360_PMU_DEV_INFO, &reg_data);
>   	if (ret) {
>   		dev_err(&client->dev, "Device not found\n");
>   		return ret;
>   	}
>   
> -	mpd->chip_rev = reg_data & CHIP_REV_MASK;
> -	if (mpd->chip_rev != CHIP_VEN_MT6360) {
> +	data->chip_rev = reg_data & CHIP_REV_MASK;
> +	if (data->chip_rev != CHIP_VEN_MT6360) {
>   		dev_err(&client->dev, "Device not supported\n");
>   		return -ENODEV;
>   	}
>   
> -	mt6360_pmu_irq_chip.irq_drv_data = mpd;
> -	ret = devm_regmap_add_irq_chip(&client->dev, mpd->regmap, client->irq,
> +	mt6360_irq_chip.irq_drv_data = data;
> +	ret = devm_regmap_add_irq_chip(&client->dev, data->regmap, client->irq,
>   				       IRQF_TRIGGER_FALLING, 0,
> -				       &mt6360_pmu_irq_chip, &mpd->irq_data);
> +				       &mt6360_irq_chip, &data->irq_data);
>   	if (ret) {
>   		dev_err(&client->dev, "Failed to add Regmap IRQ Chip\n");
>   		return ret;
>   	}
>   
> -	mpd->i2c[0] = client;
> +	data->i2c[0] = client;
>   	for (i = 1; i < MT6360_SLAVE_MAX; i++) {
> -		mpd->i2c[i] = devm_i2c_new_dummy_device(&client->dev,
> +		data->i2c[i] = devm_i2c_new_dummy_device(&client->dev,
>   							client->adapter,
>   							mt6360_slave_addr[i]);
> -		if (IS_ERR(mpd->i2c[i])) {
> +		if (IS_ERR(data->i2c[i])) {
>   			dev_err(&client->dev,
>   				"Failed to get new dummy I2C device for address 0x%x",
>   				mt6360_slave_addr[i]);
> -			return PTR_ERR(mpd->i2c[i]);
> +			return PTR_ERR(data->i2c[i]);
>   		}
> -		i2c_set_clientdata(mpd->i2c[i], mpd);
> +		i2c_set_clientdata(data->i2c[i], data);
>   	}
>   
>   	ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_AUTO,
>   				   mt6360_devs, ARRAY_SIZE(mt6360_devs), NULL,
> -				   0, regmap_irq_get_domain(mpd->irq_data));
> +				   0, regmap_irq_get_domain(data->irq_data));
>   	if (ret) {
>   		dev_err(&client->dev,
>   			"Failed to register subordinate devices\n");
> @@ -380,7 +374,7 @@ static int mt6360_pmu_probe(struct i2c_client *client)
>   	return 0;
>   }
>   
> -static int __maybe_unused mt6360_pmu_suspend(struct device *dev)
> +static int __maybe_unused mt6360_suspend(struct device *dev)
>   {
>   	struct i2c_client *i2c = to_i2c_client(dev);
>   
> @@ -390,7 +384,7 @@ static int __maybe_unused mt6360_pmu_suspend(struct device *dev)
>   	return 0;
>   }
>   
> -static int __maybe_unused mt6360_pmu_resume(struct device *dev)
> +static int __maybe_unused mt6360_resume(struct device *dev)
>   {
>   
>   	struct i2c_client *i2c = to_i2c_client(dev);
> @@ -401,25 +395,24 @@ static int __maybe_unused mt6360_pmu_resume(struct device *dev)
>   	return 0;
>   }
>   
> -static SIMPLE_DEV_PM_OPS(mt6360_pmu_pm_ops,
> -			 mt6360_pmu_suspend, mt6360_pmu_resume);
> +static SIMPLE_DEV_PM_OPS(mt6360_pm_ops, mt6360_suspend, mt6360_resume);
>   
> -static const struct of_device_id __maybe_unused mt6360_pmu_of_id[] = {
> -	{ .compatible = "mediatek,mt6360_pmu", },
> +static const struct of_device_id __maybe_unused mt6360_of_id[] = {
> +	{ .compatible = "mediatek,mt6360", },
>   	{},
>   };
> -MODULE_DEVICE_TABLE(of, mt6360_pmu_of_id);
> +MODULE_DEVICE_TABLE(of, mt6360_of_id);
>   
> -static struct i2c_driver mt6360_pmu_driver = {
> +static struct i2c_driver mt6360_driver = {
>   	.driver = {
> -		.name = "mt6360_pmu",
> -		.pm = &mt6360_pmu_pm_ops,
> -		.of_match_table = of_match_ptr(mt6360_pmu_of_id),
> +		.name = "mt6360",
> +		.pm = &mt6360_pm_ops,
> +		.of_match_table = of_match_ptr(mt6360_of_id),
>   	},
> -	.probe_new = mt6360_pmu_probe,
> +	.probe_new = mt6360_probe,
>   };
> -module_i2c_driver(mt6360_pmu_driver);
> +module_i2c_driver(mt6360_driver);
>   
>   MODULE_AUTHOR("Gene Chen <gene_chen@richtek.com>");
> -MODULE_DESCRIPTION("MT6360 PMU I2C Driver");
> +MODULE_DESCRIPTION("MT6360 I2C Driver");
>   MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/mfd/mt6360.h b/include/linux/mfd/mt6360.h
> index ea13040..76077e4 100644
> --- a/include/linux/mfd/mt6360.h
> +++ b/include/linux/mfd/mt6360.h
> @@ -21,7 +21,7 @@ enum {
>   #define MT6360_LDO_SLAVEID	(0x64)
>   #define MT6360_TCPC_SLAVEID	(0x4E)
>   
> -struct mt6360_pmu_data {
> +struct mt6360_data {
>   	struct i2c_client *i2c[MT6360_SLAVE_MAX];
>   	struct device *dev;
>   	struct regmap *regmap;
> 
