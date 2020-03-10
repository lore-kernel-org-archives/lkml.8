Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332B6C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA8F24691
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844561;
	bh=VwhYKLy1NhWaPZdxdXJS0pwQhJAtWfm9/KXs9tu/rec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jo3FQWTFWIVhKUTt9po41cLojupy4ZTdZxkS6E+1HBqlqnzF2vSlLlMCZee67Z8pe
	 B2aEcDQHHy1sin95g5/oJkcvyspH7qBeu2Bug+sx62Qeq9vFUXhvtodT5bMu8sB5/l
	 MIKQAm0Qv+HjNSfY+DoDwXOJQ0OBYazHH+V97I9M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgCJMtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:49:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728048AbgCJMtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:49:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B32A24691;
        Tue, 10 Mar 2020 12:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844555;
        bh=VwhYKLy1NhWaPZdxdXJS0pwQhJAtWfm9/KXs9tu/rec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=doGoCfAoYkg8yHZVIpHpM6jJnLvW+4Go/dol16zucaXHNaytOuRwomcvR+/pXpUis
         +4Rk0u/GNLhaM/Kgi2LJUAHHW85QsdWC1yrgK3n/PV2MuxNOKxc2Zt+rX8HeNG8uGI
         8FWz2n5JObCk50ZnVvQ1LuG0BZk46rZtpQzw8zO8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>,
        Mathieu Malaterre <malat@debian.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 035/168] net: ethernet: dm9000: Handle -EPROBE_DEFER in dm9000_parse_dt()
Date:   Tue, 10 Mar 2020 13:38:01 +0100
Message-Id: <20200310123639.066997721@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123635.322799692@linuxfoundation.org>
References: <20200310123635.322799692@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Cercueil <paul@crapouillou.net>

[ Upstream commit 9a6a0dea16177ccaecc116f560232e63bec115f1 ]

The call to of_get_mac_address() can return -EPROBE_DEFER, for instance
when the MAC address is read from a NVMEM driver that did not probe yet.

Cc: H. Nikolaus Schaller <hns@goldelico.com>
Cc: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/davicom/dm9000.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/davicom/dm9000.c b/drivers/net/ethernet/davicom/dm9000.c
index cce90b5925d93..70060c51854fd 100644
--- a/drivers/net/ethernet/davicom/dm9000.c
+++ b/drivers/net/ethernet/davicom/dm9000.c
@@ -1405,6 +1405,8 @@ static struct dm9000_plat_data *dm9000_parse_dt(struct device *dev)
 	mac_addr = of_get_mac_address(np);
 	if (!IS_ERR(mac_addr))
 		ether_addr_copy(pdata->dev_addr, mac_addr);
+	else if (PTR_ERR(mac_addr) == -EPROBE_DEFER)
+		return ERR_CAST(mac_addr);
 
 	return pdata;
 }
-- 
2.20.1



