Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204EFC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 15:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F06522087F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 15:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbgA0P3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 10:29:43 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33012 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729146AbgA0P3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 10:29:43 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 2F431293C86
Subject: Re: [PATCH 1/4] platform/chrome: Add EC command msg wrapper
To:     Prashant Malani <pmalani@chromium.org>, bleung@chromium.org
Cc:     linux-kernel@vger.kernel.org
References: <20200125012105.59903-1-pmalani@chromium.org>
 <20200125012105.59903-2-pmalani@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <feb0ef4d-0f03-9bbc-807e-c385c03ffa71@collabora.com>
Date:   Mon, 27 Jan 2020 16:29:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200125012105.59903-2-pmalani@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

Many thanks for this patch.

On 25/1/20 2:21, Prashant Malani wrote:
> Many callers of cros_ec_cmd_xfer_status() use a similar set up of
> allocating and filling a message buffer and then copying any received
> data to a target buffer.
> 

cros_ec_cmd_xfer_status is already a wrapper, I dislike the idea of having three
ways to do the same (cros_ec_cmd_xfer, cros_ec_cmd_xfer_status and this new
one). I like the idea of have a wrapper that embeds the message allocation but
we should not confuse users with different calls that does the same.

So, I am for a change like this but I'd like to have all the users calling the
same wrapper (unless there is a good reason to not use it). A proposed roadmap
(to be discussed) for this would be.

1. Replace all the remaining "cros_ec_cmd_xfer" calls with
"cros_ec_cmd_xfer_status".
2. Modify cros_ec_cmd_xfer_status to embed the message allocation.

Thanks,
 Enric


> Create a utility function that performs this setup so that callers can
> use this function instead.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
>  drivers/platform/chrome/cros_ec_proto.c     | 53 +++++++++++++++++++++
>  include/linux/platform_data/cros_ec_proto.h |  5 ++
>  2 files changed, 58 insertions(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index da1b1c4504333..8ef3b7d27d260 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -5,6 +5,7 @@
>  
>  #include <linux/delay.h>
>  #include <linux/device.h>
> +#include <linux/mfd/cros_ec.h>
>  #include <linux/module.h>
>  #include <linux/platform_data/cros_ec_commands.h>
>  #include <linux/platform_data/cros_ec_proto.h>
> @@ -570,6 +571,58 @@ int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
>  }
>  EXPORT_SYMBOL(cros_ec_cmd_xfer_status);
>  
> +/**
> + * cros_ec_send_cmd_msg() - Utility function to send commands to ChromeOS EC.
> + * @ec: EC device struct.
> + * @version: Command version number (often 0).
> + * @command: Command ID including offset.
> + * @outdata: Data to be sent to the EC.
> + * @outsize: Size of the &outdata buffer.
> + * @indata: Data to be received from the EC.
> + * @insize: Size of the &indata buffer.
> + *
> + * This function is a wrapper around &cros_ec_cmd_xfer_status, and performs
> + * some of the common work involved with sending a command to the EC. This
> + * includes allocating and filling up a &struct cros_ec_command message buffer,
> + * and copying the received data to another buffer.
> + *
> + * Return: The number of bytes transferred on success or negative error code.
> + */
> +int cros_ec_send_cmd_msg(struct cros_ec_device *ec, unsigned int version,
> +			 unsigned int command, void *outdata,
> +			 unsigned int outsize, void *indata,
> +			 unsigned int insize)
> +{
> +	struct cros_ec_command *msg;
> +	int ret;
> +
> +	msg = kzalloc(sizeof(*msg) + max(outsize, insize), GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	msg->version = version;
> +	msg->command = command;
> +	msg->outsize = outsize;
> +	msg->insize = insize;
> +
> +	if (outdata && outsize > 0)
> +		memcpy(msg->data, outdata, outsize);
> +
> +	ret = cros_ec_cmd_xfer_status(ec, msg);
> +	if (ret < 0) {
> +		dev_warn(ec->dev, "Command failed: %d\n", msg->result);
> +		goto cleanup;
> +	}
> +
> +	if (insize)
> +		memcpy(indata, msg->data, insize);
> +
> +cleanup:
> +	kfree(msg);
> +	return ret;
> +}
> +EXPORT_SYMBOL(cros_ec_send_cmd_msg);
> +
>  static int get_next_event_xfer(struct cros_ec_device *ec_dev,
>  			       struct cros_ec_command *msg,
>  			       struct ec_response_get_next_event_v1 *event,
> diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
> index 30098a5515231..166ce26bdd79e 100644
> --- a/include/linux/platform_data/cros_ec_proto.h
> +++ b/include/linux/platform_data/cros_ec_proto.h
> @@ -201,6 +201,11 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
>  int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
>  			    struct cros_ec_command *msg);
>  
> +int cros_ec_send_cmd_msg(struct cros_ec_device *ec_dev, unsigned int version,
> +			 unsigned int command, void *outdata,
> +			 unsigned int outsize, void *indata,
> +			 unsigned int insize);
> +
>  int cros_ec_register(struct cros_ec_device *ec_dev);
>  
>  int cros_ec_unregister(struct cros_ec_device *ec_dev);
> 
