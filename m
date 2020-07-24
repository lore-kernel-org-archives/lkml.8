Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37C5C4346A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 943252074F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595576609;
	bh=KtM49i0V08bRy4KEevLt7MwZmAFXsueBkkylkf7FmD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Po6n9wpnt/1kMMzCc28EXl1CFBaKKorgXIscKgbJDQXZBBAjJP5k9pRLDCPnOZIyl
	 a7CgJxQAiuRvS2vZRuWxOFWyJe4gJVgDxBDLA3J76tgWcdiU0lD7gwKEbNCcIdnTrq
	 C2snrz/vLubj1yIJP8tPq9b/eUqYyP0JlKQYycmw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbgGXHn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:43:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:37698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726607AbgGXHn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:43:27 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36E1E2076A;
        Fri, 24 Jul 2020 07:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595576606;
        bh=KtM49i0V08bRy4KEevLt7MwZmAFXsueBkkylkf7FmD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ETmX7RHojUwKnONwYfzjhyrsaZYbAM/T/HeQn7dUgZMaQpjofjgd8OQWOFeFiRggO
         785drOokRYVsZt/75hNUwcI90V7jHkIfrHj8vUTu9hlbERhdeI7VBOJIkpF1y0Tv2v
         MZeaIC1ksmQbMU9OZRMb+bWCwoyPZElcWh9fD7rs=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Roger Quadros <rogerq@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kukjin Kim <kgene@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 28/29] memory: Describe the MEMORY Kconfig entry
Date:   Fri, 24 Jul 2020 09:40:37 +0200
Message-Id: <20200724074038.5597-29-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200724074038.5597-1-krzk@kernel.org>
References: <20200724074038.5597-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Write short description about the entire memory controllers section.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. New patch
---
 drivers/memory/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index c37752d5f26d..ec735794aeaf 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -5,6 +5,12 @@
 
 menuconfig MEMORY
 	bool "Memory Controller drivers"
+	help
+	  This option allows to enable specific memory controller drivers,
+	  useful mostly on embedded systems.  These could be controllers
+	  for DRAM (SDR, DDR), ROM, SRAM and others.  The drivers features
+	  vary from memory tuning and frequency scaling to enabling
+	  access to attached peripherals through memory bus.
 
 if MEMORY
 
-- 
2.17.1

