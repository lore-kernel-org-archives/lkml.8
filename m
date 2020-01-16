Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5E6C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0650246B4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579196981;
	bh=h18oKnj8xTlOYDI1iH5PKIWAzLyL2+c5srHxbW1Mq/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QrZAW5XSmmOSRlCP2n/G/sJEzBBWJoqpun8bZxfkQ7YJE8+yFQQZXxLq7hEohOtVr
	 EoXbbtt9//SeYDBgbEQnCURDWN2nC2GSULDlUbuvXh/MyuKusntw2foIJcwiMKl8kj
	 kTZDWZnZxab8ZEvHK49RAwidkESS6O9lNkecBgdE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394284AbgAPRtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:49:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:38578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394212AbgAPRqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:46:06 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FDB3246DA;
        Thu, 16 Jan 2020 17:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196766;
        bh=h18oKnj8xTlOYDI1iH5PKIWAzLyL2+c5srHxbW1Mq/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PU7nTW9n81L2WSm1ajeDJGhO8BtvQbOWwOYImx5ed/NI770eRzRDR0yQbQH4O1MMn
         jxxdRkspg2fM52/nOroeH9KITSj5iM1l6a2jazY2uOFrA1W20cCyKoo18QbEK1qwC8
         3a5IzA6/zQ86orOgBAR/FTZkeAVGKCgcKKFDhdIs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Filippo Sironi <sironi@amazon.de>, Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 4.4 139/174] iommu/amd: Wait for completion of IOTLB flush in attach_device
Date:   Thu, 16 Jan 2020 12:42:16 -0500
Message-Id: <20200116174251.24326-139-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116174251.24326-1-sashal@kernel.org>
References: <20200116174251.24326-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Filippo Sironi <sironi@amazon.de>

[ Upstream commit 0b15e02f0cc4fb34a9160de7ba6db3a4013dc1b7 ]

To make sure the domain tlb flush completes before the
function returns, explicitly wait for its completion.

Signed-off-by: Filippo Sironi <sironi@amazon.de>
Fixes: 42a49f965a8d ("amd-iommu: flush domain tlb when attaching a new device")
[joro: Added commit message and fixes tag]
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd_iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 0ad8b7c78a43..66a406e87e11 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2184,6 +2184,8 @@ static int attach_device(struct device *dev,
 	 */
 	domain_flush_tlb_pde(domain);
 
+	domain_flush_complete(domain);
+
 	return ret;
 }
 
-- 
2.20.1

