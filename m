Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6952C55189
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 852C22071E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587488120;
	bh=6P3d7tlTVXktXH1qYOmLWzh/BIfI7nP2c8dcG01RCxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ALPl92/X5pFqfTbWIYXHb56p3RevY+2RLueOqm1l35n+hXez564AOWJh2kEbC/OnZ
	 WUV/t0tblcxcIJd1HwnQmEiKGiWjanUwcMWXluJFjNaaL7sddLnDGCq6Pr6Es4StgV
	 +1PBvqGNx8crRKiZ8y2bmU9JNYAW6DaOzcqDsr74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbgDUQzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:55:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729166AbgDUQyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:54:49 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B30CF21835;
        Tue, 21 Apr 2020 16:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587488084;
        bh=6P3d7tlTVXktXH1qYOmLWzh/BIfI7nP2c8dcG01RCxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bBffsWa8xietF/t8IPBimM9kxpT/HAR6HMIY0d1hmZ8ghpQJxgos2nZQvg+606uf5
         0YZU4FXgHlALBqIP/6cguCf+vx5iwZXjbdxnKGuimBQSJ2wE4uIi3Pfg4Lqn47M+XJ
         EP+6Nk6zg26y58BIKmVOns5LKHcKUSUnuI+WEj50=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jQwAU-00CmFU-Ux; Tue, 21 Apr 2020 18:54:42 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 27/29] docs: filesystems: convert sysfs-tagging.txt to ReST
Date:   Tue, 21 Apr 2020 18:54:38 +0200
Message-Id: <6f0686877612cdd66147c83a3ad339bdaee6d4f8.1587487612.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1587487612.git.mchehab+huawei@kernel.org>
References: <cover.1587487612.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add a SPDX header;
- Adjust document title;
- Some whitespace fixes and new line breaks;
- Mark literal blocks as such;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/index.rst           |  1 +
 .../{sysfs-tagging.txt => sysfs-tagging.rst}  | 22 ++++++++++++-------
 2 files changed, 15 insertions(+), 8 deletions(-)
 rename Documentation/filesystems/{sysfs-tagging.txt => sysfs-tagging.rst} (72%)

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 65719684295e..11852bf3e758 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -35,6 +35,7 @@ algorithms work.
    seq_file
    sharedsubtree
    sysfs-pci
+   sysfs-tagging
 
    automount-support
 
diff --git a/Documentation/filesystems/sysfs-tagging.txt b/Documentation/filesystems/sysfs-tagging.rst
similarity index 72%
rename from Documentation/filesystems/sysfs-tagging.txt
rename to Documentation/filesystems/sysfs-tagging.rst
index c7c8e6438958..8888a05c398e 100644
--- a/Documentation/filesystems/sysfs-tagging.txt
+++ b/Documentation/filesystems/sysfs-tagging.rst
@@ -1,5 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============
 Sysfs tagging
--------------
+=============
 
 (Taken almost verbatim from Eric Biederman's netns tagging patch
 commit msg)
@@ -18,25 +21,28 @@ in the directories and applications only see a limited set of
 the network devices.
 
 Each sysfs directory entry may be tagged with a namespace via the
-void *ns member of its kernfs_node.  If a directory entry is tagged,
-then kernfs_node->flags will have a flag between KOBJ_NS_TYPE_NONE
+``void *ns member`` of its ``kernfs_node``.  If a directory entry is tagged,
+then ``kernfs_node->flags`` will have a flag between KOBJ_NS_TYPE_NONE
 and KOBJ_NS_TYPES, and ns will point to the namespace to which it
 belongs.
 
-Each sysfs superblock's kernfs_super_info contains an array void
-*ns[KOBJ_NS_TYPES].  When a task in a tagging namespace
+Each sysfs superblock's kernfs_super_info contains an array
+``void *ns[KOBJ_NS_TYPES]``.  When a task in a tagging namespace
 kobj_nstype first mounts sysfs, a new superblock is created.  It
 will be differentiated from other sysfs mounts by having its
-s_fs_info->ns[kobj_nstype] set to the new namespace.  Note that
+``s_fs_info->ns[kobj_nstype]`` set to the new namespace.  Note that
 through bind mounting and mounts propagation, a task can easily view
 the contents of other namespaces' sysfs mounts.  Therefore, when a
 namespace exits, it will call kobj_ns_exit() to invalidate any
 kernfs_node->ns pointers pointing to it.
 
 Users of this interface:
-- define a type in the kobj_ns_type enumeration.
-- call kobj_ns_type_register() with its kobj_ns_type_operations which has
+
+- define a type in the ``kobj_ns_type`` enumeration.
+- call kobj_ns_type_register() with its ``kobj_ns_type_operations`` which has
+
   - current_ns() which returns current's namespace
   - netlink_ns() which returns a socket's namespace
   - initial_ns() which returns the initial namesapce
+
 - call kobj_ns_exit() when an individual tag is no longer valid
-- 
2.25.2

