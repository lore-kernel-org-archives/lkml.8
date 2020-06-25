Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37817C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 20:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0676120775
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 20:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="W8YyaGEn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407000AbgFYUCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 16:02:30 -0400
Received: from www.zeus03.de ([194.117.254.33]:53982 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406569AbgFYUC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 16:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=jALQbljjSLoISD1TnLmy+hkiu//
        w2InWWVGaPCwpDqk=; b=W8YyaGEnt6/08+zPKKLTJR16U7i28N0haXM811+f/yp
        aYIDj/mh5pJ1arqIr03TDo3fW0qIe3RknoVcGGlL6L++iTq/qGMee/Jk9c9fGi5I
        IzC7Lw6u0y/ph5YyAVKVkOEo2WMnwq/ln+2W1O8GdHQEPiGIqysMc4C+qKVS+/S0
        =
Received: (qmail 958860 invoked from network); 25 Jun 2020 22:02:26 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 Jun 2020 22:02:26 +0200
X-UD-Smtp-Session: l3s3148p1@fn9VEu6oJr0gAwDPXwsPAAlopUNgwKHN
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] firmware: improve description of firmware_request_nowarn
Date:   Thu, 25 Jun 2020 22:02:21 +0200
Message-Id: <20200625200221.18219-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The doubled 'however' is confusing. Simplify the comment a little and
reformat the paragraph.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/base/firmware_loader/main.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index ca871b13524e..8c7d9b432cb1 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -838,13 +838,14 @@ EXPORT_SYMBOL(request_firmware);
  * @name: name of firmware file
  * @device: device for which firmware is being loaded
  *
- * This function is similar in behaviour to request_firmware(), except
- * it doesn't produce warning messages when the file is not found.
- * The sysfs fallback mechanism is enabled if direct filesystem lookup fails,
- * however, however failures to find the firmware file with it are still
- * suppressed. It is therefore up to the driver to check for the return value
- * of this call and to decide when to inform the users of errors.
+ * This function is similar in behaviour to request_firmware(), except it
+ * doesn't produce warning messages when the file is not found. The sysfs
+ * fallback mechanism is enabled if direct filesystem lookup fails. However,
+ * failures to find the firmware file with it are still suppressed. It is
+ * therefore up to the driver to check for the return value of this call and to
+ * decide when to inform the users of errors.
  **/
+
 int firmware_request_nowarn(const struct firmware **firmware, const char *name,
 			    struct device *device)
 {
-- 
2.20.1

