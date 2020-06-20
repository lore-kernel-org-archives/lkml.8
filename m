Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5ECC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 04:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B20812339D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 04:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltRuvf85"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgFTEx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 00:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgFTExZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 00:53:25 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226A0C06174E;
        Fri, 19 Jun 2020 21:53:24 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ne5so5054916pjb.5;
        Fri, 19 Jun 2020 21:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B7PIoTTOQyQgldJxXHjqhoJs7L5DCLB/7zFJYw2RHwI=;
        b=ltRuvf85ePzLXPA9VJ7V52Hj80K5bpNurQVyNrzWkeVO0bo0OhMMEhaBrHqpvdb/LV
         JdzzJiTuoQX104tXyFlUSq+AwHMXl49PRs4M9LTkbfu1mzYsVEstZwp4KBPl9YRc+nVv
         /Kcett2NEDZx1XZmPGE3BdH46Ft+ZfBSaj+3jC7sUlIzFaamOi/k50WtHsYiqJ9KAuHc
         fupBha5xjahlcHwNMsVb9hnrSwovy/n5JiiUoAbkwrOfo8+jeLWlntSPzsxQNrc5FxW/
         ZVUBwn6sPFEnkFFyi0d1vKZFTmwxv6fJdajBOk09lV47uw7S7+I1FB3IM6OfrrW/b4bv
         hKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B7PIoTTOQyQgldJxXHjqhoJs7L5DCLB/7zFJYw2RHwI=;
        b=Qv8OTVmuzy28PqzpYNRqPMmBnY9B1pXy7AGhQCE/9YB1G2EoA9AUGVFwhMlow+GiLg
         0Q4U1NMVVK0GQb6f6Mbs5UnCTKA504pZUVenUYUiZrPdhPTof7Bn9hHGX7yJty7LFLL3
         byra6SUD6nlg1mAlCt2Ha3Ab8NJB8Y2uKR02T8mDm01R2sx15sZyUClIz4w1wz6uquHj
         brfI7ypThaVSf0l9c+Y6smDHp/9ymvdVs+fDl6lnoo4FBvURXQBpNRDluugWx4bAkCGM
         Wu4nX9ZWahGyCI+SCxiRb5wqsW2YAhFsXgz4EseddwLhRgLrkWpGvOmymPPa52MDLM+Z
         7mKw==
X-Gm-Message-State: AOAM530j02W5UUjUOq9aWNBXuFHgoPYC21FdyJYvrmpLZBicjCMQW4cu
        tpi3rqPC6IC/Xw+TRezGoTc=
X-Google-Smtp-Source: ABdhPJx60JlTio6X5TeMTvbcHmjWmItMTHId0bmJ1mg3mZWmcXZueo/W2SKBXPD8HoWn6WQSgHKJFQ==
X-Received: by 2002:a17:90a:260e:: with SMTP id l14mr6952700pje.76.1592628803420;
        Fri, 19 Jun 2020 21:53:23 -0700 (PDT)
Received: from cnn ([112.133.236.114])
        by smtp.gmail.com with ESMTPSA id y81sm7445212pfb.33.2020.06.19.21.53.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jun 2020 21:53:22 -0700 (PDT)
Date:   Sat, 20 Jun 2020 10:23:15 +0530
From:   Manikandan <manikandan.hcl.ers.epl@gmail.com>
To:     miltonm@us.ibm.com
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, saipsdasari@fb.com, patrickw3@fb.com,
        vijaykhemka@fb.com, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, manikandan.e@hcl.com
Subject: Re: Linux-aspeed Digest, Vol 37, Issue 25
Message-ID: <20200620045315.GA27844@cnn>
References: <mailman.1431.1592592073.26230.linux-aspeed@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mailman.1431.1592592073.26230.linux-aspeed@lists.ozlabs.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 20, 2020 at 04:41:13AM +1000, linux-aspeed-request@lists.ozlabs.org wrote:
> Send Linux-aspeed mailing list submissions to
> 	linux-aspeed@lists.ozlabs.org
> 
> To subscribe or unsubscribe via the World Wide Web, visit
> 	https://lists.ozlabs.org/listinfo/linux-aspeed
> or, via email, send a message with subject or body 'help' to
> 	linux-aspeed-request@lists.ozlabs.org
> 
> You can reach the person managing the list at
> 	linux-aspeed-owner@lists.ozlabs.org
> 
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Linux-aspeed digest..."
> 
> 
> Today's Topics:
> 
>    1. [PATCH v4] hwmon:(adm1275) Enable adm1278 ADM1278_TEMP1_EN
>       (Manikandan Elumalai)
>    2. Re: [PATCH v4] hwmon:(adm1275) Enable adm1278
>       ADM1278_TEMP1_EN (Guenter Roeck)
>    3. [PATCH v4] hwmon:(adm1275) Enable adm1278 ADM1278_TEMP1_EN
>       (Manikandan Elumalai)
>    4. Re:  [PATCH v4] hwmon:(adm1275) Enable adm1278
>       ADM1278_TEMP1_EN (Milton Miller II)
>    5. Re: [PATCH v4] hwmon:(adm1275) Enable adm1278
>       ADM1278_TEMP1_EN (Guenter Roeck)
> 
> 
> ----------------------------------------------------------------------
> 
> Message: 1
> Date: Fri, 19 Jun 2020 20:18:53 +0530
> From: Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
> To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare
> 	<jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
> 	linux-kernel@vger.kernel.org
> Cc: saipsdasari@fb.com, patrickw3@fb.com, vijaykhemka@fb.com,
> 	linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
> 	manikandan.e@hcl.com
> Subject: [PATCH v4] hwmon:(adm1275) Enable adm1278 ADM1278_TEMP1_EN
> Message-ID: <20200619144853.GA18271@cnn>
> Content-Type: text/plain; charset=us-ascii
> 
> The adm1278 temp attribute need it for openbmc platform .
> This feature not enabled by default, so PMON_CONFIG needs to enable it.
> 
> v4:
> ---
> Reported-by: kernel test robot <lkp@intel.com>
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
> +		if ((config & (ADM1278_VOUT_EN | ADM1278_TEMP1_EN)) != (ADM1278_VOUT_EN | ADM1278_TEMP1_EN)) {
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
> -- 
> 2.7.4
> 
> 
> 
> ------------------------------
> 
> Message: 2
> Date: Fri, 19 Jun 2020 08:38:32 -0700
> From: Guenter Roeck <linux@roeck-us.net>
> To: Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
> Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
> 	linux-kernel@vger.kernel.org, saipsdasari@fb.com, patrickw3@fb.com,
> 	vijaykhemka@fb.com, linux-aspeed@lists.ozlabs.org,
> 	openbmc@lists.ozlabs.org, manikandan.e@hcl.com
> Subject: Re: [PATCH v4] hwmon:(adm1275) Enable adm1278
> 	ADM1278_TEMP1_EN
> Message-ID: <20200619153832.GA57109@roeck-us.net>
> Content-Type: text/plain; charset=us-ascii
> 
> On Fri, Jun 19, 2020 at 08:18:53PM +0530, Manikandan Elumalai wrote:
> > The adm1278 temp attribute need it for openbmc platform .
> > This feature not enabled by default, so PMON_CONFIG needs to enable it.
> > 
> > v4:
> > ---
> > Reported-by: kernel test robot <lkp@intel.com>
> > v3:
> > ----
> > fix invalid signed-off.
> > removed checkpath warnings.
> > write ADM1278_TEMP1_EN and ADM1278_VOUT_EN conf in single line operation.
> > v2:
> > ----
> > add Signed-off-by.
> > removed ADM1278_TEMP1_EN check.
> > 
> > Signed-off-by: Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
> 
> The problem is that this is after '---', meaning it is considered a comment.
> The Signed-off-by: tag needs to be located before the first '---'.
> The change log should not be part of the commit log and follow '---'.
> 
> Guenter
> 
> > ---
> >  drivers/hwmon/pmbus/adm1275.c | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
> > index 5caa37fb..d4e1925 100644
> > --- a/drivers/hwmon/pmbus/adm1275.c
> > +++ b/drivers/hwmon/pmbus/adm1275.c
> > @@ -666,11 +666,12 @@ static int adm1275_probe(struct i2c_client *client,
> >  		tindex = 3;
> >  
> >  		info->func[0] |= PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT |
> > -			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
> > +			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
> > +			PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
> >  
> > -		/* Enable VOUT if not enabled (it is disabled by default) */
> > -		if (!(config & ADM1278_VOUT_EN)) {
> > -			config |= ADM1278_VOUT_EN;
> > +		/* Enable VOUT & TEMP1 if not enabled (disabled by default) */
> > +		if ((config & (ADM1278_VOUT_EN | ADM1278_TEMP1_EN)) != (ADM1278_VOUT_EN | ADM1278_TEMP1_EN)) {
> > +			config |= ADM1278_VOUT_EN | ADM1278_TEMP1_EN;
> >  			ret = i2c_smbus_write_byte_data(client,
> >  							ADM1275_PMON_CONFIG,
> >  							config);
> > @@ -681,9 +682,6 @@ static int adm1275_probe(struct i2c_client *client,
> >  			}
> >  		}
> >  
> > -		if (config & ADM1278_TEMP1_EN)
> > -			info->func[0] |=
> > -				PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
> >  		if (config & ADM1278_VIN_EN)
> >  			info->func[0] |= PMBUS_HAVE_VIN;
> >  		break;
> > -- 
> > 2.7.4
> > 
> 
> 
> ------------------------------
> 
> Message: 3
> Date: Fri, 19 Jun 2020 22:21:54 +0530
> From: Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
> To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare
> 	<jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
> 	linux-kernel@vger.kernel.org
> Cc: saipsdasari@fb.com, patrickw3@fb.com, vijaykhemka@fb.com,
> 	linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
> 	manikandan.e@hcl.com
> Subject: [PATCH v4] hwmon:(adm1275) Enable adm1278 ADM1278_TEMP1_EN
> Message-ID: <20200619165154.GA20461@cnn>
> Content-Type: text/plain; charset=us-ascii
> 
> The adm1278 temp attribute need it for openbmc platform .
> This feature not enabled by default, so PMON_CONFIG needs to enable it.
> 
> Signed-off-by: Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
> ---
> ---    v4 -Reported-by: kernel test robot <lkp@intel.com>
> ---    v3 -fix invalid signed-off.
> ---       -removed checkpath warnings.
> ---       -write ADM1278_TEMP1_EN and ADM1278_VOUT_EN conf in single line operation.
> ---    v2 -add Signed-off-by.
> ---       -removed ADM1278_TEMP1_EN check.
> ---
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
> +		if ((config & (ADM1278_VOUT_EN | ADM1278_TEMP1_EN)) != (ADM1278_VOUT_EN | ADM1278_TEMP1_EN)) {
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
> -- 
> 2.7.4
> 
> 
> 
> ------------------------------
> 
> Message: 4
> Date: Fri, 19 Jun 2020 18:09:55 +0000
> From: "Milton Miller II" <miltonm@us.ibm.com>
> To: Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
> Cc: Guenter Roeck <linux@roeck-us.net>, Jean Delvare
> 	<jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
> 	linux-kernel@vger.kernel.org, manikandan.e@hcl.com,
> 	linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
> 	vijaykhemka@fb.com, saipsdasari@fb.com, patrickw3@fb.com
> Subject: Re:  [PATCH v4] hwmon:(adm1275) Enable adm1278
> 	ADM1278_TEMP1_EN
> Message-ID:
> 	<OFB20C104E.283BBF6D-ON0025858C.0062CC5B-0025858C.0063C8F2@notes.na.collabserv.com>
> 	
> Content-Type: text/plain; charset=UTF-8
> 
> On : 06/19/2020 abiout 12:46PM in some timezone,  Manikandan Elumalai  wrote:
> 
> >The adm1278 temp attribute need it for openbmc platform .
> >This feature not enabled by default, so PMON_CONFIG needs to enable
> >it.
> >
> >Signed-off-by: Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
> >---
> >---    v4 -Reported-by: kernel test robot <lkp@intel.com>
> 
> Thie above tag should be Adjacent to the Signed-off-by.

     Thanks for review Milton.I will update new patch v6.
> 
> >---    v3 -fix invalid signed-off.
> >---       -removed checkpath warnings.
> >---       -write ADM1278_TEMP1_EN and ADM1278_VOUT_EN conf in single
> >line operation.
> >---    v2 -add Signed-off-by.
> >---       -removed ADM1278_TEMP1_EN check.
> >---
> 
> The canonical format is to have a line of 3 dashes then the trailing changelog 
> 
  will do.
> Please read the documentation at 
> 
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#the-canonical-patch-format
> 
> milton
> 
> 
> 
> ------------------------------
> 
> Message: 5
> Date: Fri, 19 Jun 2020 11:41:03 -0700
> From: Guenter Roeck <linux@roeck-us.net>
> To: Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>, Jean
> 	Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
> 	linux-kernel@vger.kernel.org
> Cc: saipsdasari@fb.com, patrickw3@fb.com, vijaykhemka@fb.com,
> 	linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
> 	manikandan.e@hcl.com
> Subject: Re: [PATCH v4] hwmon:(adm1275) Enable adm1278
> 	ADM1278_TEMP1_EN
> Message-ID: <fa65b6de-b7ea-894b-7fd1-47676cc3c705@roeck-us.net>
> Content-Type: text/plain; charset=utf-8
> 
> On 6/19/20 9:51 AM, Manikandan Elumalai wrote:
> > The adm1278 temp attribute need it for openbmc platform .
> > This feature not enabled by default, so PMON_CONFIG needs to enable it.
> > 
> > Signed-off-by: Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
> 
> In addition to the other comment - please never send a new version of a patch
> with the same sequence number. There are now two different versions of this patch,
> both tagged "v4".
> 
> Guenter
> 
> > ---
> > ---    v4 -Reported-by: kernel test robot <lkp@intel.com>
> > ---    v3 -fix invalid signed-off.
> > ---       -removed checkpath warnings.
> > ---       -write ADM1278_TEMP1_EN and ADM1278_VOUT_EN conf in single line operation.
> > ---    v2 -add Signed-off-by.
> > ---       -removed ADM1278_TEMP1_EN check.
> > ---
> > ---
> >  drivers/hwmon/pmbus/adm1275.c | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
> > index 5caa37fb..d4e1925 100644
> > --- a/drivers/hwmon/pmbus/adm1275.c
> > +++ b/drivers/hwmon/pmbus/adm1275.c
> > @@ -666,11 +666,12 @@ static int adm1275_probe(struct i2c_client *client,
> >  		tindex = 3;
> >  
> >  		info->func[0] |= PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT |
> > -			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
> > +			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
> > +			PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
> >  
> > -		/* Enable VOUT if not enabled (it is disabled by default) */
> > -		if (!(config & ADM1278_VOUT_EN)) {
> > -			config |= ADM1278_VOUT_EN;
> > +		/* Enable VOUT & TEMP1 if not enabled (disabled by default) */
> > +		if ((config & (ADM1278_VOUT_EN | ADM1278_TEMP1_EN)) != (ADM1278_VOUT_EN | ADM1278_TEMP1_EN)) {
> > +			config |= ADM1278_VOUT_EN | ADM1278_TEMP1_EN;
> >  			ret = i2c_smbus_write_byte_data(client,
> >  							ADM1275_PMON_CONFIG,
> >  							config);
> > @@ -681,9 +682,6 @@ static int adm1275_probe(struct i2c_client *client,
> >  			}
> >  		}
> >  
> > -		if (config & ADM1278_TEMP1_EN)
> > -			info->func[0] |=
> > -				PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
> >  		if (config & ADM1278_VIN_EN)
> >  			info->func[0] |= PMBUS_HAVE_VIN;
> >  		break;
> > 
> 
> 
> 
> ------------------------------
> 
> Subject: Digest Footer
> 
> _______________________________________________
> Linux-aspeed mailing list
> Linux-aspeed@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linux-aspeed
> 
> 
> ------------------------------
> 
> End of Linux-aspeed Digest, Vol 37, Issue 25
> ********************************************
