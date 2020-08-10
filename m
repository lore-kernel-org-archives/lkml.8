Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C2DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 08:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CAFF20768
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 08:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p6MuEI+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgHJIAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 04:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgHJIAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 04:00:23 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA963C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 01:00:23 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id g19so4375421plq.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 01:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zdq88gHxCb3jvrnqaljepUUsgAroF2d/K4zFPmR3yOk=;
        b=p6MuEI+XHuECK8OwzYOsOSGvE6HobWjnUYA/dLBvje7ek7CK2RJtTUwabVNR/CPshY
         alZdJZzx3Vum+SuA9bURQqqGZx8Zy8cQapS2hwbPXpmX9dJzmusmKy+1hRZrBty+HaWl
         r1vReZxNdXS2Y2f3U/kqS/I/+q4FXU/3kI9ad6rC5ljw085nCdc7Bz006PvJKbuidbND
         EjQdEVy66f3CuLilBwm+6pDuyytmwrt75zsB9pfBt6tV4KagZBBnO0k1LD8/2YOoww8/
         jj2GOO3ipclZ4+AKuCb5VBhDNM0ksSe0kiUwx9m0Ji+oGK5QJMUgZgDmvoHvGaSxX8Kd
         wXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zdq88gHxCb3jvrnqaljepUUsgAroF2d/K4zFPmR3yOk=;
        b=PY8hwhu2OsITGj3fiVW0DM8yTSuevrT1gqt68svVRh8tWyZQla+YcEka+MEuHspvgu
         qjRjzGGTmMk9Ru+57rpVg8u18jC13unlyRxJJQ1Yb2Kh9cwzjt/pUqqHBDelU1OMHDwu
         RdA28fGO/HFbfQ2Sh+ZLyrnl5Y/Y9XnyuYWBwVyPJLLzk9mGZsvE0w4iBFvSQoBnDEDq
         SoBiAvc3EnN9nHj9/FDIRVwcAV7EdgzZ50YAOwWEIugAV3mwn24bJK0FaypoHbjRtvsn
         LMs+Amhvopeh+4dTGF7wntsGWkmP6aPgaZTKLJKhOrshYJha/J6B3zOFxY+FP9D80j5e
         y26Q==
X-Gm-Message-State: AOAM532aLMEIsW5UOfl3umFB9YGt0uZnYP7vBEKvEmC8qH5bZkU3VF3N
        Y8damMmEimfxl3qAB2a70c4qcSIPKpY=
X-Google-Smtp-Source: ABdhPJz5gK1nHWJYyHM/CxrATPUeMggaRaBYXWAmyQyHAsKFcQ7z9aOcwMDd5eU2YSfcwWQ8LhWD7g==
X-Received: by 2002:a17:90b:255:: with SMTP id fz21mr25805953pjb.50.1597046423161;
        Mon, 10 Aug 2020 01:00:23 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id f18sm17456266pgv.84.2020.08.10.01.00.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Aug 2020 01:00:23 -0700 (PDT)
Date:   Mon, 10 Aug 2020 01:00:18 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_sai: Add -EPROBE_DEFER check for regmap init
Message-ID: <20200810080018.GA13408@Asurada-Nvidia>
References: <1596791682-4311-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596791682-4311-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 05:14:42PM +0800, Shengjiu Wang wrote:
> Regmap initialization may return -EPROBE_DEFER for clock
> may not be ready, so check -EPROBE_DEFER error type before
> start another Regmap initialization.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/fsl/fsl_sai.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index a22562f2df47..eb933fe9b6d1 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -927,7 +927,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
>  			"bus", base, &fsl_sai_regmap_config);
>  
>  	/* Compatible with old DTB cases */
> -	if (IS_ERR(sai->regmap))
> +	if (IS_ERR(sai->regmap) && PTR_ERR(sai->regmap) != -EPROBE_DEFER)
>  		sai->regmap = devm_regmap_init_mmio_clk(&pdev->dev,
>  				"sai", base, &fsl_sai_regmap_config);
>  	if (IS_ERR(sai->regmap)) {

In that case, might need a !EPROBE_DEFER check for this
fallback devm_regmap_init_mmio_clk at "sai" clock too?
