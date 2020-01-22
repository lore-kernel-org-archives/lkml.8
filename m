Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8096BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B6CC24688
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699505;
	bh=ikhNzRPjtLv6agTCVjiSdi6VCJA/GFt+zgLfGnJjqAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N2NGWCtHNrssmkWTM9PKvbNJfPhoqP81QYAf39K4crpus3LhqEvEj1fxuQBM92F87
	 7/H9mGyzW8BXXHf6uDWiJApVcIx1PMdmuh9MW7nN1qwW0yvYq++yHfqJkyZ+P/rEh2
	 Wuao6tzRNM2cGSg2FVKykM3DTj/p2caPT5FgR4Fw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731134AbgAVNZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:25:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:44418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731117AbgAVNZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:25:01 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D51532467B;
        Wed, 22 Jan 2020 13:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699500;
        bh=ikhNzRPjtLv6agTCVjiSdi6VCJA/GFt+zgLfGnJjqAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fcV46VuyQRWD4FHI14s7H6jx7rS4/eYqRoH8PD3bBtOGsm8hITQilDrUS2dgFSCNR
         M7KHdlpAUCbEpv5gkIXQHA29of1mFfnWOcjZi9rfnlx32U7rgL/qooNYJ6rtnDRSFE
         x/4d7q6XXlP6H0SBnsfvSXaodqLbG9CWu6iai7Jo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 165/222] net: stmmac: selftests: Mark as fail when received VLAN ID != expected
Date:   Wed, 22 Jan 2020 10:29:11 +0100
Message-Id: <20200122092845.527092902@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <Jose.Abreu@synopsys.com>

commit d39b68e5a736afa67d2e9cfb158efdd237d99dbd upstream.

When the VLAN ID does not match the expected one it means filter failed
in HW. Fix it.

Fixes: 94e18382003c ("net: stmmac: selftests: Add selftest for VLAN TX Offload")
Signed-off-by: Jose Abreu <Jose.Abreu@synopsys.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
@@ -853,8 +853,12 @@ static int stmmac_test_vlan_validate(str
 	if (tpriv->vlan_id) {
 		if (skb->vlan_proto != htons(proto))
 			goto out;
-		if (skb->vlan_tci != tpriv->vlan_id)
+		if (skb->vlan_tci != tpriv->vlan_id) {
+			/* Means filter did not work. */
+			tpriv->ok = false;
+			complete(&tpriv->comp);
 			goto out;
+		}
 	}
 
 	ehdr = (struct ethhdr *)skb_mac_header(skb);


