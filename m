Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84329C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57373217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579197850;
	bh=V+XzVa+AJikBr7Z2GJK4sPMp7Mea5rGKpfqLW5wffig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pWtQFUC0WRD7s9jQwYQHeFOuVtIsXsuXUTuKFfwRO/D604LKYph6AtaKEyWdKHdQJ
	 UITnaVAkl6SF/QrhsUPTdwb816UMdvcbTV+f8IF4y9WI/rZlB9E+LEaxDmUx3X7VAU
	 u3nUaMuODmWTi4HBzNMTZNjdvdrFhd+UqgXy758c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393648AbgAPRki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:40:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:56122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393490AbgAPRjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:39:39 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA3DB246D3;
        Thu, 16 Jan 2020 17:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196378;
        bh=V+XzVa+AJikBr7Z2GJK4sPMp7Mea5rGKpfqLW5wffig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NIt4CQZQUwvPA4CmMMlqzw5ySfSy1ifA5x/0N8BM6odICs+GISaoyTpM4boyXesYx
         MSJWPDa3Zup3Ste70DXjW4ux5d/1n0YhK8tRpbSebp91a+9hBOchxudNkMkmTVfEI6
         7e4wybs23wFvSXBVcXoWepDc0FO4ryIs6T5Hh//E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kevin Mitchell <kevmitch@arista.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 4.9 162/251] iommu/amd: Make iommu_disable safer
Date:   Thu, 16 Jan 2020 12:35:11 -0500
Message-Id: <20200116173641.22137-122-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116173641.22137-1-sashal@kernel.org>
References: <20200116173641.22137-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Mitchell <kevmitch@arista.com>

[ Upstream commit 3ddbe913e55516d3e2165d43d4d5570761769878 ]

Make it safe to call iommu_disable during early init error conditions
before mmio_base is set, but after the struct amd_iommu has been added
to the amd_iommu_list. For example, this happens if firmware fails to
fill in mmio_phys in the ACPI table leading to a NULL pointer
dereference in iommu_feature_disable.

Fixes: 2c0ae1720c09c ('iommu/amd: Convert iommu initialization to state machine')
Signed-off-by: Kevin Mitchell <kevmitch@arista.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd_iommu_init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 9bb8d64b6f94..c113e46fdc3a 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -383,6 +383,9 @@ static void iommu_enable(struct amd_iommu *iommu)
 
 static void iommu_disable(struct amd_iommu *iommu)
 {
+	if (!iommu->mmio_base)
+		return;
+
 	/* Disable command buffer */
 	iommu_feature_disable(iommu, CONTROL_CMDBUF_EN);
 
-- 
2.20.1

