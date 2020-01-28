Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20C3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E3A20716
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580222645;
	bh=Be7YZYuRAIF1ZEaBBc/ejqKf+IaBvfiPVz5XS2N1jU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bqaOhfXGWt9rmkGTwmHeQOs3AseUFOHnccaqzgHanx6KXSflETTHM9+Fl4fjthTUa
	 mtgi+cwk1yUOcN+Pfi/f77+jQUfKSWYwxW+ZK6CggYzytuVeuU1wv4LpoxeBmLOi4/
	 IejtTmIwOemr++kmG3X3Bfnje7Q3z8zgJwvs94b4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbgA1OoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:44:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:59714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727393AbgA1OKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:10:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5948C20678;
        Tue, 28 Jan 2020 14:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220646;
        bh=Be7YZYuRAIF1ZEaBBc/ejqKf+IaBvfiPVz5XS2N1jU8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OOgZaCOIZPJgBfvaVlKDrOQXsGHbZQHPHRQ8qSanQgCpWzynFngefI9Ly+aqgMP0Y
         Hnck63kE1Pl/CFOY0cRxXBSSM++GN1vt/vT510KzupcMrW1F4jo3PRgln8A8sz2Nig
         EjUMNh61lxKqqRqUYug2UZJS+cWtVnCi0R5U7MYc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Mukesh Ojha <mojha@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 073/183] ehea: Fix a copy-paste err in ehea_init_port_res
Date:   Tue, 28 Jan 2020 15:04:52 +0100
Message-Id: <20200128135837.292617994@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135829.486060649@linuxfoundation.org>
References: <20200128135829.486060649@linuxfoundation.org>
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
index 1a56de06b0140..fdbba588c6dba 100644
--- a/drivers/net/ethernet/ibm/ehea/ehea_main.c
+++ b/drivers/net/ethernet/ibm/ehea/ehea_main.c
@@ -1477,7 +1477,7 @@ static int ehea_init_port_res(struct ehea_port *port, struct ehea_port_res *pr,
 
 	memset(pr, 0, sizeof(struct ehea_port_res));
 
-	pr->tx_bytes = rx_bytes;
+	pr->tx_bytes = tx_bytes;
 	pr->tx_packets = tx_packets;
 	pr->rx_bytes = rx_bytes;
 	pr->rx_packets = rx_packets;
-- 
2.20.1



