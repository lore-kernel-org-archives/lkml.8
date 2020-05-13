Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A00C2D0F6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 02:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D971E207BC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 02:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rU6s/YCi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbgEMCUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 22:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbgEMCUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 22:20:35 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36614C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 19:20:35 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id z8so16354230qtu.17
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 19:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qDDHsvQF3Tyt1WbknmEeIhIcYqpwBalOj7vPZbmNQDs=;
        b=rU6s/YCiIrwhUh7k4TifC45P+9mvAJWJiual5AC+cP44zoLPExiNjOHw6lDoQ/nqfN
         aIQkHIOZAX/HJ7ncKOmM9DRR5CrLQf7TK6JkAl7nV/AF0LnwrC+agkpDuWSPLTjnNSxc
         RxsetU9O4GxLfYWLTcBecXnh2pXsXfvH7jVaxbccF57Kx33G0uXeDn+8LG6zqEAe2mk0
         /lVl5L6ZURNGsdtQsja1xIPtdUxGvKwjT4iZoWjgQhvlZZKrVzEOfVXoOplKNtUTXH25
         ZnAcq2YRS8zdlOteeZABEIqLJ0iTvE2583hrRVxN2nWWlH3fwGFOXdylicu6d95G7V9E
         8QOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qDDHsvQF3Tyt1WbknmEeIhIcYqpwBalOj7vPZbmNQDs=;
        b=OE47dcPOyssOwWm12Bp6N9KSYA8YBf6t9zs3wTueVINaOAomnpPUKqk/i2PPS7YiY9
         UonPij2DgCld4ZZFaIrcwsVTQmw7rF+Z1iLK/xl9AYqRpcJkmXJ3hqxRBHimXXIrcIfW
         7Q8Qn7AbdtYi9IW7A76pPYzqyLiQtQ4TQftvI3HrcGaePRn8JHr3/55E/8QDh7CnH0gn
         Y0DoAfkG2tiGSKte3mbxdD8SG6fug+aTEWpCWeJkOLmhWrm6Yag44YIhQgml1jTJSZzU
         1QqCvCIvubdi690os3+es34cXI2Zl/3d0YU9a+9Y4Gp4DIiAZDL9YaT1oBOZ8KzZkCOk
         Cx8w==
X-Gm-Message-State: AOAM531KODUMTxYuD7JHgUp1jVecnp39cW49uSmZLuUFiZChAOT1gVAf
        Os84PAQWypfbL5iJk+3xFjzwxLgowplB
X-Google-Smtp-Source: ABdhPJzv0tKVfFSUhgtN2D2Vk4BRlFxBUYoMeevUFh3I3Us0KsJsXlBYlI1ZoT3fCjjOgsltuyQ8cBGrebh7
X-Received: by 2002:a05:6214:108b:: with SMTP id o11mr1316878qvr.60.1589336434377;
 Tue, 12 May 2020 19:20:34 -0700 (PDT)
Date:   Wed, 13 May 2020 12:20:23 +1000
In-Reply-To: <20200508145624.1.I4d7421c6bbb1f83ea58419082481082e19097841@changeid>
Message-Id: <20200513122012.v3.1.I4d7421c6bbb1f83ea58419082481082e19097841@changeid>
Mime-Version: 1.0
References: <20200508145624.1.I4d7421c6bbb1f83ea58419082481082e19097841@changeid>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH v3] perf record: Use an eventfd to wakeup when done
From:   Anand K Mistry <amistry@google.com>
To:     linux-perf-users@vger.kernel.org
Cc:     Anand K Mistry <amistry@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The setting and checking of 'done' contains a rare race where the signal
handler setting 'done' is run after checking to break the loop, but
before waiting in evlist__poll(). In this case, the main loop won't wake
up until either another signal is sent, or the perf data fd causes a
wake up.

The following simple script can trigger this condition (but you might
need to run it for several hours):
for ((i = 0; i >= 0; i++)) ; do
  echo "Loop $i"
  delay=$(echo "scale=4; 0.1 * $RANDOM/32768" | bc)
  ./perf record -- sleep 30000000 >/dev/null&
  pid=$!
  sleep $delay
  kill -TERM $pid
  echo "PID $pid"
  wait $pid
done

At some point, the loop will stall. Adding logging, even though perf has
received the SIGTERM and set 'done = 1', perf will remain sleeping until
a second signal is sent.

Signed-off-by: Anand K Mistry <amistry@google.com>

---

Changes in v3:
- Move done_fd creation to below session initialisation
- Close done_fd on exit
- Log errno when write(done_fd) fails

Changes in v2:
- Added comment to signal handler explaining why the eventfd is added
- Added error handling when creating done_fd

 tools/perf/builtin-record.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 1ab349abe90469..a1af6857f24748 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -53,6 +53,7 @@
 #include <unistd.h>
 #include <sched.h>
 #include <signal.h>
+#include <sys/eventfd.h>
 #include <sys/mman.h>
 #include <sys/wait.h>
 #include <sys/types.h>
@@ -518,15 +519,28 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
 
 static volatile int signr = -1;
 static volatile int child_finished;
+static int done_fd = -1;
 
 static void sig_handler(int sig)
 {
+	u64 tmp = 1;
 	if (sig == SIGCHLD)
 		child_finished = 1;
 	else
 		signr = sig;
 
 	done = 1;
+
+	/*
+	 * It is possible for this signal handler to run after done is checked
+	 * in the main loop, but before the perf counter fds are polled. If this
+	 * happens, the poll() will continue to wait even though done is set,
+	 * and will only break out if either another signal is received, or the
+	 * counters are ready for read. To ensure the poll() doesn't sleep when
+	 * done is set, use an eventfd (done_fd) to wake up the poll().
+	 */
+	if (write(done_fd, &tmp, sizeof(tmp)) < 0)
+		pr_err("failed to signal wakeup fd, error: %m\n");
 }
 
 static void sigsegv_handler(int sig)
@@ -1466,6 +1480,19 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		return -1;
 	}
 
+	done_fd = eventfd(0, EFD_NONBLOCK);
+	if (done_fd < 0) {
+		pr_err("Failed to create wakeup eventfd, error: %m\n");
+		status = -1;
+		goto out_delete_session;
+	}
+	err = evlist__add_pollfd(rec->evlist, done_fd);
+	if (err < 0) {
+		pr_err("Failed to add wakeup eventfd to poll list\n");
+		status = err;
+		goto out_delete_session;
+	}
+
 	session->header.env.comp_type  = PERF_COMP_ZSTD;
 	session->header.env.comp_level = rec->opts.comp_level;
 
@@ -1827,6 +1854,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	}
 
 out_delete_session:
+	if (done_fd >= 0)
+		close(done_fd);
 	zstd_fini(&session->zstd_data);
 	perf_session__delete(session);
 
-- 
2.26.2.645.ge9eca65c58-goog

