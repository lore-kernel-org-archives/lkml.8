Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5675AC33CB7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 15:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C940206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 15:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KB/g7sTS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbgASPON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 10:14:13 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45884 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgASPON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 10:14:13 -0500
Received: by mail-lj1-f193.google.com with SMTP id j26so31233582ljc.12;
        Sun, 19 Jan 2020 07:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GrHGp0d4BmVw3WqnBEg850rc+eYg9sJP/HTzUcbcC/U=;
        b=KB/g7sTS0WmnqUZzzzFrUPHHY8rZ+Q2HkixRvNYVFpqdzcO3SCq9Bm9fSRBVMZgGrv
         VROO0Zu5JCH8ZtSqBiNZOcQhtQQg/w4W4cGRx7IYCM+rndIhkSo+k1uuIMb5Nh8hJhg9
         R6H5/EHWauts79cj6jsuqkHO9YeHR04IpiUwBx20tpTR6Pw6sg8lBrLAM1PUIYNodgfv
         bJyTGFOcT2N3LA0HR0lC0ewl/fMFLv0V6HR3swJimX5vbuQfC9Lp4rhRb4IieIKi86ON
         XR2Y7zIuwJV3g1iy08OKLjXUtv3bvRCdPLSKBI5T+yy+9/J4YyS19OsXnTlPmpDq3xqe
         OH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GrHGp0d4BmVw3WqnBEg850rc+eYg9sJP/HTzUcbcC/U=;
        b=NPWV/vjbZBqF37QZI85CpUwvSenIHcqo8r9UPMNRZxgEO0j+uk2q+8kHppKOSyCLOu
         bl/SqeZLR5sUh5mxF2R+cJJU5B+3IVXDE7O+CaLsRjIh5MgnQheLY6XmwAQuPy/42V/i
         NgdLZ9a5Gb7qrdYdFJQcpqqjGEBsQufAnHJXmq0IOFaAa6nTEdRETMadcmEcP5dYQLsD
         AREZlPOct99lGKEodgxMlMmDrEICM29GYEFPPR6GGJODZvnOk1iYD39zpiV8vH+o9+SE
         tDh+hJCL1wPzqKIes2PdJcHVCcLFPbCFpJVbD6sFgRcDE2rbIgzgKwG1j7sN/nQizqVO
         EK9w==
X-Gm-Message-State: APjAAAWs++CmzzufH16llYxaELdxegAn0iePvvmyKpnbkJQGj9RQr+/g
        XKKHPbp5/wsQx60O54WR5QgTh1SE
X-Google-Smtp-Source: APXvYqx2eT+IAjdXFNChF2tfzfuSJ7RWH9pEmjkaJ+PEAXBnJN7ozQqSofCMDfeKFsej7YGPA/asqQ==
X-Received: by 2002:a2e:9b05:: with SMTP id u5mr11147694lji.59.1579446850511;
        Sun, 19 Jan 2020 07:14:10 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id j19sm17747767lfb.90.2020.01.19.07.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jan 2020 07:14:09 -0800 (PST)
Subject: Re: [PATCH v8 19/22] ASoC: tegra: Enable audio mclk during
 tegra_asoc_utils_init
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, broonie@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com, spujar@nvidia.com,
        josephl@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1578986667-16041-1-git-send-email-skomatineni@nvidia.com>
 <1578986667-16041-20-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3a8e609a-58aa-d2c1-c140-e1f0127dd53b@gmail.com>
Date:   Sun, 19 Jan 2020 18:14:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1578986667-16041-20-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

14.01.2020 10:24, Sowjanya Komatineni пишет:
> Tegra PMC clock clk_out_1 is dedicated for audio mclk from Tegra30
> through Tegra210 and currently Tegra clock driver keeps the audio
> mclk enabled.
> 
> With the move of PMC clocks from clock driver into pmc driver,
> audio mclk enable from clock driver is removed and this should be
> taken care by the audio driver.
> 
> tegra_asoc_utils_init calls tegra_asoc_utils_set_rate and audio mclk
> rate configuration is not needed during init and set_rate is actually
> done during hw_params callback.
> 
> So, this patch removes tegra_asoc_utils_set_rate call and just leaves
> the audio mclk enabled.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  sound/soc/tegra/tegra_asoc_utils.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/tegra/tegra_asoc_utils.c b/sound/soc/tegra/tegra_asoc_utils.c
> index 1dce5ad6e665..99584970f5f4 100644
> --- a/sound/soc/tegra/tegra_asoc_utils.c
> +++ b/sound/soc/tegra/tegra_asoc_utils.c
> @@ -216,9 +216,16 @@ int tegra_asoc_utils_init(struct tegra_asoc_utils_data *data,
>  		data->clk_cdev1 = clk_out_1;
>  	}
>  
> -	ret = tegra_asoc_utils_set_rate(data, 44100, 256 * 44100);
> -	if (ret)
> +	/*
> +	 * FIXME: There is some unknown dependency between audio mclk disable
> +	 * and suspend-resume functionality on Tegra30, although audio mclk is
> +	 * only needed for audio.
> +	 */
> +	ret = clk_prepare_enable(data->clk_cdev1);
> +	if (ret) {
> +		dev_err(data->dev, "Can't enable cdev1: %d\n", ret);
>  		return ret;
> +	}
>  
>  	return 0;
>  }
> 

Shouldn't the clock be disabled on driver's removal?
