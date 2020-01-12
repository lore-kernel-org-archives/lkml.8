Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2BAC33CA2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 16:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1A22080D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 16:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733124AbgALQwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 11:52:32 -0500
Received: from laurent.telenet-ops.be ([195.130.137.89]:36680 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730145AbgALQwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 11:52:32 -0500
Received: from ramsan ([84.195.182.253])
        by laurent.telenet-ops.be with bizsmtp
        id pUsW2100Z5USYZQ01UsW5n; Sun, 12 Jan 2020 17:52:30 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iqgTW-00082F-Bh; Sun, 12 Jan 2020 17:52:30 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iqgTW-0005MS-9U; Sun, 12 Jan 2020 17:52:30 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     "Maciej W . Rozycki" <macro@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] tc: Make tc_match_device() static
Date:   Sun, 12 Jan 2020 17:52:29 +0100
Message-Id: <20200112165229.20567-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike its PCI counterpart, tc_match_device() was never used outside
the TURBOchannel bus code.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/tc/tc-driver.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tc/tc-driver.c b/drivers/tc/tc-driver.c
index 16b5bae63c749019..d45f2c1ff34145b0 100644
--- a/drivers/tc/tc-driver.c
+++ b/drivers/tc/tc-driver.c
@@ -56,8 +56,8 @@ EXPORT_SYMBOL(tc_unregister_driver);
  * system is in its list of supported devices.  Returns the matching
  * tc_device_id structure or %NULL if there is no match.
  */
-const struct tc_device_id *tc_match_device(struct tc_driver *tdrv,
-					   struct tc_dev *tdev)
+static const struct tc_device_id *tc_match_device(struct tc_driver *tdrv,
+						  struct tc_dev *tdev)
 {
 	const struct tc_device_id *id = tdrv->id_table;
 
@@ -71,7 +71,6 @@ const struct tc_device_id *tc_match_device(struct tc_driver *tdrv,
 	}
 	return NULL;
 }
-EXPORT_SYMBOL(tc_match_device);
 
 /**
  * tc_bus_match - Tell if a device structure has a matching
-- 
2.17.1

