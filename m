Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38839C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13ADA21D6C
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592473397;
	bh=i9JeJIALNjzTrIEVjDmpg7b8gg3dE54NRITDfTxUC7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TZqPC8ndf1FotM9DLWGhD/7VYbooHTtxBAJXw/akqULuoANBfCcACg0FJKsxc0+Ry
	 AXy7oVJs2MWy6hHK95qhNJzj2Hdcb1POEEXbYxJ2OtZoxqB7rPNF1L9/DCEcmpd3zG
	 zZKeOTGzMIkDqpu0v+muszJOgbJ3rP92sAv/Pqtw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbgFRJnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 05:43:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:43514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728568AbgFRJnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 05:43:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC0DA21548;
        Thu, 18 Jun 2020 09:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592473389;
        bh=i9JeJIALNjzTrIEVjDmpg7b8gg3dE54NRITDfTxUC7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S+rW7gFjAnZDhzVV5EeTL2h4bim5p831/I8lqdr9sK4UzwRsUSd31pNW0raTblHH5
         EJemjIGPptDv5Tn8O/arGpXtKtO1g7GiYFaprYbxJuFRJ4FzLi1jCHEbejwGRyuxXv
         2R0SbLO+ivz1L0sRe1p/nhAjmK7FmL1ON+8D1PTE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Richard Dodd <richard.o.dodd@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jonathan Cox <jonathan@jdcox.net>,
        Bastien Nocera <hadess@hadess.net>,
        =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>,
        Nishad Kamdar <nishadkamdar@gmail.com>
Subject: [PATCH 1/8] USB: rename USB quirk to USB_QUIRK_ENDPOINT_IGNORE
Date:   Thu, 18 Jun 2020 11:42:53 +0200
Message-Id: <20200618094300.1887727-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618094300.1887727-1-gregkh@linuxfoundation.org>
References: <20200618094300.1887727-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB core has a quirk flag to ignore specific endpoints, so rename it
to be more obvious what this quirk does.

Cc: Johan Hovold <johan@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Richard Dodd <richard.o.dodd@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Jonathan Cox <jonathan@jdcox.net>
Cc: Bastien Nocera <hadess@hadess.net>
Cc: "Thiébaud Weksteen" <tweek@google.com>
Cc: Nishad Kamdar <nishadkamdar@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/config.c  |  8 ++++----
 drivers/usb/core/quirks.c  | 18 +++++++++---------
 drivers/usb/core/usb.h     |  2 +-
 include/linux/usb/quirks.h |  4 ++--
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index b7918f695434..37442f423a41 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -298,10 +298,10 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 		goto skip_to_next_endpoint_or_interface_descriptor;
 	}
 
-	/* Ignore blacklisted endpoints */
-	if (udev->quirks & USB_QUIRK_ENDPOINT_BLACKLIST) {
-		if (usb_endpoint_is_blacklisted(udev, ifp, d)) {
-			dev_warn(ddev, "config %d interface %d altsetting %d has a blacklisted endpoint with address 0x%X, skipping\n",
+	/* Ignore some endpoints */
+	if (udev->quirks & USB_QUIRK_ENDPOINT_IGNORE) {
+		if (usb_endpoint_is_ignored(udev, ifp, d)) {
+			dev_warn(ddev, "config %d interface %d altsetting %d has an ignored endpoint with address 0x%X, skipping\n",
 					cfgno, inum, asnum,
 					d->bEndpointAddress);
 			goto skip_to_next_endpoint_or_interface_descriptor;
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 3e8efe759c3e..20dccf34182d 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -359,7 +359,7 @@ static const struct usb_device_id usb_quirk_list[] = {
 
 	/* Sound Devices USBPre2 */
 	{ USB_DEVICE(0x0926, 0x0202), .driver_info =
-			USB_QUIRK_ENDPOINT_BLACKLIST },
+			USB_QUIRK_ENDPOINT_IGNORE },
 
 	/* Keytouch QWERTY Panel keyboard */
 	{ USB_DEVICE(0x0926, 0x3333), .driver_info =
@@ -493,24 +493,24 @@ static const struct usb_device_id usb_amd_resume_quirk_list[] = {
 };
 
 /*
- * Entries for blacklisted endpoints that should be ignored when parsing
- * configuration descriptors.
+ * Entries for endpoints that should be ignored when parsing configuration
+ * descriptors.
  *
- * Matched for devices with USB_QUIRK_ENDPOINT_BLACKLIST.
+ * Matched for devices with USB_QUIRK_ENDPOINT_IGNORE.
  */
-static const struct usb_device_id usb_endpoint_blacklist[] = {
+static const struct usb_device_id usb_endpoint_ignore[] = {
 	{ USB_DEVICE_INTERFACE_NUMBER(0x0926, 0x0202, 1), .driver_info = 0x85 },
 	{ }
 };
 
-bool usb_endpoint_is_blacklisted(struct usb_device *udev,
-		struct usb_host_interface *intf,
-		struct usb_endpoint_descriptor *epd)
+bool usb_endpoint_is_ignored(struct usb_device *udev,
+			     struct usb_host_interface *intf,
+			     struct usb_endpoint_descriptor *epd)
 {
 	const struct usb_device_id *id;
 	unsigned int address;
 
-	for (id = usb_endpoint_blacklist; id->match_flags; ++id) {
+	for (id = usb_endpoint_ignore; id->match_flags; ++id) {
 		if (!usb_match_device(udev, id))
 			continue;
 
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index 19e4c550bc73..98e7d1ee63dc 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -37,7 +37,7 @@ extern void usb_authorize_interface(struct usb_interface *);
 extern void usb_detect_quirks(struct usb_device *udev);
 extern void usb_detect_interface_quirks(struct usb_device *udev);
 extern void usb_release_quirk_list(void);
-extern bool usb_endpoint_is_blacklisted(struct usb_device *udev,
+extern bool usb_endpoint_is_ignored(struct usb_device *udev,
 		struct usb_host_interface *intf,
 		struct usb_endpoint_descriptor *epd);
 extern int usb_remove_device(struct usb_device *udev);
diff --git a/include/linux/usb/quirks.h b/include/linux/usb/quirks.h
index 22c1f579afe3..5e4c497f54d6 100644
--- a/include/linux/usb/quirks.h
+++ b/include/linux/usb/quirks.h
@@ -69,7 +69,7 @@
 /* Hub needs extra delay after resetting its port. */
 #define USB_QUIRK_HUB_SLOW_RESET		BIT(14)
 
-/* device has blacklisted endpoints */
-#define USB_QUIRK_ENDPOINT_BLACKLIST		BIT(15)
+/* device has endpoints that should be ignored */
+#define USB_QUIRK_ENDPOINT_IGNORE		BIT(15)
 
 #endif /* __LINUX_USB_QUIRKS_H */
-- 
2.27.0

