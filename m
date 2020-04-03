Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0EFC2BA12
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE6D72073B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djFdKEvT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390807AbgDCPnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 11:43:39 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51149 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgDCPni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 11:43:38 -0400
Received: by mail-wm1-f67.google.com with SMTP id t128so7634869wma.0;
        Fri, 03 Apr 2020 08:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LK/63VpRTinhiS72eGFe8hpGS9Ib9592eNpC47zP9eg=;
        b=djFdKEvTwrwu3CjbnLd2DYvKdWWmT3nTiRUjzGLsXnWqQKq+R5eIyZqf6vy3qOHK8U
         lo8rz2LKF2oDOXC794xOJzkCiONvpaVCcKcGtnu9BO/nqiyyz+q45cdXr63dEVbNQBWg
         lWzogL2owQshIUBQ7VXOrlBLemWBhscnAdyoxUqGH2GVHdUTj7hjTqD8lxvFAFqjQ39q
         jBKSCTXH8pLWl1dYeQTmvLGda8KIKWYue+cUBo2RD5NOFJjE2wqLJZCNaN1qk8cWOxlf
         bGqi7ZGbePD5JHM+2En0vexg2XVAXFkak0ZTBdGS3mTBUOQAhKRR8VZKFrET3hS0ZdwY
         Th4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LK/63VpRTinhiS72eGFe8hpGS9Ib9592eNpC47zP9eg=;
        b=Cjn9QrqGzaBjqfMXwBDvdDeQ8u/CCWM626aBxgCOJ4MU5OdDPaf9ic1sm1noHPAlHq
         INE0xlWUL1bPP8efn+A//CLwOnEK/hLrLFKoaxdjjcOesXkzUpKQHvHLsIPT81EhfEpT
         jPmMMFVEFz+JH9lgYOnbTJ/PctMVlFxuLBK/q0vaFDOLve54YoGQf5e+sAd1mRR55Rvp
         8+3fD4gyfonDR7kkQ3BoGRZas1kHM0tO2mUKCrwtrNbNLc0GrBt/nWB8pDCzBRDy8Vv1
         aX/9i6igb2Z5uH78SEV0e2+PvzDFp9dl7DgTBwoadEj9bOnN5OGa17+nI6Hhe0IWDrOb
         nUYA==
X-Gm-Message-State: AGi0PubN7Oo7C83zutF346+TKPhKDXuFjw+Mb1BhjLlwsNpboi8dLB8e
        24UiK7rS2PBTPRIDrTMFS5cHMJoo
X-Google-Smtp-Source: APiQypLNXXcyKij1x2E3kI4jmxsZKz7DUFMVECFp2pVDbsBupYf2V9AJPCMBidDJDkAUQpQ4APKy4Q==
X-Received: by 2002:a1c:8090:: with SMTP id b138mr9695849wmd.55.1585928616606;
        Fri, 03 Apr 2020 08:43:36 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id h2sm11701580wmb.16.2020.04.03.08.43.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 08:43:35 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] ARM: dts: rockchip: remove identical #include from rk3288.dtsi
Date:   Fri,  3 Apr 2020 17:43:27 +0200
Message-Id: <20200403154329.11256-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 2 identical '#include' for 'rk3288-power.h',
so remove one of them.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3288.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index e72368a7a..f102fec69 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -7,7 +7,6 @@
 #include <dt-bindings/clock/rk3288-cru.h>
 #include <dt-bindings/power/rk3288-power.h>
 #include <dt-bindings/thermal/thermal.h>
-#include <dt-bindings/power/rk3288-power.h>
 #include <dt-bindings/soc/rockchip,boot-mode.h>
 
 / {
-- 
2.11.0

