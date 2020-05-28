Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08F4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A69E20897
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390276AbgE1NWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 09:22:44 -0400
Received: from foss.arm.com ([217.140.110.172]:52526 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390102AbgE1NWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 09:22:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3B1DD6E;
        Thu, 28 May 2020 06:22:39 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 617B63F52E;
        Thu, 28 May 2020 06:22:38 -0700 (PDT)
Subject: Re: [PATCH 02/15] drm/panfrost: clean headers in devfreq
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
 <20200510165538.19720-3-peron.clem@gmail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <480f0bd6-0b21-224e-2cde-09bf71870ee7@arm.com>
Date:   Thu, 28 May 2020 14:22:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200510165538.19720-3-peron.clem@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2020 17:55, Clément Péron wrote:
> Don't include not required headers and sort them.
> 
> Signed-off-by: Clément Péron <peron.clem@gmail.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>   drivers/gpu/drm/panfrost/panfrost_devfreq.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> index 1b560b903ea6..df7b71da9a84 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> @@ -1,18 +1,14 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /* Copyright 2019 Collabora ltd. */
> +
> +#include <linux/clk.h>
>   #include <linux/devfreq.h>
>   #include <linux/devfreq_cooling.h>
>   #include <linux/platform_device.h>
>   #include <linux/pm_opp.h>
> -#include <linux/clk.h>
> -#include <linux/regulator/consumer.h>
>   
>   #include "panfrost_device.h"
>   #include "panfrost_devfreq.h"
> -#include "panfrost_features.h"
> -#include "panfrost_issues.h"
> -#include "panfrost_gpu.h"
> -#include "panfrost_regs.h"
>   
>   static void panfrost_devfreq_update_utilization(struct panfrost_device *pfdev)
>   {
> 

