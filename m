Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B068AC55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FC052073A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587551425;
	bh=fGz7a64lWYFN33TvpNVh9lbizXvizlbW6RS4o/D26oI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PACs7SYv7uMNcY59mPu+jd+h898Lu7RrDN94DJwmw/HfSZogaTlYAP9iFQZiaQ5G9
	 itPt6Js9yLnynKwp9zZREztssn4+9GfEkeqilZPZa3JQV1W6lpTHf1J5S8ZWF05W3I
	 s9UruRiMh7kDehnxdvIs5qv3ssFec3Q4n9y9i1EM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731045AbgDVKaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:30:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730722AbgDVK0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:26:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 491F42075A;
        Wed, 22 Apr 2020 10:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587551182;
        bh=fGz7a64lWYFN33TvpNVh9lbizXvizlbW6RS4o/D26oI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fcj9RF3Yuk1qWYCkIYRZa84LxB2oIArh8FxoYaloLMXuPm9JZ8bUB8WdTBuDnqB5S
         h5aU7slLfxEnQkMBa40gNkC8flCJAwKtPDr3KDK9pUwks3gnVgDAaazpL0XRzaX1gt
         yC88SNi0UBIkNUBNM+8S/pHGK9EBWNCLHCHFr9Cc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qian Cai <cai@lca.pw>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 134/166] iommu/vt-d: Silence RCU-list debugging warning in dmar_find_atsr()
Date:   Wed, 22 Apr 2020 11:57:41 +0200
Message-Id: <20200422095103.005670022@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095047.669225321@linuxfoundation.org>
References: <20200422095047.669225321@linuxfoundation.org>
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
index 4be5494786918..ef0a5246700e5 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4501,7 +4501,8 @@ static struct dmar_atsr_unit *dmar_find_atsr(struct acpi_dmar_atsr *atsr)
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



