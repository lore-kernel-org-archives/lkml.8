Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD76C35242
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF102077C
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579946415;
	bh=L07rvQaFkM1gzQAyopMIziX4o5aOxQ65cRpKsEZRb6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=igaeNJuTMU6WF8IMXibQj9g2ry/6ni25WKTRIPPj+edKl7qvrjH6pQLp11JK0Xi5p
	 m94lpbvt2LIVn8GIPdY/1teUfzdumQUCoXUrEOQOX7Uwq5beyD5U6to+RoC9mHTOPg
	 nTBCNrqElrVyXomoH/VvysjiKzm0BjGeKVsnhKVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgAYKAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:00:14 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39703 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgAYKAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:00:14 -0500
Received: by mail-lj1-f193.google.com with SMTP id o11so5384732ljc.6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jan 2020 02:00:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MHWw4kl2aot/YGxzGbaCamrHDbhqRBfZpQ0nnwKFfPM=;
        b=fYi7Y7PDhcwBV70GKHb6LgD+ZOx+f62SimAYUs9/SusBiu7eHv2d2R6oNnYjB75T//
         DYgGZBSpGVYg1oimHmJ5Ev+x5/0jaY7Jv6XNiEKCs3U7Y4xU0plJex5eIjJwAufDuXz9
         Fuk/NUC0UbNzOhteJnyHZFGQmLezhY9hi1XOa8dV0GZtuk9vFnI4howFEDEEwXEDKVDn
         l4/3tkROYxjQuO/bFRO1z+QjgJOxk/GQrEvl32AXtG1D7/rdNPFixw42eeiZMldiTd4M
         g9udfmqF9umruMxRxc4Oe7f1TJifSl7j5BR66gwUGP6pPvJki+RKkuI4bJFCsRtxhAIM
         DvRQ==
X-Gm-Message-State: APjAAAUaeswCHcsPYNfVwtfKM1uWecmcMIl4IaHrRW/hZm1cQKTeB1/k
        Raw1+mQMbsebGAIy87jQS/OzJSKZ
X-Google-Smtp-Source: APXvYqzY/gjJLHtoy42/JWEBqLJS3tnrXvBP3FoLalRJUR3ccUOBE8/r9ZVt6Igb5iCiHrIHlzc/IQ==
X-Received: by 2002:a2e:96c6:: with SMTP id d6mr4826945ljj.4.1579946412653;
        Sat, 25 Jan 2020 02:00:12 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id j19sm5025204lfb.90.2020.01.25.02.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2020 02:00:11 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1ivIEd-0003OI-TL; Sat, 25 Jan 2020 11:00:11 +0100
Date:   Sat, 25 Jan 2020 11:00:11 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     vireshk@kernel.org, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
Subject: Re: [PATCH] staging: greybus: bootrom: fix uninitialized variables
Message-ID: <20200125100011.GK8375@localhost>
References: <20200125084403.GA3386@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200125084403.GA3386@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2020 at 02:14:03PM +0530, Saurav Girepunje wrote:
> fix uninitialized variables issue found using static code analysis tool

Which tool is that?

> (error) Uninitialized variable: offset
> (error) Uninitialized variable: size
>
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
>   drivers/staging/greybus/bootrom.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/bootrom.c b/drivers/staging/greybus/bootrom.c
> index a8efb86..9eabeb3 100644
> --- a/drivers/staging/greybus/bootrom.c
> +++ b/drivers/staging/greybus/bootrom.c
> @@ -245,7 +245,7 @@ static int gb_bootrom_get_firmware(struct gb_operation *op)
>   	struct gb_bootrom_get_firmware_request *firmware_request;
>   	struct gb_bootrom_get_firmware_response *firmware_response;
>   	struct device *dev = &op->connection->bundle->dev;
> -	unsigned int offset, size;
> +	unsigned int offset = 0, size = 0;
>   	enum next_request_type next_request;
>   	int ret = 0;

I think this has come up in the past, and while the code in question is
overly complicated and confuses static checkers as well as humans, it
looks correct to me.

Please make sure to verify the output of any tools before posting
patches based on them.

Johan
