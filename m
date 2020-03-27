Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F881C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 15:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9804820748
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 15:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=displaylink.com header.i=@displaylink.com header.b="LPIKi+e0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgC0P04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 11:26:56 -0400
Received: from eu-smtp-delivery-167.mimecast.com ([146.101.78.167]:42592 "EHLO
        eu-smtp-delivery-167.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727719AbgC0P0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 11:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=displaylink.com;
        s=mimecast20151025; t=1585322799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2nRAbgDShIjhDIzViT84/Lcnx+IPKT/EAcCTpBnS550=;
        b=LPIKi+e0h9RHdBKRDptYpbRfPkq/PW99yGvZeDxtYRH0Mwu0J2yxo3mtixWHNw2qiNSG4N
        X0/V9QxFEANJYg980vzR6VfbK2oGVdh3n3SWXWZmQWoz3mfA10mQkb7321Q62M4EJ05eJk
        MU2NXDt0s4AxdG6rJ/af6xh2eXy3DuM=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2059.outbound.protection.outlook.com [104.47.14.59]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-231-CPh41yIdNNS1rN37AUHvTA-5; Fri, 27 Mar 2020 15:26:37 +0000
X-MC-Unique: CPh41yIdNNS1rN37AUHvTA-5
Received: from AM0PR10MB3075.EURPRD10.PROD.OUTLOOK.COM (10.255.30.19) by
 AM0PR10MB1939.EURPRD10.PROD.OUTLOOK.COM (52.134.81.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Fri, 27 Mar 2020 15:26:32 +0000
Received: from AM0PR10MB3075.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::991c:987a:8997:3aab]) by AM0PR10MB3075.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::991c:987a:8997:3aab%6]) with mapi id 15.20.2856.019; Fri, 27 Mar 2020
 15:26:32 +0000
From:   vladimir.stankovic@displaylink.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mausb-host-devel@displaylink.com
Subject: [PATCH v4 5/8] usb: mausb_host: Introduce PAL processing
Date:   Fri, 27 Mar 2020 16:26:11 +0100
Message-Id: <20200327152614.26833-6-vladimir.stankovic@displaylink.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200327152614.26833-1-vladimir.stankovic@displaylink.com>
References: <8c24bff9-79a6-ca53-ce8f-fb503163db24@displaylink.com>
 <20200327152614.26833-1-vladimir.stankovic@displaylink.com>
X-ClientProxiedBy: VI1PR10CA0090.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::19) To AM0PR10MB3075.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15f::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from raven-hp.endava.net (94.189.199.177) by VI1PR10CA0090.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:28::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18 via Frontend Transport; Fri, 27 Mar 2020 15:26:30 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [94.189.199.177]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1a75de1-5d82-4e94-3284-08d7d2633972
X-MS-TrafficTypeDiagnostic: AM0PR10MB1939:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR10MB1939F5B4FD350314E496285D91CC0@AM0PR10MB1939.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0355F3A3AE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3075.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39840400004)(396003)(366004)(136003)(376002)(346002)(2906002)(316002)(66946007)(66476007)(5660300002)(4326008)(2616005)(956004)(66556008)(16526019)(6486002)(6666004)(36756003)(186003)(81166006)(81156014)(8676002)(8936002)(107886003)(478600001)(6916009)(1076003)(86362001)(6506007)(6512007)(52116002)(9686003)(30864003)(26005)(579004)(559001);DIR:OUT;SFP:1101;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IV+Z5qGtM9jOGUVJ1XVCH+4fTwpEIP0ksSdQEJ6FADzCZUKSF9SBCpmHaE2aqBaOdrhSyOlWa9gtSaldAsxCSw2HzJ4KSUkm9zBzBiZfi/B1+StzpIOdUT+m5YNmRbEYNeNJ0a84vknNP3GctLpvjr9pYHuHOStUqYUGp9dlGlRsHwDVNRL0EbDw42OsUYE45qv9ys1v29FCTotDecGnqwBkvkb4McDK4m8LudEyQ/qNX6UdQdeULUjl4oOs1aXUvKQB301mmruVoi2B40Usp6RbaAQNgvpJ6KvRUZbo9GvECDt+0tsOLNQQ1idYii2ADE8iXjzwcP227fD1uYGl5+2fOB6ImaEqjCoVf0Why7zAbHOJ7Yf0kZyvJa7vdJX+A0Rlsm4h0bE4uhfC+w26fcaW2l5D1myTt4nIgu149dbm37K4BRe7on102cRGB+bd
X-MS-Exchange-AntiSpam-MessageData: IN3wL9lt9oJB9MSfbVBDewofgH9/YHqhFgbzraqV9+xGPkKn3wdVkGRHN//OzyXkCC8q2pKivTBJSoLCmFR4Y6v4UajYbKNI+ZdSn6I3w7YH4Pub55ONqgK5QddMTm5EjwBxvpc7A+kR0qPZ4RWCMg==
X-OriginatorOrg: displaylink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a75de1-5d82-4e94-3284-08d7d2633972
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2020 15:26:30.7043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4bda75a-b444-4312-9c90-44a7c4b2c91a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p2lRquUvjvnuq9X6NdAsv/zLETxAsamnvrDDk2r+I2PfnDkYWk+MOLjuIkR5Ce16QKGAWkiZX/qrnG4WWiQPkiaAMJHpH6HXKKKKOPamsraj4f21zU+UYKwc0ygYcZaq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB1939
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: displaylink.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Protocol adaptation layer (PAL) implementation has been added to
introduce MA-USB structures and logic.

Signed-off-by: Vladimir Stankovic <vladimir.stankovic@displaylink.com>
---
 drivers/usb/mausb_host/Makefile        |    1 +
 drivers/usb/mausb_host/hcd.c           |  523 ++++++++++-
 drivers/usb/mausb_host/hcd.h           |   11 +
 drivers/usb/mausb_host/hpal.c          | 1094 ++++++++++++++++++++++++
 drivers/usb/mausb_host/hpal.h          |  289 +++++++
 drivers/usb/mausb_host/ma_usb.h        |  869 +++++++++++++++++++
 drivers/usb/mausb_host/mausb_address.h |   26 +
 drivers/usb/mausb_host/mausb_core.c    |   13 +-
 drivers/usb/mausb_host/mausb_event.h   |  224 +++++
 9 files changed, 3040 insertions(+), 10 deletions(-)
 create mode 100644 drivers/usb/mausb_host/hpal.c
 create mode 100644 drivers/usb/mausb_host/hpal.h
 create mode 100644 drivers/usb/mausb_host/ma_usb.h
 create mode 100644 drivers/usb/mausb_host/mausb_address.h
 create mode 100644 drivers/usb/mausb_host/mausb_event.h

diff --git a/drivers/usb/mausb_host/Makefile b/drivers/usb/mausb_host/Makef=
ile
index cce4696682b2..829314b15cbb 100644
--- a/drivers/usb/mausb_host/Makefile
+++ b/drivers/usb/mausb_host/Makefile
@@ -10,5 +10,6 @@ mausb_host-y :=3D mausb_core.o
 mausb_host-y +=3D utils.o
 mausb_host-y +=3D ip_link.o
 mausb_host-y +=3D hcd.o
+mausb_host-y +=3D hpal.o
=20
 ccflags-y +=3D -I$(srctree)/$(src)
diff --git a/drivers/usb/mausb_host/hcd.c b/drivers/usb/mausb_host/hcd.c
index b20d1a36ba34..70cb633c39ba 100644
--- a/drivers/usb/mausb_host/hcd.c
+++ b/drivers/usb/mausb_host/hcd.c
@@ -9,6 +9,7 @@
 #include <linux/limits.h>
 #include <linux/module.h>
=20
+#include "hpal.h"
 #include "utils.h"
=20
 static int mausb_open(struct inode *inode, struct file *file);
@@ -195,6 +196,90 @@ void mausb_deinit_hcd(void)
 =09}
 }
=20
+void mausb_port_has_changed(const enum mausb_device_type device_type,
+=09=09=09    const enum mausb_device_speed device_speed,
+=09=09=09    void *ma_dev)
+{
+=09struct usb_hcd *hcd;
+=09unsigned long flags =3D 0;
+=09struct mausb_device *dev =3D ma_dev;
+=09u16 port_number =3D dev->port_number;
+
+=09spin_lock_irqsave(&mhcd->lock, flags);
+
+=09if (device_type =3D=3D USB20HUB || device_speed < SUPER_SPEED) {
+=09=09mhcd->hcd_hs_ctx->ma_devs[port_number].port_status |=3D
+=09=09    USB_PORT_STAT_CONNECTION | (1 <<
+=09=09=09=09=09=09USB_PORT_FEAT_C_CONNECTION);
+
+=09=09if (device_speed =3D=3D LOW_SPEED) {
+=09=09=09mhcd->hcd_hs_ctx->ma_devs[port_number].port_status |=3D
+=09=09=09    MAUSB_PORT_20_STATUS_LOW_SPEED;
+=09=09=09mhcd->hcd_hs_ctx->ma_devs[port_number].dev_speed =3D
+=09=09=09    LOW_SPEED;
+=09=09} else if (device_speed =3D=3D HIGH_SPEED) {
+=09=09=09mhcd->hcd_hs_ctx->ma_devs[port_number].port_status |=3D
+=09=09=09    MAUSB_PORT_20_STATUS_HIGH_SPEED;
+=09=09=09mhcd->hcd_hs_ctx->ma_devs[port_number].dev_speed =3D
+=09=09=09    HIGH_SPEED;
+=09=09}
+
+=09=09hcd =3D mhcd->hcd_hs_ctx->hcd;
+=09=09mhcd->hcd_hs_ctx->ma_devs[port_number].ma_dev =3D ma_dev;
+=09} else {
+=09=09mhcd->hcd_ss_ctx->ma_devs[port_number].port_status |=3D
+=09=09    USB_PORT_STAT_CONNECTION | (1 <<
+=09=09=09=09=09=09USB_PORT_FEAT_C_CONNECTION);
+=09=09mhcd->hcd_ss_ctx->ma_devs[port_number].dev_speed =3D SUPER_SPEED;
+
+=09=09hcd =3D mhcd->hcd_ss_ctx->hcd;
+=09=09mhcd->hcd_ss_ctx->ma_devs[port_number].ma_dev =3D ma_dev;
+=09}
+=09spin_unlock_irqrestore(&mhcd->lock, flags);
+
+=09usb_hcd_poll_rh_status(hcd);
+}
+
+void mausb_hcd_disconnect(const u16 port_number,
+=09=09=09  const enum mausb_device_type device_type,
+=09=09=09  const enum mausb_device_speed device_speed)
+{
+=09struct usb_hcd *hcd;
+=09unsigned long flags =3D 0;
+
+=09if (port_number >=3D NUMBER_OF_PORTS) {
+=09=09mausb_pr_err("port number out of range, port_number=3D%x",
+=09=09=09     port_number);
+=09=09return;
+=09}
+
+=09spin_lock_irqsave(&mhcd->lock, flags);
+
+=09if (device_type =3D=3D USB20HUB || device_speed < SUPER_SPEED) {
+=09=09mhcd->hcd_hs_ctx->ma_devs[port_number].port_status &=3D
+=09=09=09~(USB_PORT_STAT_CONNECTION);
+=09=09mhcd->hcd_hs_ctx->ma_devs[port_number].port_status &=3D
+=09=09=09~(USB_PORT_STAT_ENABLE);
+=09=09mhcd->hcd_hs_ctx->ma_devs[port_number].port_status |=3D
+=09=09=09(1 << USB_PORT_FEAT_C_CONNECTION);
+=09=09hcd =3D mhcd->hcd_hs_ctx->hcd;
+=09} else {
+=09=09mhcd->hcd_ss_ctx->ma_devs[port_number].port_status &=3D
+=09=09=09~(USB_PORT_STAT_CONNECTION);
+=09=09mhcd->hcd_ss_ctx->ma_devs[port_number].port_status &=3D
+=09=09=09~(USB_PORT_STAT_ENABLE);
+=09=09mhcd->hcd_ss_ctx->ma_devs[port_number].port_status |=3D
+=09=09=09(1 << USB_PORT_FEAT_C_CONNECTION);
+=09=09hcd =3D mhcd->hcd_ss_ctx->hcd;
+=09}
+
+=09spin_unlock_irqrestore(&mhcd->lock, flags);
+=09if (!hcd)
+=09=09return;
+
+=09usb_hcd_poll_rh_status(hcd);
+}
+
 static const char driver_name[] =3D "MA-USB host controller";
=20
 static void mausb_get_hub_descriptor(struct usb_hcd *hcd, u16 type_req,
@@ -235,12 +320,31 @@ static int mausb_hcd_hub_status(struct usb_hcd *hcd, =
char *buff);
 static int mausb_hcd_reset(struct usb_hcd *hcd);
 static int mausb_hcd_start(struct usb_hcd *hcd);
 static void mausb_hcd_stop(struct usb_hcd *hcd);
+static int mausb_hcd_urb_dequeue(struct usb_hcd *hcd, struct urb *urb,
+=09=09=09=09 int status);
+static int mausb_hcd_urb_enqueue(struct usb_hcd *hcd, struct urb *urb,
+=09=09=09=09 gfp_t mem_flags);
 static int mausb_hub_update_device(struct usb_hcd *hcd, struct usb_device =
*dev,
 =09=09=09=09   struct usb_tt *tt, gfp_t mem_flags);
 static void mausb_reset_bandwidth(struct usb_hcd *hcd, struct usb_device *=
dev);
 static int mausb_reset_device(struct usb_hcd *hcd, struct usb_device *dev)=
;
 static int mausb_update_device(struct usb_hcd *hcd, struct usb_device *dev=
);
=20
+static void mausb_print_urb(struct urb *request)
+{
+=09mausb_pr_debug("URB: urb=3D%p, ep_handle=3D%#x, packet_num=3D%d, setup_=
dma=3D%lld, is_setup_packet=3D%d, is_ep=3D%d, is_sg=3D%d, num_sgs=3D%d, num=
_mapped_sgs=3D%d, status=3D%d, is_transfer_buffer=3D%d, transfer_buffer_len=
gth=3D%d, is_transfer_dma=3D%llu, transfer_flags=3D%d, is_hcpriv=3D%d",
+=09=09       request, ((struct mausb_endpoint_ctx *)
+=09=09=09=09 request->ep->hcpriv)->ep_handle,
+=09=09       request->number_of_packets, request->setup_dma,
+=09=09       request->setup_packet ? 1 : 0, request->ep ? 1 : 0,
+=09=09       request->sg ? 1 : 0, request->num_sgs,
+=09=09       request->num_mapped_sgs, request->status,
+=09=09       request->transfer_buffer ? 1 : 0,
+=09=09       request->transfer_buffer_length,
+=09=09       request->transfer_dma, request->transfer_flags,
+=09=09       (request->ep && request->ep->hcpriv) ? 1 : 0);
+}
+
 static const struct hc_driver mausb_hc_driver =3D {
 =09.description  =3D  driver_name,
 =09.product_desc =3D driver_name,
@@ -252,6 +356,9 @@ static const struct hc_driver mausb_hc_driver =3D {
 =09.start =3D mausb_hcd_start,
 =09.stop  =3D mausb_hcd_stop,
=20
+=09.urb_enqueue =3D mausb_hcd_urb_enqueue,
+=09.urb_dequeue =3D mausb_hcd_urb_dequeue,
+
 =09.get_frame_number =3D mausb_hcd_get_frame_number,
=20
 =09.hub_status_data   =3D mausb_hcd_hub_status,
@@ -311,6 +418,25 @@ static int get_root_hub_port_number(struct usb_device =
*dev, u8 *port_number)
 =09return 0;
 }
=20
+static int usb_to_mausb_device_speed(u8 speed)
+{
+=09switch (speed) {
+=09case USB_SPEED_LOW:
+=09=09return MA_USB_SPEED_LOW_SPEED;
+=09case USB_SPEED_FULL:
+=09=09return MA_USB_SPEED_FULL_SPEED;
+=09case USB_SPEED_WIRELESS:
+=09case USB_SPEED_HIGH:
+=09=09return MA_USB_SPEED_HIGH_SPEED;
+=09case USB_SPEED_SUPER:
+=09=09return MA_USB_SPEED_SUPER_SPEED;
+=09case USB_SPEED_SUPER_PLUS:
+=09=09return MA_USB_SPEED_SUPER_SPEED_PLUS;
+=09default:
+=09=09return -EINVAL;
+=09}
+}
+
 static struct mausb_usb_device_ctx *mausb_find_usb_device(struct mausb_dev
 =09=09=09=09=09=09=09*mdevs, void *dev_addr)
 {
@@ -330,6 +456,31 @@ static struct mausb_usb_device_ctx *mausb_find_usb_dev=
ice(struct mausb_dev
 =09return NULL;
 }
=20
+static int mausb_insert_usb_device(struct mausb_dev *mdevs,
+=09=09=09=09   struct mausb_usb_device_ctx *usb_device)
+{
+=09struct rb_node **new_node =3D &mdevs->usb_devices.rb_node;
+=09struct rb_node *parent =3D NULL;
+=09struct mausb_usb_device_ctx *current_usb_device =3D NULL;
+
+=09while (*new_node) {
+=09=09parent =3D *new_node;
+=09=09current_usb_device =3D rb_entry(*new_node,
+=09=09=09=09=09      struct mausb_usb_device_ctx,
+=09=09=09=09=09      rb_node);
+
+=09=09if (usb_device->dev_addr < current_usb_device->dev_addr)
+=09=09=09new_node =3D &((*new_node)->rb_left);
+=09=09else if (usb_device->dev_addr > current_usb_device->dev_addr)
+=09=09=09new_node =3D &((*new_node)->rb_right);
+=09=09else
+=09=09=09return -EEXIST;
+=09}
+=09rb_link_node(&usb_device->rb_node, parent, new_node);
+=09rb_insert_color(&usb_device->rb_node, &mdevs->usb_devices);
+=09return 0;
+}
+
 static int mausb_hcd_get_frame_number(struct usb_hcd *hcd)
 {
 =09return 0;
@@ -504,6 +655,123 @@ static int mausb_hcd_hub_control(struct usb_hcd *hcd,=
 u16 type_req,
 =09return retval;
 }
=20
+static int mausb_validate_urb(struct urb *urb)
+{
+=09if (!urb) {
+=09=09mausb_pr_err("urb is NULL");
+=09=09return -EINVAL;
+=09}
+
+=09if (!urb->ep->hcpriv) {
+=09=09mausb_pr_err("urb->ep->hcpriv is NULL");
+=09=09return -EINVAL;
+=09}
+
+=09if (!urb->ep->enabled) {
+=09=09mausb_pr_err("Endpoint not enabled");
+=09=09return -EINVAL;
+=09}
+=09return 0;
+}
+
+static int mausb_hcd_urb_enqueue(struct usb_hcd *hcd, struct urb *urb,
+=09=09=09=09 gfp_t mem_flags)
+{
+=09struct mausb_endpoint_ctx *endpoint_ctx;
+=09struct mausb_device=09  *ma_dev;
+=09struct mausb_urb_ctx=09  *urb_ctx;
+=09int status =3D 0;
+
+=09if (mausb_validate_urb(urb) < 0) {
+=09=09mausb_pr_err("Hpal urb enqueue failed");
+=09=09return -EPROTO;
+=09}
+
+=09endpoint_ctx =3D urb->ep->hcpriv;
+=09ma_dev =3D endpoint_ctx->ma_dev;
+
+=09if (atomic_read(&ma_dev->unresponsive_client)) {
+=09=09mausb_pr_err("Client is not responsive anymore - finish urb immediat=
ely");
+=09=09return -EHOSTDOWN;
+=09}
+
+=09urb->hcpriv =3D hcd;
+
+=09mausb_pr_debug("ep_handle=3D%#x, dev_handle=3D%#x, urb_reject=3D%d",
+=09=09       endpoint_ctx->ep_handle, endpoint_ctx->dev_handle,
+=09=09       atomic_read(&urb->reject));
+
+=09status =3D mausb_insert_urb_in_tree(urb, true);
+=09if (status) {
+=09=09mausb_pr_err("Hpal urb enqueue failed");
+=09=09return status;
+=09}
+
+=09atomic_inc(&urb->use_count);
+
+=09mausb_print_urb(urb);
+
+=09/*
+=09 * Masking URB_SHORT_NOT_OK flag as SCSI driver is adding it where it
+=09 * should not, so it is breaking the USB drive on the linux
+=09 */
+=09urb->transfer_flags &=3D ~URB_SHORT_NOT_OK;
+
+=09status =3D mausb_data_req_enqueue_event(ma_dev, endpoint_ctx->ep_handle=
,
+=09=09=09=09=09      urb);
+=09if (status < 0) {
+=09=09urb_ctx =3D mausb_unlink_and_delete_urb_from_tree(urb, status);
+=09=09atomic_dec(&urb->use_count);
+=09=09if (urb_ctx) {
+=09=09=09mausb_uninit_data_iterator(&urb_ctx->iterator);
+=09=09=09kfree(urb_ctx);
+=09=09}
+=09}
+
+=09return status;
+}
+
+static int mausb_hcd_urb_dequeue(struct usb_hcd *hcd, struct urb *urb,
+=09=09=09=09 int status)
+{
+=09struct mausb_endpoint_ctx *endpoint_ctx;
+=09struct mausb_device=09  *ma_dev;
+=09struct mausb_urb_ctx=09  *urb_ctx;
+
+=09mausb_pr_info("Urb=3D%p", urb);
+
+=09urb_ctx =3D mausb_unlink_and_delete_urb_from_tree(urb, status);
+=09if (!urb_ctx) {
+=09=09mausb_pr_warn("Urb=3D%p is not in tree", urb);
+=09=09return 0;
+=09}
+
+=09endpoint_ctx =3D urb->ep->hcpriv;
+=09ma_dev=09     =3D endpoint_ctx->ma_dev;
+
+=09queue_work(ma_dev->workq, &urb_ctx->work);
+
+=09return 0;
+}
+
+void mausb_hcd_urb_complete(struct urb *urb, u32 actual_length, int status=
)
+{
+=09struct mausb_urb_ctx *urb_ctx =3D
+=09=09mausb_unlink_and_delete_urb_from_tree(urb, status);
+
+=09if (urb_ctx) {
+=09=09mausb_uninit_data_iterator(&urb_ctx->iterator);
+=09=09kfree(urb_ctx);
+
+=09=09urb->status=09   =3D status;
+=09=09urb->actual_length =3D actual_length;
+
+=09=09atomic_dec(&urb->use_count);
+=09=09usb_hcd_giveback_urb(urb->hcpriv, urb, urb->status);
+=09=09return;
+=09}
+}
+
 int mausb_probe(struct device *dev)
 {
 =09struct mausb_hcd *mausb_hcd;
@@ -765,8 +1033,10 @@ static void mausb_free_dev(struct usb_hcd *hcd, struc=
t usb_device *dev)
 =09u8=09port_number;
 =09s16=09dev_handle;
 =09int=09status;
+=09unsigned long=09 flags;
 =09struct hub_ctx   *hub  =3D (struct hub_ctx *)hcd->hcd_priv;
 =09struct mausb_dev=09    *mdev =3D NULL;
+=09struct mausb_device=09    *ma_dev;
 =09struct mausb_usb_device_ctx *usb_device_ctx;
 =09struct mausb_endpoint_ctx   *ep_ctx =3D dev->ep0.hcpriv;
=20
@@ -779,6 +1049,16 @@ static void mausb_free_dev(struct usb_hcd *hcd, struc=
t usb_device *dev)
=20
 =09mdev  =3D &hub->ma_devs[port_number];
=20
+=09spin_lock_irqsave(&mhcd->lock, flags);
+=09ma_dev =3D hub->ma_devs[port_number].ma_dev;
+=09spin_unlock_irqrestore(&mhcd->lock, flags);
+
+=09if (!ma_dev) {
+=09=09mausb_pr_err("MAUSB device not found on port_number=3D%d",
+=09=09=09     port_number);
+=09=09return;
+=09}
+
 =09usb_device_ctx =3D mausb_find_usb_device(mdev, dev);
 =09if (!usb_device_ctx) {
 =09=09mausb_pr_warn("device_ctx is not found");
@@ -787,6 +1067,13 @@ static void mausb_free_dev(struct usb_hcd *hcd, struc=
t usb_device *dev)
=20
 =09dev_handle =3D usb_device_ctx->dev_handle;
=20
+=09if (atomic_read(&ma_dev->unresponsive_client)) {
+=09=09mausb_pr_err("Client is not responsive anymore - free usbdevice imme=
diately");
+=09=09dev->ep0.hcpriv =3D NULL;
+=09=09kfree(ep_ctx);
+=09=09goto free_dev;
+=09}
+
 =09if (ep_ctx) {
 =09=09dev->ep0.hcpriv =3D NULL;
 =09=09kfree(ep_ctx);
@@ -795,9 +1082,51 @@ static void mausb_free_dev(struct usb_hcd *hcd, struc=
t usb_device *dev)
 =09=09mausb_pr_warn("ep_ctx is NULL: dev_handle=3D%#x", dev_handle);
 =09}
=20
+free_dev:
+=09if (atomic_sub_and_test(1, &ma_dev->num_of_usb_devices)) {
+=09=09mausb_pr_info("All usb devices destroyed - proceed with disconnectin=
g");
+=09=09queue_work(ma_dev->workq, &ma_dev->socket_disconnect_work);
+=09}
+
 =09rb_erase(&usb_device_ctx->rb_node, &mdev->usb_devices);
 =09mausb_pr_info("USB device deleted device=3D%p", usb_device_ctx->dev_add=
r);
 =09kfree(usb_device_ctx);
+
+=09if (kref_put(&ma_dev->refcount, mausb_release_ma_dev_async))
+=09=09mausb_clear_hcd_madev(port_number);
+}
+
+static struct mausb_usb_device_ctx *
+mausb_alloc_device_ctx(struct hub_ctx *hub, struct usb_device *dev,
+=09=09       struct mausb_device *ma_dev, u16 port_number,
+=09=09       int *status)
+{
+=09struct mausb_usb_device_ctx *usb_device_ctx =3D NULL;
+
+=09usb_device_ctx =3D kzalloc(sizeof(*usb_device_ctx), GFP_ATOMIC);
+=09if (!usb_device_ctx) {
+=09=09*status =3D -ENOMEM;
+=09=09return NULL;
+=09}
+
+=09usb_device_ctx->dev_addr   =3D dev;
+=09usb_device_ctx->dev_handle =3D DEV_HANDLE_NOT_ASSIGNED;
+=09usb_device_ctx->addressed  =3D false;
+
+=09if (mausb_insert_usb_device(&hub->ma_devs[port_number],
+=09=09=09=09    usb_device_ctx)) {
+=09=09mausb_pr_warn("device_ctx already exists");
+=09=09kfree(usb_device_ctx);
+=09=09*status =3D -EEXIST;
+=09=09return NULL;
+=09}
+
+=09kref_get(&ma_dev->refcount);
+=09mausb_pr_info("New USB device added device=3D%p",
+=09=09      usb_device_ctx->dev_addr);
+=09atomic_inc(&ma_dev->num_of_usb_devices);
+
+=09return usb_device_ctx;
 }
=20
 /*
@@ -808,7 +1137,9 @@ static int mausb_address_device(struct usb_hcd *hcd, s=
truct usb_device *dev)
 {
 =09u8=09port_number;
 =09int=09status;
+=09unsigned long=09flags;
 =09struct hub_ctx=09*hub =3D (struct hub_ctx *)hcd->hcd_priv;
+=09struct mausb_device=09    *ma_dev;
 =09struct mausb_usb_device_ctx *usb_device_ctx;
 =09struct mausb_endpoint_ctx   *endpoint_ctx;
=20
@@ -819,9 +1150,23 @@ static int mausb_address_device(struct usb_hcd *hcd, =
struct usb_device *dev)
 =09=09return -EINVAL;
 =09}
=20
-=09usb_device_ctx =3D mausb_find_usb_device(&hub->ma_devs[port_number], de=
v);
-=09if (!usb_device_ctx)
+=09spin_lock_irqsave(&mhcd->lock, flags);
+=09ma_dev =3D hub->ma_devs[port_number].ma_dev;
+=09spin_unlock_irqrestore(&mhcd->lock, flags);
+
+=09if (!ma_dev) {
+=09=09mausb_pr_warn("MAUSB device not found on port_number=3D%d",
+=09=09=09      port_number);
 =09=09return -ENODEV;
+=09}
+
+=09usb_device_ctx =3D mausb_find_usb_device(&hub->ma_devs[port_number], de=
v);
+=09if (!usb_device_ctx) {
+=09=09usb_device_ctx =3D mausb_alloc_device_ctx(hub, dev, ma_dev,
+=09=09=09=09=09=09=09port_number, &status);
+=09=09if (!usb_device_ctx)
+=09=09=09return status;
+=09}
=20
 =09mausb_pr_info("dev_handle=3D%#x, dev_speed=3D%#x",
 =09=09      usb_device_ctx->dev_handle, dev->speed);
@@ -852,9 +1197,13 @@ static int mausb_add_endpoint(struct usb_hcd *hcd, st=
ruct usb_device *dev,
 {
 =09int=09status;
 =09u8=09port_number;
+=09struct ma_usb_ephandlereq_desc_ss  descriptor_ss;
+=09struct ma_usb_ephandlereq_desc_std descriptor;
 =09struct hub_ctx=09=09    *hub =3D (struct hub_ctx *)hcd->hcd_priv;
+=09struct mausb_device=09    *ma_dev;
 =09struct mausb_usb_device_ctx *usb_dev_ctx;
 =09struct mausb_endpoint_ctx   *endpoint_ctx;
+=09unsigned long flags =3D 0;
=20
 =09status =3D get_root_hub_port_number(dev, &port_number);
 =09if (status < 0 || port_number >=3D NUMBER_OF_PORTS) {
@@ -863,6 +1212,16 @@ static int mausb_add_endpoint(struct usb_hcd *hcd, st=
ruct usb_device *dev,
 =09=09return 0;
 =09}
=20
+=09spin_lock_irqsave(&mhcd->lock, flags);
+=09ma_dev =3D hub->ma_devs[port_number].ma_dev;
+=09spin_unlock_irqrestore(&mhcd->lock, flags);
+
+=09if (!ma_dev) {
+=09=09mausb_pr_err("MAUSB device not found on port_number=3D%d",
+=09=09=09     port_number);
+=09=09return -ENODEV;
+=09}
+
 =09usb_dev_ctx =3D mausb_find_usb_device(&hub->ma_devs[port_number], dev);
=20
 =09if (!usb_dev_ctx) {
@@ -876,8 +1235,17 @@ static int mausb_add_endpoint(struct usb_hcd *hcd, st=
ruct usb_device *dev,
=20
 =09endpoint_ctx->dev_handle=09=3D usb_dev_ctx->dev_handle;
 =09endpoint_ctx->usb_device_ctx=09=3D usb_dev_ctx;
+=09endpoint_ctx->ma_dev=09=09=3D ma_dev;
 =09endpoint->hcpriv=09=09=3D endpoint_ctx;
=20
+=09if (dev->speed >=3D USB_SPEED_SUPER) {
+=09=09mausb_init_superspeed_ep_descriptor(&descriptor_ss,
+=09=09=09=09=09=09    &endpoint->desc,
+=09=09=09=09=09=09    &endpoint->ss_ep_comp);
+=09} else {
+=09=09mausb_init_standard_ep_descriptor(&descriptor, &endpoint->desc);
+=09}
+
 =09return 0;
 }
=20
@@ -887,8 +1255,10 @@ static int mausb_drop_endpoint(struct usb_hcd *hcd, s=
truct usb_device *dev,
 =09u8=09port_number;
 =09int=09status;
 =09struct hub_ctx=09=09    *hub =3D (struct hub_ctx *)hcd->hcd_priv;
+=09struct mausb_device=09    *ma_dev;
 =09struct mausb_usb_device_ctx *usb_dev_ctx;
 =09struct mausb_endpoint_ctx   *endpoint_ctx =3D endpoint->hcpriv;
+=09unsigned long flags =3D 0;
=20
 =09status =3D get_root_hub_port_number(dev, &port_number);
 =09if (status < 0 || port_number >=3D NUMBER_OF_PORTS) {
@@ -897,6 +1267,16 @@ static int mausb_drop_endpoint(struct usb_hcd *hcd, s=
truct usb_device *dev,
 =09=09return -EINVAL;
 =09}
=20
+=09spin_lock_irqsave(&mhcd->lock, flags);
+=09ma_dev =3D hub->ma_devs[port_number].ma_dev;
+=09spin_unlock_irqrestore(&mhcd->lock, flags);
+
+=09if (!ma_dev) {
+=09=09mausb_pr_err("MAUSB device not found on port_number=3D%d",
+=09=09=09     port_number);
+=09=09return -ENODEV;
+=09}
+
 =09usb_dev_ctx =3D mausb_find_usb_device(&hub->ma_devs[port_number], dev);
=20
 =09if (!endpoint_ctx) {
@@ -913,6 +1293,70 @@ static int mausb_drop_endpoint(struct usb_hcd *hcd, s=
truct usb_device *dev,
 =09return 0;
 }
=20
+static int mausb_device_assign_dev_handle(struct usb_hcd *hcd,
+=09=09=09=09=09  struct usb_device *dev,
+=09=09=09=09=09  struct hub_ctx *hub,
+=09=09=09=09=09  struct mausb_device *ma_dev,
+=09=09=09=09=09  struct mausb_usb_device_ctx
+=09=09=09=09=09  *usb_device_ctx)
+{
+=09u8 port_number;
+=09int status;
+=09int dev_speed;
+=09u16 hub_dev_handle=09=09=3D 0;
+=09u16 parent_hs_hub_dev_handle=09=3D 0;
+=09u16 parent_hs_hub_port=09=09=3D 0;
+=09struct usb_device=09=09   *first_hub_device =3D dev;
+=09struct mausb_usb_device_ctx=09   *hub_device_ctx;
+=09struct mausb_endpoint_ctx=09   *endpoint_ctx;
+=09struct ma_usb_ephandlereq_desc_std descriptor;
+
+=09status =3D get_root_hub_port_number(dev, &port_number);
+=09if (status < 0 || port_number >=3D NUMBER_OF_PORTS) {
+=09=09mausb_pr_info("port_number out of range, port_number=3D%x",
+=09=09=09      port_number);
+=09=09return -EINVAL;
+=09}
+
+=09while (first_hub_device->parent->parent)
+=09=09first_hub_device =3D first_hub_device->parent;
+
+=09hub_device_ctx =3D mausb_find_usb_device(&hub->ma_devs[port_number],
+=09=09=09=09=09       first_hub_device);
+=09if (hub_device_ctx)
+=09=09hub_dev_handle =3D hub_device_ctx->dev_handle;
+
+=09if ((dev->speed =3D=3D USB_SPEED_LOW || dev->speed =3D=3D USB_SPEED_FUL=
L) &&
+=09    first_hub_device->speed =3D=3D USB_SPEED_HIGH) {
+=09=09parent_hs_hub_dev_handle =3D
+=09=09=09mausb_find_usb_device(&hub->ma_devs[port_number],
+=09=09=09=09=09      dev->parent)->dev_handle;
+=09=09parent_hs_hub_port =3D dev->parent->portnum;
+=09}
+
+=09dev_speed =3D usb_to_mausb_device_speed(dev->speed);
+=09mausb_pr_info("start... mausb_devspeed=3D%d, route=3D%#x, port_number=
=3D%d",
+=09=09      dev_speed, dev->route, port_number);
+
+=09if (dev_speed =3D=3D -EINVAL) {
+=09=09mausb_pr_err("bad dev_speed");
+=09=09return -EINVAL;
+=09}
+
+=09endpoint_ctx =3D kzalloc(sizeof(*endpoint_ctx), GFP_ATOMIC);
+=09if (!endpoint_ctx)
+=09=09return -ENOMEM;
+
+=09endpoint_ctx->dev_handle     =3D usb_device_ctx->dev_handle;
+=09endpoint_ctx->ma_dev=09     =3D ma_dev;
+=09endpoint_ctx->usb_device_ctx =3D usb_device_ctx;
+=09dev->ep0.hcpriv=09=09     =3D endpoint_ctx;
+
+=09mausb_init_standard_ep_descriptor(&descriptor, &dev->ep0.desc);
+
+=09return 0;
+}
+
 /*
  * For usb 2.0 logitech camera called multiple times, once during enumerat=
ion
  * of device and later after mausb_reset_device. In latter case it is
@@ -923,7 +1367,9 @@ static int mausb_enable_device(struct usb_hcd *hcd, st=
ruct usb_device *dev)
 =09int status;
 =09u8 port_number;
 =09struct hub_ctx=09=09    *hub =3D (struct hub_ctx *)hcd->hcd_priv;
+=09struct mausb_device=09    *ma_dev;
 =09struct mausb_usb_device_ctx *usb_device_ctx;
+=09unsigned long flags;
=20
 =09status =3D get_root_hub_port_number(dev, &port_number);
 =09if (status < 0 || port_number >=3D NUMBER_OF_PORTS) {
@@ -932,13 +1378,27 @@ static int mausb_enable_device(struct usb_hcd *hcd, =
struct usb_device *dev)
 =09=09return -EINVAL;
 =09}
=20
-=09usb_device_ctx =3D mausb_find_usb_device(&hub->ma_devs[port_number], de=
v);
-=09if (!usb_device_ctx)
+=09spin_lock_irqsave(&mhcd->lock, flags);
+=09ma_dev =3D hub->ma_devs[port_number].ma_dev;
+=09spin_unlock_irqrestore(&mhcd->lock, flags);
+
+=09if (!ma_dev) {
+=09=09mausb_pr_err("MAUSB device not found on port_number=3D%d",
+=09=09=09     port_number);
 =09=09return -ENODEV;
+=09}
=20
-=09mausb_pr_info("Device assigned and addressed usb_device_ctx=3D%p",
-=09=09      usb_device_ctx);
+=09usb_device_ctx =3D mausb_find_usb_device(&hub->ma_devs[port_number], de=
v);
+=09if (!usb_device_ctx) {
+=09=09usb_device_ctx =3D mausb_alloc_device_ctx(hub, dev, ma_dev,
+=09=09=09=09=09=09=09port_number, &status);
+=09=09if (!usb_device_ctx)
+=09=09=09return status;
+=09}
=20
+=09if (usb_device_ctx->dev_handle =3D=3D DEV_HANDLE_NOT_ASSIGNED)
+=09=09return mausb_device_assign_dev_handle(hcd, dev, hub, ma_dev,
+=09=09=09=09=09=09      usb_device_ctx);
 =09return 0;
 }
=20
@@ -952,7 +1412,9 @@ static int mausb_update_device(struct usb_hcd *hcd, st=
ruct usb_device *dev)
 =09u8=09port_number =3D 0;
 =09int=09status=09    =3D 0;
 =09struct hub_ctx=09=09    *hub =3D (struct hub_ctx *)hcd->hcd_priv;
+=09struct mausb_device=09    *ma_dev =3D NULL;
 =09struct mausb_usb_device_ctx *usb_device_ctx =3D NULL;
+=09unsigned long flags =3D 0;
=20
 =09if (mausb_is_hub_device(dev)) {
 =09=09mausb_pr_warn("Device is hub");
@@ -966,6 +1428,16 @@ static int mausb_update_device(struct usb_hcd *hcd, s=
truct usb_device *dev)
 =09=09return -EINVAL;
 =09}
=20
+=09spin_lock_irqsave(&mhcd->lock, flags);
+=09ma_dev =3D hub->ma_devs[port_number].ma_dev;
+=09spin_unlock_irqrestore(&mhcd->lock, flags);
+
+=09if (!ma_dev) {
+=09=09mausb_pr_err("MAUSB device not found on port_number=3D%d",
+=09=09=09     port_number);
+=09=09return -ENODEV;
+=09}
+
 =09usb_device_ctx =3D mausb_find_usb_device(&hub->ma_devs[port_number], de=
v);
 =09if (!usb_device_ctx) {
 =09=09mausb_pr_warn("Device not found");
@@ -980,10 +1452,12 @@ static int mausb_hub_update_device(struct usb_hcd *h=
cd, struct usb_device *dev,
 {
 =09int=09status;
 =09u8=09port_number;
+=09unsigned long flags;
 =09u16 max_exit_latency =3D 0;
 =09u8  mtt =3D 0;
 =09u8  ttt =3D 0;
 =09struct hub_ctx=09=09    *hub =3D (struct hub_ctx *)hcd->hcd_priv;
+=09struct mausb_device=09    *ma_dev;
 =09struct mausb_usb_device_ctx *usb_device_ctx;
=20
 =09if (dev->speed =3D=3D USB_SPEED_HIGH) {
@@ -998,6 +1472,16 @@ static int mausb_hub_update_device(struct usb_hcd *hc=
d, struct usb_device *dev,
 =09=09return 0;
 =09}
=20
+=09spin_lock_irqsave(&mhcd->lock, flags);
+=09ma_dev =3D hub->ma_devs[port_number].ma_dev;
+=09spin_unlock_irqrestore(&mhcd->lock, flags);
+
+=09if (!ma_dev) {
+=09=09mausb_pr_err("MAUSB device not found on port_number=3D%d",
+=09=09=09     port_number);
+=09=09return -ENODEV;
+=09}
+
 =09usb_device_ctx =3D mausb_find_usb_device(&hub->ma_devs[port_number],
 =09=09=09=09=09       dev);
=20
@@ -1038,10 +1522,12 @@ static void mausb_endpoint_reset(struct usb_hcd *hc=
d,
 =09int is_control;
 =09int epnum;
 =09int is_out;
+=09unsigned long flags;
 =09u16=09dev_handle;
 =09u8=09tsp;
 =09u8=09port_number;
 =09struct hub_ctx=09=09    *hub;
+=09struct mausb_device=09    *ma_dev;
 =09struct mausb_usb_device_ctx *usb_device_ctx;
 =09struct usb_device=09    *dev;
 =09struct mausb_endpoint_ctx   *ep_ctx;
@@ -1064,14 +1550,21 @@ static void mausb_endpoint_reset(struct usb_hcd *hc=
d,
 =09}
 =09hub =3D (struct hub_ctx *)hcd->hcd_priv;
=20
+=09spin_lock_irqsave(&mhcd->lock, flags);
+=09ma_dev =3D hub->ma_devs[port_number].ma_dev;
+=09spin_unlock_irqrestore(&mhcd->lock, flags);
+
+=09if (!ma_dev) {
+=09=09mausb_pr_err("MAUSB device not found on port_number=3D%d",
+=09=09=09     port_number);
+=09=09return;
+=09}
+
 =09is_control =3D usb_endpoint_xfer_control(&endpoint->desc);
 =09epnum =3D usb_endpoint_num(&endpoint->desc);
 =09is_out =3D usb_endpoint_dir_out(&endpoint->desc);
 =09tsp =3D (u8)(is_out ? dev->toggle[1] : dev->toggle[0]);
=20
-=09if (status < 0)
-=09=09return;
-
 =09if (status !=3D EUCLEAN) {
 =09=09if (!tsp) {
 =09=09=09usb_settoggle(dev, epnum, is_out, 0U);
@@ -1099,7 +1592,9 @@ static int mausb_reset_device(struct usb_hcd *hcd, st=
ruct usb_device *dev)
 =09int status;
 =09u8  port_number;
 =09u16 dev_handle;
+=09unsigned long flags;
 =09struct hub_ctx=09=09    *hub;
+=09struct mausb_device=09    *ma_dev;
 =09struct mausb_usb_device_ctx *usb_device_ctx;
=20
 =09hub =3D (struct hub_ctx *)hcd->hcd_priv;
@@ -1111,6 +1606,16 @@ static int mausb_reset_device(struct usb_hcd *hcd, s=
truct usb_device *dev)
 =09=09return -EINVAL;
 =09}
=20
+=09spin_lock_irqsave(&mhcd->lock, flags);
+=09ma_dev =3D hub->ma_devs[port_number].ma_dev;
+=09spin_unlock_irqrestore(&mhcd->lock, flags);
+
+=09if (!ma_dev) {
+=09=09mausb_pr_err("MAUSB device not found on port_number=3D%d",
+=09=09=09     port_number);
+=09=09return -ENODEV;
+=09}
+
 =09usb_device_ctx =3D mausb_find_usb_device(&hub->ma_devs[port_number], de=
v);
=20
 =09if (!usb_device_ctx ||
diff --git a/drivers/usb/mausb_host/hcd.h b/drivers/usb/mausb_host/hcd.h
index cbef70a2f985..d4e9267503d1 100644
--- a/drivers/usb/mausb_host/hcd.h
+++ b/drivers/usb/mausb_host/hcd.h
@@ -15,6 +15,8 @@
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
=20
+#include "hpal.h"
+
 #define DEVICE_NAME "mausb_host_hcd_dev"
 #define CLASS_NAME "mausb"
=20
@@ -65,6 +67,13 @@ struct hub_ctx {
 int mausb_init_hcd(void);
 void mausb_deinit_hcd(void);
=20
+void mausb_port_has_changed(const enum mausb_device_type device_type,
+=09=09=09    const enum mausb_device_speed device_speed,
+=09=09=09    void *ma_dev);
+void mausb_hcd_disconnect(const u16 port_number,
+=09=09=09  const enum mausb_device_type device_type,
+=09=09=09  const enum mausb_device_speed device_speed);
+
 #define PORT_C_MASK \
 =09=09((USB_PORT_STAT_C_CONNECTION \
 =09=09| USB_PORT_STAT_C_ENABLE \
@@ -140,11 +149,13 @@ struct mausb_endpoint_ctx {
=20
 struct mausb_urb_ctx {
 =09struct urb=09=09*urb;
+=09struct mausb_data_iter=09iterator;
 =09struct rb_node=09=09rb_node;
 =09struct work_struct=09work;
 };
=20
 int mausb_probe(struct device *dev);
+void mausb_hcd_urb_complete(struct urb *urb, u32 actual_length, int status=
);
=20
 void mausb_clear_hcd_madev(u16 port_number);
=20
diff --git a/drivers/usb/mausb_host/hpal.c b/drivers/usb/mausb_host/hpal.c
new file mode 100644
index 000000000000..ac86cbc71e36
--- /dev/null
+++ b/drivers/usb/mausb_host/hpal.c
@@ -0,0 +1,1094 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
+ */
+#include "hpal.h"
+
+#include <linux/circ_buf.h>
+#include <linux/kobject.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/uio.h>
+
+#include "hcd.h"
+#include "utils.h"
+
+struct mss mss;
+
+static int mausb_power_state_cb(struct notifier_block *nb, unsigned long a=
ction,
+=09=09=09=09void *data);
+static void mausb_execute_urb_dequeue(struct work_struct *dequeue_work);
+static int mausb_start_heartbeat_timer(void);
+
+static inline struct mausb_urb_ctx *__mausb_find_urb_in_tree(struct urb *u=
rb)
+{
+=09struct rb_node *node =3D mhcd->mausb_urbs.rb_node;
+
+=09while (node) {
+=09=09struct mausb_urb_ctx *urb_ctx =3D
+=09=09    rb_entry(node, struct mausb_urb_ctx, rb_node);
+
+=09=09if (urb < urb_ctx->urb)
+=09=09=09node =3D urb_ctx->rb_node.rb_left;
+=09=09else if (urb > urb_ctx->urb)
+=09=09=09node =3D urb_ctx->rb_node.rb_right;
+=09=09else
+=09=09=09return urb_ctx;
+=09}
+=09return NULL;
+}
+
+struct mausb_urb_ctx *mausb_find_urb_in_tree(struct urb *urb)
+{
+=09unsigned long flags =3D 0;
+=09struct mausb_urb_ctx *urb_ctx;
+
+=09spin_lock_irqsave(&mhcd->lock, flags);
+=09urb_ctx =3D  __mausb_find_urb_in_tree(urb);
+=09spin_unlock_irqrestore(&mhcd->lock, flags);
+
+=09return urb_ctx;
+}
+
+static int mausb_insert_urb_ctx_in_tree(struct mausb_urb_ctx *urb_ctx)
+{
+=09struct rb_node **new_node =3D &mhcd->mausb_urbs.rb_node;
+=09struct rb_node *parent =3D NULL;
+=09struct mausb_urb_ctx *current_urb =3D NULL;
+
+=09while (*new_node) {
+=09=09parent =3D *new_node;
+=09=09current_urb =3D rb_entry(*new_node, struct mausb_urb_ctx,
+=09=09=09=09       rb_node);
+
+=09=09if (urb_ctx->urb < current_urb->urb)
+=09=09=09new_node =3D &((*new_node)->rb_left);
+=09=09else if (urb_ctx->urb > current_urb->urb)
+=09=09=09new_node =3D &((*new_node)->rb_right);
+=09=09else
+=09=09=09return -EEXIST;
+=09}
+=09rb_link_node(&urb_ctx->rb_node, parent, new_node);
+=09rb_insert_color(&urb_ctx->rb_node, &mhcd->mausb_urbs);
+=09return 0;
+}
+
+static void mausb_delete_urb_ctx_from_tree(struct mausb_urb_ctx *urb_ctx)
+{
+=09rb_erase(&urb_ctx->rb_node, &mhcd->mausb_urbs);
+}
+
+static struct mausb_urb_ctx *mausb_create_urb_ctx(struct urb *urb, int *st=
atus)
+{
+=09struct mausb_urb_ctx *urb_ctx =3D NULL;
+
+=09if (!urb) {
+=09=09mausb_pr_err("Urb is NULL");
+=09=09*status =3D -EINVAL;
+=09=09return NULL;
+=09}
+
+=09urb_ctx =3D kzalloc(sizeof(*urb_ctx), GFP_ATOMIC);
+=09if (!urb_ctx) {
+=09=09*status =3D -ENOMEM;
+=09=09return NULL;
+=09}
+
+=09urb_ctx->urb =3D urb;
+=09INIT_WORK(&urb_ctx->work, mausb_execute_urb_dequeue);
+
+=09return urb_ctx;
+}
+
+int mausb_insert_urb_in_tree(struct urb *urb, bool link_urb_to_ep)
+{
+=09unsigned long flags;
+=09int status =3D 0;
+
+=09struct mausb_urb_ctx *urb_ctx =3D mausb_create_urb_ctx(urb, &status);
+
+=09if (!urb_ctx)
+=09=09return status;
+
+=09spin_lock_irqsave(&mhcd->lock, flags);
+
+=09if (link_urb_to_ep) {
+=09=09status =3D usb_hcd_link_urb_to_ep(urb->hcpriv, urb);
+=09=09if (status) {
+=09=09=09spin_unlock_irqrestore(&mhcd->lock, flags);
+=09=09=09mausb_pr_err("Error %d while linking urb to hcd_endpoint",
+=09=09=09=09     status);
+=09=09=09kfree(urb_ctx);
+=09=09=09return status;
+=09=09}
+=09}
+
+=09if (mausb_insert_urb_ctx_in_tree(urb_ctx)) {
+=09=09kfree(urb_ctx);
+=09=09if (link_urb_to_ep)
+=09=09=09usb_hcd_unlink_urb_from_ep(urb->hcpriv, urb);
+=09=09spin_unlock_irqrestore(&mhcd->lock, flags);
+=09=09mausb_pr_err("Urb_ctx insertion failed");
+=09=09return -EEXIST;
+=09}
+
+=09mausb_init_data_iterator(&urb_ctx->iterator, urb->transfer_buffer,
+=09=09=09=09 urb->transfer_buffer_length, urb->sg,
+=09=09=09=09 (unsigned int)urb->num_sgs,
+=09=09=09=09 usb_urb_dir_in(urb));
+
+=09spin_unlock_irqrestore(&mhcd->lock, flags);
+
+=09return 0;
+}
+
+static bool mausb_return_urb_ctx_to_tree(struct mausb_urb_ctx *urb_ctx,
+=09=09=09=09=09 bool link_urb_to_ep)
+{
+=09unsigned long flags;
+=09int status;
+
+=09if (!urb_ctx)
+=09=09return false;
+
+=09spin_lock_irqsave(&mhcd->lock, flags);
+=09if (link_urb_to_ep) {
+=09=09status =3D usb_hcd_link_urb_to_ep(urb_ctx->urb->hcpriv,
+=09=09=09=09=09=09urb_ctx->urb);
+=09=09if (status) {
+=09=09=09spin_unlock_irqrestore(&mhcd->lock, flags);
+=09=09=09mausb_pr_err("Error %d while linking urb to hcd_endpoint",
+=09=09=09=09     status);
+=09=09=09return false;
+=09=09}
+=09}
+
+=09if (mausb_insert_urb_ctx_in_tree(urb_ctx)) {
+=09=09if (link_urb_to_ep)
+=09=09=09usb_hcd_unlink_urb_from_ep(urb_ctx->urb->hcpriv,
+=09=09=09=09=09=09   urb_ctx->urb);
+=09=09spin_unlock_irqrestore(&mhcd->lock, flags);
+=09=09mausb_pr_err("Urb_ctx insertion failed");
+=09=09return false;
+=09}
+
+=09spin_unlock_irqrestore(&mhcd->lock, flags);
+
+=09return true;
+}
+
+/*After this function call only valid thing to do with urb is to give it b=
ack*/
+struct mausb_urb_ctx *mausb_unlink_and_delete_urb_from_tree(struct urb *ur=
b,
+=09=09=09=09=09=09=09    int status)
+{
+=09struct mausb_urb_ctx *urb_ctx =3D NULL;
+=09unsigned long flags;
+=09int ret;
+
+=09if (!urb) {
+=09=09mausb_pr_warn("Urb is NULL");
+=09=09return NULL;
+=09}
+
+=09spin_lock_irqsave(&mhcd->lock, flags);
+
+=09urb_ctx =3D __mausb_find_urb_in_tree(urb);
+
+=09if (!urb_ctx) {
+=09=09mausb_pr_warn("Urb=3D%p not in tree", urb);
+=09=09spin_unlock_irqrestore(&mhcd->lock, flags);
+=09=09return NULL;
+=09}
+
+=09ret =3D usb_hcd_check_unlink_urb(urb->hcpriv, urb, status);
+
+=09if (ret =3D=3D -EIDRM)
+=09=09mausb_pr_warn("Urb=3D%p is already unlinked", urb);
+=09else
+=09=09usb_hcd_unlink_urb_from_ep(urb->hcpriv, urb);
+
+=09mausb_delete_urb_ctx_from_tree(urb_ctx);
+
+=09spin_unlock_irqrestore(&mhcd->lock, flags);
+
+=09mausb_pr_debug("Urb=3D%p is removed from tree", urb);
+
+=09return urb_ctx;
+}
+
+void mausb_release_event_resources(struct mausb_event *event)
+{
+=09struct ma_usb_hdr_common *receive_buffer =3D (struct ma_usb_hdr_common =
*)
+=09=09=09=09=09=09    event->data.recv_buf;
+
+=09kfree(receive_buffer);
+}
+
+void mausb_complete_urb(struct mausb_event *event)
+{
+=09struct urb *urb =3D (struct urb *)event->data.urb;
+
+=09mausb_pr_debug("transfer_size=3D%d, rem_transfer_size=3D%d, status=3D%d=
",
+=09=09       event->data.transfer_size,
+=09=09       event->data.rem_transfer_size, event->status);
+=09mausb_complete_request(urb,
+=09=09=09       event->data.transfer_size -
+=09=09=09       event->data.rem_transfer_size,
+=09=09=09       event->status);
+}
+
+static int mausb_get_first_free_port_number(u16 *port_number)
+{
+=09(*port_number) =3D 0;
+=09while ((mhcd->connected_ports & (1 << *port_number)) !=3D 0 &&
+=09       *port_number < NUMBER_OF_PORTS)
+=09=09++(*port_number);
+
+=09if (*port_number =3D=3D NUMBER_OF_PORTS)
+=09=09return -EINVAL;
+
+=09mhcd->connected_ports |=3D (1 << *port_number);
+
+=09return 0;
+}
+
+static inline void mausb_port_has_changed_event(struct mausb_device *dev,
+=09=09=09=09=09=09struct mausb_event *event)
+{
+=09int status;
+=09u16 port_number;
+=09unsigned long flags =3D 0;
+
+=09spin_lock_irqsave(&mhcd->lock, flags);
+
+=09status =3D mausb_get_first_free_port_number(&port_number);
+=09if (status < 0) {
+=09=09spin_unlock_irqrestore(&mhcd->lock, flags);
+=09=09mausb_pr_err("There is no free port, schedule delete ma_dev");
+=09=09queue_work(dev->workq, &dev->socket_disconnect_work);
+=09=09return;
+=09}
+
+=09spin_unlock_irqrestore(&mhcd->lock, flags);
+
+=09dev->dev_type=09   =3D event->port_changed.dev_type;
+=09dev->dev_speed=09   =3D event->port_changed.dev_speed;
+=09dev->lse=09   =3D event->port_changed.lse;
+=09dev->dev_connected =3D 1;
+=09dev->port_number   =3D port_number;
+
+=09mausb_port_has_changed(event->port_changed.dev_type,
+=09=09=09       event->port_changed.dev_speed, dev);
+
+=09if ((enum mausb_device_type)event->port_changed.dev_type =3D=3D USB30HU=
B)
+=09=09mausb_port_has_changed(USB20HUB, HIGH_SPEED, dev);
+}
+
+static void mausb_heartbeat_timer_func(struct timer_list *timer)
+{
+=09unsigned long flags =3D 0;
+=09struct mausb_device *dev =3D NULL;
+
+=09if (mausb_start_heartbeat_timer() < 0) {
+=09=09mausb_pr_err("Devices disconnecting - app is unresponsive");
+=09=09spin_lock_irqsave(&mss.lock, flags);
+
+=09=09/* Reset connected clients */
+=09=09mss.client_connected =3D false;
+=09=09mss.missed_heartbeats =3D 0;
+
+=09=09list_for_each_entry(dev, &mss.madev_list, list_entry) {
+=09=09=09mausb_pr_debug("Enqueue heartbeat_work madev_addr=3D%x",
+=09=09=09=09       dev->madev_addr);
+=09=09=09queue_work(dev->workq, &dev->heartbeat_work);
+=09=09}
+
+=09=09complete(&mss.client_stopped);
+=09=09spin_unlock_irqrestore(&mss.lock, flags);
+=09}
+}
+
+void mausb_release_ma_dev_async(struct kref *kref)
+{
+=09struct mausb_device *dev =3D container_of(kref, struct mausb_device,
+=09=09=09=09=09=09refcount);
+
+=09mausb_pr_info("Scheduling work for MAUSB device to be deleted");
+
+=09schedule_work(&dev->madev_delete_work);
+}
+
+int mausb_enqueue_event_from_user(u8 madev_addr, u16 num_of_events,
+=09=09=09=09  u16 num_of_completed)
+{
+=09unsigned long flags;
+=09struct mausb_device *dev;
+
+=09spin_lock_irqsave(&mss.lock, flags);
+=09dev =3D mausb_get_dev_from_addr_unsafe(madev_addr);
+
+=09if (!dev) {
+=09=09spin_unlock_irqrestore(&mss.lock, flags);
+=09=09return -EINVAL;
+=09}
+
+=09spin_lock(&dev->num_of_user_events_lock);
+=09dev->num_of_user_events +=3D num_of_events;
+=09dev->num_of_completed_events +=3D num_of_completed;
+=09spin_unlock(&dev->num_of_user_events_lock);
+=09queue_work(dev->workq, &dev->work);
+=09spin_unlock_irqrestore(&mss.lock, flags);
+
+=09return 0;
+}
+
+int mausb_data_req_enqueue_event(struct mausb_device *dev, u16 ep_handle,
+=09=09=09=09 struct urb *request)
+{
+=09struct mausb_event mausb_event;
+
+=09mausb_event.type   =3D MAUSB_EVENT_TYPE_SEND_DATA_MSG;
+=09mausb_event.status =3D 0;
+
+=09mausb_event.data.transfer_type =3D
+=09=09mausb_transfer_type_from_usb(&request->ep->desc);
+=09mausb_event.data.device_id=09=3D dev->id;
+=09mausb_event.data.ep_handle=09=3D ep_handle;
+=09mausb_event.data.urb=09=09=3D (u64)request;
+=09mausb_event.data.setup_packet=09=3D
+=09=09(usb_endpoint_xfer_control(&request->ep->desc) &&
+=09=09=09request->setup_packet);
+=09mausb_event.data.transfer_size=09=3D request->transfer_buffer_length;
+=09mausb_event.data.direction=09=3D (usb_urb_dir_in(request) ?
+=09=09=09=09=09=09MAUSB_DATA_MSG_DIRECTION_IN :
+=09=09=09=09=09=09MAUSB_DATA_MSG_DIRECTION_OUT);
+=09mausb_event.data.transfer_size +=3D
+=09=09((mausb_event.data.direction =3D=3D MAUSB_DATA_MSG_DIRECTION_OUT &&
+=09=09=09mausb_event.data.setup_packet) ?
+=09=09=09=09MAUSB_CONTROL_SETUP_SIZE : 0);
+=09mausb_event.data.rem_transfer_size =3D mausb_event.data.transfer_size;
+=09mausb_event.data.transfer_flags=09   =3D request->transfer_flags;
+=09mausb_event.data.transfer_eot=09   =3D false;
+=09mausb_event.data.isoch_seg_num=09   =3D (u32)request->number_of_packets=
;
+=09mausb_event.data.recv_buf=09   =3D 0;
+=09mausb_event.data.payload_size=09   =3D
+=09=09(usb_endpoint_xfer_isoc(&request->ep->desc) &&
+=09=09 usb_endpoint_dir_out(&request->ep->desc)) ?
+=09=09(request->iso_frame_desc[request->number_of_packets - 1]
+=09=09=09=09=09=09=09=09.offset +
+=09=09 request->iso_frame_desc[request->number_of_packets - 1]
+=09=09=09=09=09=09=09=09.length) : 0;
+
+=09if (mausb_event.data.setup_packet) {
+=09=09memcpy(mausb_event.data.hdr_ack, request->setup_packet,
+=09=09       MAUSB_CONTROL_SETUP_SIZE);
+=09=09memcpy(shift_ptr(mausb_event.data.hdr_ack,
+=09=09=09=09 MAUSB_CONTROL_SETUP_SIZE),
+=09=09       &request->dev->route, sizeof(request->dev->route));
+=09}
+
+=09return 0;
+}
+
+void mausb_complete_request(struct urb *urb, u32 actual_length, int status=
)
+{
+=09mausb_hcd_urb_complete(urb, actual_length, status);
+}
+
+int mausb_signal_event(struct mausb_device *dev,
+=09=09       struct mausb_event *event, u64 event_id)
+{
+=09unsigned long flags;
+=09struct mausb_completion *mausb_completion;
+
+=09spin_lock_irqsave(&dev->completion_events_lock, flags);
+=09list_for_each_entry(mausb_completion, &dev->completion_events,
+=09=09=09    list_entry) {
+=09=09if (mausb_completion->event_id =3D=3D event_id) {
+=09=09=09memcpy(mausb_completion->mausb_event, event,
+=09=09=09       sizeof(*event));
+=09=09=09complete(mausb_completion->completion_event);
+=09=09=09spin_unlock_irqrestore(&dev->completion_events_lock,
+=09=09=09=09=09       flags);
+=09=09=09return 0;
+=09=09}
+=09}
+=09spin_unlock_irqrestore(&dev->completion_events_lock, flags);
+
+=09return -ETIMEDOUT;
+}
+
+void mausb_reset_connection_timer(struct mausb_device *dev)
+{
+=09unsigned long flags =3D 0;
+
+=09spin_lock_irqsave(&dev->connection_timer_lock, flags);
+=09dev->receive_failures_num =3D 0;
+
+=09mod_timer(&dev->connection_timer, jiffies + msecs_to_jiffies(1000));
+
+=09spin_unlock_irqrestore(&dev->connection_timer_lock, flags);
+}
+
+static int mausb_start_heartbeat_timer(void)
+{
+=09unsigned long flags =3D 0;
+
+=09spin_lock_irqsave(&mss.lock, flags);
+=09if (++mss.missed_heartbeats > MAUSB_MAX_MISSED_HEARTBEATS) {
+=09=09mausb_pr_err("Missed more than %d heartbeats",
+=09=09=09     MAUSB_MAX_MISSED_HEARTBEATS);
+=09=09spin_unlock_irqrestore(&mss.lock, flags);
+=09=09return -ETIMEDOUT;
+=09}
+
+=09spin_unlock_irqrestore(&mss.lock, flags);
+=09mod_timer(&mss.heartbeat_timer,
+=09=09  jiffies + msecs_to_jiffies(MAUSB_HEARTBEAT_TIMEOUT_MS));
+
+=09return 0;
+}
+
+void mausb_reset_heartbeat_cnt(void)
+{
+=09unsigned long flags =3D 0;
+
+=09spin_lock_irqsave(&mss.lock, flags);
+=09mss.missed_heartbeats =3D 0;
+=09spin_unlock_irqrestore(&mss.lock, flags);
+}
+
+static void mausb_execute_urb_dequeue(struct work_struct *dequeue_work)
+{
+=09struct mausb_urb_ctx *urb_ctx =3D
+=09=09=09container_of(dequeue_work, struct mausb_urb_ctx, work);
+=09struct urb=09=09  *urb =3D urb_ctx->urb;
+=09struct mausb_endpoint_ctx *ep_ctx;
+=09struct mausb_device=09  *ma_dev;
+=09struct mausb_event=09  mausb_event;
+=09int status =3D 0;
+
+=09ep_ctx =3D urb->ep->hcpriv;
+=09ma_dev =3D ep_ctx->ma_dev;
+
+=09if (atomic_read(&ma_dev->unresponsive_client)) {
+=09=09mausb_pr_err("Client is not responsive anymore - finish urb immediat=
ely urb=3D%p, ep_handle=3D%#x, dev_handle=3D%#x",
+=09=09=09     urb, ep_ctx->ep_handle, ep_ctx->dev_handle);
+=09=09goto complete_urb;
+=09}
+
+=09mausb_pr_debug("urb=3D%p, ep_handle=3D%#x, dev_handle=3D%#x",
+=09=09       urb, ep_ctx->ep_handle, ep_ctx->dev_handle);
+
+=09memset(&mausb_event, 0, sizeof(mausb_event));
+
+=09mausb_event.type   =3D MAUSB_EVENT_TYPE_DELETE_DATA_TRANSFER;
+=09mausb_event.status =3D 0;
+
+=09mausb_event.data.transfer_type =3D
+=09=09=09=09mausb_transfer_type_from_usb(&urb->ep->desc);
+=09mausb_event.data.device_id     =3D ma_dev->id;
+=09mausb_event.data.ep_handle     =3D ep_ctx->ep_handle;
+=09mausb_event.data.urb=09       =3D (u64)urb;
+=09mausb_event.data.direction     =3D (usb_urb_dir_in(urb) ?
+=09=09=09=09=09=09MAUSB_DATA_MSG_DIRECTION_IN :
+=09=09=09=09=09=09MAUSB_DATA_MSG_DIRECTION_OUT);
+
+=09if (!mausb_return_urb_ctx_to_tree(urb_ctx, false)) {
+=09=09mausb_pr_alert("Failed to insert in tree urb=3D%p ep_handle=3D%#x, s=
tatus=3D%d",
+=09=09=09       urb, mausb_event.data.ep_handle, status);
+=09=09goto complete_urb;
+=09}
+
+=09return;
+
+complete_urb:
+
+=09/* Deallocate urb_ctx */
+=09mausb_uninit_data_iterator(&urb_ctx->iterator);
+=09kfree(urb_ctx);
+
+=09urb->status=09   =3D -EPROTO;
+=09urb->actual_length =3D 0;
+=09atomic_dec(&urb->use_count);
+=09usb_hcd_giveback_urb(urb->hcpriv, urb, urb->status);
+}
+
+void mausb_initialize_mss(void)
+{
+=09spin_lock_init(&mss.lock);
+=09INIT_LIST_HEAD(&mss.madev_list);
+=09INIT_LIST_HEAD(&mss.available_ring_buffers);
+
+=09init_completion(&mss.empty);
+=09complete(&mss.empty);
+=09init_completion(&mss.rings_events.mausb_ring_has_events);
+=09atomic_set(&mss.rings_events.mausb_stop_reading_ring_events, 0);
+=09mss.deinit_in_progress=09=3D false;
+=09mss.ring_buffer_id=09=3D 0;
+=09mss.client_connected =3D false;
+=09mss.missed_heartbeats =3D 0;
+=09init_completion(&mss.client_stopped);
+=09atomic_set(&mss.num_of_transitions_to_sleep, 0);
+
+=09timer_setup(&mss.heartbeat_timer, mausb_heartbeat_timer_func, 0);
+}
+
+void mausb_deinitialize_mss(void)
+{
+=09struct mausb_device *dev =3D NULL;
+=09unsigned long flags =3D 0;
+=09unsigned long timeout =3D
+=09=09=09msecs_to_jiffies(MAUSB_CLIENT_STOPPED_TIMEOUT_MS);
+
+=09spin_lock_irqsave(&mss.lock, flags);
+
+=09mss.deinit_in_progress =3D true;
+
+=09list_for_each_entry(dev, &mss.madev_list, list_entry) {
+=09=09mausb_pr_debug("Enqueue mausb_hcd_disconnect_work madev_addr=3D%x",
+=09=09=09       dev->madev_addr);
+=09=09queue_work(dev->workq, &dev->hcd_disconnect_work);
+=09}
+
+=09spin_unlock_irqrestore(&mss.lock, flags);
+
+=09wait_for_completion(&mss.empty);
+=09mausb_pr_debug("Waiting for completion on disconnect_event ended");
+
+=09timeout =3D wait_for_completion_timeout(&mss.client_stopped, timeout);
+=09mausb_pr_info("Remaining time after waiting for stopping client %ld",
+=09=09      timeout);
+}
+
+int mausb_register_power_state_listener(void)
+{
+=09mausb_pr_info("Registering power states listener");
+
+=09mhcd->power_state_listener.notifier_call =3D mausb_power_state_cb;
+=09return register_pm_notifier(&mhcd->power_state_listener);
+}
+
+void mausb_unregister_power_state_listener(void)
+{
+=09mausb_pr_info("Un-registering power states listener");
+
+=09unregister_pm_notifier(&mhcd->power_state_listener);
+}
+
+static int mausb_power_state_cb(struct notifier_block *nb, unsigned long a=
ction,
+=09=09=09=09void *data)
+{
+=09unsigned long flags =3D 0;
+=09struct mausb_device *dev =3D NULL;
+
+=09mausb_pr_info("Power state callback action =3D %ld", action);
+=09if (action =3D=3D PM_SUSPEND_PREPARE || action =3D=3D PM_HIBERNATION_PR=
EPARE) {
+=09=09/* Stop heartbeat timer */
+=09=09del_timer_sync(&mss.heartbeat_timer);
+=09=09mausb_pr_info("Saving state before sleep");
+=09=09spin_lock_irqsave(&mss.lock, flags);
+=09=09if (!list_empty(&mss.madev_list))
+=09=09=09atomic_inc(&mss.num_of_transitions_to_sleep);
+
+=09=09list_for_each_entry(dev, &mss.madev_list, list_entry) {
+=09=09=09mausb_pr_info("Enqueue heartbeat_work madev_addr=3D%x",
+=09=09=09=09      dev->madev_addr);
+=09=09=09queue_work(dev->workq, &dev->heartbeat_work);
+=09=09}
+
+=09=09spin_unlock_irqrestore(&mss.lock, flags);
+=09} else if (action =3D=3D PM_POST_SUSPEND || action =3D=3D PM_POST_HIBER=
NATION) {
+=09=09mausb_reset_heartbeat_cnt();
+=09=09/* Start hearbeat timer */
+=09=09mod_timer(&mss.heartbeat_timer, jiffies +
+=09=09=09  msecs_to_jiffies(MAUSB_HEARTBEAT_TIMEOUT_MS));
+=09}
+=09return NOTIFY_OK;
+}
+
+static void mausb_populate_standard_ep_descriptor(struct usb_ep_desc *std_=
desc,
+=09=09=09=09=09=09  struct usb_endpoint_descriptor
+=09=09=09=09=09=09  *usb_std_desc)
+{
+=09std_desc->bLength=09   =3D usb_std_desc->bLength;
+=09std_desc->bDescriptorType  =3D usb_std_desc->bDescriptorType;
+=09std_desc->bEndpointAddress =3D usb_std_desc->bEndpointAddress;
+=09std_desc->bmAttributes=09   =3D usb_std_desc->bmAttributes;
+=09std_desc->wMaxPacketSize   =3D usb_std_desc->wMaxPacketSize;
+=09std_desc->bInterval=09   =3D usb_std_desc->bInterval;
+}
+
+static void
+mausb_populate_superspeed_ep_descriptor(struct usb_ss_ep_comp_desc *ss_des=
c,
+=09=09=09=09=09struct usb_ss_ep_comp_descriptor*
+=09=09=09=09=09usb_ss_desc)
+{
+=09ss_desc->bLength=09   =3D usb_ss_desc->bLength;
+=09ss_desc->bDescriptorType   =3D usb_ss_desc->bDescriptorType;
+=09ss_desc->bMaxBurst=09   =3D usb_ss_desc->bMaxBurst;
+=09ss_desc->bmAttributes=09   =3D usb_ss_desc->bmAttributes;
+=09ss_desc->wBytesPerInterval =3D usb_ss_desc->wBytesPerInterval;
+}
+
+void
+mausb_init_standard_ep_descriptor(struct ma_usb_ephandlereq_desc_std *std_=
desc,
+=09=09=09=09  struct usb_endpoint_descriptor *usb_std_desc)
+{
+=09mausb_populate_standard_ep_descriptor(&std_desc->usb20, usb_std_desc);
+}
+
+void
+mausb_init_superspeed_ep_descriptor(struct ma_usb_ephandlereq_desc_ss *ss_=
desc,
+=09=09=09=09    struct usb_endpoint_descriptor *
+=09=09=09=09    usb_std_desc,
+=09=09=09=09    struct usb_ss_ep_comp_descriptor *
+=09=09=09=09    usb_ss_desc)
+{
+=09mausb_populate_standard_ep_descriptor(&ss_desc->usb20, usb_std_desc);
+=09mausb_populate_superspeed_ep_descriptor(&ss_desc->usb31, usb_ss_desc);
+}
+
+struct mausb_device *mausb_get_dev_from_addr_unsafe(u8 madev_addr)
+{
+=09struct mausb_device *dev =3D NULL;
+
+=09list_for_each_entry(dev, &mss.madev_list, list_entry) {
+=09=09if (dev->madev_addr =3D=3D madev_addr)
+=09=09=09return dev;
+=09}
+
+=09return NULL;
+}
+
+static inline
+struct mausb_ip_ctx *mausb_get_data_channel(struct mausb_device *ma_dev,
+=09=09=09=09=09    enum mausb_channel channel)
+{
+=09if (channel >=3D MAUSB_CHANNEL_MAP_LENGTH)
+=09=09return NULL;
+
+=09return ma_dev->channel_map[channel];
+}
+
+int mausb_send_data(struct mausb_device *dev, enum mausb_channel channel_n=
um,
+=09=09    struct mausb_kvec_data_wrapper *data)
+{
+=09struct mausb_ip_ctx *channel =3D mausb_get_data_channel(dev, channel_nu=
m);
+=09int status =3D 0;
+
+=09if (!channel)
+=09=09return -ECHRNG;
+
+=09status =3D mausb_ip_send(channel, data);
+
+=09if (status < 0) {
+=09=09mausb_pr_err("Send failed. Disconnecting... status=3D%d", status);
+=09=09queue_work(dev->workq, &dev->socket_disconnect_work);
+=09=09queue_work(dev->workq, &dev->hcd_disconnect_work);
+=09}
+
+=09return status;
+}
+
+int mausb_send_transfer_ack(struct mausb_device *dev, struct mausb_event *=
event)
+{
+=09struct ma_usb_hdr_common *ack_hdr;
+=09struct kvec kvec;
+=09struct mausb_kvec_data_wrapper data_to_send;
+=09enum mausb_channel channel;
+
+=09ack_hdr =3D (struct ma_usb_hdr_common *)(&event->data.hdr_ack);
+
+=09data_to_send.kvec=09    =3D &kvec;
+=09data_to_send.kvec->iov_base =3D ack_hdr;
+=09data_to_send.kvec->iov_len  =3D ack_hdr->length;
+=09data_to_send.kvec_num=09    =3D 1;
+=09data_to_send.length=09    =3D ack_hdr->length;
+
+=09channel =3D mausb_transfer_type_to_channel(event->data.transfer_type);
+=09return mausb_send_data(dev, channel, &data_to_send);
+}
+
+int mausb_send_data_msg(struct mausb_device *dev, struct mausb_event *even=
t)
+{
+=09struct mausb_urb_ctx *urb_ctx;
+=09int status =3D 0;
+
+=09if (event->status !=3D 0) {
+=09=09mausb_pr_err("Event %d failed with status %d",
+=09=09=09     event->type, event->status);
+=09=09mausb_complete_urb(event);
+=09=09return event->status;
+=09}
+
+=09urb_ctx =3D mausb_find_urb_in_tree((struct urb *)event->data.urb);
+
+=09if (!urb_ctx) {
+=09=09/* Transfer will be deleted from dequeue task */
+=09=09mausb_pr_warn("Urb is already cancelled for event=3D%d",
+=09=09=09      event->type);
+=09=09return status;
+=09}
+
+=09return status;
+}
+
+int mausb_receive_data_msg(struct mausb_device *dev, struct mausb_event *e=
vent)
+{
+=09int status =3D 0;
+=09struct mausb_urb_ctx *urb_ctx;
+
+=09mausb_pr_debug("Direction=3D%d", event->data.direction);
+
+=09if (!mausb_isoch_data_event(event)) {
+=09=09status =3D mausb_send_transfer_ack(dev, event);
+=09=09if (status < 0) {
+=09=09=09mausb_pr_warn("Sending acknowledgment failed");
+=09=09=09goto cleanup;
+=09=09}
+=09}
+
+=09urb_ctx =3D mausb_find_urb_in_tree((struct urb *)event->data.urb);
+
+=09if (!urb_ctx)
+=09=09mausb_pr_warn("Urb is already cancelled");
+
+cleanup:
+=09mausb_release_event_resources(event);
+=09return status;
+}
+
+int mausb_add_data_chunk(void *buffer, u32 buffer_size,
+=09=09=09 struct list_head *chunks_list)
+{
+=09struct mausb_payload_chunk *data_chunk;
+
+=09data_chunk =3D kzalloc(sizeof(*data_chunk), GFP_KERNEL);
+=09if (!data_chunk)
+=09=09return -ENOMEM;
+
+=09/* Initialize data chunk for MAUSB header and add it to chunks list */
+=09INIT_LIST_HEAD(&data_chunk->list_entry);
+
+=09data_chunk->kvec.iov_base =3D buffer;
+=09data_chunk->kvec.iov_len  =3D buffer_size;
+=09list_add_tail(&data_chunk->list_entry, chunks_list);
+=09return 0;
+}
+
+int mausb_init_data_wrapper(struct mausb_kvec_data_wrapper *data,
+=09=09=09    struct list_head *chunks_list,
+=09=09=09    u32 num_of_data_chunks)
+{
+=09struct mausb_payload_chunk *data_chunk =3D NULL;
+=09struct mausb_payload_chunk *tmp =3D NULL;
+=09u32 current_kvec =3D 0;
+
+=09data->length =3D 0;
+=09data->kvec =3D kcalloc(num_of_data_chunks, sizeof(struct kvec),
+=09=09=09     GFP_KERNEL);
+=09if (!data->kvec)
+=09=09return -ENOMEM;
+
+=09list_for_each_entry_safe(data_chunk, tmp, chunks_list, list_entry) {
+=09=09data->kvec[current_kvec].iov_base =3D
+=09=09=09data_chunk->kvec.iov_base;
+=09=09data->kvec[current_kvec].iov_len =3D
+=09=09    data_chunk->kvec.iov_len;
+=09=09++data->kvec_num;
+=09=09data->length +=3D data_chunk->kvec.iov_len;
+=09=09++current_kvec;
+=09}
+=09return 0;
+}
+
+void mausb_cleanup_chunks_list(struct list_head *chunks_list)
+{
+=09struct mausb_payload_chunk *data_chunk =3D NULL;
+=09struct mausb_payload_chunk *tmp =3D NULL;
+
+=09list_for_each_entry_safe(data_chunk, tmp, chunks_list, list_entry) {
+=09=09list_del(&data_chunk->list_entry);
+=09=09kfree(data_chunk);
+=09}
+}
+
+static int mausb_read_virtual_buffer(struct mausb_data_iter *iterator,
+=09=09=09=09     u32 byte_num,
+=09=09=09=09     struct list_head *data_chunks_list,
+=09=09=09=09     u32 *data_chunks_num)
+{
+=09u32 rem_data=09=09=3D 0;
+=09u32 bytes_to_read=09=3D 0;
+=09struct mausb_payload_chunk *data_chunk =3D NULL;
+
+=09(*data_chunks_num) =3D 0;
+
+=09if (!data_chunks_list)
+=09=09return -EINVAL;
+
+=09INIT_LIST_HEAD(data_chunks_list);
+=09rem_data      =3D iterator->length - iterator->offset;
+=09bytes_to_read =3D min(byte_num, rem_data);
+
+=09if (bytes_to_read =3D=3D 0)
+=09=09return 0;
+
+=09data_chunk =3D kzalloc(sizeof(*data_chunk), GFP_KERNEL);
+
+=09if (!data_chunk)
+=09=09return -ENOMEM;
+
+=09++(*data_chunks_num);
+
+=09data_chunk->kvec.iov_base =3D (u8 *)(iterator->buffer) + iterator->offs=
et;
+=09data_chunk->kvec.iov_len =3D bytes_to_read;
+=09iterator->offset +=3D bytes_to_read;
+
+=09list_add_tail(&data_chunk->list_entry, data_chunks_list);
+
+=09return 0;
+}
+
+static int mausb_read_scatterlist_buffer(struct mausb_data_iter *iterator,
+=09=09=09=09=09 u32 byte_num,
+=09=09=09=09=09 struct list_head *data_chunks_list,
+=09=09=09=09=09 u32 *data_chunks_num)
+{
+=09u32 current_sg_read_num;
+=09struct mausb_payload_chunk *data_chunk =3D NULL;
+
+=09(*data_chunks_num) =3D 0;
+
+=09if (!data_chunks_list)
+=09=09return -EINVAL;
+
+=09INIT_LIST_HEAD(data_chunks_list);
+
+=09while (byte_num) {
+=09=09if (iterator->sg_iter.consumed =3D=3D iterator->sg_iter.length) {
+=09=09=09if (!sg_miter_next(&iterator->sg_iter))
+=09=09=09=09break;
+=09=09=09iterator->sg_iter.consumed =3D 0;
+=09=09}
+
+=09=09data_chunk =3D kzalloc(sizeof(*data_chunk), GFP_KERNEL);
+=09=09if (!data_chunk) {
+=09=09=09sg_miter_stop(&iterator->sg_iter);
+=09=09=09return -ENOMEM;
+=09=09}
+
+=09=09current_sg_read_num =3D min((size_t)byte_num,
+=09=09=09=09=09  iterator->sg_iter.length -
+=09=09=09=09=09  iterator->sg_iter.consumed);
+
+=09=09data_chunk->kvec.iov_base =3D (u8 *)iterator->sg_iter.addr +
+=09=09=09=09iterator->sg_iter.consumed;
+=09=09data_chunk->kvec.iov_len  =3D current_sg_read_num;
+
+=09=09++(*data_chunks_num);
+=09=09list_add_tail(&data_chunk->list_entry, data_chunks_list);
+
+=09=09byte_num -=3D current_sg_read_num;
+=09=09iterator->sg_iter.consumed +=3D current_sg_read_num;
+=09=09data_chunk =3D NULL;
+=09}
+
+=09return 0;
+}
+
+static u32 mausb_write_virtual_buffer(struct mausb_data_iter *iterator,
+=09=09=09=09      void *buffer, u32 size)
+{
+=09u32 rem_space   =3D 0;
+=09u32 write_count =3D 0;
+
+=09if (!buffer || !size)
+=09=09return write_count;
+
+=09rem_space   =3D iterator->length - iterator->offset;
+=09write_count =3D min(size, rem_space);
+
+=09if (write_count > 0) {
+=09=09void *location =3D shift_ptr(iterator->buffer, iterator->offset);
+
+=09=09memcpy(location, buffer, write_count);
+=09=09iterator->offset +=3D write_count;
+=09}
+
+=09return write_count;
+}
+
+static u32 mausb_write_scatterlist_buffer(struct mausb_data_iter *iterator=
,
+=09=09=09=09=09  void *buffer, u32 size)
+{
+=09u32 current_sg_rem_space;
+=09u32 count =3D 0;
+=09u32 total_count =3D 0;
+=09void *location =3D NULL;
+
+=09if (!buffer || !size)
+=09=09return count;
+
+=09while (size) {
+=09=09if (iterator->sg_iter.consumed >=3D iterator->sg_iter.length) {
+=09=09=09if (!sg_miter_next(&iterator->sg_iter))
+=09=09=09=09break;
+=09=09=09iterator->sg_iter.consumed =3D 0;
+=09=09}
+
+=09=09current_sg_rem_space =3D (u32)(iterator->sg_iter.length -
+=09=09=09iterator->sg_iter.consumed);
+
+=09=09count =3D min(size, current_sg_rem_space);
+=09=09total_count +=3D count;
+
+=09=09location =3D shift_ptr(iterator->sg_iter.addr,
+=09=09=09=09     iterator->sg_iter.consumed);
+
+=09=09memcpy(location, buffer, count);
+
+=09=09buffer =3D shift_ptr(buffer, count);
+=09=09size -=3D count;
+=09=09iterator->sg_iter.consumed +=3D count;
+=09}
+
+=09return total_count;
+}
+
+int mausb_data_iterator_read(struct mausb_data_iter *iterator,
+=09=09=09     u32 byte_num,
+=09=09=09     struct list_head *data_chunks_list,
+=09=09=09     u32 *data_chunks_num)
+{
+=09if (iterator->buffer)
+=09=09return mausb_read_virtual_buffer(iterator, byte_num,
+=09=09=09=09=09=09 data_chunks_list,
+=09=09=09=09=09=09 data_chunks_num);
+=09else
+=09=09return mausb_read_scatterlist_buffer(iterator, byte_num,
+=09=09=09=09=09=09     data_chunks_list,
+=09=09=09=09=09=09     data_chunks_num);
+}
+
+u32 mausb_data_iterator_write(struct mausb_data_iter *iterator, void *buff=
er,
+=09=09=09      u32 length)
+{
+=09if (iterator->buffer)
+=09=09return mausb_write_virtual_buffer(iterator, buffer, length);
+=09else
+=09=09return mausb_write_scatterlist_buffer(iterator, buffer, length);
+}
+
+static inline void mausb_seek_virtual_buffer(struct mausb_data_iter *itera=
tor,
+=09=09=09=09=09     u32 seek_delta)
+{
+=09iterator->offset +=3D min(seek_delta, iterator->length -
+=09=09=09=09=09    iterator->offset);
+}
+
+static void mausb_seek_scatterlist_buffer(struct mausb_data_iter *iterator=
,
+=09=09=09=09=09  u32 seek_delta)
+{
+=09u32 rem_bytes_in_current_scatter;
+
+=09while (seek_delta) {
+=09=09rem_bytes_in_current_scatter =3D (u32)(iterator->sg_iter.length -
+=09=09=09=09=09=09iterator->sg_iter.consumed);
+=09=09if (rem_bytes_in_current_scatter <=3D seek_delta) {
+=09=09=09iterator->sg_iter.consumed +=3D
+=09=09=09    rem_bytes_in_current_scatter;
+=09=09=09seek_delta -=3D rem_bytes_in_current_scatter;
+=09=09=09if (!sg_miter_next(&iterator->sg_iter))
+=09=09=09=09break;
+=09=09=09iterator->sg_iter.consumed =3D 0;
+=09=09} else {
+=09=09=09iterator->sg_iter.consumed +=3D seek_delta;
+=09=09=09break;
+=09=09}
+=09}
+}
+
+void mausb_data_iterator_seek(struct mausb_data_iter *iterator,
+=09=09=09      u32 seek_delta)
+{
+=09if (iterator->buffer)
+=09=09mausb_seek_virtual_buffer(iterator, seek_delta);
+=09else
+=09=09mausb_seek_scatterlist_buffer(iterator, seek_delta);
+}
+
+static void mausb_calculate_buffer_length(struct mausb_data_iter *iterator=
)
+{
+=09/* Calculate buffer length */
+=09if (iterator->buffer_len > 0) {
+=09=09/* Transfer_buffer_length is populated */
+=09=09iterator->length =3D iterator->buffer_len;
+=09} else if (iterator->sg && iterator->num_sgs !=3D 0) {
+=09=09/* Transfer_buffer_length is not populated */
+=09=09sg_miter_start(&iterator->sg_iter, iterator->sg,
+=09=09=09       iterator->num_sgs, iterator->flags);
+=09=09while (sg_miter_next(&iterator->sg_iter))
+=09=09=09iterator->length +=3D (u32)iterator->sg_iter.length;
+=09=09sg_miter_stop(&iterator->sg_iter);
+=09} else {
+=09=09iterator->length =3D 0;
+=09}
+}
+
+void mausb_init_data_iterator(struct mausb_data_iter *iterator, void *buff=
er,
+=09=09=09      u32 buffer_len, struct scatterlist *sg,
+=09=09=09      unsigned int num_sgs, bool direction)
+{
+=09iterator->offset =3D 0;
+=09iterator->buffer     =3D buffer;
+=09iterator->buffer_len =3D buffer_len;
+=09iterator->length     =3D 0;
+=09iterator->sg=09     =3D sg;
+=09iterator->num_sgs    =3D num_sgs;
+=09iterator->sg_started =3D 0;
+
+=09mausb_calculate_buffer_length(iterator);
+
+=09if (!buffer && sg && num_sgs !=3D 0) {
+=09=09/* Scatterlist provided */
+=09=09iterator->flags =3D direction ? SG_MITER_TO_SG : SG_MITER_FROM_SG;
+=09=09sg_miter_start(&iterator->sg_iter, sg, num_sgs,
+=09=09=09       iterator->flags);
+=09=09iterator->sg_started =3D 1;
+=09}
+}
+
+void mausb_uninit_data_iterator(struct mausb_data_iter *iterator)
+{
+=09iterator->offset     =3D 0;
+=09iterator->length     =3D 0;
+=09iterator->buffer     =3D NULL;
+=09iterator->buffer_len =3D 0;
+
+=09if (iterator->sg_started)
+=09=09sg_miter_stop(&iterator->sg_iter);
+
+=09iterator->sg_started =3D 0;
+}
+
+void mausb_reset_data_iterator(struct mausb_data_iter *iterator)
+{
+=09iterator->offset =3D 0;
+=09if (iterator->sg_started) {
+=09=09sg_miter_stop(&iterator->sg_iter);
+=09=09iterator->sg_started =3D 0;
+=09}
+
+=09if (!iterator->buffer && iterator->sg && iterator->num_sgs !=3D 0) {
+=09=09sg_miter_start(&iterator->sg_iter, iterator->sg,
+=09=09=09       iterator->num_sgs, iterator->flags);
+=09=09iterator->sg_started =3D 1;
+=09}
+}
+
+u32 mausb_data_iterator_length(struct mausb_data_iter *iterator)
+{
+=09return iterator->length;
+}
diff --git a/drivers/usb/mausb_host/hpal.h b/drivers/usb/mausb_host/hpal.h
new file mode 100644
index 000000000000..f184bbc07783
--- /dev/null
+++ b/drivers/usb/mausb_host/hpal.h
@@ -0,0 +1,289 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
+ */
+#ifndef __MAUSB_HPAL_H__
+#define __MAUSB_HPAL_H__
+
+#include <linux/kref.h>
+#include <linux/suspend.h>
+#include <linux/usb.h>
+
+#include "ip_link.h"
+#include "mausb_address.h"
+#include "mausb_event.h"
+
+#define MAUSB_CONTROL_SETUP_SIZE=098
+#define MAUSB_BUSY_RETRIES_COUNT=093
+#define MAUSB_HEARTBEAT_TIMEOUT_MS=091000
+#define MAUSB_CLIENT_STOPPED_TIMEOUT_MS=093000
+
+#define MAUSB_MAX_RECEIVE_FAILURES=093
+#define MAUSB_MAX_MISSED_HEARTBEATS=093
+#define MAUSB_TRANSFER_RESERVED=09=090
+
+#define MAUSB_CHANNEL_MAP_LENGTH=094
+
+extern struct mss mss;
+extern struct mausb_hcd *mhcd;
+
+enum mausb_isoch_header_format_size {
+=09MAUSB_ISOCH_SHORT_FORMAT_SIZE=09 =3D 4,
+=09MAUSB_ISOCH_STANDARD_FORMAT_SIZE =3D 8,
+=09MAUSB_ISOCH_LONG_FORMAT_SIZE=09 =3D 12
+};
+
+struct mausb_completion {
+=09struct list_head   list_entry;
+=09struct completion  *completion_event;
+=09struct mausb_event *mausb_event;
+=09u64=09=09   event_id;
+};
+
+struct mausb_mss_rings_events {
+=09atomic_t=09  mausb_stop_reading_ring_events;
+=09struct completion mausb_ring_has_events;
+};
+
+struct mss {
+=09bool=09   deinit_in_progress;
+=09spinlock_t lock;=09/* Protect mss structure */
+=09u64=09   ring_buffer_id;
+
+=09struct completion empty;
+=09struct completion client_stopped;
+=09bool=09=09  client_connected;
+=09struct timer_list heartbeat_timer;
+=09u8=09=09  missed_heartbeats;
+
+=09struct list_head  madev_list;
+=09atomic_t=09  num_of_transitions_to_sleep;
+=09struct list_head  available_ring_buffers;
+
+=09struct mausb_mss_rings_events=09 rings_events;
+=09struct mausb_events_notification events[MAUSB_MAX_NUM_OF_MA_DEVS];
+};
+
+struct mausb_device {
+=09struct mausb_device_address dev_addr;
+=09struct net=09=09    *net_ns;
+=09struct list_head=09    list_entry;
+
+=09struct mausb_ip_ctx *mgmt_channel;
+=09struct mausb_ip_ctx *ctrl_channel;
+=09struct mausb_ip_ctx *bulk_channel;
+=09struct mausb_ip_ctx *isoch_channel;
+=09struct mausb_ip_ctx *channel_map[MAUSB_CHANNEL_MAP_LENGTH];
+
+=09struct work_struct work;
+=09struct work_struct socket_disconnect_work;
+=09struct work_struct hcd_disconnect_work;
+=09struct work_struct madev_delete_work;
+=09struct work_struct ping_work;
+=09struct work_struct heartbeat_work;
+=09struct workqueue_struct *workq;
+
+=09struct kref refcount;
+=09/* Set on port change event after cap resp */
+=09u8 dev_type;
+=09u8 dev_speed;
+=09u8 lse;
+=09u8 madev_addr;
+=09u8 dev_connected;
+=09u16 id;
+=09u16 port_number;
+
+=09u64=09=09event_id;
+=09spinlock_t=09event_id_lock; /* Lock event ID increments */
+
+=09struct list_head completion_events;
+=09spinlock_t=09 completion_events_lock; /* Lock completion events */
+
+=09struct completion user_finished_event;
+=09u16=09=09  num_of_user_events;
+=09u16=09=09  num_of_completed_events;
+
+=09spinlock_t=09  num_of_user_events_lock; /* Lock user events count */
+
+=09struct timer_list connection_timer;
+=09u8=09=09  receive_failures_num;
+=09spinlock_t=09  connection_timer_lock; /* Lock connection timer */
+
+=09atomic_t=09  unresponsive_client;
+
+=09atomic_t=09  num_of_usb_devices;
+};
+
+struct mausb_urb_ctx *mausb_find_urb_in_tree(struct urb *urb);
+struct mausb_urb_ctx *mausb_unlink_and_delete_urb_from_tree(struct urb *ur=
b,
+=09=09=09=09=09=09=09    int status);
+struct mausb_device *mausb_get_dev_from_addr_unsafe(u8 madev_addr);
+
+static inline u64 mausb_event_id(struct mausb_device *dev)
+{
+=09unsigned long flags;
+=09u64 val;
+
+=09spin_lock_irqsave(&dev->event_id_lock, flags);
+=09val =3D ++(dev->event_id);
+=09spin_unlock_irqrestore(&dev->event_id_lock, flags);
+
+=09return val;
+}
+
+int mausb_data_req_enqueue_event(struct mausb_device *dev, u16 ep_handle,
+=09=09=09=09 struct urb *request);
+int mausb_signal_event(struct mausb_device *dev, struct mausb_event *event=
,
+=09=09       u64 event_id);
+int mausb_insert_urb_in_tree(struct urb *urb, bool link_urb_to_ep);
+
+static inline void mausb_insert_event(struct mausb_device *dev,
+=09=09=09=09      struct mausb_completion *event)
+{
+=09unsigned long flags;
+
+=09spin_lock_irqsave(&dev->completion_events_lock, flags);
+=09list_add_tail(&event->list_entry, &dev->completion_events);
+=09spin_unlock_irqrestore(&dev->completion_events_lock, flags);
+}
+
+static inline void mausb_remove_event(struct mausb_device *dev,
+=09=09=09=09      struct mausb_completion *event)
+{
+=09unsigned long flags;
+
+=09spin_lock_irqsave(&dev->completion_events_lock, flags);
+=09list_del(&event->list_entry);
+=09spin_unlock_irqrestore(&dev->completion_events_lock, flags);
+}
+
+void mausb_release_ma_dev_async(struct kref *kref);
+void mausb_complete_request(struct urb *urb, u32 actual_length, int status=
);
+void mausb_complete_urb(struct mausb_event *event);
+void mausb_reset_connection_timer(struct mausb_device *dev);
+void mausb_reset_heartbeat_cnt(void);
+void mausb_release_event_resources(struct mausb_event  *event);
+void mausb_initialize_mss(void);
+void mausb_deinitialize_mss(void);
+int mausb_register_power_state_listener(void);
+void mausb_unregister_power_state_listener(void);
+
+void mausb_init_standard_ep_descriptor(struct ma_usb_ephandlereq_desc_std =
*
+=09=09=09=09       std_desc,
+=09=09=09=09       struct usb_endpoint_descriptor *
+=09=09=09=09       usb_std_desc);
+void mausb_init_superspeed_ep_descriptor(struct ma_usb_ephandlereq_desc_ss=
 *
+=09=09=09=09=09 ss_desc,
+=09=09=09=09=09 struct usb_endpoint_descriptor *
+=09=09=09=09=09 usb_std_desc,
+=09=09=09=09=09 struct usb_ss_ep_comp_descriptor *
+=09=09=09=09=09 usb_ss_desc);
+
+int mausb_send_data(struct mausb_device *dev, enum mausb_channel channel_n=
um,
+=09=09    struct mausb_kvec_data_wrapper *data);
+
+int mausb_send_transfer_ack(struct mausb_device *dev,
+=09=09=09    struct mausb_event *event);
+
+int mausb_send_data_msg(struct mausb_device *dev, struct mausb_event *even=
t);
+
+int mausb_receive_data_msg(struct mausb_device *dev, struct mausb_event *e=
vent);
+
+int mausb_add_data_chunk(void *buffer, u32 buffer_size,
+=09=09=09 struct list_head *chunks_list);
+
+int mausb_init_data_wrapper(struct mausb_kvec_data_wrapper *data,
+=09=09=09    struct list_head *chunks_list,
+=09=09=09    u32 num_of_data_chunks);
+
+void mausb_cleanup_chunks_list(struct list_head *chunks_list);
+
+static inline bool mausb_ctrl_transfer(struct ma_usb_hdr_common *hdr)
+{
+=09return (hdr->data.t_flags & MA_USB_DATA_TFLAGS_TRANSFER_TYPE_MASK) =3D=
=3D
+=09=09MA_USB_DATA_TFLAGS_TRANSFER_TYPE_CTRL;
+}
+
+static inline bool mausb_isoch_transfer(struct ma_usb_hdr_common *hdr)
+{
+=09return (hdr->data.t_flags & MA_USB_DATA_TFLAGS_TRANSFER_TYPE_MASK) =3D=
=3D
+=09=09MA_USB_DATA_TFLAGS_TRANSFER_TYPE_ISOCH;
+}
+
+static inline bool mausb_ctrl_data_event(struct mausb_event *event)
+{
+=09return event->data.transfer_type =3D=3D
+=09=09MA_USB_DATA_TFLAGS_TRANSFER_TYPE_CTRL;
+}
+
+static inline bool mausb_isoch_data_event(struct mausb_event *event)
+{
+=09return event->data.transfer_type =3D=3D
+=09=09MA_USB_DATA_TFLAGS_TRANSFER_TYPE_ISOCH;
+}
+
+/* usb to mausb transfer type */
+static inline
+u8 mausb_transfer_type_from_usb(struct usb_endpoint_descriptor *epd)
+{
+=09return (u8)usb_endpoint_type(epd) << 3;
+}
+
+static inline u8 mausb_transfer_type_from_hdr(struct ma_usb_hdr_common *hd=
r)
+{
+=09return hdr->data.t_flags & MA_USB_DATA_TFLAGS_TRANSFER_TYPE_MASK;
+}
+
+static inline
+enum mausb_channel mausb_transfer_type_to_channel(u8 transfer_type)
+{
+=09return transfer_type >> 3;
+}
+
+struct mausb_data_iter {
+=09u32 length;
+
+=09void *buffer;
+=09u32  buffer_len;
+=09u32  offset;
+
+=09struct scatterlist=09*sg;
+=09struct sg_mapping_iter=09sg_iter;
+=09bool=09=09sg_started;
+=09unsigned int=09num_sgs;
+=09unsigned int=09flags;
+};
+
+struct mausb_payload_chunk {
+=09struct list_head list_entry;
+=09struct kvec=09 kvec;
+};
+
+int mausb_data_iterator_read(struct mausb_data_iter *iterator,
+=09=09=09     u32 byte_num,
+=09=09=09     struct list_head *data_chunks_list,
+=09=09=09     u32 *data_chunks_num);
+
+u32 mausb_data_iterator_length(struct mausb_data_iter *iterator);
+u32 mausb_data_iterator_write(struct mausb_data_iter *iterator, void *buff=
er,
+=09=09=09      u32 length);
+
+void mausb_init_data_iterator(struct mausb_data_iter *iterator,
+=09=09=09      void *buffer, u32 buffer_len,
+=09=09=09      struct scatterlist *sg, unsigned int num_sgs,
+=09=09=09      bool direction);
+void mausb_reset_data_iterator(struct mausb_data_iter *iterator);
+void mausb_uninit_data_iterator(struct mausb_data_iter *iterator);
+void mausb_data_iterator_seek(struct mausb_data_iter *iterator, u32 seek_d=
elta);
+
+static inline unsigned int mausb_get_page_order(unsigned int num_of_elems,
+=09=09=09=09=09=09unsigned int elem_size)
+{
+=09unsigned int num_of_pages =3D DIV_ROUND_UP(num_of_elems * elem_size,
+=09=09=09=09=09=09 PAGE_SIZE);
+=09unsigned int order =3D (unsigned int)ilog2(num_of_pages) +
+=09=09=09=09=09(is_power_of_2(num_of_pages) ? 0 : 1);
+=09return order;
+}
+
+#endif /* __MAUSB_HPAL_H__ */
diff --git a/drivers/usb/mausb_host/ma_usb.h b/drivers/usb/mausb_host/ma_us=
b.h
new file mode 100644
index 000000000000..65f6229c0dfe
--- /dev/null
+++ b/drivers/usb/mausb_host/ma_usb.h
@@ -0,0 +1,869 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
+ */
+#ifndef __MAUSB_MA_USB_H__
+#define __MAUSB_MA_USB_H__
+
+#ifdef __KERNEL__
+#include <linux/types.h>
+#else
+#include <types.h>
+#endif /* __KERNEL__ */
+
+#define MA_USB_SET_FIELD_(_m_, _v) __mausb_set_field(MA_USB_##_m_##_MASK, =
_v)
+#define MA_USB_GET_FIELD_(_m_, _v) __mausb_get_field(MA_USB_##_m_##_MASK, =
_v)
+#define MA_USB_SET_FIELD(_m_, _v) __mausb_set_field(MA_USB_##_m_##_MASK, \
+=09=09=09=09=09=09    MA_USB_##_v)
+#define MA_USB_GET_FIELD(_m_, _v) __mausb_get_field(MA_USB_##_m_##_MASK, \
+=09=09=09=09=09=09    MA_USB_##_v)
+
+#define MA_USB_MGMT_TOKEN_RESERVED  0
+#define MA_USB_MGMT_TOKEN_MIN       1
+#define MA_USB_MGMT_TOKEN_MAX       ((1 << 10) - 1)
+
+#define MA_USB_DATA_EPS_UNASSIGNED  0
+#define MA_USB_DATA_EPS_ACTIVE      1
+#define MA_USB_DATA_EPS_INACTIVE    2
+#define MA_USB_DATA_EPS_HALTED      3
+
+#define MA_USB_DATA_TFLAGS_ARQ      1
+#define MA_USB_DATA_TFLAGS_NEG      2
+#define MA_USB_DATA_TFLAGS_EOT      4
+#define MA_USB_DATA_TFLAGS_TRANSFER_TYPE_CTRL   0
+#define MA_USB_DATA_TFLAGS_TRANSFER_TYPE_ISOCH  8
+#define MA_USB_DATA_TFLAGS_TRANSFER_TYPE_BULK   16
+#define MA_USB_DATA_TFLAGS_TRANSFER_TYPE_INTR   24
+
+#define MA_USB_DATA_TFLAGS_TRANSFER_TYPE_MASK   0x18
+
+#define MA_USB_DATA_IFLAGS_MTD_VALID      1
+#define MA_USB_DATA_IFLAGS_HDR_FMT_SHORT  0
+#define MA_USB_DATA_IFLAGS_HDR_FMT_STD    2
+#define MA_USB_DATA_IFLAGS_HDR_FMT_LONG   4
+#define MA_USB_DATA_IFLAGS_IRS_FMT_STD    0
+#define MA_USB_DATA_IFLAGS_IRS_FMT_LONG   2
+#define MA_USB_DATA_IFLAGS_ASAP           8
+
+#define MA_USB_DATA_IFLAGS_FMT_MASK       0x6
+
+/* version */
+
+#define MA_USB_HDR_VERSION_1_0      0
+
+/* flags */
+
+#define MA_USB_HDR_FLAGS_HOST       1
+#define MA_USB_HDR_FLAGS_RETRY      2
+#define MA_USB_HDR_FLAGS_TIMESTAMP  4
+#define MA_USB_HDR_FLAGS_RESERVED   8
+#define MA_USB_HDR_FLAG(_f) MA_USB_HDR_FLAGS_##_f
+
+/* type and subtype */
+
+#define MA_USB_HDR_TYPE_TYPE_MASK     0xC0
+#define MA_USB_HDR_TYPE_SUBTYPE_MASK  0x3F
+
+#define MA_USB_HDR_TYPE_TYPE_MANAGEMENT 0
+#define MA_USB_HDR_TYPE_TYPE_CONTROL    1
+#define MA_USB_HDR_TYPE_TYPE_DATA       2
+
+/* Management subtypes */
+
+#define _MA_USB_HDR_TYPE_MANAGEMENT_REQ(_s) \
+=09MA_USB_SET_FIELD_(HDR_TYPE_SUBTYPE, (_s) * 2)
+#define _MA_USB_HDR_TYPE_MANAGEMENT_RESP(_s) \
+=09MA_USB_SET_FIELD_(HDR_TYPE_SUBTYPE, (_s) * 2 + 1)
+
+#define MA_USB_HDR_TYPE_MANAGEMENT_REQ(_s) \
+=09_MA_USB_HDR_TYPE_MANAGEMENT_REQ(MA_USB_HDR_TYPE_SUBTYPE_##_s)
+#define MA_USB_HDR_TYPE_MANAGEMENT_RESP(_s) \
+=09_MA_USB_HDR_TYPE_MANAGEMENT_RESP(MA_USB_HDR_TYPE_SUBTYPE_##_s)
+
+#define MA_USB_HDR_TYPE_SUBTYPE_CAP               0
+#define MA_USB_HDR_TYPE_SUBTYPE_USBDEVHANDLE      1
+#define MA_USB_HDR_TYPE_SUBTYPE_EPHANDLE          2
+#define MA_USB_HDR_TYPE_SUBTYPE_EPACTIVATE        3
+#define MA_USB_HDR_TYPE_SUBTYPE_EPINACTIVATE      4
+#define MA_USB_HDR_TYPE_SUBTYPE_EPRESET           5
+#define MA_USB_HDR_TYPE_SUBTYPE_CLEARTRANSFERS    6
+#define MA_USB_HDR_TYPE_SUBTYPE_EPHANDLEDELETE    7
+#define MA_USB_HDR_TYPE_SUBTYPE_DEVRESET          8
+#define MA_USB_HDR_TYPE_SUBTYPE_MODIFYEP0         9
+#define MA_USB_HDR_TYPE_SUBTYPE_SETUSBDEVADDR     10
+#define MA_USB_HDR_TYPE_SUBTYPE_UPDATEDEV         11
+#define MA_USB_HDR_TYPE_SUBTYPE_USBDEVDISCONNECT  12
+#define MA_USB_HDR_TYPE_SUBTYPE_USBSUSPEND        13
+#define MA_USB_HDR_TYPE_SUBTYPE_USBRESUME         14
+#define MA_USB_HDR_TYPE_SUBTYPE_REMOTEWAKE        15
+#define MA_USB_HDR_TYPE_SUBTYPE_PING              16
+#define MA_USB_HDR_TYPE_SUBTYPE_DEVDISCONNECT     17
+#define MA_USB_HDR_TYPE_SUBTYPE_DEVINITDISCONNECT 18
+#define MA_USB_HDR_TYPE_SUBTYPE_SYNCH             19
+#define MA_USB_HDR_TYPE_SUBTYPE_CANCELTRANSFER    20
+#define MA_USB_HDR_TYPE_SUBTYPE_EPOPENSTREAM      21
+#define MA_USB_HDR_TYPE_SUBTYPE_EPCLOSESTREAM     22
+#define MA_USB_HDR_TYPE_SUBTYPE_USBDEVRESET       23
+#define MA_USB_HDR_TYPE_SUBTYPE_DEVNOTIFICATION   24
+#define MA_USB_HDR_TYPE_SUBTYPE_EPSETKEEPALIVE    25
+#define MA_USB_HDR_TYPE_SUBTYPE_GETPORTBW         26
+#define MA_USB_HDR_TYPE_SUBTYPE_SLEEP             27
+#define MA_USB_HDR_TYPE_SUBTYPE_WAKE              28
+#define MA_USB_HDR_TYPE_SUBTYPE_VENDORSPECIFIC    31 /* Reserved */
+
+/* Data subtypes */
+
+#define _MA_USB_HDR_TYPE_DATA_REQ(_s) ({ \
+=09typeof(_s) (s) =3D (_s); \
+=09MA_USB_SET_FIELD(HDR_TYPE_TYPE, HDR_TYPE_TYPE_DATA) | \
+=09MA_USB_SET_FIELD_(HDR_TYPE_SUBTYPE, (s) * 2 \
+=09+ ((s) > 0 ? 1 : 0)); })
+#define _MA_USB_HDR_TYPE_DATA_RESP(_s) ({ \
+=09typeof(_s) (s) =3D (_s); \
+=09MA_USB_SET_FIELD(HDR_TYPE_TYPE, HDR_TYPE_TYPE_DATA) | \
+=09MA_USB_SET_FIELD_(HDR_TYPE_SUBTYPE, (s) * 2 + 1 \
+=09+ ((s) > 0 ? 1 : 0)); })
+#define _MA_USB_HDR_TYPE_DATA_ACK(_s) ( \
+=09MA_USB_SET_FIELD(HDR_TYPE_TYPE, HDR_TYPE_TYPE_DATA) | \
+=09MA_USB_SET_FIELD_(HDR_TYPE_SUBTYPE, (_s) * 2 + 2))
+
+#define MA_USB_HDR_TYPE_DATA_REQ(_s) \
+=09_MA_USB_HDR_TYPE_DATA_REQ(MA_USB_HDR_TYPE_SUBTYPE_##_s)
+#define MA_USB_HDR_TYPE_DATA_RESP(_s) \
+=09_MA_USB_HDR_TYPE_DATA_RESP(MA_USB_HDR_TYPE_SUBTYPE_##_s)
+#define MA_USB_HDR_TYPE_DATA_ACK(_s) \
+=09_MA_USB_HDR_TYPE_DATA_ACK(MA_USB_HDR_TYPE_SUBTYPE_##_s)
+
+#define MA_USB_HDR_TYPE_SUBTYPE_TRANSFER          0
+#define MA_USB_HDR_TYPE_SUBTYPE_ISOCHTRANSFER     1
+
+/* EP/Device Handle */
+
+#define MA_USB_DEVICE_HANDLE_RESERVED   0
+
+#define MA_USB_EP_HANDLE_D_MASK     0x0001
+#define MA_USB_EP_HANDLE_EP_N_MASK  0x001e
+#define MA_USB_EP_HANDLE_ADDR_MASK  0x0fe0
+#define MA_USB_EP_HANDLE_BUS_N_MASK 0xf000
+
+#define MA_USB_EP_HANDLE(_b, _a, _e, _d) ( \
+=09MA_USB_SET_FIELD_(EP_HANDLE_BUS_N, _b)  | \
+=09MA_USB_SET_FIELD_(EP_HANDLE_ADDR, _a)   | \
+=09MA_USB_SET_FIELD_(EP_HANDLE_EP_N, _e)   | \
+=09MA_USB_SET_FIELD_(EP_HANDLE_D, _d))
+
+#define MA_USB_EP_HANDLE_BUS_N_VIRTUAL  15
+#define MA_USB_EP_HANDLE_ADDR_DEFAULT   0
+#define MA_USB_EP_HANDLE_EP_N_DEFAULT   0
+#define MA_USB_EP_HANDLE_D_OUT          0=09/* See USB2.0 9.3, Table 9-2 *=
/
+#define MA_USB_EP_HANDLE_D_IN           1=09/* See USB2.0 9.3, Table 9-2 *=
/
+
+/* Status codes */
+
+#define MA_USB_HDR_STATUS_UNSUCCESSFUL                  -128
+#define MA_USB_HDR_STATUS_INVALID_MA_USB_SESSION_STATE  -127
+#define MA_USB_HDR_STATUS_INVALID_DEVICE_HANDLE         -126
+#define MA_USB_HDR_STATUS_INVALID_EP_HANDLE             -125
+#define MA_USB_HDR_STATUS_INVALID_EP_HANDLE_STATE       -124
+#define MA_USB_HDR_STATUS_INVALID_REQUEST               -123
+#define MA_USB_HDR_STATUS_MISSING_SEQUENCE_NUMBER       -122
+#define MA_USB_HDR_STATUS_TRANSFER_PENDING              -121
+#define MA_USB_HDR_STATUS_TRANSFER_EP_STALL             -120
+#define MA_USB_HDR_STATUS_TRANSFER_SIZE_ERROR           -119
+#define MA_USB_HDR_STATUS_TRANSFER_DATA_BUFFER_ERROR    -118
+#define MA_USB_HDR_STATUS_TRANSFER_BABBLE_DETECTED      -117
+#define MA_USB_HDR_STATUS_TRANSFER_TRANSACTION_ERROR    -116
+#define MA_USB_HDR_STATUS_TRANSFER_SHORT_TRANSFER       -115
+#define MA_USB_HDR_STATUS_TRANSFER_CANCELED             -114
+#define MA_USB_HDR_STATUS_INSUFICIENT_RESOURCES         -113
+#define MA_USB_HDR_STATUS_NOT_SUFFICIENT_BANDWIDTH      -112
+#define MA_USB_HDR_STATUS_INTERNAL_ERROR                -111
+#define MA_USB_HDR_STATUS_DATA_OVERRUN                  -110
+#define MA_USB_HDR_STATUS_DEVICE_NOT_ACCESSED           -109
+#define MA_USB_HDR_STATUS_BUFFER_OVERRUN                -108
+#define MA_USB_HDR_STATUS_BUSY                          -107
+#define MA_USB_HDR_STATUS_DROPPED_PACKET                -106
+#define MA_USB_HDR_STATUS_ISOCH_TIME_EXPIRED            -105
+#define MA_USB_HDR_STATUS_ISOCH_TIME_INVALID            -104
+#define MA_USB_HDR_STATUS_NO_USB_PING_RESPONSE          -103
+#define MA_USB_HDR_STATUS_NOT_SUPPORTED                 -102
+#define MA_USB_HDR_STATUS_REQUEST_DENIED                -101
+#define MA_USB_HDR_STATUS_MISSING_REQUEST_ID            -100
+#define MA_USB_HDR_STATUS_SUCCESS                       0=09/* Reserved */
+#define MA_USB_HDR_STATUS_NO_ERROR MA_USB_HDR_STATUS_SUCCESS=09/* Reserved=
 */
+
+/* Speed values */
+
+#define MA_USB_SPEED_LOW_SPEED         0
+#define MA_USB_SPEED_FULL_SPEED        1
+#define MA_USB_SPEED_HIGH_SPEED        2
+#define MA_USB_SPEED_SUPER_SPEED       3
+#define MA_USB_SPEED_SUPER_SPEED_PLUS  4
+
+/* capreq extra hdr */
+
+#define MA_USB_CAPREQ_DESC_SYNCHRONIZATION_LENGTH\
+=09(sizeof(struct ma_usb_desc) +\
+=09sizeof(struct ma_usb_capreq_desc_synchronization))
+#define MA_USB_CAPREQ_DESC_LINK_SLEEP_LENGTH\
+=09(sizeof(struct ma_usb_desc) +\
+=09sizeof(struct ma_usb_capreq_desc_link_sleep))
+
+#define MA_USB_CAPREQ_LENGTH\
+=09(sizeof(struct ma_usb_hdr_common) +\
+=09sizeof(struct ma_usb_hdr_capreq) +\
+=09MA_USB_CAPREQ_DESC_SYNCHRONIZATION_LENGTH +\
+=09MA_USB_CAPREQ_DESC_LINK_SLEEP_LENGTH)
+
+/* capreq desc types */
+
+#define MA_USB_CAPREQ_DESC_TYPE_SYNCHRONIZATION 3
+#define MA_USB_CAPREQ_DESC_TYPE_LINK_SLEEP      5
+
+/* capresp descriptors */
+
+#define MA_USB_CAPRESP_DESC_TYPE_SPEED            0
+#define MA_USB_CAPRESP_DESC_TYPE_P_MANAGED_OUT    1
+#define MA_USB_CAPRESP_DESC_TYPE_ISOCHRONOUS      2
+#define MA_USB_CAPRESP_DESC_TYPE_SYNCHRONIZATION  3
+#define MA_USB_CAPRESP_DESC_TYPE_CONTAINER_ID     4
+#define MA_USB_CAPRESP_DESC_TYPE_LINK_SLEEP       5
+#define MA_USB_CAPRESP_DESC_TYPE_HUB_LATENCY      6
+
+/* Request ID and sequence number values */
+
+#define MA_USB_TRANSFER_RESERVED      0
+#define MA_USB_TRANSFER_REQID_MIN     0
+#define MA_USB_TRANSFER_REQID_MAX     ((1 <<  8) - 1)
+#define MA_USB_TRANSFER_SEQN_MIN      0
+#define MA_USB_TRANSFER_SEQN_MAX      ((1 << 24) - 2)
+#define MA_USB_TRANSFER_SEQN_INVALID  ((1 << 24) - 1)
+
+#define MA_USB_ISOCH_SFLAGS_FRAGMENT      0x1
+#define MA_USB_ISOCH_SFLAGS_LAST_FRAGMENT 0x2
+
+#define MAUSB_MAX_MGMT_SIZE 50
+
+#define MAUSB_TRANSFER_HDR_SIZE (u32)(sizeof(struct ma_usb_hdr_common) +\
+=09=09=09=09      sizeof(struct ma_usb_hdr_transfer))
+
+#define MAUSB_ISOCH_TRANSFER_HDR_SIZE (u16)(sizeof(struct ma_usb_hdr_commo=
n) +\
+=09=09=09sizeof(struct ma_usb_hdr_isochtransfer) +\
+=09=09=09sizeof(struct ma_usb_hdr_isochtransfer_optional))
+
+#define MAX_ISOCH_ASAP_PACKET_SIZE (150000 /* Network MTU */ -\
+=09MAUSB_ISOCH_TRANSFER_HDR_SIZE - 20 /* IP header size */ -\
+=098 /* UDP header size*/)
+
+#define shift_ptr(ptr, offset) ((u8 *)(ptr) + (offset))
+
+/* USB descriptor */
+struct ma_usb_desc {
+=09u8 length;
+=09u8 type;
+=09u8 value[0];
+} __packed;
+
+struct ma_usb_ep_handle {
+=09u16 d=09=09:1,
+=09    ep_n=09:4,
+=09    addr=09:7,
+=09    bus_n=09:4;
+};
+
+struct ma_usb_hdr_mgmt {
+=09u32 status=09:8,
+=09    token=09:10,  /* requestor originator allocated */
+=09    reserved=09:14;
+} __aligned(4);
+
+struct ma_usb_hdr_ctrl {=09/* used in all req/resp/conf operations */
+=09s8 status;
+=09u8 link_type;
+=09union {
+=09=09u8 tid;=09/* ieee 802.11 */
+=09} connection_id;
+} __aligned(4);
+
+struct ma_usb_hdr_data {
+=09s8 status;
+=09u8 eps=09=09:2,
+=09   t_flags=09:6;
+=09union {
+=09=09u16 stream_id;
+=09=09struct {
+=09=09=09u16 headers=09:12,
+=09=09=09    i_flags=09:4;
+=09=09};
+=09};
+} __aligned(4);
+
+struct ma_usb_hdr_common {
+=09u8 version=09:4,
+=09   flags=09:4;
+=09u8  type;
+=09u16 length;
+=09union {
+=09=09u16 dev;
+=09=09u16 epv;
+=09=09struct ma_usb_ep_handle eph;
+=09} handle;
+=09u8 dev_addr;
+=09u8 ssid;
+=09union {
+=09=09s8 status;
+=09=09struct ma_usb_hdr_mgmt mgmt;
+=09=09struct ma_usb_hdr_ctrl ctrl;
+=09=09struct ma_usb_hdr_data data;
+=09};
+} __aligned(4);
+
+/* capreq extra hdr */
+
+struct ma_usb_hdr_capreq {
+=09u32 out_mgmt_reqs=09:12,
+=09    reserved=09=09:20;
+} __aligned(4);
+
+struct ma_usb_capreq_desc_synchronization {
+=09u8 media_time_available=09:1,
+=09   reserved=09=09:7;
+} __packed;
+
+struct ma_usb_capreq_desc_link_sleep {
+=09u8 link_sleep_capable=09:1,
+=09   reserved=09=09:7;
+} __packed;
+
+/* capresp extra hdr */
+
+struct ma_usb_hdr_capresp {
+=09u16 endpoints;
+=09u8 devices;
+=09u8 streams=09=09:5,
+=09   dev_type=09=09:3;
+=09u32 descs=09=09:8,
+=09    descs_length=09:24;
+=09u16 out_transfer_reqs;
+=09u16 out_mgmt_reqs=09:12,
+=09    reserved=09=09:4;
+} __aligned(4);
+
+struct ma_usb_capresp_desc_speed {
+=09u8 reserved1=09=09:4,
+=09=09speed=09=09:4;
+=09u8 reserved2=09=09:4,
+=09   lse=09=09=09:2,=09/* USB3.1 8.5.6.7, Table 8-22 */
+=09   reserved3=09=09:2;
+} __packed;
+
+struct ma_usb_capresp_desc_p_managed_out {
+=09u8 elastic_buffer=09=09:1,
+=09   drop_notification=09=09:1,
+=09   reserved=09=09=09:6;
+} __packed;
+
+struct ma_usb_capresp_desc_isochronous {
+=09u8 payload_dword_aligned=09:1,
+=09   reserved=09=09=09:7;
+} __packed;
+
+struct ma_usb_capresp_desc_synchronization {
+=09u8 media_time_available=09:1,
+=09   time_stamp_required=09:1,/* hubs need this set */
+=09   reserved=09=09:6;
+} __packed;
+
+struct ma_usb_capresp_desc_container_id {
+=09u8 container_id[16];=09/* UUID IETF RFC 4122 */
+} __packed;
+
+struct ma_usb_capresp_desc_link_sleep {
+=09u8 link_sleep_capable=09:1,
+=09   reserved=09=09:7;
+} __packed;
+
+struct ma_usb_capresp_desc_hub_latency {
+=09u16 latency;=09=09/* USB3.1 */
+} __packed;
+
+/* usbdevhandlereq extra hdr */
+struct ma_usb_hdr_usbdevhandlereq {
+=09u32 route_string=09:20,
+=09    speed=09=09:4,
+=09    reserved1=09=09:8;
+=09u16 hub_dev_handle;
+=09u16 reserved2;
+=09u16 parent_hs_hub_dev_handle;
+=09u16 parent_hs_hub_port=09=09:4,
+=09    mtt=09=09=09=09:1,=09/* USB2.0 11.14, 11.14.1.3 */
+=09    lse=09=09=09=09:2,=09/* USB3.1 8.5.6.7, Table 8-22 */
+=09    reserved3=09=09=09:9;
+} __aligned(4);
+
+/* usbdevhandleresp extra hdr */
+struct ma_usb_hdr_usbdevhandleresp {
+=09u16 dev_handle;
+=09u16 reserved;
+} __aligned(4);
+
+/* ephandlereq extra hdr */
+struct ma_usb_hdr_ephandlereq {
+=09u32 ep_descs=09=09:5,
+=09    ep_desc_size=09:6,
+=09    reserved=09=09:21;
+} __aligned(4);
+
+/*
+ * Restricted USB2.0 ep desc limited to 6 bytes, isolating further changes=
.
+ * See USB2.0 9.6.6, Table 9-13
+ */
+struct usb_ep_desc {
+=09u8 bLength;
+=09/* USB2.0 9.4, Table 9-5 (5) usb/ch9.h: USB_DT_ENDPOINT */
+=09u8 bDescriptorType;
+=09u8  bEndpointAddress;
+=09u8  bmAttributes;
+=09__le16 wMaxPacketSize;
+=09u8  bInterval;
+} __packed;
+
+/*
+ * Restricted USB3.1 ep comp desc isolating further changes in usb/ch9.h
+ * See USB3.1 9.6.7, Table 9-26
+ */
+struct usb_ss_ep_comp_desc {
+=09u8 bLength;
+=09/* USB3.1 9.4, Table 9-6 (48) usb/ch9.h: USB_DT_SS_ENDPOINT_COMP */
+=09u8  bDescriptorType;
+=09u8  bMaxBurst;
+=09u8  bmAttributes;
+=09__le16 wBytesPerInterval;
+} __packed;
+
+/*
+ * USB3.1 ss_plus_isoch_ep_comp_desc
+ * See USB3.1 9.6.8, Table 9-27
+ */
+struct usb_ss_plus_isoch_ep_comp_desc {
+=09u8 bLength;
+=09/* USB3.1 9.4, Table 9-6 (49) usb/ch9.h: not yet defined! */
+=09u8 bDescriptorType;
+=09u16 wReserved;
+=09u32 dwBytesPerInterval;
+} __packed;
+
+struct ma_usb_ephandlereq_desc_std {
+=09struct usb_ep_desc usb20;
+} __aligned(4);
+
+struct ma_usb_ephandlereq_desc_ss {
+=09struct usb_ep_desc=09   usb20;
+=09struct usb_ss_ep_comp_desc usb31;
+} __aligned(4);
+
+struct ma_usb_ephandlereq_desc_ss_plus {
+=09struct usb_ep_desc=09=09      usb20;
+=09struct usb_ss_ep_comp_desc=09      usb31;
+=09struct usb_ss_plus_isoch_ep_comp_desc usb31_isoch;
+} __aligned(4);
+
+struct ma_usb_dev_context {
+=09struct usb_ep_desc usb;
+};
+
+/* ephandleresp extra hdr */
+struct ma_usb_hdr_ephandleresp {
+=09u32 ep_descs :5,
+=09    reserved :27;
+} __aligned(4);
+
+/* ephandleresp descriptor */
+struct ma_usb_ephandleresp_desc {
+=09union {
+=09=09struct ma_usb_ep_handle eph;
+=09=09u16=09=09epv;
+=09} ep_handle;
+=09u16 d=09=09:1,=09/* non-control or non-OUT */
+=09    isoch=09:1,
+=09    l_managed=09:1,=09/* control or non-isoch OUT */
+=09    invalid=09:1,
+=09    reserved1=09:12;
+=09u16 ccu;=09=09/* control or non-isoch OUT */
+=09u16 reserved2;
+=09u32 buffer_size;=09/* control or OUT */
+=09u16 isoch_prog_delay;=09/* in us. */
+=09u16 isoch_resp_delay;=09/* in us. */
+} __aligned(4);
+
+/* epactivatereq extra hdr */
+struct ma_usb_hdr_epactivatereq {
+=09u32 ep_handles=09:5,
+=09    reserved=09:27;
+=09union {
+=09=09u16=09=09epv;
+=09=09struct ma_usb_ep_handle eph;
+=09} handle[0];
+} __aligned(4);
+
+/* epactivateresp extra hdr */
+struct ma_usb_hdr_epactivateresp {
+=09u32 ep_errors=09:5,
+=09    reserved=09:27;
+=09union {
+=09=09u16=09=09=09epv;
+=09=09struct ma_usb_ep_handle eph;
+=09} handle[0];
+} __aligned(4);
+
+/* epinactivatereq extra hdr */
+struct ma_usb_hdr_epinactivatereq {
+=09u32 ep_handles=09:5,
+=09    suspend=09:1,
+=09    reserved=09:26;
+=09union {
+=09=09u16=09=09epv;
+=09=09struct ma_usb_ep_handle eph;
+=09} handle[0];
+} __aligned(4);
+
+/* epinactivateresp extra hdr */
+struct ma_usb_hdr_epinactivateresp {
+=09u32 ep_errors=09:5,
+=09    reserved=09:27;
+=09union {
+=09=09u16=09=09epv;
+=09=09struct ma_usb_ep_handle eph;
+=09} handle[0];
+} __aligned(4);
+
+/* epresetreq extra hdr */
+struct ma_usb_hdr_epresetreq {
+=09u32 ep_reset_blocks=09:5,
+=09    reserved=09=09:27;
+} __aligned(4);
+
+/* epresetreq reset block */
+struct ma_usb_epresetreq_block {
+=09union {
+=09=09u16=09=09=09epv;
+=09=09struct ma_usb_ep_handle eph;
+=09} handle;
+=09u16 tsp=09=09:1,
+=09    reserved=09:15;
+} __aligned(4);
+
+/* epresetresp extra hdr */
+struct ma_usb_hdr_epresetresp {
+=09u32 ep_errors=09:5,
+=09    reserved=09:27;
+=09union {
+=09=09u16=09=09=09epv;
+=09=09struct ma_usb_ep_handle eph;
+=09} handle[0];
+} __aligned(4);
+
+/* cleartransfersreq extra hdr */
+struct ma_usb_hdr_cleartransfersreq {
+=09u32 info_blocks=09:8,
+=09    reserved=09:24;
+} __aligned(4);
+
+/* cleartransfersreq info block */
+struct ma_usb_cleartransfersreq_block {
+=09union {
+=09=09u16=09=09=09epv;
+=09=09struct ma_usb_ep_handle eph;
+=09} handle;
+=09u16 stream_id; /* ss stream eps only */
+=09u32 start_req_id=09:8,
+=09    reserved=09=09:24;
+} __aligned(4);
+
+/* cleartransfersresp extra hdr */
+struct ma_usb_hdr_cleartransfersresp {
+=09u32 status_blocks=09:8,
+=09    reserved=09=09:24;
+} __aligned(4);
+
+/* cleartransfersresp status block */
+struct ma_usb_cleartransfersresp_block {
+=09union {
+=09=09u16=09=09=09epv;
+=09=09struct ma_usb_ep_handle eph;
+=09} handle;
+=09u16 stream_id;=09/* ss stream eps only */
+=09u32 cancel_success=09:1,
+=09    partial_delivery=09:1,
+=09    reserved=09=09:30;
+=09u32 last_req_id=09=09:8,
+=09    delivered_seq_n=09:24;=09/* OUT w/partial_delivery only */
+=09u32 delivered_byte_offset;=09/* OUT w/partial_delivery only */
+} __aligned(4);
+
+/* ephandledeletereq extra hdr */
+struct ma_usb_hdr_ephandledeletereq {
+=09u32 ep_handles=09:5,
+=09    reserved=09:27;
+=09union {
+=09=09u16=09=09=09epv;
+=09=09struct ma_usb_ep_handle eph;
+=09} handle[0];
+} __aligned(4);
+
+/* ephandledeleteresp extra hdr */
+struct ma_usb_hdr_ephandledeleteresp {
+=09u32 ep_errors=09:5,
+=09    reserved=09:27;
+=09union {
+=09=09u16=09=09=09epv;
+=09=09struct ma_usb_ep_handle eph;
+=09} handle[0];
+} __aligned(4);
+
+/* modifyep0req extra hdr */
+struct ma_usb_hdr_modifyep0req {
+=09union {
+=09=09u16=09=09=09epv;
+=09=09struct ma_usb_ep_handle eph;
+=09} handle;
+=09u16 max_packet_size;
+} __aligned(4);
+
+/*
+ * modifyep0resp extra hdr
+ * Only if req ep0 handle addr was 0 and req dev is in the addressed state
+ * or  if req ep0 handle addr !=3D 0 and req dev is in default state
+ */
+struct ma_usb_hdr_modifyep0resp {
+=09union {
+=09=09u16=09=09=09epv;
+=09=09struct ma_usb_ep_handle eph;
+=09} handle;
+
+=09u16 reserved;
+} __aligned(4);
+
+/* setusbdevaddrreq extra hdr */
+struct ma_usb_hdr_setusbdevaddrreq {
+=09u16 response_timeout;=09/* in ms. */
+=09u16 reserved;
+} __aligned(4);
+
+/* setusbdevaddrresp extra hdr */
+struct ma_usb_hdr_setusbdevaddrresp {
+=09u32 addr=09:7,
+=09    reserved=09:25;
+} __aligned(4);
+
+/* updatedevreq extra hdr */
+struct ma_usb_hdr_updatedevreq {
+=09u16 max_exit_latency;=09/* hubs only */
+=09u8 hub=09=09:1,
+=09   ports=09:4,
+=09   mtt=09=09:1,
+=09   ttt=09=09:2;
+=09u8 integrated_hub_latency=09:1,
+=09   reserved=09=09=09:7;
+} __aligned(4);
+
+/*
+ * USB2.0 dev desc, isolating further changes in usb/ch9.h
+ * See USB2.0 9.6.6, Table 9-13
+ */
+struct usb_dev_desc {
+=09u8 bLength;
+=09/*
+=09 * USB2.0 9.4, Table 9-5 (1)
+=09 * usb/ch9.h: USB_DT_DEVICE
+=09 */
+=09u8 bDescriptorType;
+=09__le16 bcdUSB;
+=09u8  bDeviceClass;
+=09u8  bDeviceSubClass;
+=09u8  bDeviceProtocol;
+=09u8  bMaxPacketSize0;
+=09__le16 idVendor;
+=09__le16 idProduct;
+=09__le16 bcdDevice;
+=09u8  iManufacturer;
+=09u8  iProduct;
+=09u8  iSerialNumber;
+=09u8  bNumConfigurations;
+} __packed;
+
+struct ma_usb_updatedevreq_desc {
+=09struct usb_dev_desc usb20;
+} __aligned(4);
+
+/* remotewakereq extra hdr */
+struct ma_usb_hdr_remotewakereq {
+=09u32 resumed  :1,
+=09=09 reserved :31;
+} __aligned(4);
+
+/* synchreq/resp extra hdr */
+struct ma_usb_hdr_synch {
+=09u32 mtd_valid=09=09:1,=09/* MA-USB1.0b 6.5.1.8, Table 66 */
+=09    resp_required=09:1,
+=09    reserved=09=09:30;
+=09union {
+=09=09u32 timestamp;=09=09/* MA-USB1.0b 6.5.1.11 */
+=09=09struct {
+=09=09=09u32 delta=09=09:13,
+=09=09=09    bus_interval=09:19;
+=09=09};=09=09=09/* MA-USB1.0b 6.6.1, Table 69 */
+=09};
+=09u32 mtd;=09=09=09/* MA-USB1.0b 6.5.1.12 */
+} __aligned(4);
+
+/* canceltransferreq extra hdr */
+struct ma_usb_hdr_canceltransferreq {
+=09union {
+=09=09u16=09=09=09epv;
+=09=09struct ma_usb_ep_handle eph;
+=09} handle;
+=09u16 stream_id;
+=09u32 req_id=09  :8,
+=09=09 reserved :24;
+} __aligned(4);
+
+/* canceltransferresp extra hdr */
+struct ma_usb_hdr_canceltransferresp {
+=09union {
+=09=09u16=09=09=09epv;
+=09=09struct ma_usb_ep_handle eph;
+=09} handle;
+=09u16 stream_id;
+=09u32 req_id=09=09:8,
+=09    cancel_status=09:3,
+=09    reserved1=09=09:21;
+=09u32 delivered_seq_n=09:24,
+=09    reserved2=09=09:8;
+=09u32 delivered_byte_offset;
+} __aligned(4);
+
+/* transferreq/resp/ack extra hdr */
+struct ma_usb_hdr_transfer {
+=09u32 seq_n=09:24,
+=09    req_id=09:8;
+=09union {
+=09=09u32 rem_size_credit;
+=09=09/* ISOCH aliased fields added for convenience. */
+=09=09struct {
+=09=09=09u32 presentation_time=09:20,
+=09=09=09    segments=09=09:12;
+=09=09};
+=09};
+} __aligned(4);
+
+/* isochtransferreq/resp extra hdr */
+struct ma_usb_hdr_isochtransfer {
+=09u32 seq_n=09=09:24,
+=09    req_id=09=09:8;
+=09u32 presentation_time=09:20,
+=09    segments=09=09:12;
+} __aligned(4);
+
+/* isochtransferreq/resp optional hdr */
+struct ma_usb_hdr_isochtransfer_optional {
+=09union {
+=09=09u32 timestamp;=09/* MA-USB1.0b 6.5.1.11 */
+=09=09struct {
+=09=09=09u32 delta=09=09:13,
+=09=09=09    bus_interval=09:19;
+=09=09};=09=09/* MA-USB1.0b 6.6.1, Table 69 */
+=09};
+=09u32 mtd;=09=09/* MA-USB1.0b 6.5.1.12 */
+} __aligned(4);
+
+/* isochdatablock hdrs */
+
+struct ma_usb_hdr_isochdatablock_short {
+=09u16 block_length;
+=09u16 segment_number=09:12,
+=09    s_flags=09=09:4;
+} __aligned(4);
+
+struct ma_usb_hdr_isochdatablock_std {
+=09u16 block_length;
+=09u16 segment_number=09:12,
+=09    s_flags=09=09:4;
+=09u16 segment_length;
+=09u16 fragment_offset;
+} __aligned(4);
+
+struct ma_usb_hdr_isochdatablock_long {
+=09u16 block_length;
+=09u16 segment_number=09:12,
+=09    s_flags=09=09:4;
+=09u32 segment_length;
+=09u32 fragment_offset;
+} __aligned(4);
+
+/* isochreadsizeblock hdrs */
+
+struct ma_usb_hdr_isochreadsizeblock_std {
+=09u32 service_intervals=09=09:12,
+=09    max_segment_length=09=09:20;
+} __aligned(4);
+
+struct ma_usb_hdr_isochreadsizeblock_long {
+=09u32 service_intervals=09=09:12,
+=09    reserved=09=09=09:20;
+=09u32 max_segment_length;
+} __aligned(4);
+
+static inline int __mausb_set_field(int m, int v)
+{
+=09return ((~((m) - 1) & (m)) * (v)) & (m);
+}
+
+static inline int __mausb_get_field(int m, int v)
+{
+=09return ((v) & (m)) / (~((m) - 1) & (m));
+}
+
+static inline bool mausb_is_management_hdr_type(int hdr_type)
+{
+=09return MA_USB_GET_FIELD_(HDR_TYPE_TYPE, hdr_type)
+=09=09=09=3D=3D MA_USB_HDR_TYPE_TYPE_MANAGEMENT;
+}
+
+static inline bool mausb_is_data_hdr_type(int hdr_type)
+{
+=09return MA_USB_GET_FIELD_(HDR_TYPE_TYPE, hdr_type)
+=09=09=09=3D=3D MA_USB_HDR_TYPE_TYPE_DATA;
+}
+
+static inline bool mausb_is_management_resp_hdr_type(int hdr_resp_type)
+{
+=09return mausb_is_management_hdr_type(hdr_resp_type) &&
+=09=09=09(MA_USB_GET_FIELD_(HDR_TYPE_SUBTYPE, hdr_resp_type) & 1)
+=09=09=09!=3D 0;
+}
+
+static inline
+struct ma_usb_hdr_transfer *
+mausb_get_data_transfer_hdr(struct ma_usb_hdr_common *hdr)
+{
+=09return (struct ma_usb_hdr_transfer *)shift_ptr(hdr, sizeof(*hdr));
+}
+
+static inline
+struct ma_usb_hdr_isochtransfer *
+mausb_get_isochtransfer_hdr(struct ma_usb_hdr_common *hdr)
+{
+=09return (struct ma_usb_hdr_isochtransfer *)shift_ptr(hdr, sizeof(*hdr));
+}
+
+static inline
+struct ma_usb_hdr_isochtransfer_optional *
+mausb_hdr_isochtransfer_optional_hdr(struct ma_usb_hdr_common *hdr)
+{
+=09return (struct ma_usb_hdr_isochtransfer_optional *)
+=09=09=09shift_ptr(hdr, sizeof(struct ma_usb_hdr_common) +
+=09=09=09=09       sizeof(struct ma_usb_hdr_isochtransfer));
+}
+
+#endif=09/* __MAUSB_MA_USB_H__ */
diff --git a/drivers/usb/mausb_host/mausb_address.h b/drivers/usb/mausb_hos=
t/mausb_address.h
new file mode 100644
index 000000000000..1a75482740ea
--- /dev/null
+++ b/drivers/usb/mausb_host/mausb_address.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
+ */
+#ifndef __MAUSB_MAUSB_ADDRESS_H__
+#define __MAUSB_MAUSB_ADDRESS_H__
+
+#include <linux/inet.h>
+#include <linux/types.h>
+
+struct mausb_device_address {
+=09u8 link_type;
+=09struct {
+=09=09char address[INET6_ADDRSTRLEN];
+=09=09u8 number_of_ports;
+=09=09struct {
+=09=09=09u16 management;
+=09=09=09u16 control;
+=09=09=09u16 bulk;
+=09=09=09u16 interrupt;
+=09=09=09u16 isochronous;
+=09=09} port;
+=09} ip;
+};
+
+#endif /* __MAUSB_MAUSB_ADDRESS_H__ */
diff --git a/drivers/usb/mausb_host/mausb_core.c b/drivers/usb/mausb_host/m=
ausb_core.c
index 3ce90c29f6de..8730590126ea 100644
--- a/drivers/usb/mausb_host/mausb_core.c
+++ b/drivers/usb/mausb_host/mausb_core.c
@@ -12,6 +12,7 @@
 #include <linux/net.h>
=20
 #include "hcd.h"
+#include "hpal.h"
 #include "utils.h"
=20
 MODULE_LICENSE("GPL");
@@ -75,12 +76,20 @@ static int mausb_host_init(void)
 =09if (status < 0)
 =09=09goto cleanup;
=20
-=09status =3D mausb_create_dev();
+=09status =3D mausb_register_power_state_listener();
 =09if (status < 0)
 =09=09goto cleanup_hcd;
=20
+=09status =3D mausb_create_dev();
+=09if (status < 0)
+=09=09goto unregister_power_state_listener;
+
+=09mausb_initialize_mss();
+
 =09return 0;
=20
+unregister_power_state_listener:
+=09mausb_unregister_power_state_listener();
 cleanup_hcd:
 =09mausb_deinit_hcd();
 cleanup:
@@ -91,6 +100,8 @@ static int mausb_host_init(void)
 static void mausb_host_exit(void)
 {
 =09mausb_pr_info("Module unloading started...");
+=09mausb_unregister_power_state_listener();
+=09mausb_deinitialize_mss();
 =09mausb_deinit_hcd();
 =09mausb_cleanup_dev(1);
 =09mausb_pr_info("Module unloaded. Version=3D%s", MAUSB_DRIVER_VERSION);
diff --git a/drivers/usb/mausb_host/mausb_event.h b/drivers/usb/mausb_host/=
mausb_event.h
new file mode 100644
index 000000000000..636c07b5f2be
--- /dev/null
+++ b/drivers/usb/mausb_host/mausb_event.h
@@ -0,0 +1,224 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
+ */
+#ifndef __MAUSB_MAUSB_EVENT_H__
+#define __MAUSB_MAUSB_EVENT_H__
+
+#include "ma_usb.h"
+
+#define MAUSB_MAX_NUM_OF_MA_DEVS=09=09=0915
+#define MAUSB_RING_BUFFER_SIZE=09=09=09=091024
+#define MAUSB_MAX_DATA_IN_REQ_SIZE=09=09=0928
+
+#define MAUSB_EVENT_TYPE_DEV_RESET=09=09=091u
+#define MAUSB_EVENT_TYPE_USB_DEV_HANDLE=09=09=092u
+#define MAUSB_EVENT_TYPE_EP_HANDLE=09=09=093u
+#define MAUSB_EVENT_TYPE_EP_HANDLE_ACTIVATE=09=094u
+#define MAUSB_EVENT_TYPE_EP_HANDLE_INACTIVATE=09=095u
+#define MAUSB_EVENT_TYPE_EP_HANDLE_RESET=09=096u
+#define MAUSB_EVENT_TYPE_EP_HANDLE_DELETE=09=097u
+#define MAUSB_EVENT_TYPE_MODIFY_EP0=09=09=098u
+#define MAUSB_EVENT_TYPE_SET_USB_DEV_ADDRESS=09=099u
+#define MAUSB_EVENT_TYPE_UPDATE_DEV=09=09=0910u
+#define MAUSB_EVENT_TYPE_USB_DEV_DISCONNECT=09=0911u
+#define MAUSB_EVENT_TYPE_PING=09=09=09=0912u
+#define MAUSB_EVENT_TYPE_DEV_DISCONNECT=09=09=0913u
+#define MAUSB_EVENT_TYPE_USB_DEV_RESET=09=09=0914u
+#define MAUSB_EVENT_TYPE_CANCEL_TRANSFER=09=0915u
+
+#define MAUSB_EVENT_TYPE_PORT_CHANGED=09=09=0980u
+#define MAUSB_EVENT_TYPE_SEND_MGMT_MSG=09=09=0981u
+#define MAUSB_EVENT_TYPE_SEND_DATA_MSG=09=09=0982u
+#define MAUSB_EVENT_TYPE_RECEIVED_MGMT_MSG=09=0983u
+#define MAUSB_EVENT_TYPE_RECEIVED_DATA_MSG=09=0984u
+#define MAUSB_EVENT_TYPE_URB_COMPLETE=09=09=0985u
+#define MAUSB_EVENT_TYPE_SEND_ACK=09=09=0986u
+#define MAUSB_EVENT_TYPE_ITERATOR_RESET=09=09=0987u
+#define MAUSB_EVENT_TYPE_ITERATOR_SEEK=09=09=0988u
+#define MAUSB_EVENT_TYPE_DELETE_DATA_TRANSFER=09=0989u
+#define MAUSB_EVENT_TYPE_DELETE_MA_DEV=09=09=0990u
+#define MAUSB_EVENT_TYPE_USER_FINISHED=09=09=0991u
+#define MAUSB_EVENT_TYPE_RELEASE_EVENT_RESOURCES=0992u
+#define MAUSB_EVENT_TYPE_NETWORK_DISCONNECTED=09=0993u
+#define MAUSB_EVENT_TYPE_MGMT_REQUEST_TIMED_OUT=09=0994u
+
+#define MAUSB_EVENT_TYPE_NONE=09=09=09=09255u
+
+#define MAUSB_DATA_MSG_DIRECTION_OUT=09=09=090
+#define MAUSB_DATA_MSG_DIRECTION_IN=09=09=091
+#define MAUSB_DATA_MSG_CONTROL MAUSB_DATA_MSG_DIRECTION_OUT
+
+struct mausb_devhandle {
+=09u64 event_id;
+=09u32 route_string;
+=09u16 hub_dev_handle;
+=09u16 parent_hs_hub_dev_handle;
+=09u16 parent_hs_hub_port;
+=09u16 mtt;
+=09/* dev_handle assigned in user */
+=09u16 dev_handle;
+=09u8  device_speed;
+=09u8  lse;
+};
+
+struct mausb_ephandle {
+=09u64 event_id;
+=09u16 device_handle;
+=09u16 descriptor_size;
+=09/* ep_handle assigned in user */
+=09u16 ep_handle;
+=09char=09 descriptor[sizeof(struct ma_usb_ephandlereq_desc_ss)];
+};
+
+struct mausb_epactivate {
+=09u64 event_id;
+=09u16 device_handle;
+=09u16 ep_handle;
+};
+
+struct mausb_epinactivate {
+=09u64 event_id;
+=09u16 device_handle;
+=09u16 ep_handle;
+};
+
+struct mausb_epreset {
+=09u64 event_id;
+=09u16 device_handle;
+=09u16 ep_handle;
+=09u8  tsp;
+};
+
+struct mausb_epdelete {
+=09u64 event_id;
+=09u16 device_handle;
+=09u16 ep_handle;
+};
+
+struct mausb_updatedev {
+=09u64 event_id;
+=09u16 device_handle;
+=09u16 max_exit_latency;
+=09struct ma_usb_updatedevreq_desc update_descriptor;
+=09u8  hub;
+=09u8  number_of_ports;
+=09u8  mtt;
+=09u8  ttt;
+=09u8  integrated_hub_latency;
+};
+
+struct mausb_usbdevreset {
+=09u64 event_id;
+=09u16 device_handle;
+};
+
+struct mausb_modifyep0 {
+=09u64 event_id;
+=09u16 device_handle;
+=09u16 ep_handle;
+=09__le16 max_packet_size;
+};
+
+struct mausb_setusbdevaddress {
+=09u64 event_id;
+=09u16 device_handle;
+=09u16 response_timeout;
+};
+
+struct mausb_usbdevdisconnect {
+=09u16 device_handle;
+};
+
+struct mausb_canceltransfer {
+=09u64 urb;
+=09u16 device_handle;
+=09u16 ep_handle;
+};
+
+struct mausb_mgmt_hdr {
+=09__aligned(4) char hdr[MAUSB_MAX_MGMT_SIZE];
+};
+
+struct mausb_mgmt_req_timedout {
+=09u64 event_id;
+};
+
+struct mausb_delete_ma_dev {
+=09u64 event_id;
+=09u16 device_id;
+};
+
+/* TODO split mgmt_event to generic send mgmt req and specific requests */
+struct mausb_mgmt_event {
+=09union {
+=09=09struct mausb_devhandle=09=09dev_handle;
+=09=09struct mausb_ephandle=09=09ep_handle;
+=09=09struct mausb_epactivate=09=09ep_activate;
+=09=09struct mausb_epinactivate=09ep_inactivate;
+=09=09struct mausb_epreset=09=09ep_reset;
+=09=09struct mausb_epdelete=09=09ep_delete;
+=09=09struct mausb_modifyep0=09=09modify_ep0;
+=09=09struct mausb_setusbdevaddress=09set_usb_dev_address;
+=09=09struct mausb_updatedev=09=09update_dev;
+=09=09struct mausb_usbdevreset=09usb_dev_reset;
+=09=09struct mausb_usbdevdisconnect=09usb_dev_disconnect;
+=09=09struct mausb_canceltransfer=09cancel_transfer;
+=09=09struct mausb_mgmt_hdr=09=09mgmt_hdr;
+=09=09struct mausb_mgmt_req_timedout=09mgmt_req_timedout;
+=09=09struct mausb_delete_ma_dev=09delete_ma_dev;
+=09};
+};
+
+struct mausb_data_event {
+=09u64 urb;
+=09u64 recv_buf;
+=09u32 iterator_seek_delta;
+=09u32 transfer_size;
+=09u32 rem_transfer_size;
+=09u32 transfer_flags;
+=09u32 isoch_seg_num;
+=09u32 req_id;
+=09u32 payload_size;
+=09s32 status;
+
+=09__aligned(4) char hdr[MAUSB_TRANSFER_HDR_SIZE];
+=09__aligned(4) char hdr_ack[MAUSB_TRANSFER_HDR_SIZE];
+
+=09u16 device_id;
+=09u16 ep_handle;
+=09u16 packet_size;
+=09u8  setup_packet;
+=09u8  direction;
+=09u8  transfer_type;
+=09u8  first_control_packet;
+=09u8  transfer_eot;
+=09u8  mausb_address;
+=09u8  mausb_ssid;
+};
+
+struct mausb_port_changed_event {
+=09u8 port;
+=09u8 dev_type;
+=09u8 dev_speed;
+=09u8 lse;
+};
+
+struct mausb_event {
+=09union {
+=09=09struct mausb_mgmt_event=09=09mgmt;
+=09=09struct mausb_data_event=09=09data;
+=09=09struct mausb_port_changed_event port_changed;
+=09};
+=09s32 status;
+=09u8 type;
+=09u8 madev_addr;
+};
+
+struct mausb_events_notification {
+=09u16 num_of_events;
+=09u16 num_of_completed_events;
+=09u8  madev_addr;
+};
+
+#endif /* __MAUSB_MAUSB_EVENT_H__ */
--=20
2.17.1

