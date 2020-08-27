Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C4CC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DF9520786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XG3Ukr/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgH0TAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:00:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53313 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728083AbgH0S7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 14:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598554764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fUUDDjZXv5yzEYYBVFU9KPvv/h+kei9cu5LbNnNzrmo=;
        b=XG3Ukr/6QLZOYvUxcjxgTYvFFvAFCHKd3LQVBo5RiW5qWaP2tqznxPbKIittU+fNDgJOeU
        8XU+QsAb5ZRosjgFwE8zDmqjUiBux8Qf8ZdpeHRa88clb8cHmlc9ppeOPExI8psyfrrvG2
        50z/J+RqWRKsYZiNhwxdao41f07PJK0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-571-80VMWF9SOmiW2sRPYcdcsw-1; Thu, 27 Aug 2020 14:59:22 -0400
X-MC-Unique: 80VMWF9SOmiW2sRPYcdcsw-1
Received: by mail-qt1-f199.google.com with SMTP id w15so5540673qtv.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 11:59:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=fUUDDjZXv5yzEYYBVFU9KPvv/h+kei9cu5LbNnNzrmo=;
        b=n6Aagx5x9bDwskhSFbwtP7Orkd815OEYNi1bXdcCsfGdvWVvidO5dCDT/IL+Ub32sP
         9Mm7ckVedYrbVu70JFLcumizEmWdB1fybrqYxeQEe8hP1CpQyFsf8OaYWyYCeeGS+TZc
         78UCcY1fa2JjKarR4cPD/3e3xjYPwglk0+CwptWfh/Wkfg1cYcTf1Qgjiw7i9/fVbQ+S
         qIlHNhZIL+3I1FTETWAGbkZda/U77713C3U6LcnJsR+gLX9hYeHy1383Voqo10q+NEAl
         dV8U3H1aQQOAZrOsiZWSIe+yC474gXf04dy7cKz4M/jdDEwyRCktzrooqOzTg0aONfuw
         XsSg==
X-Gm-Message-State: AOAM531rA3yUsqhlv77CTmLUTF2QI/eGBzty68hQdM1LLnE47NIrJac3
        vHUFKZhuh+lCP7en5JcRwW/kI9JLOh4VTrmxkiP3yoL6+QUL/03aThRRiva/miZnOeX3ZIdabZL
        /1UnELI26Ku0012XVS5TT+iL4
X-Received: by 2002:a37:8d7:: with SMTP id 206mr13780613qki.422.1598554761838;
        Thu, 27 Aug 2020 11:59:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKXxjq2R9v1jyMl8bJ9Nhk7EYuCQRWNT9uUT49GRhHMbUd5Gtgzx56+NMa5Lv8TV+3FEQxLw==
X-Received: by 2002:a37:8d7:: with SMTP id 206mr13780596qki.422.1598554761599;
        Thu, 27 Aug 2020 11:59:21 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 71sm719020qki.85.2020.08.27.11.59.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 11:59:21 -0700 (PDT)
Subject: Re: [PATCH v2 3/5] fpga manager: xilinx-spi: rework write_complete
 loop implementation
To:     Luca Ceresoli <luca@lucaceresoli.net>, linux-fpga@vger.kernel.org
Cc:     Moritz Fischer <mdf@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anatolij Gustschin <agust@denx.de>
References: <20200827143249.10973-1-luca@lucaceresoli.net>
 <20200827143249.10973-3-luca@lucaceresoli.net>
From:   Tom Rix <trix@redhat.com>
Message-ID: <2b8d9ed7-0468-9001-2f8e-386312aae6cb@redhat.com>
Date:   Thu, 27 Aug 2020 11:59:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200827143249.10973-3-luca@lucaceresoli.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/27/20 7:32 AM, Luca Ceresoli wrote:
> In preparation to add error checking for gpiod_get_value(), rework
> the loop to avoid the duplication of these lines:
>
> 	if (gpiod_get_value(conf->done))
> 		return xilinx_spi_apply_cclk_cycles(conf);
>
> There is little advantage in this rework with current code. However
> error checking will expand these two lines to five, making code
> duplication more annoying.
>
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>
> ---
>
> This patch is new in v2
> ---
>  drivers/fpga/xilinx-spi.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
> index 01f494172379..cfc933d70f52 100644
> --- a/drivers/fpga/xilinx-spi.c
> +++ b/drivers/fpga/xilinx-spi.c
> @@ -151,22 +151,19 @@ static int xilinx_spi_write_complete(struct fpga_manager *mgr,
>  				     struct fpga_image_info *info)
>  {
>  	struct xilinx_spi_conf *conf = mgr->priv;
> -	unsigned long timeout;
> +	unsigned long timeout = jiffies + usecs_to_jiffies(info->config_complete_timeout_us);
>  	int ret;
>  
> -	if (gpiod_get_value(conf->done))
> -		return xilinx_spi_apply_cclk_cycles(conf);
> -
> -	timeout = jiffies + usecs_to_jiffies(info->config_complete_timeout_us);
> +	while (true) {
> +		if (gpiod_get_value(conf->done))
> +			return xilinx_spi_apply_cclk_cycles(conf);
>  
> -	while (time_before(jiffies, timeout)) {
> +		if (time_after(jiffies, timeout))
> +			break;
>  
>  		ret = xilinx_spi_apply_cclk_cycles(conf);
>  		if (ret)
>  			return ret;
> -
> -		if (gpiod_get_value(conf->done))
> -			return xilinx_spi_apply_cclk_cycles(conf);
>  	} 

Do you need another

	if (gpiod_get_value(conf->done))
		return xilinx_spi_apply_cclk_cycles(conf);

here to cover the chance of sleeping in the loop ?

Tom

>  
>  	dev_err(&mgr->dev, "Timeout after config data transfer\n");

