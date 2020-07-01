Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA098C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1CCE20722
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M5xx14Cv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgGAHEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbgGAHEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 03:04:38 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C6DC061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 00:04:38 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z13so22641013wrw.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 00:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=e12F1suikdS3lGtBuyJAayumJr4O2+9e5bqVwPL0o7M=;
        b=M5xx14CvYq83HbV1b8rfXttQ1GPSnY1Tk0KdGpXG8pGlUAlrg0sWDEnk8bzKkJ6r6k
         2Aa0XA3apmz6vDJQ0V5lUPceHC4c95rjbZ0M/T1M/vH/i0zfizzW71uUJr+IuzrwnQru
         9kTAGNbQv3W1fYpXuQhR+qoNUkjPUQnu2c/R1I+MTqIlj2BJoKllFFzmemkMhkrlTlo+
         yiv1jOcJwAo7xFKUnGiVXrK0m4pTQpddkUlVJcbN5jtVBKnBeLEE62nGdLe64NtdU2hP
         6P7VnvWOXc23r0ZP3HU6wwfGlrc8BLrfA2YlVx4xaX6aBozq60qV4YXQi72OtSGVKYUT
         Y6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=e12F1suikdS3lGtBuyJAayumJr4O2+9e5bqVwPL0o7M=;
        b=YsUJbAhLy6YrfkSlccz3esrrRWFvj8RLxQkW9WfsQ+u1cvbz342J4lAo0si0C7KFYE
         s3pwQubh4zODmeKNRx+jUIBdUtKMB9dgSwq+dTYxI+pJ6/M3tgrv1omFE1JSfLyv985Q
         49r9VUIxv68vYNhQGCq87SChYejT/210EqB+pcT9nt/bQjSDq4lKaMbML07IsNPtpSgQ
         H22ESfKJH1L4u7rYEzZ6oKb3XzxAzr1+emPto8O++WV+mcmyUbFSkMOC+OG/PBTx78BU
         zVwPNuhgCMhNvO/Nrng+6bwDYpq/RopS4hmZM1jOJ6+9713XPEq8n2mt9HbzNKFRxmFt
         qC0w==
X-Gm-Message-State: AOAM530nPnrNWKcz+3BmDXhXhoPQa0VsVgQM1jv/dOOsOWA6QqgBKWVi
        R6ywZNywimPbkcWhPcoAevrPTQ==
X-Google-Smtp-Source: ABdhPJyZ0zCqVJ4yCEcYTanPmJiMHwO+RzvGh5qS/YdgNhZ3s59Ce3qt5dt+K7Lrub9MMzWPYdgvBA==
X-Received: by 2002:a5d:66ca:: with SMTP id k10mr14794987wrw.244.1593587077069;
        Wed, 01 Jul 2020 00:04:37 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id l18sm6294142wrm.52.2020.07.01.00.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 00:04:36 -0700 (PDT)
Date:   Wed, 1 Jul 2020 08:04:34 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Michael Walle <michael@walle.cc>
Cc:     robh+dt@kernel.org, broonie@kernel.org, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] mfd: Add I2C based System Configuaration (SYSCON)
 access
Message-ID: <20200701070434.GP1179328@dell>
References: <20200622075145.1464020-1-lee.jones@linaro.org>
 <e436fd60bf0ebb6d72a76034d0fc35de@walle.cc>
 <f505c52d565ba7dbf05eef895782c410@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f505c52d565ba7dbf05eef895782c410@walle.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Jul 2020, Michael Walle wrote:

> Hi Lee,
> 
> Am 2020-06-30 11:16, schrieb Michael Walle:
> > I'm just trying to use this for my sl28 driver. Some remarks, see below.
> > 
> > Am 2020-06-22 09:51, schrieb Lee Jones:
> > > The existing SYSCON implementation only supports MMIO (memory mapped)
> > > accesses, facilitated by Regmap.  This extends support for registers
> > > held behind I2C busses.
> > > 
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > > Changelog:
> > > 
> > > v3 => v4
> > >   - Add ability to provide a non-default Regmap configuration
> > > 
> > > v2 => v3
> > >   - Change 'is CONFIG' present check to include loadable modules
> > >     - s/#ifdef CONFIG_MFD_SYSCON_I2C/#if
> > > IS_ENABLED(CONFIG_MFD_SYSCON_I2C)/
> > > 
> > > v1 => v2
> > >   - Remove legacy references to OF
> > >   - Allow building as a module (fixes h8300 0-day issue)
> > > 
> > > drivers/mfd/Kconfig            |   7 +++
> > >  drivers/mfd/Makefile           |   1 +
> > >  drivers/mfd/syscon-i2c.c       | 104
> > > +++++++++++++++++++++++++++++++++
> > >  include/linux/mfd/syscon-i2c.h |  36 ++++++++++++
> > >  4 files changed, 148 insertions(+)
> > >  create mode 100644 drivers/mfd/syscon-i2c.c
> > >  create mode 100644 include/linux/mfd/syscon-i2c.h
> > > 
> > 
> > [..]
> > 
> > > +static struct regmap *syscon_i2c_get_regmap(struct i2c_client
> > > *client,
> > > +					    struct regmap_config *regmap_config)
> > > +{
> > > +	struct device *dev = &client->dev;
> > > +	struct syscon *entry, *syscon = NULL;
> > > +
> > > +	spin_lock(&syscon_i2c_list_slock);
> > > +
> > > +	list_for_each_entry(entry, &syscon_i2c_list, list)
> > > +		if (entry->dev == dev) {
> > > +			syscon = entry;
> > > +			break;
> > > +		}
> > > +
> > > +	spin_unlock(&syscon_i2c_list_slock);
> > > +
> > > +	if (!syscon)
> > > +		syscon = syscon_i2c_register(client, regmap_config);
> > > +
> > > +	if (IS_ERR(syscon))
> > > +		return ERR_CAST(syscon);
> > > +
> > > +	return syscon->regmap;
> > > +}
> > > +
> > > +struct regmap *syscon_i2c_to_regmap_config(struct i2c_client *client,
> > > +					   struct regmap_config *regmap_config)
> > > +{
> > > +	return syscon_i2c_get_regmap(client, regmap_config);
> > > +}
> > > +EXPORT_SYMBOL_GPL(syscon_i2c_to_regmap_config);
> > > +
> > > +struct regmap *syscon_i2c_to_regmap(struct i2c_client *client)
> > > +{
> > > +	return syscon_i2c_get_regmap(client, &syscon_i2c_regmap_config);
> > > +}
> > > +EXPORT_SYMBOL_GPL(syscon_i2c_to_regmap);
> > 
> > What do you think about
> > 
> > struct regmap *syscon_i2c_to_regmap(struct device *dev)
> > {
> > 	struct i2c_client *client = i2c_verify_client(dev);
> > 
> > 	if (!client)
> > 		return ERR_PTR(-EINVAL);
> > 
> > 	return syscon_i2c_get_regmap(client, &syscon_i2c_regmap_config);
> > }
> > 
> > Or even move it to syscon_i2c_get_regmap().
> > 
> > This way, (a) a driver doesn't have to use "#include <linux/i2c.h>" just
> > to call to_i2c_client() (or i2c_verify_client()) and (b) you won't do it
> > all over again in all sub drivers.
> > 
> > So you could just do a
> >   regmap = syscon_i2c_to_regmap(pdev->dev.parent);
> > 
> > I've also noticed that the mmio syscon uses device_node as parameter.
> > What
> > was the reason to divert from that? Just curious.
> 
> How is this supposed to be used?
> 
> I had something like the following in mind:
> 
> &i2c {
>   cpld@4a {
>     compatible = "simple-mfd";
>     reg = <0x4a>;
> 
>     gpio@4 {
>       compatible = "vendor,gpio";
>       reg = <0x4>;
>     };
>   };
> };

Yes, that was the idea.

> But I think the childen are not enumerated if its an I2C device. And
> the actual i2c driver is also missing.

What do you mean?  Can you elaborate?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
