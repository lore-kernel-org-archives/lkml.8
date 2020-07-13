Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CE0C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 15:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C3C720771
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 15:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594654819;
	bh=0oDZPpCS+Q2MvYjhzJWHLHOBZvgcY8MWJm2GqBucVlQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=RZE/jmnB4kY0H75nmMLgRTMgmjBgoPFfkm1JUJeeg3lShhTP3v+U5iga7h7N2gO7T
	 F06jnm+TQb9mJztEhzn5uB45X5EH+Z6eJCnOHoJ6cNT/JI+T2r4NYWCoNCtD21X6T1
	 fzrTIGbjAPx1+65Aa1QZi03ibJz1LxAG7H51eqGg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbgGMPkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 11:40:18 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34035 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729644AbgGMPkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 11:40:17 -0400
Received: by mail-lj1-f196.google.com with SMTP id q7so18444875ljm.1;
        Mon, 13 Jul 2020 08:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+jyng9Hgh2x8iRAD8u7WdBq+B8/Hrc2f6uvoQiIpjbE=;
        b=EHSYFSNC+04xNfPy5Hp+cJ7zRnqIlvVnIFGzIC28ZtLWsOay7iFZOEG8PAvQDHqdW+
         eKsxzn5w2FJHnmU9kDfr68+HkWm5A/pWN9rq+0AOL557H318gWsKypb3dPTONe/ZCaZZ
         CxTfYAQq3uvBAyb1TbLQkurF3iNqLnykgJf2GuNE/jFC7QOjLEg9oh09DcYU04fO40oD
         wv70Tl4yieZeO/RM8pYOZUNQa4DzZCUx9sab2CzBH3eStU5KKQgtxE0yOSb5N2BUO7Yh
         B7N/oM1D+kxDghbsEirqwfVn0dErNbBcPk9lcTBByWwyqFGbIUx/O0ukX3xi8+n6LBqo
         UHsA==
X-Gm-Message-State: AOAM533xuvV9Yi/qLExcl/zbI5kynLDJfkmatXidD4HqQfoWui6Uv2xx
        hS04PEWKZh6jE3Q4CokK2CEuvhDGD74=
X-Google-Smtp-Source: ABdhPJyWh32U8JxNbVuaaonEO0IPDEPGJEcEI+ai5ippYeLJ92IgokzLCmXLTPN9JbhahoblNFju7g==
X-Received: by 2002:a2e:9b0f:: with SMTP id u15mr182249lji.180.1594654813138;
        Mon, 13 Jul 2020 08:40:13 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id x24sm4137103ljh.21.2020.07.13.08.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 08:40:12 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1jv0Z3-0004hp-1R; Mon, 13 Jul 2020 17:40:21 +0200
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH] USB: serial: sierra: clean up special-interface handling
Date:   Mon, 13 Jul 2020 17:39:36 +0200
Message-Id: <20200713153936.18032-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the handling of special interfaces that either should be
ignored or that need a larger number of URBs.

Commit 66f092ed3b94 ("USB: serial: sierra: unify quirk handling logic")
replaced the previous is_blacklisted() and is_highmemory() helpers with
a single is_quirk() helper which made it even harder to understand what
the interface lists were used for.

Rename the interface-list struct, its members and the interface-lookup
helper and restructure the code somewhat in order to make it more
self-explanatory.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/sierra.c | 58 ++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/usb/serial/sierra.c b/drivers/usb/serial/sierra.c
index a862aa788a19..57fc3c31712e 100644
--- a/drivers/usb/serial/sierra.c
+++ b/drivers/usb/serial/sierra.c
@@ -45,10 +45,9 @@
 
 static bool nmea;
 
-/* Used in interface quirks */
-struct sierra_iface_quirk {
-	const u32 infolen;	/* number of interface numbers on the list */
-	const u8  *ifaceinfo;	/* pointer to the array holding the numbers */
+struct sierra_iface_list {
+	const u8 *nums;		/* array of interface numbers */
+	size_t count;		/* number of elements in array */
 };
 
 struct sierra_intf_private {
@@ -101,20 +100,19 @@ static int sierra_calc_num_ports(struct usb_serial *serial,
 	return num_ports;
 }
 
-static int is_quirk(const u8 ifnum, const struct sierra_iface_quirk *quirk)
+static bool is_listed(const u8 ifnum, const struct sierra_iface_list *list)
 {
-	const u8  *info;
 	int i;
 
-	if (quirk) {
-		info = quirk->ifaceinfo;
+	if (!list)
+		return false;
 
-		for (i = 0; i < quirk->infolen; i++) {
-			if (info[i] == ifnum)
-				return 1;
-		}
+	for (i = 0; i < list->count; i++) {
+		if (list->nums[i] == ifnum)
+			return true;
 	}
-	return 0;
+
+	return false;
 }
 
 static u8 sierra_interface_num(struct usb_serial *serial)
@@ -125,6 +123,7 @@ static u8 sierra_interface_num(struct usb_serial *serial)
 static int sierra_probe(struct usb_serial *serial,
 			const struct usb_device_id *id)
 {
+	const struct sierra_iface_list *ignore_list;
 	int result = 0;
 	struct usb_device *udev;
 	u8 ifnum;
@@ -143,9 +142,10 @@ static int sierra_probe(struct usb_serial *serial,
 		usb_set_interface(udev, ifnum, 1);
 	}
 
-	if (is_quirk(ifnum, (struct sierra_iface_quirk *)id->driver_info)) {
-		dev_dbg(&serial->dev->dev,
-			"Ignoring interface #%d\n", ifnum);
+	ignore_list = (const struct sierra_iface_list *)id->driver_info;
+
+	if (is_listed(ifnum, ignore_list)) {
+		dev_dbg(&serial->dev->dev, "Ignoring interface #%d\n", ifnum);
 		return -ENODEV;
 	}
 
@@ -154,22 +154,22 @@ static int sierra_probe(struct usb_serial *serial,
 
 /* interfaces with higher memory requirements */
 static const u8 hi_memory_typeA_ifaces[] = { 0, 2 };
-static const struct sierra_iface_quirk typeA_interface_list = {
-	.infolen = ARRAY_SIZE(hi_memory_typeA_ifaces),
-	.ifaceinfo = hi_memory_typeA_ifaces,
+static const struct sierra_iface_list typeA_interface_list = {
+	.nums	= hi_memory_typeA_ifaces,
+	.count	= ARRAY_SIZE(hi_memory_typeA_ifaces),
 };
 
 static const u8 hi_memory_typeB_ifaces[] = { 3, 4, 5, 6 };
-static const struct sierra_iface_quirk typeB_interface_list = {
-	.infolen = ARRAY_SIZE(hi_memory_typeB_ifaces),
-	.ifaceinfo = hi_memory_typeB_ifaces,
+static const struct sierra_iface_list typeB_interface_list = {
+	.nums	= hi_memory_typeB_ifaces,
+	.count	= ARRAY_SIZE(hi_memory_typeB_ifaces),
 };
 
 /* 'ignorelist' of interfaces not served by this driver */
 static const u8 direct_ip_non_serial_ifaces[] = { 7, 8, 9, 10, 11, 19, 20 };
-static const struct sierra_iface_quirk direct_ip_interface_ignore = {
-	.infolen = ARRAY_SIZE(direct_ip_non_serial_ifaces),
-	.ifaceinfo = direct_ip_non_serial_ifaces,
+static const struct sierra_iface_list direct_ip_interface_ignore = {
+	.nums	= direct_ip_non_serial_ifaces,
+	.count	= ARRAY_SIZE(direct_ip_non_serial_ifaces),
 };
 
 static const struct usb_device_id id_table[] = {
@@ -859,7 +859,7 @@ static int sierra_port_probe(struct usb_serial_port *port)
 {
 	struct usb_serial *serial = port->serial;
 	struct sierra_port_private *portdata;
-	const struct sierra_iface_quirk *himemoryp;
+	const struct sierra_iface_list *himemory_list;
 	u8 ifnum;
 
 	portdata = kzalloc(sizeof(*portdata), GFP_KERNEL);
@@ -878,16 +878,16 @@ static int sierra_port_probe(struct usb_serial_port *port)
 	if (serial->num_ports == 1) {
 		/* Get interface number for composite device */
 		ifnum = sierra_interface_num(serial);
-		himemoryp = &typeB_interface_list;
+		himemory_list = &typeB_interface_list;
 	} else {
 		/* This is really the usb-serial port number of the interface
 		 * rather than the interface number.
 		 */
 		ifnum = port->port_number;
-		himemoryp = &typeA_interface_list;
+		himemory_list = &typeA_interface_list;
 	}
 
-	if (is_quirk(ifnum, himemoryp)) {
+	if (is_listed(ifnum, himemory_list)) {
 		portdata->num_out_urbs = N_OUT_URB_HM;
 		portdata->num_in_urbs  = N_IN_URB_HM;
 	}
-- 
2.26.2

