Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3407C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 10:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769542080D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 10:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbgAMKwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 05:52:03 -0500
Received: from laurent.telenet-ops.be ([195.130.137.89]:54022 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgAMKwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 05:52:02 -0500
Received: from ramsan ([84.195.182.253])
        by laurent.telenet-ops.be with bizsmtp
        id pmry210015USYZQ01mryH4; Mon, 13 Jan 2020 11:52:01 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iqxK9-0000up-Tz; Mon, 13 Jan 2020 11:51:57 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iqxK9-0006lD-R3; Mon, 13 Jan 2020 11:51:57 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org, linux-alpha@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] ubifs: Fix ino_t format warnings in orphan_delete()
Date:   Mon, 13 Jan 2020 11:51:56 +0100
Message-Id: <20200113105156.25945-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On alpha and s390x:

    fs/ubifs/debug.h:158:11: warning: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 4 has type ‘ino_t {aka unsigned int}’ [-Wformat=]
    ...
    fs/ubifs/orphan.c:132:3: note: in expansion of macro ‘dbg_gen’
       dbg_gen("deleted twice ino %lu", orph->inum);
    ...
    fs/ubifs/orphan.c:140:3: note: in expansion of macro ‘dbg_gen’
       dbg_gen("delete later ino %lu", orph->inum);

__kernel_ino_t is "unsigned long" on most architectures, but not on
alpha and s390x, where it is "unsigned int".  Hence when printing an
ino_t, it should always be cast to "unsigned long" first.

Fix this by re-adding the recently removed casts.

Fixes: 8009ce956c3d2802 ("ubifs: Don't leak orphans on memory during commit")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 fs/ubifs/orphan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ubifs/orphan.c b/fs/ubifs/orphan.c
index 54d6db61106ffc45..edf43ddd7dce4779 100644
--- a/fs/ubifs/orphan.c
+++ b/fs/ubifs/orphan.c
@@ -129,7 +129,7 @@ static void __orphan_drop(struct ubifs_info *c, struct ubifs_orphan *o)
 static void orphan_delete(struct ubifs_info *c, struct ubifs_orphan *orph)
 {
 	if (orph->del) {
-		dbg_gen("deleted twice ino %lu", orph->inum);
+		dbg_gen("deleted twice ino %lu", (unsigned long)orph->inum);
 		return;
 	}
 
@@ -137,7 +137,7 @@ static void orphan_delete(struct ubifs_info *c, struct ubifs_orphan *orph)
 		orph->del = 1;
 		orph->dnext = c->orph_dnext;
 		c->orph_dnext = orph;
-		dbg_gen("delete later ino %lu", orph->inum);
+		dbg_gen("delete later ino %lu", (unsigned long)orph->inum);
 		return;
 	}
 
-- 
2.17.1

