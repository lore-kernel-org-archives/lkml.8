Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98240C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 04:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6756F21655
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 04:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dV7pThsF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgEHE5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 00:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgEHE5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 00:57:07 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECBAC05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 21:57:07 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id x8so779514qkf.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 21:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=x68VNmAINfXid1iNJuaPcuSDsx8kamsfOgqkBmYYLqA=;
        b=dV7pThsFMm+cFN1gBiT8ezbUUuQVYKGqyrqVQrYkfY7dMTmx7pxxfKk0q07XMZ/Aui
         M8NQ6FePm12ujIC+Eq3mMKiIkL166CdottUpGDDRQxTMB++3R3LnNbMuRosM2HOC86vS
         nMj/1Ynz2w8Boix8gTEgtfENTwXX5tWhI0pqbmFGB4re52urwyInSTxV/mqV5IJe8gSv
         eypQMSJnhKRLor9LmHKO8hdkf0VCcoQx5RM/vwdVvM7CKW65e1sy6LuSgSSzTFPoJ9hG
         pUXumO1UR3+HR7jjZjwLhszQbmq4NKo+uMl7xWXTw7MacCVUKvyqwbHXpZAB2UAcu71j
         Dsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=x68VNmAINfXid1iNJuaPcuSDsx8kamsfOgqkBmYYLqA=;
        b=jS9XwVyBp/xmudUSZ7+oGBGDmEiy2yaVR0uXvrhHz5F1rtJNFcyRAPmfbs8l2o/Yxk
         PwPYaTpAaYJU4ms9ggW/KdF7Yg8u+rCxlREem93ZwYm7HNgs+itOGZhjPv/Sedt7MRZD
         DYGARvSIELDGrMbKC4Etz5G3KHlwDcbJpWP0F0P//zcFN1nDQqj+KvLP+EqnA4Ov1zsK
         55sQVjDsFruAX+6hckvQ0fu+1nqkBOdrSy0sq4b/wOCks4IpXgtLM+TqUj4LKL/rVBBb
         psnCOOIjnR/etw8zVitLYUGtENKmmex1LRlImkxa1nd7cqTgwj3aFXqwTzONyyYfwPdB
         M1QQ==
X-Gm-Message-State: AGi0PuZaCS8+FHcTxa9TEJ28sQA1DtvccCt36GxcrMwHVSUVpPEIcSMt
        EiM3lpFYTHsbnOzJ8BGi/Z/VGLTpK/cc
X-Google-Smtp-Source: APiQypJV+qJuszA8TOzxTGzEn9UtjeKCUmoqpXTv9uF6luzI0zRmyuw8cqOsyFVOPyjJ2Qnoleqr6aV3n7Yb
X-Received: by 2002:a0c:eb50:: with SMTP id c16mr891878qvq.151.1588913826901;
 Thu, 07 May 2020 21:57:06 -0700 (PDT)
Date:   Fri,  8 May 2020 14:56:43 +1000
Message-Id: <20200508145624.1.I4d7421c6bbb1f83ea58419082481082e19097841@changeid>
Mime-Version: 1.0
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

 tools/perf/builtin-record.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 1ab349abe90469..ce5fc3860131d2 100644
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
@@ -518,15 +519,19 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
 
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
+	if (write(done_fd, &tmp, sizeof(tmp)) < 0)
+		pr_err("failed to signal wakeup fd\n");
 }
 
 static void sigsegv_handler(int sig)
@@ -1424,6 +1429,9 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	int fd;
 	float ratio = 0;
 
+	done_fd = eventfd(0, EFD_NONBLOCK);
+	evlist__add_pollfd(rec->evlist, done_fd);
+
 	atexit(record__sig_exit);
 	signal(SIGCHLD, sig_handler);
 	signal(SIGINT, sig_handler);
-- 
2.26.2.645.ge9eca65c58-goog

