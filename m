Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F4CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A1624688
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699282;
	bh=zv2m0+Msco86uDoLUfkHwd61ijlq3Gp5aGpEuK8/KFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tQYmrKU06K2BKA+fvc9jmjVeTuz3LayUX0kx82ydCJcy8os7C8uCpQDRKVF0xKi28
	 b0HrVT04tfqTdgd1Mb1iO2Uy/U9UIu+wyhQ0tAyx9U+KQ51r6f1B+DM1bQjyLlzwyg
	 eCCbxjiU16nUtmjr8y/P6Kj5Dxa45IxYiw0kSpMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbgAVNVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:21:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:38150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730200AbgAVNVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:21:18 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B49382467B;
        Wed, 22 Jan 2020 13:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699278;
        bh=zv2m0+Msco86uDoLUfkHwd61ijlq3Gp5aGpEuK8/KFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tbxdBUB779zn4AbOv4PA4y9VWUnymF+kfmL2i3kfleppXqtNi8P+70F/zBuyqXWNn
         XmezljB0pCUTJ4E2ajUUixMsFZADZggI1XkQqg3kKtRKDqq5p91xWB8Zg7DHk4hiOC
         +AT6hafRtGXOoDS0u3PQwVslUtpLwmgiiBjQE4w4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anson Huang <Anson.Huang@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 5.4 095/222] ARM: dts: imx6sl-evk: Remove incorrect power supply assignment
Date:   Wed, 22 Jan 2020 10:28:01 +0100
Message-Id: <20200122092840.541921944@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

commit b4eb9ef0e29cd28c6fd684e0ab77bda824acb20e upstream.

The vdd3p0 LDO's input should be from external USB VBUS directly, NOT
PMIC's power supply, the vdd3p0 LDO's target output voltage can be
controlled by SW, and it requires input voltage to be high enough, with
incorrect power supply assigned, if the power supply's voltage is lower
than the LDO target output voltage, it will return fail and skip the LDO
voltage adjustment, so remove the power supply assignment for vdd3p0 to
avoid such scenario.

Fixes: 3feea8805d6f ("ARM: dts: imx6sl-evk: Assign corresponding power supply for LDOs")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/imx6sl-evk.dts |    4 ----
 1 file changed, 4 deletions(-)

--- a/arch/arm/boot/dts/imx6sl-evk.dts
+++ b/arch/arm/boot/dts/imx6sl-evk.dts
@@ -584,10 +584,6 @@
 	vin-supply = <&sw2_reg>;
 };
 
-&reg_vdd3p0 {
-	vin-supply = <&sw2_reg>;
-};
-
 &reg_vdd2p5 {
 	vin-supply = <&sw2_reg>;
 };


