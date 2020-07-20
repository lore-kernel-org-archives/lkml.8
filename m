Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C86DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 10:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 775C220B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 10:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgGTKcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 06:32:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33729 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgGTKcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 06:32:46 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jxT66-0007BB-85; Mon, 20 Jul 2020 10:32:38 +0000
From:   Colin King <colin.king@canonical.com>
To:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Paulo Alcantara <pc@cjr.nz>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] initrd: fix spelling mistake "depreated" -> "deprecated"
Date:   Mon, 20 Jul 2020 11:32:37 +0100
Message-Id: <20200720103237.271462-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are spelling mistakes in the pr_warning messages. Fix them.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 init/do_mounts.c    | 2 +-
 init/do_mounts_rd.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 4f4ceb358055..a7f22cf58c7e 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -37,7 +37,7 @@ dev_t ROOT_DEV;
 
 static int __init load_ramdisk(char *str)
 {
-	pr_warn("ignoring the depreated load_ramdisk= option\n");
+	pr_warn("ignoring the deprecated load_ramdisk= option\n");
 	return 1;
 }
 __setup("load_ramdisk=", load_ramdisk);
diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index 7b64390c0750..8307fdb5d136 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -17,7 +17,7 @@
 
 static int __init prompt_ramdisk(char *str)
 {
-	pr_warn("ignoring the depreated prompt_ramdisk= option\n");
+	pr_warn("ignoring the deprecated prompt_ramdisk= option\n");
 	return 1;
 }
 __setup("prompt_ramdisk=", prompt_ramdisk);
-- 
2.27.0

