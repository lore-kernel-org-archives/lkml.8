Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B23C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB87B2080A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599498767;
	bh=WaRb99NzFLhjb/eGzI25XFiRr/1YBLnkQgsNKe0DdCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wWARnB35Y5uwR/OAJbAlxI7unolnDGHr1wmz9QahrHvW1+EpFiRTYFsOXXWSMBE1H
	 Keq8FzSSjrlu1PJ5lQXkRpZFSvaDIVXpt2mFjooBtuFC6XW8HjoqKewcfyu0hEWivT
	 bsd7LH75TVumERX1FPaiQKqrLsvBpOj7ziLYZaz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731218AbgIGRMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:12:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:46422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729859AbgIGQca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:32:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 213A22177B;
        Mon,  7 Sep 2020 16:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599496350;
        bh=WaRb99NzFLhjb/eGzI25XFiRr/1YBLnkQgsNKe0DdCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fxxWJiGInPvYT7ElImhDMyFl6oG4I/e4FtMy+DgfGyy0resQdhHrWxiv2QsSyrJiU
         IcyvxYWVb5LhOPEIOxAVoIIr+biJ+ADiaIh314s+hNUZWK8n3d9jjhqzLOEll6MX0c
         FxC2S+WOsbke+ipT9bLb3PAge/3eLQhBJb85+knA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xie He <xie.he.0141@gmail.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Martin Schiller <ms@dev.tdt.de>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 07/53] drivers/net/wan/lapbether: Added needed_tailroom
Date:   Mon,  7 Sep 2020 12:31:33 -0400
Message-Id: <20200907163220.1280412-7-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907163220.1280412-1-sashal@kernel.org>
References: <20200907163220.1280412-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xie He <xie.he.0141@gmail.com>

[ Upstream commit 1ee39c1448c4e0d480c5b390e2db1987561fb5c2 ]

The underlying Ethernet device may request necessary tailroom to be
allocated by setting needed_tailroom. This driver should also set
needed_tailroom to request the tailroom needed by the underlying
Ethernet device to be allocated.

Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Martin Schiller <ms@dev.tdt.de>
Signed-off-by: Xie He <xie.he.0141@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wan/lapbether.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wan/lapbether.c b/drivers/net/wan/lapbether.c
index 1ea15f2123ed5..cc297ea9c6ece 100644
--- a/drivers/net/wan/lapbether.c
+++ b/drivers/net/wan/lapbether.c
@@ -340,6 +340,7 @@ static int lapbeth_new_device(struct net_device *dev)
 	 */
 	ndev->needed_headroom = -1 + 3 + 2 + dev->hard_header_len
 					   + dev->needed_headroom;
+	ndev->needed_tailroom = dev->needed_tailroom;
 
 	lapbeth = netdev_priv(ndev);
 	lapbeth->axdev = ndev;
-- 
2.25.1

