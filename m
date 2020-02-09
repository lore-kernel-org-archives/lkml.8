Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD91C35250
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 10:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F0D320726
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 10:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMTyRY67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbgBIK1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 05:27:45 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:52446 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbgBIK1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 05:27:45 -0500
Received: by mail-pj1-f68.google.com with SMTP id ep11so2889130pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 02:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jCjPuJNh7y163fuH52924U0TilCQIyk7AKarrYQwMlU=;
        b=UMTyRY67J7q7nfTqxlM+hkep+sBdWFUkE55jCan1M80XHmn203vz9vk5ErmbaX2l0G
         E6z3iMi11iNM4IUbmzW3ohn8C6QvP5+B81q8W5gl3Vzr1zjVh5f3NnMvV+QACnobO9rC
         2kLOKI4lqVfAoUT/cydVRvLqDx6azKixg6UqwepYix+Qo7koYT17LUa3Zm3wVncGCT7G
         3UJUKswtdkuOD93WyGTWUDNKWmxRI3HFKlFHPW27WMzIH2WzsueIoRQiVEYpQc8ZXtzF
         d8ZMAZTkf2Xt1XQSEPe8OOO3ZeJui6y8XcWeKxBFFrcaeeMEM+QpOtpOMOZ1VECJItc3
         qe4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jCjPuJNh7y163fuH52924U0TilCQIyk7AKarrYQwMlU=;
        b=EiYEswYLScRzmbBWOQdCwDtZF2QohhbXJW3Qe28D85wdcELWi6oxWlB/m2Qnz/tFXe
         nIxVe+B3VgHuy/eUWSdRby4+TVbdXPzweUra+ZQEmYDW7/1IZiqzJddkC7Qzcf9Tbl10
         uRN1j6ZKXNKjAoWo6XROstCsE9eDxbLgNbQgT/jsDC7YrclYmqA0Zn1rLzOphXSSKSe0
         mbM0yYucuxshq/5LvvjKz4Z1em1Fe0nlp7zBoAQTTxt2YtUYy2B8bqGm7jPLQcP3GES7
         n6Jh6upcA0ifXZRsfMFuE6QKN8XP/pCgAF9SUyoQhHjbSVuGM55f2upPEFTo+Qnd1l5q
         TOUA==
X-Gm-Message-State: APjAAAV+WDk9KAieI6sDN5wCx5AHmAwJlZUuIedacW6t1PHH6SvbTMhD
        TjUIBU6uj/wbKhUXL75p7xVWjhoBiDg=
X-Google-Smtp-Source: APXvYqxLokrORpCd3uP+Ci8jY/uWzSUx1jpQbdDjBsVfD45FYuN7BOq6NlmOdzTqMMTuxQc0eESPzA==
X-Received: by 2002:a17:902:34a:: with SMTP id 68mr7332999pld.250.1581244064528;
        Sun, 09 Feb 2020 02:27:44 -0800 (PST)
Received: from localhost.localdomain ([146.196.37.155])
        by smtp.googlemail.com with ESMTPSA id 196sm9030786pfy.86.2020.02.09.02.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 02:27:43 -0800 (PST)
From:   Amol Grover <frextrite@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Amol Grover <frextrite@gmail.com>
Subject: [PATCH] perf_event: Annotate rb pointer with __rcu
Date:   Sun,  9 Feb 2020 15:55:31 +0530
Message-Id: <20200209102530.26115-1-frextrite@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf_event::rb is used in RCU context, tell sparse
about it aswell to eliminate false-positives.

Fixes the following instances of sparse error:
incompatible types in comparison expression (different address spaces)
kernel/events/core.c:5596:9
kernel/events/core.c:5302:22
kernel/events/core.c:5438:14
kernel/events/core.c:5471:14
kernel/events/core.c:5528:14
kernel/events/core.c:5614:14
kernel/events/core.c:5627:14
kernel/events/core.c:7182:13
kernel/events/ring_buffer.c:169:14
kernel/events/ring_buffer.c:169:14
kernel/events/ring_buffer.c:169:14

This introduces the following 2 new sparse errors:
kernel/events/core.c:7212:9
kernel/events/core.c:5749:31

which are fixed by using RCU primitives, rcu_dereference()
and rcu_access_pointer() on perf_event::rb.

Signed-off-by: Amol Grover <frextrite@gmail.com>
---
 include/linux/perf_event.h | 2 +-
 kernel/events/core.c       | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 6d4c22aee384..1691107d2800 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -694,7 +694,7 @@ struct perf_event {
 	struct mutex			mmap_mutex;
 	atomic_t			mmap_count;
 
-	struct ring_buffer		*rb;
+	struct ring_buffer __rcu	*rb;
 	struct list_head		rb_entry;
 	unsigned long			rcu_batches;
 	int				rcu_pending;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2173c23c25b4..7b9411d21165 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5746,7 +5746,7 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 		 * still restart the iteration to make sure we're not now
 		 * iterating the wrong list.
 		 */
-		if (event->rb == rb)
+		if (rcu_access_pointer(event->rb) == rb)
 			ring_buffer_attach(event, NULL);
 
 		mutex_unlock(&event->mmap_mutex);
@@ -7209,7 +7209,8 @@ static void perf_pmu_output_stop(struct perf_event *event)
 
 restart:
 	rcu_read_lock();
-	list_for_each_entry_rcu(iter, &event->rb->event_list, rb_entry) {
+	list_for_each_entry_rcu(iter, &rcu_dereference(event->rb)->event_list,
+				rb_entry) {
 		/*
 		 * For per-CPU events, we need to make sure that neither they
 		 * nor their children are running; for cpu==-1 events it's
-- 
2.24.1

