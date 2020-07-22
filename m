Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5A9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9569E20787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731875AbgGVKTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 06:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgGVKTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 06:19:45 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B76C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 03:19:45 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 06C3C260FCD
Subject: Re: [PATCH 2/2] platform/chrome: cros_ec_proto: check for missing
 EC_CMD_HOST_EVENT_GET_WAKE_MASK
To:     Brian Norris <briannorris@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     linux-kernel@vger.kernel.org
References: <20200722015732.1720840-1-briannorris@chromium.org>
 <20200722015732.1720840-2-briannorris@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <5ebf1534-8045-9894-9c1c-b92b9c6d8479@collabora.com>
Date:   Wed, 22 Jul 2020 12:19:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722015732.1720840-2-briannorris@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian,

Thank you for your patch, I'll take a look soon but I'd like to ask if you can
join the discussion with this patchset [1], specially this one [2]. We're trying
to match EC errors with standard linux kernel errors because we think can be
helpful.

[1] https://lore.kernel.org/patchwork/cover/1276734/
[2] https://lore.kernel.org/patchwork/patch/1276738/

Thanks,
 Enric

On 22/7/20 3:57, Brian Norris wrote:
> As with cros_ec_cmd_xfer_status(), etc., it's not enough to simply check
> for the return status of send_command() -- that only covers transport or
> other similarly-fatal errors. One must also check the ->result field, to
> see whether the command really succeeded. If not, we can't use the data
> it returns.
> 
> The caller of cros_ec_get_host_event_wake_mask() ignores this, and so
> for example, on EC's where the command is not implemented, we're using
> junk (or in practice, all zeros) for our wake-mask. We should be using a
> non-zero default (currently, it's supposed to be all-1's).
> 
> Fix this by checking the ->result field and returning -EPROTO for
> errors.
> 
> I might label this as fixing commit 29d99b966d60 ("cros_ec: Don't signal
> wake event for non-wake host events"), except that this fix alone
> actually may make things worse, as it now allows for a lot more spurious
> wakeups. The patch "platform/chrome: cros_ec_proto: ignore battery/AC
> wakeups on old ECs" helps to mitigate this.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>  drivers/platform/chrome/cros_ec_proto.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index e93024b55ce8..01a74abe4191 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -208,6 +208,12 @@ static int cros_ec_get_host_event_wake_mask(struct cros_ec_device *ec_dev,
>  	msg->insize = sizeof(*r);
>  
>  	ret = send_command(ec_dev, msg);
> +	if (ret >= 0) {
> +		if (msg->result == EC_RES_INVALID_COMMAND)
> +			return -ENOTSUPP;
> +		if (msg->result != EC_RES_SUCCESS)
> +			return -EPROTO;
> +	}
>  	if (ret > 0) {
>  		r = (struct ec_response_host_event_mask *)msg->data;
>  		*mask = r->mask;
> @@ -488,6 +494,13 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
>  			  BIT(EC_HOST_EVENT_BATTERY_CRITICAL) |
>  			  BIT(EC_HOST_EVENT_PD_MCU) |
>  			  BIT(EC_HOST_EVENT_BATTERY_STATUS));
> +		/*
> +		 * Old ECs may not support this command. Complain about all
> +		 * other errors.
> +		 */
> +		if (ret != -ENOTSUPP)
> +			dev_err(ec_dev->dev,
> +				"failed to retrieve wake mask: %d\n", ret);
>  	}
>  
>  	ret = 0;
> 
