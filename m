Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A30C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0745B206CC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="IqQ2rkbQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731205AbgCaQoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:44:15 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:63807 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730442AbgCaQoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 12:44:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585673054; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=uOkXbeZcr2DV9rCBPPxEDbCuvkJ222eXEUFzpRLZi3A=; b=IqQ2rkbQTlc2P7VdM0Xod1TFQCP756XH6bHa2lQPZmLLG3DJ+moL0kBMjMzs7wwOk5rKzWvx
 PbhdSBEvKGgPCthlRFhuSLrV/pnRjlpTOevhnhwZ3ZspJ0zuSE/TL/5tprZXakqBRhBfe7iV
 icZjAWAb/VcIiJKBYUfaiC098t8=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e837354.7f0028b137d8-smtp-out-n01;
 Tue, 31 Mar 2020 16:44:04 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4D83FC4478C; Tue, 31 Mar 2020 16:44:03 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B0708C433F2;
        Tue, 31 Mar 2020 16:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B0708C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Tue, 31 Mar 2020 10:43:59 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Sharat Masetty <smasetty@codeaurora.org>
Cc:     freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        dri-devel@freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        sibis@codeaurora.org, saravanak@google.com, viresh.kumar@linaro.org
Subject: Re: [PATCH 4/5] drm: msm: a6xx: Fix off by one error when setting
 GPU freq
Message-ID: <20200331164359.GA11573@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Sharat Masetty <smasetty@codeaurora.org>,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        dri-devel@freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        sibis@codeaurora.org, saravanak@google.com, viresh.kumar@linaro.org
References: <1585641353-23229-1-git-send-email-smasetty@codeaurora.org>
 <1585641353-23229-5-git-send-email-smasetty@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585641353-23229-5-git-send-email-smasetty@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 01:25:52PM +0530, Sharat Masetty wrote:
> This patch fixes an error in the for loop, thereby allowing search on
> the full list of possible GPU power levels.
> 
> Signed-off-by: Sharat Masetty <smasetty@codeaurora.org>

Oh fun. This qualifies for drm-fixes. Can you pull this out of the stack and CC
stable?

Reviewed-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 489d9b6..81b8559 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -176,7 +176,7 @@ void a6xx_gmu_set_freq(struct msm_gpu *gpu, unsigned long freq)
>  	if (freq == gmu->freq)
>  		return;
> 
> -	for (perf_index = 0; perf_index < gmu->nr_gpu_freqs - 1; perf_index++)
> +	for (perf_index = 0; perf_index < gmu->nr_gpu_freqs; perf_index++)
>  		if (freq == gmu->gpu_freqs[perf_index])
>  			break;
> 
> --
> 2.7.4
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
