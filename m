Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E0DC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 654532067C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgHQLbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 07:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728380AbgHQLay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 07:30:54 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66897C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 04:30:54 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id A3D2E28DA67
Subject: Re: [PATCH v2 1/2] platform/chrome: cros_ec_proto: ignore unnecessary
 wakeups on old ECs
To:     Brian Norris <briannorris@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     linux-kernel@vger.kernel.org
References: <20200724190841.3112365-1-briannorris@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <8a3b8af8-12d3-0566-49f2-cd763d7a2002@collabora.com>
Date:   Mon, 17 Aug 2020 13:30:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200724190841.3112365-1-briannorris@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian,

On 24/7/20 21:08, Brian Norris wrote:
> ECs that don't implement EC_CMD_HOST_EVENT_GET_WAKE_MASK should still
> have some reasonable default mask -- otherwise, they'll treat a variety
> of EC signals as spurious wakeups. Battery and AC events can be
> especially common, for devices that have been sitting at full charge
> plugged into AC for a long time, as they may cycle their charging off
> and on, or their battery may start reporting failures as it ages.
> 
> Treating these as wakeups does not serve a useful purpose, and is
> instead often counterproductive. And indeed, later ECs (that implement
> the mask) don't include these events in their wake-mask.
> 
> Note that this patch doesn't do anything without the subsequent patch
> ("platform/chrome: cros_ec_proto: check for missing
> EC_CMD_HOST_EVENT_GET_WAKE_MASK"), because
> cros_ec_get_host_event_wake_mask() currently does not return an error if
> EC_CMD_HOST_EVENT_GET_WAKE_MASK is not implemented.
> 
> Some additional notes:
> While the EC typically knows not to wake the CPU for these unimportant
> events once the CPU reaches a sleep state, it doesn't really have a way
> to know that the CPU is "almost" asleep, unless it has support for
> EC_CMD_HOST_SLEEP_EVENT. Alas, these older ECs do not support that
> command either, so this solution is not 100% complete.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Sorry for late notice. The patch has been applied for 5.9.

> ---
> v2:
>  * more notes in commit message
> ---
>  drivers/platform/chrome/cros_ec_proto.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index 3e745e0fe092..e93024b55ce8 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -469,14 +469,26 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
>  						    &ver_mask);
>  	ec_dev->host_sleep_v1 = (ret >= 0 && (ver_mask & EC_VER_MASK(1)));
>  
> -	/*
> -	 * Get host event wake mask, assume all events are wake events
> -	 * if unavailable.
> -	 */
> +	/* Get host event wake mask. */
>  	ret = cros_ec_get_host_event_wake_mask(ec_dev, proto_msg,
>  					       &ec_dev->host_event_wake_mask);
> -	if (ret < 0)
> -		ec_dev->host_event_wake_mask = U32_MAX;
> +	if (ret < 0) {
> +		/*
> +		 * If the EC doesn't support EC_CMD_HOST_EVENT_GET_WAKE_MASK,
> +		 * use a reasonable default. Note that we ignore various
> +		 * battery, AC status, and power-state events, because (a)
> +		 * those can be quite common (e.g., when sitting at full
> +		 * charge, on AC) and (b) these are not actionable wake events;
> +		 * if anything, we'd like to continue suspending (to save
> +		 * power), not wake up.
> +		 */
> +		ec_dev->host_event_wake_mask = U32_MAX &
> +			~(BIT(EC_HOST_EVENT_AC_DISCONNECTED) |
> +			  BIT(EC_HOST_EVENT_BATTERY_LOW) |
> +			  BIT(EC_HOST_EVENT_BATTERY_CRITICAL) |
> +			  BIT(EC_HOST_EVENT_PD_MCU) |
> +			  BIT(EC_HOST_EVENT_BATTERY_STATUS));
> +	}
>  
>  	ret = 0;
>  
> 
