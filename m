Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E4DC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 06:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A02982073A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 06:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgEFGTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 02:19:38 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3810 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726863AbgEFGTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 02:19:38 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 64528F2DB9A8FB5C990B;
        Wed,  6 May 2020 14:19:36 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Wed, 6 May 2020
 14:19:30 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <sumit.semwal@linaro.org>, <afd@ti.com>,
        <benjamin.gaignard@linaro.org>, <lmark@codeaurora.org>,
        <labbott@redhat.com>, <Brian.Starkey@arm.com>,
        <john.stultz@linaro.org>, <seanpaul@chromium.org>,
        <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] dma-buf: heaps: Remove Unneeded variable "ret" in dma_heap_dma_buf_begin_cpu_access()
Date:   Wed, 6 May 2020 14:18:51 +0800
Message-ID: <20200506061851.19745-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

drivers/dma-buf/heaps/heap-helpers.c:203:5-8: Unneeded variable: "ret".
Return "0" on line 216

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/dma-buf/heaps/heap-helpers.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma-buf/heaps/heap-helpers.c b/drivers/dma-buf/heaps/heap-helpers.c
index 9f964ca3f59c..c82872501ba2 100644
--- a/drivers/dma-buf/heaps/heap-helpers.c
+++ b/drivers/dma-buf/heaps/heap-helpers.c
@@ -200,7 +200,6 @@ static int dma_heap_dma_buf_begin_cpu_access(struct dma_buf *dmabuf,
 {
 	struct heap_helper_buffer *buffer = dmabuf->priv;
 	struct dma_heaps_attachment *a;
-	int ret = 0;
 
 	mutex_lock(&buffer->lock);
 
@@ -213,7 +212,7 @@ static int dma_heap_dma_buf_begin_cpu_access(struct dma_buf *dmabuf,
 	}
 	mutex_unlock(&buffer->lock);
 
-	return ret;
+	return 0;
 }
 
 static int dma_heap_dma_buf_end_cpu_access(struct dma_buf *dmabuf,
-- 
2.21.1

