Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40654C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 10:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E38720578
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 10:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgC1Ksp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 06:48:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55482 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgC1Ksp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 06:48:45 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jI913-0003U8-EG; Sat, 28 Mar 2020 11:48:37 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DCEF91C03A9;
        Sat, 28 Mar 2020 11:48:36 +0100 (CET)
Date:   Sat, 28 Mar 2020 10:48:36 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] m68knommu: Remove mm.h include from uaccess_no.h
Cc:     kbuild test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <87fte1qzh0.fsf@nanos.tec.linutronix.de>
References: <87fte1qzh0.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID: <158539251645.28353.4112298508631162983.tip-bot2@tip-bot2>
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

Commit-ID:     9e860351550b28901a78f122b1e2dc97f78ba369
Gitweb:        https://git.kernel.org/tip/9e860351550b28901a78f122b1e2dc97f78ba369
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 21 Mar 2020 20:22:10 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 28 Mar 2020 11:45:39 +01:00

m68knommu: Remove mm.h include from uaccess_no.h

In file included
  from include/linux/huge_mm.h:8,
  from include/linux/mm.h:567,
  from arch/m68k/include/asm/uaccess_no.h:8,
  from arch/m68k/include/asm/uaccess.h:3,
  from include/linux/uaccess.h:11,
  from include/linux/sched/task.h:11,
  from include/linux/sched/signal.h:9,
  from include/linux/rcuwait.h:6,
  from include/linux/percpu-rwsem.h:7,
  from kernel/locking/percpu-rwsem.c:6:
 include/linux/fs.h:1422:29: error: array type has incomplete element type 'struct percpu_rw_semaphore'
    1422 |  struct percpu_rw_semaphore rw_sem[SB_FREEZE_LEVELS];

Removing the include of linux/mm.h from the uaccess header solves the problem
and various build tests of nommu configurations still work.

Fixes: 80fbaf1c3f29 ("rcuwait: Add @state argument to rcuwait_wait_event()")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lkml.kernel.org/r/87fte1qzh0.fsf@nanos.tec.linutronix.de

---
 arch/m68k/include/asm/uaccess_no.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/m68k/include/asm/uaccess_no.h b/arch/m68k/include/asm/uaccess_no.h
index 6bc80c3..a24cfe4 100644
--- a/arch/m68k/include/asm/uaccess_no.h
+++ b/arch/m68k/include/asm/uaccess_no.h
@@ -5,7 +5,6 @@
 /*
  * User space memory access functions
  */
-#include <linux/mm.h>
 #include <linux/string.h>
 
 #include <asm/segment.h>
