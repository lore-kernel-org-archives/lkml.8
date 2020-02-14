Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10967C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F3A246AD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581696738;
	bh=8oWWFICifQz6wo/aYwrUzW2cWKlMoWhyaLIk7Z/s6FM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GO+6JYgfPRPVZ2nXey/G7iDVb8rfhMDuxuZ6jUGAX0sfs8yINXhYyxtVd6TapuO5L
	 E5WUcqfahsk9NuIZ3ORb5HTi+Ox3QWE3vqRWKW/GEzoho7GhfB4nfKoDEe6nRVfVJJ
	 WP5J7wpmbRdB8ZoUq1u8epNFo09e6cZ7mIo1kP0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391954AbgBNQMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:12:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:37640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391717AbgBNQLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:11:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4476524680;
        Fri, 14 Feb 2020 16:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696669;
        bh=8oWWFICifQz6wo/aYwrUzW2cWKlMoWhyaLIk7Z/s6FM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NsjJqP7LV/qlmlr1NqmVq8wmtyIMoWnU1hj6wIQFhqzJvaBfXQraMPARpmR82IlqM
         TTlQ7/U1GsuU9QP8jv5KDdiCgJzJDFHaDRaAz7X6kCGYB+2CqNgcH+VD99N8yRymxW
         17Xa6hiLdIVH94mI2L9g+aM8TGHFi5Ps/MznYQlU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zenghui Yu <yuzenghui@huawei.com>, Marc Zyngier <maz@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 439/459] irqchip/gic-v3-its: Reference to its_invall_cmd descriptor when building INVALL
Date:   Fri, 14 Feb 2020 11:01:29 -0500
Message-Id: <20200214160149.11681-439-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
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
index 787e8eec9a7f1..11f3b50dcdcb8 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -571,7 +571,7 @@ static struct its_collection *its_build_invall_cmd(struct its_node *its,
 						   struct its_cmd_desc *desc)
 {
 	its_encode_cmd(cmd, GITS_CMD_INVALL);
-	its_encode_collection(cmd, desc->its_mapc_cmd.col->col_id);
+	its_encode_collection(cmd, desc->its_invall_cmd.col->col_id);
 
 	its_fixup_cmd(cmd);
 
-- 
2.20.1

