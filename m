Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29694C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 11:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAD94206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 11:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="A3Z9s3IC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgD1Lsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 07:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgD1Lsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 07:48:37 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B83BC03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 04:48:37 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49BKfV3T5mz9sSX; Tue, 28 Apr 2020 21:48:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1588074514;
        bh=2Xt4drwzFdVoeLpaSdh55/L13zgR9vEVW6/4XuF+vMI=;
        h=From:To:Cc:Subject:Date:From;
        b=A3Z9s3IC6Mm4hUr+WF1T2mo5kr9Rc6qWQqzMOfky6XVKvjc5n+VicZ0JE6amXUqhj
         GtfIhPLiu/Hf4wFewBbZ/GxKapOdK0EuRm1dpPlQh2byI3Nb1HqcLfS7DViDpm2+mr
         GvrwGa9FgcGYZqCvT98hg/fTClJvzu7gZzoDd7wOdDZBhsPpysyIU0slQ+QyALRcla
         lwkU+EgZw80sDHQDrVMe2ZiuFKH+2HKMAdBMYRgFxCbYTHUY8GHBSjQl7QS+Q74g9s
         rDw/nDY/vvDgZrT+mEzVvKAOuWknPcf1Qgt4rC/x0W1Y1RegZ0kTGoabxveskhlIyU
         1mE+X93WnZZbg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     linuxppc-dev@ozlabs.org
Cc:     hch@lst.de, jk@ozlabs.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/spufs: Add rcu_read_lock() around fcheck()
Date:   Tue, 28 Apr 2020 21:48:11 +1000
Message-Id: <20200428114811.68436-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the spu coredump code triggers an RCU warning:

  =============================
  WARNING: suspicious RCU usage
  5.7.0-rc3-01755-g7cd49f0b7ec7 #1 Not tainted
  -----------------------------
  include/linux/fdtable.h:95 suspicious rcu_dereference_check() usage!

  other info that might help us debug this:

  rcu_scheduler_active = 2, debug_locks = 1
  1 lock held by spu-coredump/1343:
   #0: c0000007fa22f430 (sb_writers#2){.+.+}-{0:0}, at: .do_coredump+0x1010/0x13c8

  stack backtrace:
  CPU: 0 PID: 1343 Comm: spu-coredump Not tainted 5.7.0-rc3-01755-g7cd49f0b7ec7 #1
  Call Trace:
    .dump_stack+0xec/0x15c (unreliable)
    .lockdep_rcu_suspicious+0x120/0x144
    .coredump_next_context+0x148/0x158
    .spufs_coredump_extra_notes_size+0x54/0x190
    .elf_coredump_extra_notes_size+0x34/0x50
    .elf_core_dump+0xe48/0x19d0
    .do_coredump+0xe50/0x13c8
    .get_signal+0x864/0xd88
    .do_notify_resume+0x158/0x3c8
    .interrupt_exit_user_prepare+0x19c/0x208
    interrupt_return+0x14/0x1c0

This comes from fcheck_files() via fcheck().

It's pretty clearly documented that fcheck() must be wrapped with
rcu_read_lock(), so fix it.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/cell/spufs/coredump.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/spufs/coredump.c b/arch/powerpc/platforms/cell/spufs/coredump.c
index 8b3296b62f65..0fc52cbaa552 100644
--- a/arch/powerpc/platforms/cell/spufs/coredump.c
+++ b/arch/powerpc/platforms/cell/spufs/coredump.c
@@ -82,13 +82,19 @@ static int match_context(const void *v, struct file *file, unsigned fd)
  */
 static struct spu_context *coredump_next_context(int *fd)
 {
+	struct spu_context *ctx;
 	struct file *file;
 	int n = iterate_fd(current->files, *fd, match_context, NULL);
 	if (!n)
 		return NULL;
 	*fd = n - 1;
+
+	rcu_read_lock();
 	file = fcheck(*fd);
-	return SPUFS_I(file_inode(file))->i_ctx;
+	ctx = SPUFS_I(file_inode(file))->i_ctx;
+	rcu_read_unlock();
+
+	return ctx;
 }
 
 int spufs_coredump_extra_notes_size(void)
-- 
2.25.1

