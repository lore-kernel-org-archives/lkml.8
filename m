Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19C9C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACAFD2063A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587046731;
	bh=S3kmvQnrFbm9NwxUbbMXxAAdzCLFDFuaxgikDn3OQNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sbc2mo9rVHaUvOIwECWwYcKTfDdV4+mrd5KA0gY0WxN2YkvFmqHBbki2LSyVvFuYJ
	 CUQHXxeuzdjV0cCRdywgxU/+axSy0zuc7PL1nU5oBQ8CIGILqqXzDjFDELPp/NaYAI
	 +wUFaAgoYoTOCikhgPjIY7ck8dljboZOczruWFug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442303AbgDPOSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:18:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408948AbgDPNxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:53:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9920321927;
        Thu, 16 Apr 2020 13:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045193;
        bh=S3kmvQnrFbm9NwxUbbMXxAAdzCLFDFuaxgikDn3OQNU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F6NYv3N9VSUuNb4TGlCzqPBaGTCb+xRbw2OpW5BoGkRbfIxp+uD2ktrTFtXeiCLn5
         tean/nj2LoQA7211SkZ4X8z8xOXtX7fMMAoIejfDvdkYYvnU5OjqcH+kjATPH0eioj
         1JVqUkCza1BnCLkYRBHw68i5zVcWeaP8IAULKYlA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Eric Auger <eric.auger@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 034/254] irqchip/gic-v4.1: Skip absent CPUs while iterating over redistributors
Date:   Thu, 16 Apr 2020 15:22:03 +0200
Message-Id: <20200416131330.131517661@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.804095985@linuxfoundation.org>
References: <20200416131325.804095985@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



