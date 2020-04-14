Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1656BC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 11:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D87B4206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 11:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586865332;
	bh=LkQ0dcrf9MyjqTc7cSRslR0WVvMeZfNCFsl59el83SY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hU7wieZUtz0QyMK6SFjCf4JHxtrSs12H8lN6XCSDPo9HOPMd78/RTmbMkBboLzgZU
	 6rPAkw04kWnfHXscCCWtH2bLdPCrKl4QuPCEL038128gbi/W+2I19oEIk/YymZ/+0G
	 MZQdyQuoYkaxkWeIdgiThUpbFsEzqDEodyqePMfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439681AbgDNLzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 07:55:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439662AbgDNLz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 07:55:27 -0400
Received: from localhost (unknown [106.51.106.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D53E206D5;
        Tue, 14 Apr 2020 11:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586865326;
        bh=LkQ0dcrf9MyjqTc7cSRslR0WVvMeZfNCFsl59el83SY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mnNY+rROPD2XsMKTOhtq44rZfwnnvF4NyAxYxKm+A9t8kvy1azy+gRdcDjHTLqj+O
         gDGylWU5KlgywVfu0+tYfHRNfE8K4VQobZs87stg/aQ3aWnK3L0qbaAIburMe67YpT
         XzBjPCItCIPIsUN9OTtHNWZ39tnvq9r+2+8D+9uY=
Date:   Tue, 14 Apr 2020 17:25:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] ASoC: wsa881x: mark read_only_wordlength flag
Message-ID: <20200414115512.GG72691@vkoul-mobl>
References: <20200414110347.23829-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414110347.23829-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-04-20, 12:03, Srinivas Kandagatla wrote:
> WSA881x works in PDM mode so the wordlength is fixed, which also makes
> the only field "WordLength" in DPN_BlockCtrl1 register a read-only.
> Writing to this register will throw up errors with Qualcomm Controller.
> So use ro_blockctrl1_reg flag to mark this field as read-only so that
> core will not write to this register.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> Hi Mark,
> 
> For some reason this patch was missed during last merge window,
> Other patch in this series is already in mainline.
> Without this patch audio is not functional on DB845c and other SDM845
> based platforms.
> 
> Can you please take this for next possible rc.
> 
> Thanks,
> srini
> 
>  sound/soc/codecs/wsa881x.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
> index f2d6f2f81f14..d39d479e2378 100644
> --- a/sound/soc/codecs/wsa881x.c
> +++ b/sound/soc/codecs/wsa881x.c
> @@ -394,6 +394,7 @@ static struct sdw_dpn_prop wsa_sink_dpn_prop[WSA881X_MAX_SWR_PORTS] = {
>  		.min_ch = 1,
>  		.max_ch = 1,
>  		.simple_ch_prep_sm = true,
> +		.read_only_wordlength = true,
>  	}, {
>  		/* COMP */
>  		.num = 2,
> @@ -401,6 +402,7 @@ static struct sdw_dpn_prop wsa_sink_dpn_prop[WSA881X_MAX_SWR_PORTS] = {
>  		.min_ch = 1,
>  		.max_ch = 1,
>  		.simple_ch_prep_sm = true,
> +		.read_only_wordlength = true,
>  	}, {
>  		/* BOOST */
>  		.num = 3,
> @@ -408,6 +410,7 @@ static struct sdw_dpn_prop wsa_sink_dpn_prop[WSA881X_MAX_SWR_PORTS] = {
>  		.min_ch = 1,
>  		.max_ch = 1,
>  		.simple_ch_prep_sm = true,
> +		.read_only_wordlength = true,
>  	}, {
>  		/* VISENSE */
>  		.num = 4,
> @@ -415,6 +418,7 @@ static struct sdw_dpn_prop wsa_sink_dpn_prop[WSA881X_MAX_SWR_PORTS] = {
>  		.min_ch = 1,
>  		.max_ch = 1,
>  		.simple_ch_prep_sm = true,
> +		.read_only_wordlength = true,
>  	}
>  };
>  
> -- 
> 2.21.0

-- 
~Vinod
