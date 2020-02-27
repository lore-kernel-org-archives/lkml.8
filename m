Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EF3C4BA06
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 03:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1A82467A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 03:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmPw2xDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgB0DlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 22:41:25 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44412 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbgB0DlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 22:41:25 -0500
Received: by mail-pl1-f193.google.com with SMTP id d9so546524plo.11;
        Wed, 26 Feb 2020 19:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VUxAWoyzRwTi4XcElESOl4e7XyRqkwqcDDvJbUZpLIg=;
        b=gmPw2xDsx9eKdgHlZEL2xC7Li/8YBXlNbCA+spXw9KKfoPRWYY0KhEEeVo4KC2o1UN
         YrNfxZD2lybH9mVLDj+vW/MJcIbegJHj1PeRAO04tnf28Bv/GJDG5lEc0zPKDTubtW6+
         N7IuMJPmP3mVcy8XVAlTdaqT1E2JxhEK5v/xdHjeyy807augrdOuYwNg+xDbcKfjDq9v
         jHAcRGuwNzIN3Yw/yuXMpKSZYqA5MZXi+2ZxZzj23cJPP3h3/A246g+LJnfnF+zURjDt
         uuHLQb7zdWVZ7jWWWGre5ezDmXMZasplcYWQ8/KYy346t8KZDjAG1MAvSBaQZYpcfvF7
         BXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VUxAWoyzRwTi4XcElESOl4e7XyRqkwqcDDvJbUZpLIg=;
        b=Z537Q/JEEc3PjDQ0cEKF36+g/h6AMbgQXux1TS0qE+iWz+B44iHkSOBELS8VW3oNgy
         6mEEi/qfMxVmCUSPugm3wPGQdJEXA9oiQVgL3JpsUhCrN6bdPEX3La8nTpqnwYLjRL3O
         D4z9d6Hv6V4aY/7m3laSqU69UxNVFJgdj6aWbbcNKVdVxhtU1FJqV2tiI9looFJr6iQP
         SHFCFYbCvmTqMjMYso3VMFKhUL2lqT4NeHF0mfNC/xAXHGDX91naeOu/cZfK3ipym0Yt
         A8nnD5lyDjm4S+n3i44UHd38ZQ5odr0gu2iFObqL9pOrlxw8MkfG0ZosSUjTnAYF92so
         RojA==
X-Gm-Message-State: APjAAAXUngrtG4rjSGwN1Q6VsFzs6DUXERz/1bEnOmixz8FwXhxk0Ukx
        f0DwmYqHzU824zuLBF1Bsb8=
X-Google-Smtp-Source: APXvYqwu67NFja14RMtsEQ5nHb9nwgFD7snOj2gBrL1Jp1A8X2Zh72CwRRaPQ6P9a1KCWadgsyQGaQ==
X-Received: by 2002:a17:902:7b94:: with SMTP id w20mr2521900pll.257.1582774883581;
        Wed, 26 Feb 2020 19:41:23 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id e1sm4658282pff.188.2020.02.26.19.41.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Feb 2020 19:41:23 -0800 (PST)
Date:   Wed, 26 Feb 2020 19:41:21 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] ASoC: fsl_asrc: Change asrc_width to asrc_format
Message-ID: <20200227034121.GA20540@Asurada-Nvidia.nvidia.com>
References: <cover.1582770784.git.shengjiu.wang@nxp.com>
 <ffd5ff2fd0e8ad03a97f6a640630cff767d73fa7.1582770784.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffd5ff2fd0e8ad03a97f6a640630cff767d73fa7.1582770784.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 10:41:55AM +0800, Shengjiu Wang wrote:
> asrc_format is more inteligent variable, which is align
> with the alsa definition snd_pcm_format_t.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/fsl/fsl_asrc.c     | 23 +++++++++++------------
>  sound/soc/fsl/fsl_asrc.h     |  4 ++--
>  sound/soc/fsl/fsl_asrc_dma.c |  2 +-
>  3 files changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index 0dcebc24c312..2b6a1643573c 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c

> @@ -600,11 +599,6 @@ static int fsl_asrc_dai_hw_params(struct snd_pcm_substream *substream,
>  
>  	pair->config = &config;
>  
> -	if (asrc_priv->asrc_width == 16)
> -		format = SNDRV_PCM_FORMAT_S16_LE;
> -	else
> -		format = SNDRV_PCM_FORMAT_S24_LE;

It feels better to me that we have format settings in hw_params().

Why not let fsl_easrc align with this? Any reason that I'm missing?
