Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA142C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 14:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4DC20782
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 14:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584713272;
	bh=j/n7pjP93b6DmV3JuAK413wi3AHJqJWappdxRiWCZpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eeAxJWm4xGKYIbTrf3B59oGgiGwzVe7Ckt3nSIGWz2whdBV5OPy4J9s2RuBfDvxlx
	 hIsPSRnIfNCsjHJvex3A7GWknH7yFjL3ahTCx72wxvi+mzVMr1ht2h9Qgez1iX2fce
	 NjnMl/Zhu6S6dDdH9cH4l4+ZkH43jikOJyY0ycW8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgCTOHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 10:07:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbgCTOHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 10:07:51 -0400
Received: from localhost (unknown [122.167.82.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E381E2072D;
        Fri, 20 Mar 2020 14:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584713270;
        bh=j/n7pjP93b6DmV3JuAK413wi3AHJqJWappdxRiWCZpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eowGIFSMJQ73Sa6WG5cyPuEN2lUFgV31Cemctg8SJXWXdIm9oMTklrHSRVa8yHkQq
         gxGFh6ioBkOEkeUHgB1cvwXGUnEjLWoisUytTPwR2e77U1DmwfYWdsdBncC5l4WzpE
         uPyogyP6OfJGR+1naHvwdGiyljVEdIQe+ndqNOh8=
Date:   Fri, 20 Mar 2020 19:37:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH] soundwire: qcom: add support for get_sdw_stream()
Message-ID: <20200320140746.GH4885@vkoul-mobl>
References: <20200317092645.5705-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317092645.5705-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-03-20, 09:26, Srinivas Kandagatla wrote:
> Adding support to new get_sdw_stream() that can help machine
> driver to deal with soundwire stream.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/soundwire/qcom.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index 440effed6df6..ba810fbfa3c7 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -588,6 +588,13 @@ static int qcom_swrm_set_sdw_stream(struct snd_soc_dai *dai,
>  	return 0;
>  }
>  
> +static void * qcom_swrm_get_sdw_stream(struct snd_soc_dai *dai, int direction)

This should be void *qcom_swrm_get_sdw_stream. Please run checkpatch
before sending patches.

I have fixed it up while applying

-- 
~Vinod
