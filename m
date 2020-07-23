Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9488DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C22020714
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbgGWQnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 12:43:23 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50450 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgGWQnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 12:43:23 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 48DA7283BFE
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-kernel@vger.kernel.org, miklos@szeredi.hu,
        mszeredi@redhat.com
Cc:     kernel@collabora.com, linux-fsdevel@vger.kernel.org,
        nikolaus@rath.org,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH] fuse: Update project homepage
Date:   Thu, 23 Jul 2020 13:43:11 -0300
Message-Id: <20200723164311.29169-1-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As stated in https://sourceforge.net/projects/fuse/, "the FUSE project has
moved to https://github.com/libfuse/" in 22-Dec-2015. Update URLs to
reflect this.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 Documentation/filesystems/fuse.rst | 2 +-
 MAINTAINERS                        | 2 +-
 fs/fuse/Kconfig                    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/fuse.rst b/Documentation/filesystems/fuse.rst
index cd717f9bf940..8120c3c0cb4e 100644
--- a/Documentation/filesystems/fuse.rst
+++ b/Documentation/filesystems/fuse.rst
@@ -47,7 +47,7 @@ filesystems.  A good example is sshfs: a secure network filesystem
 using the sftp protocol.
 
 The userspace library and utilities are available from the
-`FUSE homepage: <http://fuse.sourceforge.net/>`_
+`FUSE homepage: <https://github.com/libfuse/>`_
 
 Filesystem type
 ===============
diff --git a/MAINTAINERS b/MAINTAINERS
index 68f21d46614c..068c463bb18f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7086,7 +7086,7 @@ FUSE: FILESYSTEM IN USERSPACE
 M:	Miklos Szeredi <miklos@szeredi.hu>
 L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
-W:	http://fuse.sourceforge.net/
+W:	https://github.com/libfuse/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
 F:	Documentation/filesystems/fuse.rst
 F:	fs/fuse/
diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
index 774b2618018a..0156dc8aa646 100644
--- a/fs/fuse/Kconfig
+++ b/fs/fuse/Kconfig
@@ -8,7 +8,7 @@ config FUSE_FS
 
 	  There's also a companion library: libfuse2.  This library is available
 	  from the FUSE homepage:
-	  <http://fuse.sourceforge.net/>
+	  <https://github.com/libfuse/>
 	  although chances are your distribution already has that library
 	  installed if you've installed the "fuse" package itself.
 
-- 
2.27.0

