Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3C5C2BB86
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716DC20787
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586648822;
	bh=m4r/Ag31bq8ohllY1Etx/tSLMSqWiuvmKd4EumwIlTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BTX5skYr0Nk1ho24VNIrBGevJKcVsSVuC2oZ6eFitVvLBIuencBBkeOqmrmTf/8Bv
	 s3ZyFgJdAa0DWQ/hKY49TSv/F2QuKWxqQ8Gbt/SoQ38V1uozfr1Y0+q21RZrhlZcnB
	 vam1gywD5gv5hfgoVlzOazyjgTl/NZ6PzMJCzy10=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgDKXFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:05:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727608AbgDKXEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:04:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C2E6214D8;
        Sat, 11 Apr 2020 23:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646295;
        bh=m4r/Ag31bq8ohllY1Etx/tSLMSqWiuvmKd4EumwIlTc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sz73WsQkATIsXrgYXnfIjb9QH+cCtmdoweaJiYGIwopKqcLY2i+/9GBM2iE+1IVwn
         8zF2J81VOr+pSiWFLcmRDk3bZMAlK1WjjE6XK0RMMsJImU9gR/rSOicjgWcwx9zYPp
         uuT80mPudRu55DRKDPF8NjKmvLSEqZ11ja6xtSpA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 055/149] sh_eth: check sh_eth_cpu_data::cexcr when dumping registers
Date:   Sat, 11 Apr 2020 19:02:12 -0400
Message-Id: <20200411230347.22371-55-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230347.22371-1-sashal@kernel.org>
References: <20200411230347.22371-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

[ Upstream commit f75ca32403dbf91e20c275719aab705401b9e718 ]

When adding the sh_eth_cpu_data::cexcr flag I forgot to add the flag
check to  __sh_eth_get_regs(), causing the non-existing RX packet counter
registers to be considered for dumping on  the R7S72100 SoC (the register
offset sanity check has the final say here)...

Fixes: 4c1d45850d5 ("sh_eth: add sh_eth_cpu_data::cexcr flag")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Tested-by: Chris Brandt <chris.brandt@renesas.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/renesas/sh_eth.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index cd1f5842b1310..ae9469c90ae2c 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -2194,8 +2194,10 @@ static size_t __sh_eth_get_regs(struct net_device *ndev, u32 *buf)
 	add_reg(FRECR);
 	add_reg(TSFRCR);
 	add_reg(TLFRCR);
-	add_reg(CERCR);
-	add_reg(CEECR);
+	if (cd->cexcr) {
+		add_reg(CERCR);
+		add_reg(CEECR);
+	}
 	add_reg(MAFCR);
 	if (cd->rtrate)
 		add_reg(RTRATE);
-- 
2.20.1

