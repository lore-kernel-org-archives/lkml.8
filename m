Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226FDC2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 14:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29FA2083E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 14:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgDKOua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 10:50:30 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:4142 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgDKOua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 10:50:30 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.7]) by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee45e91d925d4c-15fa3; Sat, 11 Apr 2020 22:50:13 +0800 (CST)
X-RM-TRANSID: 2ee45e91d925d4c-15fa3
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.104.145.126])
        by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee45e91d923f00-9d4e6;
        Sat, 11 Apr 2020 22:50:13 +0800 (CST)
X-RM-TRANSID: 2ee45e91d923f00-9d4e6
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     gregkh@linuxfoundation.org, arve@android.com, maco@android.com,
        tkjos@android.com, joel@joelfernandes.org, christian@brauner.io
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] binderfs: Fix binderfs.c selftest compilation warning
Date:   Sat, 11 Apr 2020 22:51:51 +0800
Message-Id: <20200411145151.5576-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix missing braces compilation warning in the ARM
compiler environment:
    drivers/android/binderfs.c: In function 'binderfs_fill_super':
    drivers/android/binderfs.c:650:9: warning: missing braces around initializer [-Wmissing-braces]
      struct binderfs_device device_info = { 0 };
    drivers/android/binderfs.c:650:9: warning: (near initialization for ‘device_info.name’) [-Wmissing-braces]

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/android/binderfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 9ecad7418..78528e1 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -650,7 +650,7 @@ static int binderfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	struct binderfs_info *info;
 	struct binderfs_mount_opts *ctx = fc->fs_private;
 	struct inode *inode = NULL;
-	struct binderfs_device device_info = { 0 };
+	struct binderfs_device device_info = {};
 	const char *name;
 	size_t len;
 
-- 
2.7.4



