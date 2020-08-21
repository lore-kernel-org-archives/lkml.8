Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DF5C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 05:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 034C720724
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 05:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597988434;
	bh=zRCjuahUes6jERrX4goHO80ytxWyRaqKLIhIomFNSjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dSyNhovD3KzAKBBRCZYFa+U+1/JuSlkwVGK20233okB6a+I0ds6O4WO9Kxx7NzsfS
	 0KAiGpy1iwifM6HATrOQ5jjG2S1IvDIJu+e6t0LeTjKF6VDMi8yS2GeCJheuZTOErZ
	 TZtxx4Fn+3WMOvgF5924QUP0UGA1ClbXHAb86tqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgHUFkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 01:40:31 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39523 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgHUFk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 01:40:28 -0400
Received: by mail-wm1-f66.google.com with SMTP id g75so626716wme.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 22:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GYy21gsBobrfE+n697gXaTEDTqhXl3ZvlItxvgDKUpg=;
        b=FxlrkUB/rGQMiwWReE7tiuSH2pDuN2H8yLnmV4+g5CTbN32NcU6zruJfczSeHiDlzT
         VNsFJFiqUTZi3FZNVOIx7rQCq2TmsGsEuo+wOzCE0GFd7qC2/lspUEp3dNW8xsNInR6U
         oBYh0uoIGYn6sLARp0iiypWgVG16gNLPW6vDbeb0jNLF0qKPBYQsT9x8G2qrQFe+lhvw
         qf5WciCiyjsMe15FA70O73XjkRNVqXiTTiYfsfqcIBw/jAc9pJlVnJDntPSqT6MHi3hz
         HCWwQpk1PrjQy+wGa5jZU7a6JdkUMrdKrsSfHWyKu/t5Xb3RRKvfUY/J5/nyQS3uc793
         mokQ==
X-Gm-Message-State: AOAM532TPuVhf58e+0J64dPRtEU9uUJwKJnQbSpriaLiq7gg6zcX+3C0
        xZB98R6J7qWXsPpkP5PFJUg=
X-Google-Smtp-Source: ABdhPJyKwq7JDwgNVczIaowypJVZ0FDSzLrM9VMY1YsL5y6vs+Zgx/KETjQQwLwGckNGQ1ngq5R/uQ==
X-Received: by 2002:a1c:ab06:: with SMTP id u6mr1228329wme.172.1597988426324;
        Thu, 20 Aug 2020 22:40:26 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id s20sm2220457wmh.21.2020.08.20.22.40.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Aug 2020 22:40:25 -0700 (PDT)
Date:   Fri, 21 Aug 2020 07:40:23 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Markus Mayer <markus.mayer@broadcom.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memory: brcmstb_dpfe: fix array index out of bounds
Message-ID: <20200821054023.GA3906@kozik-lap>
References: <20200821010333.20436-1-mmayer@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200821010333.20436-1-mmayer@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 06:03:33PM -0700, Markus Mayer wrote:
> We would overrun the error_text array if we hit a TIMEOUT condition,
> because we were using the error code "ETIMEDOUT" (which is 110) as an
> array index.
> 
> We fix the problem by correcting the array index and by providing a
> function to retrieve error messages rather than accessing the array
> directly. The function includes a bounds check that prevents the array
> from being overrun.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---
> 
> This patch was prepared in response to https://lkml.org/lkml/2020/8/18/505.
> 
>  drivers/memory/brcmstb_dpfe.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
> index 81abc4a98a27..a986a849f58e 100644
> --- a/drivers/memory/brcmstb_dpfe.c
> +++ b/drivers/memory/brcmstb_dpfe.c
> @@ -190,11 +190,6 @@ struct brcmstb_dpfe_priv {
>  	struct mutex lock;
>  };
>  
> -static const char * const error_text[] = {
> -	"Success", "Header code incorrect", "Unknown command or argument",
> -	"Incorrect checksum", "Malformed command", "Timed out",
> -};
> -
>  /*
>   * Forward declaration of our sysfs attribute functions, so we can declare the
>   * attribute data structures early.
> @@ -307,6 +302,20 @@ static const struct dpfe_api dpfe_api_v3 = {
>  	},
>  };
>  
> +static const char * const get_error_text(unsigned int i)

The pointer itself is returned by value and you cannot return a const
value. I mean, you can but it does not have an effect. Only pointed
memory should be const (const const char*).

Best regards,
Krzysztof


> +{
> +	static const char * const error_text[] = {
> +		"Success", "Header code incorrect",
> +		"Unknown command or argument", "Incorrect checksum",
> +		"Malformed command", "Timed out", "Unknown error",
> +	};
> +
> +	if (unlikely(i >= ARRAY_SIZE(error_text)))
> +		i = ARRAY_SIZE(error_text) - 1;
> +
> +	return error_text[i];
> +}
> +
>  static bool is_dcpu_enabled(struct brcmstb_dpfe_priv *priv)
>  {
>  	u32 val;
> @@ -446,7 +455,7 @@ static int __send_command(struct brcmstb_dpfe_priv *priv, unsigned int cmd,
>  	}
>  	if (resp != 0) {
>  		mutex_unlock(&priv->lock);
> -		return -ETIMEDOUT;
> +		return -ffs(DCPU_RET_ERR_TIMEDOUT);
>  	}
>  
>  	/* Compute checksum over the message */
> @@ -695,7 +704,7 @@ static ssize_t generic_show(unsigned int command, u32 response[],
>  
>  	ret = __send_command(priv, command, response);
>  	if (ret < 0)
> -		return sprintf(buf, "ERROR: %s\n", error_text[-ret]);
> +		return sprintf(buf, "ERROR: %s\n", get_error_text(-ret));
>  
>  	return 0;
>  }
> -- 
> 2.17.1
> 
