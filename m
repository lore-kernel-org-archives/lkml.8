Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3990C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D713B207C4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589826566;
	bh=d4BMgLQoXzWEKnQZXDP1fQuQggJi+WIqwZC85rLTDCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MhUTVtvq0XUTbLjmE5WW4vQYPyv9weAudwXrCAJiu1vyGtkYkdOIL+PBf9Wpb6QZC
	 ftOsTH+bB/HTpqYzEF/VifmatbeAyj4E9USsNRoAXe+B7v9PzcL310P88OU69N5tvM
	 r6yBWz58olNcjRr8pLvrE5fQXrKcTR5oPYD3RcTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgERRlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:41:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:37980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729294AbgERRlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:41:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8748420657;
        Mon, 18 May 2020 17:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589823695;
        bh=d4BMgLQoXzWEKnQZXDP1fQuQggJi+WIqwZC85rLTDCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YMFzhB7UshjTh1m+AllZ3M0AdMtCLywJfRhZnGr78FYAJ1ME9CTDAAvRydKAPyi/l
         RbGIJCcW2EQ8kzbs4gTSJT34St2/yzgbBF8b/TIV3d4WJoTEP17pgXSHSrQWSs466T
         s2GbwWFbmomP4PbXiGpLwvvsvFMdBg2zCpDHUuKo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ulrich Hecht <uli+renesas@fpond.eu>
Subject: [PATCH 4.4 84/86] ARM: dts: r8a7740: Add missing extal2 to CPG node
Date:   Mon, 18 May 2020 19:36:55 +0200
Message-Id: <20200518173507.594465380@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173450.254571947@linuxfoundation.org>
References: <20200518173450.254571947@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit e47cb97f153193d4b41ca8d48127da14513d54c7 upstream.

The Clock Pulse Generator (CPG) device node lacks the extal2 clock.
This may lead to a failure registering the "r" clock, or to a wrong
parent for the "usb24s" clock, depending on MD_CK2 pin configuration and
boot loader CPG_USBCKCR register configuration.

This went unnoticed, as this does not affect the single upstream board
configuration, which relies on the first clock input only.

Fixes: d9ffd583bf345e2e ("ARM: shmobile: r8a7740: add SoC clocks to DTS")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>
Link: https://lore.kernel.org/r/20200508095918.6061-1-geert+renesas@glider.be
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/r8a7740.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -461,7 +461,7 @@
 		cpg_clocks: cpg_clocks@e6150000 {
 			compatible = "renesas,r8a7740-cpg-clocks";
 			reg = <0xe6150000 0x10000>;
-			clocks = <&extal1_clk>, <&extalr_clk>;
+			clocks = <&extal1_clk>, <&extal2_clk>, <&extalr_clk>;
 			#clock-cells = <1>;
 			clock-output-names = "system", "pllc0", "pllc1",
 					     "pllc2", "r",


