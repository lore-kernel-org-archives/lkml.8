Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07353C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 09:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7E042075B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 09:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbgAPJWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 04:22:09 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60139 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbgAPJWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 04:22:08 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1is1Lq-000436-T3; Thu, 16 Jan 2020 09:22:07 +0000
From:   Colin King <colin.king@canonical.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] tools: bootconfig: fix spelling mistake "faile" -> "failed"
Date:   Thu, 16 Jan 2020 09:22:06 +0000
Message-Id: <20200116092206.52192-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are two spelling mistakes in printf statements, fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 tools/bootconfig/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index b8f174fd2a0a..91c9a5c0c499 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -140,7 +140,7 @@ int load_xbc_from_initrd(int fd, char **buf)
 		return 0;
 
 	if (lseek(fd, -8, SEEK_END) < 0) {
-		printf("Faile to lseek: %d\n", -errno);
+		printf("Failed to lseek: %d\n", -errno);
 		return -errno;
 	}
 
@@ -155,7 +155,7 @@ int load_xbc_from_initrd(int fd, char **buf)
 		return 0;
 
 	if (lseek(fd, stat.st_size - 8 - size, SEEK_SET) < 0) {
-		printf("Faile to lseek: %d\n", -errno);
+		printf("Failed to lseek: %d\n", -errno);
 		return -errno;
 	}
 
-- 
2.24.0

