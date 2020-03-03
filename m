Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A997C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 15:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BADB2073D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 15:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbgCCPGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 10:06:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:47526 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729176AbgCCPGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 10:06:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3A179B325;
        Tue,  3 Mar 2020 15:06:53 +0000 (UTC)
From:   Cyril Hrubis <chrubis@suse.cz>
To:     linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@openvz.org>, Dmitry Safonov <dima@arista.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Bohac <jbohac@suse.cz>, Cyril Hrubis <chrubis@suse.cz>
Subject: [PATCH] sys/sysinfo: Respect boottime inside time namespace
Date:   Tue,  3 Mar 2020 16:06:38 +0100
Message-Id: <20200303150638.7329-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sysinfo() syscall includes uptime in seconds this makes it
consistent with the /proc/uptime inside of a time namespace.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
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
-- 
2.24.1

