Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E8BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B03B22081A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IxNJ+1Jt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732962AbgFWQy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 12:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732576AbgFWQy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:54:57 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319CDC061755
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 09:54:57 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id i27so24213789ljb.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 09:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ooMzjE9WFJyNnXxUflYIdbOsLymdxGSl5zf58v431ME=;
        b=IxNJ+1JtIzIGXMCnQ6UO6123d8G4fJCPmS098u927TcDhfdHOKPGlYUz/rQt0gJK3+
         Y9tElPyB+BcqwFwk8lE+tHDhpU+RIBse03WSrtFrJ6dWRHsp5CqNeGc5DHy/1eP0cr0G
         8Ln9Brt5cTHNtTY/pjDHwrYcuC4aLr30LTPZPrbRn1aHRbzfSRXEO91llwyzK6TiSvsU
         H+iIwRubMPpUZNOJfT1x+Nol8/rL2gubF16RVOWB3cqasfp7WwKYCxZAZEwBpwhwam7J
         RhSUWH8bn6YFuzvBFgt0nK8CT0YOWbwxJ7xEk3q5zUfDDM8cUZgH7soPhaF4ZG5Rf6wq
         UgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ooMzjE9WFJyNnXxUflYIdbOsLymdxGSl5zf58v431ME=;
        b=gvPfLDKKqo1If5qOvjfVlV3/iByQ0z1SJs0xUioZ87t/qqzBewIxE1wtPTsOlJKaLG
         ohJCFLa1N5PhQzfTIEG6FbLNsW5EJobK0AzxXiqKaXCMwnw1rZ/Fmq/hNVthvo6cte4g
         Q1u7iBboH5s5sIb6v5LWw/3GKtrgdkkkDK/5LSSBdYHlA3uYWXgHltQLK+KZEZ18+bMl
         9U6N/b7Habr/9HQOAzXNT8gLko7aFGxiErcdwE0tJZ0ZAkL1gTgqBB8nAptQo7sNLAzu
         SIXNdjk85NLKEFa22lMI3Eamor/iZ2pOAKSKrPH/sgsCAdQbD1gnzx3Ca+9JzK0jqAiR
         4PNA==
X-Gm-Message-State: AOAM531IGVcmCfB58HXjqHtV/YbUExLCdThmZ8sZ0qU7bJ/ZXE8a2Ov5
        UqmTQ8KLQZl0C4JldRu23+8Cyw==
X-Google-Smtp-Source: ABdhPJxc24WApjfS0ez0g26JY8PMYXzcFXTVqfl5l9fvYBr3otvIMWXPE6vGzZKJqAJFrcvvx7gtoA==
X-Received: by 2002:a2e:8858:: with SMTP id z24mr11893135ljj.128.1592931295540;
        Tue, 23 Jun 2020 09:54:55 -0700 (PDT)
Received: from [192.168.118.216] (37-144-159-139.broadband.corbina.ru. [37.144.159.139])
        by smtp.gmail.com with ESMTPSA id g14sm3963877ljl.117.2020.06.23.09.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 09:54:54 -0700 (PDT)
Subject: Re: [PATCH] media: i2c: imx290: replace msleep(10) with
 usleep_range(10000, 11000)
To:     mchehab@kernel.org, sakari.ailus@iki.fi,
        manivannan.sadhasivam@linaro.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, c.barrett@framos.com,
        a.brela@framos.com, peter.griffin@linaro.org
References: <20200623165226.12197-1-andrey.konovalov@linaro.org>
From:   Andrey Konovalov <andrey.konovalov@linaro.org>
Message-ID: <af22cf49-80d2-3ee7-c490-939065b38bfa@linaro.org>
Date:   Tue, 23 Jun 2020 19:54:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200623165226.12197-1-andrey.konovalov@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch should be applied on top of "[PATCH v5 00/10] Improvements to IMX290 CMOS driver" series.

Thanks,
Andrey

On 23.06.2020 19:52, Andrey Konovalov wrote:
> This fixes checkpatch warnings of "msleep < 20ms can sleep for up to 20ms".
> 
> Signed-off-by: Andrey Konovalov <andrey.konovalov@linaro.org>
> ---
>   drivers/media/i2c/imx290.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
> index 9c97830164e9..adcddf3204f7 100644
> --- a/drivers/media/i2c/imx290.c
> +++ b/drivers/media/i2c/imx290.c
> @@ -406,7 +406,7 @@ static int imx290_set_register_array(struct imx290 *imx290,
>   	}
>   
>   	/* Provide 10ms settle time */
> -	msleep(10);
> +	usleep_range(10000, 11000);
>   
>   	return 0;
>   }
> @@ -484,14 +484,14 @@ static int imx290_set_ctrl(struct v4l2_ctrl *ctrl)
>   		if (ctrl->val) {
>   			imx290_write_reg(imx290, IMX290_BLKLEVEL_LOW, 0x00);
>   			imx290_write_reg(imx290, IMX290_BLKLEVEL_HIGH, 0x00);
> -			msleep(10);
> +			usleep_range(10000, 11000);
>   			imx290_write_reg(imx290, IMX290_PGCTRL,
>   					 (u8)(IMX290_PGCTRL_REGEN |
>   					 IMX290_PGCTRL_THRU |
>   					 IMX290_PGCTRL_MODE(ctrl->val)));
>   		} else {
>   			imx290_write_reg(imx290, IMX290_PGCTRL, 0x00);
> -			msleep(10);
> +			usleep_range(10000, 11000);
>   			if (imx290->bpp == 10)
>   				imx290_write_reg(imx290, IMX290_BLKLEVEL_LOW,
>   						 0x3c);
> 
