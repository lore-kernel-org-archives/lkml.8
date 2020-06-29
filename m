Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2304C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D603E206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389412AbgF2Uu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:50:58 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:42333 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387763AbgF2Uuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 16:50:50 -0400
Received: from localhost.localdomain (unknown [176.88.144.104])
        (Authenticated sender: cengiz@kernel.wtf)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 8516C24000E;
        Mon, 29 Jun 2020 20:50:45 +0000 (UTC)
From:   Cengiz Can <cengiz@kernel.wtf>
To:     daniel.thompson@linaro.org
Cc:     andriy.shevchenko@linux.intel.com, cengiz@kernel.wtf,
        dianders@chromium.org, jason.wessel@windriver.com,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        pmladek@suse.com, sumit.garg@linaro.org
Subject: [PATCH v2] kdb: remove unnecessary null check of dbg_io_ops
Date:   Mon, 29 Jun 2020 23:50:13 +0300
Message-Id: <20200629205012.3263-1-cengiz@kernel.wtf>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629153756.cxg74nec3repa4lu@holly.lan>
References: <20200629153756.cxg74nec3repa4lu@holly.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`kdb_msg_write` operates on a global `struct kgdb_io *` called
`dbg_io_ops`.

It's initialized in `debug_core.c` and checked throughout the debug
flow.

There's a null check in `kdb_msg_write` which triggers static analyzers
and gives the (almost entirely wrong) impression that it can be null.

Coverity scanner caught this as CID 1465042.

I have removed the unnecessary null check and eliminated false-positive
forward null dereference warning.

Signed-off-by: Cengiz Can <cengiz@kernel.wtf>
---
 kernel/debug/kdb/kdb_io.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 683a799618ad..4ac59a4fbeec 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -549,14 +549,12 @@ static void kdb_msg_write(const char *msg, int msg_len)
 	if (msg_len == 0)
 		return;
 
-	if (dbg_io_ops) {
-		const char *cp = msg;
-		int len = msg_len;
+	const char *cp = msg;
+	int len = msg_len;
 
-		while (len--) {
-			dbg_io_ops->write_char(*cp);
-			cp++;
-		}
+	while (len--) {
+		dbg_io_ops->write_char(*cp);
+		cp++;
 	}
 
 	for_each_console(c) {
-- 
2.27.0

