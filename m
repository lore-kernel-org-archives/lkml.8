Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1619C3815B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC66F22245
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587052753;
	bh=8PpGL1xkqmeHJ2Vira44+EEkc2xrM5AF6XsNGJQaXU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OfxI/+3AnxFBBbNeQWa+cps7KvPuxB+spSQCMAI1Lhs8QT6+IYMwcxn6z5ttaFfxK
	 7euZ3F0Bwx4/SVsum3YLVqp3rpuYrwJ4KvwJbaya/CQKbO6iByLTocWvQAVBbsJohY
	 0fSU4eMBV6fqYgNHBce9FwRInT7KUEJ3aRowW790=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895702AbgDPN2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 09:28:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895347AbgDPN1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:27:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2687206E9;
        Thu, 16 Apr 2020 13:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587043625;
        bh=8PpGL1xkqmeHJ2Vira44+EEkc2xrM5AF6XsNGJQaXU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EHsY3ZgYbacBT58OVUeQTP/5PI+73WXJp7u3i82LAq/qIqJQyHq8LsP1z/p08zQEs
         0sNJUgobenWBcy6KfPrPBB9XSRqfLmo8TLajnXvxVMD5F83onBM9JkFlyNITBz9hiK
         lWs9gHQyiUndNaOzW1qri+9oITszwPpAnh5TCchg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Raju Rangoju <rajur@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 007/146] cxgb4/ptp: pass the sign of offset delta in FW CMD
Date:   Thu, 16 Apr 2020 15:22:28 +0200
Message-Id: <20200416131243.507556526@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131242.353444678@linuxfoundation.org>
References: <20200416131242.353444678@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



