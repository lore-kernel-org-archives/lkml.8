Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF16C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 01:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420532467E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 01:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583199697;
	bh=FCRHZFY4XwBLlkUSJjiRDLp68eLVuwbkrGsACThosxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XvbDL8kwUAPvyGGBaN6N/G/5HeykTwb0kCz9WFVKmq1wftmTzzCECaglK+tUhidpH
	 d3Rv2+MVV3d6WWhPYveo1E2u7cMRJrWb8bBBChI8Wt2q91Zq9Ird3TIwlj2hZ6/hbd
	 E+AINh3FPRRv195bwy7PiRrbt6hqmcXqce/7BH3c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgCCBlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 20:41:36 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43090 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgCCBlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 20:41:35 -0500
Received: by mail-ot1-f67.google.com with SMTP id j5so1392386otn.10;
        Mon, 02 Mar 2020 17:41:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wTmd93QvHJKnRP/iE9AlgpSex86ml4dgAiKBLvXi4d8=;
        b=HnL0eK6h39nv2tHEQnhGhARkA8qQrmgaxOsvpW4vJ4MCblOf+zNwQ4pw8Q1ku36cor
         AMXlHwWKlZQZfhnld1SqFCaHI22ZiEChPqatWLpSZwyhKv+f3fE3oEX33giTgHOHLQ9K
         pXACzouanLF8t8eKavNRzDWbSqTFBfCouBZtwnT1jGHwNODHPPxBwHEB48yCungETfpy
         mrA+eIs9NJNaDqyFbjksGfYgxxr93VjOxX0/NF+xBxmctqNaSDS5GssYXGXKGcB3cg9S
         V3QpuQy0ZcXGmc7lw3wNvjpOfrvfcaEFFbcx1LTsh6I+RGyVoRLEQC49ND/nhlAJm+Be
         hpqw==
X-Gm-Message-State: ANhLgQ2IPOYsEJG2gSa9nzSsbnDDmuSHanJYCuti2kgYo+UuBE3M0DVl
        bzecSE3J6bYqRlQ/pexKlA==
X-Google-Smtp-Source: ADFU+vsdNg78DFlU+1lj7jVL9V1hy4eNjciajaJxnlZGh0to9M1K+WoyXSAT3r6zp73f0HaM+PIrow==
X-Received: by 2002:a9d:836:: with SMTP id 51mr1698659oty.318.1583199694975;
        Mon, 02 Mar 2020 17:41:34 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 16sm6365123otc.33.2020.03.02.17.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 17:41:34 -0800 (PST)
Received: (nullmailer pid 25998 invoked by uid 1000);
        Tue, 03 Mar 2020 01:41:33 -0000
Date:   Mon, 2 Mar 2020 19:41:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, mark.rutland@arm.com, devicetree@vger.kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/8] ASoC: dt-bindings: fsl_asrc: Change asrc-width to
 asrc-format
Message-ID: <20200303014133.GA24596@bogus>
References: <cover.1583039752.git.shengjiu.wang@nxp.com>
 <872c2e1082de6348318e14ccd31884d62355c282.1583039752.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <872c2e1082de6348318e14ccd31884d62355c282.1583039752.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 01, 2020 at 01:24:12PM +0800, Shengjiu Wang wrote:
> asrc_format is more inteligent, which is align with the alsa
> definition snd_pcm_format_t, we don't need to convert it to
> format in driver, and it can distinguish S24_LE & S24_3LE.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl,asrc.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,asrc.txt b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> index cb9a25165503..0cbb86c026d5 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> @@ -38,7 +38,9 @@ Required properties:
>  
>     - fsl,asrc-rate	: Defines a mutual sample rate used by DPCM Back Ends.
>  
> -   - fsl,asrc-width	: Defines a mutual sample width used by DPCM Back Ends.
> +   - fsl,asrc-format	: Defines a mutual sample format used by DPCM Back
> +			  Ends. The value is one of SNDRV_PCM_FORMAT_XX in
> +			  "include/uapi/sound/asound.h"

You can't just change properties. They are an ABI.

>  
>     - fsl,asrc-clk-map   : Defines clock map used in driver. which is required
>  			  by imx8qm/imx8qxp platform
> -- 
> 2.21.0
> 
