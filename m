Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCD7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAAC7207F5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390294AbgE1NWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 09:22:50 -0400
Received: from foss.arm.com ([217.140.110.172]:52542 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390267AbgE1NWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 09:22:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F57FD6E;
        Thu, 28 May 2020 06:22:42 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF0223F52E;
        Thu, 28 May 2020 06:22:40 -0700 (PDT)
Subject: Re: [PATCH 03/15] drm/panfrost: don't use pfdevfreq.busy_count to
 know if hw is idle
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200510165538.19720-1-peron.clem@gmail.com>
 <20200510165538.19720-4-peron.clem@gmail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <3c108f43-67bd-8056-879d-36aea2d66a60@arm.com>
Date:   Thu, 28 May 2020 14:22:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200510165538.19720-4-peron.clem@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2020 17:55, Clément Péron wrote:
> This use devfreq variable that will be lock with spinlock in future
> patches. We should either introduce a function to access this one
> but as devfreq is optional let's just remove it.
> 
> Signed-off-by: Clément Péron <peron.clem@gmail.com>

As far as I can tell this should be safe. As you note this wouldn't work 
without devfreq anyway.

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>   drivers/gpu/drm/panfrost/panfrost_job.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
> index 7914b1570841..63e32a9f2749 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -581,10 +581,6 @@ int panfrost_job_is_idle(struct panfrost_device *pfdev)
>   	struct panfrost_job_slot *js = pfdev->js;
>   	int i;
>   
> -	/* Check whether the hardware is idle */
> -	if (atomic_read(&pfdev->devfreq.busy_count))
> -		return false;
> -
>   	for (i = 0; i < NUM_JOB_SLOTS; i++) {
>   		/* If there are any jobs in the HW queue, we're not idle */
>   		if (atomic_read(&js->queue[i].sched.hw_rq_count))
> 

