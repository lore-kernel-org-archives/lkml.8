Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D074EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F23120842
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591658290;
	bh=Ioq5oSR0MIiJstNPITP02CH7m7AaNYznuEU4MG1tsrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eFuIRrM7loRso7t6Hjph2PJpUNCqyIBBWtjRHHGQx8f++OFelgUk8csDTyZ8WcJtE
	 KxOUlEYTKPceR4hIxptvbiuoncVoCVXmUP8BSAh6bnGs8dpxUorYqHnmjhZlFAdadH
	 7AoTrG39+O35LCh+Zp4PnuebKmMDFJpgBPjTFZJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbgFHXSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:18:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:34708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729001AbgFHXO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:14:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A222121527;
        Mon,  8 Jun 2020 23:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658066;
        bh=Ioq5oSR0MIiJstNPITP02CH7m7AaNYznuEU4MG1tsrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QtWZzuCrWIxFM6F2AS0aFR9CYL08qNssv69lgoJ+YOakF+kGB2ibMeU4sp3fnGCt/
         7bQkOzh0rydVPTUNwnl0EtHxyeFKH1YDTWYNxXdyNrPRq7S4byucCajNlahU0U6H6D
         LqCfYFTUT38NEu6TVscLOTfEhlyrBG/So932TDys=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Richard Clark <richard.xnu.clark@gmail.com>,
        Igor Russkikh <irusskikh@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 112/606] aquantia: Fix the media type of AQC100 ethernet controller in the driver
Date:   Mon,  8 Jun 2020 19:03:57 -0400
Message-Id: <20200608231211.3363633-112-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Clark <richard.xnu.clark@gmail.com>

[ Upstream commit 6de556c31061e3b9c36546ffaaac5fdb679a2f14 ]

The Aquantia AQC100 controller enables a SFP+ port, so the driver should
configure the media type as '_TYPE_FIBRE' instead of '_TYPE_TP'.

Signed-off-by: Richard Clark <richard.xnu.clark@gmail.com>
Cc: Igor Russkikh <irusskikh@marvell.com>
Cc: "David S. Miller" <davem@davemloft.net>
Acked-by: Igor Russkikh <irusskikh@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
index 78b6f3248756..e0625c67eed3 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
@@ -56,7 +56,7 @@ static const struct aq_board_revision_s hw_atl_boards[] = {
 	{ AQ_DEVICE_ID_D108,	AQ_HWREV_2,	&hw_atl_ops_b0, &hw_atl_b0_caps_aqc108, },
 	{ AQ_DEVICE_ID_D109,	AQ_HWREV_2,	&hw_atl_ops_b0, &hw_atl_b0_caps_aqc109, },
 
-	{ AQ_DEVICE_ID_AQC100,	AQ_HWREV_ANY,	&hw_atl_ops_b1, &hw_atl_b0_caps_aqc107, },
+	{ AQ_DEVICE_ID_AQC100,	AQ_HWREV_ANY,	&hw_atl_ops_b1, &hw_atl_b0_caps_aqc100, },
 	{ AQ_DEVICE_ID_AQC107,	AQ_HWREV_ANY,	&hw_atl_ops_b1, &hw_atl_b0_caps_aqc107, },
 	{ AQ_DEVICE_ID_AQC108,	AQ_HWREV_ANY,	&hw_atl_ops_b1, &hw_atl_b0_caps_aqc108, },
 	{ AQ_DEVICE_ID_AQC109,	AQ_HWREV_ANY,	&hw_atl_ops_b1, &hw_atl_b0_caps_aqc109, },
-- 
2.25.1

