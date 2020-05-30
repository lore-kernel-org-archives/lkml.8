Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53090C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 23:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3784E2068D
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 23:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbgE3XVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 19:21:00 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:51226 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729538AbgE3XUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 19:20:35 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 3748E27FAD; Sat, 30 May 2020 19:20:33 -0400 (EDT)
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Joshua Thompson <funaho@jurai.org>,
        linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Message-Id: <25edf4450abd20e002b166ba3a11189dc1efa906.1590880623.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1590880623.git.fthain@telegraphics.com.au>
References: <cover.1590880623.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 5/8] macintosh/adb-iop: Resolve static checker warnings
Date:   Sun, 31 May 2020 09:17:03 +1000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/macintosh/adb-iop.c:215:28: warning: Using plain integer as NULL pointer
drivers/macintosh/adb-iop.c:170:5: warning: symbol 'adb_iop_probe' was not declared. Should it be static?
drivers/macintosh/adb-iop.c:177:5: warning: symbol 'adb_iop_init' was not declared. Should it be static?
drivers/macintosh/adb-iop.c:184:5: warning: symbol 'adb_iop_send_request' was not declared. Should it be static?
drivers/macintosh/adb-iop.c:230:5: warning: symbol 'adb_iop_autopoll' was not declared. Should it be static?
drivers/macintosh/adb-iop.c:236:6: warning: symbol 'adb_iop_poll' was not declared. Should it be static?
drivers/macintosh/adb-iop.c:241:5: warning: symbol 'adb_iop_reset_bus' was not declared. Should it be static?

Cc: Joshua Thompson <funaho@jurai.org>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/macintosh/adb-iop.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/macintosh/adb-iop.c b/drivers/macintosh/adb-iop.c
index 7ecc41bc7358..a2b28e09f2ce 100644
--- a/drivers/macintosh/adb-iop.c
+++ b/drivers/macintosh/adb-iop.c
@@ -166,21 +166,21 @@ static void adb_iop_start(void)
 			 adb_iop_complete);
 }
 
-int adb_iop_probe(void)
+static int adb_iop_probe(void)
 {
 	if (!iop_ism_present)
 		return -ENODEV;
 	return 0;
 }
 
-int adb_iop_init(void)
+static int adb_iop_init(void)
 {
 	pr_info("adb: IOP ISM driver v0.4 for Unified ADB\n");
 	iop_listen(ADB_IOP, ADB_CHAN, adb_iop_listen, "ADB");
 	return 0;
 }
 
-int adb_iop_send_request(struct adb_request *req, int sync)
+static int adb_iop_send_request(struct adb_request *req, int sync)
 {
 	int err;
 
@@ -211,7 +211,7 @@ static int adb_iop_write(struct adb_request *req)
 
 	local_irq_save(flags);
 
-	if (current_req != 0) {
+	if (current_req) {
 		last_req->next = req;
 		last_req = req;
 	} else {
@@ -227,18 +227,18 @@ static int adb_iop_write(struct adb_request *req)
 	return 0;
 }
 
-int adb_iop_autopoll(int devs)
+static int adb_iop_autopoll(int devs)
 {
 	/* TODO: how do we enable/disable autopoll? */
 	return 0;
 }
 
-void adb_iop_poll(void)
+static void adb_iop_poll(void)
 {
 	iop_ism_irq_poll(ADB_IOP);
 }
 
-int adb_iop_reset_bus(void)
+static int adb_iop_reset_bus(void)
 {
 	struct adb_request req;
 
-- 
2.26.2

