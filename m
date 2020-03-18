Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB3AC4332E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ABB5208E0
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584565113;
	bh=wX77u3Iu7CzdmteVdcnCZC7NOOHtdLSWOkJXPhZcwkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YEKdHZYzyaYCvTITnvZcGhtNHKcIwd4+zgo57cbyGXDi8UhPgfdU1IG6L4BfWK45B
	 iDURhaKabfawGVSQHn59r+JjcIVBuXvZ73F4bLBrHpfMXvqWDIwQ1fA6jryGSCOtKf
	 Vtoe9sQUbGfigbgBvfsaITqBzut/XTqkQcM3SMjs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgCRU6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 16:58:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:58528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727427AbgCRU5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 16:57:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32E7D208FE;
        Wed, 18 Mar 2020 20:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584565022;
        bh=wX77u3Iu7CzdmteVdcnCZC7NOOHtdLSWOkJXPhZcwkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YS6eBY9nZSVFs0Ms4n0g/414AIDFkwxKQLgqChme5hpP+swUD7YvG36p+Bl9gB5O9
         2ENNezbZuyU+f7aXjGaI8XZTBJRpWO5GWGYgwmcwyVahFrYdvGzMuM794slLK/3ZCi
         ideivAZcCww972Vo+QiPPQJgEC3mD6Ew5RxuCW3Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 4.4 12/12] iommu/vt-d: Fix the wrong printing in RHSA parsing
Date:   Wed, 18 Mar 2020 16:56:48 -0400
Message-Id: <20200318205648.17937-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200318205648.17937-1-sashal@kernel.org>
References: <20200318205648.17937-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhenzhong Duan <zhenzhong.duan@gmail.com>

[ Upstream commit b0bb0c22c4db623f2e7b1a471596fbf1c22c6dc5 ]

When base address in RHSA structure doesn't match base address in
each DRHD structure, the base address in last DRHD is printed out.

This doesn't make sense when there are multiple DRHD units, fix it
by printing the buggy RHSA's base address.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
Fixes: fd0c8894893cb ("intel-iommu: Set a more specific taint flag for invalid BIOS DMAR tables")
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/dmar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index cbad1926cec1e..bfa442d91e3bd 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -473,7 +473,7 @@ static int dmar_parse_one_rhsa(struct acpi_dmar_header *header, void *arg)
 		1, TAINT_FIRMWARE_WORKAROUND,
 		"Your BIOS is broken; RHSA refers to non-existent DMAR unit at %llx\n"
 		"BIOS vendor: %s; Ver: %s; Product Version: %s\n",
-		drhd->reg_base_addr,
+		rhsa->base_address,
 		dmi_get_system_info(DMI_BIOS_VENDOR),
 		dmi_get_system_info(DMI_BIOS_VERSION),
 		dmi_get_system_info(DMI_PRODUCT_VERSION));
-- 
2.20.1

