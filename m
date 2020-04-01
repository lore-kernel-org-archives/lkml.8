Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49647C2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D51021556
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758082;
	bh=yoXhOL7nTVasZHR6cKwhWMciTV/1jPkQpUjZtocCq3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vp4TyDgnQ0wnTgHZZ+3cUNBg4U90Mo4ILjNb2R+MmJiJj4yaBo01k1YUpoxfuz41B
	 tyLiZJ3wNyPBU8vQKoPD/HmqgQMjQNxCjotEe6PBk4GKcPWwNV+UozGb6YByDSaHrE
	 3mpa5Sp6Z90k4Wbw0qVV0vUzTWRdOu4a4tpvEukE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732447AbgDAQVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:21:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732497AbgDAQVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:21:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8765820658;
        Wed,  1 Apr 2020 16:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758077;
        bh=yoXhOL7nTVasZHR6cKwhWMciTV/1jPkQpUjZtocCq3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NFLjohpR5Bnrjd2rCojIAnwbKpnK5UFvlVgnMIq3wefmjIKACY8E5ngtK1bvPvoG/
         2nLcZgKSBD0W6QjoDPnXSOlSCuSzfoOgUX6IZjnG9CshtgL/dglst9jL7p5p4Y0xP9
         o+skzfKOncPl8ETP1uoNmCTp0AhXGX2nlyJHtPyY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Madalin Bucur <madalin.bucur@oss.nxp.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 29/30] arm64: dts: ls1043a-rdb: correct RGMII delay mode to rgmii-id
Date:   Wed,  1 Apr 2020 18:17:33 +0200
Message-Id: <20200401161436.096040580@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161414.345528747@linuxfoundation.org>
References: <20200401161414.345528747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madalin Bucur <madalin.bucur@oss.nxp.com>

commit 4022d808c45277693ea86478fab1f081ebf997e8 upstream.

The correct setting for the RGMII ports on LS1043ARDB is to
enable delay on both Rx and Tx so the interface mode used must
be PHY_INTERFACE_MODE_RGMII_ID.

Since commit 1b3047b5208a80 ("net: phy: realtek: add support for
configuring the RX delay on RTL8211F") the Realtek 8211F PHY driver
has control over the RGMII RX delay and it is disabling it for
RGMII_TXID. The LS1043ARDB uses two such PHYs in RGMII_ID mode but
in the device tree the mode was described as "rgmii_txid".
This issue was not apparent at the time as the PHY driver took the
same action for RGMII_TXID and RGMII_ID back then but it became
visible (RX no longer working) after the above patch.

Changing the phy-connection-type to "rgmii-id" to address the issue.

Fixes: bf02f2ffe59c ("arm64: dts: add LS1043A DPAA FMan support")
Signed-off-by: Madalin Bucur <madalin.bucur@oss.nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
@@ -119,12 +119,12 @@
 
 	ethernet@e4000 {
 		phy-handle = <&rgmii_phy1>;
-		phy-connection-type = "rgmii-txid";
+		phy-connection-type = "rgmii-id";
 	};
 
 	ethernet@e6000 {
 		phy-handle = <&rgmii_phy2>;
-		phy-connection-type = "rgmii-txid";
+		phy-connection-type = "rgmii-id";
 	};
 
 	ethernet@e8000 {


