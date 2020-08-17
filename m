Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDE0C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AC4420716
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B1zuT3bY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390695AbgHQSPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:15:48 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38774 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390473AbgHQSPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 14:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597688108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g80cYW2IFYoqF9vli22IsbwtpI2QtdO1qkGnkN211CA=;
        b=B1zuT3bYS1oN6dQVx2tWGtnGSP1cW5qRJKSnRWGvUY4wOM05IOoVP8ujQSF5by6gLvmcIa
        6zDQU82zG1Wu+VlMBpxQq/iSvdyEh8gONYQudUsEnf5ZLpiR+3uuxZ/k2zvV1riSUaG49i
        xJVP8g9JPteVrlRKRFlYEm1IvJN/PNk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-FB9DIeLkOOyqF7qsvLAS3g-1; Mon, 17 Aug 2020 14:15:07 -0400
X-MC-Unique: FB9DIeLkOOyqF7qsvLAS3g-1
Received: by mail-qk1-f200.google.com with SMTP id v16so11391726qka.18
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 11:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=g80cYW2IFYoqF9vli22IsbwtpI2QtdO1qkGnkN211CA=;
        b=Fzzt7CzNBPuWWhqO+XgjB/4s4Sjs6iwtgLncK7KGsGTKf8BHIAAY9kiaO6P0laLEMx
         D+FeJx4FtyNc6xStpMrlMWM/eTqNPkYlZTQXPLYacp95xVR3QuS/2xtFL4yoOcvawfJY
         jvafdCBJSMtuzpfAUCWnDDa/hmv+zk6Jo4VELDdKT2ych3nQo06CCnKrTfc+bK2UETrm
         ZBBrU/3tpgC4es6hARxfWdif+P6EjVw8zdHdnTW3/80R2DFJDBgFswdsNjzXAdDTEUsS
         FlClxBVGZvTv8qUL//StWSUkHaOOio4hJl6iyGubwwYTpmI8kLKL1MIeHa/8+4o2XDqp
         eSPQ==
X-Gm-Message-State: AOAM532mkApiolz4rFm9M3xmveoAUcHckkjMCnEBJlUj1t93Tc+YVoOS
        51dL11SOf9Y9mMXdat2imxEIHBxhJjgkcpyUPEGcMMlqO6T+iwVxo+PVEvXjr6QBDTUENHekv3N
        yymbrG4DGBlxkqKArrx6Afx0C
X-Received: by 2002:aed:2f84:: with SMTP id m4mr14446133qtd.61.1597688106682;
        Mon, 17 Aug 2020 11:15:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXUfqFuGv20cuhSCCCZGpqoNHsGaqjHh4vKhxtI6LiZdZbnvJveBje9ZvXIG7CvZAAvbAeOw==
X-Received: by 2002:aed:2f84:: with SMTP id m4mr14446091qtd.61.1597688106092;
        Mon, 17 Aug 2020 11:15:06 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s184sm18253320qkf.50.2020.08.17.11.15.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 11:15:05 -0700 (PDT)
Subject: Re: [PATCH 2/3] fpga manager: xilinx-spi: provide better diagnostics
 on programming failure
To:     Luca Ceresoli <luca@lucaceresoli.net>, linux-fpga@vger.kernel.org
Cc:     Moritz Fischer <mdf@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anatolij Gustschin <agust@denx.de>
References: <20200817165911.32589-1-luca@lucaceresoli.net>
 <20200817165911.32589-2-luca@lucaceresoli.net>
From:   Tom Rix <trix@redhat.com>
Message-ID: <b1a1a9d9-d36b-40f0-24e3-f793e55db929@redhat.com>
Date:   Mon, 17 Aug 2020 11:15:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200817165911.32589-2-luca@lucaceresoli.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The other two patches are fine.

On 8/17/20 9:59 AM, Luca Ceresoli wrote:
> When the DONE pin does not go high after programming to confirm programming
> success, the INIT_B pin provides some info on the reason. Use it if
> available to provide a more explanatory error message.
>
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  drivers/fpga/xilinx-spi.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
> index 502fae0d1d85..2aa942bb1114 100644
> --- a/drivers/fpga/xilinx-spi.c
> +++ b/drivers/fpga/xilinx-spi.c
> @@ -169,7 +169,16 @@ static int xilinx_spi_write_complete(struct fpga_manager *mgr,
>  			return xilinx_spi_apply_cclk_cycles(conf);
>  	}
>  
> -	dev_err(&mgr->dev, "Timeout after config data transfer.\n");
> +	if (conf->init_b) {
> +		int init_b_asserted = gpiod_get_value(conf->init_b);

gpiod_get_value can fail. So maybe need split the first statement.

init_b_asserted < 0 ? "invalid device"

As the if-else statement is getting complicated, embedding the ? : makes this hard to read.  'if,else if, else' would be better.

> +
> +		dev_err(&mgr->dev,
> +			init_b_asserted ? "CRC error or invalid device\n"
> +			: "Missing sync word or incomplete bitstream\n");
> +	} else {
> +		dev_err(&mgr->dev, "Timeout after config data transfer.\n");
patch 3 removes '.' s , and you just added one back in ?
> +	}
> +
>  	return -ETIMEDOUT;
>  }
>  

Reviewed-by: Tom Rix <trix@redhat.com>


