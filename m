Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF00C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 11:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5391D2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 11:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="bvkTTeXl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbgHYL5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 07:57:45 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:7314 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725893AbgHYL5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 07:57:38 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07PBvY7d029025;
        Tue, 25 Aug 2020 13:57:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=EbEMV1KvIFNB38fQh8GLgC41aChyvSDIUYhQQsl+qtY=;
 b=bvkTTeXlzGI7fUMHQeo2btq2pGrNSqQZiE+s2efKnCs2wseNGILxgVakkPAxLwJN/zoM
 zLvj+3dYpyFSSLoFAHJ9vcDKaalNisPTZZWyNdZN+QxUedLwh8qQ8C4rFAFu2F4wRmDb
 PD1LDMF0NVkjBKoXTb1WrQP5ZOmjJNAzPDG01mdh5jXF9VvG1Qc7RkBxsdasYBTlF6U0
 e1AHhn0jRvmkTL1jqDbgZUW8i7GiXv1I2K6WNdp+hdhNZ7ja896TgZ7Xz6qofPSVOYQN
 jLwyWexqdpOCpwV4fpnMbAN75XN8I1FU85NuAQKcdLlq51jQjWD27WB2ngkeUEDvgBKP aA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 333b3haujx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 13:57:34 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0E18610002A;
        Tue, 25 Aug 2020 13:57:23 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F154A2A820F;
        Tue, 25 Aug 2020 13:57:22 +0200 (CEST)
Received: from lmecxl0889.tpe.st.com (10.75.127.44) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 25 Aug
 2020 13:57:21 +0200
Subject: Re: [PATCH 5/9] rpmsg: introduce reserved rpmsg driver for ns
 announcement
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20200731114732.12815-1-arnaud.pouliquen@st.com>
 <20200731114732.12815-6-arnaud.pouliquen@st.com>
 <20200824224736.GD3938186@xps15>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <cbb145da-95ea-9f10-98e5-2618294996d6@st.com>
Date:   Tue, 25 Aug 2020 13:57:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200824224736.GD3938186@xps15>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-25_03:2020-08-25,2020-08-25 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu

Thanks for the review! please find few comments below.

On 8/25/20 12:47 AM, Mathieu Poirier wrote:
> On Fri, Jul 31, 2020 at 01:47:28PM +0200, Arnaud Pouliquen wrote:
>> The name service announcement should not be linked to the RPMsg virtio bus
>> but to the RPMsg protocol itself.
>>
>> This patch proposes to break the dependency with the RPmsg virtio bus by
>> the introduction of the reserved RPMsg name service driver which will be in
>> charge of managing the RPMsg name service announcement.
>>
>> This first patch only implements the probe and the RPMsg endpoint to
>> manage create and release channels remote requests.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>> ---
>>  drivers/rpmsg/Kconfig          |   8 ++
>>  drivers/rpmsg/Makefile         |   1 +
>>  drivers/rpmsg/rpmsg_internal.h |  17 +++++
>>  drivers/rpmsg/rpmsg_ns.c       | 135 +++++++++++++++++++++++++++++++++
>>  4 files changed, 161 insertions(+)
>>  create mode 100644 drivers/rpmsg/rpmsg_ns.c
>>
>> diff --git a/drivers/rpmsg/Kconfig b/drivers/rpmsg/Kconfig
>> index f96716893c2a..140faa975ea1 100644
>> --- a/drivers/rpmsg/Kconfig
>> +++ b/drivers/rpmsg/Kconfig
>> @@ -15,6 +15,14 @@ config RPMSG_CHAR
>>  	  in /dev. They make it possible for user-space programs to send and
>>  	  receive rpmsg packets.
>>  
>> +config RPMSG_NS
>> +	tristate "RPMSG name service announcement"
>> +	depends on RPMSG
>> +	help
>> +	  Say Y here to enable the support of the name service announcement
>> +	  channel that probes the associate RPMsg device on remote endpoint
> 
> s/associate/associated
> 
>> +	  service announcement.
>> +
>>  config RPMSG_MTK_SCP
>>  	tristate "MediaTek SCP"
>>  	depends on MTK_SCP
>> diff --git a/drivers/rpmsg/Makefile b/drivers/rpmsg/Makefile
>> index ffe932ef6050..8d452656f0ee 100644
>> --- a/drivers/rpmsg/Makefile
>> +++ b/drivers/rpmsg/Makefile
>> @@ -1,6 +1,7 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  obj-$(CONFIG_RPMSG)		+= rpmsg_core.o
>>  obj-$(CONFIG_RPMSG_CHAR)	+= rpmsg_char.o
>> +obj-$(CONFIG_RPMSG_NS)		+= rpmsg_ns.o
>>  obj-$(CONFIG_RPMSG_MTK_SCP)	+= mtk_rpmsg.o
>>  qcom_glink-objs			:= qcom_glink_native.o qcom_glink_ssr.o
>>  obj-$(CONFIG_RPMSG_QCOM_GLINK) += qcom_glink.o
>> diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
>> index d5ab286d0e5e..641b48f6bf2a 100644
>> --- a/drivers/rpmsg/rpmsg_internal.h
>> +++ b/drivers/rpmsg/rpmsg_internal.h
>> @@ -102,4 +102,21 @@ static inline int rpmsg_chrdev_register_device(struct rpmsg_device *rpdev)
>>  	return rpmsg_register_device(rpdev);
>>  }
>>  
>> +/**
>> + * rpmsg_ns_register_device() - register name service device based on rpdev
>> + * @rpdev: prepared rpdev to be used for creating endpoints
>> + *
>> + * This function wraps rpmsg_register_device() preparing the rpdev for use as
>> + * basis for the rpmsg name service device.
>> + */
>> +static inline int rpmsg_ns_register_device(struct rpmsg_device *rpdev)
>> +{
>> +	strcpy(rpdev->id.name, "rpmsg_ns");
>> +	rpdev->driver_override = "rpmsg_ns";
>> +	rpdev->src = RPMSG_NS_ADDR;
>> +	rpdev->dst = RPMSG_NS_ADDR;
>> +
>> +	return rpmsg_register_device(rpdev);
>> +}
>> +
>>  #endif
>> diff --git a/drivers/rpmsg/rpmsg_ns.c b/drivers/rpmsg/rpmsg_ns.c
>> new file mode 100644
>> index 000000000000..fe7713e737c2
>> --- /dev/null
>> +++ b/drivers/rpmsg/rpmsg_ns.c
>> @@ -0,0 +1,135 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) STMicroelectronics 2020 - All Rights Reserved
>> + */
>> +#include <linux/device.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/slab.h>
>> +#include "rpmsg_internal.h"
>> +
>> +/**
>> + * enum rpmsg_ns_flags - dynamic name service announcement flags
>> + *
>> + * @RPMSG_NS_CREATE: a new remote service was just created
>> + * @RPMSG_NS_DESTROY: a known remote service was just destroyed
>> + */
>> +enum rpmsg_ns_flags {
>> +	RPMSG_NS_CREATE		= 0,
>> +	RPMSG_NS_DESTROY	= 1,
>> +};
>> +
>> +/**
>> + * struct rpmsg_ns_msg - dynamic name service announcement message
>> + * @name: name of remote service that is published
>> + * @addr: address of remote service that is published
>> + * @flags: indicates whether service is created or destroyed
>> + *
>> + * This message is sent across to publish a new service, or announce
>> + * about its removal. When we receive these messages, an appropriate
>> + * rpmsg channel (i.e device) is created/destroyed. In turn, the ->probe()
>> + * or ->remove() handler of the appropriate rpmsg driver will be invoked
>> + * (if/as-soon-as one is registered).
>> + */
>> +struct rpmsg_ns_msg {
>> +	char name[RPMSG_NAME_SIZE];
>> +	u32 addr;
>> +	u32 flags;
>> +} __packed;
>> +
>> +/* invoked when a name service announcement arrives */
>> +static int rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
>> +		       void *priv, u32 src)
>> +{
>> +	struct rpmsg_ns_msg *msg = data;
>> +	struct rpmsg_device *newch;
>> +	struct rpmsg_channel_info chinfo;
>> +	struct device *dev = &rpdev->dev;
>> +	int ret;
>> +
>> +#if defined(CONFIG_DYNAMIC_DEBUG)
>> +	dynamic_hex_dump("NS announcement: ", DUMP_PREFIX_NONE, 16, 1,
>> +			 data, len, true);
>> +#endif
>> +
>> +	if (len != sizeof(*msg)) {
>> +		dev_err(dev, "malformed ns msg (%d)\n", len);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* don't trust the remote processor for null terminating the name */
>> +	msg->name[RPMSG_NAME_SIZE - 1] = '\0';
>> +
>> +	strncpy(chinfo.name, msg->name, sizeof(chinfo.name));
>> +	chinfo.src = RPMSG_ADDR_ANY;
>> +	chinfo.dst = msg->addr;
>> +
>> +	dev_info(dev, "%sing channel %s addr 0x%x\n",
>> +		 msg->flags & RPMSG_NS_DESTROY ? "destroy" : "creat",
>> +		 msg->name, msg->addr);
>> +
>> +	if (msg->flags & RPMSG_NS_DESTROY) {
>> +		ret = rpmsg_release_channel(rpdev, &chinfo);
>> +		if (ret)
>> +			dev_err(dev, "rpmsg_destroy_channel failed: %d\n", ret);
>> +	} else {
>> +		newch = rpmsg_create_channel(rpdev, &chinfo);
>> +		if (!newch)
>> +			dev_err(dev, "rpmsg_create_channel failed\n");
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int rpmsg_ns_probe(struct rpmsg_device *rpdev)
>> +{
>> +	struct rpmsg_channel_info ns_chinfo;
>> +	struct rpmsg_endpoint *ns_ept;
>> +
>> +	ns_chinfo.src = RPMSG_NS_ADDR;
>> +	ns_chinfo.dst = RPMSG_NS_ADDR;
>> +	strcpy(ns_chinfo.name, "name_service");
>> +
>> +	/*
>> +	 * create and attach the endpoint to the rpmsg device that it would be
>> +	 * destroy when the rpmsg device will be deleted
>> +	 */
> 
> This comment doesn't work, please revise.

Could you clarify what does not work, from your POV?
in view of your comment, it seems I should at least rephrase it... 
proposal:
	/*
 	 * Create the NS service endpoint associated to the rpmsg device.
         * The endpoint will be automatically destroyed when the rpmsg device
         * will be deleted.
	 */

> 
>> +	ns_ept = rpmsg_create_ept(rpdev, rpmsg_ns_cb, NULL, ns_chinfo);
>> +	if (!ns_ept) {
>> +		dev_err(&rpdev->dev, "failed to create the ns ept\n");
>> +		return -ENOMEM;
>> +	}
>> +	rpdev->ept = ns_ept;
>> +
>> +	rpdev->src = RPMSG_NS_ADDR;
> 
> I think this is already done in rpmsg_ns_register_device().

You are right!

thanks,
Arnaud
> 
>> +
>> +	return 0;
>> +}
>> +
>> +static struct rpmsg_driver rpmsg_ns_driver = {
>> +	.drv.name = "rpmsg_ns",
>> +	.probe = rpmsg_ns_probe,
>> +};
>> +
>> +static int rpmsg_ns_init(void)
>> +{
>> +	int ret;
>> +
>> +	ret = register_rpmsg_driver(&rpmsg_ns_driver);
>> +	if (ret < 0)
>> +		pr_err("%s: Failed to register rpmsg driver\n", __func__);
>> +
>> +	return ret;
>> +}
>> +postcore_initcall(rpmsg_ns_init);
>> +
>> +static void rpmsg_ns_exit(void)
>> +{
>> +	unregister_rpmsg_driver(&rpmsg_ns_driver);
>> +}
>> +module_exit(rpmsg_ns_exit);
>> +
>> +MODULE_DESCRIPTION("Name service announcement rpmsg Driver");
>> +MODULE_AUTHOR("Arnaud Pouliquen <arnaud.pouliquen@st.com>");
>> +MODULE_ALIAS("rpmsg_ns");
>> +MODULE_LICENSE("GPL v2");
>> -- 
>> 2.17.1
>>
