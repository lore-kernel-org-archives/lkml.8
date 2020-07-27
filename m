Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A268C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DD0B2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595859687;
	bh=AqQKZTUQ38W5fZS4lnOhbxBemp0qTW8dKqkGdBhn1Mo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gjR/Dyn1jp3oOMbLLOEHlp94Oz4+n51brmHTm7SniXYn8emxGNnSZAbwpSukpKtbF
	 +cE3WTgktq9rVPfMthbsYOcSFWGxtT+OhQ0/V6GofrhT+yCwQ4lfe44lXOHnMy5iht
	 QjR5LucwONr8pNMyfTjEQLaTSuSyqdCRihDX8q9w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731721AbgG0OV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:21:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730232AbgG0OVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:21:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FD2C2070A;
        Mon, 27 Jul 2020 14:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859680;
        bh=AqQKZTUQ38W5fZS4lnOhbxBemp0qTW8dKqkGdBhn1Mo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1lyNr6gFEjDWUx3pmOY2A+QDFhGWzuC8sN/ZpSuQkdlqr4CzGB6BTdILR9yB/kO8O
         c+alZnnA2e3/tvdR23izgh/WOi2PiDkD1wJVb/Lt/tDxJjcBdz72g93pCRCqcIg9HK
         djYXLw6+8nJUKGtb6X849jyf2yxKdgCItxvLN0Tg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Rowe <martin.p.rowe@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 064/179] arm64: dts: clearfog-gt-8k: fix switch link configuration
Date:   Mon, 27 Jul 2020 16:03:59 +0200
Message-Id: <20200727134935.788541190@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134932.659499757@linuxfoundation.org>
References: <20200727134932.659499757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit 7c6719a1aaca51ffd7cdf3905e70aa8313f6ef26 ]

The commit below caused a regression for clearfog-gt-8k, where the link
between the switch and the host does not come up.

Investigation revealed two issues:
- MV88E6xxx DSA no longer allows an in-band link to come up as the link
  is programmed to be forced down. Commit "net: dsa: mv88e6xxx: fix
  in-band AN link establishment" addresses this.

- The dts configured dissimilar link modes at each end of the host to
  switch link; the host was configured using a fixed link (so has no
  in-band status) and the switch was configured to expect in-band
  status.

With both issues fixed, the regression is resolved.

Fixes: 34b5e6a33c1a ("net: dsa: mv88e6xxx: Configure MAC when using fixed link")
Reported-by: Martin Rowe <martin.p.rowe@gmail.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
index b90d78a5724b2..e32a491e909f1 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
@@ -454,10 +454,7 @@
 	status = "okay";
 	phy-mode = "2500base-x";
 	phys = <&cp1_comphy5 2>;
-	fixed-link {
-		speed = <2500>;
-		full-duplex;
-	};
+	managed = "in-band-status";
 };
 
 &cp1_spi1 {
-- 
2.25.1



