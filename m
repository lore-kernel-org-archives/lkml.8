Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3807C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A568120661
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579202618;
	bh=PQkF5WiXVBBjRd4qE+zHYDY8jdUM5rf3otSbtRDo+9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CMR161/M6SRBgdzNgKNCaK8rIIjWo+YB5WE4Ysq66t8QeQRNlQ2e+KM31JM4FkJre
	 cpJmEfDIBL53m3Yzkk0NXmSPHWQw8yGDgfNL2Hzxx+vsB3Kicgn+1mKbORbJJCh1v8
	 4NSCXvwyxyj/8xVK4j8Zyu4UiNCXSy4YXOEODHT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730677AbgAPQxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:53:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:36328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730546AbgAPQw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:52:56 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9F3D21D56;
        Thu, 16 Jan 2020 16:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193576;
        bh=PQkF5WiXVBBjRd4qE+zHYDY8jdUM5rf3otSbtRDo+9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zg7eypR0yOggV86daYCpfyt+D3TwFy3MvXwR1NxoaupHs3veDj91fpwSxFCUS4N1b
         F+utxL7C6cwCkcNWoSVDHc6iMTZr/J5HskAeixa4v/9c0S047SpnKfh5whTubsLaFi
         NAGwxOxPOlvZpBUVNyCiTFQvr80J60NmQg1S0F1Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>, linux-rtc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 119/205] rtc: bd70528: Add MODULE ALIAS to autoload module
Date:   Thu, 16 Jan 2020 11:41:34 -0500
Message-Id: <20200116164300.6705-119-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

[ Upstream commit c3e12e66b14a043daac6b3d0559df80b9ed7679c ]

The bd70528 RTC driver is probed by MFD driver. Add MODULE_ALIAS
in order to allow udev to load the module when MFD sub-device cell
for RTC is added.

I'm not sure if this is a bugfix or feature addition but I guess
fixes tag won't harm in this case.

Fixes: 32a4a4ebf768 ("rtc: bd70528: Initial support for ROHM bd70528 RTC")
Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Link: https://lore.kernel.org/r/20191023114711.GA13954@localhost.localdomain
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-bd70528.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-bd70528.c b/drivers/rtc/rtc-bd70528.c
index 7744333b0f40..ddfef4d43bab 100644
--- a/drivers/rtc/rtc-bd70528.c
+++ b/drivers/rtc/rtc-bd70528.c
@@ -491,3 +491,4 @@ module_platform_driver(bd70528_rtc);
 MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
 MODULE_DESCRIPTION("BD70528 RTC driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platofrm:bd70528-rtc");
-- 
2.20.1

