Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA90C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 10:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D9C3208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 10:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgFLK23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 06:28:29 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40822 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725911AbgFLK21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 06:28:27 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DC2D05EBC751DA91CC57;
        Fri, 12 Jun 2020 18:28:24 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Fri, 12 Jun 2020 18:28:18 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <paul@paul-moore.com>, <edumazet@google.com>,
        <peterz@infradead.org>, <paulmck@kernel.org>,
        <dhowells@redhat.com>, <keescook@chromium.org>,
        <shakeelb@google.com>, <jamorris@linux.microsoft.com>
CC:     <nixiaoming@huawei.com>, <alex.huangjianhui@huawei.com>,
        <dylix.dailei@huawei.com>, <chenzefeng2@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC] cred: Add WARN to detect wrong use of get/put_cred
Date:   Fri, 12 Jun 2020 18:28:15 +0800
Message-ID: <1591957695-118312-1-git-send-email-nixiaoming@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cred release and usage check code flow:
	1. put_cred()
		if (atomic_dec_and_test(&(cred)->usage))
			__put_cred(cred);

	2. __put_cred()
		BUG_ON(atomic_read(&cred->usage) != 0);
		call_rcu(&cred->rcu, put_cred_rcu);

	3. put_cred_rcu()
		if (atomic_read(&cred->usage) != 0)
			panic("CRED: put_cred_rcu() sees %p with usage %d\n",
			       cred, atomic_read(&cred->usage));
		kmem_cache_free(cred_jar, cred);

If panic is triggered on put_cred_rcu(), there are two possibilities
	1. Call get_cred() after __put_cred(), usage > 0
	2. Call put_cred() after __put_cred(), usage < 0
Since put_cred_rcu is an asynchronous behavior, it is no longer the first
scene when panic, there is no information about the murderer in the panic
call stack...

So, add WARN() in get_cred()/put_cred(), and pray to catch the murderer
at the first scene.

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
---
 include/linux/cred.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 18639c0..c00d5a1 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -224,11 +224,16 @@ static inline bool cap_ambient_invariant_ok(const struct cred *cred)
  *
  * Get a reference on the specified set of new credentials.  The caller must
  * release the reference.
+ *
+ * Initialize usage to 1 during cred resource allocation,
+ * so when calling get_cred, usage cannot be 0.
  */
 static inline struct cred *get_new_cred(struct cred *cred)
 {
-	atomic_inc(&cred->usage);
-	return cred;
+	if (atomic_inc_not_zero(&cred->usage))
+		return cred;
+	WARN(1, "get_new_cred after __put_cred");
+	return NULL;
 }
 
 /**
@@ -280,11 +285,14 @@ static inline const struct cred *get_cred_rcu(const struct cred *cred)
 static inline void put_cred(const struct cred *_cred)
 {
 	struct cred *cred = (struct cred *) _cred;
+	int usage;
 
 	if (cred) {
 		validate_creds(cred);
-		if (atomic_dec_and_test(&(cred)->usage))
+		usage = atomic_dec_return(&(cred)->usage);
+		if (usage == 0)
 			__put_cred(cred);
+		WARN(usage < 0, "put_cred after __put_cred");
 	}
 }
 
-- 
1.8.5.6

