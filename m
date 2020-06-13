Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F24C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 19:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C2152074D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 19:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="XNWmcjhn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbgFMTch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 15:32:37 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:57132 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgFMTcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 15:32:35 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 49knmf2Y9Cz9vYkD
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 19:32:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9VCCm4juIrve for <linux-kernel@vger.kernel.org>;
        Sat, 13 Jun 2020 14:32:34 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 49knmf0sW2z9vYkv
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 14:32:34 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 49knmf0sW2z9vYkv
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 49knmf0sW2z9vYkv
Received: by mail-io1-f72.google.com with SMTP id t23so8515909iog.21
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 12:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=pJ20cKcKMnGm3+Riu7jtthOtL7g8EIT2MKkma1MPE6o=;
        b=XNWmcjhnocnx2PCeGekIOa6hmp/5qTxzXhmI/rnG/BdQUSUHtNzIw27S8a5v6/a0D6
         QHdgNQrOk9lqbEto8IVTmS3CbgaZdQCIKp+U8A2/9KOWjxuFB1itO+tJL+4z/o0I0PEu
         nYotRjHX1C7FW4T+5Ctpjbp/BVOqmhuyFsstGn5SB+ycEN9N13+5T5+20alrtR0bLrFa
         W8nGcO6mnr+f3ls1xudYP4uIXiOsTb9hgkK7R4fHPwxAXMajNQUC4isiBInG2sjgpTfJ
         wq288R8VLIDVgeRi7H3GKk2l4u7hD5cr1DYRAIEpPPXVX26pAYfpmg9utXKpYI56LSZ9
         E3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pJ20cKcKMnGm3+Riu7jtthOtL7g8EIT2MKkma1MPE6o=;
        b=srhqNv1Rh3C9nL6UxOhIj7FdJLD93t/gmEK5tU6RjVnLyBDAuuVFJIrMwT+ThjGeSd
         PPNq9yNcar3QU3lg+NmKZFbuWazh+MelExK4lK4olYLWYa0ZY6vYZ1vE32ER3l0/IRzp
         tdWp+Volegaidw6J93JJEvGxxj6b5HSbNIMmwZfwk6vIWo/QCLkjlrTQcu8AMKX5IipL
         SokqnEbHN2n79JVZdT/gYW3dNpGLu35cYmjerCy8l4Y25Y7ttzqRKndvuKfxg5cAOzpd
         H6nb731f4xXOI9zDukHbmX/uGNNH1jPGeWoAHWTvszBBV2k3BpeEGLQuU1bKY8yF8NCa
         7xaA==
X-Gm-Message-State: AOAM5304brq1YDRaCCWegV/Q3F/9v2X0u63fK1py7R4WvzscGusTLZW0
        42T7/GCMIaRwW6ewErHgmAd6AdvMqRt1vZfRZd+u6zN3e5sZ2sTQKHwB1lP0RSAL5izIl+CYfhF
        nbl4WgNtBZUgdm6PjKdRHxbgrPcjU
X-Received: by 2002:a05:6638:dd3:: with SMTP id m19mr14405847jaj.106.1592076753492;
        Sat, 13 Jun 2020 12:32:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNb/Sk7PVT9zM53pVsCho9Wzso9hsmtHF+L1UVP9LJR0pCZeyktih4ZL5JuGWYbfJxALxufQ==
X-Received: by 2002:a05:6638:dd3:: with SMTP id m19mr14405814jaj.106.1592076753173;
        Sat, 13 Jun 2020 12:32:33 -0700 (PDT)
Received: from qiushi.cs.umn.edu ([2607:ea00:101:3c74:4874:45:bcb4:df60])
        by smtp.gmail.com with ESMTPSA id t63sm5383628ill.54.2020.06.13.12.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 12:32:32 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu, Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdkfd: Fix reference count leaks.
Date:   Sat, 13 Jun 2020 14:32:26 -0500
Message-Id: <20200613193226.21531-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

kobject_init_and_add() takes reference even when it fails.
If this function returns an error, kobject_put() must be called to
properly clean up the memory associated with the object.

Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

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

