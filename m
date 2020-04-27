Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B79C81C44
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2770B206D6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588022335;
	bh=SrBCHrmFAfZaU3iuZcFZhZ/mdAgMIZCqDLqb0MBGzrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ap/TSLUrXvHC1trdgcv/W5eEBUN58t7g4QXCrO+vkPRa0rSX41X4wvy1qeKWVvIkz
	 UYPVyk/p/LzYuf4mLIp+RpnckbePS/5Y/bO1IUbS0OBUdlr4Q494lhsfsiaJn+xtnw
	 aeXg0shtRcJNrAoN+2Hc5kEehZT27uZW+b3FWpLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgD0VSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 17:18:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726378AbgD0VR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 17:17:26 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEF75221EB;
        Mon, 27 Apr 2020 21:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588022244;
        bh=SrBCHrmFAfZaU3iuZcFZhZ/mdAgMIZCqDLqb0MBGzrA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BUhwyp9n8UL4a+87Aavgr4yuteUMATJ114O2dX+NjfGrzcJ/E3EgGJPcGGF43EnNZ
         tARX6EoW34zuxiWnH2GfGmqoFh0R11YiH80kphMbmEQt8XX8MiIYdmXcFy93mDPUZQ
         DRWim1+ynESgSy2Qu/ZIgxJOYtgt1JZH+kZNiFCU=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jTB7z-000Hl2-05; Mon, 27 Apr 2020 23:17:23 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jan Kara <jack@suse.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH v3 18/29] docs: filesystems: convert quota.txt to ReST
Date:   Mon, 27 Apr 2020 23:17:10 +0200
Message-Id: <10a707377475bb252f454af2b8f58a038527933f.1588021877.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1588021877.git.mchehab+huawei@kernel.org>
References: <cover.1588021877.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add a SPDX header;
- Adjust document title;
- Some whitespace fixes and new line breaks;
- Add it to filesystems/index.rst.

Acked-by: Jan Kara <jack@suse.cz>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/index.rst           |  1 +
 .../filesystems/{quota.txt => quota.rst}      | 41 +++++++++++++------
 MAINTAINERS                                   |  2 +-
 3 files changed, 31 insertions(+), 13 deletions(-)
 rename Documentation/filesystems/{quota.txt => quota.rst} (81%)

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index c6f309b488e4..00739ce4ef1b 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -31,6 +31,7 @@ algorithms work.
    locks
    mandatory-locking
    mount_api
+   quota
 
    automount-support
 
diff --git a/Documentation/filesystems/quota.txt b/Documentation/filesystems/quota.rst
similarity index 81%
rename from Documentation/filesystems/quota.txt
rename to Documentation/filesystems/quota.rst
index 32874b06ebe9..a30cdd47c652 100644
--- a/Documentation/filesystems/quota.txt
+++ b/Documentation/filesystems/quota.rst
@@ -1,4 +1,6 @@
+.. SPDX-License-Identifier: GPL-2.0
 
+===============
 Quota subsystem
 ===============
 
@@ -39,6 +41,7 @@ Currently, the interface supports only one message type QUOTA_NL_C_WARNING.
 This command is used to send a notification about any of the above mentioned
 events. Each message has six attributes. These are (type of the argument is
 in parentheses):
+
         QUOTA_NL_A_QTYPE (u32)
 	  - type of quota being exceeded (one of USRQUOTA, GRPQUOTA)
         QUOTA_NL_A_EXCESS_ID (u64)
@@ -48,20 +51,34 @@ in parentheses):
 	  - UID of a user who caused the event
         QUOTA_NL_A_WARNING (u32)
 	  - what kind of limit is exceeded:
-		QUOTA_NL_IHARDWARN - inode hardlimit
-		QUOTA_NL_ISOFTLONGWARN - inode softlimit is exceeded longer
-		  than given grace period
-		QUOTA_NL_ISOFTWARN - inode softlimit
-		QUOTA_NL_BHARDWARN - space (block) hardlimit
-		QUOTA_NL_BSOFTLONGWARN - space (block) softlimit is exceeded
-		  longer than given grace period.
-		QUOTA_NL_BSOFTWARN - space (block) softlimit
+
+		QUOTA_NL_IHARDWARN
+		    inode hardlimit
+		QUOTA_NL_ISOFTLONGWARN
+		    inode softlimit is exceeded longer
+		    than given grace period
+		QUOTA_NL_ISOFTWARN
+		    inode softlimit
+		QUOTA_NL_BHARDWARN
+		    space (block) hardlimit
+		QUOTA_NL_BSOFTLONGWARN
+		    space (block) softlimit is exceeded
+		    longer than given grace period.
+		QUOTA_NL_BSOFTWARN
+		    space (block) softlimit
+
 	  - four warnings are also defined for the event when user stops
 	    exceeding some limit:
-		QUOTA_NL_IHARDBELOW - inode hardlimit
-		QUOTA_NL_ISOFTBELOW - inode softlimit
-		QUOTA_NL_BHARDBELOW - space (block) hardlimit
-		QUOTA_NL_BSOFTBELOW - space (block) softlimit
+
+		QUOTA_NL_IHARDBELOW
+		    inode hardlimit
+		QUOTA_NL_ISOFTBELOW
+		    inode softlimit
+		QUOTA_NL_BHARDBELOW
+		    space (block) hardlimit
+		QUOTA_NL_BSOFTBELOW
+		    space (block) softlimit
+
         QUOTA_NL_A_DEV_MAJOR (u32)
 	  - major number of a device with the affected filesystem
         QUOTA_NL_A_DEV_MINOR (u32)
diff --git a/MAINTAINERS b/MAINTAINERS
index 36d1fd48b6b2..ff9094b9310a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5021,7 +5021,7 @@ W:	http://www.win.tue.nl/~aeb/partitions/partition_types-1.html
 DISKQUOTA
 M:	Jan Kara <jack@suse.com>
 S:	Maintained
-F:	Documentation/filesystems/quota.txt
+F:	Documentation/filesystems/quota.rst
 F:	fs/quota/
 F:	include/linux/quota*.h
 F:	include/uapi/linux/quota*.h
-- 
2.25.4

