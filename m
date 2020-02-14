Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D06C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D85724650
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbgBNPKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:10:12 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46530 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729278AbgBNPKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:10:12 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 9358B295D01
Subject: Re: [PATCH] platform/chrome: cros_ec_rpmsg: Fix race with host event.
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200214082638.92070-1-pihsun@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <83b03af1-5518-599a-3f82-ee204992edbf@collabora.com>
Date:   Fri, 14 Feb 2020 16:10:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200214082638.92070-1-pihsun@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pi-Hsun,

On 14/2/20 9:26, Pi-Hsun Shih wrote:
> Host event can be sent by remoteproc by any time, and
> cros_ec_rpmsg_callback would be called after cros_ec_rpmsg_create_ept.
> But the cros_ec_device is initialized after that, which cause host event
> handler to use cros_ec_device that are not initialized properly yet.
> 

I don't have the hardware to test but, can't we call first cros_ec_register and
then cros_ec_rpmsg_create_ept?

Start receiving driver callbacks before finishing to probe the drivers itself
sounds weird to me.

Thanks,
 Enric

> Fix this by don't schedule host event handler before cros_ec_register
> returns. Instead, remember that we have a pending host event, and
> schedule host event handler after cros_ec_register.
> 
> Fixes: 71cddb7097e2 ("platform/chrome: cros_ec_rpmsg: Fix race with host command when probe failed.")
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> ---
>  drivers/platform/chrome/cros_ec_rpmsg.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_rpmsg.c b/drivers/platform/chrome/cros_ec_rpmsg.c
> index dbc3f5523b83..7e8629e3db74 100644
> --- a/drivers/platform/chrome/cros_ec_rpmsg.c
> +++ b/drivers/platform/chrome/cros_ec_rpmsg.c
> @@ -44,6 +44,8 @@ struct cros_ec_rpmsg {
>  	struct completion xfer_ack;
>  	struct work_struct host_event_work;
>  	struct rpmsg_endpoint *ept;
> +	bool has_pending_host_event;
> +	bool probe_done;
>  };
>  
>  /**
> @@ -177,7 +179,14 @@ static int cros_ec_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
>  		memcpy(ec_dev->din, resp->data, len);
>  		complete(&ec_rpmsg->xfer_ack);
>  	} else if (resp->type == HOST_EVENT_MARK) {
> -		schedule_work(&ec_rpmsg->host_event_work);
> +		/*
> +		 * If the host event is sent before cros_ec_register is
> +		 * finished, queue the host event.
> +		 */
> +		if (ec_rpmsg->probe_done)
> +			schedule_work(&ec_rpmsg->host_event_work);
> +		else
> +			ec_rpmsg->has_pending_host_event = true;
>  	} else {
>  		dev_warn(ec_dev->dev, "rpmsg received invalid type = %d",
>  			 resp->type);
> @@ -240,6 +249,11 @@ static int cros_ec_rpmsg_probe(struct rpmsg_device *rpdev)
>  		return ret;
>  	}
>  
> +	ec_rpmsg->probe_done = true;
> +
> +	if (ec_rpmsg->has_pending_host_event)
> +		schedule_work(&ec_rpmsg->host_event_work);
> +
>  	return 0;
>  }
>  
> 
> base-commit: b19e8c68470385dd2c5440876591fddb02c8c402
> 
