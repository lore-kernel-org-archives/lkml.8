Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77C3C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8378D24673
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581707529;
	bh=G+u9jRhP5jsPv6hxjRcp86ls1mhsmz3EzU7rvIdim+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=03CZv0D8xZMXhWMAscx6ipsqRLGrSckXbWRohtuMQDsgeyVQmeb0B0JdAMaDyt2s8
	 36xp+5vtrGnu35cMrystQlS36rxpxnG3TrRwvMHEIzWoXQ9V+qx9PpOI3FYrzk/Sil
	 MJL90ADhSsHYo0LoM3xDzvl2Vm6z8HxZVxfOVfss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388839AbgBNTMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:12:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:49768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388716AbgBNTMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:12:03 -0500
Received: from quaco.ghostprotocols.net (187-26-102-114.3g.claro.net.br [187.26.102.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 953AD24650;
        Fri, 14 Feb 2020 19:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581707523;
        bh=G+u9jRhP5jsPv6hxjRcp86ls1mhsmz3EzU7rvIdim+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dgL9quSMJVgSJ4CIDQQ21hSuCy1ld1RnRDMFFqdRMjZzTGu3MAVywQoxzmLCpQsYz
         9FlsnR53xzFrMGSOKzPUnHW/TOA+s0aTKg8Rs9Dq6/jhPEislx+Kac4HwGXLs79ffZ
         v8p0CZRanifV0hb61fKz8CPtyiVHTC7Q276Nd3l0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Mike Christie <mchristi@redhat.com>
Subject: [PATCH 11/23] perf beauty prctl: Export the 'options' strarray
Date:   Fri, 14 Feb 2020 16:10:45 -0300
Message-Id: <20200214191057.26266-12-acme@kernel.org>
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

So that we can use it with strtoul, allowing string to number
conversions in filter expressions.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mike Christie <mchristi@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/beauty.h | 2 ++
 tools/perf/trace/beauty/prctl.c  | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 5a61043c2ff7..d6dfe68a7612 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -213,6 +213,8 @@ size_t syscall_arg__scnprintf_x86_arch_prctl_code(char *bf, size_t size, struct
 size_t syscall_arg__scnprintf_prctl_option(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_PRCTL_OPTION syscall_arg__scnprintf_prctl_option
 
+extern struct strarray strarray__prctl_options;
+
 size_t syscall_arg__scnprintf_prctl_arg2(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_PRCTL_ARG2 syscall_arg__scnprintf_prctl_arg2
 
diff --git a/tools/perf/trace/beauty/prctl.c b/tools/perf/trace/beauty/prctl.c
index ba2179abed00..6fe5ad5f5d3a 100644
--- a/tools/perf/trace/beauty/prctl.c
+++ b/tools/perf/trace/beauty/prctl.c
@@ -11,9 +11,10 @@
 
 #include "trace/beauty/generated/prctl_option_array.c"
 
+DEFINE_STRARRAY(prctl_options, "PR_");
+
 static size_t prctl__scnprintf_option(int option, char *bf, size_t size, bool show_prefix)
 {
-	static DEFINE_STRARRAY(prctl_options, "PR_");
 	return strarray__scnprintf(&strarray__prctl_options, bf, size, "%d", show_prefix, option);
 }
 
-- 
2.21.1

