Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6363C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9C8A20787
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbgGPPHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728552AbgGPPHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:07:32 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24178C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 08:07:32 -0700 (PDT)
Received: from [IPv6:2a01:e35:2fb5:1510:95f7:ce7f:fb76:c54a] (unknown [IPv6:2a01:e35:2fb5:1510:95f7:ce7f:fb76:c54a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aferraris)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id AE7552A5176;
        Thu, 16 Jul 2020 16:07:29 +0100 (BST)
Subject: Re: [PATCH 1/2] ASoC: fsl_asrc: make sure the input and output clocks
 are different
To:     alsa-devel@alsa-project.org
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20200716145201.186270-1-arnaud.ferraris@collabora.com>
 <20200716145201.186270-2-arnaud.ferraris@collabora.com>
From:   Arnaud Ferraris <arnaud.ferraris@collabora.com>
Autocrypt: addr=arnaud.ferraris@collabora.com; keydata=
 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
 xZQG6fKWuIur3RI=
Message-ID: <1f98f8ba-5996-4653-bad6-ad46bbe6fbd1@collabora.com>
Date:   Thu, 16 Jul 2020 17:07:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716145201.186270-2-arnaud.ferraris@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 16/07/2020 à 16:52, Arnaud Ferraris a écrit :
> The current clock selection algorithm might select the same clock for
> both input and output. This can happen when, for instance, the output
> sample rate is a multiple of the input rate.
> 
> This patch makes sure it always selects distinct input and output
> clocks.
> 
> Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
> ---
>  sound/soc/fsl/fsl_asrc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index 02c81d2e34ad..bfd35b9c0781 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -622,7 +622,8 @@ static void fsl_asrc_select_clk(struct fsl_asrc_priv *asrc_priv,
>  			clk_rate = clk_get_rate(asrc_priv->asrck_clk[clk_index]);
>  			/* Only match a perfect clock source with no remainder */
>  			if (clk_rate != 0 && (clk_rate / rate[j]) <= 1024 &&
> -			    (clk_rate % rate[j]) == 0)
> +			    (clk_rate % rate[j]) == 0 &&
> +			    (j == 0 || i != select_clk[j-1]))
>  				break;
>  		}
>  
> 

Well, it looks like I sent the wrong patch for this one, will send a v2
fixing this right now.
Sorry about the noise.

Regards,
Arnaud
