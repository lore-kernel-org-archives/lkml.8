Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC87C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 13:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4499E20776
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 13:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxqzIR9p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgH1Nx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 09:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbgH1Nx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 09:53:28 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E686C061264;
        Fri, 28 Aug 2020 06:53:27 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id u1so1240450edi.4;
        Fri, 28 Aug 2020 06:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6hOhQywhtdYAYf6KxF2HvmwzvdNqA6AlX+SQehvf5Q0=;
        b=HxqzIR9pDGvhHhJv94isTiRVykdzw2OE6/khNjjVxJcoZBdTimJGmUeu3Gba0ytewX
         vBwp2xZlC3Yj+GJxMxRY3WcleWVOOHSozb08duMmKwaXuslJgle/krKLagHFDu0wq5am
         +58DxTYRfbWgA1MAerr/FIOjzpcYyy2Fh62zaALsTPdtbiC2xah2bWl1VwhlQai/YZpI
         x8TXjFVrXddBxuUFPbhK5SuZzwglRaxWibFdTbREr1KLikb6Xombofc/ebYPu2b/Ma75
         d4HRsEC7eHPtxo5V6Wa9YMx/P5/QsoHsmxOvx+rRxiZzKrsHmTjjXy7i2BHCtv/bHy4T
         knKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6hOhQywhtdYAYf6KxF2HvmwzvdNqA6AlX+SQehvf5Q0=;
        b=ZyoOB1RUtmIk6vkqDH10+1OSwcm4VETgvxSIyvspzym6YdwjD5Ftn7/7Jg02KzUvzA
         GgEzl2/bkcO/MpCkEiFPymUYve1ukoJzJzC22f75+vvQnxakjTCktQH5Ps51dJp3OlVK
         mxRcFMqtH3pbkd+sTmb63PyBkGrx2JxbBrM5fr+60KFFShK365zxDCObrCSO/ijJXLZO
         dRgcTtcVrikp/Lk/d5lXrhLM2bWXMt5oBCnIFzhquGJdzscjVLR9cHvA6PJnpfx2y+I0
         uWYI83cgjsbRhdXXduMJR0i0eP5w/Xm9x0veO5ZhRlbfahTSA1rUuhRfZSjRHZYv0963
         eJ6A==
X-Gm-Message-State: AOAM530UlNVY0E/AdD1G1GzlB0B6I+bgRgpui/T9r0MtDfGy8Bk4Vezd
        1JH92eZIiy7t+xJsuZ2svAA=
X-Google-Smtp-Source: ABdhPJw3fIzvi1FD70j+N60aQW3ESdtJtnbt/SUTfQRTBG/ee95ea2qjCtTSXUePATDXm5Xd5Jut6A==
X-Received: by 2002:aa7:c5c4:: with SMTP id h4mr2015603eds.131.1598622806428;
        Fri, 28 Aug 2020 06:53:26 -0700 (PDT)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id f20sm981624ejq.60.2020.08.28.06.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 06:53:26 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Korsgaard <peter@korsgaard.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 3/4] dt-bindings: arm: actions: Document RoseapplePi
Date:   Fri, 28 Aug 2020 16:53:19 +0300
Message-Id: <1f2b3ca4ff4f8a48bd0d7dcc013deefefb1de498.1598621459.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1598621459.git.cristian.ciocaltea@gmail.com>
References: <cover.1598621459.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define compatible strings for RoseapplePi, a SBC manufactured
in Taiwan, based on Actions Semi S500 reference design.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/actions.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/actions.yaml b/Documentation/devicetree/bindings/arm/actions.yaml
index ace3fdaa8396..787cd1b4f26c 100644
--- a/Documentation/devicetree/bindings/arm/actions.yaml
+++ b/Documentation/devicetree/bindings/arm/actions.yaml
@@ -18,6 +18,7 @@ properties:
           - enum:
               - allo,sparky # Allo.com Sparky
               - cubietech,cubieboard6 # Cubietech CubieBoard6
+              - roseapplepi,roseapplepi # RoseapplePi.org RoseapplePi
           - const: actions,s500
       - items:
           - enum:
-- 
2.28.0

