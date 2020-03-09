Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A559FC10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8017E20637
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583780775;
	bh=7SMO+qHMIfCp439UGVfZIYbP5J1QdPgRx7yExkcGQJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AAzdwt84YOcbSNqGZn2eNzmRLFdnlL3IWd+13QMM+pCvaeYgq4yj12cteMW6+rG3j
	 5vrOsJTl6ABb8v1KdSfEzKJp7OMIKecyxxEG0VLVtilnycOm7+cHCERaSBYbiF0Y9j
	 /1ORb/9MRObxMnKphSi1wTf4j99W6tcofLJAhhNY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgCITGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:06:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:47590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727468AbgCITEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:04:24 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EDF722B48;
        Mon,  9 Mar 2020 19:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583780663;
        bh=7SMO+qHMIfCp439UGVfZIYbP5J1QdPgRx7yExkcGQJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HeZukTxoLqquxVwq/aztk5W4fmnqh/T+XzNQEBYaqTra1TEYxb0NvitCkxlVVsgyz
         XNsT2jKxVJkfwnOLia3LjnhaCYcfclc1uefxNRUBT3VSVHpmnoX9LWY0Kz3IrkXQE4
         15l71e68LVsqmn/8kZQreJPy7Z4D2vKUoPft8Q2w=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 05/32] kcsan: Address missing case with KCSAN_REPORT_VALUE_CHANGE_ONLY
Date:   Mon,  9 Mar 2020 12:03:53 -0700
Message-Id: <20200309190420.6100-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200309190359.GA5822@paulmck-ThinkPad-P72>
References: <20200309190359.GA5822@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Even with KCSAN_REPORT_VALUE_CHANGE_ONLY, KCSAN still reports data
races between reads and watchpointed writes, even if the writes wrote
values already present.  This commit causes KCSAN to unconditionally
skip reporting in this case.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/report.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index 33bdf8b..7cd3428 100644
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
2.9.5

