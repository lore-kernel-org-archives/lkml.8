Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBE4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30F182067B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591726810;
	bh=TxT4HgKP8cxjnm29rmgpIbDnAgilIC2D7Ig1uEnXgPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dRcYFcvjeEEn8hpn2ntI1QKhIp2q6znl1JIRo1cZCNW9RIE/VThQnoqPrxnGJEomQ
	 0qm8NY58QO+SG7cT58jGMgdPxG/aNkr+wJy042ceah+pCuXZQ81CcEtYLHmyVqDZhQ
	 TVXieO18GrXxgIDy6gftqWgpnz6UkLiHulXAtg6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388888AbgFISUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:20:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731058AbgFIRtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:49:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A2072081A;
        Tue,  9 Jun 2020 17:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591724959;
        bh=TxT4HgKP8cxjnm29rmgpIbDnAgilIC2D7Ig1uEnXgPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AnHD+vB3UsJLMJ+Q+2vmUQ0eHBEzGamAT2RFArJqRBZMrcE9WkC9jGQw0FSR1VXDM
         JDuIeKAeXAiLMzozDXJKhMzbA/xEwMNfB6tlSMeoFwRF/d4xd2UpO0eaarGa4EUyhw
         QW3MN4UDaCicoeb4NXv4Jh9D3i0dkHwICoGnSwAA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeremy Kerr <jk@ozlabs.org>,
        Stan Johnson <userm57@yahoo.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 11/46] net: bmac: Fix read of MAC address from ROM
Date:   Tue,  9 Jun 2020 19:44:27 +0200
Message-Id: <20200609174023.912758807@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609174022.938987501@linuxfoundation.org>
References: <20200609174022.938987501@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Kerr <jk@ozlabs.org>

[ Upstream commit ef01cee2ee1b369c57a936166483d40942bcc3e3 ]

In bmac_get_station_address, We're reading two bytes at a time from ROM,
but we do that six times, resulting in 12 bytes of read & writes. This
means we will write off the end of the six-byte destination buffer.

This change fixes the for-loop to only read/write six bytes.

Based on a proposed fix from Finn Thain <fthain@telegraphics.com.au>.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Reported-by: Stan Johnson <userm57@yahoo.com>
Tested-by: Stan Johnson <userm57@yahoo.com>
Reported-by: Finn Thain <fthain@telegraphics.com.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/apple/bmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/apple/bmac.c b/drivers/net/ethernet/apple/bmac.c
index eac740c476ce..a8b462e1beba 100644
--- a/drivers/net/ethernet/apple/bmac.c
+++ b/drivers/net/ethernet/apple/bmac.c
@@ -1187,7 +1187,7 @@ bmac_get_station_address(struct net_device *dev, unsigned char *ea)
 	int i;
 	unsigned short data;
 
-	for (i = 0; i < 6; i++)
+	for (i = 0; i < 3; i++)
 		{
 			reset_and_select_srom(dev);
 			data = read_srom(dev, i + EnetAddressOffset/2, SROMAddressBits);
-- 
2.25.1



