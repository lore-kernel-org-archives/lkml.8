Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B6CC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F3612467D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583846029;
	bh=at7QjhSbMRG9nK0Ppcaz9JoobZPx9tb6aTYbczn2k6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Se1rBnWsWhmRNQhLeBQoFIAgYYa5N6Oa6I/AZ8aQOX8CxGuvReJFcPq3d2q5FKjq6
	 N2ForaIq/AQ1jh2sLsf2jykexvNyyAvZepQVL6RwkcgcC7pb92AN6vp/viFbq8DI+P
	 D4BGYDvvrD4X9MEKz8PdkL5q2SB0ITitYc6d13jI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731783AbgCJNNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:13:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:36830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731769AbgCJNNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:13:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F91020409;
        Tue, 10 Mar 2020 13:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583846024;
        bh=at7QjhSbMRG9nK0Ppcaz9JoobZPx9tb6aTYbczn2k6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BWfSapQGLtP+8YDdlRpjLJ2mjzTTC3jVg0YJt69m7PeLLS+ZS6LfvTYMM2IGsJXXT
         yPhFBBM8jb0WXGzUZXKfgC2VclkdRK8Yunm0aSVk/Nr6b69H5fRH9u9NVVejTVxivd
         dS+cR7JXyOcnWGA88IsQFmpwgDhAhc4N4sgRx00U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Machek <pavel@denx.de>,
        Vladimir Oltean <olteanv@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 4.19 58/86] ARM: dts: ls1021a: Restore MDIO compatible to gianfar
Date:   Tue, 10 Mar 2020 13:45:22 +0100
Message-Id: <20200310124533.930803348@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310124530.808338541@linuxfoundation.org>
References: <20200310124530.808338541@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Oltean <olteanv@gmail.com>

commit 7155c44624d061692b4c13aa8343f119c67d4fc0 upstream.

The difference between "fsl,etsec2-mdio" and "gianfar" has to do with
the .get_tbipa function, which calculates the address of the TBIPA
register automatically, if not explicitly specified. [ see
drivers/net/ethernet/freescale/fsl_pq_mdio.c ]. On LS1021A, the TBIPA
register is at offset 0x30 within the port register block, which is what
the "gianfar" method of calculating addresses actually does.

Luckily, the bad "compatible" is inconsequential for ls1021a.dtsi,
because the TBIPA register is explicitly specified via the second "reg"
(<0x0 0x2d10030 0x0 0x4>), so the "get_tbipa" function is dead code.
Nonetheless it's good to restore it to its correct value.

Background discussion:
https://www.spinics.net/lists/stable/msg361156.html

Fixes: c7861adbe37f ("ARM: dts: ls1021: Fix SGMII PCS link remaining down after PHY disconnect")
Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/ls1021a.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -584,7 +584,7 @@
 		};
 
 		mdio0: mdio@2d24000 {
-			compatible = "fsl,etsec2-mdio";
+			compatible = "gianfar";
 			device_type = "mdio";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -593,7 +593,7 @@
 		};
 
 		mdio1: mdio@2d64000 {
-			compatible = "fsl,etsec2-mdio";
+			compatible = "gianfar";
 			device_type = "mdio";
 			#address-cells = <1>;
 			#size-cells = <0>;


