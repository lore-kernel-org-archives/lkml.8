Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403E3C433F2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1349B2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595859703;
	bh=aJMqigb34Dubd5tY2sT5LEuMGU4M7GKg1c09Z+B65LA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RsV3L1azDUqLs8O0i3mUgW1u7w8+sZPw0woYS59ozvf6/yp43ma1fcj/ADUpzfsxc
	 twLgFJkH+P3brngr2AfWvb5x1Kygr+jkHku5cmaZWXuqvVIG60rDUW4JTasGYiyzbq
	 PpqUxFhIZVdwP/qTUn26xC5UHbJ8WOey0yukNhdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731774AbgG0OVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:21:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730258AbgG0OVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:21:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7153F2070B;
        Mon, 27 Jul 2020 14:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859698;
        bh=aJMqigb34Dubd5tY2sT5LEuMGU4M7GKg1c09Z+B65LA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yB/zpXSPQaLm2UVv7v1F7Uvdba7NrPf6b0Djk6ogpiGyUohiZSZ9xvMw6at4z+h59
         cV4QnIWD0XjS1EhfYM1e+Zs/apXDXEJBKpCEVIrYZKEvvl05hpDJ38MgCf3H11vmzb
         XWNh25an7srSAPkcoytFAPe0cj5U/zPN+b9n7dJ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shannon Nelson <snelson@pensando.io>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 070/179] ionic: use offset for ethtool regs data
Date:   Mon, 27 Jul 2020 16:04:05 +0200
Message-Id: <20200727134936.091115895@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134932.659499757@linuxfoundation.org>
References: <20200727134932.659499757@linuxfoundation.org>
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
index 22430fa911e2c..63d78519cbc6f 100644
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



