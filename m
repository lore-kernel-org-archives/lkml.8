Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CD6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B966D206EB
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389426AbgFXGuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 02:50:11 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:43783 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388717AbgFXGuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 02:50:10 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0U0Zd2IT_1592981407;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U0Zd2IT_1592981407)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 24 Jun 2020 14:50:07 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] nvme: Use USEC_PER_SEC instead of magic numbers
Date:   Wed, 24 Jun 2020 14:49:58 +0800
Message-Id: <440d84877c3bc0917790466ee85753919fb29cb5.1592980985.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1592980985.git.baolin.wang@linux.alibaba.com>
References: <cover.1592980985.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1592980985.git.baolin.wang@linux.alibaba.com>
References: <cover.1592980985.git.baolin.wang@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use USEC_PER_SEC instead of magic numbers to make code more readable.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f5f882f..405bafa 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2967,7 +2967,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 
 	if (id->rtd3e) {
 		/* us -> s */
-		u32 transition_time = le32_to_cpu(id->rtd3e) / 1000000;
+		u32 transition_time = le32_to_cpu(id->rtd3e) / USEC_PER_SEC;
 
 		ctrl->shutdown_timeout = clamp_t(unsigned int, transition_time,
 						 shutdown_timeout, 60);
-- 
1.8.3.1

