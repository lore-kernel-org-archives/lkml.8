Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24213C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 18:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CC342065D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 18:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgGMSqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 14:46:17 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:47142 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbgGMSqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 14:46:17 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 631BABC070;
        Mon, 13 Jul 2020 18:46:12 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     dvhart@infradead.org, andy@infradead.org,
        mika.westerberg@linux.intel.com, lee.jones@linaro.org,
        dmitry.torokhov@gmail.com, mchehab+huawei@kernel.org,
        ayman.bagabas@gmail.com, masahiroy@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] platform/x86: Replace HTTP links with HTTPS ones
Date:   Mon, 13 Jul 2020 20:46:06 +0200
Message-Id: <20200713184606.37033-1-grandmaster@al2klimov.de>
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


 drivers/platform/x86/Kconfig      |  2 +-
 drivers/platform/x86/apple-gmux.c | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 0581a54cf562..1d96e07b2a02 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -140,7 +140,7 @@ config ACERHDF
 	  in the same node directory will tell you if it is "acerhdf".
 
 	  For more information about this driver see
-	  <http://piie.net/files/acerhdf_README.txt>
+	  <https://piie.net/files/acerhdf_README.txt>
 
 	  If you have an Acer Aspire One netbook, say Y or M
 	  here.
diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index 7e3083deb1c5..9aae45a45200 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -277,8 +277,8 @@ static bool gmux_is_indexed(struct apple_gmux_data *gmux_data)
  * MBP5 2008/09 uses a `TI LP8543`_ backlight driver. All newer models
  * use a `TI LP8545`_.
  *
- * .. _TI LP8543: http://www.ti.com/lit/ds/symlink/lp8543.pdf
- * .. _TI LP8545: http://www.ti.com/lit/ds/symlink/lp8545.pdf
+ * .. _TI LP8543: https://www.ti.com/lit/ds/symlink/lp8543.pdf
+ * .. _TI LP8545: https://www.ti.com/lit/ds/symlink/lp8545.pdf
  */
 
 static int gmux_get_brightness(struct backlight_device *bd)
@@ -373,14 +373,14 @@ static const struct backlight_ops gmux_bl_ops = {
  * switch the panel and the external DP connector and allocates a framebuffer
  * for the selected GPU.
  *
- * .. _US 8,687,007 B2: http://pimg-fpiw.uspto.gov/fdd/07/870/086/0.pdf
- * .. _NXP CBTL06141:   http://www.nxp.com/documents/data_sheet/CBTL06141.pdf
- * .. _NXP CBTL06142:   http://www.nxp.com/documents/data_sheet/CBTL06141.pdf
- * .. _TI HD3SS212:     http://www.ti.com/lit/ds/symlink/hd3ss212.pdf
+ * .. _US 8,687,007 B2: https://pimg-fpiw.uspto.gov/fdd/07/870/086/0.pdf
+ * .. _NXP CBTL06141:   https://www.nxp.com/documents/data_sheet/CBTL06141.pdf
+ * .. _NXP CBTL06142:   https://www.nxp.com/documents/data_sheet/CBTL06141.pdf
+ * .. _TI HD3SS212:     https://www.ti.com/lit/ds/symlink/hd3ss212.pdf
  * .. _Pericom PI3VDP12412: https://www.pericom.com/assets/Datasheets/PI3VDP12412.pdf
- * .. _TI SN74LV4066A:  http://www.ti.com/lit/ds/symlink/sn74lv4066a.pdf
+ * .. _TI SN74LV4066A:  https://www.ti.com/lit/ds/symlink/sn74lv4066a.pdf
  * .. _NXP CBTL03062:   http://pdf.datasheetarchive.com/indexerfiles/Datasheets-SW16/DSASW00308511.pdf
- * .. _TI TS3DS10224:   http://www.ti.com/lit/ds/symlink/ts3ds10224.pdf
+ * .. _TI TS3DS10224:   https://www.ti.com/lit/ds/symlink/ts3ds10224.pdf
  */
 
 static void gmux_read_switch_state(struct apple_gmux_data *gmux_data)
-- 
2.27.0

