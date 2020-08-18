Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E09C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 10:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6EBD2065D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 10:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="XtzgrLuw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgHRKDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 06:03:48 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:45202 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgHRKDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 06:03:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597745026; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=JE65E5Dtrka1DOzWdtukE2KACAFY/NVV59JKO7w/pIg=;
 b=XtzgrLuwAJ4LfB+ZaqJvlIFKkhiDZMuQNDhwaQkyXy6nQ7BQjbIKWI6ufSJP/9YeQ/32/yiE
 xP8Y4OnGpa/6N7M9LIWsoE72QCQLJZY6kJl0QBywsnWQww/6nUFIv+nYTBUXBeMN1M66yr2e
 853JiU0gh660vWXB47E/y7XNwrQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5f3ba76e1e4d3989d41ed4aa (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 18 Aug 2020 10:03:26
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 90DE5C433CB; Tue, 18 Aug 2020 10:03:26 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AA871C433CA;
        Tue, 18 Aug 2020 10:03:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 18 Aug 2020 15:33:24 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Krishna Manikandan <mkrishn@codeaurora.org>,
        Emil Velikov <emil.velikov@collabora.com>, robdclark@gmail.com,
        seanpaul@chromium.org, hoegsberg@chromium.org,
        kalyan_t@codeaurora.org, nganji@codeaurora.org
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [v2] drm/msm: add shutdown support for display platform_driver
In-Reply-To: <1591009402-681-1-git-send-email-mkrishn@codeaurora.org>
References: <1591009402-681-1-git-send-email-mkrishn@codeaurora.org>
Message-ID: <a3fcad3f97c258043cd4268ef2c99740@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2020-06-01 16:33, Krishna Manikandan wrote:
> Define shutdown callback for display drm driver,
> so as to disable all the CRTCS when shutdown
> notification is received by the driver.
> 
> This change will turn off the timing engine so
> that no display transactions are requested
> while mmu translations are getting disabled
> during reboot sequence.
> 
> Signed-off-by: Krishna Manikandan <mkrishn@codeaurora.org>
> 
> Changes in v2:
> 	- Remove NULL check from msm_pdev_shutdown (Stephen Boyd)
> 	- Change commit text to reflect when this issue
> 	  was uncovered (Sai Prakash Ranjan)
> ---
>  drivers/gpu/drm/msm/msm_drv.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/msm_drv.c 
> b/drivers/gpu/drm/msm/msm_drv.c
> index e4b750b..94e3963 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -1322,6 +1322,13 @@ static int msm_pdev_remove(struct 
> platform_device *pdev)
>  	return 0;
>  }
> 
> +static void msm_pdev_shutdown(struct platform_device *pdev)
> +{
> +	struct drm_device *drm = platform_get_drvdata(pdev);
> +
> +	drm_atomic_helper_shutdown(drm);
> +}
> +
>  static const struct of_device_id dt_match[] = {
>  	{ .compatible = "qcom,mdp4", .data = (void *)KMS_MDP4 },
>  	{ .compatible = "qcom,mdss", .data = (void *)KMS_MDP5 },
> @@ -1334,6 +1341,7 @@ static int msm_pdev_remove(struct platform_device 
> *pdev)
>  static struct platform_driver msm_platform_driver = {
>  	.probe      = msm_pdev_probe,
>  	.remove     = msm_pdev_remove,
> +	.shutdown   = msm_pdev_shutdown,
>  	.driver     = {
>  		.name   = "msm",
>  		.of_match_table = dt_match,

Any more comments on this patch?

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
