Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC06C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD9B120578
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598026880;
	bh=VZu/xCLM/zvS86LzuuApCHR8B0eir2DgfJaLNqhOAVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d4tExNVB9shg86h8N4Jk4Ol95NAHqV3m4Pyi1p6Zo1Uh08atsF6Xnv0NTAQopqb8z
	 +ZoDPj4ILGvjxP2QWc6gaSDyB6lYIg4tp0pBYsrnzuleeG+LLuBnO/4oMbQEH5Y+7T
	 1e3uSPF15vGCS+eIMiVQSbXLQixvAyShi6VIwsWo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgHUQVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 12:21:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:48004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728046AbgHUQQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:16:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30C89208DB;
        Fri, 21 Aug 2020 16:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598026569;
        bh=VZu/xCLM/zvS86LzuuApCHR8B0eir2DgfJaLNqhOAVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M0/81QjCHN/QgHjWIUKlWa3LQMT9x/xKrIH1+MTxHpMd1a6QW3PtPT7TyesgPkRHE
         W7VORL+Ru8RiYWl9e3ZpDglb2NYDv+K+VihC6IOLBgTPmhzFiVxj9v+h++eLgsvfUE
         M6TsPG4K4AgKM3usRhrFVSnNSY0jISqzOKvQC94k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Prakash Gupta <guptap@codeaurora.org>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 5.7 19/61] iommu/iova: Don't BUG on invalid PFNs
Date:   Fri, 21 Aug 2020 12:15:03 -0400
Message-Id: <20200821161545.347622-19-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821161545.347622-1-sashal@kernel.org>
References: <20200821161545.347622-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Murphy <robin.murphy@arm.com>

[ Upstream commit d3e3d2be688b4b5864538de61e750721a311e4fc ]

Unlike the other instances which represent a complete loss of
consistency within the rcache mechanism itself, or a fundamental
and obvious misconfiguration by an IOMMU driver, the BUG_ON() in
iova_magazine_free_pfns() can be provoked at more or less any time
in a "spooky action-at-a-distance" manner by any old device driver
passing nonsense to dma_unmap_*() which then propagates through to
queue_iova().

Not only is this well outside the IOVA layer's control, it's also
nowhere near fatal enough to justify panicking anyway - all that
really achieves is to make debugging the offending driver more
difficult. Let's simply WARN and otherwise ignore bogus PFNs.

Reported-by: Prakash Gupta <guptap@codeaurora.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Prakash Gupta <guptap@codeaurora.org>
Link: https://lore.kernel.org/r/acbd2d092b42738a03a21b417ce64e27f8c91c86.1591103298.git.robin.murphy@arm.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/iova.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 0e6a9536eca62..612cbf668adf8 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -811,7 +811,9 @@ iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
 	for (i = 0 ; i < mag->size; ++i) {
 		struct iova *iova = private_find_iova(iovad, mag->pfns[i]);
 
-		BUG_ON(!iova);
+		if (WARN_ON(!iova))
+			continue;
+
 		private_free_iova(iovad, iova);
 	}
 
-- 
2.25.1

