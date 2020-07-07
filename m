Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61E7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF5FB206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgGGKK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgGGKK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:10:58 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2ED3C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 03:10:57 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 87E242A5112
Subject: Re: [PATCH] platform/chrome: cros_ec_proto: Convert EC error codes to
 Linux error codes
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Prashant Malani <pmalani@chromium.org>
References: <20200704142607.171400-1-linux@roeck-us.net>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <7fd5528a-017e-d706-8092-8e1d6b187243@collabora.com>
Date:   Tue, 7 Jul 2020 12:10:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200704142607.171400-1-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant and Guenter,

Thank you to spend your time on look at this.

On 4/7/20 16:26, Guenter Roeck wrote:
> The EC reports a variety of error codes. Most of those, with the exception
> of EC_RES_INVALID_VERSION, are converted to -EPROTO. As result, the actual
> error code gets lost. Convert all EC errors to Linux error codes to report
> a more meaningful error to the caller to aid debugging.
> 
> Cc: Yu-Hsuan Hsu <yuhsuan@chromium.org>
> Cc: Prashant Malani <pmalani@chromium.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---

For me the patch looks good as is. Said that, I'd like to discuss a bit more
(but not too much) about it :-). My "concerns" are:

- It is not clear to me if some EC errors match directly to a linux kernel error
codes, the importance of them, and which action should be taken in that case or
if just reporting is enough.

- The EC result can be obtained, either, enabling more debug traces or using the
linux kernel tracing tools. So, IMO mapping _all_ the errors has very little value.

Right now, the policy I followed is return -EPROTO for all EC errors and
introduce/match a new error when someone (another kernel driver or userspace
needs to know about it, i.e [1], where some EC drivers do different actions if
-ENOTSUPP is returned). We introduced that error because we had a use case for it.

The future, I'd like to maintain this policy if it makes sense to you. And
introduce a new error when we have a use case for it. I.e if at some point a
kernel driver needs to know when the EC is busy (-EBUSY) because the driver
waits and retries again, I'll be fine to introduce this new error/match code.
Otherwise, I feel that has no really value.

Said that, if you still feel, that this will help you for debugging purposes, I
am completely fine to pick the patch.

Thoughts?

Thanks,
 Enric

[1]
commit c5cd2b47b203f63682778c2a1783198e6b644294
Author: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Date:   Thu Feb 20 16:58:52 2020 +0100

    platform/chrome: cros_ec_proto: Report command not supported

    In practice most drivers that use the EC protocol what really care is if
    the result was successful or not, hence, we introduced a
    cros_ec_cmd_xfer_status() function that converts EC errors to standard
    Linux error codes. On some few cases, though, we are interested on know
    if the command is supported or not, and in such cases, just ignore the
    error. To achieve this, return a -ENOTSUPP error when the command is not
    supported.


>  drivers/platform/chrome/cros_ec_proto.c | 37 +++++++++++++++++++------
>  1 file changed, 29 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index 3e745e0fe092..10aa9e483d35 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -543,6 +543,29 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
>  }
>  EXPORT_SYMBOL(cros_ec_cmd_xfer);
>  
> +static const int cros_ec_error_map[] = {
> +	[EC_RES_INVALID_COMMAND] = -EOPNOTSUPP,
> +	[EC_RES_ERROR] = -EIO,
> +	[EC_RES_INVALID_PARAM] = -EINVAL,
> +	[EC_RES_ACCESS_DENIED] = -EACCES,
> +	[EC_RES_INVALID_RESPONSE] = -EPROTO,
> +	[EC_RES_INVALID_VERSION] = -ENOTSUPP,
> +	[EC_RES_INVALID_CHECKSUM] = -EBADMSG,
> +	[EC_RES_IN_PROGRESS] = -EINPROGRESS,
> +	[EC_RES_UNAVAILABLE] = -ENODATA,
> +	[EC_RES_TIMEOUT] = -ETIMEDOUT,
> +	[EC_RES_OVERFLOW] = -EOVERFLOW,
> +	[EC_RES_INVALID_HEADER] = -EBADR,
> +	[EC_RES_REQUEST_TRUNCATED] = -EBADR,
> +	[EC_RES_RESPONSE_TOO_BIG] = -EFBIG,
> +	[EC_RES_BUS_ERROR] = -EFAULT,
> +	[EC_RES_BUSY] = -EBUSY,
> +	[EC_RES_INVALID_HEADER_VERSION] = -EBADMSG,
> +	[EC_RES_INVALID_HEADER_CRC] = -EBADMSG,
> +	[EC_RES_INVALID_DATA_CRC] = -EBADMSG,
> +	[EC_RES_DUP_UNAVAILABLE] = -ENODATA,
> +};
> +
>  /**
>   * cros_ec_cmd_xfer_status() - Send a command to the ChromeOS EC.
>   * @ec_dev: EC device.
> @@ -555,8 +578,7 @@ EXPORT_SYMBOL(cros_ec_cmd_xfer);
>   *
>   * Return:
>   * >=0 - The number of bytes transferred
> - * -ENOTSUPP - Operation not supported
> - * -EPROTO - Protocol error
> + * <0 - Linux error code
>   */
>  int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
>  			    struct cros_ec_command *msg)
> @@ -566,13 +588,12 @@ int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
>  	ret = cros_ec_cmd_xfer(ec_dev, msg);
>  	if (ret < 0) {
>  		dev_err(ec_dev->dev, "Command xfer error (err:%d)\n", ret);
> -	} else if (msg->result == EC_RES_INVALID_VERSION) {
> -		dev_dbg(ec_dev->dev, "Command invalid version (err:%d)\n",
> -			msg->result);
> -		return -ENOTSUPP;
>  	} else if (msg->result != EC_RES_SUCCESS) {
> -		dev_dbg(ec_dev->dev, "Command result (err: %d)\n", msg->result);
> -		return -EPROTO;
> +		if (msg->result < ARRAY_SIZE(cros_ec_error_map) && cros_ec_error_map[msg->result])
> +			ret = cros_ec_error_map[msg->result];
> +		else
> +			ret = -EPROTO;
> +		dev_dbg(ec_dev->dev, "Command result (err: %d [%d])\n", msg->result, ret);
>  	}
>  
>  	return ret;
> 
