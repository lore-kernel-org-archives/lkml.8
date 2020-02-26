Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8479BC4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CDE22467B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=displaylink.com header.i=@displaylink.com header.b="YXMZ3+um"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgBZJ7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 04:59:43 -0500
Received: from eu-smtp-delivery-167.mimecast.com ([207.82.80.167]:42381 "EHLO
        eu-smtp-delivery-167.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727075AbgBZJ7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 04:59:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=displaylink.com;
        s=mimecast20151025; t=1582711177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1Z6ES+AYgNIASABuDrIWqoJVSdWQwe2b9ym7F130YfU=;
        b=YXMZ3+umjn1AbRdejbmrVwfI0BcIWhaSUtVPNamPKbBLNhUk1yBHnHtAE6X/Aofn3J3DNi
        ye95fu/MF5iy8sFtrWuAipl7tJT+SlcZmS85bsqWgVcjb8cEHfY9M8uieHGzDv9rtzhtEB
        LWVxRmM40Yr9Nevi2aEeCaOzAlZtDXg=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2053.outbound.protection.outlook.com [104.47.10.53]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-82-5GCNwfC7MKyiUh0XTdI4Jw-1; Wed, 26 Feb 2020 09:59:35 +0000
X-MC-Unique: 5GCNwfC7MKyiUh0XTdI4Jw-1
Received: from AM0PR10MB1954.EURPRD10.PROD.OUTLOOK.COM (52.133.63.154) by
 AM0PR10MB2897.EURPRD10.PROD.OUTLOOK.COM (10.255.28.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Wed, 26 Feb 2020 09:59:32 +0000
Received: from AM0PR10MB1954.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d07a:2e67:4515:dba6]) by AM0PR10MB1954.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d07a:2e67:4515:dba6%3]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 09:59:32 +0000
Received: from [172.17.183.132] (80.93.235.40) by VI1P195CA0006.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:d0::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Wed, 26 Feb 2020 09:59:32 +0000
From:   Vladimir Stankovic <vladimir.stankovic@displaylink.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        mausb-host-devel <mausb-host-devel@displaylink.com>
Subject: [PATCH v2 7/8] usb: mausb_host: MA USB PAL events processing
Thread-Topic: [PATCH v2 7/8] usb: mausb_host: MA USB PAL events processing
Thread-Index: AQHV7ItxAEq+SCP7/EySG2iuf98+Qg==
Date:   Wed, 26 Feb 2020 09:59:32 +0000
Message-ID: <eb4d948e-f8c9-b9bd-343a-b79b322e23b3@displaylink.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0006.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:d0::16) To AM0PR10MB1954.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:40::26)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [80.93.235.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c69ebd1e-a1b4-4fee-3df9-08d7baa293e7
x-ms-traffictypediagnostic: AM0PR10MB2897:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR10MB2897135BAB0629A1806F1A8391EA0@AM0PR10MB2897.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:291;
x-forefront-prvs: 0325F6C77B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(39840400004)(376002)(346002)(396003)(199004)(189003)(107886003)(2906002)(5660300002)(30864003)(66946007)(66476007)(66446008)(64756008)(66556008)(4326008)(44832011)(956004)(71200400001)(186003)(16526019)(478600001)(2616005)(26005)(16576012)(31696002)(8936002)(81166006)(36756003)(8676002)(81156014)(86362001)(6916009)(316002)(31686004)(6486002)(54906003)(52116002)(579004)(559001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR10MB2897;H:AM0PR10MB1954.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZAWt3piCrz4ehYprvHppCqDaRFqys93g5toiz1NXBxIN8yNHndbt+qHCEYUcTVLXUHDrXhie0xIUKYhK7jc47BNs3QHQU9R7MMo7NZCEFPB2Qs5pa1B5CaWMCSbZSaAtzu/sk2XpREcPhhL+nPqY5arQ6NjRItQvre4+wsNI4bXej5FMdzlqTmcWxTQ3G2mSw0TcO9GFYwMQmNMZiX4ZQ67pv/WzJJ2jWROTIMAPYhUg9pviKQV7veeH8zL38525lixwEzHaLjZ0pu6TMWsuc7XIjIbvoswHtalcX2qkz9GRCJEw4w1mp+DU6/GorvffAE9O8ABFuq4g1qm/ES23kvlRaQmsIdP5veN3oPz4YtrdnGJfM3x2GiZnDfS35v5zUuhW1aenVxrMPgzlUfpmqeYnE9Vuyu8qGw73pRw/kTBURFl0C12xzd+oiaSIAKFU
x-ms-exchange-antispam-messagedata: vx54U6FcYCl1D1eV6AAvE4JExV9R3fN8/K0z1w5o061KygGkF/LpQ0YlmQV4TiQQbiaNgr0ks3eDZ3CFo09Ss542tZFBVgCPpRDrVjReRR4AkA6OHMVqM1Tu1v8CRyhZzDWWbSz/IkMAk21QVM0+/Q==
Content-ID: <668FBDB014D38C4C9A12D2F095E7EA13@EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-OriginatorOrg: displaylink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c69ebd1e-a1b4-4fee-3df9-08d7baa293e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2020 09:59:32.7097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4bda75a-b444-4312-9c90-44a7c4b2c91a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: but5yiglpDyCylI0EIg91NRB/MthsZjEC0RgIcHBdjZItGrmzLkTwhYLbvmG1ztpJHCem6tqKzOyzA7aPntxnBNwzCfrhdUT3oTQB83Behza9izA2cShKukMrE3DHx67
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2897
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: displaylink.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implemented MA USB management messages processing and communication
with user-space driver via mapped memory.

MA USB PAL events are being enqueued into ring buffer from which
data is being send/received to/from user-space.

Signed-off-by: Vladimir Stankovic <vladimir.stankovic@displaylink.com>
---
  drivers/usb/mausb_host/Makefile              |   1 +
  drivers/usb/mausb_host/hcd.c                 | 252 +++++++-
  drivers/usb/mausb_host/hpal.c                | 457 +++++++++++++-
  drivers/usb/mausb_host/hpal.h                |  44 ++
  drivers/usb/mausb_host/hpal_events.c         | 611 +++++++++++++++++++
  drivers/usb/mausb_host/hpal_events.h         |  85 +++
  drivers/usb/mausb_host/mausb_driver_status.h |  17 +
  drivers/usb/mausb_host/utils.c               | 275 +++++++++
  drivers/usb/mausb_host/utils.h               |   5 +
  9 files changed, 1731 insertions(+), 16 deletions(-)
  create mode 100644 drivers/usb/mausb_host/hpal_events.c
  create mode 100644 drivers/usb/mausb_host/hpal_events.h
  create mode 100644 drivers/usb/mausb_host/mausb_driver_status.h

diff --git a/drivers/usb/mausb_host/Makefile=20
b/drivers/usb/mausb_host/Makefile
index 0ebd79f8e2ef..a9ae92d60f06 100644
--- a/drivers/usb/mausb_host/Makefile
+++ b/drivers/usb/mausb_host/Makefile
@@ -11,6 +11,7 @@ mausb_host-y +=3D utils.o
  mausb_host-y +=3D ip_link.o
  mausb_host-y +=3D hcd.o
  mausb_host-y +=3D hpal.o
+mausb_host-y +=3D hpal_events.o
   ccflags-y +=3D -I$(srctree)/$(src)
  ccflags-y +=3D -g
diff --git a/drivers/usb/mausb_host/hcd.c b/drivers/usb/mausb_host/hcd.c
index 70cb633c39ba..8cf885612684 100644
--- a/drivers/usb/mausb_host/hcd.c
+++ b/drivers/usb/mausb_host/hcd.c
@@ -10,6 +10,7 @@
  #include <linux/module.h>
   #include "hpal.h"
+#include "hpal_events.h"
  #include "utils.h"
   static int mausb_open(struct inode *inode, struct file *file);
@@ -1075,6 +1076,18 @@ static void mausb_free_dev(struct usb_hcd *hcd,=20
struct usb_device *dev)
  =09}
   =09if (ep_ctx) {
+=09=09status =3D mausb_epinactivate_event_to_user(ma_dev, dev_handle,
+=09=09=09=09=09=09=09  ep_ctx->ep_handle);
+
+=09=09mausb_pr_info("epinactivate request ep_handle=3D%#x, dev_handle=3D%#=
x,=20
status=3D%d",
+=09=09=09      ep_ctx->ep_handle, dev_handle, status);
+
+=09=09status =3D mausb_epdelete_event_to_user(ma_dev, dev_handle,
+=09=09=09=09=09=09      ep_ctx->ep_handle);
+
+=09=09if (status < 0)
+=09=09=09mausb_pr_warn("ep_handle_del request failed for ep0: ep_handle=3D=
%#x,=20
dev_handle=3D%#x",
+=09=09=09=09      ep_ctx->ep_handle, dev_handle);
  =09=09dev->ep0.hcpriv =3D NULL;
  =09=09kfree(ep_ctx);
  @@ -1082,6 +1095,14 @@ static void mausb_free_dev(struct usb_hcd *hcd,=20
struct usb_device *dev)
  =09=09mausb_pr_warn("ep_ctx is NULL: dev_handle=3D%#x", dev_handle);
  =09}
  +=09if (dev_handle !=3D DEV_HANDLE_NOT_ASSIGNED) {
+=09=09status =3D mausb_usbdevdisconnect_event_to_user(ma_dev,
+=09=09=09=09=09=09=09      dev_handle);
+=09=09if (status < 0)
+=09=09=09mausb_pr_warn("usb_dev_disconnect req failed for dev_handle=3D%#x=
",
+=09=09=09=09      dev_handle);
+=09}
+
  free_dev:
  =09if (atomic_sub_and_test(1, &ma_dev->num_of_usb_devices)) {
  =09=09mausb_pr_info("All usb devices destroyed - proceed with disconnecti=
ng");
@@ -1096,6 +1117,21 @@ static void mausb_free_dev(struct usb_hcd *hcd,=20
struct usb_device *dev)
  =09=09mausb_clear_hcd_madev(port_number);
  }
  +static int mausb_device_assign_address(struct mausb_device *dev,
+=09=09=09=09       struct mausb_usb_device_ctx *usb_dev_ctx)
+{
+=09int status =3D
+=09=09mausb_setusbdevaddress_event_to_user(dev,
+=09=09=09=09=09=09     usb_dev_ctx->dev_handle,
+=09=09=09=09=09=09     RESPONSE_TIMEOUT);
+
+=09mausb_pr_info("dev_handle=3D%#x, status=3D%d", usb_dev_ctx->dev_handle,
+=09=09      status);
+=09usb_dev_ctx->addressed =3D (status =3D=3D 0);
+
+=09return status;
+}
+
  static struct mausb_usb_device_ctx *
  mausb_alloc_device_ctx(struct hub_ctx *hub, struct usb_device *dev,
  =09=09       struct mausb_device *ma_dev, u16 port_number,
@@ -1182,6 +1218,12 @@ static int mausb_address_device(struct usb_hcd=20
*hcd, struct usb_device *dev)
  =09=09=09return status;
  =09}
  +=09if (!usb_device_ctx->addressed) {
+=09=09status =3D mausb_device_assign_address(ma_dev, usb_device_ctx);
+=09=09if (status < 0)
+=09=09=09return status;
+=09}
+
  =09endpoint_ctx =3D dev->ep0.hcpriv;
  =09if (!endpoint_ctx) {
  =09=09mausb_pr_err("endpoint_ctx is NULL: dev_handle=3D%#x",
@@ -1189,7 +1231,23 @@ static int mausb_address_device(struct usb_hcd=20
*hcd, struct usb_device *dev)
  =09=09return -EINVAL;
  =09}
  -=09return 0;
+=09/*
+=09 * Fix to support usb 2.0 logitech camera. If endoint handle of usb 2.0
+=09 * device is already modified, do not modify it again.
+=09 */
+=09if (dev->speed < USB_SPEED_SUPER && endpoint_ctx->ep_handle !=3D 0)
+=09=09return 0;
+
+=09status =3D mausb_modifyep0_event_to_user(ma_dev,
+=09=09=09=09=09       usb_device_ctx->dev_handle,
+=09=09=09=09=09       &endpoint_ctx->ep_handle,
+=09=09=09=09=09       dev->ep0.desc.wMaxPacketSize);
+
+=09mausb_pr_info("modify ep0 response, ep_handle=3D%#x, dev_handle=3D%#x,=
=20
status=3D%d",
+=09=09      endpoint_ctx->ep_handle, endpoint_ctx->dev_handle,
+=09=09      status);
+
+=09return status;
  }
   static int mausb_add_endpoint(struct usb_hcd *hcd, struct usb_device=20
*dev,
@@ -1242,10 +1300,32 @@ static int mausb_add_endpoint(struct usb_hcd=20
*hcd, struct usb_device *dev,
  =09=09mausb_init_superspeed_ep_descriptor(&descriptor_ss,
  =09=09=09=09=09=09    &endpoint->desc,
  =09=09=09=09=09=09    &endpoint->ss_ep_comp);
+=09=09status =3D mausb_ephandle_event_to_user(ma_dev,
+=09=09=09=09=09=09      usb_dev_ctx->dev_handle,
+=09=09=09=09=09=09      sizeof(descriptor_ss),
+=09=09=09=09=09=09      &descriptor_ss,
+=09=09=09=09=09=09      &endpoint_ctx->ep_handle);
+
  =09} else {
  =09=09mausb_init_standard_ep_descriptor(&descriptor, &endpoint->desc);
+=09=09status =3D mausb_ephandle_event_to_user(ma_dev,
+=09=09=09=09=09=09      usb_dev_ctx->dev_handle,
+=09=09=09=09=09=09      sizeof(descriptor),
+=09=09=09=09=09=09      &descriptor,
+=09=09=09=09=09=09      &endpoint_ctx->ep_handle);
  =09}
  +=09if (status < 0) {
+=09=09mausb_pr_err("ep_handle_request failed dev_handle=3D%#x",
+=09=09=09     usb_dev_ctx->dev_handle);
+=09=09endpoint->hcpriv =3D NULL;
+=09=09kfree(endpoint_ctx);
+=09=09return status;
+=09}
+
+=09mausb_pr_info("Endpoint added ep_handle=3D%#x, dev_handle=3D%#x",
+=09=09      endpoint_ctx->ep_handle, endpoint_ctx->dev_handle);
+
  =09return 0;
  }
  @@ -1254,6 +1334,7 @@ static int mausb_drop_endpoint(struct usb_hcd=20
*hcd, struct usb_device *dev,
  {
  =09u8=09port_number;
  =09int=09status;
+=09int=09retries=09    =3D 0;
  =09struct hub_ctx=09=09    *hub =3D (struct hub_ctx *)hcd->hcd_priv;
  =09struct mausb_device=09    *ma_dev;
  =09struct mausb_usb_device_ctx *usb_dev_ctx;
@@ -1288,9 +1369,49 @@ static int mausb_drop_endpoint(struct usb_hcd=20
*hcd, struct usb_device *dev,
  =09=09return -ENODEV;
  =09}
  +=09mausb_pr_info("Start dropping ep_handle=3D%#x, dev_handle=3D%#x",
+=09=09      endpoint_ctx->ep_handle, endpoint_ctx->dev_handle);
+
+=09if (atomic_read(&ma_dev->unresponsive_client)) {
+=09=09mausb_pr_err("Client is not responsive anymore - drop endpoint=20
immediately");
+=09=09endpoint->hcpriv =3D NULL;
+=09=09kfree(endpoint_ctx);
+=09=09return -ESHUTDOWN;
+=09}
+
+=09status =3D mausb_epinactivate_event_to_user(ma_dev,
+=09=09=09=09=09=09  usb_dev_ctx->dev_handle,
+=09=09=09=09=09=09  endpoint_ctx->ep_handle);
+
+=09mausb_pr_info("epinactivate request ep_handle=3D%#x, dev_handle=3D%#x,=
=20
status=3D%d",
+=09=09      endpoint_ctx->ep_handle, endpoint_ctx->dev_handle,
+=09=09      status);
+
+=09while (true) {
+=09=09status =3D mausb_epdelete_event_to_user(ma_dev,
+=09=09=09=09=09=09      usb_dev_ctx->dev_handle,
+=09=09=09=09=09=09      endpoint_ctx->ep_handle);
+
+=09=09mausb_pr_info("ep_handle_delete_request, ep_handle=3D%#x,=20
dev_handle=3D%#x, status=3D%d",
+=09=09=09      endpoint_ctx->ep_handle, endpoint_ctx->dev_handle,
+=09=09=09      status);
+
+=09=09if (status =3D=3D -EBUSY) {
+=09=09=09if (++retries < MAUSB_BUSY_RETRIES_COUNT)
+=09=09=09=09usleep_range(10000, 10001);
+=09=09=09else
+=09=09=09=09return -EBUSY;
+=09=09} else {
+=09=09=09break;
+=09=09}
+=09}
+
+=09mausb_pr_info("Endpoint dropped ep_handle=3D%#x, dev_handle=3D%#x",
+=09=09      endpoint_ctx->ep_handle, endpoint_ctx->dev_handle);
+
  =09endpoint->hcpriv =3D NULL;
  =09kfree(endpoint_ctx);
-=09return 0;
+=09return status;
  }
   static int mausb_device_assign_dev_handle(struct usb_hcd *hcd,
@@ -1343,6 +1464,20 @@ static int mausb_device_assign_dev_handle(struct=20
usb_hcd *hcd,
  =09=09return -EINVAL;
  =09}
  +=09status =3D mausb_usbdevhandle_event_to_user(ma_dev, (u8)dev_speed,
+=09=09=09=09=09=09  dev->route, hub_dev_handle,
+=09=09=09=09=09=09  parent_hs_hub_dev_handle,
+=09=09=09=09=09=09  parent_hs_hub_port, 0,
+=09=09=09=09=09=09  ma_dev->lse,
+=09=09=09=09=09=09  &usb_device_ctx->dev_handle);
+
+=09mausb_pr_info("mausb_usbdevhandle_event status=3D%d", status);
+
+=09if (status < 0)
+=09=09return status;
+
+=09mausb_pr_info("Get ref dev_handle=3D%#x", usb_device_ctx->dev_handle);
+
  =09endpoint_ctx =3D kzalloc(sizeof(*endpoint_ctx), GFP_ATOMIC);
  =09if (!endpoint_ctx)
  =09=09return -ENOMEM;
@@ -1354,6 +1489,22 @@ static int mausb_device_assign_dev_handle(struct=20
usb_hcd *hcd,
   =09mausb_init_standard_ep_descriptor(&descriptor, &dev->ep0.desc);
  +=09status =3D mausb_ephandle_event_to_user(ma_dev,
+=09=09=09=09=09      usb_device_ctx->dev_handle,
+=09=09=09=09=09      sizeof(descriptor),
+=09=09=09=09=09      &descriptor,
+=09=09=09=09=09      &endpoint_ctx->ep_handle);
+
+=09mausb_pr_info("mausb_ephandle_event ep_handle=3D%#x, dev_handle=3D%#x,=
=20
status=3D%d",
+=09=09      endpoint_ctx->ep_handle, endpoint_ctx->dev_handle,
+=09=09      status);
+
+=09if (status < 0) {
+=09=09dev->ep0.hcpriv =3D NULL;
+=09=09kfree(endpoint_ctx);
+=09=09return status;
+=09}
+
  =09return 0;
  }
  @@ -1396,9 +1547,21 @@ static int mausb_enable_device(struct usb_hcd=20
*hcd, struct usb_device *dev)
  =09=09=09return status;
  =09}
  +=09mausb_pr_info("Device assigned and addressed usb_device_ctx=3D%p",
+=09=09      usb_device_ctx);
+
  =09if (usb_device_ctx->dev_handle =3D=3D DEV_HANDLE_NOT_ASSIGNED)
  =09=09return mausb_device_assign_dev_handle(hcd, dev, hub, ma_dev,
  =09=09=09=09=09=09      usb_device_ctx);
+
+=09/*
+=09 * Fix for usb 2.0 logitech camera
+=09 */
+=09if (!usb_device_ctx->addressed)
+=09=09return mausb_device_assign_address(ma_dev, usb_device_ctx);
+
+=09mausb_pr_info("Device assigned and addressed dev_handle=3D%#x",
+=09=09      usb_device_ctx->dev_handle);
  =09return 0;
  }
  @@ -1444,7 +1607,15 @@ static int mausb_update_device(struct usb_hcd=20
*hcd, struct usb_device *dev)
  =09=09return -ENODEV;
  =09}
  -=09return 0;
+=09status =3D mausb_updatedev_event_to_user(ma_dev,
+=09=09=09=09=09       usb_device_ctx->dev_handle,
+=09=09=09=09=09       0, 0, 0, 0, 0, 0,
+=09=09=09=09=09       &dev->descriptor);
+
+=09mausb_pr_info("Finished dev_handle=3D%#x, status=3D%d",
+=09=09      usb_device_ctx->dev_handle, status);
+
+=09return status;
  }
   static int mausb_hub_update_device(struct usb_hcd *hcd, struct=20
usb_device *dev,
@@ -1454,8 +1625,10 @@ static int mausb_hub_update_device(struct usb_hcd=20
*hcd, struct usb_device *dev,
  =09u8=09port_number;
  =09unsigned long flags;
  =09u16 max_exit_latency =3D 0;
+=09u8  number_of_ports =3D (u8)dev->maxchild;
  =09u8  mtt =3D 0;
  =09u8  ttt =3D 0;
+=09u8  integrated_hub_latency =3D 0;
  =09struct hub_ctx=09=09    *hub =3D (struct hub_ctx *)hcd->hcd_priv;
  =09struct mausb_device=09    *ma_dev;
  =09struct mausb_usb_device_ctx *usb_device_ctx;
@@ -1495,7 +1668,17 @@ static int mausb_hub_update_device(struct usb_hcd=20
*hcd, struct usb_device *dev,
  =09else if (dev->usb3_lpm_u2_enabled)
  =09=09max_exit_latency =3D (u16)dev->u2_params.mel;
  -=09return 0;
+=09status =3D mausb_updatedev_event_to_user(ma_dev,
+=09=09=09=09=09       usb_device_ctx->dev_handle,
+=09=09=09=09=09       max_exit_latency, 1,
+=09=09=09=09=09       number_of_ports, mtt, ttt,
+=09=09=09=09=09       integrated_hub_latency,
+=09=09=09=09=09       &dev->descriptor);
+
+=09mausb_pr_info("Finished dev_handle=3D%#x, status=3D%d",
+=09=09      usb_device_ctx->dev_handle, status);
+
+=09return status;
  }
   static int mausb_check_bandwidth(struct usb_hcd *hcd, struct=20
usb_device *dev)
@@ -1531,6 +1714,8 @@ static void mausb_endpoint_reset(struct usb_hcd *hcd,
  =09struct mausb_usb_device_ctx *usb_device_ctx;
  =09struct usb_device=09    *dev;
  =09struct mausb_endpoint_ctx   *ep_ctx;
+=09struct ma_usb_ephandlereq_desc_ss  descriptor_ss;
+=09struct ma_usb_ephandlereq_desc_std descriptor;
   =09ep_ctx =3D endpoint->hcpriv;
  =09if (!ep_ctx) {
@@ -1565,6 +1750,15 @@ static void mausb_endpoint_reset(struct usb_hcd *hcd=
,
  =09is_out =3D usb_endpoint_dir_out(&endpoint->desc);
  =09tsp =3D (u8)(is_out ? dev->toggle[1] : dev->toggle[0]);
  +=09status =3D mausb_epreset_event_to_user(ma_dev, dev_handle,
+=09=09=09=09=09     ep_ctx->ep_handle, tsp);
+
+=09mausb_pr_info("ep_reset status=3D%d, ep_handle=3D%#x, dev_handle=3D%#x"=
,
+=09=09      status, ep_ctx->ep_handle, dev_handle);
+
+=09if (status < 0)
+=09=09return;
+
  =09if (status !=3D EUCLEAN) {
  =09=09if (!tsp) {
  =09=09=09usb_settoggle(dev, epnum, is_out, 0U);
@@ -1572,12 +1766,52 @@ static void mausb_endpoint_reset(struct usb_hcd=20
*hcd,
  =09=09=09=09usb_settoggle(dev, epnum, !is_out, 0U);
  =09=09}
  +=09=09status =3D mausb_epactivate_event_to_user(ma_dev, dev_handle,
+=09=09=09=09=09=09=09ep_ctx->ep_handle);
+
+=09=09mausb_pr_err("ep_activate failed, status=3D%d, ep_handle=3D%#x,=20
dev_handle=3D%#x",
+=09=09=09     status, ep_ctx->ep_handle, dev_handle);
+
  =09=09return;
  =09}
   =09if (tsp)
  =09=09return;
  +=09status =3D mausb_epinactivate_event_to_user(ma_dev, dev_handle,
+=09=09=09=09=09=09  ep_ctx->ep_handle);
+
+=09mausb_pr_info("ep_inactivate status=3D%d, ep_handle=3D%#x, dev_handle=
=3D%#x",
+=09=09      status, ep_ctx->ep_handle, dev_handle);
+
+=09if (status < 0)
+=09=09return;
+
+=09status =3D mausb_epdelete_event_to_user(ma_dev, dev_handle,
+=09=09=09=09=09      ep_ctx->ep_handle);
+
+=09mausb_pr_info("ep_handle_delete status=3D%d, ep_handle=3D%#x, dev_handl=
e=3D%#x",
+=09=09      status, ep_ctx->ep_handle, dev_handle);
+
+=09if (status < 0)
+=09=09return;
+
+=09if (dev->speed >=3D USB_SPEED_SUPER) {
+=09=09mausb_init_superspeed_ep_descriptor(&descriptor_ss,
+=09=09=09=09=09=09    &endpoint->desc,
+=09=09=09=09=09=09    &endpoint->ss_ep_comp);
+=09=09status =3D mausb_ephandle_event_to_user(ma_dev, dev_handle,
+=09=09=09=09=09=09      sizeof(descriptor_ss),
+=09=09=09=09=09=09      &descriptor_ss,
+=09=09=09=09=09=09      &ep_ctx->ep_handle);
+=09} else {
+=09=09mausb_init_standard_ep_descriptor(&descriptor, &endpoint->desc);
+=09=09status =3D mausb_ephandle_event_to_user(ma_dev, dev_handle,
+=09=09=09=09=09=09      sizeof(descriptor),
+=09=09=09=09=09=09      &descriptor,
+=09=09=09=09=09=09      &ep_ctx->ep_handle);
+=09}
+
  =09mausb_pr_info("ep_handle request status=3D%d, ep_handle=3D%#x,=20
dev_handle=3D%#x",
  =09=09      status, ep_ctx->ep_handle, dev_handle);
  }
@@ -1624,7 +1858,15 @@ static int mausb_reset_device(struct usb_hcd=20
*hcd, struct usb_device *dev)
   =09dev_handle =3D usb_device_ctx->dev_handle;
  -=09return 0;
+=09status =3D mausb_usbdevreset_event_to_user(ma_dev, dev_handle);
+
+=09mausb_pr_info("usb_dev_reset dev_handle=3D%#x, status=3D%d",
+=09=09      dev_handle, status);
+
+=09if (status =3D=3D 0)
+=09=09usb_device_ctx->addressed =3D false;
+
+=09return status;
  }
   void mausb_clear_hcd_madev(u16 port_number)
diff --git a/drivers/usb/mausb_host/hpal.c b/drivers/usb/mausb_host/hpal.c
index c5252f690451..29e3b7bc3d75 100644
--- a/drivers/usb/mausb_host/hpal.c
+++ b/drivers/usb/mausb_host/hpal.c
@@ -11,6 +11,7 @@
  #include <linux/uio.h>
   #include "hcd.h"
+#include "hpal_events.h"
  #include "utils.h"
   #define MAUSB_DELETE_MADEV_TIMEOUT_MS 3000
@@ -278,6 +279,31 @@ void mausb_release_event_resources(struct=20
mausb_event *event)
  =09kfree(receive_buffer);
  }
  +static void mausb_iterator_reset(struct mausb_device *dev,
+=09=09=09=09 struct mausb_event *event)
+{
+=09struct urb=09     *urb =3D (struct urb *)event->data.urb;
+=09struct mausb_urb_ctx *urb_ctx;
+
+=09urb_ctx =3D mausb_find_urb_in_tree(urb);
+
+=09if (urb_ctx)
+=09=09mausb_reset_data_iterator(&urb_ctx->iterator);
+}
+
+static void mausb_iterator_seek(struct mausb_device *dev,
+=09=09=09=09struct mausb_event *event)
+{
+=09struct urb=09     *urb =3D (struct urb *)event->data.urb;
+=09struct mausb_urb_ctx *urb_ctx;
+
+=09urb_ctx =3D mausb_find_urb_in_tree(urb);
+
+=09if (urb_ctx)
+=09=09mausb_data_iterator_seek(&urb_ctx->iterator,
+=09=09=09=09=09 event->data.iterator_seek_delta);
+}
+
  void mausb_complete_urb(struct mausb_event *event)
  {
  =09struct urb *urb =3D (struct urb *)event->data.urb;
@@ -291,6 +317,46 @@ void mausb_complete_urb(struct mausb_event *event)
  =09=09=09       event->status);
  }
  +static void mausb_delete_ma_dev(struct mausb_device *dev,
+=09=09=09=09struct mausb_event *event)
+{
+=09mausb_signal_event(dev, event, event->mgmt.delete_ma_dev.event_id);
+}
+
+static void mausb_process_user_finished(struct mausb_device *dev,
+=09=09=09=09=09struct mausb_event *event)
+{
+=09complete(&dev->user_finished_event);
+}
+
+static int mausb_send_mgmt_msg(struct mausb_device *dev,
+=09=09=09       struct mausb_event *event)
+{
+=09struct mausb_kvec_data_wrapper wrapper;
+=09struct kvec kvec;
+=09struct ma_usb_hdr_common *hdr;
+=09int status;
+
+=09hdr =3D (struct ma_usb_hdr_common *)event->mgmt.mgmt_hdr.hdr;
+
+=09mausb_pr_info("event=3D%d, type=3D%d", event->type, hdr->type);
+
+=09kvec.iov_base=09 =3D hdr;
+=09kvec.iov_len=09 =3D hdr->length;
+=09wrapper.kvec=09 =3D &kvec;
+=09wrapper.kvec_num =3D 1;
+=09wrapper.length=09 =3D hdr->length;
+
+=09status =3D mausb_ip_send(dev->mgmt_channel, &wrapper);
+=09if (status < 0) {
+=09=09mausb_pr_err("Send failed. Disconnecting... status=3D%d", status);
+=09=09queue_work(dev->workq, &dev->socket_disconnect_work);
+=09=09queue_work(dev->workq, &dev->hcd_disconnect_work);
+=09}
+
+=09return status;
+}
+
  static int mausb_get_first_free_port_number(u16 *port_number)
  {
  =09(*port_number) =3D 0;
@@ -338,11 +404,142 @@ static inline void=20
mausb_port_has_changed_event(struct mausb_device *dev,
  =09=09mausb_port_has_changed(USB20HUB, HIGH_SPEED, dev);
  }
  +static void mausb_complete_timeout_event(struct mausb_device *dev,
+=09=09=09=09=09 struct mausb_event *event)
+{
+=09mausb_pr_debug("Event type=3D%d, event_id=3D%llu", event->type,
+=09=09       event->mgmt.mgmt_req_timedout.event_id);
+=09mausb_signal_event(dev, event, event->mgmt.mgmt_req_timedout.event_id);
+}
+
+static void mausb_process_event(struct mausb_device *dev,
+=09=09=09=09struct mausb_event *event)
+{
+=09mausb_pr_debug("Event type=3D%d", event->type);
+
+=09switch (event->type) {
+=09case MAUSB_EVENT_TYPE_USB_DEV_HANDLE:
+=09=09mausb_usbdevhandle_event_from_user(dev, event);
+=09=09break;
+=09case MAUSB_EVENT_TYPE_EP_HANDLE:
+=09=09mausb_ephandle_event_from_user(dev, event);
+=09=09break;
+=09case MAUSB_EVENT_TYPE_EP_HANDLE_ACTIVATE:
+=09=09mausb_epactivate_event_from_user(dev, event);
+=09=09break;
+=09case MAUSB_EVENT_TYPE_EP_HANDLE_INACTIVATE:
+=09=09mausb_epinactivate_event_from_user(dev, event);
+=09=09break;
+=09case MAUSB_EVENT_TYPE_EP_HANDLE_RESET:
+=09=09mausb_epreset_event_from_user(dev, event);
+=09=09break;
+=09case MAUSB_EVENT_TYPE_EP_HANDLE_DELETE:
+=09=09mausb_epdelete_event_from_user(dev, event);
+=09=09break;
+=09case MAUSB_EVENT_TYPE_MODIFY_EP0:
+=09=09mausb_modifyep0_event_from_user(dev, event);
+=09=09break;
+=09case MAUSB_EVENT_TYPE_SET_USB_DEV_ADDRESS:
+=09=09mausb_setusbdevaddress_event_from_user(dev, event);
+=09=09break;
+=09case MAUSB_EVENT_TYPE_UPDATE_DEV:
+=09=09mausb_updatedev_event_from_user(dev, event);
+=09=09break;
+=09case MAUSB_EVENT_TYPE_USB_DEV_RESET:
+=09=09mausb_usbdevreset_event_from_user(dev, event);
+=09=09break;
+=09case MAUSB_EVENT_TYPE_CANCEL_TRANSFER:
+=09=09mausb_canceltransfer_event_from_user(dev, event);
+=09=09break;
+=09case MAUSB_EVENT_TYPE_PORT_CHANGED:
+=09=09mausb_port_has_changed_event(dev, event);
+=09=09break;
+=09case MAUSB_EVENT_TYPE_PING:
+=09=09mausb_send_mgmt_msg(dev, event);
+=09=09break;
+=09case MAUSB_EVENT_TYPE_SEND_MGMT_MSG:
+=09=09mausb_send_mgmt_msg(dev, event);
+=09=09break;
+=09case MAUSB_EVENT_TYPE_SEND_DATA_MSG:
+=09=09mausb_send_data_msg(dev, event);
+=09=09break;
+=09case MAUSB_EVENT_TYPE_RECEIVED_DATA_MSG:
+=09=09mausb_receive_data_msg(dev, event);
+=09=09break;
+=09case MAUSB_EVENT_TYPE_URB_COMPLETE:
+=09=09mausb_complete_urb(event);
+=09=09break;
+=09case MAUSB_EVENT_TYPE_SEND_ACK:
+=09=09mausb_send_transfer_ack(dev, event);
+=09=09mausb_release_event_resources(event);
+=09=09break;
+=09case MAUSB_EVENT_TYPE_ITERATOR_RESET:
+=09=09mausb_iterator_reset(dev, event);
+=09=09break;
+=09case MAUSB_EVENT_TYPE_ITERATOR_SEEK:
+=09=09mausb_iterator_seek(dev, event);
+=09=09break;
+=09case MAUSB_EVENT_TYPE_DELETE_MA_DEV:
+=09=09mausb_delete_ma_dev(dev, event);
+=09=09break;
+=09case MAUSB_EVENT_TYPE_USER_FINISHED:
+=09=09mausb_process_user_finished(dev, event);
+=09=09break;
+=09case MAUSB_EVENT_TYPE_RELEASE_EVENT_RESOURCES:
+=09=09mausb_release_event_resources(event);
+=09=09break;
+=09case MAUSB_EVENT_TYPE_NONE:
+=09=09mausb_release_event_resources(event);
+=09=09break;
+=09case MAUSB_EVENT_TYPE_MGMT_REQUEST_TIMED_OUT:
+=09=09mausb_complete_timeout_event(dev, event);
+=09=09break;
+=09default:
+=09=09break;
+=09}
+
+=09mausb_notify_completed_user_events(dev->ring_buffer);
+}
+
+static void mausb_hpal_kernel_work(struct work_struct *work)
+{
+=09struct mausb_device *dev =3D container_of(work, struct mausb_device,
+=09=09=09=09=09=09work);
+=09struct mausb_event *event;
+=09int status;
+=09u16 i;
+=09u16 events;
+=09u16 completed_events;
+=09unsigned long flags;
+=09struct mausb_ring_buffer *dev_mausb_ring =3D dev->ring_buffer;
+
+=09spin_lock_irqsave(&dev->num_of_user_events_lock, flags);
+=09events =3D dev->num_of_user_events;
+=09completed_events =3D dev->num_of_completed_events;
+=09dev->num_of_user_events =3D 0;
+=09dev->num_of_completed_events =3D 0;
+=09spin_unlock_irqrestore(&dev->num_of_user_events_lock, flags);
+
+=09status =3D mausb_ring_buffer_move_tail(dev_mausb_ring, completed_events=
);
+=09if (status < 0) {
+=09=09mausb_pr_err("Dequeue failed, status=3D%d", status);
+=09=09kref_put(&dev->refcount, mausb_release_ma_dev_async);
+=09=09return;
+=09}
+
+=09for (i =3D 0; i < events; ++i) {
+=09=09event =3D mausb_ring_current_from_user(dev_mausb_ring);
+=09=09mausb_ring_next_from_user(dev_mausb_ring);
+=09=09mausb_process_event(dev, event);
+=09}
+}
+
  static void mausb_socket_disconnect_event(struct work_struct *work)
  {
  =09struct mausb_device *dev =3D container_of(work, struct mausb_device,
  =09=09=09=09=09=09socket_disconnect_work);
  =09struct mausb_event event;
+=09int status;
   =09mausb_pr_info("madev_addr=3D%d", dev->madev_addr);
  @@ -363,6 +560,11 @@ static void mausb_socket_disconnect_event(struct=20
work_struct *work)
  =09=09event.type =3D MAUSB_EVENT_TYPE_NETWORK_DISCONNECTED;
  =09=09event.data.device_id =3D dev->id;
  +=09=09status =3D mausb_enqueue_event_to_user(dev, &event);
+
+=09=09mausb_pr_info("Sending notification to user that network is=20
disconnected status=3D%d",
+=09=09=09      status);
+
  =09=09mausb_pr_info("Releasing MAUSB device ref");
  =09=09kref_put(&dev->refcount, mausb_release_ma_dev_async);
  =09}
@@ -427,6 +629,12 @@ static void mausb_delete_madev(struct work_struct=20
*work)
   =09=09mausb_insert_event(dev, &mausb_completion);
  +=09=09status =3D mausb_enqueue_event_to_user(dev, &event);
+=09=09if (status < 0) {
+=09=09=09mausb_remove_event(dev, &mausb_completion);
+=09=09=09mausb_pr_err("Ring buffer full, enqueue failed");
+=09=09=09return;
+=09=09}
  =09=09mausb_pr_debug("Deleting MAUSB device...");
   =09=09status =3D wait_for_completion_interruptible_timeout(&completion,
@@ -449,10 +657,14 @@ static void mausb_delete_madev(struct work_struct=20
*work)
   =09mausb_clear_hcd_madev(dev->port_number);
  +=09mausb_ring_buffer_cleanup(dev->ring_buffer);
+=09mausb_ring_buffer_destroy(dev->ring_buffer);
+
  =09mausb_remove_madev_from_list(dev->madev_addr);
   =09put_net(dev->net_ns);
  +=09kfree(dev->ring_buffer);
  =09kfree(dev);
  =09mausb_signal_empty_mss();
  @@ -463,6 +675,7 @@ static void mausb_ping_work(struct work_struct *work)
  {
  =09struct mausb_device *dev =3D container_of(work, struct mausb_device,
  =09=09=09=09=09=09ping_work);
+=09int status =3D 0;
   =09if (mausb_start_connection_timer(dev) < 0) {
  =09=09mausb_pr_err("Device disconnecting due to session timeout=20
madev_addr=3D%d",
@@ -471,6 +684,13 @@ static void mausb_ping_work(struct work_struct *work)
  =09=09queue_work(dev->workq, &dev->hcd_disconnect_work);
  =09=09return;
  =09}
+
+=09status =3D mausb_ping_event_to_user(dev);
+
+=09if (status < 0) {
+=09=09mausb_pr_err("Ring buffer full");
+=09=09return;
+=09}
  }
   static void mausb_heartbeat_work(struct work_struct *work)
@@ -576,6 +796,7 @@ mausb_create_madev(struct mausb_device_address=20
dev_addr, u8 madev_address,
   =09dev->workq =3D workq;
  +=09INIT_WORK(&dev->work, mausb_hpal_kernel_work);
  =09INIT_WORK(&dev->socket_disconnect_work, mausb_socket_disconnect_event)=
;
  =09INIT_WORK(&dev->hcd_disconnect_work, mausb_hcd_disconnect_event);
  =09INIT_WORK(&dev->madev_delete_work, mausb_delete_madev);
@@ -601,6 +822,15 @@ mausb_create_madev(struct mausb_device_address=20
dev_addr, u8 madev_address,
  =09dev->madev_addr =3D madev_address;
  =09dev->net_ns =3D get_net(current->nsproxy->net_ns);
  +=09if (!list_empty(&mss.available_ring_buffers)) {
+=09=09dev->ring_buffer =3D container_of(mss.available_ring_buffers.next,
+=09=09=09=09=09=09struct mausb_ring_buffer,
+=09=09=09=09=09=09list_entry);
+=09=09list_del(mss.available_ring_buffers.next);
+=09} else {
+=09=09mausb_pr_alert("Ring buffer for mausb device is not availbale!");
+=09}
+
  =09list_add_tail(&dev->list_entry, &mss.madev_list);
   =09reinit_completion(&mss.empty);
@@ -659,6 +889,14 @@ int mausb_initiate_dev_connection(struct=20
mausb_device_address dev_addr,
  =09return 0;
  }
  +void mausb_on_madev_connected(struct mausb_device *dev)
+{
+=09struct mausb_event mausb_event;
+
+=09mausb_dev_reset_req_event(&mausb_event);
+=09mausb_enqueue_event_to_user(dev, &mausb_event);
+}
+
  int mausb_enqueue_event_from_user(u8 madev_addr, u16 num_of_events,
  =09=09=09=09  u16 num_of_completed)
  {
@@ -683,9 +921,29 @@ int mausb_enqueue_event_from_user(u8 madev_addr,=20
u16 num_of_events,
  =09return 0;
  }
  +int mausb_enqueue_event_to_user(struct mausb_device *dev,
+=09=09=09=09struct mausb_event *event)
+{
+=09int status;
+
+=09event->madev_addr =3D dev->madev_addr;
+=09status =3D mausb_ring_buffer_put(dev->ring_buffer, event);
+=09if (status < 0) {
+=09=09mausb_pr_err("Ring buffer operation failed");
+=09=09mausb_cleanup_ring_buffer_event(event);
+=09=09return status;
+=09}
+
+=09mausb_notify_ring_events(dev->ring_buffer);
+=09mausb_pr_debug("User-space notification sent.");
+
+=09return 0;
+}
+
  int mausb_data_req_enqueue_event(struct mausb_device *dev, u16 ep_handle,
  =09=09=09=09 struct urb *request)
  {
+=09int status;
  =09struct mausb_event mausb_event;
   =09mausb_event.type   =3D MAUSB_EVENT_TYPE_SEND_DATA_MSG;
@@ -728,7 +986,12 @@ int mausb_data_req_enqueue_event(struct=20
mausb_device *dev, u16 ep_handle,
  =09=09       &request->dev->route, sizeof(request->dev->route));
  =09}
  -=09return 0;
+=09status =3D mausb_enqueue_event_to_user(dev, &mausb_event);
+=09if (status < 0)
+=09=09mausb_pr_err("Failed to enqueue event to user-space ep_handle=3D%#x,=
=20
status=3D%d",
+=09=09=09     mausb_event.data.ep_handle, status);
+
+=09return status;
  }
   void mausb_complete_request(struct urb *urb, u32 actual_length, int=20
status)
@@ -841,6 +1104,17 @@ static void mausb_execute_urb_dequeue(struct=20
work_struct *dequeue_work)
  =09mausb_pr_debug("urb=3D%p, ep_handle=3D%#x, dev_handle=3D%#x",
  =09=09       urb, ep_ctx->ep_handle, ep_ctx->dev_handle);
  +=09if (!usb_endpoint_xfer_isoc(&urb->ep->desc)) {
+=09=09status =3D mausb_canceltransfer_event_to_user(ep_ctx->ma_dev,
+=09=09=09=09=09=09=09    ep_ctx->dev_handle,
+=09=09=09=09=09=09=09    ep_ctx->ep_handle,
+=09=09=09=09=09=09=09    (u64)urb);
+=09=09if (status < 0) {
+=09=09=09mausb_pr_err("Failed to enqueue cancel transfer to user");
+=09=09=09goto complete_urb;
+=09=09}
+=09}
+
  =09memset(&mausb_event, 0, sizeof(mausb_event));
   =09mausb_event.type   =3D MAUSB_EVENT_TYPE_DELETE_DATA_TRANSFER;
@@ -855,6 +1129,13 @@ static void mausb_execute_urb_dequeue(struct=20
work_struct *dequeue_work)
  =09=09=09=09=09=09MAUSB_DATA_MSG_DIRECTION_IN :
  =09=09=09=09=09=09MAUSB_DATA_MSG_DIRECTION_OUT);
  +=09status =3D mausb_enqueue_event_to_user(ep_ctx->ma_dev, &mausb_event);
+=09if (status < 0) {
+=09=09mausb_pr_alert("Failed to enqueue event to user-space ep_handle=3D%#=
x,=20
status=3D%d",
+=09=09=09       mausb_event.data.ep_handle, status);
+=09=09goto complete_urb;
+=09}
+
  =09if (!mausb_return_urb_ctx_to_tree(urb_ctx, false)) {
  =09=09mausb_pr_alert("Failed to insert in tree urb=3D%p ep_handle=3D%#x,=
=20
status=3D%d",
  =09=09=09       urb, mausb_event.data.ep_handle, status);
@@ -916,6 +1197,7 @@ void mausb_deinitialize_mss(void)
   =09wait_for_completion(&mss.empty);
  =09mausb_pr_debug("Waiting for completion on disconnect_event ended");
+=09mausb_stop_ring_events();
   =09timeout =3D wait_for_completion_timeout(&mss.client_stopped, timeout)=
;
  =09mausb_pr_info("Remaining time after waiting for stopping client %ld",
@@ -1104,7 +1386,6 @@ int mausb_send_transfer_ack(struct mausb_device=20
*dev, struct mausb_event *event)
  int mausb_send_data_msg(struct mausb_device *dev, struct mausb_event=20
*event)
  {
  =09struct mausb_urb_ctx *urb_ctx;
-=09int status =3D 0;
   =09if (event->status !=3D 0) {
  =09=09mausb_pr_err("Event %d failed with status %d",
@@ -1119,10 +1400,9 @@ int mausb_send_data_msg(struct mausb_device *dev,=20
struct mausb_event *event)
  =09=09/* Transfer will be deleted from dequeue task */
  =09=09mausb_pr_warn("Urb is already cancelled for event=3D%d",
  =09=09=09      event->type);
-=09=09return status;
  =09}
  -=09return status;
+=09return 0;
  }
   int mausb_receive_data_msg(struct mausb_device *dev, struct=20
mausb_event *event)
@@ -1143,6 +1423,7 @@ int mausb_receive_data_msg(struct mausb_device=20
*dev, struct mausb_event *event)
  =09urb_ctx =3D mausb_find_urb_in_tree((struct urb *)event->data.urb);
   =09if (!urb_ctx) {
+=09=09/* Transfer will be deleted from dequeue task */
  =09=09mausb_pr_warn("Urb is already cancelled");
  =09}
  @@ -1211,11 +1492,9 @@ static void mausb_init_ip_ctx_helper(struct=20
mausb_device *dev,
  =09=09=09=09     u16 port,
  =09=09=09=09     enum mausb_channel channel)
  {
-=09int status;
-
-=09status =3D mausb_init_ip_ctx(ip_ctx, dev->net_ns,
-=09=09=09=09   dev->dev_addr.ip.address.ip4, port, dev,
-=09=09=09=09   mausb_ip_callback, channel);
+=09int status =3D mausb_init_ip_ctx(ip_ctx, dev->net_ns,
+=09=09=09=09       dev->dev_addr.ip.address.ip4, port, dev,
+=09=09=09=09       mausb_ip_callback, channel);
  =09if (status < 0) {
  =09=09mausb_pr_err("Init ip context failed with error=3D%d", status);
  =09=09queue_work(dev->workq, &dev->socket_disconnect_work);
@@ -1226,8 +1505,8 @@ static void mausb_init_ip_ctx_helper(struct=20
mausb_device *dev,
  =09mausb_ip_connect_async(*ip_ctx);
  }
  -static void mausb_connect_callback(struct mausb_device *dev, enum=20
mausb_channel
-=09=09=09=09channel, int status)
+static void mausb_connect_callback(struct mausb_device *dev,
+=09=09=09=09   enum mausb_channel channel, int status)
  {
  =09struct mausb_device_address *dev_addr =3D &dev->dev_addr;
  @@ -1282,6 +1561,7 @@ static void mausb_connect_callback(struct=20
mausb_device *dev, enum mausb_channel
  =09if (channel =3D=3D MAUSB_ISOCH_CHANNEL) {
  =09=09dev->channel_map[MAUSB_INTR_CHANNEL] =3D
  =09=09=09=09dev->channel_map[MAUSB_CTRL_CHANNEL];
+=09=09mausb_on_madev_connected(dev);
  =09}
  }
  @@ -1308,6 +1588,16 @@ static void mausb_handle_receive_event(struct=20
mausb_device *dev,
  =09}
   =09mausb_reset_connection_timer(dev);
+
+=09status =3D mausb_msg_received_event(&event,
+=09=09=09=09=09  (struct ma_usb_hdr_common *)data,
+=09=09=09=09=09  channel);
+
+=09if (status =3D=3D 0)
+=09=09status =3D mausb_enqueue_event_to_user(dev, &event);
+
+=09if (status < 0)
+=09=09mausb_pr_err("Failed to enqueue, status=3D%d", status);
  }
   void mausb_ip_callback(void *ctx, enum mausb_channel channel,
@@ -1617,3 +1907,148 @@ u32 mausb_data_iterator_length(struct=20
mausb_data_iter *iterator)
  {
  =09return iterator->length;
  }
+
+static int mausb_ring_buffer_get(struct mausb_ring_buffer *ring,
+=09=09=09=09 struct mausb_event *event)
+{
+=09unsigned long flags =3D 0;
+
+=09spin_lock_irqsave(&ring->lock, flags);
+=09if (CIRC_CNT(ring->head, ring->tail, MAUSB_RING_BUFFER_SIZE) < 1) {
+=09=09spin_unlock_irqrestore(&ring->lock, flags);
+=09=09return -ENOSPC;
+=09}
+=09memcpy(event, ring->to_user_buffer + ring->tail, sizeof(*event));
+=09mausb_pr_debug("HEAD=3D%d, TAIL=3D%d", ring->head, ring->tail);
+=09ring->tail =3D (ring->tail + 1) & (MAUSB_RING_BUFFER_SIZE - 1);
+=09mausb_pr_debug("HEAD=3D%d, TAIL=3D%d", ring->head, ring->tail);
+=09spin_unlock_irqrestore(&ring->lock, flags);
+=09return 0;
+}
+
+int mausb_ring_buffer_init(struct mausb_ring_buffer *ring)
+{
+=09unsigned int page_order =3D
+=09=09mausb_get_page_order(2 * MAUSB_RING_BUFFER_SIZE,
+=09=09=09=09     sizeof(struct mausb_event));
+=09ring->to_user_buffer =3D
+=09=09(struct mausb_event *)__get_free_pages(GFP_KERNEL, page_order);
+=09if (!ring->to_user_buffer)
+=09=09return -ENOMEM;
+=09ring->from_user_buffer =3D ring->to_user_buffer + MAUSB_RING_BUFFER_SIZ=
E;
+=09ring->head =3D 0;
+=09ring->tail =3D 0;
+=09ring->current_from_user =3D 0;
+=09ring->buffer_full =3D false;
+=09spin_lock_init(&ring->lock);
+
+=09return 0;
+}
+
+int mausb_ring_buffer_put(struct mausb_ring_buffer *ring,
+=09=09=09  struct mausb_event *event)
+{
+=09unsigned long flags =3D 0;
+
+=09spin_lock_irqsave(&ring->lock, flags);
+
+=09if (ring->buffer_full) {
+=09=09mausb_pr_err("Ring buffer is full");
+=09=09spin_unlock_irqrestore(&ring->lock, flags);
+=09=09return -ENOSPC;
+=09}
+
+=09if (CIRC_SPACE(ring->head, ring->tail, MAUSB_RING_BUFFER_SIZE) < 2) {
+=09=09mausb_pr_err("Ring buffer capacity exceeded, disconnecting device");
+=09=09ring->buffer_full =3D true;
+=09=09mausb_disconect_event_unsafe(ring, event->madev_addr);
+=09=09ring->head =3D (ring->head + 1) & (MAUSB_RING_BUFFER_SIZE - 1);
+=09=09spin_unlock_irqrestore(&ring->lock, flags);
+=09=09return -ENOSPC;
+=09}
+=09memcpy(ring->to_user_buffer + ring->head, event, sizeof(*event));
+=09mausb_pr_debug("HEAD=3D%d, TAIL=3D%d", ring->head, ring->tail);
+=09ring->head =3D (ring->head + 1) & (MAUSB_RING_BUFFER_SIZE - 1);
+=09mausb_pr_debug("HEAD=3D%d, TAIL=3D%d", ring->head, ring->tail);
+=09spin_unlock_irqrestore(&ring->lock, flags);
+=09return 0;
+}
+
+int mausb_ring_buffer_move_tail(struct mausb_ring_buffer *ring, u32 count)
+{
+=09unsigned long flags =3D 0;
+
+=09spin_lock_irqsave(&ring->lock, flags);
+=09if (CIRC_CNT(ring->head, ring->tail, MAUSB_RING_BUFFER_SIZE) < count) {
+=09=09spin_unlock_irqrestore(&ring->lock, flags);
+=09=09return -ENOSPC;
+=09}
+=09mausb_pr_debug("old HEAD=3D%d, TAIL=3D%d", ring->head, ring->tail);
+=09ring->tail =3D (ring->tail + (int)count) & (MAUSB_RING_BUFFER_SIZE - 1)=
;
+=09mausb_pr_debug("new HEAD=3D%d, TAIL=3D%d", ring->head, ring->tail);
+=09spin_unlock_irqrestore(&ring->lock, flags);
+=09return 0;
+}
+
+void mausb_ring_buffer_cleanup(struct mausb_ring_buffer *ring)
+{
+=09struct mausb_event event;
+
+=09while (mausb_ring_buffer_get(ring, &event) =3D=3D 0)
+=09=09mausb_cleanup_ring_buffer_event(&event);
+}
+
+void mausb_ring_buffer_destroy(struct mausb_ring_buffer *ring)
+{
+=09unsigned int page_order =3D
+=09=09mausb_get_page_order(2 * MAUSB_RING_BUFFER_SIZE,
+=09=09=09=09     sizeof(struct mausb_event));
+=09if (ring && ring->to_user_buffer)
+=09=09free_pages((unsigned long)ring->to_user_buffer, page_order);
+}
+
+void mausb_cleanup_ring_buffer_event(struct mausb_event *event)
+{
+=09mausb_pr_debug("event=3D%d", event->type);
+=09switch (event->type) {
+=09case MAUSB_EVENT_TYPE_SEND_DATA_MSG:
+=09=09mausb_cleanup_send_data_msg_event(event);
+=09=09break;
+=09case MAUSB_EVENT_TYPE_RECEIVED_DATA_MSG:
+=09=09mausb_cleanup_received_data_msg_event(event);
+=09=09break;
+=09case MAUSB_EVENT_TYPE_DELETE_DATA_TRANSFER:
+=09=09mausb_cleanup_delete_data_transfer_event(event);
+=09=09break;
+=09case MAUSB_EVENT_TYPE_NONE:
+=09=09break;
+=09default:
+=09=09mausb_pr_warn("Unknown event type");
+=09=09break;
+=09}
+}
+
+void mausb_disconect_event_unsafe(struct mausb_ring_buffer *ring,
+=09=09=09=09  uint8_t madev_addr)
+{
+=09struct mausb_event disconnect_event;
+=09struct mausb_device *dev =3D mausb_get_dev_from_addr_unsafe(madev_addr)=
;
+
+=09if (!dev) {
+=09=09mausb_pr_err("Device not found, madev_addr=3D%#x", madev_addr);
+=09=09return;
+=09}
+
+=09disconnect_event.type =3D MAUSB_EVENT_TYPE_DEV_DISCONNECT;
+=09disconnect_event.status =3D -EINVAL;
+=09disconnect_event.madev_addr =3D madev_addr;
+
+=09memcpy(ring->to_user_buffer + ring->head, &disconnect_event,
+=09       sizeof(disconnect_event));
+
+=09mausb_pr_info("Disconnect event added to ring buffer for madev_addr=3D%=
#x",
+=09=09      madev_addr);
+=09mausb_pr_info("Adding hcd_disconnect_work to dev workq, madev_addr=3D%#=
x",
+=09=09      madev_addr);
+=09queue_work(dev->workq, &dev->hcd_disconnect_work);
+}
diff --git a/drivers/usb/mausb_host/hpal.h b/drivers/usb/mausb_host/hpal.h
index a04ed120ba5e..24846d4bc4a3 100644
--- a/drivers/usb/mausb_host/hpal.h
+++ b/drivers/usb/mausb_host/hpal.h
@@ -67,6 +67,7 @@ struct mss {
  struct mausb_device {
  =09struct mausb_device_address dev_addr;
  =09struct net=09=09    *net_ns;
+=09struct mausb_ring_buffer    *ring_buffer;
  =09struct list_head=09    list_entry;
   =09struct mausb_ip_ctx *mgmt_channel;
@@ -133,6 +134,10 @@ static inline u64 mausb_event_id(struct=20
mausb_device *dev)
   int mausb_initiate_dev_connection(struct mausb_device_address=20
device_address,
  =09=09=09=09  u8 madev_address);
+int mausb_enqueue_event_from_user(u8 madev_addr, u16 num_of_events,
+=09=09=09=09  u16 num_of_completed);
+int mausb_enqueue_event_to_user(struct mausb_device *dev,
+=09=09=09=09struct mausb_event *event);
  int mausb_data_req_enqueue_event(struct mausb_device *dev, u16 ep_handle,
  =09=09=09=09 struct urb *request);
  int mausb_signal_event(struct mausb_device *dev, struct mausb_event=20
*event,
@@ -282,6 +287,33 @@ void mausb_reset_data_iterator(struct=20
mausb_data_iter *iterator);
  void mausb_uninit_data_iterator(struct mausb_data_iter *iterator);
  void mausb_data_iterator_seek(struct mausb_data_iter *iterator, u32=20
seek_delta);
  +struct mausb_ring_buffer {
+=09atomic_t mausb_ring_events;
+=09atomic_t mausb_completed_user_events;
+
+=09struct mausb_event *to_user_buffer;
+=09int=09=09head;
+=09int=09=09tail;
+=09spinlock_t=09lock; /* Protect ring buffer */
+=09u64=09=09id;
+
+=09struct mausb_event *from_user_buffer;
+=09int current_from_user;
+
+=09struct list_head list_entry;
+=09bool buffer_full;
+};
+
+int mausb_ring_buffer_init(struct mausb_ring_buffer *ring);
+int mausb_ring_buffer_put(struct mausb_ring_buffer *ring,
+=09=09=09  struct mausb_event *event);
+int mausb_ring_buffer_move_tail(struct mausb_ring_buffer *ring, u32 count)=
;
+void mausb_ring_buffer_cleanup(struct mausb_ring_buffer *ring);
+void mausb_ring_buffer_destroy(struct mausb_ring_buffer *ring);
+void mausb_cleanup_ring_buffer_event(struct mausb_event *event);
+void mausb_disconect_event_unsafe(struct mausb_ring_buffer *ring,
+=09=09=09=09  uint8_t madev_addr);
+
  static inline unsigned int mausb_get_page_order(unsigned int num_of_elems=
,
  =09=09=09=09=09=09unsigned int elem_size)
  {
@@ -292,4 +324,16 @@ static inline unsigned int=20
mausb_get_page_order(unsigned int num_of_elems,
  =09return order;
  }
  +static inline
+struct mausb_event *mausb_ring_current_from_user(struct=20
mausb_ring_buffer *ring)
+{
+=09return ring->from_user_buffer + ring->current_from_user;
+}
+
+static inline void mausb_ring_next_from_user(struct mausb_ring_buffer=20
*ring)
+{
+=09ring->current_from_user =3D (ring->current_from_user + 1) &
+=09=09=09=09  (MAUSB_RING_BUFFER_SIZE - 1);
+}
+
  #endif /* __MAUSB_HPAL_H__ */
diff --git a/drivers/usb/mausb_host/hpal_events.c=20
b/drivers/usb/mausb_host/hpal_events.c
new file mode 100644
index 000000000000..6bec951213ea
--- /dev/null
+++ b/drivers/usb/mausb_host/hpal_events.c
@@ -0,0 +1,611 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
+ */
+#include "hpal_events.h"
+
+#include <linux/slab.h>
+
+#include "hcd.h"
+#include "utils.h"
+
+void mausb_dev_reset_req_event(struct mausb_event *event)
+{
+=09event->type =3D MAUSB_EVENT_TYPE_DEV_RESET;
+}
+
+static int mausb_mgmt_msg_received_event(struct mausb_event *event,
+=09=09=09=09=09 struct ma_usb_hdr_common *hdr,
+=09=09=09=09=09 enum mausb_channel channel)
+{
+=09int status =3D 0;
+
+=09mausb_pr_info("channel=3D%d, type=3D%d", channel, hdr->type);
+=09if (hdr->length <=3D MAUSB_MAX_MGMT_SIZE) {
+=09=09event->type =3D MAUSB_EVENT_TYPE_RECEIVED_MGMT_MSG;
+=09=09memcpy(event->mgmt.mgmt_hdr.hdr, hdr, hdr->length);
+=09} else {
+=09=09mausb_pr_err("MGMT message to long, failed to copy");
+=09=09status =3D -EINVAL;
+=09}
+
+=09kfree(hdr);
+=09return status;
+}
+
+static int mausb_data_msg_received_event(struct mausb_event *event,
+=09=09=09=09=09 struct ma_usb_hdr_common *hdr,
+=09=09=09=09=09 enum mausb_channel channel)
+{
+=09event->type=09=09  =3D MAUSB_EVENT_TYPE_RECEIVED_DATA_MSG;
+=09event->data.transfer_type =3D mausb_transfer_type_from_hdr(hdr);
+=09event->data.device_id=09  =3D (u16)((hdr->ssid << 8) | hdr->dev_addr);
+=09event->data.ep_handle=09  =3D hdr->handle.epv;
+=09event->data.recv_buf=09  =3D (u64)hdr;
+
+=09memcpy(event->data.hdr, hdr, MAUSB_TRANSFER_HDR_SIZE);
+
+=09if (mausb_ctrl_transfer(hdr) &&
+=09    hdr->length <=3D 2 * MAUSB_TRANSFER_HDR_SIZE) {
+=09=09memcpy(event->data.hdr_ack,
+=09=09       shift_ptr(hdr, MAUSB_TRANSFER_HDR_SIZE),
+=09=09       (size_t)(hdr->length - MAUSB_TRANSFER_HDR_SIZE));
+=09}
+
+=09return 0;
+}
+
+static int mausb_isoch_msg_received_event(struct mausb_event *event,
+=09=09=09=09=09  struct ma_usb_hdr_common *hdr,
+=09=09=09=09=09  enum mausb_channel channel)
+{
+=09event->type=09=09  =3D MAUSB_EVENT_TYPE_RECEIVED_DATA_MSG;
+=09event->data.transfer_type =3D mausb_transfer_type_from_hdr(hdr);
+=09event->data.device_id=09  =3D (u16)((hdr->ssid << 8) | hdr->dev_addr);
+=09event->data.ep_handle=09  =3D hdr->handle.epv;
+=09event->data.recv_buf=09  =3D (u64)hdr;
+
+=09memcpy(event->data.hdr, hdr, MAUSB_TRANSFER_HDR_SIZE);
+
+=09return 0;
+}
+
+int mausb_msg_received_event(struct mausb_event *event,
+=09=09=09     struct ma_usb_hdr_common *hdr,
+=09=09=09     enum mausb_channel channel)
+{
+=09mausb_pr_debug("channel=3D%d, type=3D%d", channel, hdr->type);
+=09if (mausb_is_management_hdr_type(hdr->type))
+=09=09return mausb_mgmt_msg_received_event(event, hdr, channel);
+=09else if (hdr->type =3D=3D MA_USB_HDR_TYPE_DATA_RESP(TRANSFER))
+=09=09return mausb_data_msg_received_event(event, hdr, channel);
+=09else if (hdr->type =3D=3D MA_USB_HDR_TYPE_DATA_RESP(ISOCHTRANSFER))
+=09=09return mausb_isoch_msg_received_event(event, hdr, channel);
+
+=09kfree(hdr);
+=09mausb_pr_warn("Unknown event type event=3D%d", hdr->type);
+=09return -EBADR;
+}
+
+static void mausb_prepare_completion(struct mausb_completion=20
*mausb_completion,
+=09=09=09=09     struct completion *completion,
+=09=09=09=09     struct mausb_event *event, u64 event_id)
+{
+=09init_completion(completion);
+
+=09mausb_completion->completion_event =3D completion;
+=09mausb_completion->event_id=09   =3D event_id;
+=09mausb_completion->mausb_event=09   =3D event;
+}
+
+static int mausb_wait_for_completion(struct mausb_event *event, u64=20
event_id,
+=09=09=09=09     struct mausb_device *dev)
+{
+=09struct completion=09completion;
+=09struct mausb_completion mausb_completion;
+=09long status;
+=09unsigned long timeout;
+
+=09mausb_prepare_completion(&mausb_completion, &completion, event,
+=09=09=09=09 event_id);
+=09mausb_insert_event(dev, &mausb_completion);
+
+=09status =3D mausb_enqueue_event_to_user(dev, event);
+=09if (status < 0) {
+=09=09mausb_remove_event(dev, &mausb_completion);
+=09=09mausb_pr_err("Ring buffer full, event_id=3D%lld", event_id);
+=09=09return (int)status;
+=09}
+
+=09timeout =3D msecs_to_jiffies(MANAGEMENT_EVENT_TIMEOUT);
+=09status =3D wait_for_completion_interruptible_timeout(&completion,
+=09=09=09=09=09=09=09   timeout);
+
+=09mausb_remove_event(dev, &mausb_completion);
+
+=09if (status =3D=3D 0) {
+=09=09queue_work(dev->workq, &dev->socket_disconnect_work);
+=09=09queue_work(dev->workq, &dev->hcd_disconnect_work);
+=09=09return -ETIMEDOUT;
+=09}
+
+=09return 0;
+}
+
+int mausb_usbdevhandle_event_to_user(struct mausb_device *dev,
+=09=09=09=09     u8 device_speed,
+=09=09=09=09     u32 route_string,
+=09=09=09=09     u16 hub_dev_handle,
+=09=09=09=09     u16 parent_hs_hub_dev_handle,
+=09=09=09=09     u16 parent_hs_hub_port, u16 mtt,
+=09=09=09=09     u8 lse, s32 *usb_dev_handle)
+{
+=09struct mausb_event event;
+=09int status;
+=09u64 event_id =3D mausb_event_id(dev);
+
+=09event.type =3D MAUSB_EVENT_TYPE_USB_DEV_HANDLE;
+=09event.mgmt.dev_handle.device_speed=09 =3D device_speed;
+=09event.mgmt.dev_handle.route_string=09 =3D route_string;
+=09event.mgmt.dev_handle.hub_dev_handle=09 =3D hub_dev_handle;
+=09event.mgmt.dev_handle.parent_hs_hub_port =3D parent_hs_hub_port;
+=09event.mgmt.dev_handle.mtt=09=09 =3D mtt;
+=09event.mgmt.dev_handle.lse=09=09 =3D lse;
+=09event.mgmt.dev_handle.event_id=09=09 =3D event_id;
+=09event.madev_addr=09=09=09 =3D dev->madev_addr;
+=09event.mgmt.dev_handle.parent_hs_hub_dev_handle =3D
+=09=09=09=09=09=09   parent_hs_hub_dev_handle;
+
+=09status =3D mausb_wait_for_completion(&event, event_id, dev);
+
+=09if (status < 0) {
+=09=09mausb_pr_err("Usbdevhandle failed, event_id=3D%lld", event_id);
+=09=09return status;
+=09}
+
+=09if (event.status < 0)
+=09=09return event.status;
+
+=09*usb_dev_handle =3D event.mgmt.dev_handle.dev_handle;
+
+=09return 0;
+}
+
+int mausb_usbdevhandle_event_from_user(struct mausb_device *dev,
+=09=09=09=09       struct mausb_event *event)
+{
+=09return mausb_signal_event(dev, event, event->mgmt.dev_handle.event_id);
+}
+
+int mausb_ephandle_event_to_user(struct mausb_device *dev,
+=09=09=09=09 u16 device_handle,
+=09=09=09=09 u16 descriptor_size, void *descriptor,
+=09=09=09=09 u16 *ep_handle)
+{
+=09struct mausb_event event;
+=09int  status;
+=09u64 event_id =3D mausb_event_id(dev);
+
+=09event.type=09=09=09     =3D MAUSB_EVENT_TYPE_EP_HANDLE;
+=09event.mgmt.ep_handle.device_handle   =3D device_handle;
+=09event.mgmt.ep_handle.descriptor_size =3D descriptor_size;
+=09event.mgmt.ep_handle.event_id=09     =3D event_id;
+=09event.madev_addr=09=09     =3D dev->madev_addr;
+
+=09memcpy(event.mgmt.ep_handle.descriptor, descriptor, descriptor_size);
+
+=09status =3D mausb_wait_for_completion(&event, event_id, dev);
+
+=09if (status < 0) {
+=09=09mausb_pr_err("Ephandle failed, event_id=3D%lld", event_id);
+=09=09return status;
+=09}
+
+=09if (event.status < 0)
+=09=09return event.status;
+
+=09*ep_handle =3D event.mgmt.ep_handle.ep_handle;
+
+=09return 0;
+}
+
+int mausb_ephandle_event_from_user(struct mausb_device *dev,
+=09=09=09=09   struct mausb_event *event)
+{
+=09return mausb_signal_event(dev, event, event->mgmt.ep_handle.event_id);
+}
+
+int mausb_epactivate_event_to_user(struct mausb_device *dev,
+=09=09=09=09   u16 device_handle, u16 ep_handle)
+{
+=09struct mausb_event event;
+=09int  status;
+=09u64 event_id =3D mausb_event_id(dev);
+
+=09event.type =3D MAUSB_EVENT_TYPE_EP_HANDLE_ACTIVATE;
+=09event.mgmt.ep_activate.device_handle =3D device_handle;
+=09event.mgmt.ep_activate.ep_handle     =3D ep_handle;
+=09event.mgmt.ep_activate.event_id=09     =3D event_id;
+=09event.madev_addr=09=09     =3D dev->madev_addr;
+
+=09status =3D mausb_wait_for_completion(&event, event_id, dev);
+
+=09if (status < 0) {
+=09=09mausb_pr_err("Epactivate failed, event_id=3D%lld", event_id);
+=09=09return status;
+=09}
+
+=09return event.status;
+}
+
+int mausb_epactivate_event_from_user(struct mausb_device *dev,
+=09=09=09=09     struct mausb_event *event)
+{
+=09return mausb_signal_event(dev, event,
+=09=09event->mgmt.ep_activate.event_id);
+}
+
+int mausb_epinactivate_event_to_user(struct mausb_device *dev,
+=09=09=09=09     u16 device_handle, u16 ep_handle)
+{
+=09struct mausb_event event;
+=09int  status;
+=09u64 event_id =3D mausb_event_id(dev);
+
+=09event.type =3D MAUSB_EVENT_TYPE_EP_HANDLE_INACTIVATE;
+=09event.mgmt.ep_inactivate.device_handle=09=3D device_handle;
+=09event.mgmt.ep_inactivate.ep_handle=09=3D ep_handle;
+=09event.mgmt.ep_inactivate.event_id=09=3D event_id;
+=09event.madev_addr=09=09=09=3D dev->madev_addr;
+
+=09status =3D mausb_wait_for_completion(&event, event_id, dev);
+
+=09if (status < 0) {
+=09=09mausb_pr_err("Epinactivate failed, event_id=3D%lld", event_id);
+=09=09return status;
+=09}
+
+=09return event.status;
+}
+
+int mausb_epinactivate_event_from_user(struct mausb_device *dev,
+=09=09=09=09       struct mausb_event *event)
+{
+=09return mausb_signal_event(dev, event,
+=09=09=09=09  event->mgmt.ep_inactivate.event_id);
+}
+
+int mausb_epreset_event_to_user(struct mausb_device *dev,
+=09=09=09=09u16 device_handle, u16 ep_handle,
+=09=09=09=09u8 tsp_flag)
+{
+=09struct mausb_event event;
+=09int  status;
+=09u64 event_id =3D mausb_event_id(dev);
+
+=09event.type=09=09=09  =3D MAUSB_EVENT_TYPE_EP_HANDLE_RESET;
+=09event.mgmt.ep_reset.device_handle =3D device_handle;
+=09event.mgmt.ep_reset.ep_handle=09  =3D ep_handle;
+=09event.mgmt.ep_reset.tsp=09=09  =3D tsp_flag;
+=09event.mgmt.ep_reset.event_id=09  =3D event_id;
+=09event.madev_addr=09=09  =3D dev->madev_addr;
+
+=09status =3D mausb_wait_for_completion(&event, event_id, dev);
+
+=09if (status < 0) {
+=09=09mausb_pr_err("Epreset failed, event_id=3D%lld", event_id);
+=09=09return status;
+=09}
+
+=09return event.status;
+}
+
+int mausb_epreset_event_from_user(struct mausb_device *dev,
+=09=09=09=09  struct mausb_event *event)
+{
+=09return mausb_signal_event(dev, event, event->mgmt.ep_reset.event_id);
+}
+
+int mausb_epdelete_event_to_user(struct mausb_device *dev,
+=09=09=09=09 u16 device_handle, u16 ep_handle)
+{
+=09struct mausb_event event;
+=09int  status;
+=09u64 event_id =3D mausb_event_id(dev);
+
+=09event.type=09=09=09   =3D MAUSB_EVENT_TYPE_EP_HANDLE_DELETE;
+=09event.mgmt.ep_delete.device_handle =3D device_handle;
+=09event.mgmt.ep_delete.ep_handle=09   =3D ep_handle;
+=09event.mgmt.ep_delete.event_id=09   =3D event_id;
+=09event.madev_addr=09=09   =3D dev->madev_addr;
+
+=09status =3D mausb_wait_for_completion(&event, event_id, dev);
+
+=09if (status < 0) {
+=09=09mausb_pr_err("Epdelete failed, event_id=3D%lld", event_id);
+=09=09return status;
+=09}
+
+=09return event.status;
+}
+
+int mausb_epdelete_event_from_user(struct mausb_device *dev,
+=09=09=09=09   struct mausb_event *event)
+{
+=09return mausb_signal_event(dev, event, event->mgmt.ep_delete.event_id);
+}
+
+int mausb_modifyep0_event_to_user(struct mausb_device *dev,
+=09=09=09=09  u16 device_handle, u16 *ep_handle,
+=09=09=09=09  __le16 max_packet_size)
+{
+=09struct mausb_event event;
+=09int  status;
+=09u64 event_id =3D mausb_event_id(dev);
+
+=09event.type=09=09=09=09=3D MAUSB_EVENT_TYPE_MODIFY_EP0;
+=09event.mgmt.modify_ep0.device_handle=09=3D device_handle;
+=09event.mgmt.modify_ep0.ep_handle=09=09=3D *ep_handle;
+=09event.mgmt.modify_ep0.max_packet_size=09=3D max_packet_size;
+=09event.mgmt.modify_ep0.event_id=09=09=3D event_id;
+=09event.madev_addr=09=09=09=3D dev->madev_addr;
+
+=09status =3D mausb_wait_for_completion(&event, event_id, dev);
+
+=09if (status < 0) {
+=09=09mausb_pr_err("Modifyep0 failed, event_id=3D%lld", event_id);
+=09=09return status;
+=09}
+
+=09if (event.status < 0)
+=09=09return event.status;
+
+=09*ep_handle =3D event.mgmt.modify_ep0.ep_handle;
+
+=09return 0;
+}
+
+int mausb_modifyep0_event_from_user(struct mausb_device *dev,
+=09=09=09=09    struct mausb_event *event)
+{
+=09return mausb_signal_event(dev, event, event->mgmt.modify_ep0.event_id);
+}
+
+int mausb_setusbdevaddress_event_to_user(struct mausb_device *dev,
+=09=09=09=09=09 u16 device_handle,
+=09=09=09=09=09 u16 response_timeout)
+{
+=09struct mausb_event event;
+=09int  status;
+=09u64 event_id =3D mausb_event_id(dev);
+
+=09event.type =3D MAUSB_EVENT_TYPE_SET_USB_DEV_ADDRESS;
+=09event.mgmt.set_usb_dev_address.device_handle=09=3D device_handle;
+=09event.mgmt.set_usb_dev_address.response_timeout=09=3D response_timeout;
+=09event.mgmt.set_usb_dev_address.event_id=09=09=3D event_id;
+=09event.madev_addr=09=09=09=09=3D dev->madev_addr;
+
+=09status =3D mausb_wait_for_completion(&event, event_id, dev);
+
+=09if (status < 0) {
+=09=09mausb_pr_err("Setusbdevaddress failed, event_id=3D%lld",
+=09=09=09     event_id);
+=09=09return status;
+=09}
+
+=09return event.status;
+}
+
+int mausb_setusbdevaddress_event_from_user(struct mausb_device *dev,
+=09=09=09=09=09   struct mausb_event *event)
+{
+=09return mausb_signal_event(dev, event,
+=09=09event->mgmt.set_usb_dev_address.event_id);
+}
+
+static void
+mausb_init_device_descriptor(struct ma_usb_updatedevreq_desc=20
*update_descriptor,
+=09=09=09     struct usb_device_descriptor *device_descriptor)
+{
+=09update_descriptor->usb20.bLength =3D device_descriptor->bLength;
+=09update_descriptor->usb20.bDescriptorType =3D
+=09=09=09=09=09device_descriptor->bDescriptorType;
+=09update_descriptor->usb20.bcdUSB =3D device_descriptor->bcdUSB;
+=09update_descriptor->usb20.bDeviceClass =3D
+=09=09=09=09=09device_descriptor->bDeviceClass;
+=09update_descriptor->usb20.bDeviceSubClass =3D
+=09=09=09=09=09device_descriptor->bDeviceSubClass;
+=09update_descriptor->usb20.bDeviceProtocol =3D
+=09=09=09=09=09device_descriptor->bDeviceProtocol;
+=09update_descriptor->usb20.bMaxPacketSize0 =3D
+=09=09=09=09=09device_descriptor->bMaxPacketSize0;
+=09update_descriptor->usb20.idVendor  =3D device_descriptor->idVendor;
+=09update_descriptor->usb20.idProduct =3D device_descriptor->idProduct;
+=09update_descriptor->usb20.bcdDevice =3D device_descriptor->bcdDevice;
+=09update_descriptor->usb20.iManufacturer =3D
+=09=09=09=09=09device_descriptor->iManufacturer;
+=09update_descriptor->usb20.iProduct  =3D device_descriptor->iProduct;
+=09update_descriptor->usb20.iSerialNumber =3D
+=09=09=09=09=09device_descriptor->iSerialNumber;
+=09update_descriptor->usb20.bNumConfigurations =3D
+=09=09=09=09=09device_descriptor->bNumConfigurations;
+}
+
+int mausb_updatedev_event_to_user(struct mausb_device *dev,
+=09=09=09=09  u16 device_handle,
+=09=09=09=09  u16 max_exit_latency, u8 hub,
+=09=09=09=09  u8 number_of_ports, u8 mtt,
+=09=09=09=09  u8 ttt, u8 integrated_hub_latency,
+=09=09=09=09  struct usb_device_descriptor *dev_descriptor)
+{
+=09struct mausb_event event;
+=09int status;
+=09u64 event_id =3D mausb_event_id(dev);
+
+=09event.type =3D MAUSB_EVENT_TYPE_UPDATE_DEV;
+=09event.mgmt.update_dev.device_handle=09     =3D device_handle;
+=09event.mgmt.update_dev.max_exit_latency=09     =3D max_exit_latency;
+=09event.mgmt.update_dev.hub=09=09     =3D hub;
+=09event.mgmt.update_dev.number_of_ports=09     =3D number_of_ports;
+=09event.mgmt.update_dev.mtt=09=09     =3D mtt;
+=09event.mgmt.update_dev.ttt=09=09     =3D ttt;
+=09event.mgmt.update_dev.integrated_hub_latency =3D integrated_hub_latency=
;
+=09event.mgmt.update_dev.event_id=09=09     =3D event_id;
+=09event.madev_addr=09=09=09     =3D dev->madev_addr;
+
+=09mausb_init_device_descriptor(&event.mgmt.update_dev.update_descriptor,
+=09=09=09=09     dev_descriptor);
+
+=09status =3D mausb_wait_for_completion(&event, event_id, dev);
+
+=09if (status < 0) {
+=09=09mausb_pr_err("Updatedev failed, event_id=3D%lld", event_id);
+=09=09return status;
+=09}
+
+=09return event.status;
+}
+
+int mausb_updatedev_event_from_user(struct mausb_device *dev,
+=09=09=09=09    struct mausb_event *event)
+{
+=09return mausb_signal_event(dev, event, event->mgmt.update_dev.event_id);
+}
+
+int mausb_usbdevdisconnect_event_to_user(struct mausb_device *dev,
+=09=09=09=09=09 u16 dev_handle)
+{
+=09struct mausb_event event;
+=09int status;
+
+=09event.type =3D MAUSB_EVENT_TYPE_USB_DEV_DISCONNECT;
+=09event.mgmt.usb_dev_disconnect.device_handle =3D dev_handle;
+=09event.madev_addr=09=09=09    =3D dev->madev_addr;
+
+=09status =3D mausb_enqueue_event_to_user(dev, &event);
+=09if (status < 0)
+=09=09mausb_pr_err("Ring buffer full, usbdevdisconnect failed");
+
+=09return status;
+}
+
+int mausb_ping_event_to_user(struct mausb_device *dev)
+{
+=09struct mausb_event event;
+=09int status;
+
+=09event.type=09 =3D MAUSB_EVENT_TYPE_PING;
+=09event.madev_addr =3D dev->madev_addr;
+
+=09status =3D mausb_enqueue_event_to_user(dev, &event);
+=09if (status < 0)
+=09=09mausb_pr_err("Ring buffer full, devdisconnect failed");
+
+=09return status;
+}
+
+__attribute__((unused))
+static int mausb_devdisconnect_event_to_user(struct mausb_device *dev)
+{
+=09struct mausb_event event;
+=09int status;
+
+=09event.type=09 =3D MAUSB_EVENT_TYPE_DEV_DISCONNECT;
+=09event.madev_addr =3D dev->madev_addr;
+
+=09status =3D mausb_enqueue_event_to_user(dev, &event);
+=09if (status < 0)
+=09=09mausb_pr_err("Ring buffer full, devdisconnect failed");
+
+=09return status;
+}
+
+int mausb_usbdevreset_event_to_user(struct mausb_device *dev,
+=09=09=09=09    u16 device_handle)
+{
+=09struct mausb_event event;
+=09int  status;
+=09u64 event_id =3D mausb_event_id(dev);
+
+=09event.type=09=09=09       =3D MAUSB_EVENT_TYPE_USB_DEV_RESET;
+=09event.mgmt.usb_dev_reset.device_handle =3D device_handle;
+=09event.mgmt.usb_dev_reset.event_id      =3D event_id;
+=09event.madev_addr=09=09       =3D dev->madev_addr;
+
+=09status =3D mausb_wait_for_completion(&event, event_id, dev);
+
+=09if (status < 0) {
+=09=09mausb_pr_err("Usbdevreset failed, event_id=3D%lld", event_id);
+=09=09return status;
+=09}
+
+=09return event.status;
+}
+
+int mausb_usbdevreset_event_from_user(struct mausb_device *dev,
+=09=09=09=09      struct mausb_event *event)
+{
+=09return mausb_signal_event(dev, event,
+=09=09=09=09  event->mgmt.usb_dev_reset.event_id);
+}
+
+int mausb_canceltransfer_event_to_user(struct mausb_device *dev,
+=09=09=09=09       u16 device_handle,
+=09=09=09=09       u16 ep_handle, u64 urb)
+{
+=09struct mausb_event event;
+=09int status;
+
+=09event.type =3D MAUSB_EVENT_TYPE_CANCEL_TRANSFER;
+=09event.mgmt.cancel_transfer.device_handle =3D device_handle;
+=09event.mgmt.cancel_transfer.ep_handle=09 =3D ep_handle;
+=09event.mgmt.cancel_transfer.urb=09=09 =3D urb;
+=09event.madev_addr=09=09=09 =3D dev->madev_addr;
+
+=09status =3D mausb_enqueue_event_to_user(dev, &event);
+=09if (status < 0) {
+=09=09mausb_pr_err("Ring buffer full, canceltransfer failed");
+=09=09return status;
+=09}
+
+=09return status;
+}
+
+int mausb_canceltransfer_event_from_user(struct mausb_device *dev,
+=09=09=09=09=09 struct mausb_event *event)
+{
+=09mausb_pr_debug("");
+=09return 0;
+}
+
+void mausb_cleanup_send_data_msg_event(struct mausb_event *event)
+{
+=09mausb_complete_urb(event);
+}
+
+void mausb_cleanup_received_data_msg_event(struct mausb_event *event)
+{
+=09mausb_release_event_resources(event);
+}
+
+void mausb_cleanup_delete_data_transfer_event(struct mausb_event *event)
+{
+=09struct urb *urb =3D (struct urb *)event->data.urb;
+=09struct mausb_urb_ctx *urb_ctx;
+=09int status =3D 0;
+
+=09urb_ctx =3D mausb_unlink_and_delete_urb_from_tree(urb, status);
+=09if (!urb_ctx) {
+=09=09mausb_pr_warn("Urb=3D%p is not in tree", urb);
+=09=09return;
+=09}
+
+=09/* Deallocate urb_ctx */
+=09mausb_uninit_data_iterator(&urb_ctx->iterator);
+=09kfree(urb_ctx);
+
+=09urb->status =3D -EPROTO;
+=09urb->actual_length =3D 0;
+=09atomic_dec(&urb->use_count);
+=09usb_hcd_giveback_urb(urb->hcpriv, urb, urb->status);
+}
diff --git a/drivers/usb/mausb_host/hpal_events.h=20
b/drivers/usb/mausb_host/hpal_events.h
new file mode 100644
index 000000000000..fb424d526b12
--- /dev/null
+++ b/drivers/usb/mausb_host/hpal_events.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
+ */
+#ifndef __MAUSB_HPAL_EVENTS_H__
+#define __MAUSB_HPAL_EVENTS_H__
+
+#include "hpal.h"
+#include "ip_link.h"
+#include "mausb_event.h"
+
+#define MANAGEMENT_EVENT_TIMEOUT 3000
+
+int mausb_msg_received_event(struct mausb_event *event,
+=09=09=09     struct ma_usb_hdr_common *hdr,
+=09=09=09     enum mausb_channel channel);
+int mausb_usbdevhandle_event_to_user(struct mausb_device *dev,
+=09=09=09=09     u8 device_speed,
+=09=09=09=09     u32 route_string,
+=09=09=09=09     u16 hub_dev_handle,
+=09=09=09=09     u16 parent_hs_hub_dev_handle,
+=09=09=09=09     u16 parent_hs_hub_port, u16 mtt,
+=09=09=09=09     u8 lse, s32 *usb_dev_handle);
+int mausb_usbdevhandle_event_from_user(struct mausb_device *dev,
+=09=09=09=09       struct mausb_event *event);
+int mausb_ephandle_event_to_user(struct mausb_device *dev, u16=20
device_handle,
+=09=09=09=09 u16 descriptor_size, void *descriptor,
+=09=09=09=09 u16 *ep_handle);
+int mausb_ephandle_event_from_user(struct mausb_device *dev,
+=09=09=09=09   struct mausb_event *event);
+int mausb_epactivate_event_to_user(struct mausb_device *dev,
+=09=09=09=09   u16 device_handle, u16 ep_handle);
+int mausb_epactivate_event_from_user(struct mausb_device *dev,
+=09=09=09=09     struct mausb_event *event);
+int mausb_epinactivate_event_to_user(struct mausb_device *dev,
+=09=09=09=09     u16 device_handle,
+=09=09=09=09     u16 ep_handle);
+int mausb_epinactivate_event_from_user(struct mausb_device *dev,
+=09=09=09=09       struct mausb_event *event);
+int mausb_epreset_event_to_user(struct mausb_device *dev,
+=09=09=09=09u16 device_handle, u16 ep_handle,
+=09=09=09=09u8 tsp_flag);
+int mausb_epreset_event_from_user(struct mausb_device *dev,
+=09=09=09=09  struct mausb_event *event);
+int mausb_epdelete_event_to_user(struct mausb_device *dev,
+=09=09=09=09 u16 device_handle, u16 ep_handle);
+int mausb_epdelete_event_from_user(struct mausb_device *dev,
+=09=09=09=09   struct mausb_event *event);
+int mausb_modifyep0_event_to_user(struct mausb_device *dev,
+=09=09=09=09  u16 device_handle, u16 *ep_handle,
+=09=09=09=09  __le16 max_packet_size);
+int mausb_modifyep0_event_from_user(struct mausb_device *dev,
+=09=09=09=09    struct mausb_event *event);
+int mausb_setusbdevaddress_event_to_user(struct mausb_device *dev,
+=09=09=09=09=09 u16 device_handle,
+=09=09=09=09=09 u16 response_timeout);
+int mausb_setusbdevaddress_event_from_user(struct mausb_device *dev,
+=09=09=09=09=09   struct mausb_event *event);
+int mausb_updatedev_event_to_user(struct mausb_device *dev,
+=09=09=09=09  u16 device_handle,
+=09=09=09=09  u16 max_exit_latency, u8 hub,
+=09=09=09=09  u8 number_of_ports, u8 mtt,
+=09=09=09=09  u8 ttt, u8 integrated_hub_latency,
+=09=09=09=09  struct usb_device_descriptor *dev_descriptor);
+int mausb_updatedev_event_from_user(struct mausb_device *dev,
+=09=09=09=09    struct mausb_event *event);
+int mausb_usbdevdisconnect_event_to_user(struct mausb_device *dev,
+=09=09=09=09=09 u16 dev_handle);
+int mausb_ping_event_to_user(struct mausb_device *dev);
+int mausb_usbdevreset_event_to_user(struct mausb_device *dev,
+=09=09=09=09    u16 device_handle);
+int mausb_usbdevreset_event_from_user(struct mausb_device *dev,
+=09=09=09=09      struct mausb_event *event);
+int mausb_canceltransfer_event_to_user(struct mausb_device *dev,
+=09=09=09=09       u16 device_handle,
+=09=09=09=09       u16 ep_handle, u64 urb);
+int mausb_canceltransfer_event_from_user(struct mausb_device *dev,
+=09=09=09=09=09 struct mausb_event *event);
+
+void mausb_dev_reset_req_event(struct mausb_event *event);
+void mausb_cleanup_send_data_msg_event(struct mausb_event *event);
+void mausb_cleanup_received_data_msg_event(struct mausb_event *event);
+void mausb_cleanup_delete_data_transfer_event(struct mausb_event *event);
+
+#endif /* __MAUSB_HPAL_EVENTS_H__ */
diff --git a/drivers/usb/mausb_host/mausb_driver_status.h=20
b/drivers/usb/mausb_host/mausb_driver_status.h
new file mode 100644
index 000000000000..9b55befe9cae
--- /dev/null
+++ b/drivers/usb/mausb_host/mausb_driver_status.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
+ */
+#ifndef __MAUSB_MAUSB_DRIVER_STATUS_H__
+#define __MAUSB_MAUSB_DRIVER_STATUS_H__
+
+#define MAUSB_DRIVER_BAD_READ_BUFFER_SIZE  -1
+#define MAUSB_DRIVER_RING_EVENTS_STOPPED   -2
+#define MAUSB_DRIVER_SYSTEM_SUSPENDED      -3
+#define MAUSB_DRIVER_COPY_TO_BUFFER_FAILED -4
+
+#define MAUSB_DRIVER_READ_TIMEOUT 0
+#define MAUSB_DRIVER_READ_ERROR  -1
+#define MAUSB_DRIVER_WRITE_ERROR  -2
+
+#endif /* __MAUSB_MAUSB_DRIVER_STATUS_H__ */
diff --git a/drivers/usb/mausb_host/utils.c b/drivers/usb/mausb_host/utils.=
c
index c055b578e402..643671821709 100644
--- a/drivers/usb/mausb_host/utils.c
+++ b/drivers/usb/mausb_host/utils.c
@@ -13,6 +13,8 @@
  #include <linux/slab.h>
  #include <linux/uaccess.h>
  +#include "mausb_driver_status.h"
+
  #define MAUSB_KERNEL_DEV_NAME "mausb_host"
  #define MAUSB_READ_DEVICE_TIMEOUT_MS 500
  @@ -20,6 +22,47 @@ static dev_t mausb_major_kernel;
  static struct cdev  mausb_kernel_dev;
  static struct class *mausb_kernel_class;
  +static void mausb_vm_open(struct vm_area_struct *vma)
+{
+=09mausb_pr_debug("");
+}
+
+static void mausb_vm_close(struct vm_area_struct *vma)
+{
+=09struct mausb_ring_buffer *buffer =3D NULL, *next =3D NULL;
+=09unsigned long flags =3D 0;
+=09u64 ring_buffer_id =3D *(u64 *)(vma->vm_private_data);
+
+=09mausb_pr_info("Releasing ring buffer with id: %llu", ring_buffer_id);
+=09spin_lock_irqsave(&mss.lock, flags);
+=09list_for_each_entry_safe(buffer, next, &mss.available_ring_buffers,
+=09=09=09=09 list_entry) {
+=09=09if (buffer->id =3D=3D ring_buffer_id) {
+=09=09=09list_del(&buffer->list_entry);
+=09=09=09mausb_ring_buffer_destroy(buffer);
+=09=09=09kfree(buffer);
+=09=09=09break;
+=09=09}
+=09}
+=09spin_unlock_irqrestore(&mss.lock, flags);
+}
+
+/*
+ * mausb_vm_fault is called the first time a memory area is accessed=20
which is
+ * not in memory
+ */
+static vm_fault_t mausb_vm_fault(struct vm_fault *vmf)
+{
+=09mausb_pr_debug("");
+=09return 0;
+}
+
+static const struct vm_operations_struct mausb_vm_ops =3D {
+=09.open  =3D mausb_vm_open,
+=09.close =3D mausb_vm_close,
+=09.fault =3D mausb_vm_fault,
+};
+
  static int mausb_file_open(struct inode *inode, struct file *filp)
  {
  =09filp->private_data =3D NULL;
@@ -35,9 +78,215 @@ static int mausb_file_close(struct inode *inode,=20
struct file *filp)
  =09return 0;
  }
  +static ssize_t mausb_file_read(struct file *filp, char __user=20
*user_buffer,
+=09=09=09       size_t size, loff_t *offset)
+{
+=09ssize_t num_of_bytes_to_read =3D MAUSB_MAX_NUM_OF_MA_DEVS *
+=09=09=09=09       sizeof(struct mausb_events_notification);
+=09unsigned long num_of_bytes_not_copied;
+=09int completed_events;
+=09int ring_events;
+=09struct mausb_ring_buffer *ring_buffer;
+=09struct mausb_device=09 *dev;
+=09struct completion=09 *ring_has_events;
+=09u8 current_device =3D 0;
+=09s8 fail_ret_val;
+=09unsigned long flags;
+=09unsigned long timeout;
+=09long status;
+
+=09/* Reset heartbeat timer events */
+=09mausb_reset_heartbeat_cnt();
+
+=09if ((ssize_t)size !=3D num_of_bytes_to_read) {
+=09=09mausb_pr_alert("Different expected bytes to read (%ld) from actual=
=20
size (%ld)",
+=09=09=09       num_of_bytes_to_read, size);
+=09=09fail_ret_val =3D MAUSB_DRIVER_BAD_READ_BUFFER_SIZE;
+=09=09if (copy_to_user(user_buffer, &fail_ret_val,
+=09=09=09=09 sizeof(fail_ret_val)) !=3D 0) {
+=09=09=09mausb_pr_warn("Failed to set error code.");
+=09=09}
+=09=09return MAUSB_DRIVER_READ_ERROR;
+=09}
+
+=09/* If suspend/hibernate happened delete all devices */
+=09if (atomic_xchg(&mss.num_of_transitions_to_sleep, 0)) {
+=09=09mausb_pr_alert("Suspend system event detected");
+=09=09fail_ret_val =3D MAUSB_DRIVER_SYSTEM_SUSPENDED;
+=09=09if (copy_to_user(user_buffer, &fail_ret_val,
+=09=09=09=09 sizeof(fail_ret_val)) !=3D 0) {
+=09=09=09mausb_pr_warn("Failed to set error code.");
+=09=09}
+=09=09return MAUSB_DRIVER_READ_ERROR;
+=09}
+
+=09ring_has_events =3D &mss.rings_events.mausb_ring_has_events;
+=09timeout =3D msecs_to_jiffies(MAUSB_READ_DEVICE_TIMEOUT_MS);
+=09status =3D wait_for_completion_interruptible_timeout(ring_has_events,
+=09=09=09=09=09=09=09   timeout);
+=09reinit_completion(ring_has_events);
+
+=09if (atomic_read(&mss.rings_events.mausb_stop_reading_ring_events)) {
+=09=09mausb_pr_alert("Ring events stopped");
+=09=09fail_ret_val =3D MAUSB_DRIVER_RING_EVENTS_STOPPED;
+=09=09if (copy_to_user(user_buffer, &fail_ret_val,
+=09=09=09=09 sizeof(fail_ret_val)) !=3D 0) {
+=09=09=09mausb_pr_warn("Failed to set error code.");
+=09=09}
+=09=09return MAUSB_DRIVER_READ_ERROR;
+=09}
+
+=09/* There are no new events - waiting for events hit timeout */
+=09if (status =3D=3D 0)
+=09=09return MAUSB_DRIVER_READ_TIMEOUT;
+
+=09spin_lock_irqsave(&mss.lock, flags);
+
+=09list_for_each_entry(dev, &mss.madev_list, list_entry) {
+=09=09mss.events[current_device].madev_addr =3D dev->madev_addr;
+=09=09ring_buffer =3D dev->ring_buffer;
+=09=09ring_events =3D atomic_xchg(&ring_buffer->mausb_ring_events, 0);
+=09=09completed_events =3D
+=09=09=09atomic_xchg(&ring_buffer->mausb_completed_user_events,
+=09=09=09=09    0);
+=09=09mss.events[current_device].num_of_events =3D (u16)ring_events;
+=09=09mss.events[current_device].num_of_completed_events =3D
+=09=09=09=09(u16)completed_events;
+=09=09if (++current_device =3D=3D MAUSB_MAX_NUM_OF_MA_DEVS)
+=09=09=09break;
+=09}
+
+=09spin_unlock_irqrestore(&mss.lock, flags);
+
+=09num_of_bytes_to_read =3D
+=09=09(ssize_t)(current_device *
+=09=09=09  sizeof(struct mausb_events_notification));
+=09num_of_bytes_not_copied =3D
+=09=09copy_to_user(user_buffer, &mss.events,
+=09=09=09     (unsigned long)num_of_bytes_to_read);
+
+=09mausb_pr_debug("num_of_bytes_not_copied %ld, num_of_bytes_to_read %ld",
+=09=09       num_of_bytes_not_copied, num_of_bytes_to_read);
+
+=09if (num_of_bytes_not_copied) {
+=09=09fail_ret_val =3D MAUSB_DRIVER_COPY_TO_BUFFER_FAILED;
+=09=09if (copy_to_user(user_buffer, &fail_ret_val,
+=09=09=09=09 sizeof(fail_ret_val)) !=3D 0) {
+=09=09=09mausb_pr_warn("Failed to set error code.");
+=09=09}
+=09=09return MAUSB_DRIVER_READ_ERROR;
+=09}
+
+=09return num_of_bytes_to_read;
+}
+
+static ssize_t mausb_file_write(struct file *filp, const char __user=20
*buffer,
+=09=09=09=09size_t size, loff_t *offset)
+{
+=09ssize_t num_of_bytes_to_write =3D
+=09=09=09=09sizeof(struct mausb_events_notification);
+=09struct mausb_events_notification notification;
+=09unsigned long flags;
+=09struct mausb_device *dev;
+
+=09if (size !=3D (size_t)num_of_bytes_to_write) {
+=09=09mausb_pr_alert("Different expected bytes to write (%ld) from actual=
=20
size (%ld)",
+=09=09=09       num_of_bytes_to_write, size);
+=09=09return MAUSB_DRIVER_WRITE_ERROR;
+=09}
+
+=09if (copy_from_user(&notification, buffer, size))
+=09=09return MAUSB_DRIVER_WRITE_ERROR;
+
+=09spin_lock_irqsave(&mss.lock, flags);
+=09dev =3D mausb_get_dev_from_addr_unsafe(notification.madev_addr);
+
+=09if (!dev) {
+=09=09spin_unlock_irqrestore(&mss.lock, flags);
+=09=09return 0;
+=09}
+
+=09spin_lock_irqsave(&dev->num_of_user_events_lock, flags);
+=09dev->num_of_user_events +=3D notification.num_of_events;
+=09dev->num_of_completed_events +=3D notification.num_of_completed_events;
+=09spin_unlock_irqrestore(&dev->num_of_user_events_lock, flags);
+
+=09queue_work(dev->workq, &dev->work);
+=09spin_unlock_irqrestore(&mss.lock, flags);
+
+=09return num_of_bytes_to_write;
+}
+
+static inline unsigned long mausb_ring_buffer_length(void)
+{
+=09int page_order =3D mausb_get_page_order(2 * MAUSB_RING_BUFFER_SIZE,
+=09=09=09=09=09      sizeof(struct mausb_event));
+=09return PAGE_SIZE << page_order;
+}
+
+static int mausb_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+=09unsigned long size =3D vma->vm_end - vma->vm_start;
+=09int ret;
+=09struct page *page =3D NULL;
+=09unsigned long flags =3D 0;
+=09struct mausb_ring_buffer *ring_buffer =3D kzalloc(sizeof(*ring_buffer),
+=09=09=09=09=09=09=09GFP_KERNEL);
+=09if (!ring_buffer)
+=09=09return -ENOMEM;
+
+=09ret =3D mausb_ring_buffer_init(ring_buffer);
+=09if (ret < 0) {
+=09=09mausb_pr_err("Ring buffer init failed");
+=09=09goto release_ring_buffer;
+=09}
+
+=09vma->vm_private_data =3D kzalloc(sizeof(ring_buffer->id), GFP_KERNEL);
+=09if (!vma->vm_private_data) {
+=09=09ret =3D -ENOMEM;
+=09=09goto release_ring_buffer;
+=09}
+
+=09filp->private_data =3D vma->vm_private_data;
+
+=09if (size > mausb_ring_buffer_length()) {
+=09=09mausb_pr_err("Invalid memory size to map");
+=09=09ret =3D -EINVAL;
+=09=09goto release_ring_buffer;
+=09}
+
+=09vma->vm_ops =3D &mausb_vm_ops;
+=09mausb_vm_open(vma);
+
+=09page =3D virt_to_page(ring_buffer->to_user_buffer);
+=09ret =3D remap_pfn_range(vma, vma->vm_start, page_to_pfn(page), size,
+=09=09=09      vma->vm_page_prot);
+=09if (ret < 0) {
+=09=09mausb_pr_err("Could not map the address area");
+=09=09goto release_ring_buffer;
+=09}
+
+=09spin_lock_irqsave(&mss.lock, flags);
+=09ring_buffer->id =3D mss.ring_buffer_id++;
+=09*(u64 *)(vma->vm_private_data) =3D ring_buffer->id;
+=09list_add_tail(&ring_buffer->list_entry, &mss.available_ring_buffers);
+=09mausb_pr_info("Allocated ring buffer with id: %llu", ring_buffer->id);
+=09spin_unlock_irqrestore(&mss.lock, flags);
+
+=09return 0;
+
+release_ring_buffer:
+=09mausb_ring_buffer_destroy(ring_buffer);
+=09kfree(ring_buffer);
+=09return ret;
+}
+
  static const struct file_operations mausb_file_ops =3D {
  =09.open=09 =3D mausb_file_open,
  =09.release =3D mausb_file_close,
+=09.read=09 =3D mausb_file_read,
+=09.write   =3D mausb_file_write,
+=09.mmap=09 =3D mausb_mmap,
  };
   int mausb_create_dev(void)
@@ -83,3 +332,29 @@ void mausb_cleanup_dev(int device_created)
   =09unregister_chrdev_region(mausb_major_kernel, 1);
  }
+
+void mausb_notify_completed_user_events(struct mausb_ring_buffer=20
*ring_buffer)
+{
+=09int completed;
+
+=09completed =3D
+=09=09atomic_inc_return(&ring_buffer->mausb_completed_user_events);
+=09mausb_pr_debug("mausb_completed_user_events INCREMENTED %d", completed)=
;
+=09if (completed > MAUSB_RING_BUFFER_SIZE / 16)
+=09=09complete(&mss.rings_events.mausb_ring_has_events);
+}
+
+void mausb_notify_ring_events(struct mausb_ring_buffer *ring_buffer)
+{
+=09int events;
+
+=09events =3D atomic_inc_return(&ring_buffer->mausb_ring_events);
+=09if (events =3D=3D 1)
+=09=09complete(&mss.rings_events.mausb_ring_has_events);
+}
+
+void mausb_stop_ring_events(void)
+{
+=09atomic_set(&mss.rings_events.mausb_stop_reading_ring_events, 1);
+=09complete(&mss.rings_events.mausb_ring_has_events);
+}
diff --git a/drivers/usb/mausb_host/utils.h b/drivers/usb/mausb_host/utils.=
h
index a5378ee4c4f0..b9b377886bc7 100644
--- a/drivers/usb/mausb_host/utils.h
+++ b/drivers/usb/mausb_host/utils.h
@@ -5,6 +5,8 @@
  #ifndef __MAUSB_UTILS_H__
  #define __MAUSB_UTILS_H__
  +#include "hpal.h"
+
  #if defined(MAUSB_NO_LOGS)
  #define mausb_pr_logs(...)
  #else
@@ -36,5 +38,8 @@
   int mausb_create_dev(void);
  void mausb_cleanup_dev(int device_created);
+void mausb_notify_completed_user_events(struct mausb_ring_buffer=20
*ring_buffer);
+void mausb_notify_ring_events(struct mausb_ring_buffer *ring_buffer);
+void mausb_stop_ring_events(void);
   #endif /* __MAUSB_UTILS_H__ */
--=20
2.17.1


