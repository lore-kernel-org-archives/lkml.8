Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC25BC32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9808D214DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392063AbgAXLkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:40:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:50850 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392056AbgAXLke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:40:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E4D27AD5B;
        Fri, 24 Jan 2020 11:40:32 +0000 (UTC)
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org
Cc:     alex.shi@linux.alibaba.com, guro@fb.com, hannes@cmpxchg.org,
        kernel-team@android.com, linger.lee@mediatek.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-mediatek@lists.infradead.org, lizefan@huawei.com,
        matthias.bgg@gmail.com, shuah@kernel.org, surenb@google.com,
        tj@kernel.org, tomcherry@google.com
Subject: [PATCH v2 2/3] cgroup: Clean up css_set task traversal
Date:   Fri, 24 Jan 2020 12:40:16 +0100
Message-Id: <20200124114017.8363-3-mkoutny@suse.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124114017.8363-1-mkoutny@suse.com>
References: <20200120145635.GA30904@blackbody.suse.cz>
 <20200124114017.8363-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

css_task_iter stores pointer to head of each iterable list, this dates
back to commit 0f0a2b4fa621 ("cgroup: reorganize css_task_iter") when we
did not store cur_cset. Let us utilize list heads directly in cur_cset
and streamline css_task_iter_advance_css_set a bit. This is no
intentional function change.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 include/linux/cgroup.h |  3 ---
 kernel/cgroup/cgroup.c | 61 +++++++++++++++++++-----------------------
 2 files changed, 28 insertions(+), 36 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index e75d2191226b..f1219b927817 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -58,9 +58,6 @@ struct css_task_iter {
 	struct list_head		*tcset_head;
 
 	struct list_head		*task_pos;
-	struct list_head		*tasks_head;
-	struct list_head		*mg_tasks_head;
-	struct list_head		*dying_tasks_head;
 
 	struct list_head		*cur_tasks_head;
 	struct css_set			*cur_cset;
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index a6e3619e013b..14e0e360a2b4 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4395,29 +4395,24 @@ static void css_task_iter_advance_css_set(struct css_task_iter *it)
 
 	lockdep_assert_held(&css_set_lock);
 
-	/* Advance to the next non-empty css_set */
-	do {
-		cset = css_task_iter_next_css_set(it);
-		if (!cset) {
-			it->task_pos = NULL;
-			return;
+	/* Advance to the next non-empty css_set and find first non-empty tasks list*/
+	while ((cset = css_task_iter_next_css_set(it))) {
+		if (!list_empty(&cset->tasks)) {
+			it->cur_tasks_head = &cset->tasks;
+			break;
+		} else if (!list_empty(&cset->mg_tasks)) {
+			it->cur_tasks_head = &cset->mg_tasks;
+			break;
+		} else if (!list_empty(&cset->dying_tasks)) {
+			it->cur_tasks_head = &cset->dying_tasks;
+			break;
 		}
-	} while (!css_set_populated(cset) && list_empty(&cset->dying_tasks));
-
-	if (!list_empty(&cset->tasks)) {
-		it->task_pos = cset->tasks.next;
-		it->cur_tasks_head = &cset->tasks;
-	} else if (!list_empty(&cset->mg_tasks)) {
-		it->task_pos = cset->mg_tasks.next;
-		it->cur_tasks_head = &cset->mg_tasks;
-	} else {
-		it->task_pos = cset->dying_tasks.next;
-		it->cur_tasks_head = &cset->dying_tasks;
 	}
-
-	it->tasks_head = &cset->tasks;
-	it->mg_tasks_head = &cset->mg_tasks;
-	it->dying_tasks_head = &cset->dying_tasks;
+	if (!cset) {
+		it->task_pos = NULL;
+		return;
+	}
+	it->task_pos = it->cur_tasks_head->next;
 
 	/*
 	 * We don't keep css_sets locked across iteration steps and thus
@@ -4462,24 +4457,24 @@ static void css_task_iter_advance(struct css_task_iter *it)
 repeat:
 	if (it->task_pos) {
 		/*
-		 * Advance iterator to find next entry.  cset->tasks is
-		 * consumed first and then ->mg_tasks.  After ->mg_tasks,
-		 * we move onto the next cset.
+		 * Advance iterator to find next entry. We go through cset
+		 * tasks, mg_tasks and dying_tasks, when consumed we move onto
+		 * the next cset.
 		 */
 		if (it->flags & CSS_TASK_ITER_SKIPPED)
 			it->flags &= ~CSS_TASK_ITER_SKIPPED;
 		else
 			it->task_pos = it->task_pos->next;
 
-		if (it->task_pos == it->tasks_head) {
-			it->task_pos = it->mg_tasks_head->next;
-			it->cur_tasks_head = it->mg_tasks_head;
+		if (it->task_pos == &it->cur_cset->tasks) {
+			it->cur_tasks_head = &it->cur_cset->mg_tasks;
+			it->task_pos = it->cur_tasks_head->next;
 		}
-		if (it->task_pos == it->mg_tasks_head) {
-			it->task_pos = it->dying_tasks_head->next;
-			it->cur_tasks_head = it->dying_tasks_head;
+		if (it->task_pos == &it->cur_cset->mg_tasks) {
+			it->cur_tasks_head = &it->cur_cset->dying_tasks;
+			it->task_pos = it->cur_tasks_head->next;
 		}
-		if (it->task_pos == it->dying_tasks_head)
+		if (it->task_pos == &it->cur_cset->dying_tasks)
 			css_task_iter_advance_css_set(it);
 	} else {
 		/* called from start, proceed to the first cset */
@@ -4497,12 +4492,12 @@ static void css_task_iter_advance(struct css_task_iter *it)
 			goto repeat;
 
 		/* and dying leaders w/o live member threads */
-		if (it->cur_tasks_head == it->dying_tasks_head &&
+		if (it->cur_tasks_head == &it->cur_cset->dying_tasks &&
 		    !atomic_read(&task->signal->live))
 			goto repeat;
 	} else {
 		/* skip all dying ones */
-		if (it->cur_tasks_head == it->dying_tasks_head)
+		if (it->cur_tasks_head == &it->cur_cset->dying_tasks)
 			goto repeat;
 	}
 }
-- 
2.24.1

