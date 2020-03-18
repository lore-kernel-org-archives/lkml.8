Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94E6C10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 18:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD6B20786
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 18:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BObFkvuX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgCRSMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 14:12:30 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36308 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgCRSMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 14:12:30 -0400
Received: by mail-pl1-f196.google.com with SMTP id g2so9018058plo.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 11:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zc8e3F8aKkBkRLdoAfVahNzmIGP0Ifmt+x4WYR/4FYM=;
        b=BObFkvuXsZYKRTRUbcRxLWak56/FypliNA3RcCnJZGuLpFy7wrc97kUlPk8udUALq5
         ZOYtgVkpYBDvDarRT3+FMgPCglUiXPsYjZtGOhzZzsYX/LlVuX1h97lnwbkG55qCK8lV
         U8+1fQfJc7z1TIGqiodgPp7iSkx6BmiPES27QQI4x/djQIWMyRCTVFKzhzCmuV+PphhK
         aIlVxjKhWvkH0+ChqOJns2kU72sic0br8Ga1+CkqjU4dus13vMflTqFPM7SAkqx7mq4t
         AMjmFJPgRlolN1QsEbM88PVQc0aR0PzoLpHH0d02KHKuTQhULsYr6VBLKokxYGqDtPt0
         L+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zc8e3F8aKkBkRLdoAfVahNzmIGP0Ifmt+x4WYR/4FYM=;
        b=tA06ODKZq3NmTreAKe7X/c1OQODBPmm4wB7DcoC5AWeIGlOCEVK3TnFVxORNvh9ufq
         lMJbAV4dr2JSM5KGXrnWHKfkR+qy2A/d/oaHrPHNMVljF1KYgCB/1jqErtGIGQKVXtn3
         YmfqmsL+FSqexRHYcURlmIW0kAx77lf6xgQkIYf25UW8oqgtOq95SYMd9Afk1lX739zA
         qk/G7DVYN8lgFyUJ/KZAn+b1XFbr651xsUdacvs5Hu5eMDq6QWaolw4a6NvGT/ZNAhvc
         YOdB3+Aafa31uAdYujfJYDCZ99KIgtwREV4FB4+iHMwWynW0whUdD1VKIv7+RCgzJaRc
         Z+DQ==
X-Gm-Message-State: ANhLgQ1EdnrzPQuL3n9B3UDOrf02vyuAadunYJoKTbRvKA+0lcET6uOk
        YMBRcTJ+eZIlBIFVLwCZLhqoPQ==
X-Google-Smtp-Source: ADFU+vt8AD++aXB0Ov1yHrk0wa9HmjHpKTx8yRP3M/CqVhHzh56BmyAHhnXrt3wlKilZBDmbsDWzwg==
X-Received: by 2002:a17:90b:1987:: with SMTP id mv7mr5782683pjb.148.1584555148726;
        Wed, 18 Mar 2020 11:12:28 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id q43sm3115219pjc.40.2020.03.18.11.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 11:12:27 -0700 (PDT)
Date:   Wed, 18 Mar 2020 12:12:26 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] coresight: cti: Initial CoreSight CTI Driver
Message-ID: <20200318181226.GA18359@xps15>
References: <20200309161748.31975-1-mathieu.poirier@linaro.org>
 <20200309161748.31975-2-mathieu.poirier@linaro.org>
 <20200318132241.GB2789508@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318132241.GB2789508@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 02:22:41PM +0100, Greg KH wrote:
> On Mon, Mar 09, 2020 at 10:17:36AM -0600, Mathieu Poirier wrote:
> > From: Mike Leach <mike.leach@linaro.org>
> > 
> > This introduces a baseline CTI driver and associated configuration files.
> > 
> > Uses the platform agnostic naming standard for CoreSight devices, along
> > with a generic platform probing method that currently supports device
> > tree descriptions, but allows for the ACPI bindings to be added once these
> > have been defined for the CTI devices.
> > 
> > Driver will probe for the device on the AMBA bus, and load the CTI driver
> > on CoreSight ID match to CTI IDs in tables.
> > 
> > Initial sysfs support for enable / disable provided.
> > 
> > Default CTI interconnection data is generated based on hardware
> > register signal counts, with no additional connection information.
> > 
> > Signed-off-by: Mike Leach <mike.leach@linaro.org>
> > Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> You didn't cc: all of them to get review comments?  I've added it
> above...

Thanks

> 
> And signed-off-by implies reviewed-by.

This set has been refined over several iterations.  I added my R-b to patches
that I had reviewed and did not need attentions anymore.  Since this is supposed
to be a chain of custody I decided to keep my R-b and append my S-b before
queueing in my tree.  I have seen this done many times before but will remove if
you think it is better.

> 
> > +/* basic attributes */
> > +static ssize_t enable_show(struct device *dev,
> > +			   struct device_attribute *attr,
> > +			   char *buf)
> > +{
> > +	int enable_req;
> > +	bool enabled, powered;
> > +	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > +	ssize_t size = 0;
> > +
> > +	enable_req = atomic_read(&drvdata->config.enable_req_count);
> > +	spin_lock(&drvdata->spinlock);
> > +	powered = drvdata->config.hw_powered;
> > +	enabled = drvdata->config.hw_enabled;
> > +	spin_unlock(&drvdata->spinlock);
> > +
> > +	if (powered) {
> > +		size = scnprintf(buf, PAGE_SIZE, "cti %s; powered;\n",
> > +				 enabled ? "enabled" : "disabled");
> > +	} else {
> > +		size = scnprintf(buf, PAGE_SIZE, "cti %s; unpowered;\n",
> > +				 enable_req ? "enable req" : "disabled");
> 
> sysfs files should never need scnprintf() as you "know" a single value
> will fit into a PAGE_SIZE.

I've seen many patches using scnprintf() that were merged.  We can change this
to sprintf().

> 
> And shouldn't this just be a single value, this looks like it is 2
> values in one line, that then needs to be parsed, is that to be
> expected?

There is no shortage of files under /sys/device/ with output that needs parsing,
but this can be split in two entries.

> 
> Where is the documentation for this new sysfs file?

All the documentation for sysfs files are lumped together in a single patch [1]
that is also part of this set.

[1]. https://lkml.org/lkml/2020/3/9/643

> 
> > +const struct attribute_group *coresight_cti_groups[] = {
> > +	&coresight_cti_group,
> > +	NULL,
> > +};
> 
> ATTRIBUTE_GROUPS()?

As with all the other coresight devices, groups are communicated to
coresight_register() and added to the csdev->dev in that function.

> 
> > +static struct amba_driver cti_driver = {
> > +	.drv = {
> > +		.name	= "coresight-cti",
> > +		.owner = THIS_MODULE,
> 
> Aren't amba drivers smart enough to set this properly on their own?
> {sigh}

Would you mind indicating where?  builtin_amba_driver() calls
amba_driver_register() and  that doesn't set the owner field.

Thanks,
Mathieu

> 
> greg k-h
