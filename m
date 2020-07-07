Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00B2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7620F206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594136114;
	bh=a0T6ft6shyocwqSr39cTZCmpgAAfdPrbzkMPJK3i0R8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YjBLLgf81zsNPJDnNUQsZ1guScVNmVwKE4B/RSBft8D634VZCKqW6iQtxKA9KJX1w
	 AM6bG+qur7qvj4rJl63k4zZnDrLjU99LxVzEJUqts3Ct9YtYjk8fT4keCZraDJNp7U
	 HDu0+UuxMce6Xyy9LoA3zhrQexhFbeAPo1gFrUwA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbgGGPfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:35:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727079AbgGGPfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:35:11 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D26B20663;
        Tue,  7 Jul 2020 15:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594136111;
        bh=a0T6ft6shyocwqSr39cTZCmpgAAfdPrbzkMPJK3i0R8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sYm6HN6vQNCSP8UaYveiQFdSOWg03VElJwFBZ/y4+Ppeu0Ytl2U6XDlE0EvmYrjRW
         91cf5/ldZcLbuLKxK/v8kKOfFVB+NPOlkmTGh3lyZMKpoSkKlH6ujFs9VNee/3OIEK
         K51bI2K/WdkIBxpv2+2ZefGbYV0c41OmxPKCKqjQ=
Date:   Tue, 7 Jul 2020 21:05:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 13/28] ASoC: qcom: qdsp6: q6asm: Provide documentation
 for WMA 'codec_profile'
Message-ID: <20200707153505.GA5155@vkoul-mobl>
References: <20200707101642.1747944-1-lee.jones@linaro.org>
 <20200707101642.1747944-14-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707101642.1747944-14-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-07-20, 11:16, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  sound/soc/qcom/qdsp6/q6asm.c:924: warning: Function parameter or member 'codec_profile' not described in 'q6asm_open_write'
> 
> Cc: Patrick Lai <plai@codeaurora.org>
> Cc: Banajit Goswami <bgoswami@codeaurora.org>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  sound/soc/qcom/qdsp6/q6asm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
> index ae4b2cabdf2d6..58720b18fc8c8 100644
> --- a/sound/soc/qcom/qdsp6/q6asm.c
> +++ b/sound/soc/qcom/qdsp6/q6asm.c
> @@ -915,6 +915,7 @@ static int q6asm_ac_send_cmd_sync(struct audio_client *ac, struct apr_pkt *pkt)
>   *
>   * @ac: audio client pointer
>   * @format: audio sample format
> + * @codec_profile: profile to use when WMA

Yes it is used with WMA only for now, but we should describe in
generically as "Audio codec profile"

>   * @bits_per_sample: bits per sample
>   *
>   * Return: Will be an negative value on error or zero on success
> -- 
> 2.25.1

-- 
~Vinod
