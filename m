Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57A0C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85A13206F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587488145;
	bh=1m0dqMfyqunAzLDkBnbFfXRJYKX/yvOdJ++cF5dHUtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ltT+DY9MyRbjXMKNhHDxwfHVoSYJJReroGurd7pES7C++MNXUAnHyJHRPLPW6g8lM
	 uA5ulGFWIbTtTbr6dlH2SGH3iu1IaR0NO+eXoa5H/mY3Mb6oyY1zNnsA/wkX3YT2im
	 bnMzWmwH8TjRCl77dWAz52VTu92PTkTXYfWPaBSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbgDUQzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:55:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729130AbgDUQys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:54:48 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7492720CC7;
        Tue, 21 Apr 2020 16:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587488084;
        bh=1m0dqMfyqunAzLDkBnbFfXRJYKX/yvOdJ++cF5dHUtI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xV+Rt9guKrjb6YjlrDR3s1XDE/t1iRDwUsfr218IfD0IvDV3Ad7gtu2x//iyweZXW
         dxlNFRoZO/V4YgX7YkvJURvMtadANBATEcy5O/ZCOMgwGPM0cNPX3B1gU9rqaqqE7+
         NSg30nhcRv0a530K+IWJVmXlytGz2bSsoJMqr7MU=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jQwAU-00CmEq-M7; Tue, 21 Apr 2020 18:54:42 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jan Kara <jack@suse.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH v2 19/29] docs: filesystems: convert quota.txt to ReST
Date:   Tue, 21 Apr 2020 18:54:30 +0200
Message-Id: <88f4e5b7e0b173b323413e6f410bdcdd7da847bd.1587487612.git.mchehab+huawei@kernel.org>
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
index abfc143434a2..6458891f74e4 100644
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
index 4c8fc51d3955..ac8ddd91928a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5020,7 +5020,7 @@ W:	http://www.win.tue.nl/~aeb/partitions/partition_types-1.html
 DISKQUOTA
 M:	Jan Kara <jack@suse.com>
 S:	Maintained
-F:	Documentation/filesystems/quota.txt
+F:	Documentation/filesystems/quota.rst
 F:	fs/quota/
 F:	include/linux/quota*.h
 F:	include/uapi/linux/quota*.h
-- 
2.25.2

