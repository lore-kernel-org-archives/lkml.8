Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2D8C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 04:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E5920936
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 04:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586491323;
	bh=S3kmvQnrFbm9NwxUbbMXxAAdzCLFDFuaxgikDn3OQNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yGMuUFJ5+1/NKosEzKlYTJKI1Fbmp8CI1YdNwhXpGMuBBue8InDJk5jkar1g2L+QV
	 e6x1EgLLuPhwssWNPyqW6gSW16K/WSwqCk7fasGL9i7Dcu8XGfqZqg818VgWLdILMC
	 andVt00G3scv1sV4ioS7z48er6Dhtwpgay6HNVlY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgDJECA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 00:02:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727184AbgDJDrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 23:47:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49D752145D;
        Fri, 10 Apr 2020 03:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586490437;
        bh=S3kmvQnrFbm9NwxUbbMXxAAdzCLFDFuaxgikDn3OQNU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TYHVaotxENCDde4ri9dpq3Hu4hmj3N8GY+xHXRj+/w29mvjU04TVLH2NyIPxbVOE0
         QLULypB2YNhlWwLAX4JQXNQQJ1BiCx4O4iNW5aAbJW9JJrWsuHYdAyAjRZlefmidOB
         WCnga+5oUKhHPFq91d+0FnmITjsX2eMid52cCvs0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marc Zyngier <maz@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>,
        Eric Auger <eric.auger@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.6 34/68] irqchip/gic-v4.1: Skip absent CPUs while iterating over redistributors
Date:   Thu,  9 Apr 2020 23:45:59 -0400
Message-Id: <20200410034634.7731-34-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200410034634.7731-1-sashal@kernel.org>
References: <20200410034634.7731-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <maz@kernel.org>

[ Upstream commit 28d160de5194c68ff534443d2a8b6f1d10d57c58 ]

In a system that is only sparsly populated with CPUs, we can end-up with
redistributors structures that are not initialized. Let's make sure we
don't try and access those when iterating over them (in this case when
checking we have a L2 VPE table).

Fixes: 4e6437f12d6e ("irqchip/gic-v4.1: Ensure L2 vPE table is allocated at RD level")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Link: https://lore.kernel.org/r/20200304203330.4967-3-maz@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 83b1186ffcad0..da883a6910284 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2452,6 +2452,10 @@ static bool allocate_vpe_l2_table(int cpu, u32 id)
 	if (!gic_rdists->has_rvpeid)
 		return true;
 
+	/* Skip non-present CPUs */
+	if (!base)
+		return true;
+
 	val  = gicr_read_vpropbaser(base + SZ_128K + GICR_VPROPBASER);
 
 	esz  = FIELD_GET(GICR_VPROPBASER_4_1_ENTRY_SIZE, val) + 1;
-- 
2.20.1

