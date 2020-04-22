Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897A3C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68C7D20857
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587550445;
	bh=ZIZwPWB9Q6NZv4fDKlr0cQJtBfcBFdOoZdqqJkEjXX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ONwQseHd/oRqdCM05nxf7I1dcKo7gKw8GuB6FoUvnFJHBkFCgC3m+1waZ3Gt7wAHc
	 iOi5Sg20y9f4bsR+4nLlCv0PyHfpxecLC7M2yhu9TytcORSrYsKfIeQhjKlT/TdKF7
	 pc5EC1Y0rzW6yl+5SDaHBqHUo8lcv2w0djmQ/Wck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbgDVKOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:14:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726398AbgDVKN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:13:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 298BF2076E;
        Wed, 22 Apr 2020 10:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550435;
        bh=ZIZwPWB9Q6NZv4fDKlr0cQJtBfcBFdOoZdqqJkEjXX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TmKaAKiZ+KQlZo3Ti14Vrm62pYsj04UFaDWa/U+8ULOprmmttvH7BiKzDw2wkXVys
         ZQLu7EI0ZqKA3Wr+tNjJl+Ehr49Mf38RS6CdxL98uy8FMJ3LHMbAA5gM8M8MhdOE7j
         C37P7YozVvaEHcH237MshOQneJ8IqUS/a0NR6yMI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Fuzzey <martin.fuzzey@flowbird.group>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 07/64] ARM: dts: imx6: Use gpc for FEC interrupt controller to fix wake on LAN.
Date:   Wed, 22 Apr 2020 11:56:51 +0200
Message-Id: <20200422095013.710989670@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095008.799686511@linuxfoundation.org>
References: <20200422095008.799686511@linuxfoundation.org>
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
@@ -1013,9 +1013,8 @@
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


