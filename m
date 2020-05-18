Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7E8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B142320674
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589823921;
	bh=NM+61okHoeZrlRYKybin1UV6GNvIOPisbB5yJ8j6QjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Evy+BmQS0aepI0V5pIb6z/6fvOdrSZbRnFm9f2B/cjpSzn8OuqQtDi8VNRaDxBbPF
	 lN/7bToMQcc8HVmkbyWUkiyjUEZLpj4bbLO3Hlohs7rFLrj+TpKcJzpQphZsFsiDeF
	 D3gdgGmWb7URMFfxv402G1NCm+KgBZqURCAmymns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbgERRpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:45:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:43986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729896AbgERRpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:45:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E729F20657;
        Mon, 18 May 2020 17:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589823915;
        bh=NM+61okHoeZrlRYKybin1UV6GNvIOPisbB5yJ8j6QjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q/2Gjp0OwBAaGw70w8NAMAJiMesBTBtsOedfA1iBUptmY8c5z1+5bTWYu9n7DArJX
         I0kmoaOBpPBxfgFwngtrAQwBzhfMauW+1/DenQbqDUvMx1LhJodwr0syx2ChI3h/DR
         PdcnzXPcWXBd3lik/3pcTDAqBM1x9wqqTamSAsjs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 4.9 87/90] ARM: dts: r8a73a4: Add missing CMT1 interrupts
Date:   Mon, 18 May 2020 19:37:05 +0200
Message-Id: <20200518173508.807412847@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173450.930655662@linuxfoundation.org>
References: <20200518173450.930655662@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 0f739fdfe9e5ce668bd6d3210f310df282321837 upstream.

The R-Mobile APE6 Compare Match Timer 1 generates 8 interrupts, one for
each channel, but currently only 1 is described.
Fix this by adding the missing interrupts.

Fixes: f7b65230019b9dac ("ARM: shmobile: r8a73a4: Add CMT1 node")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20200408090926.25201-1-geert+renesas@glider.be
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/r8a73a4.dtsi |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -135,7 +135,14 @@
 	cmt1: timer@e6130000 {
 		compatible = "renesas,cmt-48-r8a73a4", "renesas,cmt-48-gen2";
 		reg = <0 0xe6130000 0 0x1004>;
-		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A73A4_CLK_CMT1>;
 		clock-names = "fck";
 		power-domains = <&pd_c5>;


