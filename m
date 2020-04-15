Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E068C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F321820737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586955928;
	bh=L2mnsrtXI6WPK/FDKmAyKYl2fu/wyu8NGUz3KTMXS2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PogtBNqBhdTG/L8YmfLeScch41SzQLSs+8OXNsNeMg5h+L+wfI6KjtbMlK4Vm1bWC
	 J1Zpz80Oz/g5kCi1WEuj8Tc/peeR78xgS1bRy9po12Qfgy2B1lvzf1PMVwnANp0UWB
	 iC2pxCf5d7+9aDIdOTD8TLKG9rinpGlS7HysV3DM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505906AbgDONFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 09:05:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897129AbgDOLgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:36:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B041020775;
        Wed, 15 Apr 2020 11:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586950575;
        bh=L2mnsrtXI6WPK/FDKmAyKYl2fu/wyu8NGUz3KTMXS2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ltxFUR2j/tLVeD2QEO4tWaamLoXD2QcGQ/WdyV5zFvpjJfMlyMsPiIwDJaglZ1wWU
         uV3bpbi0IGIxUHIp1iWD+nRrFEuX1aGQ57O7KxNGflpL/csHrQ1GyaoCVdGBGPKwfs
         t7+cvMmq6tNrSuynHbf/5rxwMxRhclS6LlPK/txI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Davide Caratti <dcaratti@redhat.com>,
        syzbot+7022ab7c383875c17eff@syzkaller.appspotmail.com,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 076/129] macsec: fix NULL dereference in macsec_upd_offload()
Date:   Wed, 15 Apr 2020 07:33:51 -0400
Message-Id: <20200415113445.11881-76-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415113445.11881-1-sashal@kernel.org>
References: <20200415113445.11881-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davide Caratti <dcaratti@redhat.com>

[ Upstream commit aa81700cf2326e288c9ca1fe7b544039617f1fc2 ]

macsec_upd_offload() gets the value of MACSEC_OFFLOAD_ATTR_TYPE
without checking its presence in the request message, and this causes
a NULL dereference. Fix it rejecting any configuration that does not
include this attribute.

Reported-and-tested-by: syzbot+7022ab7c383875c17eff@syzkaller.appspotmail.com
Fixes: dcb780fb2795 ("net: macsec: add nla support for changing the offloading selection")
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/macsec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 92bc2b2df6603..3cd1b13dffe5f 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -2398,6 +2398,9 @@ static int macsec_upd_offload(struct sk_buff *skb, struct genl_info *info)
 		return PTR_ERR(dev);
 	macsec = macsec_priv(dev);
 
+	if (!tb_offload[MACSEC_OFFLOAD_ATTR_TYPE])
+		return -EINVAL;
+
 	offload = nla_get_u8(tb_offload[MACSEC_OFFLOAD_ATTR_TYPE]);
 	if (macsec->offload == offload)
 		return 0;
-- 
2.20.1

