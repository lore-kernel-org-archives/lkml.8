Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2B1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 14:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65D602072F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 14:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPb6shlw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbgFJOxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 10:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbgFJOw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 10:52:58 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723E7C03E96B;
        Wed, 10 Jun 2020 07:52:57 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id jz3so939043pjb.0;
        Wed, 10 Jun 2020 07:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W5XkcC7KeYS10PiOng4uQLLTra/keU9RDeMCG9b6HTE=;
        b=sPb6shlw/GMM34jCjyI+1IyQl4hjR/gFWJT6F1W1mWxRRFErqnyy4lHrqQqDvzki4D
         HWjwpt79BKVEZlT/4vlA7Ly8ojfKRPU6RcNA7BxoWt2xC7fX+vMKkINKQDJNT8iOzA8a
         /acoLzDyGF/oRQShetdsDD2X7jOGGZ+SD68udu7rqFtnh6G4NrKf/fgQM26zjjpykRxt
         7n/nBGjtNaBwkIu+I1M4EutJwtWZ/Tah9TQybU2I1181c3LgNk/ctC1FggbDvtMeDGcG
         lptWQfeoGMvUS6Czd/p2Dn/C3dtUjqPuy7TUtwUZoiwlkJ3+XivdFUxQjNa9sOEE/fvE
         Fo9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W5XkcC7KeYS10PiOng4uQLLTra/keU9RDeMCG9b6HTE=;
        b=lH7wYDq3E3LonMKXUXzXnWXT8OPbZQf+QMkpdX50jFZN9CtFILJYeX0KIf72uwRd4N
         KI+78GrCB6c2S3O4fjmi0bd+N20HTDL2Z2hQHBVv0Ol1D5XhtYHJfjz7TirOPCuyqsBp
         jZrnm92yDsomIuDayj6MRP5NGqXvasK+QIJot+pqB+7mhO8E2nDWyurESV5d1V/Sc2vR
         pmc7Mng1T1rWUQnwVieg6XxUBcBXMjGmO3lFcCSyjSMBDt7iPy9LfSxEwxLBgBXJwqrA
         kkDBqrh0q5u72Ou/ifbnTHhfffshNlMCqvzhmV8hGDgH3wVDQHkTBc/JlBcP5lYFiqqa
         lpig==
X-Gm-Message-State: AOAM532PVIRhoe8RebOv1u2Z4SCevD2jthHRhjQKlh5nCH9vIuU+y8RR
        QgOyfKLRqNdFL8kUNdJVn8o=
X-Google-Smtp-Source: ABdhPJyKgwdIOuUz7O0lHPIz41Jqpk6jni0GZnkqI+vYAHow4N0nEvag/EnBCXAmZff942QnsJ46Vg==
X-Received: by 2002:a17:90b:1087:: with SMTP id gj7mr3513264pjb.124.1591800777042;
        Wed, 10 Jun 2020 07:52:57 -0700 (PDT)
Received: from cnn ([2402:3a80:464:d8d9:cd72:839f:5826:c552])
        by smtp.gmail.com with ESMTPSA id a5sm203465pfi.41.2020.06.10.07.52.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jun 2020 07:52:56 -0700 (PDT)
Date:   Wed, 10 Jun 2020 20:22:50 +0530
From:   Manikandan <manikandan.hcl.ers.epl@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, saipsdasari@fb.com, patrickw3@fb.com,
        vijaykhemka@fb.com, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, manikandan.e@hcl.com
Subject: Re: [PATCH v4] hwmon:(adm1275) Enable adm1278 ADM1278_TEMP1_EN
Message-ID: <20200610145250.GA25183@cnn>
References: <20200610082611.GA14266@cnn>
 <20200610132833.GA237017@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610132833.GA237017@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 06:28:33AM -0700, Guenter Roeck wrote:
> On Wed, Jun 10, 2020 at 01:56:11PM +0530, Manikandan Elumalai wrote:
> > The adm1278 temp attribute need it for openbmc platform .
> > This feature not enabled by default, so PMON_CONFIG needs to enable it.
> > 
> > v4:
> > Reported-by: kernel test robot <lkp@intel.com>
> > ---
> > changes in conditional check to enable vout & temp1 by default.
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
> Applied (and I fixed the problem reported by 0-day, so no need to resend).
>                  Thank you  Guenter. 
> Thanks,
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
> > +		if (config & (ADM1278_VOUT_EN | ADM1278_TEMP1_EN) != ADM1278_VOUT_EN | ADM1278_TEMP1_EN) {
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
