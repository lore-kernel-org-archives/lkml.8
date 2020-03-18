Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33DFC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC22020719
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mQjz/15G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgCRRnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:43:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40057 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbgCRRnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:43:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id f3so24566001wrw.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 10:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OLEdaXjtX2QvHFSvAxOKprkBjwmITNNowmzF7dtiz/s=;
        b=mQjz/15GRRq88EJYvE0kMHybmWXH8Xj60dhiU5eD9Rfk0AhEh0M7o+nfRndV3f+nYd
         WF8dK4Bn6fmO+5rHWJhEwVHtZsTV0GHiTDAiJn7LeZXRamhfrcJWkelHRxC18mzJasG8
         8+kH9GfE4DgRVTONcCxAZAstaX1EAEPdCCjAhRBD/qi5jKTsba2kZh6zShA2DzkxonvO
         xoNJoU2AClEKAqOEa5gRCRrqISdUI5LJFoNrq5PXSDRQi+DGE0EygM5ofOGAeqk8juNL
         Vk30bQT4JnEvODf2k6Il9U2G6Ed+7YkQaKoNeA3aBNMYY3Xs9Qd3s4Fs4qUoQOVpgwsP
         PwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OLEdaXjtX2QvHFSvAxOKprkBjwmITNNowmzF7dtiz/s=;
        b=NzfVQC2BsthfNv7/zaJKVczFLB/RQyOuJ37YpzumkSVKeDq5y/E3dKBsLghImzQcRz
         KAA99PxtYxJtZbKPFL0YsMxiPzm5gm611ITXJ9rUAM6hxp0Ue85OxxMylrwqCUfjqDHO
         2lCAlGpIX7XVXeJZj1sSiEZoj5QdhmPH8FjY9wuH6fmXr7tfY09JJTJySQtkR3kVMC+D
         vUCG1Y7sJKQj/IOyB+61DWjjleB+QMdHzG/TgWEGbidAp7iHyOucgU7X3dNHB7fos3HI
         jpTMpO1BIe1eOn9doqeFOpksQEk1ypkZb54Wp7r4EcGxFalthmBLbHAWDdMaDk8RVy25
         z+kA==
X-Gm-Message-State: ANhLgQ1p70CgMvPsXxMTy4tuk7S7t3+EDKCw95Vm6qPq85QrDx///Xak
        usDzsCLJGKnEcVhnqkn5pUfATQ==
X-Google-Smtp-Source: ADFU+vtrXDCNxqZAb1paHCpQ+8ecsai5Blo9z2pHfrC1Pris7MF8wb9y6tQKc9tzR2XpIF3JHbEHag==
X-Received: by 2002:a5d:6a8d:: with SMTP id s13mr6677670wru.11.1584553384489;
        Wed, 18 Mar 2020 10:43:04 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:5d64:ea6:49bd:69d7])
        by smtp.gmail.com with ESMTPSA id r3sm3787212wrm.35.2020.03.18.10.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 10:43:03 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Anson Huang <Anson.Huang@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE)
Subject: [PATCH 19/21] clocksource/drivers/imx-tpm: Remove unused includes
Date:   Wed, 18 Mar 2020 18:41:29 +0100
Message-Id: <20200318174131.20582-19-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318174131.20582-1-daniel.lezcano@linaro.org>
References: <e6cd8adf-60df-437a-003f-58e3403e4697@linaro.org>
 <20200318174131.20582-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

There is nothing in use from of_address.h/of_irq.h, remove them.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/1584412549-18354-1-git-send-email-Anson.Huang@nxp.com
---
 drivers/clocksource/timer-imx-tpm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
index c1d52d5264c2..6334a35fdc2f 100644
--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -8,8 +8,6 @@
 #include <linux/clocksource.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
 #include <linux/sched_clock.h>
 
 #include "timer-of.h"
-- 
2.17.1

