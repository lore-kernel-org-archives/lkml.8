Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33A1C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 18:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4D2F20656
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 18:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgGOS56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 14:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbgGOS56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 14:57:58 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD06FC061755;
        Wed, 15 Jul 2020 11:57:57 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id C4B90BC0CB;
        Wed, 15 Jul 2020 18:57:52 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     dvhart@infradead.org, andy@infradead.org, peter@piie.net,
        mika.westerberg@linux.intel.com, lee.jones@linaro.org,
        dmitry.torokhov@gmail.com, ayman.bagabas@gmail.com,
        masahiroy@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH v2] platform/x86: acerhdf: Replace HTTP links with HTTPS ones
Date:   Wed, 15 Jul 2020 20:57:44 +0200
Message-Id: <20200715185744.52335-1-grandmaster@al2klimov.de>
In-Reply-To: <CAHp75VcZ5f0xw9RbV0OZ0DuE6JqCfkTExqO=MJ9AE0TFdCV8Xg@mail.gmail.com>
References: <CAHp75VcZ5f0xw9RbV0OZ0DuE6JqCfkTExqO=MJ9AE0TFdCV8Xg@mail.gmail.com>
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
 v2: Combined all two patches for acerhdf.

 drivers/platform/x86/Kconfig   | 2 +-
 drivers/platform/x86/acerhdf.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index 4df7609b4aa9..a7a0b2e0ceb9 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -5,7 +5,7 @@
  *           as soon as the upper/lower threshold is reached.
  *
  * (C) 2009 - Peter Kaestle     peter (a) piie.net
- *                              http://piie.net
+ *                              https://piie.net
  *     2009 Borislav Petkov	bp (a) alien8.de
  *
  * Inspired by and many thanks to:
-- 
2.27.0

