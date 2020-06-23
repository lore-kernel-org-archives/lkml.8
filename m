Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4C0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B6CE20780
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Djp5eFF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732305AbgFWQE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 12:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728472AbgFWQE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:04:59 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130C2C061573;
        Tue, 23 Jun 2020 09:04:59 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id u8so1651847pje.4;
        Tue, 23 Jun 2020 09:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=do86B9M5tGDDUUM7bCWck23OCEcGEf6z7sPQe5ReWXM=;
        b=Djp5eFF2KkXJL5N4FbrLUF77gAhDcV09R7NzL5ZiUZr7l493GiFUA9Jc9AJumWB0JL
         ob3ddMttwYvBHNdejMqGHn4zkWNutODfSMB1EYsuy7gK0ctmTFc2MucxUSEHeAx0FXRo
         Kc1JsWyaBntbk3noEF/ZwfLnuWgOuxuAjUAJ3u2kdl9BDCczgLdYM1cAMaf1mGZVTDJR
         1AZ/IpnFSy2MIaiM9hm44WqPnMmLUBPcaxrGp/M09wKoBVJ70nzZx3c9GzJPM6aiFMBt
         2uKdTE+BtxVANIedKeQAVxL8ZgHHg5iw/HM72G98bbBmF0Oas6EoWDZUEfPaByY66sGa
         waeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=do86B9M5tGDDUUM7bCWck23OCEcGEf6z7sPQe5ReWXM=;
        b=SmGsIAvL9puj6f0otNmKbCB5YVO2b0VJBt4BJ+uN0iq1uJOPvvo4hb3cSmlHYv8N/C
         jwyOdMs7ufcqVId7AimAedh6AZBzoU8gx0EbdQ34r3e/3YfjWRUHpeXpxK1OHO5svlkc
         a5uM3uxvA+E6ao+6LAzek5Bp+eZb9oBvnx2cUpX63vLPzkrtmzf1x9uX3wxjZLugbyGw
         gtFGwtDQBbDLJAs147qRsbhP+nVVriTFekC6Qg9Q77+Apd24G9uw0AJW4lMzht9o9JFY
         cC4syvrG/pCK3CS41Hn20Te5bpHQnNmF9KrJbyM73Xok4KeaeB1duXPU/ImHiOr2PyF4
         8PLg==
X-Gm-Message-State: AOAM530byh2ur0PbYXaT5lsoAHcbLApePQTxWQ2SO5nra2o/ygcFQC7/
        oGvOjYbgLyDokNzgytjZ2ZU=
X-Google-Smtp-Source: ABdhPJyYsFWWdMFAKz+pYWcsYlvkUt6KuY+lCjjy9egaWFdNP/Yb85qwbsEGoOOjI/3ToguBhuO5zQ==
X-Received: by 2002:a17:902:326:: with SMTP id 35mr24612675pld.301.1592928297950;
        Tue, 23 Jun 2020 09:04:57 -0700 (PDT)
Received: from cnn ([112.133.236.83])
        by smtp.gmail.com with ESMTPSA id 25sm17287060pfi.7.2020.06.23.09.04.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jun 2020 09:04:54 -0700 (PDT)
Date:   Tue, 23 Jun 2020 21:34:44 +0530
From:   Manikandan <manikandan.hcl.ers.epl@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     miltonm@us.ibm.com, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        saipsdasari@fb.com, patrickw3@fb.com, vijaykhemka@fb.com,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        manikandan.e@hcl.com
Subject: Re: [PATCH v6] hwmon:(adm1275) Enable adm1278 ADM1278_TEMP1_EN
Message-ID: <20200623160444.GA8945@cnn>
References: <20200622153727.GA9347@cnn>
 <20200623140711.GA208792@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623140711.GA208792@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 07:07:11AM -0700, Guenter Roeck wrote:
> On Mon, Jun 22, 2020 at 09:07:27PM +0530, Manikandan Elumalai wrote:
> > The adm1278 temp attribute need it for openbmc platform .
> > This feature not enabled by default, so PMON_CONFIG needs to enable it.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
> 
> Applied.

    Thanks Guenter.
> 
> Thanks,
> Guenter
> 
> > ---
> > v5 -> v6: 
> > add Reported-by in commit log
> > align commit and change log as per guidelines.
> > v4 -> v5: 
> > align commit and change log. 
> > v3 -> v4: 
> > kernel test robot CI warning
> > v2 -> v3: 
> > fix invalid signed-off.
> > removed checkpath warnings.
> > write ADM1278_TEMP1_EN and ADM1278_VOUT_EN conf in single line operation.
> > v1 -> v2: 
> > add Signed-off-by.
> > removed ADM1278_TEMP1_EN check.
> > 
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
