Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4782CC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 12:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21FFF206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 12:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="i0/Q4DUR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbgDMMPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 08:15:32 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:52860 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbgDMMP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 08:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1586780126; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=LmSdrv7+fVVwo5Lzew1t4N2yKOWFOzfy5ZCScCQ07L8=;
        b=i0/Q4DURI7xbnmcXdWEJUIjDL59khGFrUo1C/kC8g20kX1eG2FfCGPrsfCQudDzHf/sXb7
        YkmHSsRQ6tTcvgCeJKM4mQoVqRVfLo8lLh1gA69XdfhgovVgXXZFjT8upmF2+ESWkEvAkP
        Wqy1mJdjKRszhpmhBex2pJ13eeq/Row=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     od@zcrc.me, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/3] pwm: jz4740: Drop dependency on MACH_INGENIC
Date:   Mon, 13 Apr 2020 14:14:43 +0200
Message-Id: <20200413121445.72996-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on MACH_INGENIC prevent us from creating a generic kernel that
works on more than one MIPS board. Instead, we just depend on MIPS being
set.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/pwm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index eebbc917ac97..7814e5b2cad7 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -234,7 +234,7 @@ config PWM_IMX_TPM
 
 config PWM_JZ4740
 	tristate "Ingenic JZ47xx PWM support"
-	depends on MACH_INGENIC
+	depends on MIPS
 	depends on COMMON_CLK
 	select MFD_SYSCON
 	help
-- 
2.25.1

