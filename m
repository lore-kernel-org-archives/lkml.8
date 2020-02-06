Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8A4C352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D9321775
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581021939;
	bh=b5L/7neZks6SxBsJUMzzaZtT0XdM3q38CPeJu18A/co=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CiDui5VQuD0q79nVD26hvTUjz+m9r9VL6EM1Cv84q8S5MrtZsmIngZsUtLKXiciQg
	 fgAcZdyTahPencSkH9xGCvfdtg38Y/jcOmw/97ftQH/IkYCuhY4MKCsdTgcvEUVKfv
	 fCJ8FKZJ6kI6KACU7vlUf3fuGOqe5ywEaZ3DX/5g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgBFUpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 15:45:38 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33877 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbgBFUpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 15:45:36 -0500
Received: by mail-pf1-f194.google.com with SMTP id i6so64517pfc.1;
        Thu, 06 Feb 2020 12:45:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UQjt4WVJ28WaJURpUjHhblvvrGRzOLhJAhseMuxTJOc=;
        b=TOpwL3yNtPnkzaQ1hjrp+t58b2pHbZoU27pdiq5x7Eoyf1KeXVY3YEZPe9w0GFPTUU
         V5llv0oMgVtFp3yydTNlfHXSkOWIvKQKgZanigHqOzmv3xFguP7FNLPuMo3g/LkCUDEk
         ph9UhH//gBVOOMzp51rqdx4dsApvAemlh5cloumLerk9BN0UsJlqPcVvFLbRSlBIbei1
         6G2VO02N3ghvOLoylPKRnRrGoU/mDOJ9ikhExia8NsUb9NLsNqmt/WpldNjx88ZQ7E+X
         fuaZwAJ/MyYY5R/GaTsLML/38T7KYrhgZ+OH+d19wze/oThFprzKf56ryQZyPXyGk3t/
         RAbg==
X-Gm-Message-State: APjAAAUhJBNZGIMJBDkmJx10pOrzD1LR0jfe0Sosy61bgF/T1/Qr7yX1
        67R46EuuCJYZXTm6HaVUUg==
X-Google-Smtp-Source: APXvYqy59y0DOw/mTxpVJ6WbFI4h+r6pFsRuD3AZ2j+dQn50bkNfTE4aLed3JpZuFsPT5ruTsWdXSw==
X-Received: by 2002:aa7:9633:: with SMTP id r19mr6165120pfg.90.1581021934395;
        Thu, 06 Feb 2020 12:45:34 -0800 (PST)
Received: from rob-hp-laptop (63-158-47-182.dia.static.qwest.net. [63.158.47.182])
        by smtp.gmail.com with ESMTPSA id v7sm281923pfn.61.2020.02.06.12.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 12:45:33 -0800 (PST)
Received: (nullmailer pid 8782 invoked by uid 1000);
        Thu, 06 Feb 2020 17:12:10 -0000
Date:   Thu, 6 Feb 2020 17:12:10 +0000
From:   Rob Herring <robh@kernel.org>
To:     Mike Jones <michael-a1.jones@analog.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@roeck-us.net, jdelvare@suse.com, corbet@lwn.net
Subject: Re: [PATCH 3/3] hwmon: (pmbus/ltc2978): add support for more parts.
Message-ID: <20200206171210.GA4241@bogus>
References: <1580234400-2829-1-git-send-email-michael-a1.jones@analog.com>
 <1580234400-2829-3-git-send-email-michael-a1.jones@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580234400-2829-3-git-send-email-michael-a1.jones@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 11:00:00AM -0700, Mike Jones wrote:
> LTC2972, LTC2979, LTC3884, LTC3889, LTC7880, LTM4664, LTM4677,
> LTM4678, LTM4680, LTM4700.
> 
> Signed-off-by: Mike Jones <michael-a1.jones@analog.com>
> ---
>  .../devicetree/bindings/hwmon/ltc2978.txt          |  22 ++-

DT bindings should be a separate patch.

>  Documentation/hwmon/ltc2978.rst                    | 164 ++++++++++++++++-----
>  drivers/hwmon/pmbus/Kconfig                        |  11 +-
>  drivers/hwmon/pmbus/ltc2978.c                      |  92 +++++++++++-
>  4 files changed, 238 insertions(+), 51 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ltc2978.txt b/Documentation/devicetree/bindings/hwmon/ltc2978.txt
> index b428a70..4e7f621 100644
> --- a/Documentation/devicetree/bindings/hwmon/ltc2978.txt
> +++ b/Documentation/devicetree/bindings/hwmon/ltc2978.txt
> @@ -2,20 +2,30 @@ ltc2978
>  
>  Required properties:
>  - compatible: should contain one of:
> +  * "lltc,ltc2972"
>    * "lltc,ltc2974"
>    * "lltc,ltc2975"
>    * "lltc,ltc2977"
>    * "lltc,ltc2978"
> +  * "lltc,ltc2979"
>    * "lltc,ltc2980"
>    * "lltc,ltc3880"
>    * "lltc,ltc3882"
>    * "lltc,ltc3883"
> +  * "lltc,ltc3884"
>    * "lltc,ltc3886"
>    * "lltc,ltc3887"
> +  * "lltc,ltc3889"
> +  * "lltc,ltc7880"
>    * "lltc,ltm2987"
> +  * "lltc,ltm4664"
>    * "lltc,ltm4675"
>    * "lltc,ltm4676"
> +  * "lltc,ltm4677"
> +  * "lltc,ltm4678"
> +  * "lltc,ltm4680"
>    * "lltc,ltm4686"
> +  * "lltc,ltm4700"
>  - reg: I2C slave address
>  
>  Optional properties:
> @@ -25,13 +35,17 @@ Optional properties:
>    standard binding for regulators; see regulator.txt.
>  
>  Valid names of regulators depend on number of supplies supported per device:
> +  * ltc2972 vout0 - vout1
>    * ltc2974, ltc2975 : vout0 - vout3
> -  * ltc2977, ltc2980, ltm2987 : vout0 - vout7
> +  * ltc2977, ltc2979, ltc2980, ltm2987 : vout0 - vout7
>    * ltc2978 : vout0 - vout7
> -  * ltc3880, ltc3882, ltc3886 : vout0 - vout1
> +  * ltc3880, ltc3882, ltc3884, ltc3886, ltc3887, ltc3889 : vout0 - vout1
> +  * ltc7880 : vout0 - vout1
>    * ltc3883 : vout0
> -  * ltm4676 : vout0 - vout1
> -  * ltm4686 : vout0 - vout1
> +  * ltm4664 : vout0 - vout1
> +  * ltm4675, ltm4676, ltm4677, ltm4678 : vout0 - vout1
> +  * ltm4680, ltm4686 : vout0 - vout1
> +  * ltm4700 : vout0 - vout1
>  
>  Example:
>  ltc2978@5e {
