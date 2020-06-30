Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB21BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78732206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731512AbgF3IaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 04:30:15 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:44315 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbgF3IaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 04:30:14 -0400
Received: from localhost.localdomain (unknown [176.88.144.104])
        (Authenticated sender: cengiz@kernel.wtf)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id DCB5D24001E;
        Tue, 30 Jun 2020 08:30:02 +0000 (UTC)
From:   Cengiz Can <cengiz@kernel.wtf>
To:     sumit.garg@linaro.org
Cc:     andriy.shevchenko@linux.intel.com, cengiz@kernel.wtf,
        daniel.thompson@linaro.org, dianders@chromium.org,
        jason.wessel@windriver.com, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, pmladek@suse.com
Subject: [PATCH v3] kdb: remove unnecessary null check of dbg_io_ops
Date:   Tue, 30 Jun 2020 11:29:23 +0300
Message-Id: <20200630082922.28672-1-cengiz@kernel.wtf>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <CAFA6WYNpCG2xPERd=NeKf+EthbX+1R4iieOL52kWnBp8y_+Nbw@mail.gmail.com>
References: <CAFA6WYNpCG2xPERd=NeKf+EthbX+1R4iieOL52kWnBp8y_+Nbw@mail.gmail.com>
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
 kernel/debug/kdb/kdb_io.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 683a799618ad..81783ecaec58 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -545,18 +545,18 @@ static int kdb_search_string(char *searched, char *searchfor)
 static void kdb_msg_write(const char *msg, int msg_len)
 {
 	struct console *c;
+	const char *cp;
+	int len;
 
 	if (msg_len == 0)
 		return;
 
-	if (dbg_io_ops) {
-		const char *cp = msg;
-		int len = msg_len;
+	cp = msg;
+	len = msg_len;
 
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

