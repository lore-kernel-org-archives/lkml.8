Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177EDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 20:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB4E82088E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 20:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgGBU2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 16:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgGBU2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 16:28:47 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D518CC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 13:28:46 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 40B322A6103
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org
Cc:     mingo@redhat.com, dvhart@infradead.org, kernel@collabora.com,
        krisman@collabora.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [RESEND PATCH 4/4] futex: Consistently use fshared as boolean
Date:   Thu,  2 Jul 2020 17:28:43 -0300
Message-Id: <20200702202843.520764-5-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702202843.520764-1-andrealmeid@collabora.com>
References: <20200702202843.520764-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since fshared is meant to true/false values, declare it as bool. If the
code ever reaches the code beneath again label, we are sure that the
futex is shared, so we can use the true value instead of the variable.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 kernel/futex.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 697835ad5bff..d56c9310d734 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -458,7 +458,7 @@ static u64 get_inode_sequence_number(struct inode *inode)
 /**
  * get_futex_key() - Get parameters which are the keys for a futex
  * @uaddr:	virtual address of the futex
- * @fshared:	0 for a PROCESS_PRIVATE futex, 1 for PROCESS_SHARED
+ * @fshared:	false for a PROCESS_PRIVATE futex, true for PROCESS_SHARED
  * @key:	address where result is stored.
  * @rw:		mapping needs to be read/write (values: FUTEX_READ,
  *              FUTEX_WRITE)
@@ -483,7 +483,8 @@ static u64 get_inode_sequence_number(struct inode *inode)
  * lock_page() might sleep, the caller should not hold a spinlock.
  */
 static int
-get_futex_key(u32 __user *uaddr, int fshared, union futex_key *key, enum futex_access rw)
+get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
+	      enum futex_access rw)
 {
 	unsigned long address = (unsigned long)uaddr;
 	struct mm_struct *mm = current->mm;
@@ -520,7 +521,7 @@ get_futex_key(u32 __user *uaddr, int fshared, union futex_key *key, enum futex_a
 
 again:
 	/* Ignore any VERIFY_READ mapping (futex common case) */
-	if (unlikely(should_fail_futex(fshared)))
+	if (unlikely(should_fail_futex(true)))
 		return -EFAULT;
 
 	err = get_user_pages_fast(address, 1, FOLL_WRITE, &page);
@@ -608,7 +609,7 @@ get_futex_key(u32 __user *uaddr, int fshared, union futex_key *key, enum futex_a
 		 * A RO anonymous page will never change and thus doesn't make
 		 * sense for futex operations.
 		 */
-		if (unlikely(should_fail_futex(fshared)) || ro) {
+		if (unlikely(should_fail_futex(true)) || ro) {
 			err = -EFAULT;
 			goto out;
 		}
-- 
2.27.0

