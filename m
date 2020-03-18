Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3268C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 18:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A23205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 18:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RVavPlmF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgCRSQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 14:16:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40734 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgCRSQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 14:16:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id t24so14127078pgj.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 11:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=beSLS6KccZJfpFDT+vWQCRVFQjr+hT/1HsXon9oZNTs=;
        b=RVavPlmFJAX48SFQzNLnKS+jECaKmjSq7wGgWa8Ru8DEDo5L22eJZ3SsFAdzOXi4uF
         W3b1RjMZL2JpNF3Iz6sq3fkBTEX/feqaT+0EoTCEIYKH7F0lMBgIWHfZnfu3ZW+tVxXI
         Jcwj0NTvYpwymWWlYNV3JhlJGb08KA57XXb8dNrNlHuIev/+CC1zB2v9nRBmyynmknEk
         R6/MaSIhLFJ/OSQ2t4SX4Rd8KHGnO+qFGi9Yan0RKhoed7gn5ySHSZcm+gWiqXaxSwou
         jYLmiRN+yl6hXjkJuMy32YvZCKFWyBdamTyaqDbP6Rw2GEjoK/LtbGWmptXXlhGUkU6a
         ZItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=beSLS6KccZJfpFDT+vWQCRVFQjr+hT/1HsXon9oZNTs=;
        b=l4VIrHRUjL/OoOnLgzHc+g85Qsr3rXvRMoZDRF1fPm1H7V06iLkpT6NdTRPngbSRhu
         AUUzG3rJkE1eiEC9ODhbmC9OO71koLbZH8GhwCKkqAJBipw2r+UeYZozXfyzvqDdU6xM
         H7xXcMMzS7AFMpNunwh04dOv+Gc3CeCWa3Wh61nWMLyRxg0+0fO4GlyFIQQu0ktbwoh7
         /og0dRIBMkax+hDw9I2Q+z8e9FrL7rNwZKybioBwnNk0wNbWls/n7CtE445tWH4zijfG
         nBxW7NKYKtKXrrTEKlTkUFCA0kok2r8Cf/HxglesC/uhIbj7K2CRml+EfIUt1PtjAHTv
         t4mg==
X-Gm-Message-State: ANhLgQ1D8Qac3ZiYUjPYH3hUH65ahIXWju1t3cHLW+KUtE4CNRGUQjV6
        rgNtdqFMTiH7pN5n948BMR5eKg==
X-Google-Smtp-Source: ADFU+vv8IeOP/LyfBQhw2wQmADS7FfUPmRtzju2D7BaVZTBpLR8uOdRRfL9uR8sWmmwTdxwkgaeMmQ==
X-Received: by 2002:a63:441e:: with SMTP id r30mr5780514pga.51.1584555366722;
        Wed, 18 Mar 2020 11:16:06 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id z20sm6739589pge.62.2020.03.18.11.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 11:16:06 -0700 (PDT)
Date:   Wed, 18 Mar 2020 12:16:04 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] coresight: cti: Add sysfs coresight mgmt register
 access
Message-ID: <20200318181604.GB18359@xps15>
References: <20200309161748.31975-1-mathieu.poirier@linaro.org>
 <20200309161748.31975-3-mathieu.poirier@linaro.org>
 <20200318131821.GA2789508@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318131821.GA2789508@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 02:18:21PM +0100, Greg KH wrote:
> On Mon, Mar 09, 2020 at 10:17:37AM -0600, Mathieu Poirier wrote:
> > From: Mike Leach <mike.leach@linaro.org>
> > 
> > Adds sysfs access to the coresight management registers.
> > 
> > Signed-off-by: Mike Leach <mike.leach@linaro.org>
> > Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > [Fixed abbreviation in title]
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >  .../hwtracing/coresight/coresight-cti-sysfs.c | 53 +++++++++++++++++++
> >  drivers/hwtracing/coresight/coresight-priv.h  |  1 +
> >  2 files changed, 54 insertions(+)
> > 
> > diff --git a/drivers/hwtracing/coresight/coresight-cti-sysfs.c b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> > index a832b8c6b866..507f8eb487fe 100644
> > --- a/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> > +++ b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> > @@ -62,11 +62,64 @@ static struct attribute *coresight_cti_attrs[] = {
> >  	NULL,
> >  };
> >  
> > +/* register based attributes */
> > +
> > +/* macro to access RO registers with power check only (no enable check). */
> > +#define coresight_cti_reg(name, offset)			\
> > +static ssize_t name##_show(struct device *dev,				\
> > +			   struct device_attribute *attr, char *buf)	\
> > +{									\
> > +	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);	\
> > +	u32 val = 0;							\
> > +	pm_runtime_get_sync(dev->parent);				\
> > +	spin_lock(&drvdata->spinlock);					\
> > +	if (drvdata->config.hw_powered)					\
> > +		val = readl_relaxed(drvdata->base + offset);		\
> > +	spin_unlock(&drvdata->spinlock);				\
> > +	pm_runtime_put_sync(dev->parent);				\
> > +	return scnprintf(buf, PAGE_SIZE, "0x%x\n", val);		\
> > +}									\
> > +static DEVICE_ATTR_RO(name)
> > +
> > +/* coresight management registers */
> > +coresight_cti_reg(devaff0, CTIDEVAFF0);
> > +coresight_cti_reg(devaff1, CTIDEVAFF1);
> > +coresight_cti_reg(authstatus, CORESIGHT_AUTHSTATUS);
> > +coresight_cti_reg(devarch, CORESIGHT_DEVARCH);
> > +coresight_cti_reg(devid, CORESIGHT_DEVID);
> > +coresight_cti_reg(devtype, CORESIGHT_DEVTYPE);
> > +coresight_cti_reg(pidr0, CORESIGHT_PERIPHIDR0);
> > +coresight_cti_reg(pidr1, CORESIGHT_PERIPHIDR1);
> > +coresight_cti_reg(pidr2, CORESIGHT_PERIPHIDR2);
> > +coresight_cti_reg(pidr3, CORESIGHT_PERIPHIDR3);
> > +coresight_cti_reg(pidr4, CORESIGHT_PERIPHIDR4);
> > +
> > +static struct attribute *coresight_cti_mgmt_attrs[] = {
> > +	&dev_attr_devaff0.attr,
> > +	&dev_attr_devaff1.attr,
> > +	&dev_attr_authstatus.attr,
> > +	&dev_attr_devarch.attr,
> > +	&dev_attr_devid.attr,
> > +	&dev_attr_devtype.attr,
> > +	&dev_attr_pidr0.attr,
> > +	&dev_attr_pidr1.attr,
> > +	&dev_attr_pidr2.attr,
> > +	&dev_attr_pidr3.attr,
> > +	&dev_attr_pidr4.attr,
> > +	NULL,
> > +};
> > +
> >  static const struct attribute_group coresight_cti_group = {
> >  	.attrs = coresight_cti_attrs,
> >  };
> >  
> > +static const struct attribute_group coresight_cti_mgmt_group = {
> > +	.attrs = coresight_cti_mgmt_attrs,
> > +	.name = "mgmt",
> > +};
> > +
> >  const struct attribute_group *coresight_cti_groups[] = {
> >  	&coresight_cti_group,
> > +	&coresight_cti_mgmt_group,
> >  	NULL,
> >  };
> > diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> > index 82e563cdc879..aba6b789c969 100644
> > --- a/drivers/hwtracing/coresight/coresight-priv.h
> > +++ b/drivers/hwtracing/coresight/coresight-priv.h
> > @@ -22,6 +22,7 @@
> >  #define CORESIGHT_CLAIMCLR	0xfa4
> >  #define CORESIGHT_LAR		0xfb0
> >  #define CORESIGHT_LSR		0xfb4
> > +#define CORESIGHT_DEVARCH	0xfbc
> >  #define CORESIGHT_AUTHSTATUS	0xfb8
> >  #define CORESIGHT_DEVID		0xfc8
> >  #define CORESIGHT_DEVTYPE	0xfcc
> > -- 
> > 2.20.1
> > 
> 
> I do not see any Documentation/ABI/ entries for these new sysfs files,
> did I miss it somehow?  I can't take new sysfs code without
> documentation.

All the ABI is documented in this patch, which is part of this set.

[1]. https://lkml.org/lkml/2020/3/9/642

Thanks,
Mathieu

> 
> thanks,
> 
> greg k-h
