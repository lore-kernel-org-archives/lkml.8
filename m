Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD4CC10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 15:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35857206BE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 15:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbgCOPQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 11:16:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50144 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728798AbgCOPQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 11:16:11 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jDUzq-0001iT-6S; Sun, 15 Mar 2020 16:16:10 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 458FD1013B3;
        Sun, 15 Mar 2020 16:16:09 +0100 (CET)
Date:   Sun, 15 Mar 2020 15:14:38 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/urgent for 5.6-rc6
References: <158428527861.14940.12920965330771600615.tglx@nanos.tec.linutronix.de>
Message-ID: <158428527863.14940.3868391100636020882.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2020-03-15

up to:  ecc421e05bab: sys/sysinfo: Respect boottime inside time namespace


A single fix adding the missing time namespace adjustment in sys/sysinfo
which caused sys/sysinfo to be inconsistent with /proc/uptime when read
from a task inside a time namespace.


Thanks,

	tglx

------------------>
Cyril Hrubis (1):
      sys/sysinfo: Respect boottime inside time namespace


 kernel/sys.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sys.c b/kernel/sys.c
index f9bc5c303e3f..d325f3ab624a 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -47,6 +47,7 @@
 #include <linux/syscalls.h>
 #include <linux/kprobes.h>
 #include <linux/user_namespace.h>
+#include <linux/time_namespace.h>
 #include <linux/binfmts.h>
 
 #include <linux/sched.h>
@@ -2546,6 +2547,7 @@ static int do_sysinfo(struct sysinfo *info)
 	memset(info, 0, sizeof(struct sysinfo));
 
 	ktime_get_boottime_ts64(&tp);
+	timens_add_boottime(&tp);
 	info->uptime = tp.tv_sec + (tp.tv_nsec ? 1 : 0);
 
 	get_avenrun(info->loads, 0, SI_LOAD_SHIFT - FSHIFT);

