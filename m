Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD17C52D22
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639F120714
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582812572;
	bh=E0vW91EnFjMbWvi7ObLwZDH0vrqlLgBnMuIIRvTeiF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bhjBPKryybF2sVC7CoDaOSwBK+CW1FisxDpUhB40wYGyGdYHPYvKLdeDVgdeJGrii
	 s4MxK2U5ViM5Mz7yG0BHzFpafsp2hh/MWHvPAUHb3E3//bCNo+u+0R8haQsihA6a3p
	 kH3uKsZvSYrAuIp5N813ing2YnTDq0kG8sodKhDI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388399AbgB0OJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:09:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:47384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387989AbgB0OJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:09:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A6FE24656;
        Thu, 27 Feb 2020 14:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812564;
        bh=E0vW91EnFjMbWvi7ObLwZDH0vrqlLgBnMuIIRvTeiF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1+7SZkPkxCzNu7AbgIzqYVr4TJslh+2aRmbcO3WE6VmPu69rR2fl93FpJfs1RycfI
         yOfp6uNh4SP91FzT7benhO+kH6/z2N/U6InxlSGm9n472N37ts/Dg4cpnDuK9RsTcu
         NbapHPH0Z/x4Cd+yv+tl44MuMjbj1TzsSqbFAYBQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, edes <edes@gmx.net>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.4 028/135] USB: core: add endpoint-blacklist quirk
Date:   Thu, 27 Feb 2020 14:36:08 +0100
Message-Id: <20200227132233.366680167@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132228.710492098@linuxfoundation.org>
References: <20200227132228.710492098@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 73f8bda9b5dc1c69df2bc55c0cbb24461a6391a9 upstream.

Add a new device quirk that can be used to blacklist endpoints.

Since commit 3e4f8e21c4f2 ("USB: core: fix check for duplicate
endpoints") USB core ignores any duplicate endpoints found during
descriptor parsing.

In order to handle devices where the first interfaces with duplicate
endpoints are the ones that should have their endpoints ignored, we need
to add a blacklist.

Tested-by: edes <edes@gmx.net>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20200203153830.26394-2-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/config.c  |   11 +++++++++++
 drivers/usb/core/quirks.c  |   32 ++++++++++++++++++++++++++++++++
 drivers/usb/core/usb.h     |    3 +++
 include/linux/usb/quirks.h |    3 +++
 4 files changed, 49 insertions(+)

--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -256,6 +256,7 @@ static int usb_parse_endpoint(struct dev
 		struct usb_host_interface *ifp, int num_ep,
 		unsigned char *buffer, int size)
 {
+	struct usb_device *udev = to_usb_device(ddev);
 	unsigned char *buffer0 = buffer;
 	struct usb_endpoint_descriptor *d;
 	struct usb_host_endpoint *endpoint;
@@ -297,6 +298,16 @@ static int usb_parse_endpoint(struct dev
 		goto skip_to_next_endpoint_or_interface_descriptor;
 	}
 
+	/* Ignore blacklisted endpoints */
+	if (udev->quirks & USB_QUIRK_ENDPOINT_BLACKLIST) {
+		if (usb_endpoint_is_blacklisted(udev, ifp, d)) {
+			dev_warn(ddev, "config %d interface %d altsetting %d has a blacklisted endpoint with address 0x%X, skipping\n",
+					cfgno, inum, asnum,
+					d->bEndpointAddress);
+			goto skip_to_next_endpoint_or_interface_descriptor;
+		}
+	}
+
 	endpoint = &ifp->endpoint[ifp->desc.bNumEndpoints];
 	++ifp->desc.bNumEndpoints;
 
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -472,6 +472,38 @@ static const struct usb_device_id usb_am
 	{ }  /* terminating entry must be last */
 };
 
+/*
+ * Entries for blacklisted endpoints that should be ignored when parsing
+ * configuration descriptors.
+ *
+ * Matched for devices with USB_QUIRK_ENDPOINT_BLACKLIST.
+ */
+static const struct usb_device_id usb_endpoint_blacklist[] = {
+	{ }
+};
+
+bool usb_endpoint_is_blacklisted(struct usb_device *udev,
+		struct usb_host_interface *intf,
+		struct usb_endpoint_descriptor *epd)
+{
+	const struct usb_device_id *id;
+	unsigned int address;
+
+	for (id = usb_endpoint_blacklist; id->match_flags; ++id) {
+		if (!usb_match_device(udev, id))
+			continue;
+
+		if (!usb_match_one_id_intf(udev, intf, id))
+			continue;
+
+		address = id->driver_info;
+		if (address == epd->bEndpointAddress)
+			return true;
+	}
+
+	return false;
+}
+
 static bool usb_match_any_interface(struct usb_device *udev,
 				    const struct usb_device_id *id)
 {
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -37,6 +37,9 @@ extern void usb_authorize_interface(stru
 extern void usb_detect_quirks(struct usb_device *udev);
 extern void usb_detect_interface_quirks(struct usb_device *udev);
 extern void usb_release_quirk_list(void);
+extern bool usb_endpoint_is_blacklisted(struct usb_device *udev,
+		struct usb_host_interface *intf,
+		struct usb_endpoint_descriptor *epd);
 extern int usb_remove_device(struct usb_device *udev);
 
 extern int usb_get_device_descriptor(struct usb_device *dev,
--- a/include/linux/usb/quirks.h
+++ b/include/linux/usb/quirks.h
@@ -69,4 +69,7 @@
 /* Hub needs extra delay after resetting its port. */
 #define USB_QUIRK_HUB_SLOW_RESET		BIT(14)
 
+/* device has blacklisted endpoints */
+#define USB_QUIRK_ENDPOINT_BLACKLIST		BIT(15)
+
 #endif /* __LINUX_USB_QUIRKS_H */


