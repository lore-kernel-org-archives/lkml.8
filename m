Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1446C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 20:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C1BB20873
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 20:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590007867;
	bh=f5ZjuQZHOyOJalpcVvxXRlHkEct0Vs8p9XAUEBDokrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CKHxO4oLQCi3Vpe88B9NIhjv7vxYaMRUn8aWAi0yb+bdQm2yeuWJu39RK5hcxcdJn
	 Gwu/iESP4HyWlcZD5ovzSesvEQHDc2iAbPdMDDhS0Fc44j6GOFGZaJWcVZLFJMy5wj
	 u2Om6ys6nVmojrGkt+NEdHdHMxbd8FLhgHFemXlk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgETUvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 16:51:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:48440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728019AbgETUvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 16:51:06 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 596C020756;
        Wed, 20 May 2020 20:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590007865;
        bh=f5ZjuQZHOyOJalpcVvxXRlHkEct0Vs8p9XAUEBDokrs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qd//t7SJil89L+3KueWSVoahjbKgKmrETISU0aAsdikuJhHU62WjvjccEg6VenOyD
         k6A0qZgfLxlQVBlPztWzGRITf4QFm0OGJJGO2ivPoeEtWUWfFPtJwUnhPV6G15bqT9
         x5blc5cr9SB5Fsrw6l4/wkdL+1tqtI8De/XMv4Ws=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4F9E740AFD; Wed, 20 May 2020 17:51:03 -0300 (-03)
Date:   Wed, 20 May 2020 17:51:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/19] perf ftrace: detect workload failure
Message-ID: <20200520205103.GP32678@kernel.org>
References: <20200510150628.16610-1-changbin.du@gmail.com>
 <20200510150628.16610-3-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200510150628.16610-3-changbin.du@gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, May 10, 2020 at 11:06:11PM +0800, Changbin Du escreveu:
> Currently there's no error message prompted if we failed to start workload.
> And we still get some trace which is confusing. Let's tell users what
> happened.

Applied, but please in the future add Before and After output of the
commands for these to be clear even to my 4yo kid:

commit 2a5193e460eaf8792a87f678e3c5f78c88db2123
Author: Changbin Du <changbin.du@intel.com>
Date:   Sun May 10 23:06:11 2020 +0800

    perf ftrace: Detect workload failure
    
    Currently there's no error message prompted if we failed to start
    workload.  And we still get some trace which is confusing. Let's tell
    users what happened.
    
    Committer testing:
    
    Before:
    
        # perf ftrace nonsense |& head
         5)               |  switch_mm_irqs_off() {
         5)   0.400 us    |    load_new_mm_cr3();
         5)   3.261 us    |  }
         ------------------------------------------
         5)    <idle>-0    =>   <...>-3494
         ------------------------------------------
    
         5)               |  finish_task_switch() {
         5)   ==========> |
         5)               |    smp_irq_work_interrupt() {
        # type nonsense
        -bash: type: nonsense: not found
        #
    
    After:
    
      # perf ftrace nonsense |& head
      workload failed: No such file or directory
      # type nonsense
      -bash: type: nonsense: not found
      #
    
    Signed-off-by: Changbin Du <changbin.du@gmail.com>
    Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
    Cc: Jiri Olsa <jolsa@redhat.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
    Link: http://lore.kernel.org/lkml/20200510150628.16610-3-changbin.du@gmail.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index b7d3fb5fa8b1..2bfc1b0db536 100644
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
 
@@ -383,6 +384,14 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 
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
@@ -397,7 +406,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 out_reset:
 	reset_tracing_files(ftrace);
 out:
-	return done ? 0 : -1;
+	return (done && !workload_exec_errno) ? 0 : -1;
 }
 
 static int perf_ftrace_config(const char *var, const char *value, void *cb)
