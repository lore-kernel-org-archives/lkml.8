Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195B8C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 16:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE453207DA
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 16:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KeB/x5T+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgH2QBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 12:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728435AbgH2P7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 11:59:03 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0369C06123C
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 08:58:58 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id q3so1028344pls.11
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 08:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iXLYxKXetHW9WTJtF+vGPv55kJPJHPkGYNRwTSrKTCo=;
        b=KeB/x5T+auurih0+yuTY+7OioqiCvYGlG2DWIPT/zmh50G4R4sT/QA8r6a+FioR9xI
         GOImcIilnSzUdCIqJArAy8ugfrhiAFkHrMEP4DuaUz/vogacU1+knSh2BcSYbG5xuYi4
         t9s5mxCwMCydNBgzmZv2d0K12d8onSiocDGwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iXLYxKXetHW9WTJtF+vGPv55kJPJHPkGYNRwTSrKTCo=;
        b=EUJGzbWZ8TMc/UR4v+pF1xghMZIVmmE1GV3loe0oZiZGdsd54F5lB/Nnr6nIag/nBP
         0iH5hFCS4h0g+ay9ohHjQcz/8Jke78voNsAZfvS57b2y3tR/A/w6WfNW7zTW9PbsAnsO
         X57jpXBFil2YfkPn82xU6FjgzxbeELOIQyov9lS3ckm9ffbd9GgZ/JmupflJeux+mFak
         KBPMWvd6OEDXiGp9qIugFGNM37QmoxvDQGEa9LTAJ5ug9czo/EN+yTFUEm36de72zvV7
         DN9EkSPFV9Si2XhPyXkx8OYxmre6WEn4zzRGtk4tZR5IYBmuG05nEHL/t/Rq/VswJj3S
         ojCQ==
X-Gm-Message-State: AOAM532bu/bGGA7bI9MqjzWaHasTgjxmzb94JUzBKR6rcNmBQTqUg3qF
        oM2EX0EFodzuRLstlyVBw8386w==
X-Google-Smtp-Source: ABdhPJzjSZy/cBhLA6BC9pbWCJALB2J/HfYDGnXcW1uiUlt0SvanuHHz3S2i7dLHzNshBwTOph21ng==
X-Received: by 2002:a17:90a:77c7:: with SMTP id e7mr3487259pjs.175.1598716737286;
        Sat, 29 Aug 2020 08:58:57 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:9460:cfb8:90a:fedd])
        by smtp.gmail.com with ESMTPSA id j20sm3131714pfi.122.2020.08.29.08.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 08:58:56 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 6/7] arm64: dts: rockchip: px30: Add Engicam C.TOUCH 2.0
Date:   Sat, 29 Aug 2020 21:28:22 +0530
Message-Id: <20200829155823.247360-7-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200829155823.247360-1-jagan@amarulasolutions.com>
References: <20200829155823.247360-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Engicam C.TOUCH 2.0 is an EDIMM compliant general purpose
carrier board with capacitive touch interface.

Genaral features:
- TFT 10.1" industrial, 1280x800 LVDS display
- Ethernet 10/100
- Wifi/BT
- USB Type A/OTG
- Audio Out
- CAN
- LVDS panel connector

SOM's like PX30.Core needs to mount on top of this Carrier board
for creating complete PX30.Core C.TOUCH 2.0 board.

Add support for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- none

 arch/arm64/boot/dts/rockchip/px30-engicam-ctouch2.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-engicam-ctouch2.dtsi

diff --git a/arch/arm64/boot/dts/rockchip/px30-engicam-ctouch2.dtsi b/arch/arm64/boot/dts/rockchip/px30-engicam-ctouch2.dtsi
new file mode 100644
index 000000000000..cb00988953e9
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/px30-engicam-ctouch2.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020 Engicam srl
+ * Copyright (c) 2020 Amarula Solutions(India)
+ */
+
+#include "px30-engicam-common.dtsi"
-- 
2.25.1

