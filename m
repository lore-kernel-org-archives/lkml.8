Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64410C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4570820720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgGHJzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 05:55:10 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:39306 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgGHJzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:55:09 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id B7D6DBC0C2;
        Wed,  8 Jul 2020 09:55:06 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] Replace HTTP links with HTTPS ones: USB MASS STORAGE DRIVER
Date:   Wed,  8 Jul 2020 11:55:00 +0200
Message-Id: <20200708095500.13694-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.
 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
 (Actually letting a shell for loop submit all this stuff for me.)

 If there are any URLs to be removed completely or at least not HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.


 drivers/usb/storage/Kconfig        | 2 +-
 drivers/usb/storage/freecom.c      | 2 +-
 drivers/usb/storage/unusual_devs.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/storage/Kconfig b/drivers/usb/storage/Kconfig
index 5335a7ff5d14..d17b60a644ef 100644
--- a/drivers/usb/storage/Kconfig
+++ b/drivers/usb/storage/Kconfig
@@ -57,7 +57,7 @@ config USB_STORAGE_FREECOM
 	tristate "Freecom USB/ATAPI Bridge support"
 	help
 	  Support for the Freecom USB to IDE/ATAPI adaptor.
-	  Freecom has a web page at <http://www.freecom.de/>.
+	  Freecom has a web page at <https://www.freecom.de/>.
 
 	  If this driver is compiled as a module, it will be named ums-freecom.
 
diff --git a/drivers/usb/storage/freecom.c b/drivers/usb/storage/freecom.c
index 34e7eaff1174..3d5f7d0ff0f1 100644
--- a/drivers/usb/storage/freecom.c
+++ b/drivers/usb/storage/freecom.c
@@ -11,7 +11,7 @@
  *
  * This driver was developed with information provided in FREECOM's USB
  * Programmers Reference Guide.  For further information contact Freecom
- * (http://www.freecom.de/)
+ * (https://www.freecom.de/)
  */
 
 #include <linux/module.h>
diff --git a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
index b6a9a7451620..220ae2c356ee 100644
--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -44,7 +44,7 @@
  * mode.  Existing userspace solutions are superior.
  *
  * New mode switching devices should instead be added to the database
- * maintained at http://www.draisberghof.de/usb_modeswitch/
+ * maintained at https://www.draisberghof.de/usb_modeswitch/
  */
 
 #if !defined(CONFIG_USB_STORAGE_SDDR09) && \
-- 
2.27.0

