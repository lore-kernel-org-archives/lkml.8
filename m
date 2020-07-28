Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8DEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 17:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B94EC20786
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 17:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595956113;
	bh=G1v8Y0rM+ilZYs/g4rxUC1FVBPLyodeBTtIrGaLV2n4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=twnAmvDZhyXaEf8M09bG27jbBBRQLR83t3MTKWOdYeqUV0GmBj8X3Q8bH3InfW16g
	 jULhupfKUF01BxPSaRymZqh1pCiRLT/pU+5qSmOskr/bM7scus1h3APCbYI6IIVcSX
	 huUU4SBapmOdyv69AdKFrWKom0/CvvF32VXvuBJM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731803AbgG1RIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 13:08:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731623AbgG1RIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 13:08:32 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE3F120786;
        Tue, 28 Jul 2020 17:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595956111;
        bh=G1v8Y0rM+ilZYs/g4rxUC1FVBPLyodeBTtIrGaLV2n4=;
        h=From:To:Cc:Subject:Date:From;
        b=cXL5MYvhbRL3RPOdTcA7OWxWPvSS3WgxMIKlbhF5IxjNkjrruC2YdCuAQyF6HpGuz
         vd23AIZ5Fdl1rChmreWncu6aImeGr9+p4aCM3Un1mwsH/x3i6yP54Dsqigxq41tQSC
         VfTgPio9vgBkk175YP+b78zRwrVTkxwRiJS9Q3zc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/2] dma-buf: Fix kerneldoc of dma_buf_set_name()
Date:   Tue, 28 Jul 2020 19:08:20 +0200
Message-Id: <20200728170821.28050-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix W=1 compile warnings (invalid kerneldoc):

    drivers/dma-buf/dma-buf.c:328: warning: Function parameter or member 'dmabuf' not described in 'dma_buf_set_name'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/dma-buf/dma-buf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 1699a8e309ef..58564d82a3a2 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -316,9 +316,9 @@ static __poll_t dma_buf_poll(struct file *file, poll_table *poll)
  * name of the dma-buf if the same piece of memory is used for multiple
  * purpose between different devices.
  *
- * @dmabuf [in]     dmabuf buffer that will be renamed.
- * @buf:   [in]     A piece of userspace memory that contains the name of
- *                  the dma-buf.
+ * @dmabuf: [in]     dmabuf buffer that will be renamed.
+ * @buf:    [in]     A piece of userspace memory that contains the name of
+ *                   the dma-buf.
  *
  * Returns 0 on success. If the dma-buf buffer is already attached to
  * devices, return -EBUSY.
-- 
2.17.1

