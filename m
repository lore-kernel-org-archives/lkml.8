Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9039FC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64D032068D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591659475;
	bh=BbxdWGnvVlDQStaBtcIGrsZkW4bEhkfCkN1SYoePdjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UZnGa670y0PAp4mCsN9WTH4Va536e9m/72pzExbL7yLOsbBvzcxl60wKJj018aBEn
	 BLZ7Tu+M6ZdtV1wm+xmSoOmv8qCxs68WLD+RuCglMx1SGrwlgoPBdZ8WeVr4nNT54v
	 bMWlkiPfMUuuj3kw5DFadJ+xo5tVAoI+wrOHg2Fk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732221AbgFHX2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:28:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:47656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731369AbgFHXWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:22:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5E7F20872;
        Mon,  8 Jun 2020 23:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658568;
        bh=BbxdWGnvVlDQStaBtcIGrsZkW4bEhkfCkN1SYoePdjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AB+ZO2bdd6QxE8zSZApCgDq7xa3i99poCVQBZxZYQ0PVwVmX5xo5gaTWeM/j0f0zf
         qdbXEyMiEsXeItUtcY3fiUPhFhyqxDQVMqHL4eTahQu8+658oT6Fs6XfeJHEjppImj
         jWmBU6u9FQn7qoI9y8skFgJ3ibGOqmKQJYqYVils=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mark Starovoytov <mstarovoitov@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 008/106] net: atlantic: make hw_get_regs optional
Date:   Mon,  8 Jun 2020 19:21:00 -0400
Message-Id: <20200608232238.3368589-8-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608232238.3368589-1-sashal@kernel.org>
References: <20200608232238.3368589-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Starovoytov <mstarovoitov@marvell.com>

[ Upstream commit d0f23741c202c685447050713907f3be39a985ee ]

This patch fixes potential crash in case if hw_get_regs is NULL.

Signed-off-by: Mark Starovoytov <mstarovoitov@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
index 15dcfb6704e5..adac5df0d6b4 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
@@ -620,6 +620,9 @@ int aq_nic_get_regs(struct aq_nic_s *self, struct ethtool_regs *regs, void *p)
 	u32 *regs_buff = p;
 	int err = 0;
 
+	if (unlikely(!self->aq_hw_ops->hw_get_regs))
+		return -EOPNOTSUPP;
+
 	regs->version = 1;
 
 	err = self->aq_hw_ops->hw_get_regs(self->aq_hw,
@@ -634,6 +637,9 @@ int aq_nic_get_regs(struct aq_nic_s *self, struct ethtool_regs *regs, void *p)
 
 int aq_nic_get_regs_count(struct aq_nic_s *self)
 {
+	if (unlikely(!self->aq_hw_ops->hw_get_regs))
+		return 0;
+
 	return self->aq_nic_cfg.aq_hw_caps->mac_regs_count;
 }
 
-- 
2.25.1

