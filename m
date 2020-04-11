Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A68C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A8020CC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586646448;
	bh=/YCEcyxO/t3IInKr0Mko1EsnK20R6iE+X3adiZf4rVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O2ANrqB6OAH3CbsbYQShDp+DLMXAKUvx8D0TwFJ+RAcUM7AjQcfKep/kG3skGMxCU
	 +t3ci+roaluX2zjIr/8y0AfXCRgRYcXS94kR+Tws7bJb0GC70fwO43/+rAIpDBz7Jn
	 OdUt91m1qXncV37009aUpWCTQQSPFMMYJvTTdZ0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbgDKXH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:07:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728642AbgDKXHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:07:24 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B16F320708;
        Sat, 11 Apr 2020 23:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646444;
        bh=/YCEcyxO/t3IInKr0Mko1EsnK20R6iE+X3adiZf4rVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KDURxYkw1GsfmhfW6EKbK0G7jLMK1DLI+l7/8i/DvRfPWBKH5KbC5w7VSU8lJ4P9F
         uzdkxprwkjuekYmfl6ebe/PLgC8oLhspa1rOlj2zl2uFF1bGnj5rNKUhxXYoRZfTJ3
         1iyof3AgOXP6EfRejA6aeYxu8Kzr3SwBaf/12LKc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Sasha Levin <sashal@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 015/121] RDMA/bnxt_re: Fix lifetimes in bnxt_re_task
Date:   Sat, 11 Apr 2020 19:05:20 -0400
Message-Id: <20200411230706.23855-15-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230706.23855-1-sashal@kernel.org>
References: <20200411230706.23855-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

[ Upstream commit 8a6c61704746d3a1e004e054504ae8d98ed95697 ]

A work queue cannot just rely on the ib_device not being freed, it must
hold a kref on the memory so that the BNXT_RE_FLAG_IBDEV_REGISTERED check
works.

Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
Link: https://lore.kernel.org/r/1584117207-2664-3-git-send-email-selvin.xavier@broadcom.com
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/bnxt_re/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index e7e8a0f494640..bc561340b9ad1 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1604,6 +1604,7 @@ static void bnxt_re_task(struct work_struct *work)
 	smp_mb__before_atomic();
 	atomic_dec(&rdev->sched_count);
 exit:
+	put_device(&rdev->ibdev.dev);
 	kfree(re_work);
 }
 
@@ -1680,6 +1681,7 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
 		/* Allocate for the deferred task */
 		re_work = kzalloc(sizeof(*re_work), GFP_ATOMIC);
 		if (re_work) {
+			get_device(&rdev->ibdev.dev);
 			re_work->rdev = rdev;
 			re_work->event = event;
 			re_work->vlan_dev = (real_dev == netdev ?
-- 
2.20.1

