Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5367AC4332D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB2A20777
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584565717;
	bh=Ovh5rchl63BVW/eFK9nsn45vGkmK1FT0ehnpuAHunGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xkBeMbiBGL0fo89+z58dj/R5x/QRuhglSF4q4DysMEukA6HjUi3mrIrTS2MHUTj4k
	 NmOpIHO4nOjSpWWGM1/Pd2+5vfcnfctXy+dV67i1UM/6RNT0usmM8N2kDxkfzb4vGz
	 k4EsNObifF+xDp1hg0gMhJ+LAOKlo8BfUUUpPrYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbgCRUx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 16:53:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbgCRUx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 16:53:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18AC22145D;
        Wed, 18 Mar 2020 20:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584564837;
        bh=Ovh5rchl63BVW/eFK9nsn45vGkmK1FT0ehnpuAHunGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xyDefM4PLcFzPFOiahKDEWKNubnbsIKKrC+FgOCMm8SXI1cu0TEUym5Qc5xVGndFZ
         QfUVwM5bjsx9QB9zZmIp8iUNmSRDirQscZBX+FiBrIeMJQcNZ6Bdl2UHBPKNmel6Ve
         qqR0rGYbOo6Yk0Ou9GWttb9VP1BSXOP0fNvVwt6g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 17/73] macsec: add missing attribute validation for port
Date:   Wed, 18 Mar 2020 16:52:41 -0400
Message-Id: <20200318205337.16279-17-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200318205337.16279-1-sashal@kernel.org>
References: <20200318205337.16279-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 31d9a1c524964bac77b7f9d0a1ac140dc6b57461 ]

Add missing attribute validation for IFLA_MACSEC_PORT
to the netlink policy.

Fixes: c09440f7dcb3 ("macsec: introduce IEEE 802.1AE driver")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/macsec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index afd8b2a082454..9dbe218eed1da 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -2977,6 +2977,7 @@ static const struct device_type macsec_type = {
 
 static const struct nla_policy macsec_rtnl_policy[IFLA_MACSEC_MAX + 1] = {
 	[IFLA_MACSEC_SCI] = { .type = NLA_U64 },
+	[IFLA_MACSEC_PORT] = { .type = NLA_U16 },
 	[IFLA_MACSEC_ICV_LEN] = { .type = NLA_U8 },
 	[IFLA_MACSEC_CIPHER_SUITE] = { .type = NLA_U64 },
 	[IFLA_MACSEC_WINDOW] = { .type = NLA_U32 },
-- 
2.20.1

