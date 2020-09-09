Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB9AC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62DBE21D7B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599638252;
	bh=Bf70SM+kDaHrKWyPoY+mR++Vc7f3euS8X37jgXJRFFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qip7gP3W511X6ehljLksu5PanIKwOFwHFf5i1o3uKHY+9q/1Yw3ypCjiwmzEN3TCh
	 dhGGA488P8C85ORODG2Eudt7u40vm1u2V7PUEr2v32EhV4d+vmBOtcvsOJCueagxnE
	 c8yjTj1mejyPoWELHq6f/YhyELxvJLmy3JVxESaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbgIIH51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 03:57:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:51102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730030AbgIIH5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:57:16 -0400
Received: from localhost (unknown [122.179.21.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4F8F21D7B;
        Wed,  9 Sep 2020 07:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599638235;
        bh=Bf70SM+kDaHrKWyPoY+mR++Vc7f3euS8X37jgXJRFFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1VpgHjuQqy0qC77in66ZvJ/1xh+WhYpKzk2D7MZQ1IPUaQojAhsNUjD9TwMMqydk4
         OWfbEr7YduDhzqvlcRF6gCdHhjVj5MqZWQ6vFGCaZ1LGXRIb53fVwfTwYXmb0oII+v
         +ZySsnhvuRyTnGm8Z26fsZ6HIymEeJT9Ne0XD0BE=
Date:   Wed, 9 Sep 2020 13:27:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        "moderated list:SOUNDWIRE SUBSYSTEM" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soundwire: qcom: fix SLIBMUS/SLIMBUS typo
Message-ID: <20200909075707.GL77521@vkoul-mobl>
References: <20200908140818.28373-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908140818.28373-1-jonathan@marek.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-09-20, 10:08, Jonathan Marek wrote:
> Fix slimbus case being broken thanks to a typo.
> 

Applied, thanks

> Fixes: 5bd773242f75 ("soundwire: qcom: avoid dependency on CONFIG_SLIMBUS")
> 

No need of blank line here

> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
> This should be squashed into the problematic patch if possible,
> but I'm not sure if that's possible since its already in linux-next?
> 
>  drivers/soundwire/qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index 100af93a5eab..c406a079d237 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -780,7 +780,7 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>  	if (!ctrl)
>  		return -ENOMEM;
>  
> -#if IS_ENABLED(CONFIG_SLIBMUS)
> +#if IS_ENABLED(CONFIG_SLIMBUS)
>  	if (dev->parent->bus == &slimbus_bus) {
>  #else
>  	if (false) {
> -- 
> 2.26.1

-- 
~Vinod
