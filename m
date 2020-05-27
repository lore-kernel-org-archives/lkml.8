Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A61C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FD332073B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="cO0BH8ko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387671AbgE0UKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 16:10:16 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:38360 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387629AbgE0UKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 16:10:13 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 49XMPw2mpyz9vZ2R
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 20:10:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id S72-_PqyCzUr for <linux-kernel@vger.kernel.org>;
        Wed, 27 May 2020 15:10:12 -0500 (CDT)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 49XMPw138jz9vK0r
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 15:10:12 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 49XMPw138jz9vK0r
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 49XMPw138jz9vK0r
Received: by mail-io1-f71.google.com with SMTP id t23so17771753iog.21
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 13:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hPSY+Zh0t1rGNkSqJtjBbGWhpyEB+X/pF0E6TThgwhg=;
        b=cO0BH8ko43bkOPatdOWMTW1FAm4WGWEPap0aloF2Ov8I0nG59A/3qh6AZfb6yAbZZO
         WAhNKKNK7gSl5i+QdplLfll1L86UVGr2JjcN3cCuvjtM4R1WxDbhalnYCwNgAdRyz5pR
         gYgtyRBZD+g5y6bZ/jB0XJ+eePjHUzxTXtJ8zt8lnJwfL9WqejH+dysiC2m3vWxz0qIU
         5nQrWV7T5cxzaojhGzAJaNCP3VPFY8xJInVRdfzCR+MaWpnpTT3X+w0EwAsjWp/q6kjl
         XGbnFX8oRUWA22jCtYpUo772KJpqFPyEjNrgn1OTYXUggTnMtWI0arlJAKaeejZwEVHO
         OJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hPSY+Zh0t1rGNkSqJtjBbGWhpyEB+X/pF0E6TThgwhg=;
        b=NmOFRPJ+l1W6Xf9oEJcZhhhKv8FBb3Vk/40y5Wi2mm6TTLVd0ePNV4cZmRvwvzFYO6
         l4X6/tyz9SzzDLNXWCPJVyYmSE6wPWsZaPalH1/HBGaBLyUZAe5+z7BTv4Gm+XTUbQ02
         F//MGINyT9GUXeBwNLuMv2g2Gm+gl/wgIGnNvdS8VZx92OTdhi+112ZwUctErmTjc7Bp
         XJwXL7pbQHncJkdTqlPoGzFxT93Y3+ccWEj7Uc4+MydDzJD8xIiZ63wYqwckRcl7tpey
         7vFWTk2nHbudOgB+1jBwxHvlXrjPN817uY7TLYOH3/hvGpETaJ7921EFG9zUZs+26por
         yGkQ==
X-Gm-Message-State: AOAM531Dxe31Z0OKwcTYS5MrWdUpVrAVwERNMjKSp+0kirC1VdOuQQyf
        9Jut7/bLRquugImHMKoSPAX2qx0191yDGXCh21MkujDGVu1jipLusiP0XrM9+5R8gw2i3maXhu5
        izqWw8qAo2U7O+PWpw9L4cLDnBQyC
X-Received: by 2002:a6b:7b4a:: with SMTP id m10mr8477805iop.55.1590610211694;
        Wed, 27 May 2020 13:10:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxuhrc7NDsfRK/mm7gpFg9DSuH5ZtlqPdBbXWHpT2UnfIHxGwqhPUuTPCAJzX65HWUIdG9W/A==
X-Received: by 2002:a6b:7b4a:: with SMTP id m10mr8477782iop.55.1590610211353;
        Wed, 27 May 2020 13:10:11 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id y11sm2020565ily.22.2020.05.27.13.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 13:10:10 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu, Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Vyacheslav Dubeyko <Vyacheslav.Dubeyko@hgst.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nilfs2: Fix reference count leak in nilfs_sysfs_create_device_group
Date:   Wed, 27 May 2020 15:09:33 -0500
Message-Id: <20200527200933.31135-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

kobject_init_and_add() takes reference even when it fails.
In nilfs_sysfs_create_device_group(), the memory allocated by
kobject_init_and_add() is not freed when kobject_init_and_add()
fails. Thus replace the jump target "free_dev_subgroups" by
"cleanup_dev_kobject".

Fixes: da7141fb78db ("nilfs2: add /sys/fs/nilfs2/<device> group")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 fs/nilfs2/sysfs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/nilfs2/sysfs.c b/fs/nilfs2/sysfs.c
index e60be7bb55b0..4a74756d52fe 100644
--- a/fs/nilfs2/sysfs.c
+++ b/fs/nilfs2/sysfs.c
@@ -1000,7 +1000,7 @@ int nilfs_sysfs_create_device_group(struct super_block *sb)
 	err = kobject_init_and_add(&nilfs->ns_dev_kobj, &nilfs_dev_ktype, NULL,
 				    "%s", sb->s_id);
 	if (err)
-		goto free_dev_subgroups;
+		goto cleanup_dev_kobject;
 
 	err = nilfs_sysfs_create_mounted_snapshots_group(nilfs);
 	if (err)
@@ -1038,8 +1038,6 @@ int nilfs_sysfs_create_device_group(struct super_block *sb)
 
 cleanup_dev_kobject:
 	kobject_del(&nilfs->ns_dev_kobj);
-
-free_dev_subgroups:
 	kfree(nilfs->ns_dev_subgroups);
 
 failed_create_device_group:
-- 
2.17.1

