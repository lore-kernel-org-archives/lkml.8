Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9822BC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 06:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6204E21897
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 06:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgIHG2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 02:28:01 -0400
Received: from mail.windriver.com ([147.11.1.11]:40652 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbgIHG2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 02:28:01 -0400
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 0886ROT5009147
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Mon, 7 Sep 2020 23:27:25 -0700 (PDT)
Received: from pek-qzhang2-d1.wrs.com (128.224.162.183) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Sep 2020 23:27:11 -0700
From:   <qiang.zhang@windriver.com>
To:     <tglx@linutronix.de>, <longman@redhat.com>, <mingo@kernel.org>,
        <elver@google.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] debugobjects: install CPU hotplug callback
Date:   Tue, 8 Sep 2020 14:27:09 +0800
Message-ID: <20200908062709.11441-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

Due to CPU hotplug, it may never be online after it's offline,
some objects in percpu pool is never free. in order to avoid
this happening, install CPU hotplug callback, call this callback
func to free objects in percpu pool when CPU going offline.

Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 v1->v2:
 Modify submission information.

 v2->v3:
 In CPU hotplug callback func, add clear percpu pool "obj_free" operation.
 capitalize 'CPU', and use shorter preprocessor sequence.

 include/linux/cpuhotplug.h |  1 +
 lib/debugobjects.c         | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 3215023d4852..0c39d57e5342 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -36,6 +36,7 @@ enum cpuhp_state {
 	CPUHP_X86_MCE_DEAD,
 	CPUHP_VIRT_NET_DEAD,
 	CPUHP_SLUB_DEAD,
+	CPUHP_DEBUG_OBJ_DEAD,
 	CPUHP_MM_WRITEBACK_DEAD,
 	CPUHP_MM_VMSTAT_DEAD,
 	CPUHP_SOFTIRQ_DEAD,
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index fe4557955d97..bb69a02c3e7b 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 #include <linux/hash.h>
 #include <linux/kmemleak.h>
+#include <linux/cpu.h>
 
 #define ODEBUG_HASH_BITS	14
 #define ODEBUG_HASH_SIZE	(1 << ODEBUG_HASH_BITS)
@@ -433,6 +434,24 @@ static void free_object(struct debug_obj *obj)
 	}
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static int object_cpu_offline(unsigned int cpu)
+{
+	struct debug_percpu_free *percpu_pool;
+	struct hlist_node *tmp;
+	struct debug_obj *obj;
+
+	percpu_pool = per_cpu_ptr(&percpu_obj_pool, cpu);
+	hlist_for_each_entry_safe(obj, tmp, &percpu_pool->free_objs, node) {
+		hlist_del(&obj->node);
+		kmem_cache_free(obj_cache, obj);
+	}
+	percpu_pool->obj_free = 0;
+
+	return 0;
+}
+#endif
+
 /*
  * We run out of memory. That means we probably have tons of objects
  * allocated.
@@ -1367,6 +1386,11 @@ void __init debug_objects_mem_init(void)
 	} else
 		debug_objects_selftest();
 
+#ifdef CONFIG_HOTPLUG_CPU
+	cpuhp_setup_state_nocalls(CPUHP_DEBUG_OBJ_DEAD, "object:offline", NULL,
+					object_cpu_offline);
+#endif
+
 	/*
 	 * Increase the thresholds for allocating and freeing objects
 	 * according to the number of possible CPUs available in the system.
-- 
2.17.1

