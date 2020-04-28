Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16698C83006
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 12:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8DED2072A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 12:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgD1MVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 08:21:18 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:52726 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgD1MVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 08:21:17 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jTPEi-0006os-K2; Tue, 28 Apr 2020 06:21:16 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jTPEh-0001LA-S1; Tue, 28 Apr 2020 06:21:16 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
        <87ftcv1nqe.fsf@x220.int.ebiederm.org>
        <87wo66vvnm.fsf_-_@x220.int.ebiederm.org>
        <20200424173927.GB26802@redhat.com>
        <87mu6ymkea.fsf_-_@x220.int.ebiederm.org>
        <875zdmmj4y.fsf_-_@x220.int.ebiederm.org>
        <CAHk-=whvktUC9VbzWLDw71BHbV4ofkkuAYsrB5Rmxnhc-=kSeQ@mail.gmail.com>
        <878sihgfzh.fsf@x220.int.ebiederm.org>
        <CAHk-=wjSM9mgsDuX=ZTy2L+S7wGrxZMcBn054As_Jyv8FQvcvQ@mail.gmail.com>
        <87sggnajpv.fsf_-_@x220.int.ebiederm.org>
Date:   Tue, 28 Apr 2020 07:18:01 -0500
In-Reply-To: <87sggnajpv.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 28 Apr 2020 07:16:44 -0500")
Message-ID: <87mu6vajnq.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jTPEh-0001LA-S1;;;mid=<87mu6vajnq.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Anr6qsqTLzFB5xXd0dlDeNH9ArfARscA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v4 1/2] rculist: Add hlists_swap_heads_rcu
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Using the struct pid to refer to two tasks in de_thread was a clever
idea and ultimately too clever, as it has lead to proc_flush_task
being called inconsistently.

To support rectifying this add hlists_swap_heads_rcu.  An hlist
primitive that just swaps the hlist heads of two lists.  This is
exactly what is needed for exchanging the pids of two tasks.

Only consideration of correctness of the code has been given,
as the caller is expected to be a slowpath.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/rculist.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index 8214cdc715f2..67867e0d4cec 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -506,6 +506,27 @@ static inline void hlist_replace_rcu(struct hlist_node *old,
 	WRITE_ONCE(old->pprev, LIST_POISON2);
 }
 
+/**
+ * hlists_swap_heads_rcu - swap the lists the hlist heads point to
+ * @left:  The hlist head on the left
+ * @right: The hlist head on the right
+ *
+ * The lists start out as [@left  ][node1 ... ] and
+                          [@right ][node2 ... ]
+ * The lists end up as    [@left  ][node2 ... ]
+ *                        [@right ][node1 ... ]
+ */
+static inline void hlists_swap_heads_rcu(struct hlist_head *left, struct hlist_head *right)
+{
+	struct hlist_node *node1 = left->first;
+	struct hlist_node *node2 = right->first;
+
+	rcu_assign_pointer(left->first, node2);
+	rcu_assign_pointer(right->first, node1);
+	WRITE_ONCE(node2->pprev, &left->first);
+	WRITE_ONCE(node1->pprev, &right->first);
+}
+
 /*
  * return the first or the next element in an RCU protected hlist
  */
-- 
2.20.1

