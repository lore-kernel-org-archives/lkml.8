Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CD6C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94FE62469A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581607459;
	bh=EA1bzA5FCHK3bM0TRVKO52p7ylLSGuwB1mz7f6eT8qs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mPL2cakSEL6j4drN3EL3srGJy/2adcNIBw4m8Yt4JwcI+l8aFMjQmWT62z+6FPC7u
	 MQY03sUrZDyb+VgH5IRzNDGjggwXayC1g/PHQgkGZmlo+pGbHwn+A7xpA1JbpR//81
	 6L6m1Rd+S02PJjWfDQfp95xawwcJEBp1wJM2k/J4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgBMPYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:24:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:33954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728300AbgBMPXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:23:13 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E12CC2469C;
        Thu, 13 Feb 2020 15:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607393;
        bh=EA1bzA5FCHK3bM0TRVKO52p7ylLSGuwB1mz7f6eT8qs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YYah6QmKZPMRYAtFjGyDMu2CiCuYdy1TjCNFm12qYRxwjaKkkcdNljIYxCu4G5NMd
         HOA8h4RVX65iuZ3xU4gsQv+z4irxgcbsOVs38N2rxK2jkbKc0443SOGHOrL0Kpy4Tv
         R+0/m0oiKnGXR66it9gYxRw4G3IpO57df/zkLAlM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Brodkin <abrodkin@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>
Subject: [PATCH 4.4 82/91] ARC: [plat-axs10x]: Add missing multicast filter number to GMAC node
Date:   Thu, 13 Feb 2020 07:20:39 -0800
Message-Id: <20200213151854.636489849@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151821.384445454@linuxfoundation.org>
References: <20200213151821.384445454@linuxfoundation.org>
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
@@ -44,6 +44,7 @@
 			interrupt-names = "macirq";
 			phy-mode = "rgmii";
 			snps,pbl = < 32 >;
+			snps,multicast-filter-bins = <256>;
 			clocks = <&apbclk>;
 			clock-names = "stmmaceth";
 			max-speed = <100>;


