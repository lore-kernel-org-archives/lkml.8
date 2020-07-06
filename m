Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5623FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 18:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34B82206CD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 18:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fxaIpwip"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbgGFSwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 14:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729733AbgGFSwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 14:52:32 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4093AC061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 11:52:32 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id l6so14089498pjq.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 11:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LQf9W6lyj1BEyVBQY9ZVbVP6ArVDZ+iAsAbrwyXvk+A=;
        b=fxaIpwipZBmv6PkXDTJzLIHBSZELnRDWZVgzap0uWPXyvFG0nBSJxgTyLscWL7abpP
         O1ahM5LtzK3rP02DIwF1bQ5va3MHEbUuRIW/cIUdp4ORDpANzDwnS0eVo75rNPX9aS+b
         0Zbfl9Wlp2oaiE5bMKg1CpQJkuSqNKhYh3exY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LQf9W6lyj1BEyVBQY9ZVbVP6ArVDZ+iAsAbrwyXvk+A=;
        b=LF3UXPd7ZG6jF6gyXnl7zSo7cVFGlWB2yugG7YRU7sDuMqnlHPArcZWvZVcEVWLU6M
         PCOiLYo6vowsc0eJ6Ipp90lX9WvwXv4KDJisL3hclZSxvhjX/zIAZZ6pVZR1JFEnCH5W
         C9OlUOQlJWV2N1uWBExEVdp9L8YRuNwm7bbTEFsF4J0XBhtPqt/F1M0FA98tzl2ZEibr
         9/1g57A/WduSHVoCHX3iMpj2onaEeLsK4K0GIyNY8XO6NHkd34YE6t5zedoIDJrzeJ3R
         9OxTBu9/tK+62xUhyI6LXuVfvQRIk4+UdISBP9/LES1AJCN8PGmMfmw57nFnzZ08WInO
         NuNQ==
X-Gm-Message-State: AOAM53344rv4uiVgDdn7dOg0QqrQmMLQs62WKjsR/p2YiZBNnAmiiD/2
        KhCtEh5A4Ve342kc+2JW6o/17UqWGeA=
X-Google-Smtp-Source: ABdhPJzOsQ4YDB35Zt5zbVRtI1SB4BZQhSUH7T5psPfsLS88pqju7bJ1iHii/Ck7cviGl7xykl8/Mw==
X-Received: by 2002:a17:90a:cf01:: with SMTP id h1mr571326pju.234.1594061551462;
        Mon, 06 Jul 2020 11:52:31 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id h23sm5270455pfo.166.2020.07.06.11.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 11:52:31 -0700 (PDT)
Date:   Mon, 6 Jul 2020 11:52:30 -0700
From:   Prashant Malani <pmalani@chromium.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        linux-kernel@vger.kernel.org, Yu-Hsuan Hsu <yuhsuan@chromium.org>
Subject: Re: [PATCH] platform/chrome: cros_ec_proto: Convert EC error codes
 to Linux error codes
Message-ID: <20200706185230.GA792857@google.com>
References: <20200704142607.171400-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200704142607.171400-1-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On Sat, Jul 04, 2020 at 07:26:07AM -0700, Guenter Roeck wrote:
> The EC reports a variety of error codes. Most of those, with the exception
> of EC_RES_INVALID_VERSION, are converted to -EPROTO. As result, the actual
> error code gets lost. Convert all EC errors to Linux error codes to report
> a more meaningful error to the caller to aid debugging.
> 
> Cc: Yu-Hsuan Hsu <yuhsuan@chromium.org>
> Cc: Prashant Malani <pmalani@chromium.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
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

Do we expect a case where cros_ec_error_map[msg->result] == 0?

> +			ret = cros_ec_error_map[msg->result];
> +		else
> +			ret = -EPROTO;
> +		dev_dbg(ec_dev->dev, "Command result (err: %d [%d])\n", msg->result, ret);
>  	}
>  
>  	return ret;
> -- 
> 2.17.1
> 
