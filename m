Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA60BC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C242077B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579202274;
	bh=qOQzyhtcbChDzzbv1LEMKJgJf4TpU+N7xoKSA4d6j2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jkBnBtkgLoqHI5XKVB1x/l6mbb3KWhc0hojq9xavhgu5og8TZ6VI94KbjbpZpC/h8
	 Xv4zBPwIc973M4ZwuIRl5K7QBmWgrFgxM3GqDuZaLKFf7ZhRB78ZykEkwFq2ubcLsu
	 eolfHfUiJf807xS24O79/jlmeL2oplTTcH79+Pk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730507AbgAPQzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:55:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:39988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729340AbgAPQzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:55:06 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30EAD22522;
        Thu, 16 Jan 2020 16:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193705;
        bh=qOQzyhtcbChDzzbv1LEMKJgJf4TpU+N7xoKSA4d6j2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ssqj/+C3XsCKeXSJZFL5dZCVRxBl4O002yKwMlyPAGE2JcnLwz29beJLf0jl1BG1r
         hTWYoU43jSzS+nIhne2s3SpCIBrfvwpPCZlbtdtjUeu8uI4v72+rV3M6rZMdev5CiH
         vLijMY7x/JluTOhr/wdEqP2fFT7U553KoJyi8160=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 002/671] ARM: dts: at91: nattis: set the PRLUD and HIPOW signals low
Date:   Thu, 16 Jan 2020 11:43:53 -0500
Message-Id: <20200116165502.8838-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165502.8838-1-sashal@kernel.org>
References: <20200116165502.8838-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Rosin <peda@axentia.se>

[ Upstream commit 29feb2c960ab32fc24249443d4434194ce96f083 ]

AT91_PINCTRL_OUTPUT_VAL(0) without AT91_PINCTRL_OUTPUT is a no-op, so
make sure the pins really output a zero.

Fixes: 0e4323899973 ("ARM: dts: at91: add devicetree for the Axentia Nattis with Natte power")
Signed-off-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/at91-nattis-2-natte-2.dts | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91-nattis-2-natte-2.dts b/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
index af9f38456d04..bfa5815a0721 100644
--- a/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
+++ b/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
@@ -38,14 +38,16 @@
 						atmel,pins =
 							<AT91_PIOA 21
 							 AT91_PERIPH_GPIO
-							 AT91_PINCTRL_OUTPUT_VAL(0)>;
+							 (AT91_PINCTRL_OUTPUT |
+							  AT91_PINCTRL_OUTPUT_VAL(0))>;
 					};
 
 					pinctrl_lcd_hipow0: lcd_hipow0 {
 						atmel,pins =
 							<AT91_PIOA 23
 							 AT91_PERIPH_GPIO
-							 AT91_PINCTRL_OUTPUT_VAL(0)>;
+							 (AT91_PINCTRL_OUTPUT |
+							  AT91_PINCTRL_OUTPUT_VAL(0))>;
 					};
 				};
 			};
-- 
2.20.1

