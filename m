Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23096C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 094F320855
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgHQLbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 07:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbgHQLbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 07:31:11 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80FDC061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 04:31:10 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 6D12728DA67
Subject: Re: [PATCH v2 2/2] platform/chrome: cros_ec_proto: check for missing
 EC_CMD_HOST_EVENT_GET_WAKE_MASK
To:     Brian Norris <briannorris@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     linux-kernel@vger.kernel.org
References: <20200724190841.3112365-1-briannorris@chromium.org>
 <20200724190841.3112365-2-briannorris@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <6c200c61-209f-eb76-88b6-16491e2bc69c@collabora.com>
Date:   Mon, 17 Aug 2020 13:31:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200724190841.3112365-2-briannorris@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian,

On 24/7/20 21:08, Brian Norris wrote:
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

Sorry for late notice. The patch has been applied for 5.9.

> ---
> v2:
>  * EOPNOTSUPP, not ENOTSUPP
> ---
>  drivers/platform/chrome/cros_ec_proto.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index e93024b55ce8..31ca0af62388 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -208,6 +208,12 @@ static int cros_ec_get_host_event_wake_mask(struct cros_ec_device *ec_dev,
>  	msg->insize = sizeof(*r);
>  
>  	ret = send_command(ec_dev, msg);
> +	if (ret >= 0) {
> +		if (msg->result == EC_RES_INVALID_COMMAND)
> +			return -EOPNOTSUPP;
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
> +		if (ret != -EOPNOTSUPP)
> +			dev_err(ec_dev->dev,
> +				"failed to retrieve wake mask: %d\n", ret);
>  	}
>  
>  	ret = 0;
> 
