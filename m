Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AEEC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 541A0206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586961866;
	bh=whIc/g6snA4mC0yASCocLrh5mqkEG1560/rJBnBIugM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jhX1QpB9eKTmHOFXKPHBGUIYogUn7RRvIzhDxVblZ/FNad4Kt1mS7AGDF9w1w3yHF
	 L9ZS+Z8utmnDr+kO3qdgITOpSuW/Unz6zqjkaH77ywlXUXuhBqBVgyR+PPwsygFSpq
	 LWc3151GIxJ9igddU59LgFXC4f2Gp6P3eB/ybM/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636783AbgDOOoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:44:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:45454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394040AbgDOOc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:32:58 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C01D21707;
        Wed, 15 Apr 2020 14:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586961171;
        bh=whIc/g6snA4mC0yASCocLrh5mqkEG1560/rJBnBIugM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SbfuPht6vNKQOBXa5+YSjoEn4FTB+aRexUz68eM2lVg33m2m9nSmaV3b9y0vVlA0Q
         cDTnZg5a/ndZXiymvjT4BL3oPiTv5PpVmO+FrQseVT77uvPk3WqqAsFtMxqNQEa0gS
         izHYznx9ThRsNmujiX3RfdHVrzW+kczH7W40mj7w=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOj5t-006kOj-E8; Wed, 15 Apr 2020 16:32:49 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 13/34] docs: filesystems: convert devpts.txt to ReST
Date:   Wed, 15 Apr 2020 16:32:26 +0200
Message-Id: <0144d68b5afc2930b34e62e66120d2c76f897c09.1586960617.git.mchehab+huawei@kernel.org>
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
- Add a document title;
- Some whitespace fixes and new line breaks;
- Mark literal blocks as such;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/admin-guide/sysctl/kernel.rst |  2 +-
 Documentation/filesystems/devpts.rst        | 36 +++++++++++++++++++++
 Documentation/filesystems/devpts.txt        | 26 ---------------
 Documentation/filesystems/index.rst         |  1 +
 4 files changed, 38 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/filesystems/devpts.rst
 delete mode 100644 Documentation/filesystems/devpts.txt

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 39c95c0e13d3..6427cfa6cc91 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -880,7 +880,7 @@ this sysctl interface anymore.
 pty
 ===
 
-See Documentation/filesystems/devpts.txt.
+See Documentation/filesystems/devpts.rst.
 
 
 randomize_va_space
diff --git a/Documentation/filesystems/devpts.rst b/Documentation/filesystems/devpts.rst
new file mode 100644
index 000000000000..a03248ddfb4c
--- /dev/null
+++ b/Documentation/filesystems/devpts.rst
@@ -0,0 +1,36 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================
+The Devpts Filesystem
+=====================
+
+Each mount of the devpts filesystem is now distinct such that ptys
+and their indicies allocated in one mount are independent from ptys
+and their indicies in all other mounts.
+
+All mounts of the devpts filesystem now create a ``/dev/pts/ptmx`` node
+with permissions ``0000``.
+
+To retain backwards compatibility the a ptmx device node (aka any node
+created with ``mknod name c 5 2``) when opened will look for an instance
+of devpts under the name ``pts`` in the same directory as the ptmx device
+node.
+
+As an option instead of placing a ``/dev/ptmx`` device node at ``/dev/ptmx``
+it is possible to place a symlink to ``/dev/pts/ptmx`` at ``/dev/ptmx`` or
+to bind mount ``/dev/ptx/ptmx`` to ``/dev/ptmx``.  If you opt for using
+the devpts filesystem in this manner devpts should be mounted with
+the ``ptmxmode=0666``, or ``chmod 0666 /dev/pts/ptmx`` should be called.
+
+Total count of pty pairs in all instances is limited by sysctls::
+
+    kernel.pty.max = 4096	- global limit
+    kernel.pty.reserve = 1024	- reserved for filesystems mounted from the initial mount namespace
+    kernel.pty.nr		- current count of ptys
+
+Per-instance limit could be set by adding mount option ``max=<count>``.
+
+This feature was added in kernel 3.4 together with
+``sysctl kernel.pty.reserve``.
+
+In kernels older than 3.4 sysctl ``kernel.pty.max`` works as per-instance limit.
diff --git a/Documentation/filesystems/devpts.txt b/Documentation/filesystems/devpts.txt
deleted file mode 100644
index 9f94fe276dea..000000000000
--- a/Documentation/filesystems/devpts.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-Each mount of the devpts filesystem is now distinct such that ptys
-and their indicies allocated in one mount are independent from ptys
-and their indicies in all other mounts.
-
-All mounts of the devpts filesystem now create a /dev/pts/ptmx node
-with permissions 0000.
-
-To retain backwards compatibility the a ptmx device node (aka any node
-created with "mknod name c 5 2") when opened will look for an instance
-of devpts under the name "pts" in the same directory as the ptmx device
-node.
-
-As an option instead of placing a /dev/ptmx device node at /dev/ptmx
-it is possible to place a symlink to /dev/pts/ptmx at /dev/ptmx or
-to bind mount /dev/ptx/ptmx to /dev/ptmx.  If you opt for using
-the devpts filesystem in this manner devpts should be mounted with
-the ptmxmode=0666, or chmod 0666 /dev/pts/ptmx should be called.
-
-Total count of pty pairs in all instances is limited by sysctls:
-kernel.pty.max = 4096		- global limit
-kernel.pty.reserve = 1024	- reserved for filesystems mounted from the initial mount namespace
-kernel.pty.nr			- current count of ptys
-
-Per-instance limit could be set by adding mount option "max=<count>".
-This feature was added in kernel 3.4 together with sysctl kernel.pty.reserve.
-In kernels older than 3.4 sysctl kernel.pty.max works as per-instance limit.
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 8e3ccb4ed483..470b2da2b7b1 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -25,6 +25,7 @@ algorithms work.
    locking
    directory-locking
    dax
+   devpts
 
    automount-support
 
-- 
2.25.2

