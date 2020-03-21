Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F207FC4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D536D20754
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgCUPyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 11:54:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39057 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgCUPx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 11:53:58 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFgRb-0005Ua-Mz; Sat, 21 Mar 2020 16:53:51 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 416E91C22EF;
        Sat, 21 Mar 2020 16:53:51 +0100 (CET)
Date:   Sat, 21 Mar 2020 15:53:50 -0000
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] nds32: Remove mm.h from asm/uaccess.h
Cc:     kbuild test robot <lkp@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200321113241.339289758@linutronix.de>
References: <20200321113241.339289758@linutronix.de>
MIME-Version: 1.0
Message-ID: <158480603085.28353.13958347443342587650.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     43ea9d1a533a08dea4a2a9312d6aa2583313ef23
Gitweb:        https://git.kernel.org/tip/43ea9d1a533a08dea4a2a9312d6aa2583313ef23
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Sat, 21 Mar 2020 12:25:50 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 21 Mar 2020 16:00:21 +01:00

nds32: Remove mm.h from asm/uaccess.h

The defconfig compiles without linux/mm.h. With mm.h included the
include chain leands to:
|   CC      kernel/locking/percpu-rwsem.o
| In file included from include/linux/huge_mm.h:8,
|                  from include/linux/mm.h:567,
|                  from arch/nds32/include/asm/uaccess.h:,
|                  from include/linux/uaccess.h:11,
|                  from include/linux/sched/task.h:11,
|                  from include/linux/sched/signal.h:9,
|                  from include/linux/rcuwait.h:6,
|                  from include/linux/percpu-rwsem.h:8,
|                  from kernel/locking/percpu-rwsem.c:6:
| include/linux/fs.h:1422:29: error: array type has incomplete element type 'struct percpu_rw_semaphore'
|  1422 |  struct percpu_rw_semaphore rw_sem[SB_FREEZE_LEVELS];

once rcuwait.h includes linux/sched/signal.h.

Remove the linux/mm.h include.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200321113241.339289758@linutronix.de
---
 arch/nds32/include/asm/uaccess.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/nds32/include/asm/uaccess.h b/arch/nds32/include/asm/uaccess.h
index 8916ad9..3a9219f 100644
--- a/arch/nds32/include/asm/uaccess.h
+++ b/arch/nds32/include/asm/uaccess.h
@@ -11,7 +11,6 @@
 #include <asm/errno.h>
 #include <asm/memory.h>
 #include <asm/types.h>
-#include <linux/mm.h>
 
 #define __asmeq(x, y)  ".ifnc " x "," y " ; .err ; .endif\n\t"
 
