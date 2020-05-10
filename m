Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFABC54E4B
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86A3F20735
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLjyyABU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgEJPHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 11:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726104AbgEJPHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 11:07:05 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C8EC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 08:07:05 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y9so224598plk.10
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 08:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=voUoOuTrRby1XQqqFE85VsqGFZ6h8QY4sBzJK51ntGg=;
        b=XLjyyABULKU7EGO572c6H60m5i2icms/1MaPWdMnSLJAaKURluOV9sN4K5+uRUiofg
         0P74uzlIaWZSTdbQJji6coIClS/dB0Mgcj9Eb69ZvE4dipumD0VHTJ0a75Dqa0+FuMMw
         kAZHOdqhbalo4YtyACbKi1JSPgpHmy22Q18x6ltPIUC5Y43zVrX5m8McgmSp7vyWqFYu
         3nCnIZb2eYVVRYiPV4fAu7FsYn5PiSF86huvaM0tog2fdDigSyKirLYhlR/ey4ItVfo2
         NY/mu0cTuikoGnMR0XspGpHRXPxd1e1SzxgvED9dvcLZ6Jv7wY61L2nQnSHCwGGWjfhV
         Hr8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=voUoOuTrRby1XQqqFE85VsqGFZ6h8QY4sBzJK51ntGg=;
        b=sPZbQ6IQGcgLoPKK0IA075RFtoJVNh0lRBfvwzZMCUy/EWFhemkWjRdEWdY1ovcra5
         +uCKOc/CJOeGi2wEvhPbOnMGHyBRMr2lYMUoy1fcNRWgGeGUtqQrtooNjNAnAwcrlso7
         nGhEr92Bzp21J5+EzrdZeIYSLqqJ5ld6zDeQYfFnWv6s2liKV7OgqtLuwawAcBR8otuj
         oz+sz6Ikr2tuUMqFLY39Qp+Lkh54Pi4bTVfqU8D3N6BsJi4E1Njj2qSSyXtDHrbJtYEH
         N5NdBjCfwV3ok2uP4SI+DsxFOUqyVMipyiauKRR2NieHKfrWSc4BI0hkpQBYmnJXKMU6
         WjYA==
X-Gm-Message-State: AGi0PuZbqftybPpqTMkRONzjoniYz/wvFQbMOkp/43a8Z99YkrEIzcJ5
        nNUDG0bI/8kZwdqanXUg++E=
X-Google-Smtp-Source: APiQypJWU53pCKYuSd9/psPN+yHFD00v8288Bd5rO6RMJPMMEUu41rtfQFmBeVsVyvn/Eq/KqQBiJg==
X-Received: by 2002:a17:90a:7349:: with SMTP id j9mr17680939pjs.196.1589123224732;
        Sun, 10 May 2020 08:07:04 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id v7sm6870909pfm.146.2020.05.10.08.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 08:07:04 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 02/19] perf ftrace: detect workload failure
Date:   Sun, 10 May 2020 23:06:11 +0800
Message-Id: <20200510150628.16610-3-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200510150628.16610-1-changbin.du@gmail.com>
References: <20200510150628.16610-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there's no error message prompted if we failed to start workload.
And we still get some trace which is confusing. Let's tell users what
happened.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/builtin-ftrace.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 11fc02037899..5584f8dec25d 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -45,6 +45,7 @@ struct filter_entry {
 	char			name[];
 };
 
+static volatile int workload_exec_errno;
 static bool done;
 
 static void sig_handler(int sig __maybe_unused)
@@ -63,7 +64,7 @@ static void ftrace__workload_exec_failed_signal(int signo __maybe_unused,
 						siginfo_t *info __maybe_unused,
 						void *ucontext __maybe_unused)
 {
-	/* workload_exec_errno = info->si_value.sival_int; */
+	workload_exec_errno = info->si_value.sival_int;
 	done = true;
 }
 
@@ -382,6 +383,14 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 
 	write_tracing_file("tracing_on", "0");
 
+	if (workload_exec_errno) {
+		const char *emsg = str_error_r(workload_exec_errno, buf, sizeof(buf));
+		/* flush stdout first so below error msg appears at the end. */
+		fflush(stdout);
+		pr_err("workload failed: %s\n", emsg);
+		goto out_close_fd;
+	}
+
 	/* read remaining buffer contents */
 	while (true) {
 		int n = read(trace_fd, buf, sizeof(buf));
@@ -396,7 +405,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 out_reset:
 	reset_tracing_files(ftrace);
 out:
-	return done ? 0 : -1;
+	return (done && !workload_exec_errno) ? 0 : -1;
 }
 
 static int perf_ftrace_config(const char *var, const char *value, void *cb)
-- 
2.25.1

