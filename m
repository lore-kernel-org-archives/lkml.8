Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6AFC43332
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 19:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817C520775
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 19:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgCUT3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 15:29:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39274 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbgCUT3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 15:29:01 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jFjnY-0008Uo-OD; Sat, 21 Mar 2020 20:28:44 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 1657D1040D4; Sat, 21 Mar 2020 20:28:43 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     kbuild test robot <lkp@intel.com>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: Re: [tip:locking/core 19/28] include/linux/fs.h:1422:29: error: array type has incomplete element type 'struct percpu_rw_semaphore'
In-Reply-To: <202003220209.CjthuGEA%lkp@intel.com>
References: <202003220209.CjthuGEA%lkp@intel.com>
Date:   Sat, 21 Mar 2020 20:28:43 +0100
Message-ID: <87fte1qzh0.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kbuild test robot <lkp@intel.com> writes:
> All errors (new ones prefixed by >>):
>
>    In file included from include/linux/huge_mm.h:8,
>                     from include/linux/mm.h:567,
>                     from arch/m68k/include/asm/uaccess_no.h:8,
>                     from arch/m68k/include/asm/uaccess.h:3,
>                     from include/linux/uaccess.h:11,
>                     from include/linux/sched/task.h:11,
>                     from include/linux/sched/signal.h:9,
>                     from include/linux/rcuwait.h:6,
>                     from include/linux/percpu-rwsem.h:7,
>                     from kernel/locking/percpu-rwsem.c:6:
>>> include/linux/fs.h:1422:29: error: array type has incomplete element type 'struct percpu_rw_semaphore'
>     1422 |  struct percpu_rw_semaphore rw_sem[SB_FREEZE_LEVELS];
>          |                             ^~~~~~

Same problem as in the other architectures and same cure.

Thanks,

        tglx
---
Subject: m68knommu: Remove mm.h include from uaccess_no.h
From: Thomas Gleixner <tglx@linutronix.de>
Date: Sat, 21 Mar 2020 20:22:10 +0100

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
Cc: Greg Ungerer <gerg@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org
---
 arch/m68k/include/asm/uaccess_no.h |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/m68k/include/asm/uaccess_no.h
+++ b/arch/m68k/include/asm/uaccess_no.h
@@ -5,7 +5,6 @@
 /*
  * User space memory access functions
  */
-#include <linux/mm.h>
 #include <linux/string.h>
 
 #include <asm/segment.h>
