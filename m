Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E382C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09E5D20B80
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="K9GBZe8g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgFPMSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgFPMRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:17:20 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8ADC08C5C5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:17:19 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id l24so567070pgb.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Ofrbcs6powOIpLHVgUb+s2Y6gSuASwM2PMR2S8GC/8=;
        b=K9GBZe8gNJO/W9HkRUGhLRRenI1uWzOY2VyMcVpQ1qpJoy8XFBU/gN9hplt+ZBwytp
         Vl3FWj2Xe9Qotiq1GXQaR+lcoBmvS22iEhQgk3IrWMNrUgSANF8Ny/DCdDURZNZ9npKx
         4DV78QiAjJ4kj6JhAdhMLmVrC5LAM7JTlQYnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Ofrbcs6powOIpLHVgUb+s2Y6gSuASwM2PMR2S8GC/8=;
        b=TU4I8qNurxJEf8ICxEMfdU81vGq5syivMFebHUu2hG8UmVYHNux7LhhoiFFyL8+QkV
         TJmzqkitUQWbLKFGOm00fRWcY9OT1uO2OmJdcausTCyXdyh486u+eMDKXR07BwdScg2L
         d1Xyw2mMGcmc4DiKCy5qVLuH/+CdAZL3gixgEHmHAxxEf6edcf3xvEw9W5v72ib6kbA9
         +3GT1PhkDcbz1bHvqY9602Wa4dIaWvl5I5gstvlkypsT5BDJLnpErFSoH/N0hbE9hEWN
         THIWZheU9xN35GuTpvVJiDelTaJ6terEv0fsrfV4YWMBOQxOqgb+l7e7IpQpw13ShHiS
         uexA==
X-Gm-Message-State: AOAM533MuxxGAtmDjHfjQaT6L6sDWr+bfh+nN9Vh2Blf314/lYWHa9Gk
        qCBNUDapNhZCRb8zPO6bI1/ZPQ==
X-Google-Smtp-Source: ABdhPJx2/ZThHxd7TkGqkTWZKS35Q9MJ8+CEueo+tZWGJimgB1gnkJ2ft0DeXHEgR4K/xPkFcWleWw==
X-Received: by 2002:a62:7dd1:: with SMTP id y200mr1787559pfc.184.1592309839077;
        Tue, 16 Jun 2020 05:17:19 -0700 (PDT)
Received: from shiro.work (p1285116-ipngn200805sizuokaden.shizuoka.ocn.ne.jp. [114.171.61.116])
        by smtp.googlemail.com with ESMTPSA id f23sm2360703pja.8.2020.06.16.05.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 05:17:18 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v4 04/12] dt-bindings: vendor-prefixes: Add thingy.jp prefix
Date:   Tue, 16 Jun 2020 21:15:17 +0900
Message-Id: <20200616121525.1409790-5-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <20200616121525.1409790-1-daniel@0x0f.com>
References: <20200612130032.3905240-2-daniel@0x0f.com>
 <20200616121525.1409790-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add prefix for thingy.jp

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 53cd050668e6..c209b3dc7ecc 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1038,6 +1038,8 @@ patternProperties:
     description: Three Five Corp
   "^thine,.*":
     description: THine Electronics, Inc.
+  "^thingyjp,.*":
+    description: thingy.jp
   "^ti,.*":
     description: Texas Instruments
   "^tianma,.*":
-- 
2.27.0.rc0

