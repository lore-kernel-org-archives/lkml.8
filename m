Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0BFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73E4321D7B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592473410;
	bh=EUL5EpWmg/P73fVYKwEbU1keTjpnVeTCNmlbj41nbss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aXqYto1Z5Omnsi8MZmojQ6fRS3v/ExOSbUseQLBqFyQDJYoK8K6QXpx5dYSxGBvlv
	 9AS+8GF8qXi4MaWDwVeAtE6Y/1VN8qilkstN2WUdyUAODfLKmVw+cFA8Xd1DiLgkDQ
	 XFh62dMEpL6g+zYxk8qxsdGMKrkzCAIMYOq1t7P0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgFRJn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 05:43:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:43800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729060AbgFRJn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 05:43:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05F2421D6C;
        Thu, 18 Jun 2020 09:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592473404;
        bh=EUL5EpWmg/P73fVYKwEbU1keTjpnVeTCNmlbj41nbss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bYBFVWTB1XuqG0yqh/PlJireakJ6pml4VyoKrdKqu+j8gx7+IcOB7l11+IYfmdzjw
         sshdVBdPggGguppX+cd3FtJ6hrbz4QptES50Io1Ac52N2Xs6DJPToMFxnpKa1wmbhp
         WLF5LyGNb22AXxZSDuyhfk2DLs1ElTRr5IA5B3hk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 5/8] USB: serial: sierra: unify quirk handling logic
Date:   Thu, 18 Jun 2020 11:42:57 +0200
Message-Id: <20200618094300.1887727-6-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618094300.1887727-1-gregkh@linuxfoundation.org>
References: <20200618094300.1887727-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sierra driver had two different functions for trying to determine
different quirks that did the same exact thing.  Remove one and rename
things to make it more obvious exactly what the different lists do.

Cc: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/serial/sierra.c | 57 +++++++++++++------------------------
 1 file changed, 19 insertions(+), 38 deletions(-)

diff --git a/drivers/usb/serial/sierra.c b/drivers/usb/serial/sierra.c
index a43263a0edd8..e8b130157b57 100644
--- a/drivers/usb/serial/sierra.c
+++ b/drivers/usb/serial/sierra.c
@@ -45,9 +45,9 @@
 
 static bool nmea;
 
-/* Used in interface blacklisting */
-struct sierra_iface_info {
-	const u32 infolen;	/* number of interface numbers on blacklist */
+/* Used in interface quirks */
+struct sierra_iface_quirk {
+	const u32 infolen;	/* number of interface numbers on the list */
 	const u8  *ifaceinfo;	/* pointer to the array holding the numbers */
 };
 
@@ -101,33 +101,15 @@ static int sierra_calc_num_ports(struct usb_serial *serial,
 	return num_ports;
 }
 
-static int is_blacklisted(const u8 ifnum,
-				const struct sierra_iface_info *blacklist)
+static int is_quirk(const u8 ifnum, const struct sierra_iface_quirk *quirk)
 {
 	const u8  *info;
 	int i;
 
-	if (blacklist) {
-		info = blacklist->ifaceinfo;
+	if (quirk) {
+		info = quirk->ifaceinfo;
 
-		for (i = 0; i < blacklist->infolen; i++) {
-			if (info[i] == ifnum)
-				return 1;
-		}
-	}
-	return 0;
-}
-
-static int is_himemory(const u8 ifnum,
-				const struct sierra_iface_info *himemorylist)
-{
-	const u8  *info;
-	int i;
-
-	if (himemorylist) {
-		info = himemorylist->ifaceinfo;
-
-		for (i=0; i < himemorylist->infolen; i++) {
+		for (i = 0; i < quirk->infolen; i++) {
 			if (info[i] == ifnum)
 				return 1;
 		}
@@ -161,10 +143,9 @@ static int sierra_probe(struct usb_serial *serial,
 		usb_set_interface(udev, ifnum, 1);
 	}
 
-	if (is_blacklisted(ifnum,
-				(struct sierra_iface_info *)id->driver_info)) {
+	if (is_quirk(ifnum, (struct sierra_iface_quirk *)id->driver_info)) {
 		dev_dbg(&serial->dev->dev,
-			"Ignoring blacklisted interface #%d\n", ifnum);
+			"Ignoring interface #%d\n", ifnum);
 		return -ENODEV;
 	}
 
@@ -173,20 +154,20 @@ static int sierra_probe(struct usb_serial *serial,
 
 /* interfaces with higher memory requirements */
 static const u8 hi_memory_typeA_ifaces[] = { 0, 2 };
-static const struct sierra_iface_info typeA_interface_list = {
+static const struct sierra_iface_quirk typeA_interface_list = {
 	.infolen = ARRAY_SIZE(hi_memory_typeA_ifaces),
 	.ifaceinfo = hi_memory_typeA_ifaces,
 };
 
 static const u8 hi_memory_typeB_ifaces[] = { 3, 4, 5, 6 };
-static const struct sierra_iface_info typeB_interface_list = {
+static const struct sierra_iface_quirk typeB_interface_list = {
 	.infolen = ARRAY_SIZE(hi_memory_typeB_ifaces),
 	.ifaceinfo = hi_memory_typeB_ifaces,
 };
 
-/* 'blacklist' of interfaces not served by this driver */
+/* 'ignorelist' of interfaces not served by this driver */
 static const u8 direct_ip_non_serial_ifaces[] = { 7, 8, 9, 10, 11, 19, 20 };
-static const struct sierra_iface_info direct_ip_interface_blacklist = {
+static const struct sierra_iface_quirk direct_ip_interface_ignore = {
 	.infolen = ARRAY_SIZE(direct_ip_non_serial_ifaces),
 	.ifaceinfo = direct_ip_non_serial_ifaces,
 };
@@ -264,19 +245,19 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(0x1199, 0x6893) },	/* Sierra Wireless Device */
 	/* Sierra Wireless Direct IP modems */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x1199, 0x68A3, 0xFF, 0xFF, 0xFF),
-	  .driver_info = (kernel_ulong_t)&direct_ip_interface_blacklist
+	  .driver_info = (kernel_ulong_t)&direct_ip_interface_ignore
 	},
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x1199, 0x68AA, 0xFF, 0xFF, 0xFF),
-	  .driver_info = (kernel_ulong_t)&direct_ip_interface_blacklist
+	  .driver_info = (kernel_ulong_t)&direct_ip_interface_ignore
 	},
 	{ USB_DEVICE(0x1199, 0x68AB) }, /* Sierra Wireless AR8550 */
 	/* AT&T Direct IP LTE modems */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0F3D, 0x68AA, 0xFF, 0xFF, 0xFF),
-	  .driver_info = (kernel_ulong_t)&direct_ip_interface_blacklist
+	  .driver_info = (kernel_ulong_t)&direct_ip_interface_ignore
 	},
 	/* Airprime/Sierra Wireless Direct IP modems */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0F3D, 0x68A3, 0xFF, 0xFF, 0xFF),
-	  .driver_info = (kernel_ulong_t)&direct_ip_interface_blacklist
+	  .driver_info = (kernel_ulong_t)&direct_ip_interface_ignore
 	},
 
 	{ }
@@ -879,7 +860,7 @@ static int sierra_port_probe(struct usb_serial_port *port)
 {
 	struct usb_serial *serial = port->serial;
 	struct sierra_port_private *portdata;
-	const struct sierra_iface_info *himemoryp;
+	const struct sierra_iface_quirk *himemoryp;
 	u8 ifnum;
 
 	portdata = kzalloc(sizeof(*portdata), GFP_KERNEL);
@@ -907,7 +888,7 @@ static int sierra_port_probe(struct usb_serial_port *port)
 		himemoryp = &typeA_interface_list;
 	}
 
-	if (is_himemory(ifnum, himemoryp)) {
+	if (is_quirk(ifnum, himemoryp)) {
 		portdata->num_out_urbs = N_OUT_URB_HM;
 		portdata->num_in_urbs  = N_IN_URB_HM;
 	}
-- 
2.27.0

