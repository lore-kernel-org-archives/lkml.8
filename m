Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D87C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 412B8206DB
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592448021;
	bh=qnZJ+y88am70vNTm8oIcf5bPU1V80wtwWA+jUDlUqHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wpk81W7WCLcRLwFkntFGodYuQxhp1OFiGJou1yrnyHnmmtIuIzh/y7vQe7jqo/c9P
	 r/wfM6qcMNS2J4K423Tk1EhP6dX6cH4BzISTEmJ6VxDlYgGqhhN0D6nvrpHq8EXLC+
	 I2NsNi6x2hYS+iQ7MJtQ8vQa0vAna6c8ADVfbVGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgFRBMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:12:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728803AbgFRBLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:11:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D45220B1F;
        Thu, 18 Jun 2020 01:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442712;
        bh=qnZJ+y88am70vNTm8oIcf5bPU1V80wtwWA+jUDlUqHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O1VnLVW4y8xjGucdJTIU3QSgfVqN8ALaPNxrzYmGPeHDS4XWp7n8trbcqVJaLbJCw
         mjcvlLCt/aObGHtBFq3v0SxiL25yybk5BaQS+I3OnOeoebDGUb2dvotV2+FvbOhAQ+
         9o8OdtRKMnv9egfbZ+lm0ikBUPZww5J9bqDW57RQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Jerome Pouiller <Jerome.Pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 5.7 172/388] staging: wfx: avoid compiler warning on empty array
Date:   Wed, 17 Jun 2020 21:04:29 -0400
Message-Id: <20200618010805.600873-172-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 2eeefd3787fdc6319124945d453774be95b97897 ]

When CONFIG_OF is disabled, gcc-9 produces a warning about the
wfx_sdio_of_match[] array having a declaration without a dimension:

drivers/staging/wfx/bus_sdio.c:159:34: error: array 'wfx_sdio_of_match' assumed to have one element [-Werror]
  159 | static const struct of_device_id wfx_sdio_of_match[];
      |                                  ^~~~~~~~~~~~~~~~~

Move the proper declaration up and out of the #ifdef instead.

Fixes: a7a91ca5a23d ("staging: wfx: add infrastructure for new driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Jerome Pouiller <Jerome.Pouiller@silabs.com>
Link: https://lore.kernel.org/r/20200429142119.1735196-1-arnd@arndb.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/wfx/bus_sdio.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/wfx/bus_sdio.c b/drivers/staging/wfx/bus_sdio.c
index dedc3ff58d3e..c2e4bd1e3b0a 100644
--- a/drivers/staging/wfx/bus_sdio.c
+++ b/drivers/staging/wfx/bus_sdio.c
@@ -156,7 +156,13 @@ static const struct hwbus_ops wfx_sdio_hwbus_ops = {
 	.align_size		= wfx_sdio_align_size,
 };
 
-static const struct of_device_id wfx_sdio_of_match[];
+static const struct of_device_id wfx_sdio_of_match[] = {
+	{ .compatible = "silabs,wfx-sdio" },
+	{ .compatible = "silabs,wf200" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, wfx_sdio_of_match);
+
 static int wfx_sdio_probe(struct sdio_func *func,
 			  const struct sdio_device_id *id)
 {
@@ -248,15 +254,6 @@ static const struct sdio_device_id wfx_sdio_ids[] = {
 };
 MODULE_DEVICE_TABLE(sdio, wfx_sdio_ids);
 
-#ifdef CONFIG_OF
-static const struct of_device_id wfx_sdio_of_match[] = {
-	{ .compatible = "silabs,wfx-sdio" },
-	{ .compatible = "silabs,wf200" },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, wfx_sdio_of_match);
-#endif
-
 struct sdio_driver wfx_sdio_driver = {
 	.name = "wfx-sdio",
 	.id_table = wfx_sdio_ids,
@@ -264,6 +261,6 @@ struct sdio_driver wfx_sdio_driver = {
 	.remove = wfx_sdio_remove,
 	.drv = {
 		.owner = THIS_MODULE,
-		.of_match_table = of_match_ptr(wfx_sdio_of_match),
+		.of_match_table = wfx_sdio_of_match,
 	}
 };
-- 
2.25.1

