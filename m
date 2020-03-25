Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68673C54FCF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 07:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3260220714
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 07:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585121821;
	bh=KFHVOj3TQ5nDXf7jm3X9jRhbM3EIINnqrMU+w1cIYWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iODN8lnFIZuWzKADLLooNuBCT+Wk12qQlpVIA35NDw9l1JcJOz6tNMXuLOACqir8U
	 3g/kzdtjhvj2izHoUF6vrnr5jTR/W2agS6cPNwOSJLISJ6/Ul9lyQ4vLsTSyRN+DhH
	 bIQell0Sz+IayvNPf4l/3Xu6y4hwZ+m8H1SVdjFc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgCYHhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 03:37:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:38290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgCYHg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 03:36:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A40C92051A;
        Wed, 25 Mar 2020 07:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585121819;
        bh=KFHVOj3TQ5nDXf7jm3X9jRhbM3EIINnqrMU+w1cIYWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IJ+K28CjFmrvTBzuky+gQfJF0tQggxOXPEJMqNUKLjJbWhzrbs8dwWIzNyYea1DHX
         Pf+epF0xPc+FuR+54ReOUHR/iAl0axw7tj6Jff2j41yeYeQg3rWZRuneLBAYkDggSk
         kdGbwzCWMer9pO9io56ay18RBTA70s6Kyh37w+K4=
Date:   Wed, 25 Mar 2020 08:36:56 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] nvmem: core: use is_bin_visible for permissions
Message-ID: <20200325073656.GA2985010@kroah.com>
References: <20200324171600.15606-1-srinivas.kandagatla@linaro.org>
 <20200324171600.15606-4-srinivas.kandagatla@linaro.org>
 <PSXP216MB04380BBC9B7488DEC47ACB6A80F10@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSXP216MB04380BBC9B7488DEC47ACB6A80F10@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 11:05:07PM +0000, Nicholas Johnson wrote:
> On Tue, Mar 24, 2020 at 05:16:00PM +0000, Srinivas Kandagatla wrote:
> > By using is_bin_visible callback to set permissions will remove a large list
> > of attribute groups. These group permissions can be dynamically derived in
> > the callback.
> > 
> > Suggested-by: Greg KH <gregkh@linuxfoundation.org>
> > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > ---
> >  drivers/nvmem/nvmem-sysfs.c | 74 +++++++++----------------------------
> >  1 file changed, 18 insertions(+), 56 deletions(-)
> > 
> > diff --git a/drivers/nvmem/nvmem-sysfs.c b/drivers/nvmem/nvmem-sysfs.c
> > index 8759c4470012..1ff1801048f6 100644
> > --- a/drivers/nvmem/nvmem-sysfs.c
> > +++ b/drivers/nvmem/nvmem-sysfs.c
> > @@ -103,6 +103,17 @@ static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
> >  
> >  	return count;
> >  }
> > +static umode_t nvmem_bin_attr_is_visible(struct kobject *kobj,
> > +					 struct bin_attribute *attr, int i)
> > +{
> > +	struct device *dev = container_of(kobj, struct device, kobj);
> > +	struct nvmem_device *nvmem = to_nvmem_device(dev);
> > +
> > +	if (nvmem->root_only)
> > +		return nvmem->read_only ? 0400 : 0600;
> > +
> > +	return nvmem->read_only ? 0444 : 0644;
> > +}
> Looks like I did a pretty good job as I arrived at a similar result 
> independently. Even added root_only to nvmem_device. You beat me to it. 
> :)
> 
> >  const struct attribute_group **nvmem_sysfs_get_groups(
> >  					struct nvmem_device *nvmem,
> >  					const struct nvmem_config *config)
> >  {
> > -	if (config->root_only)
> > -		return nvmem->read_only ?
> > -			nvmem_ro_root_dev_groups :
> > -			nvmem_rw_root_dev_groups;
> > -
> > -	return nvmem->read_only ? nvmem_ro_dev_groups : nvmem_rw_dev_groups;
> > +	return nvmem_dev_groups;
> >  }
> I was wondering if we can export nvmem_dev_group instead of this 
> nvmem_sysfs_get_groups() to fetch it.
> 
> Also, we need some logic in nvmem_register() to abort if bad combination 
> is given (i.e. root_only set but no reg_read), as returning 0 in 
> is_bin_visible callback does not abort. I can do that in my patch if you 
> want.

Returning 0 will cause the file to not be created at all, which is
probably what you want, right?

thanks,

greg k-h
