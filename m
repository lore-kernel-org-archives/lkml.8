Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A21AC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E132051A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581338907;
	bh=q0jTh8NA67CL22jjqtJ3TlVzbORChLP+p/Zwt+T7Fl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AVh0mEbYQdREPreFgwZP9KcoWKLkFYNY4Mr6LK4ua7D3mkyxlyZnu2Wh+6I991AiE
	 K3LS1JRNpUYakoyqV0SG2CW37m9oFi3IPFvjv3gHHTd65AZw69ePP4nCfyhLRV6qh3
	 dKmfTb/12pzWO40NPfwFDUzQ8ah4wgH/dSC05a8c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgBJMrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:47:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:45772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730149AbgBJMmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:42:05 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B71320838;
        Mon, 10 Feb 2020 12:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338525;
        bh=q0jTh8NA67CL22jjqtJ3TlVzbORChLP+p/Zwt+T7Fl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RdAO1yVLEQgk0HR06rSl7GFg47lFl+IAdbyLegs+QalL1Rg5X1ygHmrXe9jCX0YmF
         3odCNYoy4LSnWCxmofakrWCHiS1FG2G7USax3QmgokA2+47Hq056CH8g+8PG0M9b2E
         /Qp6TIfn/sqZUFeq4dVdYrLA9jme0sPSdak525+c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 345/367] r8169: fix performance regression related to PCIe max read request size
Date:   Mon, 10 Feb 2020 04:34:18 -0800
Message-Id: <20200210122454.429284951@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 21b5f672fb2eb1366dedc4ac9d32431146b378d3 ]

It turned out that on low performance systems the original change can
cause lower tx performance. On a N3450-based mini-PC tx performance
in iperf3 was reduced from 950Mbps to ~900Mbps. Therefore effectively
revert the original change, just use pcie_set_readrq() now instead of
changing the PCIe capability register directly.

Fixes: 2df49d365498 ("r8169: remove fiddling with the PCIe max read request size")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/realtek/r8169_main.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -3865,15 +3865,18 @@ static void rtl_hw_jumbo_enable(struct r
 	switch (tp->mac_version) {
 	case RTL_GIGA_MAC_VER_12:
 	case RTL_GIGA_MAC_VER_17:
+		pcie_set_readrq(tp->pci_dev, 512);
 		r8168b_1_hw_jumbo_enable(tp);
 		break;
 	case RTL_GIGA_MAC_VER_18 ... RTL_GIGA_MAC_VER_26:
+		pcie_set_readrq(tp->pci_dev, 512);
 		r8168c_hw_jumbo_enable(tp);
 		break;
 	case RTL_GIGA_MAC_VER_27 ... RTL_GIGA_MAC_VER_28:
 		r8168dp_hw_jumbo_enable(tp);
 		break;
 	case RTL_GIGA_MAC_VER_31 ... RTL_GIGA_MAC_VER_33:
+		pcie_set_readrq(tp->pci_dev, 512);
 		r8168e_hw_jumbo_enable(tp);
 		break;
 	default:
@@ -3903,6 +3906,9 @@ static void rtl_hw_jumbo_disable(struct
 		break;
 	}
 	rtl_lock_config_regs(tp);
+
+	if (pci_is_pcie(tp->pci_dev) && tp->supports_gmii)
+		pcie_set_readrq(tp->pci_dev, 4096);
 }
 
 static void rtl_jumbo_config(struct rtl8169_private *tp, int mtu)


