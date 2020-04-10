Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9C3C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 16:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9C22078E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 16:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V3JjhjmZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgDJQod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 12:44:33 -0400
Received: from mail-wr1-f74.google.com ([209.85.221.74]:34808 "EHLO
        mail-wr1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgDJQoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 12:44:32 -0400
Received: by mail-wr1-f74.google.com with SMTP id 91so1492942wro.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 09:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ueafPH9nFZnbYCe8pBTsy3DXxC5q7uCEv34zh8QVYcE=;
        b=V3JjhjmZxR2RHOx83Yy9LM/Ff7fyUM4rsteIPOsKRC5ySgn3GXOuW1xShn7CFw3SSK
         O/VXh/3exarcTAjv1/kct8EgSpxHsbQWtnzlmjdwK9ip9KKpH7qEZw4ThTAYZx4Qbtnw
         QwfJ1F6NO2bMjVz4smENn/BeUZ/0S+0Cp63MQZPEhpBTAh0q5piB0NjQ2J31bBdUb2Bo
         ycwe2SzkLlIfkP++3Ymi1+wuZuf/78lrqU1spbW7v74WTKBBFBqc6U8sULIfHoyUD/Mb
         kuZci/1nHfFpDAcXCziIN8r2VlupXCn6JklGoC2w5m1UEjvjgxxwQ/QVO2TtFwLjmv5e
         rdQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ueafPH9nFZnbYCe8pBTsy3DXxC5q7uCEv34zh8QVYcE=;
        b=CAD290zGQC8qac0OYHFpaaYLA03r+hdlPMD/ydf4NxoUvctkrjOKiGxhFg/Rw6bVcl
         ahIwcpotb2NOFnmfAqmp9uj2sbKmMavxueGxkq1fXfTBUyS/49zwFIDcDjIqeZewbRHl
         9Yms4+09aHtsHsyr0UEtQIO60RgK6GdJIg0+hQrJ9KUIr9+kG/0pxlqcU7qqE+k/wiow
         gQrYOADogwej+hKf/Ms1OM09JUJ2wuEIaArNotC1nDx7qyf1Dscb/1geL9q54fNCKpE9
         tvB4cuP0GsYlbPN6QOz3flPYBtSsjWkl6j9w//yYoBmXmPeFdRni7twxjAqbAN8z0zx1
         CuHQ==
X-Gm-Message-State: AGi0PuYPYSYGVm7CNdHfMapc/mSQOhwImKOYdLu/aTxeecoci/lk2wFd
        u549cgXR8ufK9Gv3GZm0fB8Ib/U/+g==
X-Google-Smtp-Source: APiQypJmiZ6mY0njAKvycTCVMyPm5vaYR9C+OrQsqzWrXOLCALq6HLuow6VXeiMVRL7vtCArQ/O8Xjeu+w==
X-Received: by 2002:a5d:4248:: with SMTP id s8mr5315245wrr.216.1586537069409;
 Fri, 10 Apr 2020 09:44:29 -0700 (PDT)
Date:   Fri, 10 Apr 2020 18:44:17 +0200
Message-Id: <20200410164418.65808-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH 1/2] kcsan: Fix function matching in report
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass string length as returned by scnprintf() to strnstr(), since
strnstr() searches exactly len bytes in haystack, even if it contains a
NUL-terminator before haystack+len.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/report.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index ddc18f1224a4..cf41d63dd0cd 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -192,11 +192,11 @@ skip_report(enum kcsan_value_change value_change, unsigned long top_frame)
 		 * maintainers.
 		 */
 		char buf[64];
+		int len = scnprintf(buf, sizeof(buf), "%ps", (void *)top_frame);
 
-		snprintf(buf, sizeof(buf), "%ps", (void *)top_frame);
-		if (!strnstr(buf, "rcu_", sizeof(buf)) &&
-		    !strnstr(buf, "_rcu", sizeof(buf)) &&
-		    !strnstr(buf, "_srcu", sizeof(buf)))
+		if (!strnstr(buf, "rcu_", len) &&
+		    !strnstr(buf, "_rcu", len) &&
+		    !strnstr(buf, "_srcu", len))
 			return true;
 	}
 
@@ -262,15 +262,15 @@ static const char *get_thread_desc(int task_id)
 static int get_stack_skipnr(const unsigned long stack_entries[], int num_entries)
 {
 	char buf[64];
+	int len;
 	int skip = 0;
 
 	for (; skip < num_entries; ++skip) {
-		snprintf(buf, sizeof(buf), "%ps", (void *)stack_entries[skip]);
-		if (!strnstr(buf, "csan_", sizeof(buf)) &&
-		    !strnstr(buf, "tsan_", sizeof(buf)) &&
-		    !strnstr(buf, "_once_size", sizeof(buf))) {
+		len = scnprintf(buf, sizeof(buf), "%ps", (void *)stack_entries[skip]);
+		if (!strnstr(buf, "csan_", len) &&
+		    !strnstr(buf, "tsan_", len) &&
+		    !strnstr(buf, "_once_size", len))
 			break;
-		}
 	}
 	return skip;
 }
-- 
2.26.0.110.g2183baf09c-goog

