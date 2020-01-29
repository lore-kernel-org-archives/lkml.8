Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D6FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 15:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC46E2070E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 15:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QZytvrIW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgA2PBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 10:01:15 -0500
Received: from mail-wr1-f73.google.com ([209.85.221.73]:53918 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgA2PBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 10:01:14 -0500
Received: by mail-wr1-f73.google.com with SMTP id j13so10221576wrr.20
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 07:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=MCBz1zj6EK5lhXzgufWO0flG14sfalDmNzlYHd383TA=;
        b=QZytvrIWRYXmxoGnbla5A2jhMQqKG1hG/eEiCxUSENUkgcU/dnW+6DBhHdJ3L35Bog
         bZAUcrs09f8QXa3y/WJ2q5KA0C2Whmmjue7xl98FOuw/eaJSeEwiEaWxL7+Zv3zmNrgM
         am8Cge9FEPr05hGC3tpTGaiDEvWNVoBpCu1hXMcGDstBomMcBPqA0C9560sv6JdExpuG
         U0+Kxu6Zo30maV5QtTGqAZAHcgfmvqbIMjtUYoS1fHTwpRq7oQWDOCHe8fA0R9XXXAWi
         LGW3BZxAw2AkVNh15so+Z71OjA2S6L40OvJ7D7IGFENSwcN9T0Fo5rvssewZ9pp4F0zV
         1u/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=MCBz1zj6EK5lhXzgufWO0flG14sfalDmNzlYHd383TA=;
        b=jk0WT9naMUdtJcpNrVfxprFVOdEeFQOWmXktOqrzv3eHaShXqQ9ya1iMrTFu6LW7z7
         zCG9sgJSpoB1JiYJAmHZ1nep/kIhKYq6zTzluLIu1nD1d3uKvMT+bW3vbYb/U3/WMtuu
         BnJdYkVkA6GA110Nl8k5CXW/Kl6w9vqRBaopu3z7BhanjC6bvBYX/FPF0yflhLfNDkT8
         QDC/eziqFOGTnH7M4IV9tExom5t4vr6KEku2RIn1a1yKI3qqgpr22FyUMGI8fiXizwRH
         z+RnDxTrfjaX6mnOM1cpK/CaBMxb9BB1xH8qZ421cv388j1NYKxpPLO3oDiyE8GWfXnL
         IXtQ==
X-Gm-Message-State: APjAAAX3zx3XqpC49b7IuNKxyGIDoNKUryvABAIDLpdrjaPZ3lftJxal
        NlEbQXOnVt3/8N7kBPstlKmlxY51nA==
X-Google-Smtp-Source: APXvYqyz4MGMPiOutt2buBwqQFivZYybjLnLfg7X8qoNsv4TMbGhF+yysILPV5sbZ35hGGQeDXF0FaOD5w==
X-Received: by 2002:adf:f54d:: with SMTP id j13mr35917050wrp.19.1580310072038;
 Wed, 29 Jan 2020 07:01:12 -0800 (PST)
Date:   Wed, 29 Jan 2020 16:01:02 +0100
Message-Id: <20200129150102.2122-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH] kcsan: Address missing case with KCSAN_REPORT_VALUE_CHANGE_ONLY
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

With KCSAN_REPORT_VALUE_CHANGE_ONLY, KCSAN has still been able to report
data races between reads and writes, if a watchpoint was set up on the
write. If the write rewrote the same value we'd still have reported the
data race. We now unconditionally skip reporting on this case.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/report.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index 33bdf8b229b5..7cd34285df74 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -130,12 +130,25 @@ static bool rate_limit_report(unsigned long frame1, unsigned long frame2)
  * Special rules to skip reporting.
  */
 static bool
-skip_report(int access_type, bool value_change, unsigned long top_frame)
+skip_report(bool value_change, unsigned long top_frame)
 {
-	const bool is_write = (access_type & KCSAN_ACCESS_WRITE) != 0;
-
-	if (IS_ENABLED(CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY) && is_write &&
-	    !value_change) {
+	/*
+	 * The first call to skip_report always has value_change==true, since we
+	 * cannot know the value written of an instrumented access. For the 2nd
+	 * call there are 6 cases with CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY:
+	 *
+	 * 1. read watchpoint, conflicting write (value_change==true): report;
+	 * 2. read watchpoint, conflicting write (value_change==false): skip;
+	 * 3. write watchpoint, conflicting write (value_change==true): report;
+	 * 4. write watchpoint, conflicting write (value_change==false): skip;
+	 * 5. write watchpoint, conflicting read (value_change==false): skip;
+	 * 6. write watchpoint, conflicting read (value_change==true): impossible;
+	 *
+	 * Cases 1-4 are intuitive and expected; case 5 ensures we do not report
+	 * data races where the write may have rewritten the same value; and
+	 * case 6 is simply impossible.
+	 */
+	if (IS_ENABLED(CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY) && !value_change) {
 		/*
 		 * The access is a write, but the data value did not change.
 		 *
@@ -228,7 +241,7 @@ static bool print_report(const volatile void *ptr, size_t size, int access_type,
 	/*
 	 * Must check report filter rules before starting to print.
 	 */
-	if (skip_report(access_type, true, stack_entries[skipnr]))
+	if (skip_report(true, stack_entries[skipnr]))
 		return false;
 
 	if (type == KCSAN_REPORT_RACE_SIGNAL) {
@@ -237,7 +250,7 @@ static bool print_report(const volatile void *ptr, size_t size, int access_type,
 		other_frame = other_info.stack_entries[other_skipnr];
 
 		/* @value_change is only known for the other thread */
-		if (skip_report(other_info.access_type, value_change, other_frame))
+		if (skip_report(value_change, other_frame))
 			return false;
 	}
 
-- 
2.25.0.341.g760bfbb309-goog

