Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3891C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 05:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EFD420809
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 05:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLVq/MTQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbgFSFuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 01:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgFSFuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 01:50:04 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEC6C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 22:50:04 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id jz3so3642773pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 22:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uJunhxgU/GhtFdUD98Pvml4aHtu/6+uQFMKPVljojZY=;
        b=VLVq/MTQU/NNg1KDEodPCc0dIVnRN0lPQnSff9+nrJhdE1v5B72E4p0G+nx7HDdROB
         TwUXIT0/yD8D0OJ+3VxMmx+8x23YbT8Wxj//0vsxG6/Pag1QcQlwYCEIhI9n09u4bPaF
         dR7NvqkQyN/C+6IU3hD6PN/CmCZsXNgwBR9NIg8ZJ8KWDhDpnNHqyBXnwffA9CRTJ8h3
         LbaWrqCCkrPlv1EKl5zAswa/WrO+a2HBU0tpoe5lafMudJGyYhwoW7Qw74dZ2u1El1yR
         Ab7eDkHYshROtUglv+eB0hoCm1UgWZDNEr1+xgIzG5oodweXDbRJ9G5zWb2M9ZPjnjxL
         3s8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uJunhxgU/GhtFdUD98Pvml4aHtu/6+uQFMKPVljojZY=;
        b=JdAYgrHtjvbPZycJb7sXvJcANkr9f1rdAujhkhWejNTwJas2eZ65RJTol7g4V4dFmR
         s5miJqFNXOurm90O5vYf4vB7y8a8gN/ek7fNYjZLcSemxuBghkySXZ8QjyIADLq42WLs
         FGvNsHTxhWKBrBAiDavYfSayqY59ZDUKEEYFkacZwd027UXlqTy6+ZPPvHLQLIjWtcRJ
         AAOiIh7Op9PGuVmTSRtoS6Yu9SeO5V9ZMKhguf+UOPPa3arGpjyiCu3YCUyXWkVDJPZt
         rRp4bSgLXygnr0S2mT44P3NoF+N3TEIaurlBTKnG33bvO2jU4yUUdQFZvV+bwW0FKSuM
         W4ZQ==
X-Gm-Message-State: AOAM531cH85E3IB2Hx+taMgRD+3M8PfCp0wlqyZBmiSVjXWxOP9tiLNb
        Pb5JbBCokhZdIbRuZsdtxmo=
X-Google-Smtp-Source: ABdhPJx9GYYwyzfa4Sv6g1ItpE1EMJ1VSw6RWycMP3Mmz6sGniIT+wDPwVV1zAwACzJLNVQELZuDEQ==
X-Received: by 2002:a17:90a:1a17:: with SMTP id 23mr1880621pjk.231.1592545803758;
        Thu, 18 Jun 2020 22:50:03 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id w17sm5028544pff.27.2020.06.18.22.50.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Jun 2020 22:50:03 -0700 (PDT)
Date:   Thu, 18 Jun 2020 22:49:43 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_spdif: Add pm runtime function
Message-ID: <20200619054942.GA25856@Asurada-Nvidia>
References: <1592481334-3680-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592481334-3680-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 07:55:34PM +0800, Shengjiu Wang wrote:
> Add pm runtime support and move clock handling there.
> Close the clocks at suspend to reduce the power consumption.
> 
> fsl_spdif_suspend is replaced by pm_runtime_force_suspend.
> fsl_spdif_resume is replaced by pm_runtime_force_resume.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

LGTM, yet some nits, please add my ack after fixing:

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> @@ -495,25 +496,10 @@ static int fsl_spdif_startup(struct snd_pcm_substream *substream,

>  
> -disable_txclk:
> -	for (i--; i >= 0; i--)
> -		clk_disable_unprepare(spdif_priv->txclk[i]);
>  err:
> -	if (!IS_ERR(spdif_priv->spbaclk))
> -		clk_disable_unprepare(spdif_priv->spbaclk);
> -err_spbaclk:
> -	clk_disable_unprepare(spdif_priv->coreclk);
> -
>  	return ret;

Only "return ret;" remains now. We could clean the goto away.

> -static int fsl_spdif_resume(struct device *dev)
> +static int fsl_spdif_runtime_resume(struct device *dev)

> +disable_rx_clk:
> +	clk_disable_unprepare(spdif_priv->rxclk);
> +disable_tx_clk:
> +disable_spba_clk:

Why have two duplicated ones? Could probably drop the 2nd one.
