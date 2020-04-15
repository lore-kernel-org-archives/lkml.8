Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E43C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27EDF208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586961472;
	bh=RbyX6clEe1Kk8Vn80HHEN4SUoKWE9yfaoFqHwqbb8tI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tucF+4zPNq36PmjennPpUH9lmZuASfvY1iAnJzyTtRa0WB8xxE0u9ozwlUvM1BOp+
	 5Tq0eSmrkqpoaUgPrhFmqEKF8Qm2onUnU//oAvVFSW6RYq6NnNpnvAhX/rkeuMmnYV
	 MTfIE5QU5IewzP79yhJIPKfXj31IQcEx/1dOaizE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636636AbgDOOhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:37:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:45890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394091AbgDOOdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:33:05 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7E55221F5;
        Wed, 15 Apr 2020 14:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586961172;
        bh=RbyX6clEe1Kk8Vn80HHEN4SUoKWE9yfaoFqHwqbb8tI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wqm64SBNcgWvyPSOxDG7TujVEwLrOOcP7/4iw2H7CFPUwAn/31WThuh8/6OIlqhmp
         qSqoJKj9fZ8AlrjdBOX89+iLSpctC9H1EAqUo2+F2lFVmhjx8aiQHYRTI80hRxGzSt
         nz0N5Ye78DRnYNzm68+c09w/rzA/kCYQjuD1UzCU=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOj5u-006kQF-6f; Wed, 15 Apr 2020 16:32:50 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 32/34] docs: filesystems: convert sysfs-tagging.txt to ReST
Date:   Wed, 15 Apr 2020 16:32:45 +0200
Message-Id: <73189273bad97f990d0cc08de81f8b7530e961a6.1586960617.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586960617.git.mchehab+huawei@kernel.org>
References: <cover.1586960617.git.mchehab+huawei@kernel.org>
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
index 34d5f53931e7..687fe64d8b5c 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -37,6 +37,7 @@ algorithms work.
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

