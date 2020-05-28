Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E40C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74A2921548
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590667826;
	bh=SoHylZ6iLn+VLc0OHY0aK98CsyxfdDPEAMQscWGk9iA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EXQT8xGjwqfc9s2OFb0NmjeSf/mVil3/HojWWiBiWnHcw8rLwQKPuAFw67xnofTyb
	 FdSPB1T50JnSw6UCIUt451DuSIeshz3vzThoZ7Dm7TlBQgUGldDBwIse4xG1EeOX0s
	 YVDLGyoPHktO7KwMDbmSVO9fh/xtSeCIGtq6eGWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389455AbgE1MKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 08:10:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:48358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388686AbgE1L4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:56:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76612208E4;
        Thu, 28 May 2020 11:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590666979;
        bh=SoHylZ6iLn+VLc0OHY0aK98CsyxfdDPEAMQscWGk9iA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=grWxn/rFk284PwVWUq5pHEdH7pmffpTS7ja30QsO8+uCs9czuA+oII9pfssE8Yhzm
         FhasNl7MUNmMj5iVcC4xnTfaD627yCxLFk21VtP3TSH1vgI7tANNNn7/pZDyYxSBSg
         tfkx1+Uuqt8G7Ed+RXiGipUkTxBKHu73wqHb4hbg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jeremy Kerr <jk@ozlabs.org>, Stan Johnson <userm57@yahoo.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 16/47] net: bmac: Fix read of MAC address from ROM
Date:   Thu, 28 May 2020 07:55:29 -0400
Message-Id: <20200528115600.1405808-16-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200528115600.1405808-1-sashal@kernel.org>
References: <20200528115600.1405808-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index a58185b1d8bf..3e3711b60d01 100644
--- a/drivers/net/ethernet/apple/bmac.c
+++ b/drivers/net/ethernet/apple/bmac.c
@@ -1182,7 +1182,7 @@ bmac_get_station_address(struct net_device *dev, unsigned char *ea)
 	int i;
 	unsigned short data;
 
-	for (i = 0; i < 6; i++)
+	for (i = 0; i < 3; i++)
 		{
 			reset_and_select_srom(dev);
 			data = read_srom(dev, i + EnetAddressOffset/2, SROMAddressBits);
-- 
2.25.1

