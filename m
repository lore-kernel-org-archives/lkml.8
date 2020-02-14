Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D32DC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7629D2187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581695786;
	bh=p5HfsD/7oSJvIOKScBFttuw+L3MLtwgbJ+C+qro4QB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NK8fLjc/w8HHlw/2M/skkHn26JK6owIVn+bl99Pe+ktd/pcjQQVrdfe6m0CZc2eA8
	 KpU0wWee/Di5UCpwszABLhl+jXYV7r+FttL/2p5ls2AdUlPaWwRR0Wia+b46G1UjAD
	 ehK0o5wqpR1EMORQVqtctQrHItumsQbMFIWpZMHI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387792AbgBNP4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:56:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:38064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387744AbgBNP4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:56:19 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 154EC206D7;
        Fri, 14 Feb 2020 15:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695778;
        bh=p5HfsD/7oSJvIOKScBFttuw+L3MLtwgbJ+C+qro4QB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Iw3NsrwX5tpuVap832gLAEL8PfhKutoPdE13UyvaVYH395bjna1F4PGb4ht8pcJZm
         9lbYK2PplOXswD2zd9bp+qKqDVom4RIRBN+2XfRGZie9wxgd2UxpSRmqNJtW29AUYe
         oQbAmbODBYYn4+gxCa75J/hBxyeATMYAurpdetVE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hongbo Yao <yaohongbo@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.5 343/542] misc: genwqe: fix compile warnings
Date:   Fri, 14 Feb 2020 10:45:35 -0500
Message-Id: <20200214154854.6746-343-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hongbo Yao <yaohongbo@huawei.com>

[ Upstream commit 8edf4cd193067ac5e03fd9580f1affbb6a3f729b ]

Using the following command will get compile warnings:
make W=1 drivers/misc/genwqe/card_ddcb.o ARCH=x86_64

drivers/misc/genwqe/card_ddcb.c: In function setup_ddcb_queue:
drivers/misc/genwqe/card_ddcb.c:1024:6: warning: variable rc set but not
used [-Wunused-but-set-variable]
drivers/misc/genwqe/card_ddcb.c: In function genwqe_card_thread:
drivers/misc/genwqe/card_ddcb.c:1190:23: warning: variable rc set but
not used [-Wunused-but-set-variable]

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>
Link: https://lore.kernel.org/r/20191205111655.170382-1-yaohongbo@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/genwqe/card_ddcb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/genwqe/card_ddcb.c b/drivers/misc/genwqe/card_ddcb.c
index 026c6ca245408..905106579935a 100644
--- a/drivers/misc/genwqe/card_ddcb.c
+++ b/drivers/misc/genwqe/card_ddcb.c
@@ -1084,7 +1084,7 @@ static int setup_ddcb_queue(struct genwqe_dev *cd, struct ddcb_queue *queue)
 				queue->ddcb_daddr);
 	queue->ddcb_vaddr = NULL;
 	queue->ddcb_daddr = 0ull;
-	return -ENODEV;
+	return rc;
 
 }
 
@@ -1179,7 +1179,7 @@ static irqreturn_t genwqe_vf_isr(int irq, void *dev_id)
  */
 static int genwqe_card_thread(void *data)
 {
-	int should_stop = 0, rc = 0;
+	int should_stop = 0;
 	struct genwqe_dev *cd = (struct genwqe_dev *)data;
 
 	while (!kthread_should_stop()) {
@@ -1187,12 +1187,12 @@ static int genwqe_card_thread(void *data)
 		genwqe_check_ddcb_queue(cd, &cd->queue);
 
 		if (GENWQE_POLLING_ENABLED) {
-			rc = wait_event_interruptible_timeout(
+			wait_event_interruptible_timeout(
 				cd->queue_waitq,
 				genwqe_ddcbs_in_flight(cd) ||
 				(should_stop = kthread_should_stop()), 1);
 		} else {
-			rc = wait_event_interruptible_timeout(
+			wait_event_interruptible_timeout(
 				cd->queue_waitq,
 				genwqe_next_ddcb_ready(cd) ||
 				(should_stop = kthread_should_stop()), HZ);
-- 
2.20.1

