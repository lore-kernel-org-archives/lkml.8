Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84931C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 22:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E19D20780
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 22:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="e+VUpj8L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgGBWUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 18:20:46 -0400
Received: from www.zeus03.de ([194.117.254.33]:37300 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgGBWUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 18:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=11stCWHVtl+XFCsSu8Wb6D+1uMN
        DsBQ1VAOfPwW4dNo=; b=e+VUpj8LQ0c1yoeXo1v+82f+Jx/CWZElcaHFJtNc9eU
        NgPzIcrcCiDrPmxwkmqOzTs++jjjKyHkfF/CdHRZTdavI5atImc19jNmm1qyehj3
        /dt4US9d1Rsk6CaNSrDABoJL50rHPwETznK1xUd48MP6Plaj+xuAxTMzVhiwj7II
        =
Received: (qmail 1031761 invoked from network); 3 Jul 2020 00:20:37 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Jul 2020 00:20:37 +0200
X-UD-Smtp-Session: l3s3148p1@iSxU0XyptsAgAwDPXwopAMEIVZ8qCmOC
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2] lib: update DEBUG_SHIRQ docs to match reality
Date:   Fri,  3 Jul 2020 00:20:24 +0200
Message-Id: <20200702222024.6915-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no extra interrupt when registering a shared interrupt handler
since 2011. Update the Kconfig text to make it clear and to avoid wrong
assumptions when debugging issues found by it.

Fixes: 6d83f94db95c ("genirq: Disable the SHIRQ_DEBUG call in request_threaded_irq for now")
Link: https://lore.kernel.org/linux-i2c/859e8211-2c56-8dd5-d6fb-33e4358e4128@pengutronix.de/T/#mf24d7070d7e0c8f17b6be6ceb51df94b7d7613b3
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Greg, could you pick this one up as well?

Change since v1:
* add two tags from developers bitten by the misleading text

 lib/Kconfig.debug | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 9ad9210d70a1..2bff6315224d 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -844,10 +844,10 @@ config DEBUG_SHIRQ
 	bool "Debug shared IRQ handlers"
 	depends on DEBUG_KERNEL
 	help
-	  Enable this to generate a spurious interrupt as soon as a shared
-	  interrupt handler is registered, and just before one is deregistered.
-	  Drivers ought to be able to handle interrupts coming in at those
-	  points; some don't and need to be caught.
+	  Enable this to generate a spurious interrupt just before a shared
+	  interrupt handler is deregistered (generating one when registering
+	  is currently disabled). Drivers need to handle this correctly. Some
+	  don't and need to be caught.
 
 menu "Debug Oops, Lockups and Hangs"
 
-- 
2.27.0

