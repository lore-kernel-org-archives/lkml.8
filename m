Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AA7C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A088824681
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgAQKIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 05:08:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55358 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbgAQKIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 05:08:50 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1isOYT-0005RL-GZ; Fri, 17 Jan 2020 11:08:41 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2F1741C19CE;
        Fri, 17 Jan 2020 11:08:41 +0100 (CET)
Date:   Fri, 17 Jan 2020 10:08:41 -0000
From:   "tip-bot2 for Wang Long" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/psi: create /proc/pressure and
 /proc/pressure/{io|memory|cpu} only when psi enabled
Cc:     Wang Long <w@laoqinren.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1576672698-32504-1-git-send-email-w@laoqinren.net>
References: <1576672698-32504-1-git-send-email-w@laoqinren.net>
MIME-Version: 1.0
Message-ID: <157925572102.396.13781861787054630755.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3d817689a62cf71bbb290af18cd26cf9764f38fe
Gitweb:        https://git.kernel.org/tip/3d817689a62cf71bbb290af18cd26cf9764f38fe
Author:        Wang Long <w@laoqinren.net>
AuthorDate:    Wed, 18 Dec 2019 20:38:18 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 17 Jan 2020 10:19:22 +01:00

sched/psi: create /proc/pressure and /proc/pressure/{io|memory|cpu} only when psi enabled

when CONFIG_PSI_DEFAULT_DISABLED set to N or the command line set psi=0,
I think we should not create /proc/pressure and
/proc/pressure/{io|memory|cpu}.

In the future, user maybe determine whether the psi feature is enabled by
checking the existence of the /proc/pressure dir or
/proc/pressure/{io|memory|cpu} files.

Signed-off-by: Wang Long <w@laoqinren.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Link: https://lkml.kernel.org/r/1576672698-32504-1-git-send-email-w@laoqinren.net
---
 kernel/sched/psi.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index ce8f674..db7b50b 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1280,10 +1280,12 @@ static const struct file_operations psi_cpu_fops = {
 
 static int __init psi_proc_init(void)
 {
-	proc_mkdir("pressure", NULL);
-	proc_create("pressure/io", 0, NULL, &psi_io_fops);
-	proc_create("pressure/memory", 0, NULL, &psi_memory_fops);
-	proc_create("pressure/cpu", 0, NULL, &psi_cpu_fops);
+	if (psi_enable) {
+		proc_mkdir("pressure", NULL);
+		proc_create("pressure/io", 0, NULL, &psi_io_fops);
+		proc_create("pressure/memory", 0, NULL, &psi_memory_fops);
+		proc_create("pressure/cpu", 0, NULL, &psi_cpu_fops);
+	}
 	return 0;
 }
 module_init(psi_proc_init);
