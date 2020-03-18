Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A25C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 13:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E171C2076F
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 13:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584537808;
	bh=MS122+MI8HvaX7QgTFw/2hADw9MT/NgSAmlg4rviq4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mhwUkCHETlLTOgQQEPywLLliRXErkj5SCbcXh2dos1ZMrI5a2xzK7gEkjv6TZAenA
	 cQiIU6MgSnddHmKy4+og9rdwaMegV0CDXycFGO8QjjbbNUmuORG/rDTKqZDhgs3Iy0
	 cFMcxE9+l0Kz9Sj8DAdW/i9SsN97HmBOTGP6DQ0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgCRNX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 09:23:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbgCRNX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 09:23:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58F372076F;
        Wed, 18 Mar 2020 13:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584537805;
        bh=MS122+MI8HvaX7QgTFw/2hADw9MT/NgSAmlg4rviq4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GpMwXcj8lqA4iW5RxQBBrJVd+qMgBVPfjSNN4WJBRjsMU7d8Yk1aMNAv8JOXZCoNN
         YNv1YD14IL/Pz+Dy5gs1Wdoc3pKe5v/9E+NQWPwpvjgve8Ok22jkKnZUeuiXyo1cr/
         cgOv8pXsr6CD1wNmMGyIJxKcDtQAr4r3Jtp0FjWQ=
Date:   Wed, 18 Mar 2020 14:23:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/13] coresight: cti: Add sysfs access to program
 function registers
Message-ID: <20200318132322.GC2789508@kroah.com>
References: <20200309161748.31975-1-mathieu.poirier@linaro.org>
 <20200309161748.31975-4-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309161748.31975-4-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 10:17:38AM -0600, Mathieu Poirier wrote:
> From: Mike Leach <mike.leach@linaro.org>
> 
> Adds in sysfs programming support for the CTI function register sets.
> Allows direct manipulation of channel / trigger association registers.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> [Fixed abbreviation in title]
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  drivers/hwtracing/coresight/Kconfig           |   9 +
>  .../hwtracing/coresight/coresight-cti-sysfs.c | 361 ++++++++++++++++++
>  drivers/hwtracing/coresight/coresight-cti.c   |  19 +
>  drivers/hwtracing/coresight/coresight-cti.h   |   8 +
>  4 files changed, 397 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> index 45d3822c8c8c..83e841be1081 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -122,4 +122,13 @@ config CORESIGHT_CTI
>  	  halt compared to disabling sources and sinks normally in driver
>  	  software.
>  
> +config CORESIGHT_CTI_INTEGRATION_REGS
> +	bool "Access CTI CoreSight Integration Registers"
> +	depends on CORESIGHT_CTI
> +	help
> +	  This option adds support for the CoreSight integration registers on
> +	  this device. The integration registers allow the exploration of the
> +	  CTI trigger connections between this and other devices.These
> +	  registers are not used in normal operation and can leave devices in
> +	  an inconsistent state.
>  endif
> diff --git a/drivers/hwtracing/coresight/coresight-cti-sysfs.c b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> index 507f8eb487fe..f687e07b68b0 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> @@ -109,6 +109,361 @@ static struct attribute *coresight_cti_mgmt_attrs[] = {
>  	NULL,
>  };
>  
> +/* CTI low level programming registers */
> +
> +/*
> + * Show a simple 32 bit value if enabled and powered.
> + * If inaccessible & pcached_val not NULL then show cached value.
> + */
> +static ssize_t cti_reg32_show(struct device *dev, char *buf,
> +			      u32 *pcached_val, int reg_offset)
> +{
> +	u32 val = 0;
> +	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	struct cti_config *config = &drvdata->config;
> +
> +	spin_lock(&drvdata->spinlock);
> +	if ((reg_offset >= 0) && cti_active(config)) {
> +		CS_UNLOCK(drvdata->base);
> +		val = readl_relaxed(drvdata->base + reg_offset);
> +		if (pcached_val)
> +			*pcached_val = val;
> +		CS_LOCK(drvdata->base);
> +	} else if (pcached_val) {
> +		val = *pcached_val;
> +	}
> +	spin_unlock(&drvdata->spinlock);
> +	return scnprintf(buf, PAGE_SIZE, "%#x\n", val);

Fix all of the scnprintf() calls.

And again, no documentation?

I'll stop here on this series, as much the same comments belong on the
other patches in here.

thanks,

greg k-h
