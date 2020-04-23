Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DE2C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 11:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1BD42084D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 11:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbgDWL5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 07:57:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:44084 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727804AbgDWL5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 07:57:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3251BAD0F;
        Thu, 23 Apr 2020 11:57:28 +0000 (UTC)
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     akpm@linux-foundation.org, Christoph Lameter <cl@linux.com>
Cc:     Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, mhocko@kernel.org,
        vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] slub: Remove userspace notifier for cache add/remove
Date:   Thu, 23 Apr 2020 13:57:21 +0200
Message-Id: <20200423115721.19821-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Lameter <cl@linux.com>

I came across some unnecessary uevents once again which reminded me
this. The patch seems to be lost in the leaves of the original
discussion [1], so resending.

[1] https://lore.kernel.org/r/alpine.DEB.2.21.2001281813130.745@www.lameter.com

8<---
Kmem caches are internal kernel structures so it is strange that
userspace notifiers would be needed. And I am not aware of any use
of these notifiers. These notifiers may just exist because in the
initial slub release the sysfs code was copied from another
subsystem.

Signed-off-by: Christoph Lameter <cl@linux.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Michal Koutný <mkoutny@suse.com>
---
 mm/slub.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 332d4b459a90..ae6116adf875 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5665,19 +5665,6 @@ static struct kobj_type slab_ktype = {
 	.release = kmem_cache_release,
 };
 
-static int uevent_filter(struct kset *kset, struct kobject *kobj)
-{
-	struct kobj_type *ktype = get_ktype(kobj);
-
-	if (ktype == &slab_ktype)
-		return 1;
-	return 0;
-}
-
-static const struct kset_uevent_ops slab_uevent_ops = {
-	.filter = uevent_filter,
-};
-
 static struct kset *slab_kset;
 
 static inline struct kset *cache_kset(struct kmem_cache *s)
@@ -5745,7 +5732,6 @@ static void sysfs_slab_remove_workfn(struct work_struct *work)
 #ifdef CONFIG_MEMCG
 	kset_unregister(s->memcg_kset);
 #endif
-	kobject_uevent(&s->kobj, KOBJ_REMOVE);
 out:
 	kobject_put(&s->kobj);
 }
@@ -5803,7 +5789,6 @@ static int sysfs_slab_add(struct kmem_cache *s)
 	}
 #endif
 
-	kobject_uevent(&s->kobj, KOBJ_ADD);
 	if (!unmergeable) {
 		/* Setup first alias */
 		sysfs_slab_alias(s, s->name);
@@ -5884,7 +5869,7 @@ static int __init slab_sysfs_init(void)
 
 	mutex_lock(&slab_mutex);
 
-	slab_kset = kset_create_and_add("slab", &slab_uevent_ops, kernel_kobj);
+	slab_kset = kset_create_and_add("slab", NULL, kernel_kobj);
 	if (!slab_kset) {
 		mutex_unlock(&slab_mutex);
 		pr_err("Cannot register slab subsystem.\n");
-- 
2.26.0

