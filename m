Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EDFC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 10:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2895420870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 10:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FqQJM5dW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbgBKKDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 05:03:00 -0500
Received: from mail-wm1-f73.google.com ([209.85.128.73]:58630 "EHLO
        mail-wm1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbgBKKDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 05:03:00 -0500
Received: by mail-wm1-f73.google.com with SMTP id p2so1106340wmi.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 02:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=4ErgepGfDI3yrrGPodBZCow6kOhTX1ReLVCDrlwlOKY=;
        b=FqQJM5dW1/FooZ2cFt2xQ5iJ1Tqxr/S+zlg1ivQ1SkzX+LJssklGFCSACCll8ncIth
         S83G93n7UzkiRiLY4LZVPlBGJxjWhKyEOCfzt2k5IQxEuZUar1fNNb31Je07/gdPtqN3
         GR5HvEGi2L0eWu31vlJE0S7lQaYr33Rib8WyHmURGcmy7+o+p9DW/VX6TqT+WNhZpo8P
         EWlDnL+65tIdbLAnOxZQkDkXijD2FU7yD1U6IZicFllGphHU5B7O3M+jXYR6kMIs3/7L
         zJqrwdE593crtsJvki30OZSyR34/duLqlP5/c07V4IdIa08jE5nKE/Y1RmxYbZ0RES0u
         woOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=4ErgepGfDI3yrrGPodBZCow6kOhTX1ReLVCDrlwlOKY=;
        b=f4VlAtgsWgGuLKSTIs49FFVorhWEqQit7zdCgR2GRAw2A6i0VweY//aqhFcra6xvtq
         9qSxAhFBmo52e58cioZdHJ5IFfsJWXSay19NOherbqYUPzixwQcj09It5riT/rQhnV5N
         llDj+pzMtt8ScqoIc4QQEmXTKiGeQKHVxYYvn0w9MES5uxX7XDaysBoIKgSAG9pU9bEJ
         NVuL9hyIldK5dz16KHBYpUPhYQxx6EKeQW+PTpjd9ovjltSl2BuqhfeACAU1rvQdcHh3
         Rsk/1ObVdAGj6MW88TA5di1lEFy00eJCjaMQKx59GUBuFFoYUm2mlkaNPSMkZw1tJVOX
         BU8g==
X-Gm-Message-State: APjAAAWn9/se7D+fvXOO8MX/fIzwz1oO3oBIC20PgpMDf3bKPJsvzM+L
        JKq34ndVxtE8U6HXvCYub7Ow3nZAVw==
X-Google-Smtp-Source: APXvYqxnsn5PVOziySVAlxU2el27ltIMmQsBTqh/nhzrnNWSlvuM7AUfSZCkjKrx+UCr7I7R6vQfm5DalQ==
X-Received: by 2002:adf:fe43:: with SMTP id m3mr8140672wrs.213.1581415377060;
 Tue, 11 Feb 2020 02:02:57 -0800 (PST)
Date:   Tue, 11 Feb 2020 11:02:43 +0100
Message-Id: <20200211100243.101187-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
Subject: [PATCH v2] kcsan: Fix misreporting if concurrent races on same address
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there are at least 4 threads racing on the same address, it can
happen that one of the readers may observe another matching reader in
other_info. To avoid locking up, we have to consume 'other_info'
regardless, but skip the report. See the added comment for more details.

Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Improve comment to illustrate more concrete case.
---
 kernel/kcsan/report.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index 3bc590e6be7e3..abf6852dff72f 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -422,6 +422,44 @@ static bool prepare_report(unsigned long *flags, const volatile void *ptr,
 			return false;
 		}
 
+		access_type |= other_info.access_type;
+		if ((access_type & KCSAN_ACCESS_WRITE) == 0) {
+			/*
+			 * While the address matches, this is not the other_info
+			 * from the thread that consumed our watchpoint, since
+			 * neither this nor the access in other_info is a write.
+			 * It is invalid to continue with the report, since we
+			 * only have information about reads.
+			 *
+			 * This can happen due to concurrent races on the same
+			 * address, with at least 4 threads. To avoid locking up
+			 * other_info and all other threads, we have to consume
+			 * it regardless.
+			 *
+			 * A concrete case to illustrate why we might lock up if
+			 * we do not consume other_info:
+			 *
+			 *   We have 4 threads, all accessing the same address
+			 *   (or matching address ranges). Assume the following
+			 *   watcher and watchpoint consumer pairs:
+			 *   write1-read1, read2-write2. The first to populate
+			 *   other_info is write2, however, write1 consumes it,
+			 *   resulting in a report of write1-write2. This report
+			 *   is valid, however, now read1 populates other_info;
+			 *   read2-read1 is an invalid conflict, yet, no other
+			 *   conflicting access is left. Therefore, we must
+			 *   consume read1's other_info.
+			 *
+			 * Since this case is assumed to be rare, it is
+			 * reasonable to omit this report: one of the other
+			 * reports includes information about the same shared
+			 * data, and at this point the likelihood that we
+			 * re-report the same race again is high.
+			 */
+			release_report(flags, KCSAN_REPORT_RACE_SIGNAL);
+			return false;
+		}
+
 		/*
 		 * Matching & usable access in other_info: keep other_info_lock
 		 * locked, as this thread consumes it to print the full report;
-- 
2.25.0.225.g125e21ebc7-goog

