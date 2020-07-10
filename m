Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE94C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43EB92075D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgGJTJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 15:09:33 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:57874 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbgGJTJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 15:09:32 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 2BE6DBC06E;
        Fri, 10 Jul 2020 19:09:25 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        alexandre.belloni@bootlin.com, grandmaster@al2klimov.de,
        clabbe@baylibre.com, arnd@arndb.de, yuehaibing@huawei.com,
        yanaijie@huawei.com, baijiaju1990@gmail.com,
        chunfeng.yun@mediatek.com, swboyd@chromium.org,
        christophe.jaillet@wanadoo.fr, jaswinder.singh@linaro.org,
        linux-geode@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: Replace HTTP links with HTTPS ones
Date:   Fri, 10 Jul 2020 21:09:19 +0200
Message-Id: <20200710190919.31464-1-grandmaster@al2klimov.de>
In-Reply-To: <20200710065939.GA1153760@kroah.com>
References: <20200710065939.GA1153760@kroah.com>
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
 Sorry, my mistake.
 Now better?

 drivers/usb/gadget/udc/amd5536udc.h     | 2 +-
 drivers/usb/gadget/udc/amd5536udc_pci.c | 2 +-
 drivers/usb/gadget/udc/gr_udc.c         | 2 +-
 drivers/usb/gadget/udc/gr_udc.h         | 2 +-
 drivers/usb/gadget/udc/max3420_udc.c    | 2 +-
 drivers/usb/gadget/udc/snps_udc_core.c  | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/udc/amd5536udc.h b/drivers/usb/gadget/udc/amd5536udc.h
index 0262383f8c79..3296f3fcee48 100644
--- a/drivers/usb/gadget/udc/amd5536udc.h
+++ b/drivers/usb/gadget/udc/amd5536udc.h
@@ -2,7 +2,7 @@
 /*
  * amd5536.h -- header for AMD 5536 UDC high/full speed USB device controller
  *
- * Copyright (C) 2007 AMD (http://www.amd.com)
+ * Copyright (C) 2007 AMD (https://www.amd.com)
  * Author: Thomas Dahlmann
  */
 
diff --git a/drivers/usb/gadget/udc/amd5536udc_pci.c b/drivers/usb/gadget/udc/amd5536udc_pci.c
index 80685e4306f3..a98b54b30882 100644
--- a/drivers/usb/gadget/udc/amd5536udc_pci.c
+++ b/drivers/usb/gadget/udc/amd5536udc_pci.c
@@ -2,7 +2,7 @@
 /*
  * amd5536udc_pci.c -- AMD 5536 UDC high/full speed USB device controller
  *
- * Copyright (C) 2005-2007 AMD (http://www.amd.com)
+ * Copyright (C) 2005-2007 AMD (https://www.amd.com)
  * Author: Thomas Dahlmann
  */
 
diff --git a/drivers/usb/gadget/udc/gr_udc.c b/drivers/usb/gadget/udc/gr_udc.c
index 7164ad9800f1..8fe0b65772b9 100644
--- a/drivers/usb/gadget/udc/gr_udc.c
+++ b/drivers/usb/gadget/udc/gr_udc.c
@@ -8,7 +8,7 @@
  * GRLIB VHDL IP core library.
  *
  * Full documentation of the GRUSBDC core can be found here:
- * http://www.gaisler.com/products/grlib/grip.pdf
+ * https://www.gaisler.com/products/grlib/grip.pdf
  *
  * Contributors:
  * - Andreas Larsson <andreas@gaisler.com>
diff --git a/drivers/usb/gadget/udc/gr_udc.h b/drivers/usb/gadget/udc/gr_udc.h
index 417ad2aa2cc7..ac5b3f65adb5 100644
--- a/drivers/usb/gadget/udc/gr_udc.h
+++ b/drivers/usb/gadget/udc/gr_udc.h
@@ -8,7 +8,7 @@
  * GRLIB VHDL IP core library.
  *
  * Full documentation of the GRUSBDC core can be found here:
- * http://www.gaisler.com/products/grlib/grip.pdf
+ * https://www.gaisler.com/products/grlib/grip.pdf
  *
  * Contributors:
  * - Andreas Larsson <andreas@gaisler.com>
diff --git a/drivers/usb/gadget/udc/max3420_udc.c b/drivers/usb/gadget/udc/max3420_udc.c
index 23f33946d80c..ea8cf9341dd5 100644
--- a/drivers/usb/gadget/udc/max3420_udc.c
+++ b/drivers/usb/gadget/udc/max3420_udc.c
@@ -7,7 +7,7 @@
  *
  * Based on:
  *	o MAX3420E datasheet
- *		http://datasheets.maximintegrated.com/en/ds/MAX3420E.pdf
+ *		https://datasheets.maximintegrated.com/en/ds/MAX3420E.pdf
  *	o MAX342{0,1}E Programming Guides
  *		https://pdfserv.maximintegrated.com/en/an/AN3598.pdf
  *		https://pdfserv.maximintegrated.com/en/an/AN3785.pdf
diff --git a/drivers/usb/gadget/udc/snps_udc_core.c b/drivers/usb/gadget/udc/snps_udc_core.c
index 3fcded31405a..1102077facdc 100644
--- a/drivers/usb/gadget/udc/snps_udc_core.c
+++ b/drivers/usb/gadget/udc/snps_udc_core.c
@@ -2,7 +2,7 @@
 /*
  * amd5536.c -- AMD 5536 UDC high/full speed USB device controller
  *
- * Copyright (C) 2005-2007 AMD (http://www.amd.com)
+ * Copyright (C) 2005-2007 AMD (https://www.amd.com)
  * Author: Thomas Dahlmann
  */
 
-- 
2.27.0

