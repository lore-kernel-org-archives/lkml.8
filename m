Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9180BC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 23:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77EC3207BC
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 23:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbgE3XUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 19:20:41 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:51202 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729521AbgE3XUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 19:20:34 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 80AD027F9A; Sat, 30 May 2020 19:20:33 -0400 (EDT)
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Joshua Thompson <funaho@jurai.org>,
        linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Message-Id: <b63d56ecb6e75f11a0bf02231f3b2db656a528a3.1590880623.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1590880623.git.fthain@telegraphics.com.au>
References: <cover.1590880623.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 3/8] macintosh/adb-iop: Adopt bus reset algorithm from
 via-macii driver
Date:   Sun, 31 May 2020 09:17:03 +1000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This algorithm is slightly shorter and avoids the surprising
adb_iop_start() call in adb_iop_poll().

Cc: Joshua Thompson <funaho@jurai.org>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/macintosh/adb-iop.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/macintosh/adb-iop.c b/drivers/macintosh/adb-iop.c
index ca3b411b0742..c3089dacf2e2 100644
--- a/drivers/macintosh/adb-iop.c
+++ b/drivers/macintosh/adb-iop.c
@@ -238,24 +238,19 @@ int adb_iop_autopoll(int devs)
 
 void adb_iop_poll(void)
 {
-	if (adb_iop_state == idle)
-		adb_iop_start();
 	iop_ism_irq_poll(ADB_IOP);
 }
 
 int adb_iop_reset_bus(void)
 {
-	struct adb_request req = {
-		.reply_expected = 0,
-		.nbytes = 2,
-		.data = { ADB_PACKET, 0 },
-	};
-
-	adb_iop_write(&req);
-	while (!req.complete) {
-		adb_iop_poll();
-		schedule();
-	}
+	struct adb_request req;
+
+	/* Command = 0, Address = ignored */
+	adb_request(&req, NULL, ADBREQ_NOSEND, 1, ADB_BUSRESET);
+	adb_iop_send_request(&req, 1);
+
+	/* Don't want any more requests during the Global Reset low time. */
+	mdelay(3);
 
 	return 0;
 }
-- 
2.26.2

