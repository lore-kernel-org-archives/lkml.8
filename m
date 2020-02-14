Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDADFC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B57D82465D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581707536;
	bh=iLQ0bzrCA+KrnRzHd/NmxLab/YgDOlr4I+oInNcSueg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1R3AR2ieg3zlXJspRd1lAXq9t4nW2wXtrSA2GyE8G4cGEYIUnNrgTpeBXvk/blauA
	 OZyfbFKjTC6w3bTFo9FrgwLgnGIBwrbOfDzlBSg+W21+8A+RdydThHA/pXq89ZDDhQ
	 Xfo9XKdPmMsUuVohRlDJqk1TYwB1I9Hx9s7KlABA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388973AbgBNTMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:12:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:49876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388832AbgBNTMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:12:12 -0500
Received: from quaco.ghostprotocols.net (187-26-102-114.3g.claro.net.br [187.26.102.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A29122314;
        Fri, 14 Feb 2020 19:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581707531;
        bh=iLQ0bzrCA+KrnRzHd/NmxLab/YgDOlr4I+oInNcSueg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j84iSsoYiZe5rcE6u18tP1c789WychuR1wXLwcOJCWD9wpZeQgER6cJDXCZVskTMe
         qyMw35BTcfePtgWNO1wxRe2zV98ubfvN1uYytw1GUFQcT4mx699jOVH5CkkT2fsNRe
         wM4ESmvPH3CE84TWyGSa5waqcIovl18vcP6VztAQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrei Vagin <avagin@openvz.org>
Subject: [PATCH 13/23] tools headers UAPI: Sync sched.h with the kernel
Date:   Fri, 14 Feb 2020 16:10:47 -0300
Message-Id: <20200214191057.26266-14-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200214191057.26266-1-acme@kernel.org>
References: <20200214191057.26266-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes in:

  769071ac9f20 ("ns: Introduce Time Namespace")

Silencing this tools/perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/sched.h' differs from latest version at 'include/uapi/linux/sched.h'
  diff -u tools/include/uapi/linux/sched.h include/uapi/linux/sched.h

Which enables 'perf trace' to decode the CLONE_NEWTIME bit in the
'flags' argument to the clone syscalls.

Example of clone flags being decoded:

  [root@quaco ~]# perf trace -e clone*
       0.000 qemu-system-x8/23923 clone(clone_flags: VM|FS|FILES|SIGHAND|THREAD|SYSVSEM|SETTLS|PARENT_SETTID|CHILD_CLEARTID, newsp: 0x7f0dad7f9870, parent_tidptr: 0x7f0dad7fa9d0, child_tidptr: 0x7f0dad7fa9d0, tls: 0x7f0dad7fa700) = 6806 (qemu-system-x86)
           ? qemu-system-x8/6806  ... [continued]: clone())              = 0
  ^C[root@quaco ~]#

At some point this should enable things like:

  # perf trace -e 'clone*/clone_flags&NEWTIME/'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andrei Vagin <avagin@openvz.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/sched.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/include/uapi/linux/sched.h b/tools/include/uapi/linux/sched.h
index 4a0217832464..2e3bc22c6f20 100644
--- a/tools/include/uapi/linux/sched.h
+++ b/tools/include/uapi/linux/sched.h
@@ -36,6 +36,12 @@
 /* Flags for the clone3() syscall. */
 #define CLONE_CLEAR_SIGHAND 0x100000000ULL /* Clear any signal handler and reset to SIG_DFL. */
 
+/*
+ * cloning flags intersect with CSIGNAL so can be used with unshare and clone3
+ * syscalls only:
+ */
+#define CLONE_NEWTIME	0x00000080	/* New time namespace */
+
 #ifndef __ASSEMBLY__
 /**
  * struct clone_args - arguments for the clone3 syscall
-- 
2.21.1

