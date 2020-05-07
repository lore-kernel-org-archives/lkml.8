Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD54AC54E4B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9454A2083B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588861945;
	bh=fkiihqvs3l6pEIs158rIwq8LwXoqIKl9fUbmIrZefK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ElUmJs/PNfD6OSmbVMfpp1auo5iJLnrdeLPtEZ2qxQ+7lky9QM/DInrGsoHJXW89V
	 8EjNEQwELYeYNT3UelzAUQC418hrAo6jxUvSO144TzHw8htqUcH1OUQFAj+m6CGx4m
	 B+IvgUMjhAurS0V1+rb8HGbBFCXyI96l4k5og7yY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgEGO3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:29:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728630AbgEGO3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:29:40 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80CC3208D6;
        Thu,  7 May 2020 14:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588861780;
        bh=fkiihqvs3l6pEIs158rIwq8LwXoqIKl9fUbmIrZefK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ukA1YBjXab11nqDNIfuMw0nGMxbpd0X6oDtsaLPdQ2qDK+IQvHlhNEWmAAXna6cfZ
         cGTSg0v4TXR9ls7m/ctvYmTiCtLdP+qTwlsbYVHXw/3fV8n1NuI/ng2PS+Tc743+Fl
         qalWGFWtj4/aXUqMG6e+rulCYG2tbYbO8hUT1NwQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 4.19 19/20] iommu/amd: Fix legacy interrupt remapping for x2APIC-enabled system
Date:   Thu,  7 May 2020 10:29:15 -0400
Message-Id: <20200507142917.26612-19-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200507142917.26612-1-sashal@kernel.org>
References: <20200507142917.26612-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

[ Upstream commit b74aa02d7a30ee5e262072a7d6e8deff10b37924 ]

Currently, system fails to boot because the legacy interrupt remapping
mode does not enable 128-bit IRTE (GA), which is required for x2APIC
support.

Fix by using AMD_IOMMU_GUEST_IR_LEGACY_GA mode when booting with
kernel option amd_iommu_intr=legacy instead. The initialization
logic will check GASup and automatically fallback to using
AMD_IOMMU_GUEST_IR_LEGACY if GA mode is not supported.

Fixes: 3928aa3f5775 ("iommu/amd: Detect and enable guest vAPIC support")
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Link: https://lore.kernel.org/r/1587562202-14183-1-git-send-email-suravee.suthikulpanit@amd.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd_iommu_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 465f28a7844c2..2557ed112bc24 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -2836,7 +2836,7 @@ static int __init parse_amd_iommu_intr(char *str)
 {
 	for (; *str; ++str) {
 		if (strncmp(str, "legacy", 6) == 0) {
-			amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY;
+			amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY_GA;
 			break;
 		}
 		if (strncmp(str, "vapic", 5) == 0) {
-- 
2.20.1

