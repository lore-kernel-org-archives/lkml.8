Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6543C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 13:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 949A12072B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 13:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgBENZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 08:25:51 -0500
Received: from foss.arm.com ([217.140.110.172]:47252 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727162AbgBENZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 08:25:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F16C231B;
        Wed,  5 Feb 2020 05:25:50 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AC093F52E;
        Wed,  5 Feb 2020 05:25:50 -0800 (PST)
Subject: Re: [PATCH] drm/panfrost: Don't try to map on error faults
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
References: <20200205100719.24999-1-tomeu.vizoso@collabora.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <3500c501-b166-6a1e-267b-31a4e5c62619@arm.com>
Date:   Wed, 5 Feb 2020 13:25:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200205100719.24999-1-tomeu.vizoso@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/2020 10:07 am, Tomeu Vizoso wrote:
> If the exception type isn't one of the normal faults, don't try to map
> and instead go straight to a terminal fault.

"One of the the normal faults" seems a rather vague way of saying "a 
translation fault", which is what we're specifically handling here, and 
logically the only fault reflecting something not yet mapped rather than 
mapped inappropriately ;)

(Who knows how the level ended up as 1-4 rather than 0-3 as it really 
should be - another Mali Mystery(TM)...)

> Otherwise, we can get flooded by kernel warnings and further faults.

Either way,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
>   drivers/gpu/drm/panfrost/panfrost_mmu.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> index 763cfca886a7..80abddb4544c 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -596,8 +596,9 @@ static irqreturn_t panfrost_mmu_irq_handler_thread(int irq, void *data)
>   		source_id = (fault_status >> 16);
>   
>   		/* Page fault only */
> -		if ((status & mask) == BIT(i)) {
> -			WARN_ON(exception_type < 0xC1 || exception_type > 0xC4);
> +		if ((status & mask) == BIT(i) &&
> +		     exception_type >= 0xC1 &&
> +		     exception_type <= 0xC4) {
>   
>   			ret = panfrost_mmu_map_fault_addr(pfdev, i, addr);
>   			if (!ret) {
> 
