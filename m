Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B246C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55C0920704
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgGQSmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 14:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728159AbgGQSmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:42:49 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D423C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 11:42:49 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 5483DBC06E;
        Fri, 17 Jul 2020 18:42:46 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     geert@linux-m68k.org, funaho@jurai.org, grandmaster@al2klimov.de,
        fthain@telegraphics.com.au, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] m68k: Replace HTTP links with HTTPS ones
Date:   Fri, 17 Jul 2020 20:42:40 +0200
Message-Id: <20200717184240.79799-1-grandmaster@al2klimov.de>
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

 If there are any URLs to be removed completely
 or at least not (just) HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.


 arch/m68k/include/asm/mac_via.h | 4 ++--
 arch/m68k/mac/config.c          | 2 +-
 arch/m68k/mac/macboing.c        | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/m68k/include/asm/mac_via.h b/arch/m68k/include/asm/mac_via.h
index 1149251ea58d..0cbab71f2592 100644
--- a/arch/m68k/include/asm/mac_via.h
+++ b/arch/m68k/include/asm/mac_via.h
@@ -30,7 +30,7 @@
  *      http://www.rs6000.ibm.com/resource/technology/chrpio/via5.mak.html
  *      ftp://ftp.austin.ibm.com/pub/technology/spec/chrp/inwork/CHRP_IORef_1.0.pdf
  *
- * also, http://developer.apple.com/technotes/hw/hw_09.html claims the
+ * also, https://developer.apple.com/technotes/hw/hw_09.html claims the
  * following changes for IIfx:
  * VIA1A_vSccWrReq not available and that VIA1A_vSync has moved to an IOP.
  * Also, "All of the functionality of VIA2 has been moved to other chips".
@@ -178,7 +178,7 @@
 				 * on others, 0=disable processor's instruction
 				 * and data caches. */
 
-/* Apple sez: http://developer.apple.com/technotes/ov/ov_04.html
+/* Apple sez: https://developer.apple.com/technotes/ov/ov_04.html
  * Another example of a valid function that has no ROM support is the use
  * of the alternate video page for page-flipping animation. Since there
  * is no ROM call to flip pages, it is necessary to go play with the
diff --git a/arch/m68k/mac/config.c b/arch/m68k/mac/config.c
index 5c9f3a2d6538..6f2eb1dcfc0c 100644
--- a/arch/m68k/mac/config.c
+++ b/arch/m68k/mac/config.c
@@ -240,7 +240,7 @@ static struct mac_model mac_data_table[] = {
 	 * Weirdified Mac II hardware - all subtly different. Gee thanks
 	 * Apple. All these boxes seem to have VIA2 in a different place to
 	 * the Mac II (+1A000 rather than +4000)
-	 * CSA: see http://developer.apple.com/technotes/hw/hw_09.html
+	 * CSA: see https://developer.apple.com/technotes/hw/hw_09.html
 	 */
 
 	{
diff --git a/arch/m68k/mac/macboing.c b/arch/m68k/mac/macboing.c
index 388780797f7d..a904146dc4e6 100644
--- a/arch/m68k/mac/macboing.c
+++ b/arch/m68k/mac/macboing.c
@@ -116,7 +116,7 @@ static void mac_init_asc( void )
 			 *   support 16-bit stereo output, but only mono input."
 			 *
 			 *   Technical Information Library (TIL) article number 16405. 
-			 *   http://support.apple.com/kb/TA32601 
+			 *   https://support.apple.com/kb/TA32601 
 			 *
 			 * --David Kilzer
 			 */
-- 
2.27.0

