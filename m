Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4ACC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2096C21532
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390352AbgE0PxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:53:22 -0400
Received: from foss.arm.com ([217.140.110.172]:40528 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390286AbgE0PwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:52:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A35830E;
        Wed, 27 May 2020 08:52:05 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E5533F52E;
        Wed, 27 May 2020 08:52:03 -0700 (PDT)
Subject: Re: [PATCH] [v2] drm/panfrost: Fix runtime PM imbalance on error
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu
Cc:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200522134109.27204-1-dinghao.liu@zju.edu.cn>
From:   Steven Price <steven.price@arm.com>
Message-ID: <48348af2-649c-7305-6255-6ae6a80e9b7a@arm.com>
Date:   Wed, 27 May 2020 16:52:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200522134109.27204-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/2020 14:41, Dinghao Liu wrote:
> The caller expects panfrost_job_hw_submit() to increase
> runtime PM usage counter. The refcount decrement on the
> error branch of WARN_ON() will break the counter balance
> and needs to be removed.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>

Reviewed-by: Steven Price <steven.price@arm.com>

Thanks,

Steve

> ---
> 
> Changelog:
> 
> v2: - Remove refcount decrement on the error path of
>        WARN_ON() rather than add refcount decrement
>        on the error path of pm_runtime_get_sync().
> ---
>   drivers/gpu/drm/panfrost/panfrost_job.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
> index 7914b1570841..1092d9754f0f 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -150,7 +150,6 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
>   		return;
>   
>   	if (WARN_ON(job_read(pfdev, JS_COMMAND_NEXT(js)))) {
> -		pm_runtime_put_sync_autosuspend(pfdev->dev);
>   		return;
>   	}
>   
> 

