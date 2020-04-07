Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE641C2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 00:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B4322078A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 00:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586217877;
	bh=8PpGL1xkqmeHJ2Vira44+EEkc2xrM5AF6XsNGJQaXU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ss3KxL4hQKKjQ+4t3rbilZAqInjHIjKkbv8NbnyRGztIeYvS3u7YighL53DpmYC14
	 yw3H8vm9oKyfht4yqU34bK18GPdI2p5haL2ib5pLx89cMf7LZm73BIAQ9MgzzJAOqs
	 tV1PY6Pt14A+4CqIv+KI2FC9fqVr6OpFdGEL7wnM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgDGAEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 20:04:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:37722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728256AbgDGACs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 20:02:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B428F20842;
        Tue,  7 Apr 2020 00:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586217768;
        bh=8PpGL1xkqmeHJ2Vira44+EEkc2xrM5AF6XsNGJQaXU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lO2HwfB1XsxWXdrn9aASwDIDFJsRqDlwMnD/EFCiQ+l5rSfq6hX8s8+/fvlkOK8xs
         a5ejtmPHe66GvgQPpQkO84VoRP7d9lOq4hKTe6RutGC3ororGkHytaJ2c76LGkRvZ8
         IT9aPIY9OLQIP3S0eXv/cfVjW7fylgAZodeNIIpY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Raju Rangoju <rajur@chelsio.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 11/13] cxgb4/ptp: pass the sign of offset delta in FW CMD
Date:   Mon,  6 Apr 2020 20:02:32 -0400
Message-Id: <20200407000234.17088-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200407000234.17088-1-sashal@kernel.org>
References: <20200407000234.17088-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raju Rangoju <rajur@chelsio.com>

[ Upstream commit 50e0d28d3808146cc19b0d5564ef4ba9e5bf3846 ]

cxgb4_ptp_fineadjtime() doesn't pass the signedness of offset delta
in FW_PTP_CMD. Fix it by passing correct sign.

Signed-off-by: Raju Rangoju <rajur@chelsio.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ptp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ptp.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ptp.c
index 9f9d6cae39d55..758f2b8363282 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ptp.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ptp.c
@@ -246,6 +246,9 @@ static int  cxgb4_ptp_fineadjtime(struct adapter *adapter, s64 delta)
 			     FW_PTP_CMD_PORTID_V(0));
 	c.retval_len16 = cpu_to_be32(FW_CMD_LEN16_V(sizeof(c) / 16));
 	c.u.ts.sc = FW_PTP_SC_ADJ_FTIME;
+	c.u.ts.sign = (delta < 0) ? 1 : 0;
+	if (delta < 0)
+		delta = -delta;
 	c.u.ts.tm = cpu_to_be64(delta);
 
 	err = t4_wr_mbox(adapter, adapter->mbox, &c, sizeof(c), NULL);
-- 
2.20.1

