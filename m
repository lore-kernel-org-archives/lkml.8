Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B827C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 089A920706
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XElZtWvW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgDXPLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727886AbgDXPLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:11:16 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40335C09B045;
        Fri, 24 Apr 2020 08:11:16 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u16so11190600wmc.5;
        Fri, 24 Apr 2020 08:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GSOYiwkqZKLb7y47h2QBV30Cg8CF5SiWC7cPuAELcE0=;
        b=XElZtWvWYfo+l3n7mMqN1xxPqug0hipNIvwZbiMvLDeqdtBuwB/R/6eVVvDvJxBgcO
         n+a23AuCg9C9WCRJyzvHwUZavxy47Fp07az0w1Kcn/xtsYYARq+oDFsMiZTSzhfnC5ig
         2AChAZhyFp+edQTpegElq6dzHnqWvbqtu+i5ZuOf/NYmxkNDTIyCNhAMt7L06VkCxMdS
         hWtnusjfCzjMpyUtFQuZR96Az07KImi9q8sgJi/2krbFS0lQMcOMClOTqwNFm5xxZX/V
         9IsR2fdCccxkXJprwt9cKc7QCxOd3g/sYqt0v+mn95AcIUCMeWFvl4KmBZFP9NCROubp
         Fzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GSOYiwkqZKLb7y47h2QBV30Cg8CF5SiWC7cPuAELcE0=;
        b=gYyo54wnDgcY02DyBCL/K8VbqCDzeiJkUrxfokMAgebcXOUTP8ic6DHQzxHzAzdoOT
         u5hGvdVv+yb8Pxk/jR3Kt7pWQEXl0V2my+g4xilIjjaEaDWrsabh+znyhR+aY84NF0dq
         HmrsjfYLqoNPXtkGrrVqRKpSq1GqgsOOLSkveqsKCp0YbqQVrdoVnC1h7H+bgHhGMTHd
         co45uYmWQtzX32C87/5pc13HrC+6MeoDkv8SE5lfUtr6/vq54SUNf4iZh9cxQ26D0WLp
         gasWTnS46Z1VwwrE/PsYlJKUoEXddSCW4uPBE9YZk6dItnmx2x67yE5VL+t7GySUn58U
         JVAA==
X-Gm-Message-State: AGi0PuYzamlMd5eqzQO/B12BaCzSj2AXolwJUk1MX3wt1rmnOStaN7ok
        voFP1hNZfKvd7uivvEe2bMs=
X-Google-Smtp-Source: APiQypLO0aRIuz+zgTRv7w4cBk8IwnBuB8JeO+edeOvmFEHyU5aHRBfNcBgiCNZ4D87S2qOgXE4Gdg==
X-Received: by 2002:a7b:c181:: with SMTP id y1mr11303273wmi.83.1587741074999;
        Fri, 24 Apr 2020 08:11:14 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id a125sm3215289wme.3.2020.04.24.08.11.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 08:11:14 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] include: dt-bindings: rockchip: mark RK_GPIO defines as deprecated
Date:   Fri, 24 Apr 2020 17:11:05 +0200
Message-Id: <20200424151105.18736-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The defines RK_GPIO0, RK_GPIO1, RK_GPIO2, RK_GPIO3,
RK_GPIO4 and RK_GPIO6 are no longer used. Mark them as
"deprecated" to prevent that someone start using them again.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 include/dt-bindings/pinctrl/rockchip.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/dt-bindings/pinctrl/rockchip.h b/include/dt-bindings/pinctrl/rockchip.h
index 6d6bac1c2..e379ec110 100644
--- a/include/dt-bindings/pinctrl/rockchip.h
+++ b/include/dt-bindings/pinctrl/rockchip.h
@@ -9,12 +9,12 @@
 #ifndef __DT_BINDINGS_ROCKCHIP_PINCTRL_H__
 #define __DT_BINDINGS_ROCKCHIP_PINCTRL_H__
 
-#define RK_GPIO0	0
-#define RK_GPIO1	1
-#define RK_GPIO2	2
-#define RK_GPIO3	3
-#define RK_GPIO4	4
-#define RK_GPIO6	6
+#define RK_GPIO0	0 /* deprecated */
+#define RK_GPIO1	1 /* deprecated */
+#define RK_GPIO2	2 /* deprecated */
+#define RK_GPIO3	3 /* deprecated */
+#define RK_GPIO4	4 /* deprecated */
+#define RK_GPIO6	6 /* deprecated */
 
 #define RK_PA0		0
 #define RK_PA1		1
-- 
2.11.0

