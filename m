Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13431C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADC31254A1
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="XEjxaSkJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgIDSJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 14:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgIDSI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 14:08:58 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DA7C061245
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 11:08:58 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id o20so5021222pfp.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 11:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VR8GNVs/4QhnhespfyktUk1pNIw2OaOAjoA98mpiYlI=;
        b=XEjxaSkJBRR+Nw65OrveDE7+DhOIyYNNraHHcuxii2UG8l+JWdFCrP2biFNSD8SJLt
         iPpvc/c18znjeUqOgilXudlTLABnQxCGUa233Zz7pHeEFnFh/Ygh4hEFUPEM3OK82AlB
         GtyNiZFiOZX6nfJJ0FnGEnxtA1aACnAzqAeUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VR8GNVs/4QhnhespfyktUk1pNIw2OaOAjoA98mpiYlI=;
        b=qZ/p6L/cd/Xot2JioBrfPSCcEv7TTlmAa7nF5n7+TO5jTvCJtVbibC4Om4DbGjz0el
         7YN0L2nmKVOBwUaMfV887CuwwV3sOf9xKEO+AB0B/5F6OJfPMfhofDilUeHn51ajlvAC
         N+fSPz0ycORqqylHNo3l7UIVvG6b1XjNwJxYoKL+05HDS7hX2kj4VcwknByyFlkUydPI
         qa3iyBlr+qC7viSWczwAdoUq1gkTvUrE5BuU5Yhr+ms8f7VJWsb2ywIV+e1GH5Z0UQ3L
         xr11e5Dhl4IwHD6tuMlQ+I9+m0xFs7V7wKtHmnFTNBhDK0diGUuMMOscGvz1Jt3yEQ0K
         L+Zg==
X-Gm-Message-State: AOAM532ms1wraYjR1dvUh7QFvRPY109ioQkWyw0suo6+0pU8/QNZqTRw
        yTBonF4Mjqir/4pY6VfkEdXxNw==
X-Google-Smtp-Source: ABdhPJxCodZ5I7hCe8TfVPMYqQ+obWSOHN+ol2zsrB4TMir8vNQYBz2HIJbl5PnGjUbOhMTC7eVnSQ==
X-Received: by 2002:a63:5c1a:: with SMTP id q26mr8341714pgb.223.1599242937733;
        Fri, 04 Sep 2020 11:08:57 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:b9ea:24bf:6b2b:1eee])
        by smtp.gmail.com with ESMTPSA id 131sm7448281pfy.5.2020.09.04.11.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 11:08:57 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 2/3] dt-bindings: display: simple: Add YTC700TLAG-05-201C
Date:   Fri,  4 Sep 2020 23:38:20 +0530
Message-Id: <20200904180821.302194-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200904180821.302194-1-jagan@amarulasolutions.com>
References: <20200904180821.302194-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings for YTC700TLAG-05-201C 7" TFT LCD panel from
Yes Optoelectronics Co.,Ltd.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index f629d04f7737..3e12b32897e0 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -268,6 +268,8 @@ properties:
       - vxt,vl050-8048nt-c01
         # Winstar Display Corporation 3.5" QVGA (320x240) TFT LCD panel
       - winstar,wf35ltiacd
+        # Yes Optoelectronics YTC700TLAG-05-201C 7" TFT LCD panel
+      - yes-optoelectronics,ytc700tlag-05-201c
 
   backlight: true
   enable-gpios: true
-- 
2.25.1

