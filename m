Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742AAC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A5D124955
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588339938;
	bh=FsjARDXTygae6jd46EpiQsq5YldIFMZaxWZiKkMxT2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fjeU/p3KlPPvCytPTLsiiDuQL8lVDBLIGjmkOKLd2p48nAhrcQ4uaMyvjsK4VoqX1
	 NcidXGWJdErq0PLXQxNSB7meBOocacgSd4cRrNicYDAvGk9d6RHvnxOdpt6i7eDg/L
	 gP8duHgggbAq26du28Sqtk+E+fCtxfv1VPW+9Cik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbgEANcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:32:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730257AbgEANcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:32:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19134208C3;
        Fri,  1 May 2020 13:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588339930;
        bh=FsjARDXTygae6jd46EpiQsq5YldIFMZaxWZiKkMxT2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l14Lu3fOTsHNGzc9XyZPi4XTH1zzZrvD15bPOnrZnV5qZwT9lAZi4yw6K8NXn3U/T
         i4O7sd16L2lAYbvfd/h1rj3ZGn28OTvqMwSNJs1A23P7XfP13y9sU94H8mVOV/xuXc
         dd5+MkplDxb5fzZZGs0ZG/YDmTyeoCQ81MqjyIqs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Manoj Malviya <manojmalviya@chelsio.com>,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 024/117] cxgb4: fix large delays in PTP synchronization
Date:   Fri,  1 May 2020 15:21:00 +0200
Message-Id: <20200501131547.847864178@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131544.291247695@linuxfoundation.org>
References: <20200501131544.291247695@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>

[ Upstream commit bd019427bf3623ee3c7d2845cf921bbf4c14846c ]

Fetching PTP sync information from mailbox is slow and can take
up to 10 milliseconds. Reduce this unnecessary delay by directly
reading the information from the corresponding registers.

Fixes: 9c33e4208bce ("cxgb4: Add PTP Hardware Clock (PHC) support")
Signed-off-by: Manoj Malviya <manojmalviya@chelsio.com>
Signed-off-by: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ptp.c |   27 +++++--------------------
 drivers/net/ethernet/chelsio/cxgb4/t4_regs.h   |    3 ++
 2 files changed, 9 insertions(+), 21 deletions(-)

--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ptp.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ptp.c
@@ -311,32 +311,17 @@ static int cxgb4_ptp_adjtime(struct ptp_
  */
 static int cxgb4_ptp_gettime(struct ptp_clock_info *ptp, struct timespec64 *ts)
 {
-	struct adapter *adapter = (struct adapter *)container_of(ptp,
-				   struct adapter, ptp_clock_info);
-	struct fw_ptp_cmd c;
+	struct adapter *adapter = container_of(ptp, struct adapter,
+					       ptp_clock_info);
 	u64 ns;
-	int err;
 
-	memset(&c, 0, sizeof(c));
-	c.op_to_portid = cpu_to_be32(FW_CMD_OP_V(FW_PTP_CMD) |
-				     FW_CMD_REQUEST_F |
-				     FW_CMD_READ_F |
-				     FW_PTP_CMD_PORTID_V(0));
-	c.retval_len16 = cpu_to_be32(FW_CMD_LEN16_V(sizeof(c) / 16));
-	c.u.ts.sc = FW_PTP_SC_GET_TIME;
-
-	err = t4_wr_mbox(adapter, adapter->mbox, &c, sizeof(c), &c);
-	if (err < 0) {
-		dev_err(adapter->pdev_dev,
-			"PTP: %s error %d\n", __func__, -err);
-		return err;
-	}
+	ns = t4_read_reg(adapter, T5_PORT_REG(0, MAC_PORT_PTP_SUM_LO_A));
+	ns |= (u64)t4_read_reg(adapter,
+			       T5_PORT_REG(0, MAC_PORT_PTP_SUM_HI_A)) << 32;
 
 	/* convert to timespec*/
-	ns = be64_to_cpu(c.u.ts.tm);
 	*ts = ns_to_timespec64(ns);
-
-	return err;
+	return 0;
 }
 
 /**
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_regs.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_regs.h
@@ -1810,6 +1810,9 @@
 
 #define MAC_PORT_CFG2_A 0x818
 
+#define MAC_PORT_PTP_SUM_LO_A 0x990
+#define MAC_PORT_PTP_SUM_HI_A 0x994
+
 #define MPS_CMN_CTL_A	0x9000
 
 #define COUNTPAUSEMCRX_S    5


