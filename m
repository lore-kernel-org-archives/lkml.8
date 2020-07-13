Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF7FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 19:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C03E520738
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 19:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgGMTGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 15:06:39 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:53544 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbgGMTGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 15:06:38 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 72635BC0E4;
        Mon, 13 Jul 2020 19:06:35 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     ibm-acpi@hmh.eng.br, dvhart@infradead.org, andy@infradead.org,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] platform/x86: thinkpad_acpi: Replace HTTP links with HTTPS ones
Date:   Mon, 13 Jul 2020 21:06:28 +0200
Message-Id: <20200713190629.37242-1-grandmaster@al2klimov.de>
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

 If there are any URLs to be removed completely or at least not just HTTPSified:
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


 drivers/platform/x86/thinkpad_acpi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index ff7f0a4f2475..24fc16eca550 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -7957,7 +7957,7 @@ static struct ibm_struct volume_driver_data = {
  *	does so, its initial value is meaningless (0x07).
  *
  *	For firmware bugs, refer to:
- *	http://thinkwiki.org/wiki/Embedded_Controller_Firmware#Firmware_Issues
+ *	https://thinkwiki.org/wiki/Embedded_Controller_Firmware#Firmware_Issues
  *
  * 	----
  *
@@ -7982,7 +7982,7 @@ static struct ibm_struct volume_driver_data = {
  *	mode.
  *
  *	For firmware bugs, refer to:
- *	http://thinkwiki.org/wiki/Embedded_Controller_Firmware#Firmware_Issues
+ *	https://thinkwiki.org/wiki/Embedded_Controller_Firmware#Firmware_Issues
  *
  *	----
  *
@@ -10094,7 +10094,7 @@ static int __must_check __init get_thinkpad_model_data(
 	 * X32 or newer, all Z series;  Some models must have an
 	 * up-to-date BIOS or they will not be detected.
 	 *
-	 * See http://thinkwiki.org/wiki/List_of_DMI_IDs
+	 * See https://thinkwiki.org/wiki/List_of_DMI_IDs
 	 */
 	while ((dev = dmi_find_device(DMI_DEV_TYPE_OEM_STRING, NULL, dev))) {
 		if (sscanf(dev->name,
@@ -10613,8 +10613,8 @@ MODULE_DEVICE_TABLE(acpi, ibm_htk_device_ids);
 /*
  * DMI matching for module autoloading
  *
- * See http://thinkwiki.org/wiki/List_of_DMI_IDs
- * See http://thinkwiki.org/wiki/BIOS_Upgrade_Downloads
+ * See https://thinkwiki.org/wiki/List_of_DMI_IDs
+ * See https://thinkwiki.org/wiki/BIOS_Upgrade_Downloads
  *
  * Only models listed in thinkwiki will be supported, so add yours
  * if it is not there yet.
-- 
2.27.0

