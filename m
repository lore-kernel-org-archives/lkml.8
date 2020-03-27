Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82D9C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 15:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B88520748
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 15:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=displaylink.com header.i=@displaylink.com header.b="tqfwb+vT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgC0P0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 11:26:42 -0400
Received: from eu-smtp-delivery-167.mimecast.com ([146.101.78.167]:26771 "EHLO
        eu-smtp-delivery-167.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727674AbgC0P0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 11:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=displaylink.com;
        s=mimecast20151025; t=1585322795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=776EJGhENNfsPuSnb+P1Ba6UQkKd2hSe9sC5ij0DTwM=;
        b=tqfwb+vTxZx8FUmAIfURBPdYTVjBd7PCsgOaXL9dPcFbTygtn8jDTpPLa+dpAX4iCxFDBv
        KjGqGRxQLU5AKwYf96k1gJ7t2RAX0OsSoBljTyBLCxpj0try9XXMFo4KDPJu3+68EpV0te
        KCkYzIsb6nuSR/ecdP9Lst6R5XIdb/o=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2059.outbound.protection.outlook.com [104.47.14.59]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-231-irJyRzkvNOK7MBV3AyVm1g-3; Fri, 27 Mar 2020 15:26:34 +0000
X-MC-Unique: irJyRzkvNOK7MBV3AyVm1g-3
Received: from AM0PR10MB3075.EURPRD10.PROD.OUTLOOK.COM (10.255.30.19) by
 AM0PR10MB1939.EURPRD10.PROD.OUTLOOK.COM (52.134.81.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Fri, 27 Mar 2020 15:26:30 +0000
Received: from AM0PR10MB3075.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::991c:987a:8997:3aab]) by AM0PR10MB3075.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::991c:987a:8997:3aab%6]) with mapi id 15.20.2856.019; Fri, 27 Mar 2020
 15:26:30 +0000
From:   vladimir.stankovic@displaylink.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mausb-host-devel@displaylink.com
Subject: [PATCH v4 4/8] usb: mausb_host: Implement initial hub handlers
Date:   Fri, 27 Mar 2020 16:26:10 +0100
Message-Id: <20200327152614.26833-5-vladimir.stankovic@displaylink.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200327152614.26833-1-vladimir.stankovic@displaylink.com>
References: <8c24bff9-79a6-ca53-ce8f-fb503163db24@displaylink.com>
 <20200327152614.26833-1-vladimir.stankovic@displaylink.com>
X-ClientProxiedBy: VI1PR10CA0090.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::19) To AM0PR10MB3075.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15f::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from raven-hp.endava.net (94.189.199.177) by VI1PR10CA0090.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:28::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18 via Frontend Transport; Fri, 27 Mar 2020 15:26:29 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [94.189.199.177]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79031513-49a2-4d0e-0832-08d7d2633913
X-MS-TrafficTypeDiagnostic: AM0PR10MB1939:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR10MB1939526FBEE4341B372B980F91CC0@AM0PR10MB1939.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:404;
X-Forefront-PRVS: 0355F3A3AE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3075.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39840400004)(396003)(366004)(136003)(376002)(346002)(2906002)(316002)(66946007)(66476007)(5660300002)(4326008)(2616005)(956004)(66556008)(16526019)(6486002)(6666004)(36756003)(186003)(81166006)(81156014)(8676002)(8936002)(107886003)(478600001)(6916009)(1076003)(86362001)(6506007)(6512007)(52116002)(9686003)(30864003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YeIHI0FsVMpTjmaPHKrRuymgbmqi1VQJsx97pRefr+fb+hkljkKVro3Ga/WiSxdD2P3vtwR/czBiYmmTZWuyKQ59jm+5nm9ky1qBog7elTfx8RFwgA16vo0uoFIV/5Cw8GHUu7J8pRn4mPvOudLYIpcS1uGBjdAC1AfG2xIz7Pvu58O4St8GvSbxIC6t67/mWC+UQe+RwFNgncCujB15tIfixe6eBRpWU7GASzVVQKNKvu+6X5IZIYxo/anL2Fmnt/vsDcklsOTCyN8kdw1jeRh5uK+2ybuVGC2+VbDvCM6CN8HI8NT0TR91utYNydSPg4ObMPYHJdwWMi9Ml1m5KmyK587V4w5T4ANqRYET5xpT3qutUuNgUPIQmrdyjrBYvRZyOj/yoDkt8u9tNE21rW/NmpTbXuiBhPOYJVoh9hZfn/ZvH9YljnUuu4CRULcq
X-MS-Exchange-AntiSpam-MessageData: F4DT5+iLaUuPS7gyR+t4Ze8FAStwcfwAATWtol3K2n9GzQBLlMOqnYs7kMU3F//v53Mrnbc/X75XEcL8VAKEvzRgeAY39qQ2pCZJ8ireH3IT5zItviziDXn+MTIvUc1QVaSOEmeKjge5RzlNNG2G3g==
X-OriginatorOrg: displaylink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79031513-49a2-4d0e-0832-08d7d2633913
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2020 15:26:29.9567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4bda75a-b444-4312-9c90-44a7c4b2c91a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jxps5x9YcqBchH4p0C7sB67spHZmt6maetklgNVBrzB/FJSGDhuPajpVmT3aqA1DMn1WZpNNHlMGjVu7O5CYm5Erpl5+cyBwsSzyGTncFzQIDQj4jnB1X46m7qIwiRSB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB1939
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: displaylink.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implemented handlers for subset of HCD events.

Signed-off-by: Vladimir Stankovic <vladimir.stankovic@displaylink.com>
---
 drivers/usb/mausb_host/hcd.c | 964 ++++++++++++++++++++++++++++++++++-
 drivers/usb/mausb_host/hcd.h |  86 +++-
 2 files changed, 1046 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/mausb_host/hcd.c b/drivers/usb/mausb_host/hcd.c
index 3aa548a6cb30..b20d1a36ba34 100644
--- a/drivers/usb/mausb_host/hcd.c
+++ b/drivers/usb/mausb_host/hcd.c
@@ -71,7 +71,7 @@ static void mausb_remove(void)
=20
 static int mausb_bus_probe(struct device *dev)
 {
-=09return 0;
+=09return mausb_probe(dev);
 }
=20
 static int mausb_bus_remove(struct device *dev)
@@ -159,7 +159,15 @@ int mausb_init_hcd(void)
=20
 =09device->driver =3D &mausb_driver;
=20
+=09retval =3D mausb_probe(device);
+=09if (retval) {
+=09=09mausb_pr_err("Mausb_probe failed");
+=09=09goto mausb_probe_failed;
+=09}
+
 =09return retval;
+mausb_probe_failed:
+=09device_destroy(mausb_class, devt);
 device_create_error:
 =09kfree(mhcd);
 =09mhcd =3D NULL;
@@ -186,3 +194,957 @@ void mausb_deinit_hcd(void)
 =09=09unregister_chrdev(major, DEVICE_NAME);
 =09}
 }
+
+static const char driver_name[] =3D "MA-USB host controller";
+
+static void mausb_get_hub_descriptor(struct usb_hcd *hcd, u16 type_req,
+=09=09=09=09     u16 value, u16 index,
+=09=09=09=09     char *buff, u16 length);
+static void mausb_set_port_feature(struct usb_hcd *hcd, u16 type_req,
+=09=09=09=09   u16 value, u16 index, char *buff,
+=09=09=09=09   u16 length);
+static void mausb_get_port_status(struct usb_hcd *hcd, u16 type_req,
+=09=09=09=09  u16 value, u16 index, char *buff,
+=09=09=09=09  u16 length);
+static void mausb_clear_port_feature(struct usb_hcd *hcd, u16 type_req,
+=09=09=09=09     u16 value, u16 index,
+=09=09=09=09     char *buff, u16 length);
+static void mausb_get_hub_status(struct usb_hcd *hcd, u16 type_req,
+=09=09=09=09 u16 value, u16 index, char *buff,
+=09=09=09=09 u16 length);
+static int mausb_add_endpoint(struct usb_hcd *hcd, struct usb_device *dev,
+=09=09=09      struct usb_host_endpoint *endpoint);
+static int mausb_address_device(struct usb_hcd *hcd, struct usb_device *de=
v);
+static int mausb_alloc_dev(struct usb_hcd *hcd, struct usb_device *dev);
+static int mausb_check_bandwidth(struct usb_hcd *hcd, struct usb_device *d=
ev);
+static int mausb_drop_endpoint(struct usb_hcd *hcd, struct usb_device *dev=
,
+=09=09=09       struct usb_host_endpoint *endpoint);
+static int mausb_enable_device(struct usb_hcd *hcd, struct usb_device *dev=
);
+static void mausb_endpoint_disable(struct usb_hcd *hcd,
+=09=09=09=09   struct usb_host_endpoint *endpoint);
+static void mausb_endpoint_reset(struct usb_hcd *hcd,
+=09=09=09=09 struct usb_host_endpoint *endpoint);
+static void mausb_free_dev(struct usb_hcd *hcd, struct usb_device *dev);
+static int mausb_hcd_bus_resume(struct usb_hcd *hcd);
+static int mausb_hcd_bus_suspend(struct usb_hcd *hcd);
+static int mausb_hcd_get_frame_number(struct usb_hcd *hcd);
+static int mausb_hcd_hub_control(struct usb_hcd *hcd, u16 type_req,
+=09=09=09=09 u16 value, u16 index, char *buff,
+=09=09=09=09 u16 length);
+static int mausb_hcd_hub_status(struct usb_hcd *hcd, char *buff);
+static int mausb_hcd_reset(struct usb_hcd *hcd);
+static int mausb_hcd_start(struct usb_hcd *hcd);
+static void mausb_hcd_stop(struct usb_hcd *hcd);
+static int mausb_hub_update_device(struct usb_hcd *hcd, struct usb_device =
*dev,
+=09=09=09=09   struct usb_tt *tt, gfp_t mem_flags);
+static void mausb_reset_bandwidth(struct usb_hcd *hcd, struct usb_device *=
dev);
+static int mausb_reset_device(struct usb_hcd *hcd, struct usb_device *dev)=
;
+static int mausb_update_device(struct usb_hcd *hcd, struct usb_device *dev=
);
+
+static const struct hc_driver mausb_hc_driver =3D {
+=09.description  =3D  driver_name,
+=09.product_desc =3D driver_name,
+=09.flags=09      =3D HCD_USB3 | HCD_SHARED,
+
+=09.hcd_priv_size =3D sizeof(struct hub_ctx),
+
+=09.reset =3D mausb_hcd_reset,
+=09.start =3D mausb_hcd_start,
+=09.stop  =3D mausb_hcd_stop,
+
+=09.get_frame_number =3D mausb_hcd_get_frame_number,
+
+=09.hub_status_data   =3D mausb_hcd_hub_status,
+=09.hub_control=09   =3D mausb_hcd_hub_control,
+=09.update_hub_device =3D mausb_hub_update_device,
+=09.bus_suspend=09   =3D mausb_hcd_bus_suspend,
+=09.bus_resume=09   =3D mausb_hcd_bus_resume,
+
+=09.alloc_dev=09=3D mausb_alloc_dev,
+=09.free_dev=09=3D mausb_free_dev,
+=09.enable_device=09=3D mausb_enable_device,
+=09.update_device=09=3D mausb_update_device,
+=09.reset_device=09=3D mausb_reset_device,
+
+=09.add_endpoint=09  =3D mausb_add_endpoint,
+=09.drop_endpoint=09  =3D mausb_drop_endpoint,
+=09.check_bandwidth  =3D mausb_check_bandwidth,
+=09.reset_bandwidth  =3D mausb_reset_bandwidth,
+=09.address_device   =3D mausb_address_device,
+=09.endpoint_disable =3D mausb_endpoint_disable,
+=09.endpoint_reset=09  =3D mausb_endpoint_reset,
+};
+
+static struct {
+=09struct usb_bos_descriptor    bos;
+=09struct usb_ss_cap_descriptor ss_cap;
+} usb3_bos_desc =3D {
+=09.bos =3D {
+=09=09.bLength=09 =3D USB_DT_BOS_SIZE,
+=09=09.bDescriptorType =3D USB_DT_BOS,
+=09=09.wTotalLength=09 =3D cpu_to_le16(sizeof(usb3_bos_desc)),
+=09=09.bNumDeviceCaps=09 =3D 1
+=09},
+=09.ss_cap =3D {
+=09=09.bLength=09=09=3D USB_DT_USB_SS_CAP_SIZE,
+=09=09.bDescriptorType=09=3D USB_DT_DEVICE_CAPABILITY,
+=09=09.bDevCapabilityType=09=3D USB_SS_CAP_TYPE,
+=09=09.wSpeedSupported=09=3D cpu_to_le16(USB_5GBPS_OPERATION),
+=09=09.bFunctionalitySupport=09=3D ilog2(USB_5GBPS_OPERATION)
+=09}
+};
+
+static int get_root_hub_port_number(struct usb_device *dev, u8 *port_numbe=
r)
+{
+=09struct usb_device *first_hub_device =3D dev;
+
+=09if (!dev->parent) {
+=09=09(*port_number) =3D 0;
+=09=09return -EINVAL;
+=09}
+
+=09while (first_hub_device->parent->parent)
+=09=09first_hub_device =3D first_hub_device->parent;
+
+=09(*port_number) =3D first_hub_device->portnum - 1;
+
+=09return 0;
+}
+
+static struct mausb_usb_device_ctx *mausb_find_usb_device(struct mausb_dev
+=09=09=09=09=09=09=09*mdevs, void *dev_addr)
+{
+=09struct rb_node *node =3D mdevs->usb_devices.rb_node;
+
+=09while (node) {
+=09=09struct mausb_usb_device_ctx *usb_device =3D
+=09=09    rb_entry(node, struct mausb_usb_device_ctx, rb_node);
+
+=09=09if (dev_addr < usb_device->dev_addr)
+=09=09=09node =3D usb_device->rb_node.rb_left;
+=09=09else if (dev_addr > usb_device->dev_addr)
+=09=09=09node =3D usb_device->rb_node.rb_right;
+=09=09else
+=09=09=09return usb_device;
+=09}
+=09return NULL;
+}
+
+static int mausb_hcd_get_frame_number(struct usb_hcd *hcd)
+{
+=09return 0;
+}
+
+static int mausb_hcd_reset(struct usb_hcd *hcd)
+{
+=09if (usb_hcd_is_primary_hcd(hcd)) {
+=09=09hcd->speed =3D HCD_USB2;
+=09=09hcd->self.root_hub->speed =3D USB_SPEED_HIGH;
+=09} else {
+=09=09hcd->speed =3D HCD_USB3;
+=09=09hcd->self.root_hub->speed =3D USB_SPEED_SUPER;
+=09}
+=09hcd->self.no_sg_constraint =3D 1;
+=09hcd->self.sg_tablesize =3D UINT_MAX;
+
+=09return 0;
+}
+
+static int mausb_hcd_start(struct usb_hcd *hcd)
+{
+=09hcd->power_budget =3D 0;
+=09hcd->uses_new_polling =3D 1;
+=09return 0;
+}
+
+static void mausb_hcd_stop(struct usb_hcd *hcd)
+{
+=09mausb_pr_debug("Not implemented");
+}
+
+static int mausb_hcd_hub_status(struct usb_hcd *hcd, char *buff)
+{
+=09int retval;
+=09int changed;
+=09int i;
+=09struct hub_ctx *hub;
+=09unsigned long flags =3D 0;
+
+=09hub =3D (struct hub_ctx *)hcd->hcd_priv;
+
+=09retval  =3D DIV_ROUND_UP(NUMBER_OF_PORTS + 1, 8);
+=09changed =3D 0;
+
+=09memset(buff, 0, (unsigned int)retval);
+
+=09spin_lock_irqsave(&mhcd->lock, flags);
+
+=09if (!HCD_HW_ACCESSIBLE(hcd)) {
+=09=09mausb_pr_info("hcd not accessible, hcd speed=3D%d", hcd->speed);
+=09=09spin_unlock_irqrestore(&mhcd->lock, flags);
+=09=09return 0;
+=09}
+
+=09for (i =3D 0; i < NUMBER_OF_PORTS; ++i) {
+=09=09if ((hub->ma_devs[i].port_status & PORT_C_MASK)) {
+=09=09=09buff[(i + 1) / 8] |=3D 1 << (i + 1) % 8;
+=09=09=09changed =3D 1;
+=09=09}
+=09}
+
+=09mausb_pr_info("Usb %d.0 : changed=3D%d, retval=3D%d",
+=09=09      (hcd->speed =3D=3D HCD_USB2) ? 2 : 3, changed, retval);
+
+=09if (hcd->state =3D=3D HC_STATE_SUSPENDED && changed =3D=3D 1) {
+=09=09mausb_pr_info("hcd state is suspended");
+=09=09usb_hcd_resume_root_hub(hcd);
+=09}
+
+=09spin_unlock_irqrestore(&mhcd->lock, flags);
+
+=09return changed ? retval : 0;
+}
+
+static int mausb_hcd_bus_resume(struct usb_hcd *hcd)
+{
+=09unsigned long flags =3D 0;
+
+=09spin_lock_irqsave(&mhcd->lock, flags);
+=09if (!HCD_HW_ACCESSIBLE(hcd)) {
+=09=09mausb_pr_info("hcd not accessible, hcd speed=3D%d", hcd->speed);
+=09=09spin_unlock_irqrestore(&mhcd->lock, flags);
+=09=09return -ESHUTDOWN;
+=09}
+=09hcd->state =3D HC_STATE_RUNNING;
+=09spin_unlock_irqrestore(&mhcd->lock, flags);
+
+=09return 0;
+}
+
+static int mausb_hcd_bus_suspend(struct usb_hcd *hcd)
+{
+=09unsigned long flags =3D 0;
+
+=09spin_lock_irqsave(&mhcd->lock, flags);
+=09hcd->state =3D HC_STATE_SUSPENDED;
+=09spin_unlock_irqrestore(&mhcd->lock, flags);
+
+=09return 0;
+}
+
+static int mausb_hcd_hub_control(struct usb_hcd *hcd, u16 type_req,
+=09=09=09=09 u16 value, u16 index, char *buff,
+=09=09=09=09 u16 length)
+{
+=09int retval =3D 0;
+=09struct hub_ctx=09 *hub =3D (struct hub_ctx *)hcd->hcd_priv;
+=09struct mausb_hcd *hub_mhcd =3D hub->mhcd;
+=09unsigned long=09 flags;
+=09bool invalid_rhport =3D false;
+
+=09index =3D ((__u8)(index & 0x00ff));
+=09if (index < 1 || index > NUMBER_OF_PORTS)
+=09=09invalid_rhport =3D true;
+
+=09mausb_pr_info("TypeReq=3D%d", type_req);
+
+=09spin_lock_irqsave(&hub_mhcd->lock, flags);
+
+=09if (!HCD_HW_ACCESSIBLE(hcd)) {
+=09=09mausb_pr_info("hcd not accessible, hcd speed=3D%d", hcd->speed);
+=09=09spin_unlock_irqrestore(&hub_mhcd->lock, flags);
+=09=09return -ETIMEDOUT;
+=09}
+
+=09switch (type_req) {
+=09case ClearHubFeature:
+=09=09break;
+=09case ClearPortFeature:
+=09=09if (invalid_rhport)
+=09=09=09goto invalid_port;
+
+=09=09mausb_clear_port_feature(hcd, type_req, value, index, buff,
+=09=09=09=09=09 length);
+=09=09break;
+=09case DeviceRequest | USB_REQ_GET_DESCRIPTOR:
+=09=09memcpy(buff, &usb3_bos_desc, sizeof(usb3_bos_desc));
+=09=09retval =3D sizeof(usb3_bos_desc);
+=09=09break;
+=09case GetHubDescriptor:
+=09=09mausb_get_hub_descriptor(hcd, type_req, value, index, buff,
+=09=09=09=09=09 length);
+=09=09break;
+=09case GetHubStatus:
+=09=09mausb_get_hub_status(hcd, type_req, value, index, buff,
+=09=09=09=09     length);
+=09=09break;
+=09case GetPortStatus:
+=09=09if (invalid_rhport)
+=09=09=09goto invalid_port;
+
+=09=09mausb_get_port_status(hcd, type_req, value, index, buff,
+=09=09=09=09      length);
+=09=09break;
+=09case SetHubFeature:
+=09=09retval =3D -EPIPE;
+=09=09break;
+=09case SetPortFeature:
+=09=09if (invalid_rhport)
+=09=09=09goto invalid_port;
+
+=09=09mausb_set_port_feature(hcd, type_req, value, index, buff,
+=09=09=09=09       length);
+=09=09break;
+=09default:
+=09=09retval =3D -EPIPE;
+=09}
+
+invalid_port:
+=09spin_unlock_irqrestore(&hub_mhcd->lock, flags);
+=09return retval;
+}
+
+int mausb_probe(struct device *dev)
+{
+=09struct mausb_hcd *mausb_hcd;
+=09struct usb_hcd=09 *hcd_ss;
+=09struct usb_hcd=09 *hcd_hs;
+=09int ret;
+
+=09mausb_hcd =3D dev_get_drvdata(dev);
+=09spin_lock_init(&mausb_hcd->lock);
+
+=09hcd_hs =3D usb_create_hcd(&mausb_hc_driver, dev, dev_name(dev));
+=09if (!hcd_hs)
+=09=09return -ENOMEM;
+
+=09hcd_hs->has_tt =3D 1;
+=09mausb_hcd->hcd_hs_ctx=09    =3D (struct hub_ctx *)hcd_hs->hcd_priv;
+=09mausb_hcd->hcd_hs_ctx->mhcd =3D mausb_hcd;
+=09mausb_hcd->hcd_hs_ctx->hcd  =3D hcd_hs;
+=09memset(mausb_hcd->hcd_hs_ctx->ma_devs, 0,
+=09       sizeof(struct mausb_dev) * NUMBER_OF_PORTS);
+
+=09ret =3D usb_add_hcd(hcd_hs, 0, 0);
+=09if (ret) {
+=09=09mausb_pr_err("usb_add_hcd failed");
+=09=09goto put_hcd_hs;
+=09}
+
+=09hcd_ss =3D usb_create_shared_hcd(&mausb_hc_driver, dev, dev_name(dev),
+=09=09=09=09       hcd_hs);
+=09if (!hcd_ss) {
+=09=09ret =3D -ENOMEM;
+=09=09goto remove_hcd_hs;
+=09}
+=09mausb_hcd->hcd_ss_ctx=09    =3D (struct hub_ctx *)hcd_ss->hcd_priv;
+=09mausb_hcd->hcd_ss_ctx->mhcd =3D mausb_hcd;
+=09mausb_hcd->hcd_ss_ctx->hcd  =3D hcd_ss;
+
+=09memset(mausb_hcd->hcd_ss_ctx->ma_devs, 0,
+=09       sizeof(struct mausb_dev) * NUMBER_OF_PORTS);
+
+=09ret =3D usb_add_hcd(hcd_ss, 0, 0);
+=09if (ret) {
+=09=09mausb_pr_err("usb_add_hcd failed");
+=09=09goto put_hcd_ss;
+=09}
+
+=09return ret;
+
+put_hcd_ss:
+=09usb_put_hcd(hcd_ss);
+remove_hcd_hs:
+=09usb_remove_hcd(hcd_hs);
+put_hcd_hs:
+=09usb_put_hcd(hcd_hs);
+=09mausb_hcd->hcd_hs_ctx =3D NULL;
+=09mausb_hcd->hcd_ss_ctx =3D NULL;
+=09return ret;
+}
+
+static void mausb_get_hub_descriptor(struct usb_hcd *hcd, u16 type_req,
+=09=09=09=09     u16 value, u16 index,
+=09=09=09=09     char *buff, u16 length)
+{
+=09u8 width;
+=09struct usb_hub_descriptor *desc =3D (struct usb_hub_descriptor *)buff;
+
+=09memset(desc, 0, sizeof(struct usb_hub_descriptor));
+
+=09if (hcd->speed =3D=3D HCD_USB3) {
+=09=09desc->bDescriptorType=09   =3D USB_DT_SS_HUB;
+=09=09desc->bDescLength=09   =3D 12;
+=09=09desc->wHubCharacteristics  =3D
+=09=09    cpu_to_le16(HUB_CHAR_INDV_PORT_LPSM | HUB_CHAR_COMMON_OCPM);
+=09=09desc->bNbrPorts=09=09   =3D NUMBER_OF_PORTS;
+=09=09desc->u.ss.bHubHdrDecLat   =3D 0x04;
+=09=09desc->u.ss.DeviceRemovable =3D cpu_to_le16(0xffff);
+=09} else {
+=09=09desc->bDescriptorType=09  =3D USB_DT_HUB;
+=09=09desc->wHubCharacteristics =3D
+=09=09    cpu_to_le16(HUB_CHAR_INDV_PORT_LPSM | HUB_CHAR_COMMON_OCPM);
+=09=09desc->bNbrPorts=09=09  =3D NUMBER_OF_PORTS;
+=09=09width=09=09=09  =3D (u8)(desc->bNbrPorts / 8 + 1);
+=09=09desc->bDescLength=09  =3D USB_DT_HUB_NONVAR_SIZE + 2 * width;
+
+=09=09memset(&desc->u.hs.DeviceRemovable[0], 0, width);
+=09=09memset(&desc->u.hs.DeviceRemovable[width], 0xff, width);
+=09}
+}
+
+static void mausb_set_port_feature(struct usb_hcd *hcd, u16 type_req,
+=09=09=09=09   u16 value, u16 index, char *buff,
+=09=09=09=09   u16 length)
+{
+=09struct hub_ctx *hub =3D (struct hub_ctx *)hcd->hcd_priv;
+
+=09index =3D ((__u8)(index & 0x00ff));
+
+=09switch (value) {
+=09case USB_PORT_FEAT_LINK_STATE:
+=09=09mausb_pr_debug("USB_PORT_FEAT_LINK_STATE");
+=09=09if (hcd->speed =3D=3D HCD_USB3) {
+=09=09=09if ((hub->ma_devs[index - 1].port_status &
+=09=09=09     USB_SS_PORT_STAT_POWER) !=3D 0) {
+=09=09=09=09hub->ma_devs[index - 1].port_status |=3D
+=09=09=09=09    (1U << value);
+=09=09=09}
+=09=09} else {
+=09=09=09if ((hub->ma_devs[index - 1].port_status &
+=09=09=09     USB_PORT_STAT_POWER) !=3D 0) {
+=09=09=09=09hub->ma_devs[index - 1].port_status |=3D
+=09=09=09=09    (1U << value);
+=09=09=09}
+=09=09}
+=09=09break;
+=09case USB_PORT_FEAT_U1_TIMEOUT:
+=09case USB_PORT_FEAT_U2_TIMEOUT:
+=09=09break;
+=09case USB_PORT_FEAT_SUSPEND:
+=09=09break;
+=09case USB_PORT_FEAT_POWER:
+=09=09mausb_pr_debug("USB_PORT_FEAT_POWER");
+
+=09=09if (hcd->speed =3D=3D HCD_USB3) {
+=09=09=09hub->ma_devs[index - 1].port_status |=3D
+=09=09=09    USB_SS_PORT_STAT_POWER;
+=09=09} else {
+=09=09=09hub->ma_devs[index - 1].port_status |=3D
+=09=09=09    USB_PORT_STAT_POWER;
+=09=09}
+=09=09break;
+=09case USB_PORT_FEAT_BH_PORT_RESET:
+=09=09mausb_pr_debug("USB_PORT_FEAT_BH_PORT_RESET");
+=09=09/* fall through */
+=09case USB_PORT_FEAT_RESET:
+=09=09mausb_pr_debug("USB_PORT_FEAT_RESET hcd->speed=3D%d", hcd->speed);
+
+=09=09if (hcd->speed =3D=3D HCD_USB3) {
+=09=09=09hub->ma_devs[index - 1].port_status =3D 0;
+=09=09=09hub->ma_devs[index - 1].port_status =3D
+=09=09=09    (USB_SS_PORT_STAT_POWER |
+=09=09=09     USB_PORT_STAT_CONNECTION | USB_PORT_STAT_RESET);
+=09=09} else if (hub->ma_devs[index - 1].port_status
+=09=09=09   & USB_PORT_STAT_ENABLE) {
+=09=09=09hub->ma_devs[index - 1].port_status &=3D
+=09=09=09    ~(USB_PORT_STAT_ENABLE |
+=09=09=09      USB_PORT_STAT_LOW_SPEED |
+=09=09=09      USB_PORT_STAT_HIGH_SPEED);
+=09=09}
+=09=09/* fall through */
+=09default:
+=09=09mausb_pr_info("Default value=3D%d", value);
+
+=09=09if (hcd->speed =3D=3D HCD_USB3) {
+=09=09=09if ((hub->ma_devs[index - 1].port_status &
+=09=09=09     USB_SS_PORT_STAT_POWER) !=3D 0) {
+=09=09=09=09hub->ma_devs[index - 1].port_status |=3D
+=09=09=09=09    (1U << value);
+=09=09=09}
+=09=09} else {
+=09=09=09if ((hub->ma_devs[index - 1].port_status &
+=09=09=09     USB_PORT_STAT_POWER) !=3D 0) {
+=09=09=09=09hub->ma_devs[index - 1].port_status |=3D
+=09=09=09=09    (1U << value);
+=09=09=09}
+=09=09}
+=09}
+}
+
+static void mausb_get_port_status(struct usb_hcd *hcd, u16 type_req,
+=09=09=09=09  u16 value, u16 index, char *buff,
+=09=09=09=09  u16 length)
+{
+=09u8 dev_speed;
+=09struct hub_ctx *hub =3D (struct hub_ctx *)hcd->hcd_priv;
+
+=09index =3D ((__u8)(index & 0x00ff));
+
+=09if ((hub->ma_devs[index - 1].port_status &
+=09=09=09=09(1 << USB_PORT_FEAT_RESET)) !=3D 0) {
+=09=09mausb_pr_info("Finished reset hcd->speed=3D%d", hcd->speed);
+
+=09=09dev_speed =3D hub->ma_devs[index - 1].dev_speed;
+=09=09switch (dev_speed) {
+=09=09case LOW_SPEED:
+=09=09=09hub->ma_devs[index - 1].port_status |=3D
+=09=09=09    USB_PORT_STAT_LOW_SPEED;
+=09=09=09break;
+=09=09case HIGH_SPEED:
+=09=09=09hub->ma_devs[index - 1].port_status |=3D
+=09=09=09    USB_PORT_STAT_HIGH_SPEED;
+=09=09=09break;
+=09=09default:
+=09=09=09mausb_pr_info("Not updating port_status for device speed %d",
+=09=09=09=09      dev_speed);
+=09=09}
+
+=09=09hub->ma_devs[index - 1].port_status |=3D
+=09=09    (1 << USB_PORT_FEAT_C_RESET) | USB_PORT_STAT_ENABLE;
+=09=09hub->ma_devs[index - 1].port_status &=3D
+=09=09    ~(1 << USB_PORT_FEAT_RESET);
+=09}
+
+=09((__le16 *)buff)[0] =3D cpu_to_le16(hub->ma_devs[index - 1].port_status=
);
+=09((__le16 *)buff)[1] =3D
+=09    cpu_to_le16(hub->ma_devs[index - 1].port_status >> 16);
+
+=09mausb_pr_info("port_status=3D%d", hub->ma_devs[index - 1].port_status);
+}
+
+static void mausb_clear_port_feature(struct usb_hcd *hcd, u16 type_req,
+=09=09=09=09     u16 value, u16 index,
+=09=09=09=09     char *buff, u16 length)
+{
+=09struct hub_ctx *hub =3D (struct hub_ctx *)hcd->hcd_priv;
+
+=09index =3D ((__u8)(index & 0x00ff));
+
+=09switch (value) {
+=09case USB_PORT_FEAT_SUSPEND:
+=09=09break;
+=09case USB_PORT_FEAT_POWER:
+=09=09mausb_pr_debug("USB_PORT_FEAT_POWER");
+
+=09=09if (hcd->speed =3D=3D HCD_USB3) {
+=09=09=09hub->ma_devs[index - 1].port_status &=3D
+=09=09=09    ~USB_SS_PORT_STAT_POWER;
+=09=09} else {
+=09=09=09hub->ma_devs[index - 1].port_status &=3D
+=09=09=09    ~USB_PORT_STAT_POWER;
+=09=09}
+=09=09break;
+=09case USB_PORT_FEAT_RESET:
+
+=09case USB_PORT_FEAT_C_RESET:
+
+=09default:
+=09=09mausb_pr_info("Default value: %d", value);
+
+=09=09hub->ma_devs[index - 1].port_status &=3D ~(1 << value);
+=09}
+}
+
+static void mausb_get_hub_status(struct usb_hcd *hcd, u16 type_req,
+=09=09=09=09 u16 value, u16 index, char *buff,
+=09=09=09=09 u16 length)
+{
+=09*(__le32 *)buff =3D cpu_to_le32(0);
+}
+
+static int mausb_alloc_dev(struct usb_hcd *hcd, struct usb_device *dev)
+{
+=09mausb_pr_info("Usb device=3D%p", dev);
+
+=09return 1;
+}
+
+static void mausb_free_dev(struct usb_hcd *hcd, struct usb_device *dev)
+{
+=09u8=09port_number;
+=09s16=09dev_handle;
+=09int=09status;
+=09struct hub_ctx   *hub  =3D (struct hub_ctx *)hcd->hcd_priv;
+=09struct mausb_dev=09    *mdev =3D NULL;
+=09struct mausb_usb_device_ctx *usb_device_ctx;
+=09struct mausb_endpoint_ctx   *ep_ctx =3D dev->ep0.hcpriv;
+
+=09status =3D get_root_hub_port_number(dev, &port_number);
+=09if (status < 0 || port_number >=3D NUMBER_OF_PORTS) {
+=09=09mausb_pr_info("port_number out of range, port_number=3D%x",
+=09=09=09      port_number);
+=09=09return;
+=09}
+
+=09mdev  =3D &hub->ma_devs[port_number];
+
+=09usb_device_ctx =3D mausb_find_usb_device(mdev, dev);
+=09if (!usb_device_ctx) {
+=09=09mausb_pr_warn("device_ctx is not found");
+=09=09return;
+=09}
+
+=09dev_handle =3D usb_device_ctx->dev_handle;
+
+=09if (ep_ctx) {
+=09=09dev->ep0.hcpriv =3D NULL;
+=09=09kfree(ep_ctx);
+
+=09} else {
+=09=09mausb_pr_warn("ep_ctx is NULL: dev_handle=3D%#x", dev_handle);
+=09}
+
+=09rb_erase(&usb_device_ctx->rb_node, &mdev->usb_devices);
+=09mausb_pr_info("USB device deleted device=3D%p", usb_device_ctx->dev_add=
r);
+=09kfree(usb_device_ctx);
+}
+
+/*
+ * For usb 2.0 logitech camera called multiple times, once during
+ * enumeration of device and later after mausb_reset_device.
+ */
+static int mausb_address_device(struct usb_hcd *hcd, struct usb_device *de=
v)
+{
+=09u8=09port_number;
+=09int=09status;
+=09struct hub_ctx=09*hub =3D (struct hub_ctx *)hcd->hcd_priv;
+=09struct mausb_usb_device_ctx *usb_device_ctx;
+=09struct mausb_endpoint_ctx   *endpoint_ctx;
+
+=09status =3D get_root_hub_port_number(dev, &port_number);
+=09if (status < 0 || port_number >=3D NUMBER_OF_PORTS) {
+=09=09mausb_pr_warn("port_number out of range, port_number=3D%x",
+=09=09=09      port_number);
+=09=09return -EINVAL;
+=09}
+
+=09usb_device_ctx =3D mausb_find_usb_device(&hub->ma_devs[port_number], de=
v);
+=09if (!usb_device_ctx)
+=09=09return -ENODEV;
+
+=09mausb_pr_info("dev_handle=3D%#x, dev_speed=3D%#x",
+=09=09      usb_device_ctx->dev_handle, dev->speed);
+
+=09if (dev->speed >=3D USB_SPEED_SUPER)
+=09=09mausb_pr_info("USB 3.0");
+=09else
+=09=09mausb_pr_info("USB 2.0");
+
+=09if (usb_device_ctx->dev_handle =3D=3D DEV_HANDLE_NOT_ASSIGNED) {
+=09=09status =3D mausb_enable_device(hcd, dev);
+=09=09if (status < 0)
+=09=09=09return status;
+=09}
+
+=09endpoint_ctx =3D dev->ep0.hcpriv;
+=09if (!endpoint_ctx) {
+=09=09mausb_pr_err("endpoint_ctx is NULL: dev_handle=3D%#x",
+=09=09=09     usb_device_ctx->dev_handle);
+=09=09return -EINVAL;
+=09}
+
+=09return 0;
+}
+
+static int mausb_add_endpoint(struct usb_hcd *hcd, struct usb_device *dev,
+=09=09=09      struct usb_host_endpoint *endpoint)
+{
+=09int=09status;
+=09u8=09port_number;
+=09struct hub_ctx=09=09    *hub =3D (struct hub_ctx *)hcd->hcd_priv;
+=09struct mausb_usb_device_ctx *usb_dev_ctx;
+=09struct mausb_endpoint_ctx   *endpoint_ctx;
+
+=09status =3D get_root_hub_port_number(dev, &port_number);
+=09if (status < 0 || port_number >=3D NUMBER_OF_PORTS) {
+=09=09mausb_pr_info("port_number out of range, port_number=3D%x",
+=09=09=09      port_number);
+=09=09return 0;
+=09}
+
+=09usb_dev_ctx =3D mausb_find_usb_device(&hub->ma_devs[port_number], dev);
+
+=09if (!usb_dev_ctx) {
+=09=09mausb_pr_warn("Device not found");
+=09=09return -ENODEV;
+=09}
+
+=09endpoint_ctx =3D kzalloc(sizeof(*endpoint_ctx), GFP_ATOMIC);
+=09if (!endpoint_ctx)
+=09=09return -ENOMEM;
+
+=09endpoint_ctx->dev_handle=09=3D usb_dev_ctx->dev_handle;
+=09endpoint_ctx->usb_device_ctx=09=3D usb_dev_ctx;
+=09endpoint->hcpriv=09=09=3D endpoint_ctx;
+
+=09return 0;
+}
+
+static int mausb_drop_endpoint(struct usb_hcd *hcd, struct usb_device *dev=
,
+=09=09=09       struct usb_host_endpoint *endpoint)
+{
+=09u8=09port_number;
+=09int=09status;
+=09struct hub_ctx=09=09    *hub =3D (struct hub_ctx *)hcd->hcd_priv;
+=09struct mausb_usb_device_ctx *usb_dev_ctx;
+=09struct mausb_endpoint_ctx   *endpoint_ctx =3D endpoint->hcpriv;
+
+=09status =3D get_root_hub_port_number(dev, &port_number);
+=09if (status < 0 || port_number >=3D NUMBER_OF_PORTS) {
+=09=09mausb_pr_info("port_number out of range, port_number=3D%x",
+=09=09=09      port_number);
+=09=09return -EINVAL;
+=09}
+
+=09usb_dev_ctx =3D mausb_find_usb_device(&hub->ma_devs[port_number], dev);
+
+=09if (!endpoint_ctx) {
+=09=09mausb_pr_err("Endpoint context doesn't exist");
+=09=09return 0;
+=09}
+=09if (!usb_dev_ctx) {
+=09=09mausb_pr_err("Usb device context doesn't exist");
+=09=09return -ENODEV;
+=09}
+
+=09endpoint->hcpriv =3D NULL;
+=09kfree(endpoint_ctx);
+=09return 0;
+}
+
+/*
+ * For usb 2.0 logitech camera called multiple times, once during enumerat=
ion
+ * of device and later after mausb_reset_device. In latter case it is
+ * required to address the device again in order for ep0 to work properly.
+ */
+static int mausb_enable_device(struct usb_hcd *hcd, struct usb_device *dev=
)
+{
+=09int status;
+=09u8 port_number;
+=09struct hub_ctx=09=09    *hub =3D (struct hub_ctx *)hcd->hcd_priv;
+=09struct mausb_usb_device_ctx *usb_device_ctx;
+
+=09status =3D get_root_hub_port_number(dev, &port_number);
+=09if (status < 0 || port_number >=3D NUMBER_OF_PORTS) {
+=09=09mausb_pr_info("port_number out of range, port_number=3D%x",
+=09=09=09      port_number);
+=09=09return -EINVAL;
+=09}
+
+=09usb_device_ctx =3D mausb_find_usb_device(&hub->ma_devs[port_number], de=
v);
+=09if (!usb_device_ctx)
+=09=09return -ENODEV;
+
+=09mausb_pr_info("Device assigned and addressed usb_device_ctx=3D%p",
+=09=09      usb_device_ctx);
+
+=09return 0;
+}
+
+static int mausb_is_hub_device(struct usb_device *dev)
+{
+=09return dev->descriptor.bDeviceClass =3D=3D 0x09;
+}
+
+static int mausb_update_device(struct usb_hcd *hcd, struct usb_device *dev=
)
+{
+=09u8=09port_number =3D 0;
+=09int=09status=09    =3D 0;
+=09struct hub_ctx=09=09    *hub =3D (struct hub_ctx *)hcd->hcd_priv;
+=09struct mausb_usb_device_ctx *usb_device_ctx =3D NULL;
+
+=09if (mausb_is_hub_device(dev)) {
+=09=09mausb_pr_warn("Device is hub");
+=09=09return 0;
+=09}
+
+=09status =3D get_root_hub_port_number(dev, &port_number);
+=09if (status < 0 || port_number >=3D NUMBER_OF_PORTS) {
+=09=09mausb_pr_info("port_number out of range, port_number=3D%x",
+=09=09=09      port_number);
+=09=09return -EINVAL;
+=09}
+
+=09usb_device_ctx =3D mausb_find_usb_device(&hub->ma_devs[port_number], de=
v);
+=09if (!usb_device_ctx) {
+=09=09mausb_pr_warn("Device not found");
+=09=09return -ENODEV;
+=09}
+
+=09return 0;
+}
+
+static int mausb_hub_update_device(struct usb_hcd *hcd, struct usb_device =
*dev,
+=09=09=09=09   struct usb_tt *tt, gfp_t mem_flags)
+{
+=09int=09status;
+=09u8=09port_number;
+=09u16 max_exit_latency =3D 0;
+=09u8  mtt =3D 0;
+=09u8  ttt =3D 0;
+=09struct hub_ctx=09=09    *hub =3D (struct hub_ctx *)hcd->hcd_priv;
+=09struct mausb_usb_device_ctx *usb_device_ctx;
+
+=09if (dev->speed =3D=3D USB_SPEED_HIGH) {
+=09=09mtt =3D tt->multi =3D=3D 0 ? 1 : 0;
+=09=09ttt =3D (u8)tt->think_time;
+=09}
+
+=09status =3D get_root_hub_port_number(dev, &port_number);
+=09if (status < 0 || port_number >=3D NUMBER_OF_PORTS) {
+=09=09mausb_pr_info("port_number out of range, port_number=3D%x",
+=09=09=09      port_number);
+=09=09return 0;
+=09}
+
+=09usb_device_ctx =3D mausb_find_usb_device(&hub->ma_devs[port_number],
+=09=09=09=09=09       dev);
+
+=09if (!usb_device_ctx) {
+=09=09mausb_pr_err("USB device not found");
+=09=09return -ENODEV;
+=09}
+
+=09if (dev->usb3_lpm_u1_enabled)
+=09=09max_exit_latency =3D (u16)dev->u1_params.mel;
+=09else if (dev->usb3_lpm_u2_enabled)
+=09=09max_exit_latency =3D (u16)dev->u2_params.mel;
+
+=09return 0;
+}
+
+static int mausb_check_bandwidth(struct usb_hcd *hcd, struct usb_device *d=
ev)
+{
+=09mausb_pr_debug("Not implemented");
+=09return 0;
+}
+
+static void mausb_reset_bandwidth(struct usb_hcd *hcd, struct usb_device *=
dev)
+{
+=09mausb_pr_debug("Not implemented");
+}
+
+static void mausb_endpoint_disable(struct usb_hcd *hcd,
+=09=09=09=09   struct usb_host_endpoint *endpoint)
+{
+=09mausb_pr_debug("Not implemented");
+}
+
+static void mausb_endpoint_reset(struct usb_hcd *hcd,
+=09=09=09=09 struct usb_host_endpoint *endpoint)
+{
+=09int status;
+=09int is_control;
+=09int epnum;
+=09int is_out;
+=09u16=09dev_handle;
+=09u8=09tsp;
+=09u8=09port_number;
+=09struct hub_ctx=09=09    *hub;
+=09struct mausb_usb_device_ctx *usb_device_ctx;
+=09struct usb_device=09    *dev;
+=09struct mausb_endpoint_ctx   *ep_ctx;
+
+=09ep_ctx =3D endpoint->hcpriv;
+=09if (!ep_ctx) {
+=09=09mausb_pr_err("ep->hcpriv is NULL");
+=09=09return;
+=09}
+
+=09usb_device_ctx=09=3D ep_ctx->usb_device_ctx;
+=09dev_handle=09=3D usb_device_ctx->dev_handle;
+=09dev=09=09=3D usb_device_ctx->dev_addr;
+
+=09status =3D get_root_hub_port_number(dev, &port_number);
+=09if (status < 0 || port_number >=3D NUMBER_OF_PORTS) {
+=09=09mausb_pr_info("port_number out of range, port_number=3D%x",
+=09=09=09      port_number);
+=09=09return;
+=09}
+=09hub =3D (struct hub_ctx *)hcd->hcd_priv;
+
+=09is_control =3D usb_endpoint_xfer_control(&endpoint->desc);
+=09epnum =3D usb_endpoint_num(&endpoint->desc);
+=09is_out =3D usb_endpoint_dir_out(&endpoint->desc);
+=09tsp =3D (u8)(is_out ? dev->toggle[1] : dev->toggle[0]);
+
+=09if (status < 0)
+=09=09return;
+
+=09if (status !=3D EUCLEAN) {
+=09=09if (!tsp) {
+=09=09=09usb_settoggle(dev, epnum, is_out, 0U);
+=09=09=09if (is_control)
+=09=09=09=09usb_settoggle(dev, epnum, !is_out, 0U);
+=09=09}
+
+=09=09return;
+=09}
+
+=09if (tsp)
+=09=09return;
+
+=09mausb_pr_info("ep_handle request status=3D%d, ep_handle=3D%#x, dev_hand=
le=3D%#x",
+=09=09      status, ep_ctx->ep_handle, dev_handle);
+}
+
+/*
+ * For usb 2.0 logitech camera called multiple times,
+ * followed by either mausb_enable_device or mausb_address_device.
+ * Resets device to non-addressed state.
+ */
+static int mausb_reset_device(struct usb_hcd *hcd, struct usb_device *dev)
+{
+=09int status;
+=09u8  port_number;
+=09u16 dev_handle;
+=09struct hub_ctx=09=09    *hub;
+=09struct mausb_usb_device_ctx *usb_device_ctx;
+
+=09hub =3D (struct hub_ctx *)hcd->hcd_priv;
+
+=09status =3D get_root_hub_port_number(dev, &port_number);
+=09if (status < 0 || port_number >=3D NUMBER_OF_PORTS) {
+=09=09mausb_pr_info("port_number out of range, port_number=3D%x",
+=09=09=09      port_number);
+=09=09return -EINVAL;
+=09}
+
+=09usb_device_ctx =3D mausb_find_usb_device(&hub->ma_devs[port_number], de=
v);
+
+=09if (!usb_device_ctx ||
+=09    usb_device_ctx->dev_handle =3D=3D DEV_HANDLE_NOT_ASSIGNED)
+=09=09return 0;
+
+=09dev_handle =3D usb_device_ctx->dev_handle;
+
+=09return 0;
+}
+
+void mausb_clear_hcd_madev(u16 port_number)
+{
+=09unsigned long flags =3D 0;
+
+=09if (port_number >=3D NUMBER_OF_PORTS) {
+=09=09mausb_pr_err("port_number out of range, port_number=3D%x",
+=09=09=09     port_number);
+=09=09return;
+=09}
+
+=09spin_lock_irqsave(&mhcd->lock, flags);
+
+=09memset(&mhcd->hcd_hs_ctx->ma_devs[port_number], 0,
+=09       sizeof(struct mausb_dev));
+=09memset(&mhcd->hcd_ss_ctx->ma_devs[port_number], 0,
+=09       sizeof(struct mausb_dev));
+
+=09mhcd->connected_ports &=3D ~(1 << port_number);
+
+=09mhcd->hcd_hs_ctx->ma_devs[port_number].port_status =3D
+=09=09=09=09=09=09=09USB_PORT_STAT_POWER;
+=09mhcd->hcd_ss_ctx->ma_devs[port_number].port_status =3D
+=09=09=09=09=09=09=09USB_SS_PORT_STAT_POWER;
+
+=09spin_unlock_irqrestore(&mhcd->lock, flags);
+}
diff --git a/drivers/usb/mausb_host/hcd.h b/drivers/usb/mausb_host/hcd.h
index cac62ba1f1e2..cbef70a2f985 100644
--- a/drivers/usb/mausb_host/hcd.h
+++ b/drivers/usb/mausb_host/hcd.h
@@ -24,9 +24,6 @@
=20
 #define RESPONSE_TIMEOUT=095000
=20
-#define MAUSB_PORT_20_STATUS_LOW_SPEED       0x0200
-#define MAUSB_PORT_20_STATUS_HIGH_SPEED      0x0400
-
 enum mausb_device_type {
 =09USBDEVICE =3D 0,
 =09USB20HUB  =3D 1,
@@ -68,4 +65,87 @@ struct hub_ctx {
 int mausb_init_hcd(void);
 void mausb_deinit_hcd(void);
=20
+#define PORT_C_MASK \
+=09=09((USB_PORT_STAT_C_CONNECTION \
+=09=09| USB_PORT_STAT_C_ENABLE \
+=09=09| USB_PORT_STAT_C_SUSPEND \
+=09=09| USB_PORT_STAT_C_OVERCURRENT \
+=09=09| USB_PORT_STAT_C_RESET) << 16)
+
+#define MAUSB_PORT_20_STATUS_CONNECT         0x0001
+#define MAUSB_PORT_20_STATUS_ENABLE          0x0002
+#define MAUSB_PORT_20_STATUS_SUSPEND         0x0004
+#define MAUSB_PORT_20_STATUS_OVER_CURRENT    0x0008
+#define MAUSB_PORT_20_STATUS_RESET           0x0010
+#define MAUSB_PORT_20_STATUS_POWER           0x0100
+#define MAUSB_PORT_20_STATUS_LOW_SPEED       0x0200
+#define MAUSB_PORT_20_STATUS_HIGH_SPEED      0x0400
+
+#define MAUSB_CHANGE_PORT_20_STATUS_CONNECT  0x010000
+#define MAUSB_CHANGE_PORT_20_STATUS_RESET    0x100000
+
+/* USB 3.2 specification chapter 10.16.2.6.1 table 10-13 page 440 */
+#define MAUSB_PORT_30_STATUS_CONNECT              0x0001
+#define MAUSB_PORT_30_STATUS_ENABLE               0x0002
+#define MAUSB_PORT_30_STATUS_OVER_CURRENT         0x0008
+#define MAUSB_PORT_30_STATUS_RESET                0x0010
+#define MAUSB_PORT_30_LINK_STATE_U0               0x0000
+#define MAUSB_PORT_30_LINK_STATE_U1               0x0020
+#define MAUSB_PORT_30_LINK_STATE_U2               0x0040
+#define MAUSB_PORT_30_LINK_STATE_U3               0x0060
+#define MAUSB_PORT_30_LINK_STATE_DISABLED         0x0080
+#define MAUSB_PORT_30_LINK_STATE_RX_DETECT        0x00A0
+#define MAUSB_PORT_30_LINK_STATE_INACTIVE         0x00C0
+#define MAUSB_PORT_30_LINK_STATE_POLLING          0x00E0
+#define MAUSB_PORT_30_LINK_STATE_RECOVERY         0x0100
+#define MAUSB_PORT_30_LINK_STATE_HOT_RESET        0x0120
+#define MAUSB_PORT_30_LINK_STATE_COMPLIANCE_MODE  0x0140
+#define MAUSB_PORT_30_LINK_STATE_LOOPBACK         0x0160
+#define MAUSB_PORT_30_STATUS_POWER                0x0200
+#define MAUSB_PORT_30_STATUS_SUPER_SPEED          0x0400
+#define MAUSB_PORT_30_CLEAR_LINK_STATE            0xFE1F
+
+/* USB 3.2 specification chapter 10.16.2.6.2 table 10-14 page 443 */
+#define MAUSB_CHANGE_PORT_30_STATUS_CONNECT              0x010000
+#define MAUSB_CHANGE_PORT_30_STATUS_OVER_CURRENT         0x080000
+#define MAUSB_CHANGE_PORT_30_STATUS_RESET                0x100000
+#define MAUSB_CHANGE_PORT_30_BH_STATUS_RESET             0x200000
+#define MAUSB_CHANGE_PORT_30_LINK_STATE                  0x400000
+#define MAUSB_CHANGE_PORT_30_CONFIG_ERROR                0x800000
+
+/* USB 3.2 specification chapter 10.16.2.4 table 10-10 page 438 */
+#define MAUSB_HUB_30_POWER_GOOD              0x00
+#define MAUSB_HUB_30_LOCAL_POWER_SOURCE_LOST 0x01
+#define MAUSB_HUB_30_OVER_CURRENT            0x02
+
+/* USB 3.2 specification chapter 10.16.2.4 table 10-11 page 438 */
+#define MAUSB_CHANGE_HUB_30_LOCAL_POWER_SOURCE_LOST  0x10000
+#define MAUSB_CHANGE_HUB_30_OVER_CURRENT             0x20000
+
+#define DEV_HANDLE_NOT_ASSIGNED=09-1
+
+struct mausb_usb_device_ctx {
+=09s32=09=09dev_handle;
+=09bool=09=09addressed;
+=09void=09=09*dev_addr;
+=09struct rb_node=09rb_node;
+};
+
+struct mausb_endpoint_ctx {
+=09u16=09ep_handle;
+=09u16=09dev_handle;
+=09void=09*ma_dev;
+=09struct mausb_usb_device_ctx *usb_device_ctx;
+};
+
+struct mausb_urb_ctx {
+=09struct urb=09=09*urb;
+=09struct rb_node=09=09rb_node;
+=09struct work_struct=09work;
+};
+
+int mausb_probe(struct device *dev);
+
+void mausb_clear_hcd_madev(u16 port_number);
+
 #endif /* __MAUSB_HCD_H__ */
--=20
2.17.1

