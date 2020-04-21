Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE28C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE2272070B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587488180;
	bh=li9M5Mt1eWOEw3qJYSXZWdFD0JuizqN8a+ReSeFY7Ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e5YviecAnBrZcOgeFh/yvxb4yxHwyHJX09FywCO3Q4wGNEJYeL1C24PpYA8rjKuIG
	 sUauQmpwKqMBbqdS5JF27p9/EhpWi164s43nxYYVv/p9fztyR5scS22XubvwDT22ZX
	 T3v6y9C7vL7VSz392/AbbT0AvRhQ1e/Dhmy+8B7U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbgDUQ4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:56:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729040AbgDUQyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:54:46 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FFFA2076C;
        Tue, 21 Apr 2020 16:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587488084;
        bh=li9M5Mt1eWOEw3qJYSXZWdFD0JuizqN8a+ReSeFY7Ew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sLx3NN1ULklZfupIlZtXm/xGMzj8EqmK9OxVXVNEV8k8T1xQGyomo5ux+Rqhe5vyv
         FWiipv6g/lseb76qiDs/fbIDzv90yhjswiDFbQmevPGfucT4MBXVhO8TC01LbBLSfC
         7nrssqASQrtkqmmXlZ3x3G1km7RUgAYNuXMjM0b8=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jQwAU-00CmEH-Ek; Tue, 21 Apr 2020 18:54:42 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 12/29] docs: filesystems: convert dnotify.txt to ReST
Date:   Tue, 21 Apr 2020 18:54:23 +0200
Message-Id: <63bf7009a782fccc0faf45f786550cb1d171a100.1587487612.git.mchehab+huawei@kernel.org>
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
- Add a document title;
- Some whitespace fixes and new line breaks;
- Add table markups;
- Add it to filesystems/index.rst

Acked-by: Jan Kara <jack@suse.cz>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../filesystems/{dnotify.txt => dnotify.rst}          | 11 ++++++++---
 Documentation/filesystems/index.rst                   |  1 +
 MAINTAINERS                                           |  2 +-
 3 files changed, 10 insertions(+), 4 deletions(-)
 rename Documentation/filesystems/{dnotify.txt => dnotify.rst} (90%)

diff --git a/Documentation/filesystems/dnotify.txt b/Documentation/filesystems/dnotify.rst
similarity index 90%
rename from Documentation/filesystems/dnotify.txt
rename to Documentation/filesystems/dnotify.rst
index 08d575ece45d..a28a1f9ef79c 100644
--- a/Documentation/filesystems/dnotify.txt
+++ b/Documentation/filesystems/dnotify.rst
@@ -1,5 +1,8 @@
-		Linux Directory Notification
-		============================
+.. SPDX-License-Identifier: GPL-2.0
+
+============================
+Linux Directory Notification
+============================
 
 	   Stephen Rothwell <sfr@canb.auug.org.au>
 
@@ -12,6 +15,7 @@ being delivered using signals.
 The application decides which "events" it wants to be notified about.
 The currently defined events are:
 
+	=========	=====================================================
 	DN_ACCESS	A file in the directory was accessed (read)
 	DN_MODIFY	A file in the directory was modified (write,truncate)
 	DN_CREATE	A file was created in the directory
@@ -19,6 +23,7 @@ The currently defined events are:
 	DN_RENAME	A file in the directory was renamed
 	DN_ATTRIB	A file in the directory had its attributes
 			changed (chmod,chown)
+	=========	=====================================================
 
 Usually, the application must reregister after each notification, but
 if DN_MULTISHOT is or'ed with the event mask, then the registration will
@@ -36,7 +41,7 @@ especially important if DN_MULTISHOT is specified.  Note that SIGRTMIN
 is often blocked, so it is better to use (at least) SIGRTMIN + 1.
 
 Implementation expectations (features and bugs :-))
----------------------------
+---------------------------------------------------
 
 The notification should work for any local access to files even if the
 actual file system is on a remote server.  This implies that remote
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 14179987bd4b..be47953cce00 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -25,6 +25,7 @@ algorithms work.
    locking
    directory-locking
    devpts
+   dnotify
 
    automount-support
 
diff --git a/MAINTAINERS b/MAINTAINERS
index d7b40cce090b..4c8fc51d3955 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5006,7 +5006,7 @@ M:	Jan Kara <jack@suse.cz>
 R:	Amir Goldstein <amir73il@gmail.com>
 L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
-F:	Documentation/filesystems/dnotify.txt
+F:	Documentation/filesystems/dnotify.rst
 F:	fs/notify/dnotify/
 F:	include/linux/dnotify.h
 
-- 
2.25.2

