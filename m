Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2867C33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CFAF2468B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686283;
	bh=+k8l0cfdUeAkxe5nbdoC1OBbTIvPc5WFvyER10yZ+iI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BvBjIZ5dMipwIOTzyFgacImE/YycMQsasVlUIitINaWP31baWTX1U62cEFUd4C2qL
	 0CHomV9XKOSaxkef8IiEYhrYQgSeEAbVe0QmpD+8j4gVkbEx5xRs4UoDtiYrgICo5p
	 Sx5Cp76Mv0VNUWCWAlJp1xxAavJrxdgOS4pqHJvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387759AbgAVJom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:44:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:37898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388061AbgAVJog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:44:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37A3A2468D;
        Wed, 22 Jan 2020 09:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579686275;
        bh=+k8l0cfdUeAkxe5nbdoC1OBbTIvPc5WFvyER10yZ+iI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n31cJuzlQeeagUKCgH9SbIhpxX4GyTkDxquaA0Zw/1qCow1rZObPMyrUG5C/5KijZ
         0ANurS50t6zrsKMQ5FB1uWfvbkvmkmj2G163EyAKgasMPrjGg04kU83A5Sj26aCAxh
         fa8+9y2Qr2yps/GMe2qAn2D1Et986+wFOLGxjBhA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 5.4 012/222] arm64: dts: imx8mq-librem5-devkit: use correct interrupt for the magnetometer
Date:   Wed, 22 Jan 2020 10:26:38 +0100
Message-Id: <20200122092834.255279802@linuxfoundation.org>
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

From: Angus Ainslie (Purism) <angus@akkea.ca>

commit 106f7b3bf943d267eb657f34616adcaadb2ab07f upstream.

The LSM9DS1 uses a high level interrupt.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
Fixes: eb4ea0857c83 ("arm64: dts: fsl: librem5: Add a device tree for the Librem5 devkit")
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -421,7 +421,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_imu>;
 		interrupt-parent = <&gpio3>;
-		interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <19 IRQ_TYPE_LEVEL_HIGH>;
 		vdd-supply = <&reg_3v3_p>;
 		vddio-supply = <&reg_3v3_p>;
 	};


