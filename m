Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDEDC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C12D214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579859757;
	bh=qyyCTX8EsmGpAcO006jT7pkmaovBH/fCxsXbUYNeZSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lbfxPvBj2ZzJ5y6ssPwf0vMdqC+g0Sma52+8umNmulbeZFhcGRYb86SXiFI0wp4j/
	 5N+RlyjwCsOvm9Xkn2EBIDZwUErIFx7f8sXf6tldYNVZzxm+UEXeurUajo+UwnkN06
	 gpGQIxMexLkb4eBOW7iFFPjP1lAAMRbVYySX9bkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388431AbgAXJz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:55:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:59540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731830AbgAXJzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:55:55 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B21EA20718;
        Fri, 24 Jan 2020 09:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579859755;
        bh=qyyCTX8EsmGpAcO006jT7pkmaovBH/fCxsXbUYNeZSI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=054Wb/bwHgKo0jdLnh/OqaxMBOTdQAqloASpLoJ+uVRA3n2bbBab34LrYCxqjL2fZ
         8HAAZhxSVESut9uo04tswKh63S9t1jjiXuLSiF+DUGduoxleozrpKJdl+60ewR/JhH
         Ps3II40lMgoCCB2ATmPVTKtSy73/QNKWHS6nEBAk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Mukesh Ojha <mojha@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 163/343] ehea: Fix a copy-paste err in ehea_init_port_res
Date:   Fri, 24 Jan 2020 10:29:41 +0100
Message-Id: <20200124092941.406796439@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit c8f191282f819ab4e9b47b22a65c6c29734cefce ]

pr->tx_bytes should be assigned to tx_bytes other than
rx_bytes.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: ce45b873028f ("ehea: Fixing statistics")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ibm/ehea/ehea_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ehea/ehea_main.c b/drivers/net/ethernet/ibm/ehea/ehea_main.c
index 30cbdf0fed595..373deb247ac01 100644
--- a/drivers/net/ethernet/ibm/ehea/ehea_main.c
+++ b/drivers/net/ethernet/ibm/ehea/ehea_main.c
@@ -1475,7 +1475,7 @@ static int ehea_init_port_res(struct ehea_port *port, struct ehea_port_res *pr,
 
 	memset(pr, 0, sizeof(struct ehea_port_res));
 
-	pr->tx_bytes = rx_bytes;
+	pr->tx_bytes = tx_bytes;
 	pr->tx_packets = tx_packets;
 	pr->rx_bytes = rx_bytes;
 	pr->rx_packets = rx_packets;
-- 
2.20.1



