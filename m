Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6861C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 10:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2E0420724
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 10:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSiI4/V+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgGRKyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 06:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgGRKxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 06:53:54 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7450DC0619D3;
        Sat, 18 Jul 2020 03:53:54 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id n2so9592005edr.5;
        Sat, 18 Jul 2020 03:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XD9e+8Q0hWnIFihcstxk52mTTLmu1xMC8V0Bf3F4SYA=;
        b=gSiI4/V+MrizALAzfQK7TGg+rcIPlOddT9E0oBL3Fg0dXRvVNPcbkN9GFgM4nFydVX
         AiWU6dtJmOQApYRzNeKBv4HBA2uJIH6cm2WrThIjf8qUml17aL5Wm/JoHZBumO1fVCxh
         rnoiFdPmWfvvgmEUfwzMfcoR4sk+j5/vSIurYAgBPm1F/ovD+e9PqjU2kT2I9erg/ryB
         HpAXYVXWz+2YP9HFuFQuTnT5dcbv5egMdDSdXUHZjPPzEUB5+7Qm2mIy7CJt+dOPziIO
         PkHw/hAAH0qpjcPC5zvIof7YbXSvACjApWlkjxdkOl3TFuMocZU//GL3G9S7Udp7LjNx
         P3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XD9e+8Q0hWnIFihcstxk52mTTLmu1xMC8V0Bf3F4SYA=;
        b=lCC1JeOrX3wuqj+LaKgK/1thyC03W6p01tp+DU55gB344gFxDepLfYAbpUL8Y03vYw
         u35JI6snoP0VqqsWFQnJuE+FUw4yGPX6BPsuCxWcPJyUKl1hHfgXuFE016QUYPVvL5F8
         TvN2+sDpoH0Hw0wRqJiOF0ZYwbPpoTNXfh3TGLDAdvcxVgZoxfFDpyaWyBn1xjH4csYk
         Z5E5f7A6sFRjbAfuDILd+s2nJBPjtldCFnMUaxtBF3w5paaC320CYBH3zdAukPcafnbX
         IBh7Pfr3sLrCdEWCRHzEXYXkV+d4BNrLNnT1wCBSl0evBpxk0j5FiuBESNBnThcIZw83
         9O8Q==
X-Gm-Message-State: AOAM5333uA9iOb5fJldXXOs80Q+fpLb7hMB+nWnGXwihgMZIKZgyxWxb
        KZa4yGTOVq2WSzz7lBBYm0g=
X-Google-Smtp-Source: ABdhPJwFv/R5dcGr3SE8hzLuP+5IjOPz4UQwf8bmngfnc8CKYWMEpVZlhmJkBoGG6x/5jK7JyQ4NKg==
X-Received: by 2002:aa7:cd50:: with SMTP id v16mr12952045edw.252.1595069633195;
        Sat, 18 Jul 2020 03:53:53 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id r19sm10776381edp.79.2020.07.18.03.53.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Jul 2020 03:53:52 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: arm: rockchip: add Zkmagic A95X Z2 description
Date:   Sat, 18 Jul 2020 12:53:42 +0200
Message-Id: <20200718105343.5152-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200718105343.5152-1-jbx6244@gmail.com>
References: <20200718105343.5152-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Zkmagic A95X Z2 description for a board with rk3318 processor.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index d4a404509..441fe82d2 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -549,4 +549,9 @@ properties:
         items:
           - const: tronsmart,orion-r68-meta
           - const: rockchip,rk3368
+
+      - description: Zkmagic A95X Z2
+        items:
+          - const: zkmagic,a95x-z2
+          - const: rockchip,rk3318
 ...
-- 
2.11.0

