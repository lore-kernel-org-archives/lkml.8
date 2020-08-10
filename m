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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B00C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 08:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A2AA2065C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 08:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pLBGxBmA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgHJIhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 04:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgHJIhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 04:37:36 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B44C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 01:37:36 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ha11so4583608pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 01:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Scg7QrQFHhZ2Uk5vL9dJtfSBTf93pMWkHX0hTYM3Wac=;
        b=pLBGxBmA28+kasChedisfkm5yQ00pLLat8cogyaXTpLiExGsBIVYBEBCu2hz/OBRjq
         JEnJ8UbRvkBLpVgWe9F5OiPBNu9NN1vD5FcFk390ldPJaV9NbI3L8f1/o6dj2SD8uDG8
         X8HCnYYdZ3mdBTreaxYiqxn/AEPh962sa6zkhkddCa28cl6ei0EUjktXDaKZ9mZmleMu
         nqxvzdp70e+sqykKT3MdZqiju2Xs3elZPFUcEiKx0QWPDUgZjzniVgfUlThWTWdT/teq
         vMOIcg2BEPu5qgUkPzOaHU7y3Q68EobH75g7jKMfAkHKVMdl3PONxv3/GLP39z2Lr56w
         5CQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Scg7QrQFHhZ2Uk5vL9dJtfSBTf93pMWkHX0hTYM3Wac=;
        b=fbNuyQIHSG4ZC3MlBBxHYm4jD6tnfFujmKz32w7INmbWjFMz9friadBGS9AwQFGyGs
         hJUIzIv/F/2JcMpAqiq77viAHIdIxecsoPVinIaXzjoJ4IyMsBpfUIdYPJB7mD1FMQkA
         bheUp5fbo2T9l/KTeQw5ihMchPWHWazeiXRPiSXAFs0exISKo+mLPy+OmItGl1XVzVSL
         6Z+8SQ/8HBMlegVnUBjqiBh2PaZG9PA7hsAXZqqRidh+FCeIj7JVMWwdijSabI1/+oCM
         XQWh0/Oc8hWvBWey8UCTs1cLYg0PMiT4LCJr8F94vLWL0/HIJKeFwNRGV44l/hX+oiZq
         fG5Q==
X-Gm-Message-State: AOAM530GYFUiJ6SFMWsDlKATBy1ncVL/FlikWzM790k25ceTiNJ3vzB9
        r09icyZGJ2t0IB0gClta2VI=
X-Google-Smtp-Source: ABdhPJzjuMOIL1DAbcFHuOnCIOgipzZg0qAzo4rznqU2sir2vCh9nY2ksofTJnj2XfUNc1XE1vk4bw==
X-Received: by 2002:a17:90a:b386:: with SMTP id e6mr26337780pjr.57.1597048654505;
        Mon, 10 Aug 2020 01:37:34 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id 13sm22135713pfp.3.2020.08.10.01.37.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Aug 2020 01:37:34 -0700 (PDT)
Date:   Mon, 10 Aug 2020 01:37:29 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: fsl-asoc-card: Get "extal" clock rate by
 clk_get_rate
Message-ID: <20200810083728.GA7560@Asurada-Nvidia>
References: <1597047103-6863-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597047103-6863-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 04:11:43PM +0800, Shengjiu Wang wrote:
> On some platform(.e.g. i.MX8QM MEK), the "extal" clock is different
> with the mclk of codec, then the clock rate is also different.
> So it is better to get clock rate of "extal" rate by clk_get_rate,
> don't reuse the clock rate of mclk.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
> changes in v2
> - add defer probe handler
> 
>  sound/soc/fsl/fsl-asoc-card.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
> index 52adedc03245..32f8f756e6bb 100644
> --- a/sound/soc/fsl/fsl-asoc-card.c
> +++ b/sound/soc/fsl/fsl-asoc-card.c
> @@ -696,6 +696,17 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
>  			goto asrc_fail;
>  		}
>  	} else if (of_node_name_eq(cpu_np, "esai")) {
> +		struct clk *esai_clk = clk_get(&cpu_pdev->dev, "extal");
> +
> +		if (!IS_ERR(esai_clk)) {
> +			priv->cpu_priv.sysclk_freq[TX] = clk_get_rate(esai_clk);
> +			priv->cpu_priv.sysclk_freq[RX] = clk_get_rate(esai_clk);

Will it break existing imx-audio-cs42888 on older i.MX platforms?
'cause it overwrites cpu_priv.sysclk_freq[] that are set in "card
configurations" section.
