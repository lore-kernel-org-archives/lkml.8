Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00387C54E4B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 04:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAE992072B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 04:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gfrRAg6H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbgELE74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 00:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725814AbgELE7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 00:59:55 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B0DC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 21:59:54 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id g4so11804002ybf.21
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 21:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wTMtR6SinjsfSneLfEmzXkUvLzSb3s46ODVv49BzMq4=;
        b=gfrRAg6HGRG/LTUkmM7Q9ttYyM+8mzucwFcrUkPcW3ZJHVWHiToeUeu1CcH4rvUCQJ
         3mF7k9PPMUnt906rf2JagbXdLXzgtG/ypxsjndr+mzLfDWW0Kvcp12LqZUuEX0/TzJaV
         pBTrnuyeK8FFXecWBj5iA5NWIY+vGYzpKjfc/rQLCb8FhAJqlanV3dAmtIUp0MubTC/G
         ld484k0DS904lpBVTzeO83f9X+PsekabZ2DPshX1izSuRONCIIGmwzc8aRo0XKPAYfV7
         3SxdUtfZf9kJRyrbM/my5DTXTbFjAUDHP1wIxX7lYX3ggbtfcNfNmQV1ETDmj/m90hmi
         NdNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wTMtR6SinjsfSneLfEmzXkUvLzSb3s46ODVv49BzMq4=;
        b=XPTUAvKcBdIlyCaGcP/mLEydsGRG7USEPMbjW75a0zjzTN199tSGJGyreprQOYavn7
         3HbvDLRW3dT0Eb5mGmEDGxLUqfawOxsBxvw70cbeQmjSUBzk5ZSr/g8+s+Fxa12NYUfo
         WMSprkVN6BY3dJVlsam7n2JO72lpJOb7k1hV3280gsjbARA9Kh8Y+DgLjnLYmmEGcEwZ
         8jfs9vy5r5s1AiHFgK8vYmfGWM1wv5BxIqG4SXaoTiaUkifRXpsBvrKIiwvobDliGn0r
         Loq61gqULj0WLAVDAGjsj7u0NVysSSMmBM0CGZKkDcoWRZvgNAojCWKetdg/Se+zMKqA
         cigQ==
X-Gm-Message-State: AGi0PuZWLdbp6pqPqaHwiMSs7yvJoZuTDVw79+Hw2f0RBloQbjD7EZn+
        cd25ebLlLT6AUTmeWhX6h8kyqp5inP+8
X-Google-Smtp-Source: APiQypK4W8IIdmnhxjuRK4vWBSaU8V84q0u4mcblA5POpheyVAwREoSiRrBRXNdt9pMAvUHmRWvqZsPq0pJY
X-Received: by 2002:a25:3207:: with SMTP id y7mr17701571yby.463.1589259593405;
 Mon, 11 May 2020 21:59:53 -0700 (PDT)
Date:   Tue, 12 May 2020 14:59:36 +1000
In-Reply-To: <20200508145624.1.I4d7421c6bbb1f83ea58419082481082e19097841@changeid>
Message-Id: <20200512145930.1.I4d7421c6bbb1f83ea58419082481082e19097841@changeid>
Mime-Version: 1.0
References: <20200508145624.1.I4d7421c6bbb1f83ea58419082481082e19097841@changeid>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH] perf record: Use an eventfd to wakeup when done
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

 tools/perf/builtin-record.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 1ab349abe90469..099ecaa66732a2 100644
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
+		pr_err("failed to signal wakeup fd\n");
 }
 
 static void sigsegv_handler(int sig)
@@ -1424,6 +1438,17 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	int fd;
 	float ratio = 0;
 
+	done_fd = eventfd(0, EFD_NONBLOCK);
+	if (done_fd < 0) {
+		pr_err("Failed to create wakeup eventfd, error: %m\n");
+		return -1;
+	}
+	err = evlist__add_pollfd(rec->evlist, done_fd);
+	if (err < 0) {
+		pr_err("Failed to add wakeup eventfd to poll list\n");
+		return -1;
+	}
+
 	atexit(record__sig_exit);
 	signal(SIGCHLD, sig_handler);
 	signal(SIGINT, sig_handler);
-- 
2.26.2.645.ge9eca65c58-goog

