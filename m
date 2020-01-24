Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB50BC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFDB7214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579865283;
	bh=GiEP1PFnmkTJwrM55QZS/YPYJ481u6cUZfnoue7nGQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L2BTcplQkZu19tN4iCj6xXwZLlaDdzpG/MZShLDgDywOnuiskyi5+o/UMmxYEsVPv
	 LnWsbjXlRIGLA5p+S4dqFAq3vwE+bvzqgl6HQ/E4HTd8ELVyDsDcIt8mnzlwluqgwm
	 zzHBbCC7WuwHbv2izK1hMY7YEL2eK/hM1PbaB/Z4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403999AbgAXL2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:28:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:43792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391312AbgAXL1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:27:54 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 648282077C;
        Fri, 24 Jan 2020 11:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579865274;
        bh=GiEP1PFnmkTJwrM55QZS/YPYJ481u6cUZfnoue7nGQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eng3yL6j86lu+6Y05u5CqCoYzR6TBXIJNc7c4bA3TX+gxITcPtPSZFooMZlUgz/FY
         1inb6FtqZVGOF1dtgM3HiQ9DOPC+xpjg4vOHmXb2uML95MwMMDL6lnuOxB8agyThZA
         we2zZwKj5tNU8uS0RpErOF+q1VvUirLmxIcrq4ho=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fabrice Gasnier <fabrice.gasnier@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 493/639] ARM: dts: stm32: add missing vdda-supply to adc on stm32h743i-eval
Date:   Fri, 24 Jan 2020 10:31:03 +0100
Message-Id: <20200124093150.521142396@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 3f8e0c4a998d0..5bf64e63cdf35 100644
--- a/arch/arm/boot/dts/stm32h743i-eval.dts
+++ b/arch/arm/boot/dts/stm32h743i-eval.dts
@@ -79,6 +79,7 @@
 };
 
 &adc_12 {
+	vdda-supply = <&vdda>;
 	vref-supply = <&vdda>;
 	status = "okay";
 	adc1: adc@0 {
-- 
2.20.1



