Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871F4C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53759207FF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579193261;
	bh=dhhbX6ij0FJ90/04ldXUev7Hfd1P56CKr8nC90spKuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UFVe0Bbbm8WUcxvz8I3wtJRHRkskecYKlZmTHeYOxVpNmQahDJra9c4ioWXj0fFbt
	 0E/S1pYphtSHr+8aqUTsLAMwu/NFxgsp/9DCD+0Qo9dhzLw1yzo/gyXnay13NNx7XU
	 NtB0lvP/CFrnZJrfNgG4ToF5YqVDIZKuaNMVUm7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgAPQrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:47:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:57484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729961AbgAPQrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:47:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDE262073A;
        Thu, 16 Jan 2020 16:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193256;
        bh=dhhbX6ij0FJ90/04ldXUev7Hfd1P56CKr8nC90spKuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HWLYANuVHV71kOBMubun2ntCMkaiOoRpjantoyXimskyY3drGEFqclLSMM2MTfgji
         FwdLh9FkQsCj0cz21epq2aPRuEWbK9cloZP6pXlG+wKt1KkZsAMahy9PTw8yn3Ku0r
         9ueR9UkrFOEEMZnN3r1kYRHvwCvG55+SszTUEaf8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 056/205] regulator: bd70528: Add MODULE_ALIAS to allow module auto loading
Date:   Thu, 16 Jan 2020 11:40:31 -0500
Message-Id: <20200116164300.6705-56-sashal@kernel.org>
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

[ Upstream commit 55d5f62c3fa005a6a8010363d7d1855909ceefbc ]

The bd70528 regulator driver is probed by MFD driver. Add MODULE_ALIAS
in order to allow udev to load the module when MFD sub-device cell for
regulators is added.

Fixes: 99ea37bd1e7d7 ("regulator: bd70528: Support ROHM BD70528 regulator block")
Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Link: https://lore.kernel.org/r/20191023121452.GA1812@localhost.localdomain
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/bd70528-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/bd70528-regulator.c b/drivers/regulator/bd70528-regulator.c
index 6041839ec38c..5bf8a2dc5fe7 100644
--- a/drivers/regulator/bd70528-regulator.c
+++ b/drivers/regulator/bd70528-regulator.c
@@ -285,3 +285,4 @@ module_platform_driver(bd70528_regulator);
 MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
 MODULE_DESCRIPTION("BD70528 voltage regulator driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:bd70528-pmic");
-- 
2.20.1

