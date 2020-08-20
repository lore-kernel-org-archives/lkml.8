Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FEAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 15:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7208E206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 15:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597937392;
	bh=FLYZzvI6qZvOBrZc6NGVhAboHpTPvwtXEgVM/dD6aW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ynYnByjYJKmj4IkSvL3KL67Kl7tYExFj1lCTKBcfeEzb0Jz7ITvSOHwuj1h+3/1ak
	 B2LH7jl6R58L5M1+/IAlOf+ey2Pu8oQLWCKzNSWwcOgoPG97/3BLg6Xl2NV3OfgWpx
	 2JXm2q7oRCWlpJIvJ+kGrVa6V+LDqMcFxgnkeKTY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgHTP3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 11:29:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40179 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbgHTP3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 11:29:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id l2so2428024wrc.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 08:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l7vM9zA2bl0VIVdITFGRlvEN94PC+ze3csdbSLab8aI=;
        b=sjOQHU28laAhJuL5CLfBN+yqh1rswyOiYl3eybJPPGG/ZpGEIB0EHlkBXaNb7jcvQ6
         +z6z3Ud5GIRZiDNCeGwpllfeJVPNj2MzPWWCk5wfyWNHxlByMOSIOoKVnoM0xUyIEJU8
         YPQPNexEJeA8F3dyMJiiNrIb3Mcll5rBY0chJP41bl9H+vAWTt8EwSua3+AUU2RaS4Ha
         MI9iEImpHOoYtW0WBjhYGeCFm0CGWCybn9uafwVfM84ws6algnVV1nwvFGJzi7SE5Yc8
         PJZHQl0PQnvCz/iP6piev0QCE4EZ0w8AFxrReAeV3eiKAoKMpKM/AdMNFxRZXyN3X74h
         80WQ==
X-Gm-Message-State: AOAM532OwRKfSu8EoGsQLkhXZXfcyVWhzohKAMW7AmLJbLog1kkkvOPX
        q1V3OVDi8QY0fI4CyDl3+PY=
X-Google-Smtp-Source: ABdhPJw4FMm8La7t7y8hXO1Lq1u3nZ58jXNmmht94PsXzJk1P30z+LFva57a5vdyIeqEil23i2ZnTw==
X-Received: by 2002:a05:6000:10c6:: with SMTP id b6mr3676401wrx.257.1597937387025;
        Thu, 20 Aug 2020 08:29:47 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id d7sm4877977wra.29.2020.08.20.08.29.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Aug 2020 08:29:46 -0700 (PDT)
Date:   Thu, 20 Aug 2020 17:29:44 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Alex Dewar <alex.dewar90@gmail.com>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memory: brcmstb_dpfe: Fix memory leak
Message-ID: <20200820152944.GB17144@kozik-lap>
References: <20200818110201.69933-1-alex.dewar90@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200818110201.69933-1-alex.dewar90@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 12:02:01PM +0100, Alex Dewar wrote:
> In brcmstb_dpfe_download_firmware(), memory is allocated to variable fw by
> firmware_request_nowarn(), but never released. Fix up to release fw on
> all return paths.
> 
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> ---
>  drivers/memory/brcmstb_dpfe.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
> index 60e8633b1175..f24a9dc65f3c 100644
> --- a/drivers/memory/brcmstb_dpfe.c
> +++ b/drivers/memory/brcmstb_dpfe.c
> @@ -616,7 +616,7 @@ static int brcmstb_dpfe_download_firmware(struct brcmstb_dpfe_priv *priv)
>  	const u32 *dmem, *imem;
>  	struct init_data init;
>  	const void *fw_blob;
> -	int ret;
> +	int ret = 0;

This does not look needed. Why initializing it? You cannot jump to
release_fw label or reach it without going through assignment.

Best regards,
Krzysztof

>  
>  	/*
>  	 * Skip downloading the firmware if the DCPU is already running and
> @@ -647,8 +647,10 @@ static int brcmstb_dpfe_download_firmware(struct brcmstb_dpfe_priv *priv)
>  		return (ret == -ENOENT) ? -EPROBE_DEFER : ret;
>  
>  	ret = __verify_firmware(&init, fw);
> -	if (ret)
> -		return -EFAULT;
> +	if (ret) {
> +		ret = -EFAULT;
> +		goto release_fw;
> +	}
>  
>  	__disable_dcpu(priv);
>  
> @@ -667,18 +669,20 @@ static int brcmstb_dpfe_download_firmware(struct brcmstb_dpfe_priv *priv)
>  
>  	ret = __write_firmware(priv->dmem, dmem, dmem_size, is_big_endian);
>  	if (ret)
> -		return ret;
> +		goto release_fw;
>  	ret = __write_firmware(priv->imem, imem, imem_size, is_big_endian);
>  	if (ret)
> -		return ret;
> +		goto release_fw;
>  
>  	ret = __verify_fw_checksum(&init, priv, header, init.chksum);
>  	if (ret)
> -		return ret;
> +		goto release_fw;
>  
>  	__enable_dcpu(priv);
>  
> -	return 0;
> +release_fw:
> +	release_firmware(fw);
> +	return ret;
>  }
>  
>  static ssize_t generic_show(unsigned int command, u32 response[],
> -- 
> 2.28.0
> 
