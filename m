Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511F8C433F7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26703206E7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595860545;
	bh=H/OM6/a8M3t7VNB7Ov8Of+TDljr1vmXMWpv38rk0khQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Nokvqo1vdyF5AkrCylxxoJrrrwQcltMhxZBsnvKlLhWfuyJnlIkvJP+zpeZwFIxsm
	 4kADUCmXU4DyV8mlHmflEG889D6h3pMMf+pEfpI1h3UFfA90NrlnoDZ7YwzV4K/N1S
	 Saq0Y3P/b2mqbHjH9AELq5IUABqxpokZaeHHnqmw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732926AbgG0Ofo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:35:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:40790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730606AbgG0OOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:14:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D84422173E;
        Mon, 27 Jul 2020 14:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859289;
        bh=H/OM6/a8M3t7VNB7Ov8Of+TDljr1vmXMWpv38rk0khQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CNHovnEFmgGSrkj7B4Io9eSoMq/eb8mG+FwwIuKsoot3qpXcISlGnwxPvvzma4blA
         Le0uDPVJcHBHLhL6d1jbz2GVejt/5Tl1KG0O1sygCOLcolvxSVD7WM0+r7f1p+4/oZ
         rJ2PpehChSAUMcN5UwT50TCTGVTd5M8Y6eA54JSA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shannon Nelson <snelson@pensando.io>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 051/138] ionic: use offset for ethtool regs data
Date:   Mon, 27 Jul 2020 16:04:06 +0200
Message-Id: <20200727134927.908289915@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134925.228313570@linuxfoundation.org>
References: <20200727134925.228313570@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shannon Nelson <snelson@pensando.io>

[ Upstream commit f85ae16f924f92a370b81b4e77862c1c59882fce ]

Use an offset to write the second half of the regs data into the
second half of the buffer instead of overwriting the first half.

Fixes: 4d03e00a2140 ("ionic: Add initial ethtool support")
Signed-off-by: Shannon Nelson <snelson@pensando.io>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index 7d10265f782a6..5aacc00962df7 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -102,15 +102,18 @@ static void ionic_get_regs(struct net_device *netdev, struct ethtool_regs *regs,
 			   void *p)
 {
 	struct ionic_lif *lif = netdev_priv(netdev);
+	unsigned int offset;
 	unsigned int size;
 
 	regs->version = IONIC_DEV_CMD_REG_VERSION;
 
+	offset = 0;
 	size = IONIC_DEV_INFO_REG_COUNT * sizeof(u32);
-	memcpy_fromio(p, lif->ionic->idev.dev_info_regs->words, size);
+	memcpy_fromio(p + offset, lif->ionic->idev.dev_info_regs->words, size);
 
+	offset += size;
 	size = IONIC_DEV_CMD_REG_COUNT * sizeof(u32);
-	memcpy_fromio(p, lif->ionic->idev.dev_cmd_regs->words, size);
+	memcpy_fromio(p + offset, lif->ionic->idev.dev_cmd_regs->words, size);
 }
 
 static int ionic_get_link_ksettings(struct net_device *netdev,
-- 
2.25.1



