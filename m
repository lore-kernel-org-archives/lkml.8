Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19B0C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EE662073A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587552289;
	bh=WL3PbyBJMFw8o4KxrC8xipxehGC7bO8H7IF894iaawA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o8EFPDG+bY8fDUuEyHi9BiMo9262JFQwBeguwt2o7mDKtQtAV9NmNAmB5j78l0HvH
	 rRZvw8dkDT9SgKFR8qqTBZB5F1V/LLCZR3E8hW2EkD3rQU6/4+W7WV884/z24XJKWI
	 9ZXq6NiH4LxtLSHX/XFm5ADB6U6TDu5mX5GqxrEA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729628AbgDVKSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:18:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:53998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729865AbgDVKRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:17:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10EE02070B;
        Wed, 22 Apr 2020 10:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550660;
        bh=WL3PbyBJMFw8o4KxrC8xipxehGC7bO8H7IF894iaawA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qHzUKosN6ZFx7mTa0W+o2AxnHu/h9muVV+2QxbHjflTrKUxS28Do94zokUcqNTH1w
         U0MWnLqqRELOdbEmsfGdi761awUBNSOljbV6KYvMf2VV7lWxZJeVa7nKl7rf6ZbHwU
         V8P7jeEOkqPSbxCmp/lcI4TocG4pDoTwKXc8UyD8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Fuzzey <martin.fuzzey@flowbird.group>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 009/118] ARM: dts: imx6: Use gpc for FEC interrupt controller to fix wake on LAN.
Date:   Wed, 22 Apr 2020 11:56:10 +0200
Message-Id: <20200422095033.067534688@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095031.522502705@linuxfoundation.org>
References: <20200422095031.522502705@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Fuzzey <martin.fuzzey@flowbird.group>

commit 4141f1a40fc0789f6fd4330e171e1edf155426aa upstream.

In order to wake from suspend by ethernet magic packets the GPC
must be used as intc does not have wakeup functionality.

But the FEC DT node currently uses interrupt-extended,
specificying intc, thus breaking WoL.

This problem is probably fallout from the stacked domain conversion
as intc used to chain to GPC.

So replace "interrupts-extended" by "interrupts" to use the default
parent which is GPC.

Fixes: b923ff6af0d5 ("ARM: imx6: convert GPC to stacked domains")

Signed-off-by: Martin Fuzzey <martin.fuzzey@flowbird.group>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/imx6qdl.dtsi |    5 ++---
 arch/arm/boot/dts/imx6qp.dtsi  |    1 -
 2 files changed, 2 insertions(+), 4 deletions(-)

--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1039,9 +1039,8 @@
 				compatible = "fsl,imx6q-fec";
 				reg = <0x02188000 0x4000>;
 				interrupt-names = "int0", "pps";
-				interrupts-extended =
-					<&intc 0 118 IRQ_TYPE_LEVEL_HIGH>,
-					<&intc 0 119 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <0 118 IRQ_TYPE_LEVEL_HIGH>,
+					     <0 119 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6QDL_CLK_ENET>,
 					 <&clks IMX6QDL_CLK_ENET>,
 					 <&clks IMX6QDL_CLK_ENET_REF>;
--- a/arch/arm/boot/dts/imx6qp.dtsi
+++ b/arch/arm/boot/dts/imx6qp.dtsi
@@ -77,7 +77,6 @@
 };
 
 &fec {
-	/delete-property/interrupts-extended;
 	interrupts = <0 118 IRQ_TYPE_LEVEL_HIGH>,
 		     <0 119 IRQ_TYPE_LEVEL_HIGH>;
 };


