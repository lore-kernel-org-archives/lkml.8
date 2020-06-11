Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C45EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 18:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78A942084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 18:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=displaylink.com header.i=@displaylink.com header.b="kxCGMiUh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbgFKS0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 14:26:18 -0400
Received: from eu-smtp-delivery-167.mimecast.com ([207.82.80.167]:36420 "EHLO
        eu-smtp-delivery-167.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728506AbgFKS0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 14:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=displaylink.com;
        s=mimecast20151025; t=1591899972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tM9YA6RBaQtDO4UdxHfWYnwlxbmUk3qrIfG/XVoBfIY=;
        b=kxCGMiUh+Ywjq8V5YekMAJbuU4cLX3XtWIFb/V1BaNKRlf0SI+hHP2eYxbSEObdteO7shB
        5oNNe/jQNnnuTotKmf6locXxVNdLzQkxcmmWqntqnQWS/dl+hcm/M5bqJblbOXwWLL3ViP
        O9oAcKJw0el+fw34F1jG23aPSdonZs8=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2059.outbound.protection.outlook.com [104.47.14.59]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-256-pBqr8_FtMva3iYCwP43Fng-1; Thu, 11 Jun 2020 19:20:05 +0100
X-MC-Unique: pBqr8_FtMva3iYCwP43Fng-1
Received: from AM0PR10MB2627.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:129::21)
 by AM0PR10MB2386.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:d4::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.22; Thu, 11 Jun
 2020 18:20:04 +0000
Received: from AM0PR10MB2627.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bd:9bf7:579b:62b4]) by AM0PR10MB2627.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bd:9bf7:579b:62b4%7]) with mapi id 15.20.3088.018; Thu, 11 Jun 2020
 18:20:04 +0000
Subject: Re: [PATCH v6 1/8] usb: Add MA-USB Host kernel module
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mausb-host-devel@displaylink.com
References: <20200425091954.1610-1-vladimir.stankovic@displaylink.com>
 <20200515123502.12099-1-vladimir.stankovic@displaylink.com>
 <20200515123502.12099-2-vladimir.stankovic@displaylink.com>
 <20200515130127.GA1937631@kroah.com>
From:   Vladimir Stankovic <vladimir.stankovic@displaylink.com>
Message-ID: <3ee6788a-9944-4a01-6b81-083ca489efda@displaylink.com>
Date:   Thu, 11 Jun 2020 20:20:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200515130127.GA1937631@kroah.com>
Content-Language: en-US
X-ClientProxiedBy: LO2P123CA0058.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::22) To AM0PR10MB2627.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:129::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.102] (94.189.196.243) by LO2P123CA0058.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:1::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18 via Frontend Transport; Thu, 11 Jun 2020 18:20:03 +0000
X-Originating-IP: [94.189.196.243]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c492f1c8-d40f-4f19-2c0c-08d80e340fd8
X-MS-TrafficTypeDiagnostic: AM0PR10MB2386:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR10MB2386DE910ED17C368C90961D91800@AM0PR10MB2386.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PNrbKissK5mDEr5QkgCBEanMta4KDkVamsgu0ONVXiZxidfx3PIhPrjmk9uvn2wowob5vJ3uavynVHPKJQwQTpTRtxd9XkMqcQ+64TKGpEvmRWf9dFBoxzyfsuGq7U1+CiChSslwjrMScuz7rPNInb/zlrKpYPHI1fj0im7RcMv9qSZIrcmrMvuFLxX8W9+i1FEBeZnsSi9MiPdDu9alcljzjSz9LHj2MbSMhJSSDYmhVh+sIbY2iMj5ZV83pN61li6XI8uNa1OADz5NohamdRLV1/FNER5ixdI+q86cr/YNlgvVn7wVgXzqR5tBhLlTKeKvap8evvjZ/4WSmjpOnDhVOCcAg/GgIAM0fOEdpXN+Uot23VD4PHTyAkySEcA3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2627.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39840400004)(136003)(346002)(376002)(366004)(107886003)(4326008)(2906002)(186003)(16526019)(5660300002)(6486002)(26005)(52116002)(478600001)(31686004)(2616005)(6916009)(66476007)(66556008)(956004)(66946007)(36756003)(44832011)(31696002)(16576012)(86362001)(8936002)(8676002)(316002)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: c2CfQKejeOIzY8bSmLmrGQsCQokxaTPkadlymet26+Mw2Bf4IZgroSuQK0dMcvoTsU5kEIGzi48wtTZ9gmxmIm0FY8A2+4IJ2hiNa6pIUEcuO/HJwYB7yDMxzSXM7akHaKFAercxxcIyMQooEBLTI2wqK2Qtr4+91akkZSO2+lfoKVrVJQ28MVcydc4VV5qE24aerJUsZ1QUo33nBM8PecLWuiX4dsuxdfpzLx4LD8VviTAXh+IDQ6ZU/ps5A9qWLmZfZNNfNkmMyR5KeuFZMAAFCE4u7hlRcJU2M5CUYUPX07OhmN8QT9wZeskLnDdRpgCqcQ13fiRU46X0J4mfq5NQSI7sCup0GcAv+QJ0u9abv9HD1dNs7vKybPYL7j69nV2OB17tOfgoSbo4+fAvi3jS/PH3owqBMTjG3Ylejxm38fH4gKp+Sdq6c6udY2JwFntdYNf33gqFpwIR0FI71svg8YhwKNgbaMXuQ67m+Zg=
X-OriginatorOrg: displaylink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c492f1c8-d40f-4f19-2c0c-08d80e340fd8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 18:20:04.1517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4bda75a-b444-4312-9c90-44a7c4b2c91a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sNAee4qT4z/TXm4mluJUtC91SuJ4dbmeb/ULkM/t8noTVBqViH6DrWG0pjN65z7PQ/ZZm75L04t4LqoAP4neTW8F0BmXxXLMQnmaz9G2v41KHGPDzBF4+PdNz8kGCVJN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2386
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: displaylink.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.5.20. 15:01, Greg KH wrote:
> On Fri, May 15, 2020 at 02:34:55PM +0200, Vladimir Stankovic wrote:
>> --- /dev/null
>> +++ b/drivers/usb/host/mausb/Kconfig
>> @@ -0,0 +1,15 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# Kernel configuration file for MA-USB Host driver.
>> +#
>> +# Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
>> +#
>> +
>> +config USB_HOST_MAUSB
>> +=09tristate "Media Agnostic (MA) USB Host Driver"
>> +=09depends on USB=3Dy
>=20
> Why =3Dy?  That should not be a requirement for any usb host driver.
With current driver in-tree location, it's not needed. Will be removed.
>=20
>> +=09help
>> +=09  This is a Media Agnostic (MA) USB Host driver which enables host
>> +=09  communication via MA USB protocol stack.
>> +
>> +=09  If this driver is compiled as a module, it will be named mausb_hos=
t.
>=20
> Provide links to the userspace and spec here so that people have a
> chance to be able to use this driver?
>=20
>=20
>=20
>> diff --git a/drivers/usb/host/mausb/Makefile b/drivers/usb/host/mausb/Ma=
kefile
>> new file mode 100644
>> index 000000000000..cafccac0edba
>> --- /dev/null
>> +++ b/drivers/usb/host/mausb/Makefile
>> @@ -0,0 +1,10 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# Makefile for DisplayLink MA-USB Host driver.
>> +#
>> +# Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
>> +#
>> +
>> +obj-$(CONFIG_USB_HOST_MAUSB) +=3D mausb_host.o
>> +mausb_host-y :=3D mausb_core.o
>> +mausb_host-y +=3D utils.o
>> diff --git a/drivers/usb/host/mausb/mausb_core.c b/drivers/usb/host/maus=
b/mausb_core.c
>> new file mode 100644
>> index 000000000000..44f76a1b74de
>> --- /dev/null
>> +++ b/drivers/usb/host/mausb/mausb_core.c
>> @@ -0,0 +1,24 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
>> + */
>> +#include <linux/module.h>
>> +
>> +#include "utils.h"
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("DisplayLink (UK) Ltd.");
>> +
>> +static int mausb_host_init(void)
>> +{
>> +=09return mausb_host_dev_register();
>> +}
>> +
>> +static void mausb_host_exit(void)
>> +{
>> +=09dev_info(mausb_host_dev.this_device, "Module unloading started...");
>> +=09mausb_host_dev_deregister();
>> +}
>> +
>> +module_init(mausb_host_init);
>> +module_exit(mausb_host_exit);
>> diff --git a/drivers/usb/host/mausb/utils.c b/drivers/usb/host/mausb/uti=
ls.c
>> new file mode 100644
>> index 000000000000..1cfa2140311e
>> --- /dev/null
>> +++ b/drivers/usb/host/mausb/utils.c
>> @@ -0,0 +1,47 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
>> + */
>> +#include "utils.h"
>> +
>> +#include <linux/fs.h>
>> +#include <linux/slab.h>
>> +
>> +#define MAUSB_KERNEL_DEV_NAME "mausb_host"
>> +#define MAUSB_READ_DEVICE_TIMEOUT_MS 500
>> +
>> +struct miscdevice mausb_host_dev;
>> +
>> +static int mausb_host_dev_open(struct inode *inode, struct file *filp)
>> +{
>> +=09filp->private_data =3D NULL;
>> +
>> +=09return 0;
>> +}
>> +
>> +static int mausb_host_dev_release(struct inode *inode, struct file *fil=
p)
>> +{
>> +=09kfree(filp->private_data);
>> +=09filp->private_data =3D NULL;
>> +
>> +=09return 0;
>> +}
>> +
>> +static const struct file_operations mausb_host_dev_fops =3D {
>> +=09.open=09 =3D mausb_host_dev_open,
>> +=09.release =3D mausb_host_dev_release,
>> +};
>> +
>> +int mausb_host_dev_register(void)
>> +{
>> +=09mausb_host_dev.minor =3D MISC_DYNAMIC_MINOR;
>> +=09mausb_host_dev.name =3D MAUSB_KERNEL_DEV_NAME;
>> +=09mausb_host_dev.fops =3D &mausb_host_dev_fops;
>> +=09mausb_host_dev.mode =3D 0;
>=20
> You only have 1 device in the system at a time?  With a global
> structure?  And no locking at all?
>=20
> That feels _very_ wrong, why?
>=20
> And mode of 0?  You don't want any userspace code to use this device
> node?
>=20
> confused,
>=20
> greg k-h
>=20
Agree. This will be revised in following patch version.


--=20
Regards,
Vladimir.

