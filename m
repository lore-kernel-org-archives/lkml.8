Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06E7C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 21:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5DB320857
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 21:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587158449;
	bh=KBRxRFTBeaK4Sp1zi8YSC3yjLurSvYb2PVh6yle5ySg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=FihAauAwLWHIrOZhsWYuUHCc6g+HhQRUJM1CXWwVN+ej+VWXSxU++iwichc7bUzkI
	 BIlyAd7xPaWeOJ+Lwihot/zUIGeFIA/GrjS/i41+OO60/wbkn1EHaXuwbdg40rd+Wt
	 ofSMBsQCR2feFnkkk8N6ehrb9i/aKIa0ZjqElHMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgDQVUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 17:20:48 -0400
Received: from mail-oo1-f68.google.com ([209.85.161.68]:36605 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgDQVUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 17:20:48 -0400
Received: by mail-oo1-f68.google.com with SMTP id x17so779846ooa.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 14:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OQ8VvxT9+3crfVwlWJJzfFn2WYEKasdv8UrQD4Rcn8E=;
        b=akhw1ZqXTj6+TJEB4oDVW/FthSCbua7pHET+7GFWvbGa2HTujRk3O6yR7VBWGfTFi+
         QOGvKm2aU/bstq7aBPlEk48unsqscZBOMBAKeQytJyUTPzlU3LrHplc8ZDicHYzwUqNm
         +rd4eTli6zRob+STJAzLxAmiTBd7zKcQur737QNRrEkj9PlXnxRjZYCasu9R9z3mHx2D
         tB4x7S81/lTEy/TwktiP1gzUiqv9HLptZ0Fmj9llQ6sI5wG9v2SlGDYkSV5yWRdxK82C
         219BWjMwkwaolBy6CqSmIS6V86sWO+4mFFtUeAbUkxSRtDdMpMV9u+xNLil8+FxjsQyH
         yYPA==
X-Gm-Message-State: AGi0PuYa4AJt8UNEMxJoHvSt54M/V55o3pSSQT08Rr3F98XXz3+ISP0h
        zr3D3qpf8wQ2IP6RpzyJyA==
X-Google-Smtp-Source: APiQypL6rSQWWm4O/O5NIKoI2/iuASc9VsPq/xS33QzFkpBAH2PsJauehqGS19xsRxbxU0NhZf8WBA==
X-Received: by 2002:a4a:2c8c:: with SMTP id o134mr4247569ooo.77.1587158446862;
        Fri, 17 Apr 2020 14:20:46 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id s25sm3651476ooh.22.2020.04.17.14.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 14:20:46 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] clocksource: versatile: Allow CONFIG_CLKSRC_VERSATILE to be disabled
Date:   Fri, 17 Apr 2020 16:20:45 -0500
Message-Id: <20200417212045.16917-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The timer-versatile driver provides a sched_clock for certain Arm Ltd.
reference platforms. Specifically, it is used on Versatile and 32-bit
VExpress. It is not needed for those platforms with an arch timer (all
the 64-bit ones) yet CONFIG_MFD_VEXPRESS_SYSREG does still need to be
enabled. In that case, the timer-versatile can only be disabled when
COMPILE_TEST is enabled which is not desirable. Let's use the sub-arch
kconfig symbols instead.

Realview platforms don't have the sysregs that this driver uses so
correct the help text.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
This is part of a larger effort to modularize Versatile Express support, 
but this change doesn't have any dependency, so it can be applied 
independently.

Rob

 drivers/clocksource/Kconfig | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index f2142e6bbea3..679b35fc07a8 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -562,12 +562,11 @@ config CLKSRC_VERSATILE
 	bool "ARM Versatile (Express) reference platforms clock source" if COMPILE_TEST
 	depends on GENERIC_SCHED_CLOCK && !ARCH_USES_GETTIMEOFFSET
 	select TIMER_OF
-	default y if MFD_VEXPRESS_SYSREG
+	default y if (ARCH_VEXPRESS || ARCH_VERSATILE) && ARM
 	help
 	  This option enables clock source based on free running
 	  counter available in the "System Registers" block of
-	  ARM Versatile, RealView and Versatile Express reference
-	  platforms.
+	  ARM Versatile and Versatile Express reference platforms.
 
 config CLKSRC_MIPS_GIC
 	bool
-- 
2.20.1

