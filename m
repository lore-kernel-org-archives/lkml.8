Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F018FC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C0A20BED
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758540;
	bh=jDgk2fNUsf2K27sBbMdghDFeZe3irrb6hkqUGNr2ZBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rgb7W4iLYhY//StdNSt6jBsIGhbNKv5Xwq51gitR6AInLA/yqKOVQWdLiwvIribfd
	 uSSWCORCEGivzvsWg2vXP02ENMg0Jo9NJeMh2Zaku6BX9AzZuzE2YsgksnkorQ2jGh
	 xKZW4SCF6nwcx4NqWCTHIuGRmBJZbW+2Gqe1bEYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388135AbgDAQ26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:28:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:54368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733248AbgDAQ25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:28:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05EEC20BED;
        Wed,  1 Apr 2020 16:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758536;
        bh=jDgk2fNUsf2K27sBbMdghDFeZe3irrb6hkqUGNr2ZBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aP440InumYDHxLvmwJo0B/2CQ2A8H0Z9IrBBJlilG+TCFDoVUFK16jPZqDOA/r6/M
         EAIgWyzD9BPE/yeqSJySnxcgc8dnCcOUrLFZVLovo1d0LULxgYxWiqj3HsoA8V3SiI
         W5nZZqm+02eCtFeo/KB7ShXozJbZqOA4ib99FpX0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Madalin Bucur <madalin.bucur@oss.nxp.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 116/116] arm64: dts: ls1046ardb: set RGMII interfaces to RGMII_ID mode
Date:   Wed,  1 Apr 2020 18:18:12 +0200
Message-Id: <20200401161556.911849462@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161542.669484650@linuxfoundation.org>
References: <20200401161542.669484650@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madalin Bucur <madalin.bucur@oss.nxp.com>

commit d79e9d7c1e4ba5f95f2ff3541880c40ea9722212 upstream.

The correct setting for the RGMII ports on LS1046ARDB is to
enable delay on both Rx and Tx so the interface mode used must
be PHY_INTERFACE_MODE_RGMII_ID.

Since commit 1b3047b5208a80 ("net: phy: realtek: add support for
configuring the RX delay on RTL8211F") the Realtek 8211F PHY driver
has control over the RGMII RX delay and it is disabling it for
RGMII_TXID. The LS1046ARDB uses two such PHYs in RGMII_ID mode but
in the device tree the mode was described as "rgmii".

Changing the phy-connection-type to "rgmii-id" to address the issue.

Fixes: 3fa395d2c48a ("arm64: dts: add LS1046A DPAA FMan nodes")
Signed-off-by: Madalin Bucur <madalin.bucur@oss.nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
@@ -125,12 +125,12 @@
 &fman0 {
 	ethernet@e4000 {
 		phy-handle = <&rgmii_phy1>;
-		phy-connection-type = "rgmii";
+		phy-connection-type = "rgmii-id";
 	};
 
 	ethernet@e6000 {
 		phy-handle = <&rgmii_phy2>;
-		phy-connection-type = "rgmii";
+		phy-connection-type = "rgmii-id";
 	};
 
 	ethernet@e8000 {


