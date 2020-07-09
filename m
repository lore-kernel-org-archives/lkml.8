Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C605BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E7F62077D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F14FqFFx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgGINUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 09:20:53 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25918 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726497AbgGINUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 09:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594300851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=76OSvzSCUloauOhafR66c4WpoHtn6DispnTVDGjMLOA=;
        b=F14FqFFxuiKSLLFqgzu+RYBot9hYlGWH02C0TvimgrmSQmAOp8+O5WmTZh5NvasNjoN5Tg
        UAXFXbOiT0dTjaqF73nD8qM5Jgy4r6VW7oQogiFgN2jXCmCyzPz42g1enqeqBb6dcz2+Oq
        cSeuF6cfvpPu3F4eJkFlDw61RLDfeJk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-B5tOiIXGO3S0QoEVJD4hng-1; Thu, 09 Jul 2020 09:20:50 -0400
X-MC-Unique: B5tOiIXGO3S0QoEVJD4hng-1
Received: by mail-qk1-f198.google.com with SMTP id p126so1725495qkf.15
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 06:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=76OSvzSCUloauOhafR66c4WpoHtn6DispnTVDGjMLOA=;
        b=bw+q8Kh5L/V/Xy7NcJ8u+Rd1ZGL6vEGAc2OOKfchcrZVnIeSc1Ds5cqNZs0o5r6r8N
         zeh+BEg21DvC2haNJLkctal3XEWbQ6UMSbN92ET3GH4KO4YsGEwzJXsPQ0yM36f+E9tX
         7vfPuZ5raQlOHgbIwMYPSpvs/Lwfqb2Opz0bVhon4OB8ArWS/LYLzco9sEIwescdjj3Y
         WMdP0w0X93mKUmwyInTz77g3bTY7SXwjBx84xUld+65R/qJKdaweomU4ItWUyFdU31Py
         tgUmTWcetN3ce+xpgLxKFSEqgoOBcoyBEnEyj6bGEW7LcCPfr7j7GGwXeXCsugBtqiji
         dyyw==
X-Gm-Message-State: AOAM531kD80uVarjUni7yS69wLBsx0R0ip84KYxkePVWVItZudbW6CJT
        7jlEiNEMpfeU+Twrfz9bWNnAwFwIg7bujEVj0a2r1P8YXTg77QszTZKAcawd9yyyrdddwCPWgzD
        kaPE/ldMSCJPZQmOF2GtynZHD
X-Received: by 2002:aed:3621:: with SMTP id e30mr65943938qtb.190.1594300847802;
        Thu, 09 Jul 2020 06:20:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwv9y/2XVgBqXA0qajhFxXtzwcjgCuGpUXH3oak5UIWbJ6fZG4M6hi43XJBds9zBMjZoNTfw==
X-Received: by 2002:aed:3621:: with SMTP id e30mr65943687qtb.190.1594300844420;
        Thu, 09 Jul 2020 06:20:44 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id p36sm3873647qta.0.2020.07.09.06.20.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 06:20:43 -0700 (PDT)
Subject: Re: [RESEND PATCH 2/2] fpga: dfl: fix bug in port reset handshake
To:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
References: <1594282337-32125-1-git-send-email-yilun.xu@intel.com>
 <1594282337-32125-3-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <c6984a5b-ce56-2094-a30e-a019d8721420@redhat.com>
Date:   Thu, 9 Jul 2020 06:20:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1594282337-32125-3-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/9/20 1:12 AM, Xu Yilun wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>
> When putting the port in reset, driver must wait for the soft reset
> acknowledgment bit instead of the soft reset bit.
>
> Fixes: 47c1b19c160f (fpga: dfl: afu: add port ops support)
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Acked-by: Wu Hao <hao.wu@intel.com>
> ---
>  drivers/fpga/dfl-afu-main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index 7c84fee..753cda4 100644
> --- a/drivers/fpga/dfl-afu-main.c
> +++ b/drivers/fpga/dfl-afu-main.c
> @@ -83,7 +83,8 @@ int __afu_port_disable(struct platform_device *pdev)
>  	 * on this port and minimum soft reset pulse width has elapsed.
>  	 * Driver polls port_soft_reset_ack to determine if reset done by HW.
>  	 */
> -	if (readq_poll_timeout(base + PORT_HDR_CTRL, v, v & PORT_CTRL_SFTRST,
> +	if (readq_poll_timeout(base + PORT_HDR_CTRL, v,
> +			       v & PORT_CTRL_SFTRST_ACK,
>  			       RST_POLL_INVL, RST_POLL_TIMEOUT)) {
>  		dev_err(&pdev->dev, "timeout, fail to reset device\n");
>  		return -ETIMEDOUT;

Looks ok to me.

Reviewed-by: Tom Rix <trix@redhat.com>

