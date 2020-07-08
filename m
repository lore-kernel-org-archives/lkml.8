Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C10EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 19:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 384BF206E2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 19:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qot4vl7X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgGHTK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 15:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgGHTK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 15:10:57 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C58DC061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 12:10:57 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u185so18338464pfu.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 12:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dLXDbdD3tq5gDxGkxbvF5RLU0N3KNJ8yEFdDrQUR7lE=;
        b=Qot4vl7XmJWCqWjMWIN/aQ3y9aQGIyTYwBtR/40aP7+KkXf9L7mPJoxzzWMgonM52y
         zbz2srKXuVhETnrA85kx4jlJSBM/f+aeayJO0NJFsegRR8fwCVv0WouKmpNTLXaEaSu0
         5vKbs0r6+36zo7BtIvUwaKqp0hVy1X+K2rc3CjOmI7q3GYfD2IEO71xzzrJg0hZLC8eY
         PGxpsbpRQEtBmU+Ir4Z/RNZ67jpPDyfMGWY/BkNmYdxqTXNxpSDGm7+dtqAoYi/CZvdW
         UlB6LstmGvROCxuVvbh4hnXcDKbgKx9vjnM0oCb9DT222HBF/FWx9Cob1ri0Tw8vTEfF
         fD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dLXDbdD3tq5gDxGkxbvF5RLU0N3KNJ8yEFdDrQUR7lE=;
        b=bBtWraVur6YMa7XQuf4EwpNjkZfrLlxNqudk6v7NKNK6gm30ouIUnsvHrLi0Lo5txf
         yFm17LrIOCt9Jc9Q362ydRU6o9aPuojf1H7o6SrGL+GEhASWddqU1Bd5Bq8rtREnHVB4
         yonCDOApQqzb9Gev9FNFGRl/kGzy5D/KNcWc1gmEio2YUWhsoFT8MoBgn0guI3mGt8/2
         vCJr2gcKUYvnL8/tV7weC3yWdOjZFzJZvwVcWBmPaW44fwpefbnI1tnpVJIHD7w1nMTJ
         7bgOZn0BDwwn+W6EIQCDvm3EyuyvF/Me7VlOD/S3y0YKjG/u+TMrgEbCtQYUO6HKv5rw
         2+XQ==
X-Gm-Message-State: AOAM532nWCYzcjd5JxVLMpBArHbtyV7eeKDLkGiCFXxGRAqnLHhENj1Y
        OBt8mZmiDGM/RaD7IwVE43Y=
X-Google-Smtp-Source: ABdhPJzG5cxnpQmzcJpPMpevH07rAuaVG3/ub3qwqnZEJYbDkFoy+eLXIGWJl+6l0teRVkxKSAilgw==
X-Received: by 2002:a63:5c55:: with SMTP id n21mr48561050pgm.27.1594235456757;
        Wed, 08 Jul 2020 12:10:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q14sm482992pgk.86.2020.07.08.12.10.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 12:10:56 -0700 (PDT)
Subject: Re: chrome-platform/for-kernelci bisection:
 baseline.bootrr.rockchip-dp-probed on rk3399-gru-kevin
To:     "kernelci.org bot" <bot@kernelci.org>, gtucker@collabora.com,
        kernelci-results@groups.io,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
References: <5f06177f.1c69fb81.ed8e4.1a92@mx.google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <0d0475a1-c042-8025-f215-d81d04748b75@roeck-us.net>
Date:   Wed, 8 Jul 2020 12:10:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <5f06177f.1c69fb81.ed8e4.1a92@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/20 11:59 AM, kernelci.org bot wrote:
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> *                                                               *
> * If you do send a fix, please include this trailer:            *
> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> *                                                               *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> 
> chrome-platform/for-kernelci bisection: baseline.bootrr.rockchip-dp-probed on rk3399-gru-kevin
> 
> Summary:
>   Start:      154353417996 KERNELCI: x86_64_defconfig: Enable support for Chromebooks devices
>   Plain log:  https://storage.kernelci.org/chrome-platform/for-kernelci/v5.8-rc1-20-g154353417996/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.txt
>   HTML log:   https://storage.kernelci.org/chrome-platform/for-kernelci/v5.8-rc1-20-g154353417996/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html
>   Result:     8c9a6ef40bf4 platform/chrome: cros_ec_proto: Convert EC error codes to Linux error codes
> 
> Checks:
>   revert:     PASS
>   verify:     PASS
> 
> Parameters:
>   Tree:       chrome-platform
>   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git
>   Branch:     for-kernelci
>   Target:     rk3399-gru-kevin
>   CPU arch:   arm64
>   Lab:        lab-collabora
>   Compiler:   gcc-8
>   Config:     defconfig
>   Test case:  baseline.bootrr.rockchip-dp-probed
> 
> Breaking commit found:
> 
> -------------------------------------------------------------------------------
> commit 8c9a6ef40bf400c64c9907031bd32b59f9d4aea2
> Author: Guenter Roeck <linux@roeck-us.net>
> Date:   Sat Jul 4 07:26:07 2020 -0700
> 
>     platform/chrome: cros_ec_proto: Convert EC error codes to Linux error codes
>     
>     The EC reports a variety of error codes. Most of those, with the exception
>     of EC_RES_INVALID_VERSION, are converted to -EPROTO. As result, the actual
>     error code gets lost. Convert all EC errors to Linux error codes to report
>     a more meaningful error to the caller to aid debugging.
>     

Interesting. Well, good that the patch was abandoned, so I don't expect this
to be a problem in practice.

Guenter

>     Cc: Yu-Hsuan Hsu <yuhsuan@chromium.org>
>     Cc: Prashant Malani <pmalani@chromium.org>
>     Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>     Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
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
> -------------------------------------------------------------------------------
> 
> 
> Git bisection log:
> 
> -------------------------------------------------------------------------------
> git bisect start
> # good: [b3a9e3b9622ae10064826dccb4f7a52bd88c7407] Linux 5.8-rc1
> git bisect good b3a9e3b9622ae10064826dccb4f7a52bd88c7407
> # bad: [15435341799604f20adcbb5f69b7f0beb2a2f964] KERNELCI: x86_64_defconfig: Enable support for Chromebooks devices
> git bisect bad 15435341799604f20adcbb5f69b7f0beb2a2f964
> # good: [3c5ca501b46b91e68b935b4bd752a0aba5232208] platform/chrome: cros_ec_spi: Document missing function parameters
> git bisect good 3c5ca501b46b91e68b935b4bd752a0aba5232208
> # good: [20b736872f7f324438649a277ec711a646ce8e8d] platform/chrome: cros_ec_typec: Add PM support
> git bisect good 20b736872f7f324438649a277ec711a646ce8e8d
> # bad: [8c9a6ef40bf400c64c9907031bd32b59f9d4aea2] platform/chrome: cros_ec_proto: Convert EC error codes to Linux error codes
> git bisect bad 8c9a6ef40bf400c64c9907031bd32b59f9d4aea2
> # good: [e48bc01ed5adec203676c735365373b31c3c7600] platform/chrome: cros_ec_sensorhub: Fix EC timestamp overflow
> git bisect good e48bc01ed5adec203676c735365373b31c3c7600
> # first bad commit: [8c9a6ef40bf400c64c9907031bd32b59f9d4aea2] platform/chrome: cros_ec_proto: Convert EC error codes to Linux error codes
> -------------------------------------------------------------------------------
> 

