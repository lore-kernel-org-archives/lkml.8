Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABCBC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 16:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1592C207DA
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 16:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="X6vCf1x8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgH2QBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 12:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728424AbgH2P67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 11:58:59 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2670DC061239
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 08:58:54 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u128so2214853pfb.6
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 08:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+xa1iz4+LbQK9GmC+3dpDj+oguycEKNLcSKsGXCFjpc=;
        b=X6vCf1x8M2sLlMLv5j4Nw2WZpqtS6NLqqEpWr0kzmpxjmUtwRKj3wA3K4r85jDTB5p
         CibTR1D4ZZyjRnSvdLRkim8iBLS61m7i1vKcZ8G8rwxlnNzGHHgSc17CJF/5a4ghETxR
         2orkEIPkUBLIoy70O5Eeym9SiOQIOc2F4swyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+xa1iz4+LbQK9GmC+3dpDj+oguycEKNLcSKsGXCFjpc=;
        b=o8lgFqIgh31+GhXGH2Dqu/B8dGVao6mMK9tQzq8xbeElODn6X8lpiaEnTiDU04+I6U
         ujFZdoJx/Ip9IUmcNglVQzcpn2hcjaa543880XBPdr94TQxSnSQ80RtCqsXQfAjFcFk5
         hnrRb4WAGo7amGly0eOydolDFoUZKFsuIjW5Hh58kmkJ5Qa9rlGypVj8lLJa+qNwRnt+
         gNRT+ElG4/JYxjfgS3SxgfGyO4K0K4USBVmtjb/396C9j4HZRJCdKEnm1VXrNEGKqVC8
         FyOIa6p/dkC5KcRhz6+6XbrTIvkr87JSk/QzXCCtt4HFpegEk0VzxBCZXsrWWnsU3urM
         QgLw==
X-Gm-Message-State: AOAM532X6+CKJA7tCRKSR0vDY84K5/QpO4oQysMYZsRjp3NnM08gKunD
        t5FcAvVCL5OaRQ4/qOyDENVMnQ==
X-Google-Smtp-Source: ABdhPJwKDtSAllMNHqmAEl7wwHQpzu67T/H1QT6DJfBY5vrvsEEWj7ICtu7JnbAf/AO14geaUmeYHQ==
X-Received: by 2002:a63:d409:: with SMTP id a9mr594039pgh.312.1598716733710;
        Sat, 29 Aug 2020 08:58:53 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:9460:cfb8:90a:fedd])
        by smtp.gmail.com with ESMTPSA id j20sm3131714pfi.122.2020.08.29.08.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 08:58:53 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 5/7] dt-bindings: arm: rockchip: Add Engicam PX30.Core C.TOUCH 2.0
Date:   Sat, 29 Aug 2020 21:28:21 +0530
Message-Id: <20200829155823.247360-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200829155823.247360-1-jagan@amarulasolutions.com>
References: <20200829155823.247360-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PX30.Core is an EDIMM SOM based on Rockchip PX30 from Engicam.

C.TOUCH 2.0 is a general purpose carrier board with capacitive
touch interface support.

PX30.Core needs to mount on top of this Carrier board for creating
complete PX30.Core C.TOUCH 2.0 board.

Add bindings for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- new patch

 Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index bda0f2781890..3aecb1241492 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -70,6 +70,12 @@ properties:
           - const: elgin,rv1108-r1
           - const: rockchip,rv1108
 
+      - description: Engicam PX30.Core C.TOUCH 2.0
+        items:
+          - const: engicam,px30-core-ctouch2
+          - const: engicam,px30-px30-core
+          - const: rockchip,px30
+
       - description: Engicam PX30.Core EDIMM2.2 Starter Kit
         items:
           - const: engicam,px30-core-edimm2.2
-- 
2.25.1

