Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F706C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22AAC2065D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgGHStN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 14:49:13 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:40728 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbgGHStN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 14:49:13 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 06A1EBC0D4;
        Wed,  8 Jul 2020 18:49:09 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] USB: storage: replace HTTP links with HTTPS ones
Date:   Wed,  8 Jul 2020 20:49:03 +0200
Message-Id: <20200708184903.17350-1-grandmaster@al2klimov.de>
In-Reply-To: <20200708103928.GC585606@kroah.com>
References: <20200708103928.GC585606@kroah.com>
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

