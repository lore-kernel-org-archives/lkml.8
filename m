Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB85EC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 18:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B478F206FA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 18:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X12vqK2P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbgFESE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 14:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgFESE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 14:04:56 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9B7C08C5C2;
        Fri,  5 Jun 2020 11:04:54 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f3so5314726pfd.11;
        Fri, 05 Jun 2020 11:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Gl4m6hVinnfFSKepS1HCmQPY0u24GAicu5wcvYMKZIw=;
        b=X12vqK2PGSjxkksfrv2pFiM4EphDGJtMVGEYh8JCcpK34XvZXmzF76euZWI7GBZc4Y
         6YF41JWbC8tjp2fB7ZNZQFWGcNb1XAkjTy+syWo66mQc56ZLazixBXle6Ab3j8GImT6r
         +fCufvtPbAMzBzzq64/8u66R10CrSeBuoyrqx5QASpKH0DI6vBAy589edsq3PUEBhxR0
         FHCOWrE4EFE+84b1zWV3mAei+AVsSMjzoR/+FuQRjAMBXXB4huFzlrPVdzb67xy1CzxD
         j/a1MscIATO6nxxl1EhYVmoOU/dchXkbofvSEce3z11okM0IxQNYejDdhgLVVwxhaMXT
         XHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gl4m6hVinnfFSKepS1HCmQPY0u24GAicu5wcvYMKZIw=;
        b=PJ4FBXxWuS1ONEkpcc+7bFuotM6oBu4v8AZdvwJpmjOnw5UxqgQXtkyROdTmk6CF2E
         Zpvy5WC1RCOlkyF01QSAlpHZQ5OqRfItaemarB3POZr7Lml+HNSGAikWiBbC9w5WtCjH
         HfHRM2eeGz9PI2tEuK+qXg2uyJsftKtFHFX7BvBcHv+jUlLvkRSwpW9/rVCRpmPegVD3
         x+Mm3zfHWiqjGcyl+OROE6xjAWNdt3jwLKBCLnEErR4F2MJQUhwaGVeIRTgFbkRR2GLS
         KnbF0BUVJEa5K2WdbVNt+dRgF3pCOni8bDwX9udIps39QPff4YwIPekyZj4fQxNVcrMA
         MV+A==
X-Gm-Message-State: AOAM533oTKm5L+wd9IOGm148VMLAP8oLFWSfZBa2N2AQy3bVJFX2Vvma
        3b7pEiZr3Az7v/l9vlQFrJ7IeiL9
X-Google-Smtp-Source: ABdhPJwgCcoTPGG55GUhS7/TIb6qAwSriEDk4pDmFHrsijuGGztrWxmW8DC9Zd1TgTmFAi0ScK2aGw==
X-Received: by 2002:a63:3814:: with SMTP id f20mr10440957pga.266.1591380293630;
        Fri, 05 Jun 2020 11:04:53 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m24sm33379pgd.69.2020.06.05.11.04.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jun 2020 11:04:52 -0700 (PDT)
Date:   Fri, 5 Jun 2020 11:04:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Manikandan <manikandan.hcl.ers.epl@gmail.com>
Cc:     patrickw3@fb.com, vijaykhemka@fb.com, linux-hwmon@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, saipsdasari@fb.com, manikandan.e@hcl.com
Subject: Re: [PATCH v2] hwmon:(adm1275) Enable adm1278 ADM1278_TEMP1_EN
Message-ID: <20200605180451.GA201666@roeck-us.net>
References: <20200529124607.GA3469@cnn>
 <49485085-7cc7-9e29-a719-98d1e184378b@roeck-us.net>
 <20200605164821.GA29990@cnn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605164821.GA29990@cnn>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 10:18:21PM +0530, Manikandan wrote:
> On Fri, May 29, 2020 at 10:30:16AM -0700, Guenter Roeck wrote:
> > On 5/29/20 5:46 AM, Manikandan Elumalai wrote:
> > > The adm1278 temperature sysfs attribute need it for one of the openbmc platform . 
> > > This functionality is not enabled by default, so PMON_CONFIG needs to be modified in order to enable it.
> > > 
> > > Signed-off-by   : Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
> > 
> > This is not valid.
> > 
> > > 
> > > v2:
> > >    - Add Signed-off-by.
> > >    - Removed ADM1278_TEMP1_EN check.
> > 
> > checkpatch reports:
> > 
> > > ---WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
> > #14:
> > The adm1278 temperature sysfs attribute need it for one of the openbmc platform .
> > 
> > CHECK: Alignment should match open parenthesis
> > #45: FILE: drivers/hwmon/pmbus/adm1275.c:679:
> > +		ret = i2c_smbus_write_byte_data(client,
> > +					ADM1275_PMON_CONFIG,
> > 
> > WARNING: suspect code indent for conditional statements (16, 16)
> > #47: FILE: drivers/hwmon/pmbus/adm1275.c:681:
> > +		if (ret < 0) {
> > +		dev_err(&client->dev,
> > 
> > ERROR: Missing Signed-off-by: line(s)
> > 
> > total: 1 errors, 2 warnings, 1 checks, 33 lines checked
> > 
> > Please follow published guidelines when submitting patches.
> > 
> > >  drivers/hwmon/pmbus/adm1275.c | 21 +++++++++++++++++----
> > >  1 file changed, 17 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
> > > index 5caa37fb..ab5fceb 100644
> > > --- a/drivers/hwmon/pmbus/adm1275.c
> > > +++ b/drivers/hwmon/pmbus/adm1275.c
> > > @@ -666,7 +666,23 @@ static int adm1275_probe(struct i2c_client *client,
> > >  		tindex = 3;
> > >  
> > >  		info->func[0] |= PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT |
> > > -			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
> > > +			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
> > > +			PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
> > > +
> > > +		config = i2c_smbus_read_byte_data(client, ADM1275_PMON_CONFIG);
> > > +		if (config < 0)
> > > +			return config;
> > > +
> > > +		/* Enable TEMP1 by default */
> > > +		config |= ADM1278_TEMP1_EN;
> > > +		ret = i2c_smbus_write_byte_data(client,
> > > +					ADM1275_PMON_CONFIG,
> > > +					config);
> > > +		if (ret < 0) {
> > > +		dev_err(&client->dev,
> > > +			"Failed to enable temperature config\n");
> > > +		return -ENODEV;
> > > +		}
> > 
> > This can be handled in a single operation, together with ADM1278_VOUT_EN
> > below. There is no need for two separate write operations.
> >
>         Thanks for review Guenter, Patrick and Vijay.
>         Sorry for delay response. 
>         I have made changes to write ADM1278_VOUT_EN and ADM1278_TEMP1_EN in single
>         operation and tested in platfrom .
>         The changes given for quick look and will help if any misunderstand.
> 
> 	--- a/drivers/hwmon/pmbus/adm1275.c
> 	+++ b/drivers/hwmon/pmbus/adm1275.c
> 	@@ -666,11 +666,11 @@ static int adm1275_probe(struct i2c_client *client,
>  		tindex = 3;
>  
>  		info->func[0] |= PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT |
> 	-			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
> 	+			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT | 
>         +			PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
>  
>  		/* Enable VOUT if not enabled (it is disabled by default) */
>  		if (!(config & ADM1278_VOUT_EN)) {

		if (config & (ADM1278_VOUT_EN | ADM1278_TEMP1_EN) !=
						ADM1278_VOUT_EN | ADM1278_TEMP1_EN)

> 	-			config |= ADM1278_VOUT_EN;
> 	+			config |= (ADM1278_VOUT_EN | ADM1278_TEMP1_EN);

( ) is unnecessary here.

>  			ret = i2c_smbus_write_byte_data(client,
>  							ADM1275_PMON_CONFIG,
>  							config);
> 	@@ -680,10 +680,6 @@ static int adm1275_probe(struct i2c_client *client,
>  				return -ENODEV;
>  			}
>  		}
> 	-
> 	-		if (config & ADM1278_TEMP1_EN)
> 	-			info->func[0] |=
> 	-				PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
>  		if (config & ADM1278_VIN_EN)
>  			info->func[0] |= PMBUS_HAVE_VIN;
>  		break; 
> > Guenter
> > 
> > > 
> > >  		/* Enable VOUT if not enabled (it is disabled by default) */
> > >  		if (!(config & ADM1278_VOUT_EN)) {
> > > @@ -681,9 +697,6 @@ static int adm1275_probe(struct i2c_client *client,
> > >  			}
> > >  		}
> > >  
> > > -		if (config & ADM1278_TEMP1_EN)
> > > -			info->func[0] |=
> > > -				PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
> > >  		if (config & ADM1278_VIN_EN)
> > >  			info->func[0] |= PMBUS_HAVE_VIN;
> > >  		break;
> > > 
> > 
