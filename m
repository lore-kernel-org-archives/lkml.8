Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118AFC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36CF20675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608429;
	bh=lPkTcJsktgq1DVCQu6Pr6czb8dK9EqddpNJ+KE3I0zw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2sTrMvvEZfkaz48Xdg2Yl2bbzaO5ib88XRjx/xdbchNR2zx7nNs2dCF2ZjXseVj1f
	 ucJw+TNIzX4ai5/ZMUkTWiRzfdVIVWdYGUXMHV34meIt+WXqbb8XuRdAfqjmBNdObK
	 7DtVlCruwc8UT9xpAbzk9CskpLgZbUKkg/IHyquk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387807AbgBMPk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:40:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:56734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387778AbgBMP2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:28:45 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF99E24670;
        Thu, 13 Feb 2020 15:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607724;
        bh=lPkTcJsktgq1DVCQu6Pr6czb8dK9EqddpNJ+KE3I0zw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ve0S8ZCelfXV/ISqDPxvL/HQSRnl9iCmWEs7CXiZk5wpD13vYZxxKaAPEqysHbGda
         3Fs0nTzukxD0wl0HCwDV4Ton5oR2G/1lZ0yJZ+c24UVbyldQh5D04k691u1kkIPlSM
         ZiJebjM1BjR+jCo5e88k8kBXwnPUgGhH2VyXyMyc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Brodkin <abrodkin@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>
Subject: [PATCH 5.5 053/120] ARC: [plat-axs10x]: Add missing multicast filter number to GMAC node
Date:   Thu, 13 Feb 2020 07:20:49 -0800
Message-Id: <20200213151919.834820192@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151901.039700531@linuxfoundation.org>
References: <20200213151901.039700531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <Jose.Abreu@synopsys.com>

commit 7980dff398f86a618f502378fa27cf7e77449afa upstream.

Add a missing property to GMAC node so that multicast filtering works
correctly.

Fixes: 556cc1c5f528 ("ARC: [axs101] Add support for AXS101 SDP (software development platform)")
Acked-by: Alexey Brodkin <abrodkin@synopsys.com>
Signed-off-by: Jose Abreu <Jose.Abreu@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arc/boot/dts/axs10x_mb.dtsi |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arc/boot/dts/axs10x_mb.dtsi
+++ b/arch/arc/boot/dts/axs10x_mb.dtsi
@@ -78,6 +78,7 @@
 			interrupt-names = "macirq";
 			phy-mode = "rgmii";
 			snps,pbl = < 32 >;
+			snps,multicast-filter-bins = <256>;
 			clocks = <&apbclk>;
 			clock-names = "stmmaceth";
 			max-speed = <100>;


