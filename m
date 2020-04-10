Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DBCC2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 16:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9280320769
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 16:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KQyOuVLH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgDJQoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 12:44:37 -0400
Received: from mail-wm1-f73.google.com ([209.85.128.73]:37103 "EHLO
        mail-wm1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgDJQoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 12:44:37 -0400
Received: by mail-wm1-f73.google.com with SMTP id s9so962943wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 09:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jktZwzpJNVLsGLy9KhviNEQJCLl1FlOOKSWLnXPYqxw=;
        b=KQyOuVLHLkjKZehmeDyrA7jlikXp+KWxO6iRaDrvYTjO6piK9fKGV97vEz9I0itX1m
         9JrbqYegnf7uUwph8CEPP7M0i1nSK0vTtIKcPsO22QH7+GZ7VTNzy096xsgLpN667ZGH
         iDPq29x452oxKbLRs8nv9PgJtHaKf4QPQPTb3hIBHgludnXHHZRWJ6zDW9nuUcPWzR0y
         rljIUHuZvNuHZzaA/m5zZeZirYCvi+mw3tUHzVP7HIScnvN5TJtZk2o5KaOG9pLmfqJC
         1chOp5rsSUWQaH0VPoait19ZG8VUSkEkzvkrLPs4RSXCaxqLWpPy3VcZZFgtg5xpiY01
         WNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jktZwzpJNVLsGLy9KhviNEQJCLl1FlOOKSWLnXPYqxw=;
        b=q9vCHoIR57ttBtM2Ijs8DxrIn4I8OhtjxLFvNkk9YhIzR/7VUJCzfWM+wJnX8WBdt+
         98175FtqBaSs6IFBMn48/bvSB5IHB8nZHoPh/7KRsA4FppX7SjIb1vrDMV+Ax+7MN5tH
         SWZlORf/bmuF+DB9Z790TQtg7i9/zhnuCxnle6LLmHd6nLWxE3b5l/TrvhhrymqKp79v
         8K9C/cxUvvaLdVc2Nd9pnDQcA8oNoWwisAJYNo3pdwkcnx9GI5E0eWkmFUGb5Tso8Tvj
         2gRiWII+BIUGOLa696pCEEWJoxr9SPBGkXT4T1cb6B9BoICFkBNZXLjmP4A/V3NtGJdt
         Tifw==
X-Gm-Message-State: AGi0PubzdUWCQhJerwaeiSMLC8AwhO5Bh11ETLHfU1WmLeYImX1/gOQt
        09Xto3AwgYK+E176nO5IVp5Hfllq+w==
X-Google-Smtp-Source: APiQypLjQHtLpkc4mB4CPVsqd36ikxEDet6lXC50WFb/7IvdeK8DNeQ07dh1OGI/I2mCHYvaLQ7LMY168A==
X-Received: by 2002:adf:aad7:: with SMTP id i23mr5391553wrc.184.1586537074302;
 Fri, 10 Apr 2020 09:44:34 -0700 (PDT)
Date:   Fri, 10 Apr 2020 18:44:18 +0200
In-Reply-To: <20200410164418.65808-1-elver@google.com>
Message-Id: <20200410164418.65808-2-elver@google.com>
Mime-Version: 1.0
References: <20200410164418.65808-1-elver@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH 2/2] kcsan: Make reporting aware of KCSAN tests
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reporting hides KCSAN runtime functions in the stack trace, with
filtering done based on function names. Currently this included all
functions (or modules) that would match "kcsan_". Make the filter aware
of KCSAN tests, which contain "kcsan_test", and are no longer skipped in
the report.

This is in preparation for adding a KCSAN test module.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/report.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index cf41d63dd0cd..ac5f8345bae9 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -262,16 +262,32 @@ static const char *get_thread_desc(int task_id)
 static int get_stack_skipnr(const unsigned long stack_entries[], int num_entries)
 {
 	char buf[64];
-	int len;
-	int skip = 0;
+	char *cur;
+	int len, skip;
 
-	for (; skip < num_entries; ++skip) {
+	for (skip = 0; skip < num_entries; ++skip) {
 		len = scnprintf(buf, sizeof(buf), "%ps", (void *)stack_entries[skip]);
-		if (!strnstr(buf, "csan_", len) &&
-		    !strnstr(buf, "tsan_", len) &&
-		    !strnstr(buf, "_once_size", len))
-			break;
+
+		/* Never show tsan_* or {read,write}_once_size. */
+		if (strnstr(buf, "tsan_", len) ||
+		    strnstr(buf, "_once_size", len))
+			continue;
+
+		cur = strnstr(buf, "kcsan_", len);
+		if (cur) {
+			cur += sizeof("kcsan_") - 1;
+			if (strncmp(cur, "test", sizeof("test") - 1))
+				continue; /* KCSAN runtime function. */
+			/* KCSAN related test. */
+		}
+
+		/*
+		 * No match for runtime functions -- @skip entries to skip to
+		 * get to first frame of interest.
+		 */
+		break;
 	}
+
 	return skip;
 }
 
-- 
2.26.0.110.g2183baf09c-goog

