Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0253C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 18:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7683A20785
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 18:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584555727;
	bh=0kLp7bEp/11sPwr/wXBGJSmj+PYzD+oXI6sOmSm+LUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IQi1V7cRamgLzHH19BIw737p8tmt+Dm+onpGauaBqS/oVx0w21ikFTjoHpQ4Qf/gJ
	 dlJ6IxWvJfuZlv5MWt3YgsynQdwgyeCObGZEd+nAgX3A0xlzuqETdb7CDlN2hRaau/
	 ukva7WYjo/IH//k3dIKC1d4DGnXFa0ZwQec3mdVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgCRSWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 14:22:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbgCRSWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 14:22:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0338A2077E;
        Wed, 18 Mar 2020 18:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584555723;
        bh=0kLp7bEp/11sPwr/wXBGJSmj+PYzD+oXI6sOmSm+LUc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0Oa48EjSeTb/K5rRf47bm8c63ncn/iBXJ5ghH8MWC2/UNVxAosBp0kw0dVM1CYBIY
         e5a068X1hqTCQ0rSF8NyfLuIEEVOjeO5jyLfqz9jWDJLak242HHegusdlKcUPV6dsR
         guYzBqrLDcR7f/OuR7ZZB99Wm71AhkGClZLchqxo=
Date:   Wed, 18 Mar 2020 19:22:01 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] coresight: cti: Add sysfs coresight mgmt register
 access
Message-ID: <20200318182201.GA3235688@kroah.com>
References: <20200309161748.31975-1-mathieu.poirier@linaro.org>
 <20200309161748.31975-3-mathieu.poirier@linaro.org>
 <20200318131821.GA2789508@kroah.com>
 <20200318181604.GB18359@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318181604.GB18359@xps15>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 12:16:04PM -0600, Mathieu Poirier wrote:
> On Wed, Mar 18, 2020 at 02:18:21PM +0100, Greg KH wrote:
> > On Mon, Mar 09, 2020 at 10:17:37AM -0600, Mathieu Poirier wrote:
> > > From: Mike Leach <mike.leach@linaro.org>
> > > 
> > > Adds sysfs access to the coresight management registers.
> > > 
> > > Signed-off-by: Mike Leach <mike.leach@linaro.org>
> > > Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > [Fixed abbreviation in title]
> > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > ---
> > >  .../hwtracing/coresight/coresight-cti-sysfs.c | 53 +++++++++++++++++++
> > >  drivers/hwtracing/coresight/coresight-priv.h  |  1 +
> > >  2 files changed, 54 insertions(+)
> > > 
> > > diff --git a/drivers/hwtracing/coresight/coresight-cti-sysfs.c b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> > > index a832b8c6b866..507f8eb487fe 100644
> > > --- a/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> > > +++ b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> > > @@ -62,11 +62,64 @@ static struct attribute *coresight_cti_attrs[] = {
> > >  	NULL,
> > >  };
> > >  
> > > +/* register based attributes */
> > > +
> > > +/* macro to access RO registers with power check only (no enable check). */
> > > +#define coresight_cti_reg(name, offset)			\
> > > +static ssize_t name##_show(struct device *dev,				\
> > > +			   struct device_attribute *attr, char *buf)	\
> > > +{									\
> > > +	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);	\
> > > +	u32 val = 0;							\
> > > +	pm_runtime_get_sync(dev->parent);				\
> > > +	spin_lock(&drvdata->spinlock);					\
> > > +	if (drvdata->config.hw_powered)					\
> > > +		val = readl_relaxed(drvdata->base + offset);		\
> > > +	spin_unlock(&drvdata->spinlock);				\
> > > +	pm_runtime_put_sync(dev->parent);				\
> > > +	return scnprintf(buf, PAGE_SIZE, "0x%x\n", val);		\
> > > +}									\
> > > +static DEVICE_ATTR_RO(name)
> > > +
> > > +/* coresight management registers */
> > > +coresight_cti_reg(devaff0, CTIDEVAFF0);
> > > +coresight_cti_reg(devaff1, CTIDEVAFF1);
> > > +coresight_cti_reg(authstatus, CORESIGHT_AUTHSTATUS);
> > > +coresight_cti_reg(devarch, CORESIGHT_DEVARCH);
> > > +coresight_cti_reg(devid, CORESIGHT_DEVID);
> > > +coresight_cti_reg(devtype, CORESIGHT_DEVTYPE);
> > > +coresight_cti_reg(pidr0, CORESIGHT_PERIPHIDR0);
> > > +coresight_cti_reg(pidr1, CORESIGHT_PERIPHIDR1);
> > > +coresight_cti_reg(pidr2, CORESIGHT_PERIPHIDR2);
> > > +coresight_cti_reg(pidr3, CORESIGHT_PERIPHIDR3);
> > > +coresight_cti_reg(pidr4, CORESIGHT_PERIPHIDR4);
> > > +
> > > +static struct attribute *coresight_cti_mgmt_attrs[] = {
> > > +	&dev_attr_devaff0.attr,
> > > +	&dev_attr_devaff1.attr,
> > > +	&dev_attr_authstatus.attr,
> > > +	&dev_attr_devarch.attr,
> > > +	&dev_attr_devid.attr,
> > > +	&dev_attr_devtype.attr,
> > > +	&dev_attr_pidr0.attr,
> > > +	&dev_attr_pidr1.attr,
> > > +	&dev_attr_pidr2.attr,
> > > +	&dev_attr_pidr3.attr,
> > > +	&dev_attr_pidr4.attr,
> > > +	NULL,
> > > +};
> > > +
> > >  static const struct attribute_group coresight_cti_group = {
> > >  	.attrs = coresight_cti_attrs,
> > >  };
> > >  
> > > +static const struct attribute_group coresight_cti_mgmt_group = {
> > > +	.attrs = coresight_cti_mgmt_attrs,
> > > +	.name = "mgmt",
> > > +};
> > > +
> > >  const struct attribute_group *coresight_cti_groups[] = {
> > >  	&coresight_cti_group,
> > > +	&coresight_cti_mgmt_group,
> > >  	NULL,
> > >  };
> > > diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> > > index 82e563cdc879..aba6b789c969 100644
> > > --- a/drivers/hwtracing/coresight/coresight-priv.h
> > > +++ b/drivers/hwtracing/coresight/coresight-priv.h
> > > @@ -22,6 +22,7 @@
> > >  #define CORESIGHT_CLAIMCLR	0xfa4
> > >  #define CORESIGHT_LAR		0xfb0
> > >  #define CORESIGHT_LSR		0xfb4
> > > +#define CORESIGHT_DEVARCH	0xfbc
> > >  #define CORESIGHT_AUTHSTATUS	0xfb8
> > >  #define CORESIGHT_DEVID		0xfc8
> > >  #define CORESIGHT_DEVTYPE	0xfcc
> > > -- 
> > > 2.20.1
> > > 
> > 
> > I do not see any Documentation/ABI/ entries for these new sysfs files,
> > did I miss it somehow?  I can't take new sysfs code without
> > documentation.
> 
> All the ABI is documented in this patch, which is part of this set.
> 
> [1]. https://lkml.org/lkml/2020/3/9/642

That is not in the required Documentation/ABI/ form that all sysfs files
should have.  If they don't, it's a bug.

Please use that format and do not make up your own, we already have
tools that parse these files.

thanks,

greg k-h
