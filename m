Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E08CC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 15:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 592662067B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 15:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hz3MolTL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgFGPoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 11:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgFGPnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 11:43:50 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574FEC08C5C6;
        Sun,  7 Jun 2020 08:43:49 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a25so17420457ljp.3;
        Sun, 07 Jun 2020 08:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1qLiLZq7FNwrmfOWv+rYatcR7Rmj1NqpWdK2xLqqCWw=;
        b=hz3MolTLrDjN4nQ6tQkoa073cSZ9SfasctdcPnEYU74oHSXT3P9X6dsv/fp4bOxoZL
         +eS/X9T5gb/BiZ4K2Mba28IBsXE7+8kHl4mziqntLPzexQZ/IUeLnMh9MPyQc+dhFu11
         /VFuX8xsljyFdxieBQHXpzHzhxeMc+NCGpXh6+z/zM1b6zO8NoPDkOZA5sRb49ACX6Bt
         Qx56oWojR1TiV7rHcfYltXh4QIe1JX6zRzndmi+hbLtYCjo1cv0QalQtF5YcDqI4V8AL
         /s3h3M+ZHBaEfENGtrcE7pCMifqHcxllV54bXpb30RLLYmAxDNwfWNKM/PjPloCASDIn
         m4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1qLiLZq7FNwrmfOWv+rYatcR7Rmj1NqpWdK2xLqqCWw=;
        b=XkPWUIqg10VPiDrWEnHQAchOEdH9MYt3tUrRQF2wuOx/Kf7ZpM00xEx4zsUOyD26Ej
         +9qDh3DQSFhWzhGYhZ0fIoRu/8FskB2ZqM+D2IwdfIaBkFr27A+ObjPzyEdLs7BoIV6b
         4xiq647RiNRepST7xiQZ9PdWcog1mSTV1is5l+3z7Tt4re9cTK19nqT2dFkMsCOO7Jzf
         75KS3zDO7tZTfL9MPZP2WQtXYOtii2ffS7aEyIHqdEWBum6OlolZxHkuM1NJFp0j0m9n
         e5qZxUrdTDrZ0yoErtXD+JKDFuP+7BHFBvTDXassMPTIa94jvEbV0gJ0/lyMJ/WWEL8U
         KIWg==
X-Gm-Message-State: AOAM532qOT+BOLHmfE6JXNml03gVPEwwu2QRsYo0J6azjbMbTb1Tyg9f
        rGcoaLc+TkHiWxXtqe8KbwY=
X-Google-Smtp-Source: ABdhPJxKVkUjB7oKcZp10OBLSdSrsHwBPxSYNBXeLyQC50T9z7+JmwY306OMlylArKawuiccVaXkRw==
X-Received: by 2002:a05:651c:112b:: with SMTP id e11mr9267509ljo.134.1591544627872;
        Sun, 07 Jun 2020 08:43:47 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id a7sm3592234lfm.4.2020.06.07.08.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 08:43:47 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        =?UTF-8?q?Pedro=20=C3=82ngelo?= <pangelo@void.io>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Zack Pearsall <zpearsall@yahoo.com>
Cc:     linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 4/6] dt-bindings: ARM: tegra: Add Acer Iconia Tab A500
Date:   Sun,  7 Jun 2020 18:43:25 +0300
Message-Id: <20200607154327.18589-5-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200607154327.18589-1-digetx@gmail.com>
References: <20200607154327.18589-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding for the Tegra20-based Acer Iconia Tab A500 tablet device.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 Documentation/devicetree/bindings/arm/tegra.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/tegra.yaml b/Documentation/devicetree/bindings/arm/tegra.yaml
index 60b38eb5c61a..7fd0b66c69b2 100644
--- a/Documentation/devicetree/bindings/arm/tegra.yaml
+++ b/Documentation/devicetree/bindings/arm/tegra.yaml
@@ -34,6 +34,9 @@ properties:
               - toradex,colibri_t20-iris
           - const: toradex,colibri_t20
           - const: nvidia,tegra20
+      - items:
+          - const: acer,picasso
+          - const: nvidia,tegra20
       - items:
           - enum:
               - nvidia,beaver
-- 
2.26.0

