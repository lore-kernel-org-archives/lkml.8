Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B6FC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EBDA20702
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580222221;
	bh=8OzNsdy4d7Ke874WxL42U1gN9E01qAY2+swLm2PIZCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g9yCIs7bpkGI2rX6Kvdck0/caFejpdd6EMW8XBSTyS0+SxF1e9aimZFPbxq28jlXK
	 OhXwhS2DIRyZjoV4V5cLbWIEsj8G+i3kelsTqsTcIwiFNqHsnN6OWQ7ur+86DuSJ0c
	 coWr82s9Q5Aunz2hqqmwrPtlQgg7Cj3On7bKJhCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731161AbgA1OU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:20:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:45940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731145AbgA1OUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:20:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD20E21739;
        Tue, 28 Jan 2020 14:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221251;
        bh=8OzNsdy4d7Ke874WxL42U1gN9E01qAY2+swLm2PIZCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fNq+XUryZfLNT48sMMxNjNS5A6MeMpiVfU+7hCaHLEA0/Md03ISP2+ipHPMrnu7GO
         MCyA3NdhMF8yI4dBoSyNZYaaSmq+Wo8XC5+H+CjuSGq5w0WJsLsSHQvWTbbqt6oWjx
         /BkVjfoDsum2EPoRDPIjnmo1Iw8/H/Fe5DI2mBfM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Mukesh Ojha <mojha@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 113/271] ehea: Fix a copy-paste err in ehea_init_port_res
Date:   Tue, 28 Jan 2020 15:04:22 +0100
Message-Id: <20200128135900.987677866@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
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
index 2dd17e01e3a7a..3692adb8902d1 100644
--- a/drivers/net/ethernet/ibm/ehea/ehea_main.c
+++ b/drivers/net/ethernet/ibm/ehea/ehea_main.c
@@ -1476,7 +1476,7 @@ static int ehea_init_port_res(struct ehea_port *port, struct ehea_port_res *pr,
 
 	memset(pr, 0, sizeof(struct ehea_port_res));
 
-	pr->tx_bytes = rx_bytes;
+	pr->tx_bytes = tx_bytes;
 	pr->tx_packets = tx_packets;
 	pr->rx_bytes = rx_bytes;
 	pr->rx_packets = rx_packets;
-- 
2.20.1



