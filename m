Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306D2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 177F82068E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbgHYKzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 06:55:31 -0400
Received: from sym2.noone.org ([178.63.92.236]:60798 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728117AbgHYKzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 06:55:25 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4BbQrB1Yc2zvjc1; Tue, 25 Aug 2020 12:55:21 +0200 (CEST)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] fs: adjust dirtytime_interval_handler definition to match prototype
Date:   Tue, 25 Aug 2020 12:55:21 +0200
Message-Id: <20200825105521.4563-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 32927393dc1c ("sysctl: pass kernel pointers to ->proc_handler")
changed ctl_table.proc_handler to take a kernel pointer. Adjust the
definition of dirtytime_interval_handler to match its prototype in
linux/writeback.h which fixes the following sparse error/warning:

fs/fs-writeback.c:2189:50: warning: incorrect type in argument 3 (different address spaces)
fs/fs-writeback.c:2189:50:    expected void *
fs/fs-writeback.c:2189:50:    got void [noderef] __user *buffer
fs/fs-writeback.c:2184:5: error: symbol 'dirtytime_interval_handler' redeclared with different type (incompatible argument 3 (different address spaces)):
fs/fs-writeback.c:2184:5:    int extern [addressable] [signed] [toplevel] dirtytime_interval_handler( ... )
fs/fs-writeback.c: note: in included file:
./include/linux/writeback.h:374:5: note: previously declared as:
./include/linux/writeback.h:374:5:    int extern [addressable] [signed] [toplevel] dirtytime_interval_handler( ... )

Fixes: 32927393dc1c ("sysctl: pass kernel pointers to ->proc_handler")
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 fs/fs-writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index a605c3dddabc..7a6e6155807c 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2182,7 +2182,7 @@ static int __init start_dirtytime_writeback(void)
 __initcall(start_dirtytime_writeback);
 
 int dirtytime_interval_handler(struct ctl_table *table, int write,
-			       void __user *buffer, size_t *lenp, loff_t *ppos)
+			       void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
 
-- 
2.27.0

