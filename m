Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FA3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 09:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9133E20706
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 09:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731027AbgFSJA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 05:00:27 -0400
Received: from foss.arm.com ([217.140.110.172]:48380 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728712AbgFSJA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 05:00:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A12452B;
        Fri, 19 Jun 2020 02:00:25 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D341E3F71F;
        Fri, 19 Jun 2020 02:00:23 -0700 (PDT)
Subject: Re: [PATCH 2/2] panfrost: Add compatible string for bifrost
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
References: <20200611085900.49740-1-tomeu.vizoso@collabora.com>
 <20200611085900.49740-2-tomeu.vizoso@collabora.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <1b72d5ad-365f-e7fb-624e-b88420ff264b@arm.com>
Date:   Fri, 19 Jun 2020 10:00:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200611085900.49740-2-tomeu.vizoso@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/2020 09:58, Tomeu Vizoso wrote:
> Mesa now supports some Bifrost devices, so enable it.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

I've also dug out my Hikey960 (from the box it's been in since lock down 
started), so I'll see if I can get things running on there, at the 
moment I'm seeing some DATA_INVALID_FAULT regressions running my hacked 
DDK :(

Steve

> ---
>   drivers/gpu/drm/panfrost/panfrost_drv.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 882fecc33fdb..8ff8e140f91e 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -677,6 +677,7 @@ static const struct of_device_id dt_match[] = {
>   	{ .compatible = "arm,mali-t830", .data = &default_data, },
>   	{ .compatible = "arm,mali-t860", .data = &default_data, },
>   	{ .compatible = "arm,mali-t880", .data = &default_data, },
> +	{ .compatible = "arm,mali-bifrost", .data = &default_data, },
>   	{}
>   };
>   MODULE_DEVICE_TABLE(of, dt_match);
> 

