Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70B7C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 03:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86F9620720
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 03:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgHaDL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 23:11:28 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:46547 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727828AbgHaDLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 23:11:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U7J4Kfq_1598843469;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U7J4Kfq_1598843469)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 31 Aug 2020 11:11:09 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH 5/6] ftrace: replace do_for_each_ftrace_rec() with for_ftrace_rec_iter()
Date:   Mon, 31 Aug 2020 11:11:03 +0800
Message-Id: <20200831031104.23322-6-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200831031104.23322-1-richard.weiyang@linux.alibaba.com>
References: <20200831031104.23322-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we have two similar infrastructure to iterate ftrace_page and
dyn_ftrace:

  * do_for_each_ftrace_rec()
  * for_ftrace_rec_iter()

The 2nd one, for_ftrace_rec_iter(), looks more generic, so preserve it
and replace do_for_each_ftrace_rec() with it.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 kernel/trace/ftrace.c | 94 ++++++++++++++++++++-----------------------
 1 file changed, 44 insertions(+), 50 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 15fcfa16895d..4def668f45ba 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1501,21 +1501,6 @@ ftrace_ops_test(struct ftrace_ops *ops, unsigned long ip, void *regs)
 	return ret;
 }
 
-/*
- * This is a double for. Do not use 'break' to break out of the loop,
- * you must use a goto.
- */
-#define do_for_each_ftrace_rec(pg, rec)					\
-	for (pg = ftrace_pages_start; pg; pg = pg->next) {		\
-		int _____i;						\
-		for (_____i = 0; _____i < pg->index; _____i++) {	\
-			rec = &pg->records[_____i];
-
-#define while_for_each_ftrace_rec()		\
-		}				\
-	}
-
-
 static int ftrace_cmp_recs(const void *a, const void *b)
 {
 	const struct dyn_ftrace *key = a;
@@ -1638,7 +1623,7 @@ static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
 {
 	struct ftrace_hash *hash;
 	struct ftrace_hash *other_hash;
-	struct ftrace_page *pg;
+	struct ftrace_rec_iter *iter;
 	struct dyn_ftrace *rec;
 	bool update = false;
 	int count = 0;
@@ -1676,11 +1661,13 @@ static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
 			return false;
 	}
 
-	do_for_each_ftrace_rec(pg, rec) {
+	for_ftrace_rec_iter(iter) {
 		int in_other_hash = 0;
 		int in_hash = 0;
 		int match = 0;
 
+		rec = ftrace_rec_iter_record(iter);
+
 		if (rec->flags & FTRACE_FL_DISABLED)
 			continue;
 
@@ -1797,7 +1784,7 @@ static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
 		/* Shortcut, if we handled all records, we are done. */
 		if (!all && count == hash->count)
 			return update;
-	} while_for_each_ftrace_rec();
+	}
 
 	return update;
 }
@@ -1862,7 +1849,7 @@ static int __ftrace_hash_update_ipmodify(struct ftrace_ops *ops,
 					 struct ftrace_hash *old_hash,
 					 struct ftrace_hash *new_hash)
 {
-	struct ftrace_page *pg;
+	struct ftrace_rec_iter *iter;
 	struct dyn_ftrace *rec, *end = NULL;
 	int in_old, in_new;
 
@@ -1881,7 +1868,8 @@ static int __ftrace_hash_update_ipmodify(struct ftrace_ops *ops,
 		return -EINVAL;
 
 	/* Update rec->flags */
-	do_for_each_ftrace_rec(pg, rec) {
+	for_ftrace_rec_iter(iter) {
+		rec = ftrace_rec_iter_record(iter);
 
 		if (rec->flags & FTRACE_FL_DISABLED)
 			continue;
@@ -1899,7 +1887,7 @@ static int __ftrace_hash_update_ipmodify(struct ftrace_ops *ops,
 			rec->flags |= FTRACE_FL_IPMODIFY;
 		} else /* Removed entry */
 			rec->flags &= ~FTRACE_FL_IPMODIFY;
-	} while_for_each_ftrace_rec();
+	}
 
 	return 0;
 
@@ -1907,7 +1895,8 @@ static int __ftrace_hash_update_ipmodify(struct ftrace_ops *ops,
 	end = rec;
 
 	/* Roll back what we did above */
-	do_for_each_ftrace_rec(pg, rec) {
+	for_ftrace_rec_iter(iter) {
+		rec = ftrace_rec_iter_record(iter);
 
 		if (rec->flags & FTRACE_FL_DISABLED)
 			continue;
@@ -1924,7 +1913,7 @@ static int __ftrace_hash_update_ipmodify(struct ftrace_ops *ops,
 			rec->flags &= ~FTRACE_FL_IPMODIFY;
 		else
 			rec->flags |= FTRACE_FL_IPMODIFY;
-	} while_for_each_ftrace_rec();
+	}
 
 err_out:
 	return -EBUSY;
@@ -2517,8 +2506,8 @@ __ftrace_replace_code(struct dyn_ftrace *rec, bool enable)
 
 void __weak ftrace_replace_code(int mod_flags)
 {
+	struct ftrace_rec_iter *iter;
 	struct dyn_ftrace *rec;
-	struct ftrace_page *pg;
 	bool enable = mod_flags & FTRACE_MODIFY_ENABLE_FL;
 	int schedulable = mod_flags & FTRACE_MODIFY_MAY_SLEEP_FL;
 	int failed;
@@ -2526,7 +2515,8 @@ void __weak ftrace_replace_code(int mod_flags)
 	if (unlikely(ftrace_disabled))
 		return;
 
-	do_for_each_ftrace_rec(pg, rec) {
+	for_ftrace_rec_iter(iter) {
+		rec = ftrace_rec_iter_record(iter);
 
 		if (rec->flags & FTRACE_FL_DISABLED)
 			continue;
@@ -2539,7 +2529,7 @@ void __weak ftrace_replace_code(int mod_flags)
 		}
 		if (schedulable)
 			cond_resched();
-	} while_for_each_ftrace_rec();
+	}
 }
 
 struct ftrace_rec_iter {
@@ -2940,14 +2930,15 @@ int ftrace_shutdown(struct ftrace_ops *ops, int command)
 	 */
 	if (rcu_dereference_protected(ftrace_ops_list,
 			lockdep_is_held(&ftrace_lock)) == &ftrace_list_end) {
-		struct ftrace_page *pg;
+		struct ftrace_rec_iter *iter;
 		struct dyn_ftrace *rec;
 
-		do_for_each_ftrace_rec(pg, rec) {
+		for_ftrace_rec_iter(iter) {
+			rec = ftrace_rec_iter_record(iter);
 			if (FTRACE_WARN_ON_ONCE(rec->flags & ~FTRACE_FL_DISABLED))
 				pr_warn("  %pS flags:%lx\n",
 					(void *)rec->ip, rec->flags);
-		} while_for_each_ftrace_rec();
+		}
 	}
 
 	ops->old_hash.filter_hash = NULL;
@@ -3917,6 +3908,7 @@ add_rec_by_index(struct ftrace_hash *hash, struct ftrace_glob *func_g,
 		 int clear_filter)
 {
 	long index = simple_strtoul(func_g->search, NULL, 0);
+	struct ftrace_rec_iter *iter;
 	struct ftrace_page *pg;
 	struct dyn_ftrace *rec;
 
@@ -3924,16 +3916,17 @@ add_rec_by_index(struct ftrace_hash *hash, struct ftrace_glob *func_g,
 	if (--index < 0)
 		return 0;
 
-	do_for_each_ftrace_rec(pg, rec) {
+	for_ftrace_rec_iter(iter) {
+		pg = iter->pg;
 		if (pg->index <= index) {
+			iter->index = pg->index;
 			index -= pg->index;
-			/* this is a double loop, break goes to the next page */
-			break;
+			continue;
 		}
 		rec = &pg->records[index];
 		enter_record(hash, rec, clear_filter);
 		return 1;
-	} while_for_each_ftrace_rec();
+	}
 	return 0;
 }
 
@@ -3978,7 +3971,7 @@ ftrace_match_record(struct dyn_ftrace *rec, struct ftrace_glob *func_g,
 static int
 match_records(struct ftrace_hash *hash, char *func, int len, char *mod)
 {
-	struct ftrace_page *pg;
+	struct ftrace_rec_iter *iter;
 	struct dyn_ftrace *rec;
 	struct ftrace_glob func_g = { .type = MATCH_FULL };
 	struct ftrace_glob mod_g = { .type = MATCH_FULL };
@@ -4010,7 +4003,8 @@ match_records(struct ftrace_hash *hash, char *func, int len, char *mod)
 		goto out_unlock;
 	}
 
-	do_for_each_ftrace_rec(pg, rec) {
+	for_ftrace_rec_iter(iter) {
+		rec = ftrace_rec_iter_record(iter);
 
 		if (rec->flags & FTRACE_FL_DISABLED)
 			continue;
@@ -4023,7 +4017,7 @@ match_records(struct ftrace_hash *hash, char *func, int len, char *mod)
 			}
 			found = 1;
 		}
-	} while_for_each_ftrace_rec();
+	}
  out_unlock:
 	mutex_unlock(&ftrace_lock);
 
@@ -5945,7 +5939,7 @@ ftrace_graph_set_hash(struct ftrace_hash *hash, char *buffer)
 {
 	struct ftrace_glob func_g;
 	struct dyn_ftrace *rec;
-	struct ftrace_page *pg;
+	struct ftrace_rec_iter *iter;
 	struct ftrace_func_entry *entry;
 	int fail = 1;
 	int not;
@@ -5963,7 +5957,8 @@ ftrace_graph_set_hash(struct ftrace_hash *hash, char *buffer)
 		return -ENODEV;
 	}
 
-	do_for_each_ftrace_rec(pg, rec) {
+	for_ftrace_rec_iter(iter) {
+		rec = ftrace_rec_iter_record(iter);
 
 		if (rec->flags & FTRACE_FL_DISABLED)
 			continue;
@@ -5985,7 +5980,7 @@ ftrace_graph_set_hash(struct ftrace_hash *hash, char *buffer)
 				}
 			}
 		}
-	} while_for_each_ftrace_rec();
+	}
 out:
 	mutex_unlock(&ftrace_lock);
 
@@ -6407,7 +6402,7 @@ void ftrace_release_mod(struct module *mod)
 void ftrace_module_enable(struct module *mod)
 {
 	struct dyn_ftrace *rec;
-	struct ftrace_page *pg;
+	struct ftrace_rec_iter *iter;
 
 	mutex_lock(&ftrace_lock);
 
@@ -6430,17 +6425,16 @@ void ftrace_module_enable(struct module *mod)
 	if (ftrace_start_up)
 		ftrace_arch_code_modify_prepare();
 
-	do_for_each_ftrace_rec(pg, rec) {
+	for_ftrace_rec_iter(iter) {
 		int cnt;
-		/*
-		 * do_for_each_ftrace_rec() is a double loop.
-		 * module text shares the pg. If a record is
-		 * not part of this module, then skip this pg,
-		 * which the "break" will do.
-		 */
+		rec = ftrace_rec_iter_record(iter);
+
 		if (!within_module_core(rec->ip, mod) &&
-		    !within_module_init(rec->ip, mod))
-			break;
+		    !within_module_init(rec->ip, mod)) {
+			/* skip current ftrace_page */
+			iter->index = iter->pg->index;
+			continue;
+		}
 
 		cnt = 0;
 
@@ -6464,7 +6458,7 @@ void ftrace_module_enable(struct module *mod)
 			}
 		}
 
-	} while_for_each_ftrace_rec();
+	}
 
  out_loop:
 	if (ftrace_start_up)
-- 
2.20.1 (Apple Git-117)

