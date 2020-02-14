Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9925C3B1B5
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A6E422314
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405146AbgBNSRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:17:19 -0500
Received: from smtprelay0076.hostedemail.com ([216.40.44.76]:51244 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405119AbgBNSRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:17:18 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id AB4161822451B;
        Fri, 14 Feb 2020 18:17:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: north37_224944e309a50
X-Filterd-Recvd-Size: 5967
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Fri, 14 Feb 2020 18:17:15 +0000 (UTC)
Message-ID: <60559197a1af9e0af7f329cc3427989e5756846f.camel@perches.com>
Subject: [PATCH] usb-storage: Use const to reduce object data size
From:   Joe Perches <joe@perches.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 14 Feb 2020 10:15:57 -0800
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make structs const to reduce data size ~20KB.

Change function arguments and prototypes as necessary to compile.

$ size (x86-64 defconfig pre)
   text	   data	    bss	    dec	    hex	filename
  12281	  10948	    480	  23709	   5c9d	./drivers/usb/storage/usb.o
    111	  10528	      8	  10647	   2997	./drivers/usb/storage/usual-tables.o

$ size (x86-64 defconfig post)
   text	   data	    bss	    dec	    hex	filename
  22809	    420	    480	  23709	   5c9d	drivers/usb/storage/usb.o
  10551	      0	      0	  10551	   2937	drivers/usb/storage/usual-tables.o

Signed-off-by: Joe Perches <joe@perches.com>
---

compile tested only

 drivers/usb/storage/usb.c          | 10 +++++-----
 drivers/usb/storage/usb.h          |  5 +++--
 drivers/usb/storage/usual-tables.c |  6 +++---
 include/linux/usb_usual.h          |  2 +-
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/storage/usb.c b/drivers/usb/storage/usb.c
index 9a79cd..94a6472 100644
--- a/drivers/usb/storage/usb.c
+++ b/drivers/usb/storage/usb.c
@@ -121,12 +121,12 @@ MODULE_PARM_DESC(quirks, "supplemental list of
device IDs and their quirks");
 	.initFunction = init_function,	\
 }
 
-static struct us_unusual_dev us_unusual_dev_list[] = {
+static const struct us_unusual_dev us_unusual_dev_list[] = {
 #	include "unusual_devs.h"
 	{ }		/* Terminating entry */
 };
 
-static struct us_unusual_dev for_dynamic_ids =
+static const struct us_unusual_dev for_dynamic_ids =
 		USUAL_DEV(USB_SC_SCSI, USB_PR_BULK);
 
 #undef UNUSUAL_DEV
@@ -583,7 +583,7 @@ EXPORT_SYMBOL_GPL(usb_stor_adjust_quirks);
 
 /* Get the unusual_devs entries and the string descriptors */
 static int get_device_info(struct us_data *us, const struct
usb_device_id *id,
-		struct us_unusual_dev *unusual_dev)
+		const struct us_unusual_dev *unusual_dev)
 {
 	struct usb_device *dev = us->pusb_dev;
 	struct usb_interface_descriptor *idesc =
@@ -933,7 +933,7 @@ static unsigned int usb_stor_sg_tablesize(struct
usb_interface *intf)
 int usb_stor_probe1(struct us_data **pus,
 		struct usb_interface *intf,
 		const struct usb_device_id *id,
-		struct us_unusual_dev *unusual_dev,
+		const struct us_unusual_dev *unusual_dev,
 		struct scsi_host_template *sht)
 {
 	struct Scsi_Host *host;
@@ -1092,7 +1092,7 @@ static struct scsi_host_template
usb_stor_host_template;
 static int storage_probe(struct usb_interface *intf,
 			 const struct usb_device_id *id)
 {
-	struct us_unusual_dev *unusual_dev;
+	const struct us_unusual_dev *unusual_dev;
 	struct us_data *us;
 	int result;
 	int size;
diff --git a/drivers/usb/storage/usb.h b/drivers/usb/storage/usb.h
index 85052c..5850d62 100644
--- a/drivers/usb/storage/usb.h
+++ b/drivers/usb/storage/usb.h
@@ -93,7 +93,8 @@ struct us_data {
 	struct mutex		dev_mutex;	 /* protect pusb_dev */
 	struct usb_device	*pusb_dev;	 /* this usb_device */
 	struct usb_interface	*pusb_intf;	 /* this interface */
-	struct us_unusual_dev   *unusual_dev;	 /* device-filter
entry     */
+	const struct us_unusual_dev   *unusual_dev;
+						/* device-filter
entry     */
 	unsigned long		fflags;		 /* fixed flags from
filter */
 	unsigned long		dflags;		 /* dynamic atomic
bitflags */
 	unsigned int		send_bulk_pipe;	 /* cached pipe values
*/
@@ -185,7 +186,7 @@ extern int usb_stor_post_reset(struct usb_interface
*iface);
 extern int usb_stor_probe1(struct us_data **pus,
 		struct usb_interface *intf,
 		const struct usb_device_id *id,
-		struct us_unusual_dev *unusual_dev,
+		const struct us_unusual_dev *unusual_dev,
 		struct scsi_host_template *sht);
 extern int usb_stor_probe2(struct us_data *us);
 extern void usb_stor_disconnect(struct usb_interface *intf);
diff --git a/drivers/usb/storage/usual-tables.c
b/drivers/usb/storage/usual-tables.c
index cfd12e5..529512 100644
--- a/drivers/usb/storage/usual-tables.c
+++ b/drivers/usb/storage/usual-tables.c
@@ -40,7 +40,7 @@
 	.driver_info = (flags) \
 }
 
-struct usb_device_id usb_storage_usb_ids[] = {
+const struct usb_device_id usb_storage_usb_ids[] = {
 #	include "unusual_devs.h"
 	{ }		/* Terminating entry */
 };
@@ -68,7 +68,7 @@ struct ignore_entry {
 	.bcdmax = bcdDeviceMax,		\
 }
 
-static struct ignore_entry ignore_ids[] = {
+static const struct ignore_entry ignore_ids[] = {
 #	include "unusual_alauda.h"
 #	include "unusual_cypress.h"
 #	include "unusual_datafab.h"
@@ -92,7 +92,7 @@ int usb_usual_ignore_device(struct usb_interface
*intf)
 {
 	struct usb_device *udev;
 	unsigned vid, pid, bcd;
-	struct ignore_entry *p;
+	const struct ignore_entry *p;
 
 	udev = interface_to_usbdev(intf);
 	vid = le16_to_cpu(udev->descriptor.idVendor);
diff --git a/include/linux/usb_usual.h b/include/linux/usb_usual.h
index 000a595..4a19ac3 100644
--- a/include/linux/usb_usual.h
+++ b/include/linux/usb_usual.h
@@ -92,6 +92,6 @@ enum { US_DO_ALL_FLAGS };
 #include <linux/usb/storage.h>
 
 extern int usb_usual_ignore_device(struct usb_interface *intf);
-extern struct usb_device_id usb_storage_usb_ids[];
+extern const struct usb_device_id usb_storage_usb_ids[];
 
 #endif /* __LINUX_USB_USUAL_H */


