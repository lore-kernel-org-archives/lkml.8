Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0B5C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 02:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2D30207EA
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 02:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gbrNJ6Fb";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="Y/Vq/C3e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbgIKCvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 22:51:36 -0400
Received: from a27-18.smtp-out.us-west-2.amazonses.com ([54.240.27.18]:42606
        "EHLO a27-18.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725300AbgIKCvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 22:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599792694;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
        bh=MqAdCFM2kgFFf+vg7jbZ34uiMjZ6rwD+QSv7h7kTgKc=;
        b=gbrNJ6FbZqYfOSdmEGl0z0uUSGFY3L0TB37lER3DCSeqj2fB9MYnhQaJNdjD3tx1
        pM9lPi8+u+i6C/mpK/qzqBMv3Ep+EZZf3X7A94pl2FFu6P09Vv8xTIYeRfnW9Tc61F2
        UQBdT03kpD7pZ9A/yQ8IMSE0zijVnWG2owTcKoNA=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599792694;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Feedback-ID;
        bh=MqAdCFM2kgFFf+vg7jbZ34uiMjZ6rwD+QSv7h7kTgKc=;
        b=Y/Vq/C3eP7ex4/xVf7XgU87TKg8d6o60PVsDf5KGXN8xRx9jUn1vKnwAopshbVc9
        8LbZUOAUqGrKkx82dJ3wQDOAr3tUpA94s4HeG6D1RHgcwftb+bpHJT/STM5P6sMCTPz
        XXT7a0XDPMTu1vZqb4p8xa6NlcFfv0O8ymJzvGng=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5C99DC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=tingweiz@codeaurora.org
Date:   Fri, 11 Sep 2020 02:51:34 +0000
From:   Tingwei Zhang <tingweiz@codeaurora.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Tingwei Zhang <tingwei@codeaurora.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leo Yan <leo.yan@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Kim Phillips <kim.phillips@arm.com>,
        Mian Yousaf Kaukab <ykaukab@suse.de>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 21/24] coresight: cti: allow cti to be built as a
 module
Message-ID: <010101747b13452a-0775f7ad-9630-4f7e-9208-5a6fa46a6785-000000@us-west-2.amazonses.com>
References: <20200821034445.967-1-tingwei@codeaurora.org>
 <20200821034445.967-22-tingwei@codeaurora.org>
 <20200910230303.GE590446@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910230303.GE590446@xps15>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SES-Outgoing: 2020.09.11-54.240.27.18
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 07:03:03AM +0800, Mathieu Poirier wrote:
> On Fri, Aug 21, 2020 at 11:44:42AM +0800, Tingwei Zhang wrote:
> > Allow to build coresight-cti as a module, for ease of development.
> > 
> > - Kconfig becomes a tristate, to allow =m
> > - append -core to source file name to allow module to
> >   be called coresight-cti by the Makefile
> > - add an cti_remove function, for module unload
> > - move cti_remove_conn_xrefs to cti_remove
> > - add a MODULE_DEVICE_TABLE for autoloading on boot
> > 
> > Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
> > Tested-by: Mike Leach <mike.leach@linaro.org>
> > Reviewed-by Mike Leach <mike.leach@linaro.org>
> > ---
> >  drivers/hwtracing/coresight/Kconfig           |  5 ++++-
> >  drivers/hwtracing/coresight/Makefile          |  4 ++--
> >  .../{coresight-cti.c => coresight-cti-core.c} | 20 ++++++++++++++++++-
> >  .../hwtracing/coresight/coresight-platform.c  |  1 +
> >  drivers/hwtracing/coresight/coresight.c       |  1 +
> >  5 files changed, 27 insertions(+), 4 deletions(-)
> >  rename drivers/hwtracing/coresight/{coresight-cti.c =>
> coresight-cti-core.c} (98%)
> > 
> > diff --git a/drivers/hwtracing/coresight/Kconfig
> b/drivers/hwtracing/coresight/Kconfig
> > index f31778dd0b5d..b04aae2ceecc 100644
> > --- a/drivers/hwtracing/coresight/Kconfig
> > +++ b/drivers/hwtracing/coresight/Kconfig
> > @@ -136,7 +136,7 @@ config CORESIGHT_CPU_DEBUG
> >  	  module will be called coresight-cpu-debug.
> >  
> >  config CORESIGHT_CTI
> > -	bool "CoreSight Cross Trigger Interface (CTI) driver"
> > +	tristate "CoreSight Cross Trigger Interface (CTI) driver"
> >  	depends on ARM || ARM64
> >  	help
> >  	  This driver provides support for CoreSight CTI and CTM
> components.
> > @@ -147,6 +147,9 @@ config CORESIGHT_CTI
> >  	  halt compared to disabling sources and sinks normally in driver
> >  	  software.
> >  
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called coresight-cti.
> > +
> >  config CORESIGHT_CTI_INTEGRATION_REGS
> >  	bool "Access CTI CoreSight Integration Registers"
> >  	depends on CORESIGHT_CTI
> > diff --git a/drivers/hwtracing/coresight/Makefile
> b/drivers/hwtracing/coresight/Makefile
> > index f2a568b969c4..0359d5a1588f 100644
> > --- a/drivers/hwtracing/coresight/Makefile
> > +++ b/drivers/hwtracing/coresight/Makefile
> > @@ -19,6 +19,6 @@ coresight-etm4x-y := coresight-etm4x-core.o
> coresight-etm4x-sysfs.o
> >  obj-$(CONFIG_CORESIGHT_STM) += coresight-stm.o
> >  obj-$(CONFIG_CORESIGHT_CPU_DEBUG) += coresight-cpu-debug.o
> >  obj-$(CONFIG_CORESIGHT_CATU) += coresight-catu.o
> > -obj-$(CONFIG_CORESIGHT_CTI) += coresight-cti.o \
> > -				coresight-cti-platform.o \
> > +obj-$(CONFIG_CORESIGHT_CTI) += coresight-cti.o
> > +coresight-cti-y := coresight-cti-core.o	coresight-cti-platform.o \
> >  				coresight-cti-sysfs.o
> > diff --git a/drivers/hwtracing/coresight/coresight-cti.c
> b/drivers/hwtracing/coresight/coresight-cti-core.c
> > similarity index 98%
> > rename from drivers/hwtracing/coresight/coresight-cti.c
> > rename to drivers/hwtracing/coresight/coresight-cti-core.c
> > index ec286d617b73..d6d5419ec21c 100644
> > --- a/drivers/hwtracing/coresight/coresight-cti.c
> > +++ b/drivers/hwtracing/coresight/coresight-cti-core.c
> > @@ -838,7 +838,6 @@ static void cti_device_release(struct device *dev)
> >  	struct cti_drvdata *ect_item, *ect_tmp;
> >  
> >  	mutex_lock(&ect_mutex);
> > -	cti_remove_conn_xrefs(drvdata);
> >  	cti_pm_release(drvdata);
> >  
> >  	/* remove from the list */
> > @@ -853,6 +852,18 @@ static void cti_device_release(struct device *dev)
> >  	if (drvdata->csdev_release)
> >  		drvdata->csdev_release(dev);
> >  }
> > +static int __exit cti_remove(struct amba_device *adev)
> > +{
> > +	struct cti_drvdata *drvdata = dev_get_drvdata(&adev->dev);
> > +
> > +	mutex_lock(&ect_mutex);
> > +	cti_remove_conn_xrefs(drvdata);
> > +	mutex_unlock(&ect_mutex);
> > +
> > +	coresight_unregister(drvdata->csdev);
> > +
> > +	return 0;
> 
> Once again my recommendations from V8 were not followed.
>

Sorry for missing your comment. I'll add reason for above change
in commit message in V11.

Thanks,
Tingwei
 
> > +}
> >  
> >  static int cti_probe(struct amba_device *adev, const struct amba_id
> *id)
> >  {
> > @@ -973,6 +984,8 @@ static const struct amba_id cti_ids[] = {
> >  	{ 0, 0},
> >  };
> >  
> > +MODULE_DEVICE_TABLE(amba, cti_ids);
> > +
> >  static struct amba_driver cti_driver = {
> >  	.drv = {
> >  		.name	= "coresight-cti",
> > @@ -980,6 +993,7 @@ static struct amba_driver cti_driver = {
> >  		.suppress_bind_attrs = true,
> >  	},
> >  	.probe		= cti_probe,
> > +	.remove		= cti_remove,
> >  	.id_table	= cti_ids,
> >  };
> >  
> > @@ -1002,3 +1016,7 @@ static void __exit cti_exit(void)
> >  
> >  module_init(cti_init);
> >  module_exit(cti_exit);
> > +
> > +MODULE_AUTHOR("Mike Leach <mike.leach@linaro.org>");
> > +MODULE_DESCRIPTION("Arm CoreSight CTI Driver");
> > +MODULE_LICENSE("GPL v2");
> > diff --git a/drivers/hwtracing/coresight/coresight-platform.c
> b/drivers/hwtracing/coresight/coresight-platform.c
> > index 227e234a2470..3629b7885aca 100644
> > --- a/drivers/hwtracing/coresight/coresight-platform.c
> > +++ b/drivers/hwtracing/coresight/coresight-platform.c
> > @@ -75,6 +75,7 @@ coresight_find_csdev_by_fwnode(struct fwnode_handle
> *r_fwnode)
> >  	}
> >  	return csdev;
> >  }
> > +EXPORT_SYMBOL_GPL(coresight_find_csdev_by_fwnode);
> >  
> >  #ifdef CONFIG_OF
> >  static inline bool of_coresight_legacy_ep_is_input(struct device_node
> *ep)
> > diff --git a/drivers/hwtracing/coresight/coresight.c
> b/drivers/hwtracing/coresight/coresight.c
> > index 6c9f6930b8b8..668963b4b7d4 100644
> > --- a/drivers/hwtracing/coresight/coresight.c
> > +++ b/drivers/hwtracing/coresight/coresight.c
> > @@ -288,6 +288,7 @@ void coresight_set_assoc_ectdev_mutex(struct
> coresight_device *csdev,
> >  	csdev->ect_dev = ect_csdev;
> >  	mutex_unlock(&coresight_mutex);
> >  }
> > +EXPORT_SYMBOL_GPL(coresight_set_assoc_ectdev_mutex);
> >  
> >  static int coresight_enable_sink(struct coresight_device *csdev,
> >  				 u32 mode, void *data)
> > -- 
> > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> Forum,
> > a Linux Foundation Collaborative Project
> > 
