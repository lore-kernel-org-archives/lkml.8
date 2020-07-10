Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11C9C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81AA5206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="Cm0Pk0tM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgGJJqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727919AbgGJJqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:46:04 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877C9C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:46:04 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id 72so2048471ple.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jc4j0zmTeuKM0lc2BizwkCFwAO5j79CRqfTY47zNpAM=;
        b=Cm0Pk0tMv9wqV2IrM93XQT/9PDI10+I7Y+/NvLF94mFJkFB9Eoo5lpmXy1DO2CCxtB
         tjlnkUHOEdT30VbCxE9H4r11bSJdnsIuGU+vPkqsvC9A8/KFw0ZaDYxA7g9iAMBF7dlu
         9r5NYRVAW87sf6laWvIHbD+bsSxqDxEUIDXwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jc4j0zmTeuKM0lc2BizwkCFwAO5j79CRqfTY47zNpAM=;
        b=QZrk3j4bSlPME4MUxmug8CAZyjvFbH+FVszJsu8bY/jB60sP7o6qkqrLH68RopQ7uE
         9eYNvXIqH4Q7693RGdxRwPZ2KS4zBCvvk5aF15+becKck5HQXx9LMJDzgjoq6u4+CAI8
         KkDHJxWJLLq8cHOh5rqIahNPlvDKSvHkBYEDTpX/iKiHuDJYkuGHsUstcFeOerprM9p+
         FDPyqxxp0dcCz+6rxlchIo9YRVcvlUJDaOXnQmjjGcIWMekoBfBz+yUTfeX5fUOJ5Oc0
         cSX3OYmupUjww5LvqnQcymayxg5ZneShb1VcOW8PnlNDlMi+UTXj3WYr6T+tJ13BHO/J
         K6Eg==
X-Gm-Message-State: AOAM532D9z7YlhsxnCRBz1pIBQlefNrLrk49dwVh2rFuAsIkkO09g/lb
        ylkXAWm4tdoZDBMyFZoeXbhGlQ==
X-Google-Smtp-Source: ABdhPJwgMJyQdZFFazYHTx86QU+TKCAIqoWpfY67XYRmUas73Svg3wmHcIJWkqMSCed7gMobcQX/FA==
X-Received: by 2002:a17:902:9a0a:: with SMTP id v10mr2487615plp.134.1594374364062;
        Fri, 10 Jul 2020 02:46:04 -0700 (PDT)
Received: from shiro.work ([2400:4162:2428:2f01:7285:c2ff:fe8e:66d7])
        by smtp.googlemail.com with ESMTPSA id z9sm5133213pgh.94.2020.07.10.02.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 02:46:03 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux@armlinux.org.uk, arnd@arndb.de,
        afaerber@suse.de, maz@kernel.org, w@1wt.eu,
        Daniel Palmer <daniel@0x0f.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v5 01/12] dt-bindings: vendor-prefixes: Add mstar vendor prefix
Date:   Fri, 10 Jul 2020 18:45:33 +0900
Message-Id: <20200710094544.430258-2-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710094544.430258-1-daniel@0x0f.com>
References: <20200710094544.430258-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add prefix for MStar Semiconductor, Inc.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9aeab66be85f..b09b6c9911c3 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -680,6 +680,8 @@ patternProperties:
     description: Microsemi Corporation
   "^msi,.*":
     description: Micro-Star International Co. Ltd.
+  "^mstar,.*":
+    description: MStar Semiconductor, Inc. (acquired by MediaTek Inc.)
   "^mti,.*":
     description: Imagination Technologies Ltd. (formerly MIPS Technologies Inc.)
   "^multi-inno,.*":
-- 
2.27.0

