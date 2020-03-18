Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AE4C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E264920719
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PRRCKzf4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgCRRnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:43:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41050 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbgCRRnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:43:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id h9so2737639wrc.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 10:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LnAT0cbyFmhoBQ00Ga1dspfG4naptUEJD59/Qz0lOxU=;
        b=PRRCKzf4bNfaTiGfWH6QKQv/dvGuLgHqvuvaV4gJcjkcxy2TykA6vkfuE/9hnW5nFy
         2C5jDZXp2cSPSeVa2h3zd+QwRPt4Aslz1Yt2dY5K3rm3bSJ3WN+ZwzMlNuJZRnLHLd5G
         MFY7QL0QVaxtIadyGNDpQHg1bLXXYKNL0c71NGQk+XkNrg2hpz1leQ/zVZV73wyUmAVf
         68gdoIW4mlGnNyiXLvf5nWVhSNsb/IccqAPNXpCYlq/rNKRVzZnW74eI+6npP1WQuyAa
         VcKudz8wE01E22QZoM7HfT8JPlUm/NEiKWRN/1QXmY17419evX78ww3/L+gekT97xd8q
         PfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LnAT0cbyFmhoBQ00Ga1dspfG4naptUEJD59/Qz0lOxU=;
        b=GryDGjx95IlKftZfezr0F01zngvM5Tg9j6ZXjOWlPoo+jGLaUGPLq6+/ntqIVEbihy
         A5lADWPFInrwrzb7PCy7owJiZZZwundVCb9wPVMhrBv/OduSjXUXm2KmIUcg81UZUrU0
         FJpMAPKrWMHfvv9Uap8YoiOwUsP7GXrGV2CGDN8xdrH2Dsm1bS1nlMfmh9giUlCVu7/r
         IdU2ZMA55SjBQqoudMyJO50Jf4KxolzjQEFBdDasES8tnV9/9kYIX90PXKgY0padLjQV
         Dp89WR3OCfvLFpeFpDaLiOkntfecqs8ggdFfcfu4pPkXB93FoFKt+OnRyIMKvIk89iS2
         mW7w==
X-Gm-Message-State: ANhLgQ2x8p0CtOvAc0P7TK6kkClgRN1/A1wf0gZMCY2TIQl1NYmEIzhP
        /euMJDD70m5nKVZvPSwxreSIUA==
X-Google-Smtp-Source: ADFU+vsd/NKHL4FhKagu2tXjW/yjB1glAeG3sSXkBnkwpLQzrlhtGiCdZpNzuliExWPaVJQE7Mu50w==
X-Received: by 2002:a5d:55c7:: with SMTP id i7mr6954159wrw.252.1584553386183;
        Wed, 18 Mar 2020 10:43:06 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:5d64:ea6:49bd:69d7])
        by smtp.gmail.com with ESMTPSA id r3sm3787212wrm.35.2020.03.18.10.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 10:43:05 -0700 (PDT)
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
Subject: [PATCH 20/21] clocksource/drivers/imx-sysctr: Remove unused includes
Date:   Wed, 18 Mar 2020 18:41:30 +0100
Message-Id: <20200318174131.20582-20-daniel.lezcano@linaro.org>
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
Link: https://lore.kernel.org/r/1584413713-7376-1-git-send-email-Anson.Huang@nxp.com
---
 drivers/clocksource/timer-imx-sysctr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clocksource/timer-imx-sysctr.c b/drivers/clocksource/timer-imx-sysctr.c
index b7c80a368a1b..18b90fc56bfc 100644
--- a/drivers/clocksource/timer-imx-sysctr.c
+++ b/drivers/clocksource/timer-imx-sysctr.c
@@ -4,8 +4,6 @@
 
 #include <linux/interrupt.h>
 #include <linux/clockchips.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
 
 #include "timer-of.h"
 
-- 
2.17.1

