Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DB2C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB1A32076D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586956262;
	bh=Mc1pIuQsFh+DB+kAcRNt4P2NwE+ll1nbXbIDWqB5Y6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n0TOlzX4lTAUPJBtxmLvcvVw9B6cffxrpwOvKrQ47oLfHdqBYZ12jRh/aOff8yhxN
	 RvZli1IyQgMppu3hSNN9LwLQF1E19vbGkC1GbVzDHlycZf9+0k6wHnlPPPEPsnmsTG
	 e//FFOl2N+RZVi60AaJAYZ9RihsBw8sp/Y2S7VzU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506071AbgDONK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 09:10:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:55270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897071AbgDOLfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:35:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4005C20775;
        Wed, 15 Apr 2020 11:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586950541;
        bh=Mc1pIuQsFh+DB+kAcRNt4P2NwE+ll1nbXbIDWqB5Y6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RhPH6ZraU6gLKYwP/Bz7uX1p9NRo1axFCHYoPReu1wzYAhv1J1iyjSzM2WOzISc6F
         4rQKZ9vEuvFQIkpayv5HYgHIWbMl5/oycOcqJooz10u8aBl9ta7HVz7MPf43dGxSGJ
         TfJ4199XfFEspLPdOufsUBI7BNrYyX/DK2QB45fo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alex Smith <alex.smith@imgtec.com>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 048/129] MIPS: DTS: CI20: add DT node for IR sensor
Date:   Wed, 15 Apr 2020 07:33:23 -0400
Message-Id: <20200415113445.11881-48-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415113445.11881-1-sashal@kernel.org>
References: <20200415113445.11881-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Smith <alex.smith@imgtec.com>

[ Upstream commit f5e8fcf85a25bac26c32a0000dbab5857ead9113 ]

The infrared sensor on the CI20 board is connected to a GPIO and can
be operated by using the gpio-ir-recv driver. Add a DT node for the
sensor to allow that driver to be used.

Signed-off-by: Alex Smith <alex.smith@imgtec.com>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Reviewed-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/boot/dts/ingenic/ci20.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index c340f947baa03..fc4e64200c3d5 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -62,6 +62,11 @@
 		enable-active-high;
 	};
 
+	ir: ir {
+		compatible = "gpio-ir-receiver";
+		gpios = <&gpe 3 GPIO_ACTIVE_LOW>;
+	};
+
 	wlan0_power: fixedregulator@1 {
 		compatible = "regulator-fixed";
 		regulator-name = "wlan0_power";
-- 
2.20.1

