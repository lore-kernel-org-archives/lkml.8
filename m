Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A72C433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A553206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589482449;
	bh=7D/zctjk5AKqwiEPDsf1Ku+Xppketp/iz8b48qj3Saw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xzL/GBiBso6oJj3sQeB8rt51ul6qvnESK/bBvkX6SisHjOpWTqPNfRhmU9ZLgNopX
	 fpI0yBBhmdWeScO5K94zpJzutRzPnmRBXFImVgZIRsVhjTK0Q7/JRfLLcqB4BjoWHa
	 zs9jfwBjWNyWU8r5vAp7S1s6rXR3RcV3klQ2uKvE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgENSyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 14:54:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:53586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728881AbgENSx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:53:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FC892076A;
        Thu, 14 May 2020 18:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589482436;
        bh=7D/zctjk5AKqwiEPDsf1Ku+Xppketp/iz8b48qj3Saw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EWeLlxGQ1M9kNhjP6IhQBdmd2aBGSnSpEziEtdUvR+EnqRYrbzfBrqOydTTe60ij3
         4J3qMMVAEWe0wGXMVsLav7rU/Gg21vJ3iRn3VuO+tyrF1nGccmKShr0uH3suiST3li
         2RR01S+fKhe0UvwMsAW8fTWveaEw07guWRgvrV3E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Joerg Roedel <jroedel@suse.de>, Qian Cai <cai@lca.pw>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 5.4 36/49] iommu/amd: Call domain_flush_complete() in update_domain()
Date:   Thu, 14 May 2020 14:52:57 -0400
Message-Id: <20200514185311.20294-36-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514185311.20294-1-sashal@kernel.org>
References: <20200514185311.20294-1-sashal@kernel.org>
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
index bc77714983421..32de8e7bb8b45 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2386,6 +2386,7 @@ static void update_domain(struct protection_domain *domain)
 
 	domain_flush_devices(domain);
 	domain_flush_tlb_pde(domain);
+	domain_flush_complete(domain);
 }
 
 static int dir2prot(enum dma_data_direction direction)
-- 
2.20.1

