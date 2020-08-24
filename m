Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EACC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7A7D206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbgHXJya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:54:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:49518 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbgHXJy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 05:54:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 30C0FACAF;
        Mon, 24 Aug 2020 09:54:56 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        syzbot+ad1f53726c3bd11180cb@syzkaller.appspotmail.com,
        akpm@linux-foundation.org, nico@fluxnic.net
Subject: [PATCH] Revert "vc_screen: extract vcs_read_buf_header"
Date:   Mon, 24 Aug 2020 11:54:25 +0200
Message-Id: <20200824095425.4376-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit b1c32fcfadf5593ab7a63261cc8a5747c36e627e, because
Syzkaller reports a use-after-free, a write in vcs_read:

BUG: KASAN: use-after-free in vcs_read_buf drivers/tty/vt/vc_screen.c:357 [inline]
BUG: KASAN: use-after-free in vcs_read+0xaa7/0xb40 drivers/tty/vt/vc_screen.c:449
Write of size 2 at addr ffff8880a8014000 by task syz-executor.5/16936
CPU: 1 PID: 16936 Comm: syz-executor.5 Not tainted 5.9.0-rc1-next-20200820-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
...
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 vcs_read_buf drivers/tty/vt/vc_screen.c:357 [inline]
 vcs_read+0xaa7/0xb40 drivers/tty/vt/vc_screen.c:449

There are two issues with the patch:
1) vcs_read rounds the 'count' *up* to an even number. So if we read odd
   bytes from the header (3 bytes in the reproducer), the second byte of
   a (2-byte/ushort) write to temporary con_buf won't fit. It is because
   with the patch applied, we only subtract the real number read (3 bytes)
   and not the whole header (4 bytes).

2) in this scenario, we perform unaligned accesses now: there are
   2-byte/ushort writes to odd addresses. Due to the same reason as
   above.

Revert this for now, re-think and retry later.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Reported-by: syzbot+ad1f53726c3bd11180cb@syzkaller.appspotmail.com
Fixes: b1c32fcfadf5 ("vc_screen: extract vcs_read_buf_header")
Cc: akpm@linux-foundation.org
Cc: nico@fluxnic.net
---
 drivers/tty/vt/vc_screen.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 3e3a6a9a7f44..1850bacdb5b0 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -293,22 +293,6 @@ static void vcs_read_buf_noattr(const struct vc_data *vc, char *con_buf,
 	}
 }
 
-static unsigned int vcs_read_buf_header(const struct vc_data *vc, char *con_buf,
-		unsigned int pos, unsigned int count)
-{
-	count = min(HEADER_SIZE - pos, count);
-
-	/* clamp header values if they don't fit */
-	con_buf[0] = min(vc->vc_rows, 0xFFu);
-	con_buf[1] = min(vc->vc_cols, 0xFFu);
-	getconsxy(vc, con_buf + 2);
-
-	if (pos)
-		memmove(con_buf, con_buf + pos, count);
-
-	return count;
-}
-
 static unsigned int vcs_read_buf(const struct vc_data *vc, char *con_buf,
 		unsigned int pos, unsigned int count, bool viewed,
 		unsigned int *skip)
@@ -318,11 +302,22 @@ static unsigned int vcs_read_buf(const struct vc_data *vc, char *con_buf,
 	unsigned int filled = count;
 
 	if (pos < HEADER_SIZE) {
-		count -= vcs_read_buf_header(vc, con_buf, pos, count);
+		/* clamp header values if they don't fit */
+		con_buf[0] = min(vc->vc_rows, 0xFFu);
+		con_buf[1] = min(vc->vc_cols, 0xFFu);
+		getconsxy(vc, con_buf + 2);
+
+		*skip += pos;
+		count += pos;
+		if (count > CON_BUF_SIZE) {
+			count = CON_BUF_SIZE;
+			filled = count - pos;
+		}
 
+		/* Advance state pointers and move on. */
+		count -= min(HEADER_SIZE, count);
 		pos = HEADER_SIZE;
 		con_buf += HEADER_SIZE;
-
 		/* If count >= 0, then pos is even... */
 	} else if (pos & 1) {
 		/*
-- 
2.28.0

