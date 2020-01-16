Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E63C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4545A21D56
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579193592;
	bh=yu1pKmc/UuygvIf1h74p6ClN+6r0N/CpuaWnqJNI+8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a97rbB869uHiH6TszK5LFetGeomUzSeNdGqXczd5Sevo840gUX03vU6cD/wJOxEYv
	 MBbvLL58bVIfBc+xkRPwAFuFqecjNzEi0NO7C9nqtTitgfGwEEVuMfEScbrJ6Z7j09
	 E+qeAJvFYmye0XEztmMcwKg+MdzXBf60k/Y+tX8E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730692AbgAPQxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:53:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:36350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729610AbgAPQw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:52:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD1352464B;
        Thu, 16 Jan 2020 16:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193577;
        bh=yu1pKmc/UuygvIf1h74p6ClN+6r0N/CpuaWnqJNI+8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zS8X2fd7RoRYvWLaVvVSUHRUiN/D7ljYsFCOGp6KQ5WWj0e6YnGN/RDUnXWROmPeB
         XTYnL79OYSRA63BvexFCXsWJsLzwN88m5J9MqJBhpEXhw20ESaISQxHxqa6tS6yku8
         164DM/W4ACkBTqNmc3fvxGEV3ZCdcWjuJArw/rxU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>, linux-rtc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 120/205] rtc: bd70528: fix module alias to autoload module
Date:   Thu, 16 Jan 2020 11:41:35 -0500
Message-Id: <20200116164300.6705-120-sashal@kernel.org>
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

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit afe19a7ae8b6b6032d04d3895ebd5bbac7fe9f30 ]

The module alias platform tag contains a spelling mistake. Fix it.

Fixes: f33506abbcdd ("rtc: bd70528: Add MODULE ALIAS to autoload module")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Link: https://lore.kernel.org/r/20191106083418.159045-1-colin.king@canonical.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-bd70528.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-bd70528.c b/drivers/rtc/rtc-bd70528.c
index ddfef4d43bab..627037aa66a8 100644
--- a/drivers/rtc/rtc-bd70528.c
+++ b/drivers/rtc/rtc-bd70528.c
@@ -491,4 +491,4 @@ module_platform_driver(bd70528_rtc);
 MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
 MODULE_DESCRIPTION("BD70528 RTC driver");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platofrm:bd70528-rtc");
+MODULE_ALIAS("platform:bd70528-rtc");
-- 
2.20.1

