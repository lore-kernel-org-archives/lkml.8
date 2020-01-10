Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADAFC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 22:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF86820842
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 22:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578693973;
	bh=C9LryPPI8PsxaJh91bW40PmXS34SlvRrDvM0ud5fJqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bUkpupF24MIjvOMKF7JYn81vGrX2L9Kxxc6SJB0IKdQD0awb/J6PMzwJZ0alOd5OQ
	 dcwTikTCASvHDhNEG6Bu0j/PWJTgKQ6RF2/Bcex0c6eT4GL1F9vdrDwDEXB34xWBiL
	 EJq7JLZ+lbY81irI1EtRlM8zQD2QIvj7uu4pRps0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgAJWGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 17:06:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:52528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728117AbgAJWGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 17:06:05 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A1192072E;
        Fri, 10 Jan 2020 22:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578693964;
        bh=C9LryPPI8PsxaJh91bW40PmXS34SlvRrDvM0ud5fJqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jZTPpOg+z8ylhfNPthp7K7G8VEmLrZOn9Tzu1zOPyCwAGfVXkGu9/ePT1ofmIHm/f
         WhyxvsmiMKPvn4zR1If8SsOKswbUQSjKZlJUS3HSxjTlcYAU0ZV6dYtDlX++sUma7N
         8TbIX/xHRF4AAJAwCNagguolrYTQMKpAD3dXwVUU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Alexander.Barabash@dell.com" <Alexander.Barabash@dell.com>,
        Alexander Barabash <alexander.barabash@dell.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 08/11] ioat: ioat_alloc_ring() failure handling.
Date:   Fri, 10 Jan 2020 17:05:52 -0500
Message-Id: <20200110220556.28505-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200110220556.28505-1-sashal@kernel.org>
References: <20200110220556.28505-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Alexander.Barabash@dell.com" <Alexander.Barabash@dell.com>

[ Upstream commit b0b5ce1010ffc50015eaec72b0028aaae3f526bb ]

If dma_alloc_coherent() returns NULL in ioat_alloc_ring(), ring
allocation must not proceed.

Until now, if the first call to dma_alloc_coherent() in
ioat_alloc_ring() returned NULL, the processing could proceed, failing
with NULL-pointer dereferencing further down the line.

Signed-off-by: Alexander Barabash <alexander.barabash@dell.com>
Acked-by: Dave Jiang <dave.jiang@intel.com>
Link: https://lore.kernel.org/r/75e9c0e84c3345d693c606c64f8b9ab5@x13pwhopdag1307.AMER.DELL.COM
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/ioat/dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
index 23fb2fa04000..b94cece58b98 100644
--- a/drivers/dma/ioat/dma.c
+++ b/drivers/dma/ioat/dma.c
@@ -388,10 +388,11 @@ ioat_alloc_ring(struct dma_chan *c, int order, gfp_t flags)
 
 		descs->virt = dma_alloc_coherent(to_dev(ioat_chan),
 						 SZ_2M, &descs->hw, flags);
-		if (!descs->virt && (i > 0)) {
+		if (!descs->virt) {
 			int idx;
 
 			for (idx = 0; idx < i; idx++) {
+				descs = &ioat_chan->descs[idx];
 				dma_free_coherent(to_dev(ioat_chan), SZ_2M,
 						  descs->virt, descs->hw);
 				descs->virt = NULL;
-- 
2.20.1

