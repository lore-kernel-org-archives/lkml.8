Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95AEC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79C0C2072D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597921583;
	bh=gwuEsgmsoQl0q0Xk5buPFR4EG5XCCWsaqCtI3x8fdyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gAcvFiugM9NDqRS6ygJ6x7mhHFwsn92vmC5I7lOXr/U/vS+cVtgjZXZ/VCWlpgvzl
	 CHl4q5SporORxEcyPgNrybDpf7G/zc1BItCTj+0OMUmemx6QntK9ErYmsPOkJl5nmI
	 jQG9tt6qdOgjMCIf7M+yJa8U+bGYkmqEJrnlpFas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbgHTLGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:06:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730543AbgHTKMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:12:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F696206DA;
        Thu, 20 Aug 2020 10:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918324;
        bh=gwuEsgmsoQl0q0Xk5buPFR4EG5XCCWsaqCtI3x8fdyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Skwsl3okTbYyJNk5qsB+tgbqm+8+zkqc2jNAeisUCyuvCItWoaN9PlWBnUhH+dMJ0
         bbTD86BdResY1iuXYytMNV4BPUW3rePc9A2orpaTcZWTbTGkUDJezrEcdj/pyg/Haa
         QfQCrDm73WiEVLHKNQqAZ1KaPMrgZjWU43A3SquY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Florinel Iordache <florinel.iordache@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 130/228] fsl/fman: use 32-bit unsigned integer
Date:   Thu, 20 Aug 2020 11:21:45 +0200
Message-Id: <20200820091614.084912862@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091607.532711107@linuxfoundation.org>
References: <20200820091607.532711107@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florinel Iordache <florinel.iordache@nxp.com>

[ Upstream commit 99f47abd9f7bf6e365820d355dc98f6955a562df ]

Potentially overflowing expression (ts_freq << 16 and intgr << 16)
declared as type u32 (32-bit unsigned) is evaluated using 32-bit
arithmetic and then used in a context that expects an expression of
type u64 (64-bit unsigned) which ultimately is used as 16-bit
unsigned by typecasting to u16. Fixed by using an unsigned 32-bit
integer since the value is truncated anyway in the end.

Fixes: 414fd46e7762 ("fsl/fman: Add FMan support")
Signed-off-by: Florinel Iordache <florinel.iordache@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/fman/fman.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
index 9080d2332d030..cdd48b1cc84a7 100644
--- a/drivers/net/ethernet/freescale/fman/fman.c
+++ b/drivers/net/ethernet/freescale/fman/fman.c
@@ -1396,8 +1396,7 @@ static void enable_time_stamp(struct fman *fman)
 {
 	struct fman_fpm_regs __iomem *fpm_rg = fman->fpm_regs;
 	u16 fm_clk_freq = fman->state->fm_clk_freq;
-	u32 tmp, intgr, ts_freq;
-	u64 frac;
+	u32 tmp, intgr, ts_freq, frac;
 
 	ts_freq = (u32)(1 << fman->state->count1_micro_bit);
 	/* configure timestamp so that bit 8 will count 1 microsecond
-- 
2.25.1



