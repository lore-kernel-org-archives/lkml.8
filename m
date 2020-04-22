Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1F6C5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA6D520656
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587552197;
	bh=TX443VW0wwGHwsW3eKFenSBCRAXdimDJM+ENiJ/1qn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MNzA9T0p0s+zFmk++3PdfxQlljNXK4Nm0Ms2Tqsp6TnQpRCUz1kLQvpNHjAYJ6Ehv
	 4C2SjZI/uDb6uPgqQr06firqVli0uCOIxa27xs1p/8krbMUTdH0UtAtqmGDnBUiopV
	 ZamDAqgbhl5t2t5LlqtlAS+xANvMIxDIBcgOi4oE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731744AbgDVKnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:43:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729523AbgDVKTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:19:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54A8020775;
        Wed, 22 Apr 2020 10:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550780;
        bh=TX443VW0wwGHwsW3eKFenSBCRAXdimDJM+ENiJ/1qn0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bRVs4AHRDIh91PI6zEHdawUWHLvladc13ijuYkurvcjUVvgBy9IdjDze/7rqROfY2
         kgAntolM9OtC7GIqrk8O1OwyW5wj+8WfwZ33sRYjvyKb5pscjA2toNl9gujIGjh2Tl
         QkSZRBdx5rPVmwmEoN4W2Kfx7kMkq02MHIhRZt50=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qian Cai <cai@lca.pw>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 091/118] iommu/vt-d: Silence RCU-list debugging warning in dmar_find_atsr()
Date:   Wed, 22 Apr 2020 11:57:32 +0200
Message-Id: <20200422095046.283048366@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095031.522502705@linuxfoundation.org>
References: <20200422095031.522502705@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qian Cai <cai@lca.pw>

[ Upstream commit c6f4ebdeba4cff590594df931ff1ee610c426431 ]

dmar_find_atsr() calls list_for_each_entry_rcu() outside of an RCU read
side critical section but with dmar_global_lock held. Silence this
false positive.

 drivers/iommu/intel-iommu.c:4504 RCU-list traversed in non-reader section!!
 1 lock held by swapper/0/1:
 #0: ffffffff9755bee8 (dmar_global_lock){+.+.}, at: intel_iommu_init+0x1a6/0xe19

 Call Trace:
  dump_stack+0xa4/0xfe
  lockdep_rcu_suspicious+0xeb/0xf5
  dmar_find_atsr+0x1ab/0x1c0
  dmar_parse_one_atsr+0x64/0x220
  dmar_walk_remapping_entries+0x130/0x380
  dmar_table_init+0x166/0x243
  intel_iommu_init+0x1ab/0xe19
  pci_iommu_init+0x1a/0x44
  do_one_initcall+0xae/0x4d0
  kernel_init_freeable+0x412/0x4c5
  kernel_init+0x19/0x193

Signed-off-by: Qian Cai <cai@lca.pw>
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 0d922eeae3579..773ac2b0d6068 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4335,7 +4335,8 @@ static struct dmar_atsr_unit *dmar_find_atsr(struct acpi_dmar_atsr *atsr)
 	struct dmar_atsr_unit *atsru;
 	struct acpi_dmar_atsr *tmp;
 
-	list_for_each_entry_rcu(atsru, &dmar_atsr_units, list) {
+	list_for_each_entry_rcu(atsru, &dmar_atsr_units, list,
+				dmar_rcu_check()) {
 		tmp = (struct acpi_dmar_atsr *)atsru->hdr;
 		if (atsr->segment != tmp->segment)
 			continue;
-- 
2.20.1



