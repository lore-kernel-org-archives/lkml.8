Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0172DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 13:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D32F12078C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 13:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEclRi9m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgFJN2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 09:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgFJN2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 09:28:35 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB122C03E96B;
        Wed, 10 Jun 2020 06:28:35 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a127so1095732pfa.12;
        Wed, 10 Jun 2020 06:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5nPSs393bGASphPtnT357hjeVtfaWOHC4CaGSirIQ0k=;
        b=fEclRi9mXpZuNWCDGq3LGoLC69Zoh084aXEwqnhiUGzCy4Lveyjg5c3uHKbynX46QB
         /gPuG7HGhPtt3mFPHVuDj3DA005B7sHn0a+P2bygYpxaTgovINLQirbxyA7KMk+kmtEx
         0283ouBpmFZceDWliw8qkg/SQu7I91p+NVGbjK/l8fc2KG681YRY58RySnhFxPWqUvht
         6HfBwK0em+Guf8WDnxSsCEBXCIUigPxa8gKJuN/LeGC3h31Wr9/loSkugEo4w50eQe97
         6GpxoFjooLBWhdFIFHRRZid79h+TcbC2bOU8cpYtG2ctGb9ufBPZiVBhYvX09F2LFK7U
         qI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5nPSs393bGASphPtnT357hjeVtfaWOHC4CaGSirIQ0k=;
        b=I3cmnYN6CMJJNK60t9S6p6zL2EZxEjDvDBX892Y1bDJ/vX/fhASQS/1Z0rPLzQ3Dcy
         az8EjwnuYL0/OOfV9jjo0dusZR1L4CM+cpF9CdeN0TogmwxNZIAYkQWBBtclbs2fn85W
         96QyJs6FdW8skeN7WJ4O0d5lGl925iQr1dXLniEZrpMUNb0Sk67n7wvz07dok4Dt4n95
         X54kQt1mPnGJxRWF0q8Vuyi7pgAgP4vXj3D6fckqet8zX4qOCbwEI/wW2Kw8aEjQ0JHm
         AsuI7kPGJxzpxigW1UBqiOSQ8VVSPSBxVG0WJWNYAUpqCgntFdRNnUoHuvQwUiHyucke
         AHDA==
X-Gm-Message-State: AOAM5314RIXJmuENIbx5MP7ggF4/s+wyfdWa+t5Rk0Ms+AIOAOhmsV0e
        Vpwg3IIDQrLSXBahSGI4eD8=
X-Google-Smtp-Source: ABdhPJzZ/n/c5toEAWjdwCntIeRgVObVWoTwUoxNq25z0L3JlP1IwlRK5hoW1zpdPOdgFcDzIos5rA==
X-Received: by 2002:aa7:8387:: with SMTP id u7mr2816888pfm.90.1591795715320;
        Wed, 10 Jun 2020 06:28:35 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c12sm1505576pgm.73.2020.06.10.06.28.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Jun 2020 06:28:34 -0700 (PDT)
Date:   Wed, 10 Jun 2020 06:28:33 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, saipsdasari@fb.com, patrickw3@fb.com,
        vijaykhemka@fb.com, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, manikandan.e@hcl.com
Subject: Re: [PATCH v4] hwmon:(adm1275) Enable adm1278 ADM1278_TEMP1_EN
Message-ID: <20200610132833.GA237017@roeck-us.net>
References: <20200610082611.GA14266@cnn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610082611.GA14266@cnn>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 01:56:11PM +0530, Manikandan Elumalai wrote:
> The adm1278 temp attribute need it for openbmc platform .
> This feature not enabled by default, so PMON_CONFIG needs to enable it.
> 
> v4:
> Reported-by: kernel test robot <lkp@intel.com>
> ---
> changes in conditional check to enable vout & temp1 by default.
> v3:
> ----
> fix invalid signed-off.
> removed checkpath warnings.
> write ADM1278_TEMP1_EN and ADM1278_VOUT_EN conf in single line operation.
> v2:
> ----
> add Signed-off-by.
> removed ADM1278_TEMP1_EN check.
> 
> Signed-off-by: Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>

Applied (and I fixed the problem reported by 0-day, so no need to resend).

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/adm1275.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
> index 5caa37fb..d4e1925 100644
> --- a/drivers/hwmon/pmbus/adm1275.c
> +++ b/drivers/hwmon/pmbus/adm1275.c
> @@ -666,11 +666,12 @@ static int adm1275_probe(struct i2c_client *client,
>  		tindex = 3;
>  
>  		info->func[0] |= PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT |
> -			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
> +			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
> +			PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
>  
> -		/* Enable VOUT if not enabled (it is disabled by default) */
> -		if (!(config & ADM1278_VOUT_EN)) {
> -			config |= ADM1278_VOUT_EN;
> +		/* Enable VOUT & TEMP1 if not enabled (disabled by default) */
> +		if (config & (ADM1278_VOUT_EN | ADM1278_TEMP1_EN) != ADM1278_VOUT_EN | ADM1278_TEMP1_EN) {
> +			config |= ADM1278_VOUT_EN | ADM1278_TEMP1_EN;
>  			ret = i2c_smbus_write_byte_data(client,
>  							ADM1275_PMON_CONFIG,
>  							config);
> @@ -681,9 +682,6 @@ static int adm1275_probe(struct i2c_client *client,
>  			}
>  		}
>  
> -		if (config & ADM1278_TEMP1_EN)
> -			info->func[0] |=
> -				PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
>  		if (config & ADM1278_VIN_EN)
>  			info->func[0] |= PMBUS_HAVE_VIN;
>  		break;
