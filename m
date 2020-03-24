Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D654AC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 18:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE832074D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 18:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SVxEUhNe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbgCXSL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:11:29 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:48982 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbgCXSL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 14:11:29 -0400
Received: by mail-pg1-f202.google.com with SMTP id f14so14225680pgj.15
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 11:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=A1s+GlgKu1KUfIn178l7zMrQpVDU7CgjURg8+2s0rx0=;
        b=SVxEUhNeN50/tJOoGdm1YPrsE8PoywLqO3Yl9kMDqrYxa36vAeD+6wR7wR7J7QOWyE
         ip2oVxNRex/Mi8jHuiDXdDUp84P8MPhhEQsVhOwxnmAdJzd07bqVaS0roszymXjJBMCS
         96A3iWFVeKuVRUAM1V7ui9moS+JO1uSeCz/0OII7G8rGpMK5s7UQ+ebypdumuZMUmMV0
         ClvmegIw6r+n3RrV26cxyzWgKhA8NS/49BubQKJuwpt/+Kdz8jkiLZTWmy3l/b7cFON7
         y76F4LzO6V9x8KQZxBTWyrLKMWoiEDzloS/oV645tpUpbVheztN+ecPGg6M24lvixRNS
         S7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=A1s+GlgKu1KUfIn178l7zMrQpVDU7CgjURg8+2s0rx0=;
        b=XrFKw+AhCDm7jCpg5YEd8xlWu5934sItKttbqJvbK1BixS8VNrjIOnyC2bSsqfWI7u
         3znq9MGrOs1elNJVfh6aCuwN29XV1XjuQfEcmQGHMj189Qg/uPzR6LJwtLNnN+HkVpHQ
         n6aAtr/FzcGTaa6ia4aGfxswfMXErGvz19w1GF59cLx0jKDTQvv4etjzvkXHOtpYCqML
         vPGjbUwMX4KhiI0l7YbWTomkqXEOQx4kdUPmMUtCmdtpk28Kz+IoruKZZl1uNrXFXy6j
         TiGtNb+PqqnhVbNX2M/w9MVTYPMpYrB9xkb+Na7RuYD5QV0tx2hpw0fDhD91/TgQzbFd
         9lQw==
X-Gm-Message-State: ANhLgQ35QTqqI9tzabvygwscGzruXUduhMx0HN8WHn/u3maZC7G067ev
        U7wjYQ7yVqSWe4c1UAoQA8q5TdnTCtfJLKhJjxuEwB8OfQz+PxRMfPZq9TC1skP6/ZVKSQrMo1+
        hNwjFdNwjdgk94qxeqMPOtzmLoNUKjX2FV+iXHBdofeP+tOKrpnRnZyaHKBGpMFiLSmd8XA+U
X-Google-Smtp-Source: ADFU+vsZHgZzwzSAnX9z0GCt66DRx1pqOylPa4FAFI8S9DOESAJemQ/MuyhGH5nTQ1jcoCiw7ugGea+65lvW
X-Received: by 2002:a63:e70d:: with SMTP id b13mr28393578pgi.8.1585073486180;
 Tue, 24 Mar 2020 11:11:26 -0700 (PDT)
Date:   Tue, 24 Mar 2020 11:10:20 -0700
Message-Id: <20200324181020.229914-1-eranian@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH] perf/tools: fix perf_evsel__fallback() for paranoid=2 and -b
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@elte.hu, acme@redhat.com,
        jolsa@redhat.com, irogers@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When perf_event_paranoid=2, regular users are prevented from sampling
at the kernel level. However, it the user passes an event without
a privilege level, the tool will force :u when it detects paranoid>1.
This works well, except when branch sampling is requested. It has a more
stringent requirement especially with exclude_hv.
$ perf record ls
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.001 MB /tmp/perf.data ]

But:
$ perf record -b ls
Error:
You may not have permission to collect stats.

Consider tweaking /proc/sys/kernel/perf_event_paranoid,
which controls use of the performance events system by
unprivileged users (without CAP_SYS_ADMIN).

The current value is 2:

      -1: Allow use of (almost) all events by all users
    >= 0: Disallow raw tracepoint access by users without CAP_IOC_LOCK
    >= 1: Disallow CPU event access by users without CAP_SYS_ADMIN
    >= 2: Disallow kernel profiling by users without CAP_SYS_ADMIN

To make this setting permanent, edit /etc/sysctl.conf too, e.g.:

    kernel.perf_event_paranoid = -1

The problem is that in the fallback cod only exclude_kernel is checked and
if set, then exclude_hv is not forced to 1. When branch sampling is enabled
exclude_hv must be set.

This patch fixes the bug in the fallback code by considering the value of
exclude_hv and not just exclude_kernel. We prefer this approach to give a
chance to exclude_hv=0.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 tools/perf/util/evsel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 816d930d774e7..db0e6112992e5 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2424,7 +2424,8 @@ bool perf_evsel__fallback(struct evsel *evsel, int err,
 
 		zfree(&evsel->name);
 		return true;
-	} else if (err == EACCES && !evsel->core.attr.exclude_kernel &&
+	} else if (err == EACCES &&
+		   (!evsel->core.attr.exclude_kernel || !evsel->core.attr.exclude_hv) &&
 		   (paranoid = perf_event_paranoid()) > 1) {
 		const char *name = perf_evsel__name(evsel);
 		char *new_name;
-- 
2.25.1.696.g5e7596f4ac-goog

