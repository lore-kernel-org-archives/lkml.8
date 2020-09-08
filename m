Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC58EC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A241A20C09
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="yj9Ik1nd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbgIHHzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 03:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729447AbgIHHya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 03:54:30 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6435C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 00:54:29 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id z9so16161509wmk.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 00:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AaJv1mu5ukB/CIcMyJjiUkroua19/SVkAvuVAHfagew=;
        b=yj9Ik1ndq3jW04GwKrFOI8D/lPSZVkGcU3uzyMVspnynRbQKdFBJN4BFNiIapGRwnR
         vZYjfZ0jXsdmJWS2xNWLvFAWOvA/GkMFUOAaaTEjv4YuNA7igfTuaSL5w/Sx2MUcPs1w
         9pykHkjdFNrAQGds+Fr60lNduf7ESa5KsiloGG7zLHXEXWpDE2FP7wi44xCKbV+GuJhI
         Haax/tWmOAxnKiL294A24g/1CrLCj+/h9S9lPochIfNWS6onPfaA+hmH/Ua5nIQz7BG3
         mCQZSq/T9x96bj+Wrq7sDzE8UmwxlOhooZ9aKAii8BJ36d4YcmdyiDE/E869lL1S5Vt7
         txiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AaJv1mu5ukB/CIcMyJjiUkroua19/SVkAvuVAHfagew=;
        b=ZKvcWRtiIiTBi3YBOGnjm0UpQrrm4gcAueNAtRj5qqJ6TgWB25GzUjHO2Y8Hwy0D83
         uisbDYL5/YbgdPUypc7dt2j5EEocEsV0mNiadlcMqjnGSMPIvxk7hPdGGeBWw0Q+zOxv
         rSmGmMxQBreAxrRdNqjvqkt2YPu7uqx+Pq8hiYMIfKcDJp8KF4r3PfM7ami+jGcoXwgY
         n3JcFjdq2mQ39j7Er4jmSO1I42LDozwtutqRYe8HZjp80wxuD4vKOu43bu0iTvUGAdJV
         4iHwczq2w4jAGNrywYspNma5G38aqubkoCX1zjJlKKJpaeUCZsHST05DRmb8E0OJO4Sr
         HmZw==
X-Gm-Message-State: AOAM5301fyFJwxXBAsUbTHEE/oW0WS04+tGy9vW6snMxeGOUFOeJaHTA
        M8zcr20Mf6gWLCOVPCafbq+2pg==
X-Google-Smtp-Source: ABdhPJzELndZXOBjcc+iB86Na+d7gpW0eUl7Xb0Mcmpwvh1mxirZqv7irrBgH24N13Nm09Gk9voTNQ==
X-Received: by 2002:a1c:7215:: with SMTP id n21mr3241141wmc.154.1599551668340;
        Tue, 08 Sep 2020 00:54:28 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id f14sm33788291wrv.72.2020.09.08.00.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 00:54:27 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org,
        devicetree@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v3 1/4] dt-bindings: vendor-prefixes: Add Shanghai Top Display Optolelectronics vendor prefix
Date:   Tue,  8 Sep 2020 09:54:18 +0200
Message-Id: <20200908075421.17344-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200908075421.17344-1-narmstrong@baylibre.com>
References: <20200908075421.17344-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shanghai Top Display Optolelectronics Co., Ltd  is a display manufacturer
from Shanghai.
Web site of the company: http://www.shtdo.com/

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index a1e4356cf522..4e9dfb352c68 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1078,6 +1078,8 @@ patternProperties:
     description: TPK U.S.A. LLC
   "^tplink,.*":
     description: TP-LINK Technologies Co., Ltd.
+  "^tdo,.*":
+    description: Shangai Top Display Optoelectronics Co., Ltd
   "^tpo,.*":
     description: TPO
   "^tq,.*":
-- 
2.22.0

