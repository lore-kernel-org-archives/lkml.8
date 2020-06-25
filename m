Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F99C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 20:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2A4F2072E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 20:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u+xRIflT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391154AbgFYUo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 16:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391125AbgFYUoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 16:44:24 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EE8C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 13:44:23 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x207so3596723pfc.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 13:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OJIWob+W3gkDD1uP1ASRGO41yjBk8/1OpCvhfpmJs8w=;
        b=u+xRIflTTe1eUnFBT4p5WF8e480mirYe7NpkH2bv8nIzTiLuJKFDeofANH1OOeic5x
         /6LK2tKveHvX+ICIbkWmq08rmtn819jD7iIKFocYGQk/nSgnIbrqYX/AbZdYHeM60SNn
         CtV1RNdwOPTuN/E8WwRhrKZRTz4WD4vkoDwu5ykRGGc8KcylpXPXSJt7Pdfdn9hj2EXN
         200SrPmEYQFRASiGasXTcWH+JhpbKs/XvE/RfLKzplaVJtYbAW22CNeSFvqXwX4VCjfA
         nJSH4Pr22jSucBL9jLDnFEupk/Y8P+6KswwaztgzAHsNJc7X1nmP+6w8E272L9/g+Dod
         0r9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OJIWob+W3gkDD1uP1ASRGO41yjBk8/1OpCvhfpmJs8w=;
        b=fjVl/4EufgJyaq6a3GMjRWER9CLmBnrVKtfY91e9Bchc7xs1/pXa8oAuJaiDVmAfvt
         hb2YBQmRZdyijnWK7lRuXBqvU/Rp/mForMO7tjGp4PvofJnfwJgAO/qACg9SuYgwHnZ1
         NWAgWNTLiHH5Q7Y6DT/766f1gL5UhndXLmus2dPVeWjf7kqGcNmkHt4LU37ZSztfNxYZ
         7XZVr5VXQRrxFrHnukXgH9QYKNU4tzPDhA+jLdEhoIG2iWYsgrOUmFxT0WA1FoQ4kLVl
         pdLva0Pj9ifl4S7/nw0zOJmt1zN7L0rEJAjYmEtQVpYw6Lz2FdRMxkE9ysJbFvR7z4YW
         c/Pg==
X-Gm-Message-State: AOAM532Mm9bsLoPcM+qLyGcLv/r6LlNbVH3o3BmbhyRSFmDGz6otbEJ4
        +s8Fa91hBT5MZ8b08/z0vwaW1Dkc
X-Google-Smtp-Source: ABdhPJzFhAn2/SSIKUbwB3Gmn1pjQeQ+zba2hlNLxfpD5Z5CUhCeaeWCTeNeW7UCKdcn1Ek5ltUcxQ==
X-Received: by 2002:a63:a13:: with SMTP id 19mr27225468pgk.100.1593117862934;
        Thu, 25 Jun 2020 13:44:22 -0700 (PDT)
Received: from localhost (g2.222-224-226.ppp.wakwak.ne.jp. [222.224.226.2])
        by smtp.gmail.com with ESMTPSA id 27sm9222139pjg.19.2020.06.25.13.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 13:44:22 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marco Elver <elver@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: [PATCH] init: Align init_task to avoid conflict with MUTEX_FLAGS
Date:   Fri, 26 Jun 2020 05:44:09 +0900
Message-Id: <20200625204410.3168791-1-shorne@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When booting on 32-bit machines (seen on OpenRISC) I saw this warning
with CONFIG_DEBUG_MUTEXES turned on.

    ------------[ cut here ]------------
    WARNING: CPU: 0 PID: 0 at kernel/locking/mutex.c:1242 __mutex_unlock_slowpath+0x328/0x3ec
    DEBUG_LOCKS_WARN_ON(__owner_task(owner) != current)
    Modules linked in:
    CPU: 0 PID: 0 Comm: swapper Not tainted 5.8.0-rc1-simple-smp-00005-g2864e2171db4-dirty #179
    Call trace:
    [<(ptrval)>] dump_stack+0x34/0x48
    [<(ptrval)>] __warn+0x104/0x158
    [<(ptrval)>] ? __mutex_unlock_slowpath+0x328/0x3ec
    [<(ptrval)>] warn_slowpath_fmt+0x7c/0x94
    [<(ptrval)>] __mutex_unlock_slowpath+0x328/0x3ec
    [<(ptrval)>] mutex_unlock+0x18/0x28
    [<(ptrval)>] __cpuhp_setup_state_cpuslocked.part.0+0x29c/0x2f4
    [<(ptrval)>] ? page_alloc_cpu_dead+0x0/0x30
    [<(ptrval)>] ? start_kernel+0x0/0x684
    [<(ptrval)>] __cpuhp_setup_state+0x4c/0x5c
    [<(ptrval)>] page_alloc_init+0x34/0x68
    [<(ptrval)>] ? start_kernel+0x1a0/0x684
    [<(ptrval)>] ? early_init_dt_scan_nodes+0x60/0x70
    irq event stamp: 0

I traced this to kernel/locking/mutex.c storing 3 bits of MUTEX_FLAGS in
the task_struct pointer (mutex.owner).  There is a comment saying that
task_structs are always aligned to L1_CACHE_BYTES.  This is not true for
the init_task.

On 64-bit machines this is not a problem because symbol addresses are
naturally aligned to 64-bits providing 3 bits for MUTEX_FLAGS.  Howerver,
for 32-bit machines the symbol address only has 2 bits available.

Fix this by setting init_task alignment to at least L1_CACHE_BYTES.

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 init/init_task.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/init/init_task.c b/init/init_task.c
index 15089d15010a..d2d2af018d0d 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -64,6 +64,8 @@ unsigned long init_shadow_call_stack[SCS_SIZE / sizeof(long)]
 struct task_struct init_task
 #ifdef CONFIG_ARCH_TASK_STRUCT_ON_STACK
 	__init_task_data
+#else
+	__aligned(L1_CACHE_BYTES)
 #endif
 = {
 #ifdef CONFIG_THREAD_INFO_IN_TASK
-- 
2.26.2

