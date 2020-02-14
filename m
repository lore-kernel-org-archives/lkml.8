Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60987C3B1A4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE572067D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581699403;
	bh=Uh+F+K4G4VhwM0jMFoF67RQma0Fxf9NzqW3BVuHHRXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fE/opAcu+NhwgblTtwvG83Hh80t8u6+ndnOfI8W8TyXam4oUO5a98jfrPlmJTnX28
	 ptTtryEsEIDAB1mRUb6B0JTg8esG79DGqAsy9LR8ck20/9Th/76xh4Pyat+NTmkBSB
	 f4URAZSiSQuPVPOKyD2y40uEBkU/YNii9FaM+jJw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404614AbgBNQR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:17:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:47874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404051AbgBNQQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:16:51 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43F5024681;
        Fri, 14 Feb 2020 16:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697010;
        bh=Uh+F+K4G4VhwM0jMFoF67RQma0Fxf9NzqW3BVuHHRXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RC4XDh00owcp+QrZzZGDN3mXkqJP4PwGyujPfOXFIkZ6l/lSi896emJZ0I4yjL+3D
         1tmAWRUC2L1Wh8mxUU6JFfd20GBlg3NyqmCG9orhUKr3jOHQMg9bnz9QB3CEWfh1eq
         pm/ahn2HO+aaWvOUW1ckQ2PnBbsRCloBvmOMuOHs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zenghui Yu <yuzenghui@huawei.com>, Marc Zyngier <maz@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 241/252] irqchip/gic-v3-its: Reference to its_invall_cmd descriptor when building INVALL
Date:   Fri, 14 Feb 2020 11:11:36 -0500
Message-Id: <20200214161147.15842-241-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161147.15842-1-sashal@kernel.org>
References: <20200214161147.15842-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zenghui Yu <yuzenghui@huawei.com>

[ Upstream commit 107945227ac5d4c37911c7841b27c64b489ce9a9 ]

It looks like an obvious mistake to use its_mapc_cmd descriptor when
building the INVALL command block. It so far worked by luck because
both its_mapc_cmd.col and its_invall_cmd.col sit at the same offset of
the ITS command descriptor, but we should not rely on it.

Fixes: cc2d3216f53c ("irqchip: GICv3: ITS command queue")
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20191202071021.1251-1-yuzenghui@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 050d6e040128d..bf7b69449b438 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -578,7 +578,7 @@ static struct its_collection *its_build_invall_cmd(struct its_node *its,
 						   struct its_cmd_desc *desc)
 {
 	its_encode_cmd(cmd, GITS_CMD_INVALL);
-	its_encode_collection(cmd, desc->its_mapc_cmd.col->col_id);
+	its_encode_collection(cmd, desc->its_invall_cmd.col->col_id);
 
 	its_fixup_cmd(cmd);
 
-- 
2.20.1

