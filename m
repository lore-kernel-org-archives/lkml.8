Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3692EC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 23:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15FB42067B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 23:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbgE3XVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 19:21:11 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:51216 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729528AbgE3XUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 19:20:34 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id A111127F9B; Sat, 30 May 2020 19:20:33 -0400 (EDT)
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Joshua Thompson <funaho@jurai.org>,
        linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Message-Id: <bbe32b087c7e04d68e2425f6a2df4a414d167c32.1590880623.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1590880623.git.fthain@telegraphics.com.au>
References: <cover.1590880623.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 4/8] macintosh/adb-iop: Access current_req and adb_iop_state
 when inside lock
Date:   Sun, 31 May 2020 09:17:03 +1000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the redundant local_irq_save/restore() from adb_iop_start() because
the caller has to do it anyway. This is the pattern used in via-macii.

Cc: Joshua Thompson <funaho@jurai.org>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/macintosh/adb-iop.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/macintosh/adb-iop.c b/drivers/macintosh/adb-iop.c
index c3089dacf2e2..7ecc41bc7358 100644
--- a/drivers/macintosh/adb-iop.c
+++ b/drivers/macintosh/adb-iop.c
@@ -137,7 +137,6 @@ static void adb_iop_listen(struct iop_msg *msg)
 
 static void adb_iop_start(void)
 {
-	unsigned long flags;
 	struct adb_request *req;
 	struct adb_iopmsg amsg;
 
@@ -146,8 +145,6 @@ static void adb_iop_start(void)
 	if (!req)
 		return;
 
-	local_irq_save(flags);
-
 	/* The IOP takes MacII-style packets, so strip the initial
 	 * ADB_PACKET byte.
 	 */
@@ -161,7 +158,6 @@ static void adb_iop_start(void)
 
 	req->sent = 1;
 	adb_iop_state = sending;
-	local_irq_restore(flags);
 
 	/* Now send it. The IOP manager will call adb_iop_complete
 	 * when the message has been sent.
@@ -208,13 +204,13 @@ static int adb_iop_write(struct adb_request *req)
 		return -EINVAL;
 	}
 
-	local_irq_save(flags);
-
 	req->next = NULL;
 	req->sent = 0;
 	req->complete = 0;
 	req->reply_len = 0;
 
+	local_irq_save(flags);
+
 	if (current_req != 0) {
 		last_req->next = req;
 		last_req = req;
@@ -223,10 +219,11 @@ static int adb_iop_write(struct adb_request *req)
 		last_req = req;
 	}
 
-	local_irq_restore(flags);
-
 	if (adb_iop_state == idle)
 		adb_iop_start();
+
+	local_irq_restore(flags);
+
 	return 0;
 }
 
-- 
2.26.2

