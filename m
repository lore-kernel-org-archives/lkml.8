Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36B0C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 11:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A50B21548
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 11:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732799AbgFSLyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 07:54:55 -0400
Received: from mail-m17613.qiye.163.com ([59.111.176.13]:15258 "EHLO
        mail-m17613.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732343AbgFSLyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 07:54:38 -0400
X-Greylist: delayed 527 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Jun 2020 07:54:36 EDT
Received: from njvxl5505.vivo.xyz (unknown [157.0.31.125])
        by mail-m17613.qiye.163.com (Hmail) with ESMTPA id 7B4494816D2;
        Fri, 19 Jun 2020 19:45:45 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] drm/amd: fix potential memleak in err branch
Date:   Fri, 19 Jun 2020 19:45:33 +0800
Message-Id: <20200619114533.2612-1-bernard@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGkoeGUhKGktCGUNNVkpOQklOTUxKT05MSEhVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NRA6HDo5Czg5HQIuOio9LTUe
        Qz0KChdVSlVKTkJJTk1MSk9NSklPVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSU5ZV1kIAVlBT01JTjcG
X-HM-Tid: 0a72cc6624b093bakuws7b4494816d2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function kobject_init_and_add alloc memory like:
kobject_init_and_add->kobject_add_varg->kobject_set_name_vargs
->kvasprintf_const->kstrdup_const->kstrdup->kmalloc_track_caller
->kmalloc_slab, in err branch this memory not free. If use
kmemleak, this path maybe catched.
These changes are to add kobject_put in kobject_init_and_add
failed branch, fix potential memleak.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c  |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 20 +++++++++++++++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index d27221ddcdeb..5ee4d6cfb16d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -124,6 +124,7 @@ void kfd_procfs_init(void)
 	if (ret) {
 		pr_warn("Could not create procfs proc folder");
 		/* If we fail to create the procfs, clean up */
+		kobject_put(procfs.kobj);
 		kfd_procfs_shutdown();
 	}
 }
@@ -428,6 +429,7 @@ struct kfd_process *kfd_create_process(struct file *filep)
 					   (int)process->lead_thread->pid);
 		if (ret) {
 			pr_warn("Creating procfs pid directory failed");
+			kobject_put(process->kobj);
 			goto out;
 		}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index bb77f7af2b6d..dc3c4149f860 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -632,8 +632,10 @@ static int kfd_build_sysfs_node_entry(struct kfd_topology_device *dev,
 
 	ret = kobject_init_and_add(dev->kobj_node, &node_type,
 			sys_props.kobj_nodes, "%d", id);
-	if (ret < 0)
+	if (ret < 0) {
+		kobject_put(dev->kobj_node);
 		return ret;
+	}
 
 	dev->kobj_mem = kobject_create_and_add("mem_banks", dev->kobj_node);
 	if (!dev->kobj_mem)
@@ -680,8 +682,10 @@ static int kfd_build_sysfs_node_entry(struct kfd_topology_device *dev,
 			return -ENOMEM;
 		ret = kobject_init_and_add(mem->kobj, &mem_type,
 				dev->kobj_mem, "%d", i);
-		if (ret < 0)
+		if (ret < 0) {
+			kobject_put(mem->kobj);
 			return ret;
+		}
 
 		mem->attr.name = "properties";
 		mem->attr.mode = KFD_SYSFS_FILE_MODE;
@@ -699,8 +703,10 @@ static int kfd_build_sysfs_node_entry(struct kfd_topology_device *dev,
 			return -ENOMEM;
 		ret = kobject_init_and_add(cache->kobj, &cache_type,
 				dev->kobj_cache, "%d", i);
-		if (ret < 0)
+		if (ret < 0) {
+			kobject_put(cache->kobj);
 			return ret;
+		}
 
 		cache->attr.name = "properties";
 		cache->attr.mode = KFD_SYSFS_FILE_MODE;
@@ -718,8 +724,10 @@ static int kfd_build_sysfs_node_entry(struct kfd_topology_device *dev,
 			return -ENOMEM;
 		ret = kobject_init_and_add(iolink->kobj, &iolink_type,
 				dev->kobj_iolink, "%d", i);
-		if (ret < 0)
+		if (ret < 0) {
+			kobject_put(iolink->kobj);
 			return ret;
+		}
 
 		iolink->attr.name = "properties";
 		iolink->attr.mode = KFD_SYSFS_FILE_MODE;
@@ -798,8 +806,10 @@ static int kfd_topology_update_sysfs(void)
 		ret = kobject_init_and_add(sys_props.kobj_topology,
 				&sysprops_type,  &kfd_device->kobj,
 				"topology");
-		if (ret < 0)
+		if (ret < 0) {
+			kobject_put(sys_props.kobj_topology);
 			return ret;
+		}
 
 		sys_props.kobj_nodes = kobject_create_and_add("nodes",
 				sys_props.kobj_topology);
-- 
2.17.1

