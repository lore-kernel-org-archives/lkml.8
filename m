Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09361C2BB86
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 02:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D62CE20732
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 02:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqZbwjSj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403952AbgDNCHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 22:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727867AbgDNCHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 22:07:39 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87938C0A3BDC;
        Mon, 13 Apr 2020 19:07:39 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id h69so2790056pgc.8;
        Mon, 13 Apr 2020 19:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5D/iZIZkZcDpS6kx/415RbCsRqRRwuRfxlRc0sHly4Y=;
        b=QqZbwjSjtSQpz3SlpqPldzbuhg+pariHVz063YbZ4QNr9Xz+hN6U5IXK6wCVyWLIv1
         oPKQ3EOsiwcSEXmEFvumckWdvyrHCNQ1pGubuZyHL6nP8oEhqyz6es8MI3/8nNZU5kk6
         vk+dFx8JFF93z87qrdOLMMGMSWOjEgD3ZPnOI/IUC+qVep5mOB9514q6OHOBmfT/B/vf
         okKTY4rNaBuRlKmOTYoF2/dRnATUq8OfPh5ML382ZwzwMhAuaJkut+dapH9nOuhGVCUc
         Qh/ZQsfd4d2EGHx1rgk2GmFcKtnBbSzVgSL+TQiWtxoxwnKTLZIo5/yj4qJKGHsftFzY
         YAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5D/iZIZkZcDpS6kx/415RbCsRqRRwuRfxlRc0sHly4Y=;
        b=Zvznq8DZi1e6maMU1wpNv0qAQpDeRG5Q1AdOJ2+K2eMGlzSN0fLxMGxYOrDegdrpgn
         DJf4XWlT7+TnrXZyiZ9pucbHHx41YmtR7XpAqACup+kSdBamEyBEMIAgZkgYTmGYa6jG
         3gEPD2sQ8RlpKPJz2zwQgAC52zcWNk76O1qSD0ehUbbj1um8yUJT31g1V3kEufHvlyaG
         KiLhJefEnkyZUwn+g1Eybvtve/tc2gTMmf5qyNtFgCsqN3pqvAQcwNmg/AjCUQxwkFy1
         ny9KhbcaP647a0wQRP5AaPbowHSCU2ZgeZQGumiPt+IxeQtlfI4aR1pKk8jSZUTgRS4X
         BF7w==
X-Gm-Message-State: AGi0PubVacDgM15ooEZ29HBpVkOJ34jhbQ3AtHlG1sEsRTakB3CySi9G
        D//+lPBhoGkNbT20D0J4tBk=
X-Google-Smtp-Source: APiQypLK639UxIA+FT+5Ot/3qPNoOsaHuQJ8finTEvj7k/GdLBDOknElzhbA4HM7L3jjPzj13KJKYA==
X-Received: by 2002:a63:5d7:: with SMTP id 206mr8048114pgf.136.1586830058811;
        Mon, 13 Apr 2020 19:07:38 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id y71sm9900161pfb.179.2020.04.13.19.07.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Apr 2020 19:07:38 -0700 (PDT)
Date:   Mon, 13 Apr 2020 19:07:49 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/7] ASoC: fsl_asrc: Move common definition to
 fsl_asrc_common
Message-ID: <20200414020748.GB10195@Asurada-Nvidia.nvidia.com>
References: <cover.1586747728.git.shengjiu.wang@nxp.com>
 <6d2bed91bcdbc3f75a9d12ac4ebf6c34c9bb9c3f.1586747728.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d2bed91bcdbc3f75a9d12ac4ebf6c34c9bb9c3f.1586747728.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 08:43:07AM +0800, Shengjiu Wang wrote:
> There is a new ASRC included in i.MX serial platform, there
> are some common definition can be shared with each other.
> So move the common definition to a separate header file.
> 
> And add fsl_asrc_pair_priv and fsl_asrc_priv for
> the variable specific for the module, which can be used
> internally.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> +static size_t fsl_asrc_get_pair_priv_size(void)
> +{
> +	return sizeof(struct fsl_asrc_pair_priv);
> +}

Perhaps we haven't understood completely each other's point.

Yet, would the following change work?

> diff --git a/sound/soc/fsl/fsl_asrc_common.h b/sound/soc/fsl/fsl_asrc_common.h
> new file mode 100644
> index 000000000000..b15244e027d0
> --- /dev/null
> +++ b/sound/soc/fsl/fsl_asrc_common.h
> +struct fsl_asrc {
> +	size_t (*get_pair_priv_size)(void);

+	size_t pair_priv_size;

> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> @@ -992,25 +1012,32 @@ static int fsl_asrc_probe(struct platform_device *pdev)
> +	asrc->get_pair_priv_size = fsl_asrc_get_pair_priv_size;

+	asrc->pair_priv_size = sizeof(struct fsl_asrc_pair_priv);

> diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
> @@ -311,11 +311,12 @@ static int fsl_asrc_dma_startup(struct snd_soc_component *component,
>  		return ret;
>  	}
>  
> -	pair = kzalloc(sizeof(struct fsl_asrc_pair), GFP_KERNEL);
> +	pair = kzalloc(sizeof(*pair) + asrc->get_pair_priv_size(), GFP_KERNEL);

+	pair = kzalloc(sizeof(*pair) + asrc->pair_priv_size, GFP_KERNEL);
