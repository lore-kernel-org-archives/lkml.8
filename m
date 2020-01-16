Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0029CC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDB5524703
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579195727;
	bh=M6QDKkBnweTBN8PV3G31m4jegzT+8ZGFNXWqYrBwOFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kkud/xDMNtXJqEig/Vd2yPDAg8vGZwqb4Gk1GTiyg6JZXOMC2qtb1WveqT2TxJLGO
	 ngaQHyPRO1f7TFw7/Rh0iI/thXUGXbOiqWSLfCmGfDDFMER24b8eq8bylwKdOPdQLO
	 v78gL1xflUFw8gVby9Dcf8or2EjPeNlZ2aPIHugw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392650AbgAPR2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:28:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:39776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392601AbgAPR2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:28:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5472246F2;
        Thu, 16 Jan 2020 17:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195714;
        bh=M6QDKkBnweTBN8PV3G31m4jegzT+8ZGFNXWqYrBwOFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NATr0SZz9P5IAVIAWG7Mgh6PE9RSTQDZGt5qGK37P3LlKUvU51poEhap8T/Be9k/n
         QCAEMe+aUnCZ6sWKQzy81/wIgOLoRbXusvKl/A0+2Z1Bw1g8hUhFWxouxD3C2juTD5
         7HY2Bz+H17ZL/oA5GzHvoUbZMyf9idMysTnThlyU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Fabrice Gasnier <fabrice.gasnier@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 259/371] ARM: dts: stm32: add missing vdda-supply to adc on stm32h743i-eval
Date:   Thu, 16 Jan 2020 12:22:11 -0500
Message-Id: <20200116172403.18149-202-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabrice Gasnier <fabrice.gasnier@st.com>

[ Upstream commit 493e84c5dc4d703d976b5875f5db22dae08a0782 ]

Add missing vdda-supply required by STM32 ADC.

Fixes: 090992a9ca54 ("ARM: dts: stm32: enable ADC on stm32h743i-eval
board")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/stm32h743i-eval.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/stm32h743i-eval.dts b/arch/arm/boot/dts/stm32h743i-eval.dts
index 6c07786e7ddb..0d98b2865bd7 100644
--- a/arch/arm/boot/dts/stm32h743i-eval.dts
+++ b/arch/arm/boot/dts/stm32h743i-eval.dts
@@ -71,6 +71,7 @@
 };
 
 &adc_12 {
+	vdda-supply = <&vdda>;
 	vref-supply = <&vdda>;
 	status = "okay";
 	adc1: adc@0 {
-- 
2.20.1

