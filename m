Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDE4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DA452077D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbgGAJLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:11:30 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43088 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgGAJLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 05:11:30 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id AE46F2A0D02
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH] platform: chrome: Fix EC timestamp overflow
To:     Gwendal Grignou <gwendal@chromium.org>, bleung@chromium.org,
        bhanumaiya@chromium.org
Cc:     groeck@chromium.org, linux-kernel@vger.kernel.org
References: <20200630075203.3054990-1-gwendal@chromium.org>
Message-ID: <2f4f14e9-c7cb-ec6d-e3e9-b9f4132db808@collabora.com>
Date:   Wed, 1 Jul 2020 11:11:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200630075203.3054990-1-gwendal@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gwendal,

Thank you for your patch.

On 30/6/20 9:52, Gwendal Grignou wrote:
> EC is using 32 bit timestamps (us), and before converting it to 64bit
> they were not casted, so it would overflow every 4s.
> Regular overflow every ~70 minutes was not taken into acoun either.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

Applied for 5.9 with a slightly modified subject, platform/chrome:
cros_ec_sensorhub: ...

> ---
>  drivers/platform/chrome/cros_ec_sensorhub_ring.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_sensorhub_ring.c b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
> index 23960f3acc0b1..641d91088cee2 100644
> --- a/drivers/platform/chrome/cros_ec_sensorhub_ring.c
> +++ b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
> @@ -465,9 +465,7 @@ cros_ec_sensor_ring_process_event(struct cros_ec_sensorhub *sensorhub,
>  			 * Disable filtering since we might add more jitter
>  			 * if b is in a random point in time.
>  			 */
> -			new_timestamp = fifo_timestamp -
> -					fifo_info->timestamp  * 1000 +
> -					in->timestamp * 1000;
> +			new_timestamp = c - b * 1000 + a * 1000;
>  			/*
>  			 * The timestamp can be stale if we had to use the fifo
>  			 * info timestamp.
> 
