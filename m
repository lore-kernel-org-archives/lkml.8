Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4B8C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCDFC20675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATleuhRi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbgEEPHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729261AbgEEPHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:07:21 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02395C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 08:07:19 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a5so1272002pjh.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 08:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NNSggG8Wl6Z2agG/S9qpStjU4wnFQtE7sVRqgF3O2SA=;
        b=ATleuhRiRQfJoQB7YZpPeMfKei9oHPfil5eo65s1qErJeraVVqGckXZ7t9jm669HaR
         CaLgi0kxys53GjsORZU48HrCqHEdzpusMbIGjkfaWAd6g4ktCmapOLVDYNxvVCzSnV/P
         AyMaJf9C+4xiYLzIfF6MnOttq3ntTEJZ4bC+OjUQFiZbRju7IGYQN+fx119mohvADQq3
         SpiAE3zRv67KHjqtXa3ljXS8MCuAj5SqD1t2gLrJ2KiP2awFeIlgjQdMAtSIjitgwmaj
         jqq7h0FxOihAd+3vQSicrxs9ZRs6/8kYZqdzct8DnK0up2m4HHabRm6u/gK3NJcE+kaC
         +qvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NNSggG8Wl6Z2agG/S9qpStjU4wnFQtE7sVRqgF3O2SA=;
        b=LueMESMZW5kgHsdSMNJW9r0tHBPDVtSUqxInQBFT6NOgYx4Ue/LVnZDXn1r7dMJpps
         uee5QWEuhaudXQ2WH46Xb7t6kLjZZQwjUTf7FpdTvldtjyuULsdr82CF8lg1ouzqUa0k
         SVCijhIDwUt/gTUXPQcJUQbc/FtIKKEY/nQbnRs2EPHrj6Gl96irNme43vMVMZt7WbRF
         VRWGPgZluRxwnbOfI7UXfH+8nxcz2J77oUw529xAodXe3VrrhZpfF4IAZLwX4PKKLk3k
         VDil/fn2m8lkHE/Vkfej/oUegGLhzsZHVdrlD1963k0HDo6WwynGP3jTfChb8hMIijGj
         18Vw==
X-Gm-Message-State: AGi0PuYKUrb3VsJLx+teksG6F+07y5LJHk8jKKbdsPkYypqGJrGpAQCF
        DUUsjsVAC6Dr+I54CxWTjck=
X-Google-Smtp-Source: APiQypKKaFBiGAzBA+lIxZist3gssDZ3s3mi6ZC/ZC39EDj0QRPYGPHgze6Vuwa3Axx5S8BdVKhZOQ==
X-Received: by 2002:a17:902:eb12:: with SMTP id l18mr3326160plb.269.1588691239346;
        Tue, 05 May 2020 08:07:19 -0700 (PDT)
Received: from localhost.localdomain ([120.244.110.63])
        by smtp.gmail.com with ESMTPSA id c2sm2229997pfp.118.2020.05.05.08.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 08:07:18 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     shaggy@kernel.org, Markus.Elfring@web.de
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH v2] fs: jfs: fix possible data races in txExit()
Date:   Tue,  5 May 2020 23:06:50 +0800
Message-Id: <20200505150650.9156-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions txEnd() and txExit() can be concurrently executed in the
following call contexts:

Thread1: 
  jfs_lazycommit()
    txLazyCommit()
      txEnd()
Thread2:
  exit_jfs_fs()
    txExit()

In txEnd():
  struct tblock *tblk = tid_to_tblock(tid);
  // #define tid_to_tblock(tid) (&TxBlock[tid])

In txExit():
  vfree(TxBlock);
  TxBlock = NULL;

Data races can occur for the global variable TxBlock, and they 
can cause use-after-free bugs and null-pointer dereferences.
These data races were found by our concurrency fuzzer.

Thus call txExit() after the filesystem stops the threads 
that run jfs_lazycommit().

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
v2:
* Change the description.
  Thank Markus Elfring for good advice.

 fs/jfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index b2dc4d1f9dcc..8c80397df336 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -1027,13 +1027,13 @@ static void __exit exit_jfs_fs(void)
 
 	jfs_info("exit_jfs_fs called");
 
-	txExit();
 	metapage_exit();
 
 	kthread_stop(jfsIOthread);
 	for (i = 0; i < commit_threads; i++)
 		kthread_stop(jfsCommitThread[i]);
 	kthread_stop(jfsSyncThread);
+	txExit();
 #ifdef PROC_FS_JFS
 	jfs_proc_clean();
 #endif
-- 
2.17.1

