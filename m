Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B220CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D42720C09
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730523AbgE0PsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:48:09 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44208 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgE0PsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:48:05 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id C730F2A3AB4
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org
Cc:     mingo@redhat.com, dvhart@infradead.org, kernel@collabora.com,
        krisman@collabora.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH 3/4] futex: Remove unused or redundant includes
Date:   Wed, 27 May 2020 12:47:46 -0300
Message-Id: <20200527154747.36931-4-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527154747.36931-1-andrealmeid@collabora.com>
References: <20200527154747.36931-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 82af7aca ("Removal of FUTEX_FD"), some includes related to file
operations aren't needed anymore. More investigation around the includes
showed that a lot of includes aren't required for compilation, possible
due to redundant includes. Simplify the code by removing unused
includes.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
To test this code, I compiled with different configurations (x86_64,
i386, with x32 ABI supported enabled/disabled), and ran futex selftests.
---
 kernel/futex.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index ec07de620d1e..7bc5340396aa 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -31,31 +31,12 @@
  *  "The futexes are also cursed."
  *  "But they come in a choice of three flavours!"
  */
-#include <linux/compat.h>
-#include <linux/slab.h>
-#include <linux/poll.h>
-#include <linux/fs.h>
-#include <linux/file.h>
 #include <linux/jhash.h>
-#include <linux/init.h>
-#include <linux/futex.h>
-#include <linux/mount.h>
-#include <linux/pagemap.h>
 #include <linux/syscalls.h>
-#include <linux/signal.h>
-#include <linux/export.h>
-#include <linux/magic.h>
-#include <linux/pid.h>
-#include <linux/nsproxy.h>
-#include <linux/ptrace.h>
-#include <linux/sched/rt.h>
-#include <linux/sched/wake_q.h>
-#include <linux/sched/mm.h>
 #include <linux/hugetlb.h>
 #include <linux/freezer.h>
 #include <linux/memblock.h>
 #include <linux/fault-inject.h>
-#include <linux/refcount.h>
 
 #include <asm/futex.h>
 
-- 
2.26.2

