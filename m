Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3543C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E0C206F6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585056658;
	bh=Unh3rPOkR4ko5NKQUaz+SBxCMdPJ9H1YJmGubzUTjOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FHn+ugLAmIhcWGo5xvZpE+o76pCkrnKMLMR89X47cWvo/e3NACHHPPBnR8ZhpbCbP
	 ojzhgvjiGmWDs0gFKfDFv2ksAbPG1X9htjBPuHwqkXCgXVDscU6bTfMJAEC0RMBb6q
	 dKbnuhxRTpHTkmO2tb9LHqNlXRzbxBOrYuSOE0c8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbgCXNa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:30:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:43206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728825AbgCXNVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:21:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14BBF206F6;
        Tue, 24 Mar 2020 13:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585056082;
        bh=Unh3rPOkR4ko5NKQUaz+SBxCMdPJ9H1YJmGubzUTjOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wSDfz0FFDcvDAx+fzBAocp5ytK7yAg0IGWtUR6t7MUyw3R172M1opjuB75CU6z96o
         Jy0G2vxMdqNoR0RoPW4TdYLHwQwEL+mIIzfUQKbL9odAbg4WVmiLo4Ypw21IAkmcDD
         sm7fJD19bqzQkGmDiaEXyvwRRIoNRjVk0EaJkidg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 016/119] ARM: dts: bcm283x: Add missing properties to the PWR LED
Date:   Tue, 24 Mar 2020 14:10:01 +0100
Message-Id: <20200324130809.545443654@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130808.041360967@linuxfoundation.org>
References: <20200324130808.041360967@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Wahren <stefan.wahren@i2se.com>

[ Upstream commit bff211bab301db890e38de872d43cbb459940daa ]

This adds the missing properties to the PWR LED for the RPi 3 & 4 boards,
which are already set for the other boards. Without them we will lose
the LED state after suspend.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Tested-by: Peter Robinson <pbrobinson@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts      | 2 ++
 arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts | 2 ++
 arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
index 1b5a835f66bd3..b8c4b5bb265a9 100644
--- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
+++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
@@ -31,6 +31,8 @@
 		pwr {
 			label = "PWR";
 			gpios = <&expgpio 2 GPIO_ACTIVE_LOW>;
+			default-state = "keep";
+			linux,default-trigger = "default-on";
 		};
 	};
 
diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts b/arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts
index 66ab35eccba7b..28be0332c1c81 100644
--- a/arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts
+++ b/arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts
@@ -26,6 +26,8 @@
 		pwr {
 			label = "PWR";
 			gpios = <&expgpio 2 GPIO_ACTIVE_LOW>;
+			default-state = "keep";
+			linux,default-trigger = "default-on";
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
index 74ed6d0478070..37343148643db 100644
--- a/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
+++ b/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
@@ -27,6 +27,8 @@
 		pwr {
 			label = "PWR";
 			gpios = <&expgpio 2 GPIO_ACTIVE_LOW>;
+			default-state = "keep";
+			linux,default-trigger = "default-on";
 		};
 	};
 
-- 
2.20.1



