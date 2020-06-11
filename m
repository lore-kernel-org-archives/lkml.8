Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A260CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 18:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65A1C206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 18:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=displaylink.com header.i=@displaylink.com header.b="vQDTmnsX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgFKS0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 14:26:10 -0400
Received: from eu-smtp-delivery-167.mimecast.com ([185.58.86.167]:42073 "EHLO
        eu-smtp-delivery-167.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728410AbgFKS0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 14:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=displaylink.com;
        s=mimecast20151025; t=1591899961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3LwXF533DAb+Xqj4OyzNFjEv70UzeBSQ8W+LkbNG1QU=;
        b=vQDTmnsX8wgtcp7MYmlJqId8vIBCBNerl2dK4YD3ExCq7xPIRmazvbFwc/jim3qv4/tKod
        03CnLrL4xI0+u/EWKMq7I96EAb6EfRUt+2cfwvxpDu9oNLAD9jOv2hxVVnLn0rbUf3X5CF
        UT3JZ3jYKXUs5aMb7xAis5UXbr2Gfyg=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2051.outbound.protection.outlook.com [104.47.14.51]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-14-UiX4aX8pMta7rAphdcvvbg-1; Thu, 11 Jun 2020 19:19:07 +0100
X-MC-Unique: UiX4aX8pMta7rAphdcvvbg-1
Received: from AM0PR10MB2627.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:129::21)
 by AM0PR10MB2386.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:d4::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.22; Thu, 11 Jun
 2020 18:19:05 +0000
Received: from AM0PR10MB2627.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bd:9bf7:579b:62b4]) by AM0PR10MB2627.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bd:9bf7:579b:62b4%7]) with mapi id 15.20.3088.018; Thu, 11 Jun 2020
 18:19:05 +0000
Subject: Re: [External] Re: [PATCH v6 3/8] usb: mausb_host: HCD initialization
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mausb-host-devel@displaylink.com
References: <20200425091954.1610-1-vladimir.stankovic@displaylink.com>
 <20200515123502.12099-1-vladimir.stankovic@displaylink.com>
 <20200515123502.12099-4-vladimir.stankovic@displaylink.com>
 <20200515130754.GD1937631@kroah.com>
From:   Vladimir Stankovic <vladimir.stankovic@displaylink.com>
Message-ID: <bc1d3b5a-758a-2c7d-4b6b-952c674f14f9@displaylink.com>
Date:   Thu, 11 Jun 2020 20:18:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200515130754.GD1937631@kroah.com>
Content-Language: en-US
X-ClientProxiedBy: LNXP123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::27) To AM0PR10MB2627.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:129::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.102] (94.189.196.243) by LNXP123CA0015.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:d2::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19 via Frontend Transport; Thu, 11 Jun 2020 18:19:04 +0000
X-Originating-IP: [94.189.196.243]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f537e0f-5a53-426a-7d24-08d80e33eccf
X-MS-TrafficTypeDiagnostic: AM0PR10MB2386:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR10MB238651869236C74C191B32C191800@AM0PR10MB2386.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FVbpvNlLrna8Eabb2nLptu6fhRVZxT462CdqPHa4MdMxW5nK2Vwo/7Wx2D/T7IpyQH+A7KloAvQapW18/Jhi/52NEx+D7dVNOtzHX59oQYKgN5qJZVJ8SnCUcBDgmem0GjBe1Pw+35D8YTtVLICTkLhHm5nUIhujt4Cieva6TlCN6olkZHE1u3deSGDs3SKH8tcLdvThlOWxGtX984IrwEjcs+ar35eZz+V8kE4p/JfHTl4D4AwSquk1v+mMjt4+rd0b+L4iatfbzTlk8CozFfeEiVRfjLOETLqhVQkShntZ/skChc/mWSFL6ZrZaokSVRmWdztRkZzLJNMK4d8+mnjM5Yy2bkMcOgsmF30y6hdIhyeHJLeBykCzaR+9FUJW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2627.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(346002)(396003)(136003)(39840400004)(956004)(44832011)(66946007)(36756003)(31686004)(6916009)(66556008)(66476007)(2616005)(316002)(83380400001)(31696002)(8936002)(8676002)(86362001)(16576012)(16526019)(5660300002)(4326008)(2906002)(107886003)(186003)(6666004)(26005)(52116002)(478600001)(6486002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: KtaXa0F+N4bidoJCcGohKU0z4a7e80GSzOjQussZnedCiqZVGYhEE22XLBU8larQDJKILrCs4Y8iwfMS/XPzxbPW+L1ihc0I0ruNnz0AyD6NIoepsXx3MHEHYpq26fjsg56UHlSztwGIi1VD4CAzn6xl2CbTOkyt+ijSG4gv7QAjXqk540tzXOOyhEHAcXbfI4Sy1yC3bO/e77Pu/jOJICqLvKlDcfE6lIA7XzcF98cHVAMC+aUNf3OaMZnh7Lk8tBNtnY6GrVtCq41Cb0O7uVOumC/BABLNtwTNrrSNswkR7la+4haEAM80jtCCCDQ/Ou+8Jng3xs5znVnYSgrDs/rL9eEa91WVot2YfyjSIwe9mqvBOOLXBf+V6fcI1CJ93hbaa2CV+d9CrgSrxVGhoN6xgthLtDzJ/LQpnPVN4KNsO+YNTQ+pk56nqGyvvSC4eVVSgq0sPR2RcAN2ZXuSdL1ikg8V5OVIaEttY270YO4aON8wcAGOGwuXD+1snITY
X-OriginatorOrg: displaylink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f537e0f-5a53-426a-7d24-08d80e33eccf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 18:19:05.4235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4bda75a-b444-4312-9c90-44a7c4b2c91a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rrtv0auJLuKxcScspl6/Xh5fNAOEwvl5U6+2Q7TXMy6yGVI0xa5uxmibspD91Y8FlzGPSjDNGVCzjf6x8NKrQx2Rl2QctroKYPxwcSwsUMwcnWkH+inAOEhkNqVlrKky
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2386
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C67A128 smtp.mailfrom=vladimir.stankovic@displaylink.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: displaylink.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.5.20. 15:07, Greg KH wrote:
> On Fri, May 15, 2020 at 02:34:57PM +0200, Vladimir Stankovic wrote:
>> --- /dev/null
>> +++ b/drivers/usb/host/mausb/hcd.c
>> @@ -0,0 +1,120 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
>> + */
>> +#include "hcd.h"
>> +
>> +#include "utils.h"
>> +
>> +static int mausb_bus_match(struct device *dev, struct device_driver *dr=
v);
>> +
>> +static const struct file_operations mausb_fops;
>> +
>> +static unsigned int major;
>> +static unsigned int minor =3D 1;
>> +static dev_t devt;
>> +static struct device *device;
>> +
>> +struct mausb_hcd=09*mhcd;
>> +static struct class=09*mausb_class;
>> +static struct bus_type=09mausb_bus_type =3D {
>> +=09.name=09=3D DEVICE_NAME,
>> +=09.match=09=3D mausb_bus_match,
>> +};
>=20
> A static bus type???  For a single driver?
>=20
>> +
>> +static struct device_driver mausb_driver =3D {
>> +=09.name=09=3D DEVICE_NAME,
>> +=09.bus=09=3D &mausb_bus_type,
>> +=09.owner=09=3D THIS_MODULE,
>> +};
>=20
> Wait, what???  A static "raw" struct device_driver?  Why???
This was our initial driver setup that was "inherited" from some
in-tree drivers. We are currently revising driver setup. In general,
device driver will not work properly w/o bus being setup and the
only way to avoid explicit bus and simplify driver setup is to use
platform driver; however, we are not aware of any explicit dependency
on the platform, so not sure whether it's acceptable to switch to
platform device driver setup.
>=20
>> +
>> +static void mausb_remove(void)
>> +{
>> +=09struct usb_hcd *hcd, *shared_hcd;
>> +
>> +=09hcd=09   =3D mhcd->hcd_hs_ctx->hcd;
>> +=09shared_hcd =3D mhcd->hcd_ss_ctx->hcd;
>> +
>> +=09if (shared_hcd) {
>> +=09=09usb_remove_hcd(shared_hcd);
>> +=09=09usb_put_hcd(shared_hcd);
>> +=09=09mhcd->hcd_ss_ctx =3D NULL;
>> +=09}
>> +
>> +=09usb_remove_hcd(hcd);
>> +=09usb_put_hcd(hcd);
>> +=09mhcd->hcd_hs_ctx =3D NULL;
>> +}
>> +
>> +static int mausb_bus_match(struct device *dev, struct device_driver *dr=
v)
>> +{
>> +=09if (strncmp(dev->bus->name, drv->name, strlen(drv->name)))
>> +=09=09return 0;
>> +=09else
>> +=09=09return 1;
>> +}
>> +
>> +int mausb_init_hcd(void)
>> +{
>> +=09int retval =3D register_chrdev(0, DEVICE_NAME, &mausb_fops);
>> +
>> +=09if (retval < 0)
>> +=09=09return retval;
>> +
>> +=09major =3D (unsigned int)retval;
>> +=09retval =3D bus_register(&mausb_bus_type);
>> +=09if (retval)
>> +=09=09goto bus_register_error;
>> +
>> +=09mausb_class =3D class_create(THIS_MODULE, CLASS_NAME);
>> +=09if (IS_ERR(mausb_class)) {
>> +=09=09retval =3D (int)PTR_ERR(mausb_class);
>> +=09=09goto class_error;
>> +=09}
>> +
>> +=09retval =3D driver_register(&mausb_driver);
>> +=09if (retval)
>> +=09=09goto driver_register_error;
>> +
>> +=09mhcd =3D kzalloc(sizeof(*mhcd), GFP_ATOMIC);
>> +=09if (!mhcd) {
>> +=09=09retval =3D -ENOMEM;
>> +=09=09goto mausb_hcd_alloc_failed;
>> +=09}
>> +
>> +=09devt =3D MKDEV(major, minor);
>> +=09device =3D device_create(mausb_class, NULL, devt, mhcd, DEVICE_NAME)=
;
>> +=09if (IS_ERR(device)) {
>> +=09=09retval =3D (int)IS_ERR(device);
>> +=09=09goto device_create_error;
>> +=09}
>> +
>> +=09device->driver =3D &mausb_driver;
>=20
> Why?  What is this device going to do?  What do you need it for?
Yeah, this one is not needed at all. Will be removed.
>=20
>> +
>> +=09return retval;
>> +device_create_error:
>> +=09kfree(mhcd);
>> +=09mhcd =3D NULL;
>> +mausb_hcd_alloc_failed:
>> +=09driver_unregister(&mausb_driver);
>> +driver_register_error:
>> +=09class_destroy(mausb_class);
>> +class_error:
>> +=09bus_unregister(&mausb_bus_type);
>> +bus_register_error:
>> +=09unregister_chrdev(major, DEVICE_NAME);
>=20
> I thought you were using the misc device, what are you doing with a
> class and chardev?  Why is that still here?
>=20
We're currently revising driver setup logic - this part should be much
cleaner in new patch version.
>=20
>=20
>=20
>> +
>> +=09return retval;
>> +}
>> +
>> +void mausb_deinit_hcd(void)
>> +{
>> +=09if (mhcd) {
>> +=09=09mausb_remove();
>> +=09=09device_destroy(mausb_class, devt);
>> +=09=09driver_unregister(&mausb_driver);
>> +=09=09class_destroy(mausb_class);
>> +=09=09bus_unregister(&mausb_bus_type);
>> +=09=09unregister_chrdev(major, DEVICE_NAME);
>> +=09}
>> +}
>> diff --git a/drivers/usb/host/mausb/hcd.h b/drivers/usb/host/mausb/hcd.h
>> new file mode 100644
>> index 000000000000..e2374af67663
>> --- /dev/null
>> +++ b/drivers/usb/host/mausb/hcd.h
>> @@ -0,0 +1,65 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
>> + */
>> +#ifndef __MAUSB_HCD_H__
>> +#define __MAUSB_HCD_H__
>> +
>> +#include <linux/slab.h>
>> +#include <linux/usb.h>
>> +#include <linux/usb/hcd.h>
>> +
>> +#define DEVICE_NAME "mausb_host_hcd"
>> +#define CLASS_NAME "mausb"
>> +
>> +#define NUMBER_OF_PORTS=09=0915
>=20
> Why this max?
Related to USB_SS_MAXPORTS - a worst case scenario.
>=20
>> +
>> +#define MAX_USB_DEVICE_DEPTH=096
>=20
> Where does this max come from?
Unknown origin and unused - will be removed.
>=20
>> +
>> +#define RESPONSE_TIMEOUT=095000
>=20
> Units?
ms - will be renamed to reflect the same.
>=20
>> +
>> +#define MAUSB_PORT_20_STATUS_LOW_SPEED       0x0200
>> +#define MAUSB_PORT_20_STATUS_HIGH_SPEED      0x0400
>=20
> Device ids?  Something else?
>=20
> If something else, use BIT()?
>=20
>> +
>> +enum mausb_device_type {
>> +=09USBDEVICE =3D 0,
>> +=09USB20HUB  =3D 1,
>> +=09USB30HUB  =3D 2
>=20
> Trailing , please
>=20
>> +};
>> +
>> +enum mausb_device_speed {
>> +=09LOW_SPEED=09 =3D 0,
>> +=09FULL_SPEED=09 =3D 1,
>> +=09HIGH_SPEED=09 =3D 2,
>> +=09SUPER_SPEED=09 =3D 3,
>> +=09SUPER_SPEED_PLUS =3D 4
>=20
> , please.
>=20
>> +};
>=20
> Where do these values come from?
>=20
>> +
>> +struct mausb_hcd {
>> +=09spinlock_t=09lock;=09/* Protect HCD during URB processing */
>> +=09struct device=09*pdev;
>> +=09u16=09=09connected_ports;
>=20
> Why u16?
Seems odd, since max number of ports is much less. Should be corrected.
>=20
>> +
>> +=09struct rb_root=09mausb_urbs;
>> +=09struct hub_ctx=09*hcd_ss_ctx;
>> +=09struct hub_ctx=09*hcd_hs_ctx;
>> +=09struct notifier_block power_state_listener;
>> +};
>> +
>> +struct mausb_dev {
>> +=09u32=09=09port_status;
>> +=09struct rb_root=09usb_devices;
>> +=09u8=09=09dev_speed;
>> +=09void=09=09*ma_dev;
>> +};
>> +
>> +struct hub_ctx {
>> +=09struct mausb_hcd *mhcd;
>> +=09struct usb_hcd=09 *hcd;
>> +=09struct mausb_dev ma_devs[NUMBER_OF_PORTS];
>> +};
>> +
>> +int mausb_init_hcd(void);
>> +void mausb_deinit_hcd(void);
>> +
>> +#endif /* __MAUSB_HCD_H__ */
>> diff --git a/drivers/usb/host/mausb/mausb_core.c b/drivers/usb/host/maus=
b/mausb_core.c
>> index 44f76a1b74de..485f241d2b4c 100644
>> --- a/drivers/usb/host/mausb/mausb_core.c
>> +++ b/drivers/usb/host/mausb/mausb_core.c
>> @@ -4,6 +4,7 @@
>>   */
>>  #include <linux/module.h>
>> =20
>> +#include "hcd.h"
>>  #include "utils.h"
>> =20
>>  MODULE_LICENSE("GPL");
>> @@ -11,12 +12,27 @@ MODULE_AUTHOR("DisplayLink (UK) Ltd.");
>> =20
>>  static int mausb_host_init(void)
>>  {
>> -=09return mausb_host_dev_register();
>> +=09int status =3D mausb_host_dev_register();
>> +
>> +=09if (status < 0)
>> +=09=09goto exit;
>> +
>> +=09status =3D mausb_init_hcd();
>> +=09if (status < 0)
>> +=09=09goto cleanup_dev;
>> +
>> +=09return 0;
>> +
>> +cleanup_dev:
>> +=09mausb_host_dev_deregister();
>> +exit:
>> +=09return status;
>>  }
>> =20
>>  static void mausb_host_exit(void)
>>  {
>>  =09dev_info(mausb_host_dev.this_device, "Module unloading started...");
>=20
> This is debugging statements, please remove.  If a driver works
> properly, it does not print anything out.
>=20
> Especially as you never give the user the chance to see if module
> unloading ever finished :)
Agree :)
>=20
> thanks,
>=20
> greg k-h
>=20


--=20
Regards,
Vladimir.

