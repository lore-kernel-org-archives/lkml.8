Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F64AC433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 18:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F8C720B1F
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 18:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgGSSZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 14:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgGSSZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 14:25:49 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFC1C0619D2;
        Sun, 19 Jul 2020 11:25:49 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 4A794BC073;
        Sun, 19 Jul 2020 18:25:46 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     linux@roeck-us.net, jdelvare@suse.com, corbet@lwn.net,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH for v5.9] hwmon: (jc42) Replace HTTP links with HTTPS ones
Date:   Sun, 19 Jul 2020 20:25:39 +0200
Message-Id: <20200719182539.60944-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
X-Spam: Yes
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

 If there are any URLs to be removed completely
 or at least not (just) HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.

 Sorry again to all maintainers who complained about subject lines.
 Now I realized that you want an actually perfect prefixes,
 not just subsystem ones.
 I tried my best...
 And yes, *I could* (at least half-)automate it.
 Impossible is nothing! :)


 Documentation/hwmon/jc42.rst | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/hwmon/jc42.rst b/Documentation/hwmon/jc42.rst
index 5b14b49bb6f7..19d10512f6c0 100644
--- a/Documentation/hwmon/jc42.rst
+++ b/Documentation/hwmon/jc42.rst
@@ -7,7 +7,7 @@ Supported chips:
 
     Datasheets:
 
-	http://www.analog.com/static/imported-files/data_sheets/ADT7408.pdf
+	https://www.analog.com/static/imported-files/data_sheets/ADT7408.pdf
 
   * Atmel AT30TS00, AT30TS002A/B, AT30TSE004A
 
@@ -39,37 +39,37 @@ Supported chips:
 
     Datasheets:
 
-	http://ww1.microchip.com/downloads/en/DeviceDoc/22203C.pdf
+	https://ww1.microchip.com/downloads/en/DeviceDoc/22203C.pdf
 
-	http://ww1.microchip.com/downloads/en/DeviceDoc/21977b.pdf
+	https://ww1.microchip.com/downloads/en/DeviceDoc/21977b.pdf
 
-	http://ww1.microchip.com/downloads/en/DeviceDoc/25095A.pdf
+	https://ww1.microchip.com/downloads/en/DeviceDoc/25095A.pdf
 
-	http://ww1.microchip.com/downloads/en/DeviceDoc/21996a.pdf
+	https://ww1.microchip.com/downloads/en/DeviceDoc/21996a.pdf
 
-	http://ww1.microchip.com/downloads/en/DeviceDoc/22153c.pdf
+	https://ww1.microchip.com/downloads/en/DeviceDoc/22153c.pdf
 
-	http://ww1.microchip.com/downloads/en/DeviceDoc/22327A.pdf
+	https://ww1.microchip.com/downloads/en/DeviceDoc/22327A.pdf
 
   * NXP Semiconductors SE97, SE97B, SE98, SE98A
 
     Datasheets:
 
-	http://www.nxp.com/documents/data_sheet/SE97.pdf
+	https://www.nxp.com/documents/data_sheet/SE97.pdf
 
-	http://www.nxp.com/documents/data_sheet/SE97B.pdf
+	https://www.nxp.com/documents/data_sheet/SE97B.pdf
 
-	http://www.nxp.com/documents/data_sheet/SE98.pdf
+	https://www.nxp.com/documents/data_sheet/SE98.pdf
 
-	http://www.nxp.com/documents/data_sheet/SE98A.pdf
+	https://www.nxp.com/documents/data_sheet/SE98A.pdf
 
   * ON Semiconductor CAT34TS02, CAT6095
 
     Datasheet:
 
-	http://www.onsemi.com/pub_link/Collateral/CAT34TS02-D.PDF
+	https://www.onsemi.com/pub_link/Collateral/CAT34TS02-D.PDF
 
-	http://www.onsemi.com/pub/Collateral/CAT6095-D.PDF
+	https://www.onsemi.com/pub/Collateral/CAT6095-D.PDF
 
   * ST Microelectronics STTS424, STTS424E02, STTS2002, STTS2004, STTS3000
 
-- 
2.27.0

