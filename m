Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CA6C28E83
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 08:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E25C206C9
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 08:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="n9Of3dZk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbgIDI27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 04:28:59 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:53966 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728636AbgIDI2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 04:28:55 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0848STix015945;
        Fri, 4 Sep 2020 10:28:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=k9jbDf+a89m98T0u0mG78qgihU+pWNX+2QSGeByO6dc=;
 b=n9Of3dZkV1ozEcNpAlwFgBtII3HKZXXWVXKkWXaz5OUQJrbLnEa4NO4dqssmbYz95+Sy
 tAvM5AvfPzJNGhFoAwgtFhkBJ1tnMs9xjOZGrkLlbhpUIcdNw6kyQjayy5TkorZoJUxE
 iayj3djDypiXEz92/CXu70pVJjoY1mfEugXbsY8njiAXe4513NItH2p5hzLbX6enlszE
 1Exof2/2CRNOOSP+tGd2vOjQ+bZm6oG8d4cD/so6hzxgdf0i2tWnGwUNUxtRYf2IDzXM
 pscr1ij3/WwSWanTjD8ge17bxaZ2H2/SXHtlV8BhtbZAY6b4no/01KLCUaGIsXQZLlJY nw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 337dwhrcmv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Sep 2020 10:28:49 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D2D4110002A;
        Fri,  4 Sep 2020 10:28:48 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C16B821FEB9;
        Fri,  4 Sep 2020 10:28:48 +0200 (CEST)
Received: from lmecxl0889.tpe.st.com (10.75.127.51) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 4 Sep
 2020 10:28:47 +0200
Subject: Re: [PATCH v2 5/8] rpmsg: introduce reserved rpmsg driver for ns
 announcement
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20200825164907.3642-1-arnaud.pouliquen@st.com>
 <20200825164907.3642-6-arnaud.pouliquen@st.com>
 <20200903230009.GD333030@xps15>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <9f62520b-63b2-b3e5-feff-58142e92de2a@st.com>
Date:   Fri, 4 Sep 2020 10:28:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903230009.GD333030@xps15>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG4NODE1.st.com (10.75.127.10) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-04_05:2020-09-04,2020-09-04 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 9/4/20 1:00 AM, Mathieu Poirier wrote:
> On Tue, Aug 25, 2020 at 06:49:04PM +0200, Arnaud Pouliquen wrote:
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
>> index f96716893c2a..c3fc75e6514b 100644
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
>> +	  channel that probes the associated RPMsg device on remote endpoint
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
>> index 000000000000..3c929b6976a6
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
>> +	__le32 addr;
>> +	__le32 flags;
> 
> This is about to get moved to a header file [1] so that the virtualisation people
> can use the same structures.  As such we can't just assume their type is __le32
> and we can't move them here either.  I suggest to move this to
> include/linux/rpmsg/virtio.h as Guennadi did.
> 
> [1]. https://patchwork.kernel.org/patch/11749285/

The objective of this patch is to treat the ns annoucement as a service so it should not 
depend on the virtio.
From my POV we have to separate the header from the payload in term of endianness.

That make sense that the rpmsg_hdr is virtio struct dependent. But the rpmsg_ns_msg  
describes the payload message. The payload message should be fixed by the service itself
and should not depend on the virualization.
Here i proposed to fix the payload in little endian for compatibility with the legacy.
But we also could decide to not fixe the endianess.

> 
>> +} __packed;
>> +
>> +/* Invoked when a name service announcement arrives */
>> +static int rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
>> +		       void *priv, u32 src)
>> +{
>> +	struct rpmsg_ns_msg *msg = data;
>> +	struct rpmsg_device *newch;
>> +	struct rpmsg_channel_info chinfo;
>> +	struct device *dev = &rpdev->dev;
>> +	unsigned int flags = le32_to_cpu(msg->flags);
> 
> I've been staring at this for a long time and I suspect you did too.
> 
> Can we assume that a name service is running on a virtio implementation?  It
> certainly has been the case so far, and doing so would make this patchset a lot
> more simple.  Otherwise we need to find a way to make this work without
> losing flexibility, which will make things more complex.
> 
> What do you think?

I am not sure to understand your point...
I'm also intertesting in understanding more in details what do you have in mind in term of 
"losing flexibility"?

The purpose of this patchset is to generalize the ns announcement so that it does
not depend on the implementation. The goal is to avoid that implementations
rewrite the service.

The vhost patchset is an exemple which is also virtio based. But there are some other
implementations (exemples below).

Anyway I think the main question associated to this patchset is:
Is the ns annoucement is a RPMsg service or a virtio RPMsg service?

From my point of view it should be a RPMsg service, that is enbled or
not, depending on the backend implementation.

2 other ns annoucement service exemples:
- the mtk_rpmsg driver[1].
- In ST we have a PoC to extend the rpmsg over a physical serial link [2]. Notice that, with
  this implementation we can have the LE-BE inter-communication use case. 
  For this PoC we also defined a common file that does not depend on the virtio[3], so
  an alternative to what Guennadi did in include/linux/rpmsg/virtio.h.

[1]https://elixir.bootlin.com/linux/v5.9-rc3/source/drivers/rpmsg/mtk_rpmsg.c#L45 
[2]https://github.com/arnopo/linux/blob/ELCE_demos/drivers/rpmsg/uart_rpmsg_bus.c
[3]https://github.com/arnopo/linux/blob/ELCE_demos/drivers/rpmsg/rpmsg_bus_common.c

Thanks,
Arnaud

> 
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
>> +	/* Don't trust the remote processor for null terminating the name */
>> +	msg->name[RPMSG_NAME_SIZE - 1] = '\0';
>> +
>> +	strncpy(chinfo.name, msg->name, sizeof(chinfo.name));
>> +	chinfo.src = RPMSG_ADDR_ANY;
>> +	chinfo.dst = le32_to_cpu(msg->addr);
>> +
>> +	dev_info(dev, "%sing channel %s addr 0x%x\n",
>> +		 (flags & RPMSG_NS_DESTROY) ? "destroy" : "creat",
>> +		 msg->name, chinfo.dst);
>> +
>> +	if (flags & RPMSG_NS_DESTROY) {
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
>> +	 * Create the NS announcement service endpoint associated to the RPMsg
>> +	 * device. The endpoint will be automatically destroyed when the RPMsg
>> +	 * device will be deleted.
>> +	 */
>> +	ns_ept = rpmsg_create_ept(rpdev, rpmsg_ns_cb, NULL, ns_chinfo);
>> +	if (!ns_ept) {
>> +		dev_err(&rpdev->dev, "failed to create the ns ept\n");
>> +		return -ENOMEM;
>> +	}
>> +	rpdev->ept = ns_ept;
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
