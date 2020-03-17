Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA74C5ACD7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC7920738
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="l8YkbChH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgCQR4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:56:53 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38362 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgCQR4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:56:53 -0400
Received: by mail-qt1-f194.google.com with SMTP id e20so18277541qto.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 10:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4WGq4CF/dR8iCUj35XbboYwcU6jq/WMDHaS7e14zUHU=;
        b=l8YkbChHMzRzyWgsYzMiOOaKQwqIBfBczFU/QbsilDui8FS7SvOG+wBcK5QvoH2xUV
         zsY+luGTXUMkvCfYw0krokGbr6uX3EkjAJpALUEVpwCScJqmdk4fS1801CVmf4pQ0Sg+
         q4S2DcEsWuvZkJZnKL+l0GSNrj87Rf2WwAZ0agwI7kli4Q2lZi21DTKHnN/LFXCx3Nt+
         uw1kc1QWxj/pw1xeQrpIc2WEbd57LCNMzNg3x7bZQSYzbCllPFHvLl6bwRn4sCQ5Kukk
         +xKfTx3z3Gkr/czGD+Sjaz3P/dxTuOUZoC//eKBNYJz7tJXvN4JLYod2vKY/Loaee7I+
         K5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4WGq4CF/dR8iCUj35XbboYwcU6jq/WMDHaS7e14zUHU=;
        b=Fi7v6xbvYdvHxMz6v8lL0EdEXm7Dpsy7xquw6/+oP0VGanwhFD8d4FTqgEUW1KaOzd
         4dAF2f66WhB2i1EN6YStNm9DsVoLSsCvgJYu2+Yul9exr+R74V+YLtv0ylbUpHGUOSDi
         oZxUVciV20NwmUWppVLuGCrrKxxijpuHuOkz3+TKb0O4lkSda8kCXjf8us+QVwCFe95U
         pqbSyYkzVLElbtlwhNlMsYoYiwb+PRWe3A+oT9grZFTYrn1y2vmEv9EPcD8OH/mMYF5L
         U0LRbeu7oO5IoH/Ya0K910/MVkG4QTGOcDvFH2BiRR6bXKfGRWk5BAvGQfZSepGlWQL5
         Be4w==
X-Gm-Message-State: ANhLgQ3nEHHnT2uIODWNm893Id6VzVpYsNcyx62bOEzpv9XIMzwNbxyL
        IKai2cafegHuHyv7C9MEZeBmug==
X-Google-Smtp-Source: ADFU+vuKg6hr6xOxDHVZru0yHgshRbjUlraQHnxbwMpRAaCMlvZfgToLAacWGLp4vMhXlyfRL13Ugg==
X-Received: by 2002:ac8:7b39:: with SMTP id l25mr387464qtu.72.1584467811291;
        Tue, 17 Mar 2020 10:56:51 -0700 (PDT)
Received: from ovpn-66-200.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id r6sm2285068qkf.71.2020.03.17.10.56.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Mar 2020 10:56:50 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     jgg@ziepe.ca, paulmck@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] mm/mmu_notifier: silence PROVE_RCU_LIST warnings
Date:   Tue, 17 Mar 2020 13:56:40 -0400
Message-Id: <20200317175640.2047-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is safe to traverse mm->notifier_subscriptions->list either under
SRCU read lock or mm->notifier_subscriptions->lock using
hlist_for_each_entry_rcu(). Silence the PROVE_RCU_LIST false positives,
for example,

 WARNING: suspicious RCU usage
 -----------------------------
 mm/mmu_notifier.c:484 RCU-list traversed in non-reader section!!

 other info that might help us debug this:

 rcu_scheduler_active = 2, debug_locks = 1
 3 locks held by libvirtd/802:
  #0: ffff9321e3f58148 (&mm->mmap_sem#2){++++}, at: do_mprotect_pkey+0xe1/0x3e0
  #1: ffffffff91ae6160 (mmu_notifier_invalidate_range_start){+.+.}, at: change_p4d_range+0x5fa/0x800
  #2: ffffffff91ae6e08 (srcu){....}, at: __mmu_notifier_invalidate_range_start+0x178/0x460

 stack backtrace:
 CPU: 7 PID: 802 Comm: libvirtd Tainted: G          I       5.6.0-rc6-next-20200317+ #2
 Hardware name: HP ProLiant BL460c Gen8, BIOS I31 11/02/2014
 Call Trace:
  dump_stack+0xa4/0xfe
  lockdep_rcu_suspicious+0xeb/0xf5
  __mmu_notifier_invalidate_range_start+0x3ff/0x460
  change_p4d_range+0x746/0x800
  change_protection+0x1df/0x300
  mprotect_fixup+0x245/0x3e0
  do_mprotect_pkey+0x23b/0x3e0
  __x64_sys_mprotect+0x51/0x70
  do_syscall_64+0x91/0xae8
  entry_SYSCALL_64_after_hwframe+0x49/0xb3

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/mmu_notifier.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index ef3973a5d34a..06852b896fa6 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -307,7 +307,8 @@ static void mn_hlist_release(struct mmu_notifier_subscriptions *subscriptions,
 	 * ->release returns.
 	 */
 	id = srcu_read_lock(&srcu);
-	hlist_for_each_entry_rcu(subscription, &subscriptions->list, hlist)
+	hlist_for_each_entry_rcu(subscription, &subscriptions->list, hlist,
+				 srcu_read_lock_held(&srcu))
 		/*
 		 * If ->release runs before mmu_notifier_unregister it must be
 		 * handled, as it's the only way for the driver to flush all
@@ -370,7 +371,8 @@ int __mmu_notifier_clear_flush_young(struct mm_struct *mm,
 
 	id = srcu_read_lock(&srcu);
 	hlist_for_each_entry_rcu(subscription,
-				 &mm->notifier_subscriptions->list, hlist) {
+				 &mm->notifier_subscriptions->list, hlist,
+				 srcu_read_lock_held(&srcu)) {
 		if (subscription->ops->clear_flush_young)
 			young |= subscription->ops->clear_flush_young(
 				subscription, mm, start, end);
@@ -389,7 +391,8 @@ int __mmu_notifier_clear_young(struct mm_struct *mm,
 
 	id = srcu_read_lock(&srcu);
 	hlist_for_each_entry_rcu(subscription,
-				 &mm->notifier_subscriptions->list, hlist) {
+				 &mm->notifier_subscriptions->list, hlist,
+				 srcu_read_lock_held(&srcu)) {
 		if (subscription->ops->clear_young)
 			young |= subscription->ops->clear_young(subscription,
 								mm, start, end);
@@ -407,7 +410,8 @@ int __mmu_notifier_test_young(struct mm_struct *mm,
 
 	id = srcu_read_lock(&srcu);
 	hlist_for_each_entry_rcu(subscription,
-				 &mm->notifier_subscriptions->list, hlist) {
+				 &mm->notifier_subscriptions->list, hlist,
+				 srcu_read_lock_held(&srcu)) {
 		if (subscription->ops->test_young) {
 			young = subscription->ops->test_young(subscription, mm,
 							      address);
@@ -428,7 +432,8 @@ void __mmu_notifier_change_pte(struct mm_struct *mm, unsigned long address,
 
 	id = srcu_read_lock(&srcu);
 	hlist_for_each_entry_rcu(subscription,
-				 &mm->notifier_subscriptions->list, hlist) {
+				 &mm->notifier_subscriptions->list, hlist,
+				 srcu_read_lock_held(&srcu)) {
 		if (subscription->ops->change_pte)
 			subscription->ops->change_pte(subscription, mm, address,
 						      pte);
@@ -476,7 +481,8 @@ static int mn_hlist_invalidate_range_start(
 	int id;
 
 	id = srcu_read_lock(&srcu);
-	hlist_for_each_entry_rcu(subscription, &subscriptions->list, hlist) {
+	hlist_for_each_entry_rcu(subscription, &subscriptions->list, hlist,
+				 srcu_read_lock_held(&srcu)) {
 		const struct mmu_notifier_ops *ops = subscription->ops;
 
 		if (ops->invalidate_range_start) {
@@ -528,7 +534,8 @@ mn_hlist_invalidate_end(struct mmu_notifier_subscriptions *subscriptions,
 	int id;
 
 	id = srcu_read_lock(&srcu);
-	hlist_for_each_entry_rcu(subscription, &subscriptions->list, hlist) {
+	hlist_for_each_entry_rcu(subscription, &subscriptions->list, hlist,
+				 srcu_read_lock_held(&srcu)) {
 		/*
 		 * Call invalidate_range here too to avoid the need for the
 		 * subsystem of having to register an invalidate_range_end
@@ -582,7 +589,8 @@ void __mmu_notifier_invalidate_range(struct mm_struct *mm,
 
 	id = srcu_read_lock(&srcu);
 	hlist_for_each_entry_rcu(subscription,
-				 &mm->notifier_subscriptions->list, hlist) {
+				 &mm->notifier_subscriptions->list, hlist,
+				 srcu_read_lock_held(&srcu)) {
 		if (subscription->ops->invalidate_range)
 			subscription->ops->invalidate_range(subscription, mm,
 							    start, end);
@@ -714,7 +722,8 @@ find_get_mmu_notifier(struct mm_struct *mm, const struct mmu_notifier_ops *ops)
 
 	spin_lock(&mm->notifier_subscriptions->lock);
 	hlist_for_each_entry_rcu(subscription,
-				 &mm->notifier_subscriptions->list, hlist) {
+				 &mm->notifier_subscriptions->list, hlist,
+				 lockdep_is_held(&mm->notifier_subscriptions->lock)) {
 		if (subscription->ops != ops)
 			continue;
 
-- 
2.21.0 (Apple Git-122.2)

