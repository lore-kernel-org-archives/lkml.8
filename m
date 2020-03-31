Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85182C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57CE12072E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585646172;
	bh=FsfqxzjScZhe4FgujMhbEo2vZ75ikspigoZUz49IIUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0B0a89e18Lh0pPbxnC7RHDAOzwLgWLH2DMxi3/leNTPbZ714XPyejMzKamkf6EAIq
	 8lo17iN3qStx2ECSc3juYXXCq1ifUn0D00qjRKJaYXFAt6Wfwg2jlq2sZMSf6J194C
	 OlueKX/fQQ8OuyKhjw9SHSiNuvZUWsCZzEQhaxhE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731626AbgCaJQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:16:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:36722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731324AbgCaJQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:16:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B52120675;
        Tue, 31 Mar 2020 09:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585646166;
        bh=FsfqxzjScZhe4FgujMhbEo2vZ75ikspigoZUz49IIUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YG4SnUUp/dWWgOiuKJbaDIcWl7OXHKMs2n50Wjq210L9ivorVbn99+UfxLoqETo+u
         WLKrYox5ufSOxurxJy+dv7AOLo9VQi0IbSbCc8U160R4khq9APlQKWZIan0Z9EQn6R
         g0R8cJcsl/eCApFwa+FKvAbq8HtAibTLXkkoDpgM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qian Cai <cai@lca.pw>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 065/155] iommu/vt-d: Silence RCU-list debugging warnings
Date:   Tue, 31 Mar 2020 10:58:25 +0200
Message-Id: <20200331085425.760016508@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085418.274292403@linuxfoundation.org>
References: <20200331085418.274292403@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qian Cai <cai@lca.pw>

[ Upstream commit f5152416528c2295f35dd9c9bd4fb27c4032413d ]

Similar to the commit 02d715b4a818 ("iommu/vt-d: Fix RCU list debugging
warnings"), there are several other places that call
list_for_each_entry_rcu() outside of an RCU read side critical section
but with dmar_global_lock held. Silence those false positives as well.

 drivers/iommu/intel-iommu.c:4288 RCU-list traversed in non-reader section!!
 1 lock held by swapper/0/1:
  #0: ffffffff935892c8 (dmar_global_lock){+.+.}, at: intel_iommu_init+0x1ad/0xb97

 drivers/iommu/dmar.c:366 RCU-list traversed in non-reader section!!
 1 lock held by swapper/0/1:
  #0: ffffffff935892c8 (dmar_global_lock){+.+.}, at: intel_iommu_init+0x125/0xb97

 drivers/iommu/intel-iommu.c:5057 RCU-list traversed in non-reader section!!
 1 lock held by swapper/0/1:
  #0: ffffffffa71892c8 (dmar_global_lock){++++}, at: intel_iommu_init+0x61a/0xb13

Signed-off-by: Qian Cai <cai@lca.pw>
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/dmar.c | 3 ++-
 include/linux/dmar.h | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 6a9a1b987520f..9e393b9c50911 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -371,7 +371,8 @@ dmar_find_dmaru(struct acpi_dmar_hardware_unit *drhd)
 {
 	struct dmar_drhd_unit *dmaru;
 
-	list_for_each_entry_rcu(dmaru, &dmar_drhd_units, list)
+	list_for_each_entry_rcu(dmaru, &dmar_drhd_units, list,
+				dmar_rcu_check())
 		if (dmaru->segment == drhd->segment &&
 		    dmaru->reg_base_addr == drhd->address)
 			return dmaru;
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index d3ea390336f39..f397e52c2d9de 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -74,11 +74,13 @@ extern struct list_head dmar_drhd_units;
 				dmar_rcu_check())
 
 #define for_each_active_drhd_unit(drhd)					\
-	list_for_each_entry_rcu(drhd, &dmar_drhd_units, list)		\
+	list_for_each_entry_rcu(drhd, &dmar_drhd_units, list,		\
+				dmar_rcu_check())			\
 		if (drhd->ignored) {} else
 
 #define for_each_active_iommu(i, drhd)					\
-	list_for_each_entry_rcu(drhd, &dmar_drhd_units, list)		\
+	list_for_each_entry_rcu(drhd, &dmar_drhd_units, list,		\
+				dmar_rcu_check())			\
 		if (i=drhd->iommu, drhd->ignored) {} else
 
 #define for_each_iommu(i, drhd)						\
-- 
2.20.1



