Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DCBC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27B4B20771
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbgGWPyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 11:54:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53406 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgGWPyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 11:54:19 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jydXz-0001Lg-U7; Thu, 23 Jul 2020 15:54:16 +0000
From:   Colin King <colin.king@canonical.com>
To:     David Kershner <david.kershner@unisys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sparmaintainer@unisys.com, devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: unisys: visorhba: remove redundant initialization of variables scsicmd_id and rc
Date:   Thu, 23 Jul 2020 16:54:15 +0100
Message-Id: <20200723155415.994036-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variables scsicmd_id and rc is being initialized with a value
that is never read and are being updated later with a new value.
The initializations are redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/unisys/visorhba/visorhba_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/unisys/visorhba/visorhba_main.c b/drivers/staging/unisys/visorhba/visorhba_main.c
index 99c57ceeb357..7ae5306b92fe 100644
--- a/drivers/staging/unisys/visorhba/visorhba_main.c
+++ b/drivers/staging/unisys/visorhba/visorhba_main.c
@@ -305,7 +305,7 @@ static int forward_taskmgmt_command(enum task_mgmt_types tasktype,
 		(struct visorhba_devdata *)scsidev->host->hostdata;
 	int notifyresult = 0xffff;
 	wait_queue_head_t notifyevent;
-	int scsicmd_id = 0;
+	int scsicmd_id;
 
 	if (devdata->serverdown || devdata->serverchangingstate)
 		return FAILED;
@@ -1186,7 +1186,7 @@ static struct visor_driver visorhba_driver = {
  */
 static int visorhba_init(void)
 {
-	int rc = -ENOMEM;
+	int rc;
 
 	visorhba_debugfs_dir = debugfs_create_dir("visorhba", NULL);
 	if (!visorhba_debugfs_dir)
-- 
2.27.0

