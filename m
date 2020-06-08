Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C47C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79808207FB
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591662848;
	bh=8cvxJMJFDcmUm/5T5Iw939tVnqpy6rotxOWw3C4jB4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HfOInAgmxrb8rSD4QyGoE5fS9wzcSxIy0NsbdtusIrRwCSOEoXf6Nw5yiEPy99IAi
	 rrAbsyOuj7g9xXNcezhyTtf941xcxdrP1j5TUWXfUNJjjzdMsm1rKE9tFiAcxcr3dM
	 heCn4892DeDoBb9OKfdF/nGrtd8+zYIgi0zLKjs4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731380AbgFIAeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:34:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:35230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729892AbgFHXOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:14:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF65120B80;
        Mon,  8 Jun 2020 23:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658084;
        bh=8cvxJMJFDcmUm/5T5Iw939tVnqpy6rotxOWw3C4jB4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OTYgpUMCr+/MxXM5OLal87LzCsWBtiqRZCnbO2+ILxkJbO+ARJhUi9BjvamZMP5sN
         t4WdsMOcc3WeA8ITTn2DmXVyaAzlEBfpC/zZNgN0bqXVj47nhAXGjLPpOGlXWGbWCA
         fkhaZGyK1F2iJJj7BNNWXTXam5DW12ATLUmk+6Pw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Joerg Roedel <jroedel@suse.de>, Qian Cai <cai@lca.pw>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 5.6 128/606] iommu/amd: Call domain_flush_complete() in update_domain()
Date:   Mon,  8 Jun 2020 19:04:13 -0400
Message-Id: <20200608231211.3363633-128-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

[ Upstream commit f44a4d7e4f1cdef73c90b1dc749c4d8a7372a8eb ]

The update_domain() function is expected to also inform the hardware
about domain changes. This needs a COMPLETION_WAIT command to be sent
to all IOMMUs which use the domain.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Tested-by: Qian Cai <cai@lca.pw>
Link: https://lore.kernel.org/r/20200504125413.16798-4-joro@8bytes.org
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd_iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 18c995a16d80..2aa46a6de172 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2345,6 +2345,7 @@ static void update_domain(struct protection_domain *domain)
 
 	/* Flush domain TLB(s) and wait for completion */
 	domain_flush_tlb_pde(domain);
+	domain_flush_complete(domain);
 }
 
 int __init amd_iommu_init_api(void)
-- 
2.25.1

