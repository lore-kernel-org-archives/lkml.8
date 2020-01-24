Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A331AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F7F2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579865278;
	bh=gU8F7Tl6DvBKb/PH4OgLQKOtUUaB6PKZI6b+LjlOG2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tpGqTMY1oUFA9rU0mCx0GfIrKgp21+B/yLGWe3kezPvFDB5UUush8pkRNQsWQ8jxl
	 fwNka9z4I1m/rioLGVhzDn+aw21nyuXpwXKPHQIixuHf/WiDMOuBouxfjdCUmmwMnZ
	 9o4oM3m80bzoLKFoF8GJrRdM+gbmA6XwRLfbJsW0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403913AbgAXL14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:27:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:43706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391686AbgAXL1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:27:52 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEC4A214AF;
        Fri, 24 Jan 2020 11:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579865270;
        bh=gU8F7Tl6DvBKb/PH4OgLQKOtUUaB6PKZI6b+LjlOG2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1i98ZclKeSL8A2uv0NVrKrQ6iIftkRbxrXcwhnFaEt2ARs2uAADPz/5unNRPpe6pp
         KY88/bp2fp8IqW2XX1yy7fORZm9T8KrQRCmcX/8YfridvCu8g3233WixMwEG1rVQwE
         aXSdzaC2XtuJQGcX4vJdx8q2d9oJtLI9kEcUB+PM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Olof Johansson <olof@lixom.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 477/639] ARM: stm32: use "depends on" instead of "if" after prompt
Date:   Fri, 24 Jan 2020 10:30:47 +0100
Message-Id: <20200124093147.884676121@linuxfoundation.org>
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

From: Masahiro Yamada <yamada.masahiro@socionext.com>

[ Upstream commit 7e8a0f10899075ac2665c78c4e49dbaf32bf3346 ]

This appeared after the global fixups by commit e32465429490 ("ARM: use
"depends on" for SoC configs instead of "if" after prompt"). Fix it now.

Link: https://lore.kernel.org/r/20190710051320.8738-1-yamada.masahiro@socionext.com
Fixes: e32465429490 ("ARM: use "depends on" for SoC configs instead of "if" after prompt")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-stm32/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-stm32/Kconfig b/arch/arm/mach-stm32/Kconfig
index 713c068b953fb..adca4368d67c4 100644
--- a/arch/arm/mach-stm32/Kconfig
+++ b/arch/arm/mach-stm32/Kconfig
@@ -1,5 +1,6 @@
 menuconfig ARCH_STM32
-	bool "STMicroelectronics STM32 family" if ARM_SINGLE_ARMV7M || ARCH_MULTI_V7
+	bool "STMicroelectronics STM32 family"
+	depends on ARM_SINGLE_ARMV7M || ARCH_MULTI_V7
 	select ARMV7M_SYSTICK if ARM_SINGLE_ARMV7M
 	select HAVE_ARM_ARCH_TIMER if ARCH_MULTI_V7
 	select ARM_GIC if ARCH_MULTI_V7
-- 
2.20.1



