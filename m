Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2A5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6273420768
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="T6qovZ6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgHNRoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:44:14 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:31461 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgHNRoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1597427052;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=2Z0U+mcYwggZx3AXbVi+Ktpmy8/fEbXz6BZpJ2spCyk=;
        b=T6qovZ6gGx69JQRtyLHctdG3hJraUesAIXLyWkY+Rh2miOeslHrTk9Mm3z0Bb/CknC
        6mYko3Y0TrweA+wI9ImGEs0pqJT33isNkdkaWt+Xr/7tq988pfA6s70h5MfQ7nYDjBT+
        //xJ0mmqVvX2sAc5LYUsZd0EyrdOv5P5TZ+vlX9uchpHiEFv5byKbIo5MD2GBZTMyGyH
        jZ0/3oQGgdo3y0ERTsH7aluDgsl8E80SSVdKO8Oyp2FoJ1EcM7yxift3DGmziW2aZLzw
        U7hPzBSZoax/LRie6Pp1qdkXEm8+uBHYJNWy6+6ZyC9p7DqX7Yi1RDnSBP4zzYHQevmz
        qutA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j6Ic/MbIo="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.10.5 DYNA|AUTH)
        with ESMTPSA id Y0939ew7EHi94lK
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 14 Aug 2020 19:44:09 +0200 (CEST)
Date:   Fri, 14 Aug 2020 19:43:32 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com, tiwai@suse.com,
        john.stultz@linaro.org
Subject: Re: [PATCH] ASoC: msm8916-wcd-analog: fix register Interrupt offset
Message-ID: <20200814174332.GA314820@gerhold.net>
References: <20200811103452.20448-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811103452.20448-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 11:34:52AM +0100, Srinivas Kandagatla wrote:
> For some reason interrupt set and clear register offsets are
> not set correctly.
> This patch corrects them!
> 
> Fixes: 585e881e5b9e ("ASoC: codecs: Add msm8916-wcd analog codec")
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/codecs/msm8916-wcd-analog.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
> index 4428c62e25cf..3ddd822240e3 100644
> --- a/sound/soc/codecs/msm8916-wcd-analog.c
> +++ b/sound/soc/codecs/msm8916-wcd-analog.c
> @@ -19,8 +19,8 @@
>  
>  #define CDC_D_REVISION1			(0xf000)
>  #define CDC_D_PERPH_SUBTYPE		(0xf005)
> -#define CDC_D_INT_EN_SET		(0x015)
> -#define CDC_D_INT_EN_CLR		(0x016)
> +#define CDC_D_INT_EN_SET		(0xf015)
> +#define CDC_D_INT_EN_CLR		(0xf016)
>  #define MBHC_SWITCH_INT			BIT(7)
>  #define MBHC_MIC_ELECTRICAL_INS_REM_DET	BIT(6)
>  #define MBHC_BUTTON_PRESS_DET		BIT(5)
> -- 
> 2.21.0
> 

It's surprising that we didn't notice this before. Seems like the HW
has exactly the IRQs we want enabled by default. Everything seems to be
still working fine after this patch, so FWIW:

Tested-by: Stephan Gerhold <stephan@gerhold.net>
Reviewed-by: Stephan Gerhold <stephan@gerhold.net>

Thanks!
Stephan
