Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864AEC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53F80208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588943574;
	bh=6sRp/ShxUWakFUSR0H/jKpiuBU3Tr1r1Q4kbnxQJHoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E1Vlc82i7zwTAEL0Et1qbOzz5l9X3GA5p30ae4Lmc6YZxqMhwTdvGn0VpqHJ8e7Q9
	 Fcp2O4yMSXfBDRZcO0XCCELvkJ60ReYHCQgAHYghOf4PowKV+qv/opyNIG0jwPTOgA
	 hnTxDgUbXQkBeaF/lMJ7QK/DANEwvWB8j4bXfpWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730494AbgEHNMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:12:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:52392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729674AbgEHMsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:48:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6F1521473;
        Fri,  8 May 2020 12:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942111;
        bh=6sRp/ShxUWakFUSR0H/jKpiuBU3Tr1r1Q4kbnxQJHoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wpLV5ODyNdsPyWNgddBb5mxlOHelZ6Y6JsdtCVCk4PTKsgwKX0k5nEr2qUb/klxVZ
         UsmSmO2zK5puMnPmuHXrAD23IOjIQpBNPZ1dChVMGYrWJSY3EjsVHvtZt+6i+Yr1Dt
         x8yHhCH4h0Rm8eZh975hPUTsYxNYMlafwR+YBOgo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 274/312] net: axienet: Fix return value check in axienet_probe()
Date:   Fri,  8 May 2020 14:34:25 +0200
Message-Id: <20200508123143.701824736@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

commit 3ad7b1477ef9b01988ac052b02be9cd410c95157 upstream.

In case of error, the function of_parse_phandle() returns NULL
pointer not ERR_PTR(). The IS_ERR() test in the return value
check should be replaced with NULL test.

Fixes: 46aa27df8853 ('net: axienet: Use devm_* calls')
Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1602,9 +1602,9 @@ static int axienet_probe(struct platform
 
 	/* Find the DMA node, map the DMA registers, and decode the DMA IRQs */
 	np = of_parse_phandle(pdev->dev.of_node, "axistream-connected", 0);
-	if (IS_ERR(np)) {
+	if (!np) {
 		dev_err(&pdev->dev, "could not find DMA node\n");
-		ret = PTR_ERR(np);
+		ret = -ENODEV;
 		goto free_netdev;
 	}
 	ret = of_address_to_resource(np, 0, &dmares);


