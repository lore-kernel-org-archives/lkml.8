Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F48C433F1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4CD421D79
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731192AbgGNTHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730576AbgGNTHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:07:08 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0267C061755;
        Tue, 14 Jul 2020 12:07:07 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 7B1ACBC06E;
        Tue, 14 Jul 2020 19:07:03 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     dvhart@infradead.org, andy@infradead.org,
        mika.westerberg@linux.intel.com, mchehab+huawei@kernel.org,
        lee.jones@linaro.org, dmitry.torokhov@gmail.com,
        ayman.bagabas@gmail.com, masahiroy@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] platform/x86: acerhdf: Replace HTTP links with HTTPS ones
Date:   Tue, 14 Jul 2020 21:06:57 +0200
Message-Id: <20200714190657.47527-1-grandmaster@al2klimov.de>
In-Reply-To: <CAHp75Ve2pPGN3BtMw6x1xR5Cyv8VP=KMJMMJ9qao29ArrxPo9w@mail.gmail.com>
References: <CAHp75Ve2pPGN3BtMw6x1xR5Cyv8VP=KMJMMJ9qao29ArrxPo9w@mail.gmail.com>
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
 drivers/platform/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.27.0

