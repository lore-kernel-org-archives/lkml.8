Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2808C35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 19:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A63662082F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 19:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cvLez4k2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731218AbgBYTzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 14:55:24 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40205 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbgBYTzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 14:55:24 -0500
Received: by mail-pj1-f67.google.com with SMTP id 12so170375pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 11:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SnsV7ukks/HdHQSNSo2jKDAJZMw+RXgFpVQ1NWbWeJ4=;
        b=cvLez4k2FMczRwg3HTgCnssgLc9hcjpdA7sScgfJYSyKQS7N0vsqyEphpfVUGVNumO
         Lz4Zk63sF9n0txyw++6a+NP7F6D9+1wPKN++pGBrFoYrgtu7n+xBdAWoy0yrbsp/1wH8
         t36jE/s/FvXbCBtx+8eGLY8NLyK5vuww2AMH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SnsV7ukks/HdHQSNSo2jKDAJZMw+RXgFpVQ1NWbWeJ4=;
        b=mR9q6A6RG/7Z/W7Joj7HOUhxTAp/QCiLP1A1cr4BvcCQcHfdsERjdi2/pvpnFrSRJ1
         4ZxpR/O34jJT+SOPKJKI3GkJK/G8+ztBKgbGe6lmat1+HE88qKQSfzhTI+Sw53TVSVHC
         yoZKQjEL9eePh0ulh9tTHBXBh/V43rn2uk+ssl0AX89uV5P2Zs/gMbKL3d3gV5HAC1i6
         +171MBxurnPKBJkultXFh6GzfFbfywGC9hhncEz5bFmdxrT0ukuMSlkPiZFv9Kjc0ARi
         vy5lmrJyhgyryD13xonRdM7+ROPqPCTUHcoKMkhlE/3gJgDo/Wba1TNgDRKm2ttrTbTx
         lI4w==
X-Gm-Message-State: APjAAAUOf0aJeziu43GTUqfWX8yff+Qwe9HocUj092tceO/zujPqvaSn
        CoHli4MjwU7NJp3/GYgMkEuz8Q==
X-Google-Smtp-Source: APXvYqxWh9M0HRW+LvA3wwgav40rYeK2CMkz3dtqrIt1u7Qlo/BpNS1Yl+Z9MlJyn9b3v+TMF2BF3Q==
X-Received: by 2002:a17:90a:33a1:: with SMTP id n30mr746208pjb.6.1582660522012;
        Tue, 25 Feb 2020 11:55:22 -0800 (PST)
Received: from google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id s7sm4355059pjk.22.2020.02.25.11.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 11:55:21 -0800 (PST)
Date:   Tue, 25 Feb 2020 11:55:19 -0800
From:   Prashant Malani <pmalani@chromium.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        groeck@chromium.org, bleung@chromium.org, dtor@chromium.org,
        gwendal@chromium.org
Subject: Re: [PATCH 4/8] platform/chrome: cros_ec_chardev: Use
 cros_ec_cmd_xfer_status helper
Message-ID: <20200225195519.GC11971@google.com>
References: <20200220155859.906647-1-enric.balletbo@collabora.com>
 <20200220155859.906647-5-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220155859.906647-5-enric.balletbo@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On Thu, Feb 20, 2020 at 04:58:55PM +0100, Enric Balletbo i Serra wrote:
> This patch makes use of cros_ec_cmd_xfer_status() instead of
> cros_ec_cmd_xfer(). In this case the change is trivial and the only
> reason to do it is because we want to make cros_ec_cmd_xfer() a private
> function for the EC protocol and let people only use the
> cros_ec_cmd_xfer_status() to return Linux standard error codes.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  drivers/platform/chrome/cros_ec_chardev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_chardev.c b/drivers/platform/chrome/cros_ec_chardev.c
> index c65e70bc168d..b51ab24055f3 100644
> --- a/drivers/platform/chrome/cros_ec_chardev.c
> +++ b/drivers/platform/chrome/cros_ec_chardev.c
> @@ -301,7 +301,7 @@ static long cros_ec_chardev_ioctl_xcmd(struct cros_ec_dev *ec, void __user *arg)
>  	}
>  
>  	s_cmd->command += ec->cmd_offset;
> -	ret = cros_ec_cmd_xfer(ec->ec_dev, s_cmd);
> +	ret = cros_ec_cmd_xfer_status(ec->ec_dev, s_cmd);

One issue I see here is that if we were to later convert
cros_ec_cmd_xfer_status() to cros_ec_cmd(), we would lose the
s_cmd->result value, since I was hoping to avoid returning msg->result
via a pointer parameter. I don't know if userspace actually uses that, but I
am assuming it does.

So, should cros_ec_cmd() keep the *result pointer like so ?:

int cros_ec_cmd(struct cros_ec_device *ec, u32 version, u32 command,
               void *outdata, u32 outsize, void *indata, u32 insize, u32 *result);

This way, we can manually re-populate s_cmd->result with |*result|.

Or, should we drop msg->result while returning s_cmd to userspace? I am
guessing the answer is no, but thought I'd check with you first.

Best regards,


>  	/* Only copy data to userland if data was received. */
>  	if (ret < 0)
>  		goto exit;
> -- 
> 2.25.0
> 
