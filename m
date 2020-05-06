Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803E1C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A1C021582
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778863;
	bh=55vswDL15sN87GlRsE3MUEijgY/Ks7F9Rj2rwfAUxz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=123ucxeEXV7TzT7gUOAxUDkhXKqOBb/X15FvAOrkKt87emgXWI4biOArDjtzfmQG8
	 8ylppDGcTDakO8m04n3SA/d48DDvXiS0e/nhLrSnMh4UqOonjrOL+vobcDgin8nfqi
	 qZ2c5/Epc7NOqAV4PZqlEmxEnznMePzg1EJVwxc8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbgEFP1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:27:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:51832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730361AbgEFP1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:27:38 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9214F20A8B;
        Wed,  6 May 2020 15:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778857;
        bh=55vswDL15sN87GlRsE3MUEijgY/Ks7F9Rj2rwfAUxz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HKifYriy34bjbIGTb4srfvzAp3L4CBNJzfXp5cICZReMYcoW1jjuF5tJMFeEuePkv
         RFYy0cAYAnwHc1uCYhbgeqzGDcIKxGV9jcIekxSPxvEEPgi72vn3GnuFUlGoPpfGQR
         Rn8paUnj7g9gs+mfisJ8XnIjEoQ2I5aniaWgrv9A=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 89/91] libsymbols kallsyms: Move hex2u64 out of header
Date:   Wed,  6 May 2020 12:22:32 -0300
Message-Id: <20200506152234.21977-90-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Rogers <irogers@google.com>

hex2u64 is a helper that's out of place in kallsyms.h as not being
kallsyms related. Move from kallsyms.h to the only user.

Committer notes:

Move it out of tools/lib/symbol/kallsyms.c as well, as we had to leave
it there in the previous patch lest we break the build.

Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lore.kernel.org/lkml/20200501221315.54715-4-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/symbol/kallsyms.c | 13 -------------
 tools/lib/symbol/kallsyms.h |  2 --
 tools/perf/util/symbol.c    | 14 ++++++++++++++
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/tools/lib/symbol/kallsyms.c b/tools/lib/symbol/kallsyms.c
index a5edc75c346c..e335ac2b9e19 100644
--- a/tools/lib/symbol/kallsyms.c
+++ b/tools/lib/symbol/kallsyms.c
@@ -11,19 +11,6 @@ u8 kallsyms2elf_type(char type)
 	return (type == 't' || type == 'w') ? STT_FUNC : STT_OBJECT;
 }
 
-/*
- * While we find nice hex chars, build a long_val.
- * Return number of chars processed.
- */
-int hex2u64(const char *ptr, u64 *long_val)
-{
-	char *p;
-
-	*long_val = strtoull(ptr, &p, 16);
-
-	return p - ptr;
-}
-
 bool kallsyms__is_function(char symbol_type)
 {
 	symbol_type = toupper(symbol_type);
diff --git a/tools/lib/symbol/kallsyms.h b/tools/lib/symbol/kallsyms.h
index bd988f7b18d4..72ab9870454b 100644
--- a/tools/lib/symbol/kallsyms.h
+++ b/tools/lib/symbol/kallsyms.h
@@ -18,8 +18,6 @@ static inline u8 kallsyms2elf_binding(char type)
 	return isupper(type) ? STB_GLOBAL : STB_LOCAL;
 }
 
-int hex2u64(const char *ptr, u64 *long_val);
-
 u8 kallsyms2elf_type(char type);
 
 bool kallsyms__is_function(char symbol_type);
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 8f4300492dc7..381da6b39f89 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -566,6 +566,20 @@ void dso__sort_by_name(struct dso *dso)
 	return symbols__sort_by_name(&dso->symbol_names, &dso->symbols);
 }
 
+/*
+ * While we find nice hex chars, build a long_val.
+ * Return number of chars processed.
+ */
+static int hex2u64(const char *ptr, u64 *long_val)
+{
+	char *p;
+
+	*long_val = strtoull(ptr, &p, 16);
+
+	return p - ptr;
+}
+
+
 int modules__parse(const char *filename, void *arg,
 		   int (*process_module)(void *arg, const char *name,
 					 u64 start, u64 size))
-- 
2.21.1

