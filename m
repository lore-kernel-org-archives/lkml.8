Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875BCC35671
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3902082F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kYez6mqH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbgBXLi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 06:38:58 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39030 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgBXLi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 06:38:57 -0500
Received: by mail-wm1-f66.google.com with SMTP id c84so9012338wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 03:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YaVwweN+aW1ZCvHJhQTdqSj28sX6FFGNSbihhchPVRg=;
        b=kYez6mqHDaN2QlJo5jP1V1uZimfHQ9jdJwXu4K4TW5lh4MWBrDGoyrsRW7NolG00gT
         HjOQ/tQlKcPQiAaxdiVteQgNTPNoqguqCxYivYk/wiMYPsz0Dw5lU2msyD+5n1C18MrU
         CHWeuUKRlT/KUT3wqn6xbgiJzl97ogAHL8ZUZmsTQfTaq4vC8AMJYugY9n4kW/XLeoNH
         I5GOHGSS5sbMPQazJI3ib8LBjFKHtQBF2MLyzRnjx9IoJL64VKHshjulyrKUjWmyN+UN
         eqpvq/nCyvK3lIQxuWgsfzoxgxZAMQTODMnrr21Eo2IbuZkSoHedFOebtZ8rlli0zzt3
         KaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YaVwweN+aW1ZCvHJhQTdqSj28sX6FFGNSbihhchPVRg=;
        b=kvKOUAn0Xo2FTp2JuIKoqMgXPPqaIAahXtsAe5GLCUQpmfBhflS46jsGWMvrvFCFZh
         Bhj+nfxhyfm4w1/ZMky4r5tEGMdZuw7URKGzbKcFmeLPZhCqP/ger5vH503+DSwnnoxa
         +tJLXYvR2QVk7DZ1YHN3LH3nDNauWA88F1AWEdlEK0aoinmuc9YkzrUrQPSxTDpuGlwN
         ZuHGNQVqKccX7hXexDPDcPqa1d9Pg8j0KbS1fbtUT3ZHpeB8nSDgmkZ5hUl+ibFJTTqW
         yFWYgBBT1aYOPEAs11Z7jIqqC/aQ42eQJRDGoDPZLHoPKxPEbSkFQDREVudwjWfM4ioy
         zbuQ==
X-Gm-Message-State: APjAAAXKwPcgkuqYKtVQAxAFxr6dHOrXvX9+zpXvmo7ANNgzdCzMHbX3
        SsQDAplDNM/mQcKaudtYbq6lTw==
X-Google-Smtp-Source: APXvYqwWZw+MC/+NeJW1pCU8kARU161lx+zVhbRPwDhs8FF72zbQu2fF5sJsbWI5fLprolMJPlcfug==
X-Received: by 2002:a1c:7d8b:: with SMTP id y133mr22313770wmc.165.1582544336115;
        Mon, 24 Feb 2020 03:38:56 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id e11sm7572535wrm.80.2020.02.24.03.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 03:38:55 -0800 (PST)
Date:   Mon, 24 Feb 2020 11:39:26 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     arnd@arndb.de, zhang.lyra@gmail.com, orsonzhai@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] mfd: sc27xx: Add USB charger type detection
 support
Message-ID: <20200224113926.GU3494@dell>
References: <049eb16cf995d3a2dd0de01f4c0ed09965e36f92.1581906151.git.baolin.wang7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <049eb16cf995d3a2dd0de01f4c0ed09965e36f92.1581906151.git.baolin.wang7@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020, Baolin Wang wrote:

> The Spreadtrum SC27XX series PMICs supply the USB charger type detection
> function, and related registers are located on the PMIC global registers
> region, thus we implement and export this function in the MFD driver for
> users to get the USB charger type.
> 
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> ---
>  drivers/mfd/sprd-sc27xx-spi.c   |   52 +++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/sc27xx-pmic.h |    7 ++++++
>  2 files changed, 59 insertions(+)
>  create mode 100644 include/linux/mfd/sc27xx-pmic.h

[...]

> +enum usb_charger_type sprd_pmic_detect_charger_type(struct device *dev)
> +{
> +	struct spi_device *spi = to_spi_device(dev);
> +	struct sprd_pmic *ddata = spi_get_drvdata(spi);
> +	const struct sprd_pmic_data *pdata = ddata->pdata;
> +	enum usb_charger_type type;
> +	u32 val;
> +	int ret;
> +
> +	ret = regmap_read_poll_timeout(ddata->regmap, pdata->charger_det, val,
> +				       (val & SPRD_PMIC_CHG_DET_DONE),
> +				       SPRD_PMIC_CHG_DET_DELAY_US,
> +				       SPRD_PMIC_CHG_DET_TIMEOUT);
> +	if (ret) {
> +		dev_err(&spi->dev, "failed to detect charger type\n");
> +		return UNKNOWN_TYPE;
> +	}
> +
> +	switch (val & SPRD_PMIC_CHG_TYPE_MASK) {
> +	case SPRD_PMIC_CDP_TYPE:
> +		type = CDP_TYPE;
> +		break;
> +	case SPRD_PMIC_DCP_TYPE:
> +		type = DCP_TYPE;
> +		break;
> +	case SPRD_PMIC_SDP_TYPE:
> +		type = SDP_TYPE;
> +		break;
> +	default:
> +		type = UNKNOWN_TYPE;
> +		break;
> +	}
> +
> +	return type;
> +}
> +EXPORT_SYMBOL_GPL(sprd_pmic_detect_charger_type);

Where is this called from?

Why isn't the charger type detected in the charger driver?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
