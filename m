Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6C3C4332D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10CED20409
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584565495;
	bh=pzcPdQhupRlmCAI9v65WsirZbfz7Rj/Nmuo4MKCKWIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zk+r6Q5Ixd8YFzJsPI+j8iK7RPVIcF75l2xVnzcnOCZGuWkpIc9g5eLfN3f54txPZ
	 btF2DIrw3CqMPgcg6XZmH8gtmE2Whiw2pnGC8++rHdE9pvknoliQfQOwagT9tQjw/Z
	 aVl2Xrbsb95VTAeawvt3MqXdROKo4d7ee2Vj+CI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbgCRVEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 17:04:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728195AbgCRUzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 16:55:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CAA1208E4;
        Wed, 18 Mar 2020 20:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584564906;
        bh=pzcPdQhupRlmCAI9v65WsirZbfz7Rj/Nmuo4MKCKWIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wb1gthT8nkhrMQ1z/qrGNoNPL0LQcOQ5qOY9d+9hsV5RS6/aeDwSwcxXavJ95UYvd
         tx9H/5J7Hx6Ip5kEtGnUycUkZrkoIcT7ycX7vFDbuYWHaJesIcnlm7qMpiLnXw6yBf
         ulNa3LNW2muZEMoac9NjRNaFxt0id+8Cy55w7eA0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 5.4 72/73] iommu/amd: Fix IOMMU AVIC not properly update the is_run bit in IRTE
Date:   Wed, 18 Mar 2020 16:53:36 -0400
Message-Id: <20200318205337.16279-72-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200318205337.16279-1-sashal@kernel.org>
References: <20200318205337.16279-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

[ Upstream commit 730ad0ede130015a773229573559e97ba0943065 ]

Commit b9c6ff94e43a ("iommu/amd: Re-factor guest virtual APIC
(de-)activation code") accidentally left out the ir_data pointer when
calling modity_irte_ga(), which causes the function amd_iommu_update_ga()
to return prematurely due to struct amd_ir_data.ref is NULL and
the "is_run" bit of IRTE does not get updated properly.

This results in bad I/O performance since IOMMU AVIC always generate GA Log
entry and notify IOMMU driver and KVM when it receives interrupt from the
PCI pass-through device instead of directly inject interrupt to the vCPU.

Fixes by passing ir_data when calling modify_irte_ga() as done previously.

Fixes: b9c6ff94e43a ("iommu/amd: Re-factor guest virtual APIC (de-)activation code")
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd_iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 8bd5d608a82c2..bc77714983421 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -4421,7 +4421,7 @@ int amd_iommu_activate_guest_mode(void *data)
 	entry->lo.fields_vapic.ga_tag      = ir_data->ga_tag;
 
 	return modify_irte_ga(ir_data->irq_2_irte.devid,
-			      ir_data->irq_2_irte.index, entry, NULL);
+			      ir_data->irq_2_irte.index, entry, ir_data);
 }
 EXPORT_SYMBOL(amd_iommu_activate_guest_mode);
 
@@ -4447,7 +4447,7 @@ int amd_iommu_deactivate_guest_mode(void *data)
 				APICID_TO_IRTE_DEST_HI(cfg->dest_apicid);
 
 	return modify_irte_ga(ir_data->irq_2_irte.devid,
-			      ir_data->irq_2_irte.index, entry, NULL);
+			      ir_data->irq_2_irte.index, entry, ir_data);
 }
 EXPORT_SYMBOL(amd_iommu_deactivate_guest_mode);
 
-- 
2.20.1

