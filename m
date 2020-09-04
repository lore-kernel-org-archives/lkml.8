Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C543EC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E94425496
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="AY5OpA7E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgIDSI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 14:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgIDSIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 14:08:55 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2176BC061245
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 11:08:54 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id n3so5499790pjq.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 11:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vzdf81iezfmu4wvC29MoXNkCDvJVBLYXkjv5GQ8JBzg=;
        b=AY5OpA7EQVxVAQ2BRX17UsK93kzal14AKuR6K16pVMKsOYoO8PkFnqa4VfSl/adDAt
         XJ1kq1MbD9UwAc8cTVRUKWrp8Hb49mM2XqEEwqy8vpbmhJ6sw8TLcsWbJogpfNM8eFhz
         OaFfs98t3oVzsTtMaiEPwPi48rdYUP/ydXtDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vzdf81iezfmu4wvC29MoXNkCDvJVBLYXkjv5GQ8JBzg=;
        b=XV8Xq+193M6DhZwilRGPHpv6gts4Itt8vMYy2e3lqin+xxGBkqNu2cAlEBWz4lRdLv
         qSlMVpDwiZKUVriKLtCZ/Mb663pNT42YwrLxwNPNEiQybkLNEECsZEt3UVOdYk5h0Uiy
         MMA1OH9PVzpiKbKQuS7eqcwLVXAkMBVS3ML5x72lyfxXYewZdSS8cV6m7x4IQOIUo7z8
         umgKPymHdAhbcFGwjZy1nmoq+en/L1WQsCYNV8tnxZbN93PLT/7z9MlXUiLFLaYogcQu
         B53xOQOz/trUbOpQ2XuWBb2D3U6SDPZkmO0byutnd8V8RZZ+q3ZbxBmezlHG0ljnutmk
         tskg==
X-Gm-Message-State: AOAM533kMk1IAir2hXCxbcE6qKDDisFFpcAAVh6GdXTytNemP55/hpCK
        VS9mb6KpDGaHQN0JY1EZfHsNhw==
X-Google-Smtp-Source: ABdhPJz+WOCZ/I5jjFzcU51vGXw5nkCE8i7D62RQZfF3tj0lru20q/i+6dduujH2uY1P2mruBR1a2Q==
X-Received: by 2002:a17:90a:5a48:: with SMTP id m8mr9275714pji.181.1599242934113;
        Fri, 04 Sep 2020 11:08:54 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:b9ea:24bf:6b2b:1eee])
        by smtp.gmail.com with ESMTPSA id 131sm7448281pfy.5.2020.09.04.11.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 11:08:53 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: Add Yes Optoelectronics
Date:   Fri,  4 Sep 2020 23:38:19 +0530
Message-Id: <20200904180821.302194-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor dt-bindings for Yes Optoelectronics Co.,Ltd.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9aeab66be85f..15a6a8e7260d 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1167,6 +1167,8 @@ patternProperties:
     description: Shenzhen Xunlong Software CO.,Limited
   "^xylon,.*":
     description: Xylon
+  "^yes-optoelectronics,.*":
+    description: Yes Optoelectronics Co.,Ltd.
   "^yna,.*":
     description: YSH & ATIL
   "^yones-toptech,.*":
-- 
2.25.1

