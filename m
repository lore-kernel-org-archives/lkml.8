Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D3CC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 15:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D92E920721
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 15:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbgBCP12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 10:27:28 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53752 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgBCP12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 10:27:28 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 074C72931F2
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH 01/17] platform/chrome: Add EC command msg wrapper
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Evan Green <evgreen@chromium.org>
References: <20200130203106.201894-1-pmalani@chromium.org>
 <20200130203106.201894-2-pmalani@chromium.org>
Message-ID: <86fb1f07-7677-52e6-024e-48528d5093b2@collabora.com>
Date:   Mon, 3 Feb 2020 16:27:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200130203106.201894-2-pmalani@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

Many thanks to work on this. Some comments below ...

On 30/1/20 21:30, Prashant Malani wrote:
> Many callers of cros_ec_cmd_xfer_status() use a similar set up of
> allocating and filling a message buffer and then copying any received
> data to a target buffer.
> 
> Create a utility function cros_ec_send_cmd_msg() that performs this
> setup so that callers can use this function instead. Subsequent patches
> will convert callers of cros_ec_cmd_xfer_status() to the new function
> instead.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
>  drivers/platform/chrome/cros_ec_proto.c     | 57 +++++++++++++++++++++
>  include/linux/platform_data/cros_ec_proto.h |  5 ++
>  2 files changed, 62 insertions(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index da1b1c45043333..53f3bfac71d90e 100644
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
> @@ -570,6 +571,62 @@ int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
>  }
>  EXPORT_SYMBOL(cros_ec_cmd_xfer_status);
>  
> +/**
> + * cros_ec_send_cmd_msg() - Utility function to send commands to ChromeOS EC.

I'm wondering if just cros_ec_cmd() shouldn't be a better name. If it's a
replacement of current user usage of cros_ec_cmd_xfer and
cros_ec_cmd_xfer_status, this will be used a lot, and have a short name and
clear will help the users of this helper.

> + * @ec: EC device struct.
> + * @version: Command version number (often 0).
> + * @command: Command ID including offset.
> + * @outdata: Data to be sent to the EC.
> + * @outsize: Size of the &outdata buffer.
> + * @indata: Data to be received from the EC.
> + * @insize: Size of the &indata buffer.
> + *
> + * This function is a wrapper around &cros_ec_cmd_xfer_status, and performs

You say that is a wrapper around cros_ec_cmd_xfer_status but then you remove
that function, and rewrite the doc here. Just explain for what is this helper
without referencing cros_ec_cmd_xfer_status and cros_ec_cmd_xfer.

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

Should we change the parameter types from "unsigned int" to "u32" to match both
ec hardware and the storage type in struct cros_ec_command?

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
> +	ret = cros_ec_cmd_xfer(ec, msg);
> +	if (ret < 0) {
> +		dev_err(ec->dev, "Command xfer error (err:%d)\n", ret);
> +		goto cleanup;
> +	} else if (msg->result != EC_RES_SUCCESS) {
> +		dev_dbg(ec->dev, "Command result (err: %d)\n", msg->result);
> +		ret = -EPROTO;
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
> index 30098a5515231d..166ce26bdd79eb 100644
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
