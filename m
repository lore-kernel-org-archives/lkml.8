Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890A2C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5DE206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579876605;
	bh=FRlpmS+R7cBGR2ZUrY4xTSO0XyMmTxygVvMrzqc2n4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A/4Q1nJRa/C1J4KbS/DM+DVeyOPN2zUP3Ux60/cB5uE59/ZrcIHui47+jWtlYAHzK
	 8mtf01S8Ecsaiok0ko0ZxC9l25KJ9CvI5tMMtn/imvVzYi/R+SQjc2gK46McY8XEGj
	 m/eKWpQV6Nn7lQ40VPGkNa6BCg2eVF7gmaH5QnO8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731411AbgAXOgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:36:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:39324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391195AbgAXOTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:19:11 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0FFB22522;
        Fri, 24 Jan 2020 14:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579875550;
        bh=FRlpmS+R7cBGR2ZUrY4xTSO0XyMmTxygVvMrzqc2n4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rpHHSdjx3adBpmTXi20+hKm0/KJVdIQfXIMqqIcmEXYDMNsVyFMHK7qHSnW7G+sfz
         ZMMX0pQg7D1r00r1nQDsHKpNYuSSgW/uVWJ1SvuYcGO/B3Ti4N+eO23agvhc3H9UYY
         pc6e8I4SHMuOBAhQ7XC8KMvEJ2wTiWUhmcf0YXyM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-sh@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 045/107] sh_eth: check sh_eth_cpu_data::dual_port when dumping registers
Date:   Fri, 24 Jan 2020 09:17:15 -0500
Message-Id: <20200124141817.28793-45-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124141817.28793-1-sashal@kernel.org>
References: <20200124141817.28793-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

[ Upstream commit 3249b1e442a1be1a6b9f1026785b519d1443f807 ]

When adding the sh_eth_cpu_data::dual_port flag I forgot to add the flag
checks to __sh_eth_get_regs(), causing the non-existing TSU registers to
be dumped by 'ethtool' on the single port Ether controllers having TSU...

Fixes: a94cf2a614f8 ("sh_eth: fix TSU init on SH7734/R8A7740")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/renesas/sh_eth.c | 38 +++++++++++++++------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index 7ba35a0bdb292..8aa1b1bda96d1 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -2204,24 +2204,28 @@ static size_t __sh_eth_get_regs(struct net_device *ndev, u32 *buf)
 	if (cd->tsu) {
 		add_tsu_reg(ARSTR);
 		add_tsu_reg(TSU_CTRST);
-		add_tsu_reg(TSU_FWEN0);
-		add_tsu_reg(TSU_FWEN1);
-		add_tsu_reg(TSU_FCM);
-		add_tsu_reg(TSU_BSYSL0);
-		add_tsu_reg(TSU_BSYSL1);
-		add_tsu_reg(TSU_PRISL0);
-		add_tsu_reg(TSU_PRISL1);
-		add_tsu_reg(TSU_FWSL0);
-		add_tsu_reg(TSU_FWSL1);
+		if (cd->dual_port) {
+			add_tsu_reg(TSU_FWEN0);
+			add_tsu_reg(TSU_FWEN1);
+			add_tsu_reg(TSU_FCM);
+			add_tsu_reg(TSU_BSYSL0);
+			add_tsu_reg(TSU_BSYSL1);
+			add_tsu_reg(TSU_PRISL0);
+			add_tsu_reg(TSU_PRISL1);
+			add_tsu_reg(TSU_FWSL0);
+			add_tsu_reg(TSU_FWSL1);
+		}
 		add_tsu_reg(TSU_FWSLC);
-		add_tsu_reg(TSU_QTAGM0);
-		add_tsu_reg(TSU_QTAGM1);
-		add_tsu_reg(TSU_FWSR);
-		add_tsu_reg(TSU_FWINMK);
-		add_tsu_reg(TSU_ADQT0);
-		add_tsu_reg(TSU_ADQT1);
-		add_tsu_reg(TSU_VTAG0);
-		add_tsu_reg(TSU_VTAG1);
+		if (cd->dual_port) {
+			add_tsu_reg(TSU_QTAGM0);
+			add_tsu_reg(TSU_QTAGM1);
+			add_tsu_reg(TSU_FWSR);
+			add_tsu_reg(TSU_FWINMK);
+			add_tsu_reg(TSU_ADQT0);
+			add_tsu_reg(TSU_ADQT1);
+			add_tsu_reg(TSU_VTAG0);
+			add_tsu_reg(TSU_VTAG1);
+		}
 		add_tsu_reg(TSU_ADSBSY);
 		add_tsu_reg(TSU_TEN);
 		add_tsu_reg(TSU_POST1);
-- 
2.20.1

