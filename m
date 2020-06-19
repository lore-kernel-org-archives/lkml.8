Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B3DC433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72BAC21582
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592579945;
	bh=vxJxC9yvGvWy3BLrCCZpHsuyMgC36pPN9F4rCuq7UuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GNalKQB5vVaq8+6ktyNBupubOmHW28+kujCRe7JXQMxDryyc5fulq3LmnBMvV1A8r
	 2CgsCq+YTu8u8SJXHuZuiHFXMIuoI9Ixv02z44TprYdwPaoKNJCGypir0NFXsfjAaD
	 7hUUhDbtPGmb5Sx3PrfDG1JVgo2+UwQyJYaVX5PE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392348AbgFSPRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:17:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404185AbgFSPRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:17:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF2B22158C;
        Fri, 19 Jun 2020 15:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579844;
        bh=vxJxC9yvGvWy3BLrCCZpHsuyMgC36pPN9F4rCuq7UuU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xAIKfajrGsQPjWowaJuLsLUjj2S3tvdgec1uqb/FHM+5zroKbQ4qk98YjDIrR37lX
         pVABiF5NpKn/ZQzcXrMjN8PXqsVouhW4PsWUosUbQPgY/J7G35DMvPVjmyucnQpDZC
         h5/ITQYublpFI60ZIR69mkdB3220fY0pT7sGJML4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mark Starovoytov <mstarovoitov@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 026/376] net: atlantic: make hw_get_regs optional
Date:   Fri, 19 Jun 2020 16:29:04 +0200
Message-Id: <20200619141711.599901744@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index a369705a786a..e5391e0b84f8 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
@@ -764,6 +764,9 @@ int aq_nic_get_regs(struct aq_nic_s *self, struct ethtool_regs *regs, void *p)
 	u32 *regs_buff = p;
 	int err = 0;
 
+	if (unlikely(!self->aq_hw_ops->hw_get_regs))
+		return -EOPNOTSUPP;
+
 	regs->version = 1;
 
 	err = self->aq_hw_ops->hw_get_regs(self->aq_hw,
@@ -778,6 +781,9 @@ err_exit:
 
 int aq_nic_get_regs_count(struct aq_nic_s *self)
 {
+	if (unlikely(!self->aq_hw_ops->hw_get_regs))
+		return 0;
+
 	return self->aq_nic_cfg.aq_hw_caps->mac_regs_count;
 }
 
-- 
2.25.1



