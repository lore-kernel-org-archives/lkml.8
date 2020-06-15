Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F29EC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 00:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49B2720714
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 00:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHpYiO0p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgFOATa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 20:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbgFOATR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 20:19:17 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67657C08C5C2;
        Sun, 14 Jun 2020 17:19:17 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id gl26so15498545ejb.11;
        Sun, 14 Jun 2020 17:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=79mtyeZRq2M0mbofzOHg0zNB78sTVjll89dsFzzw1/A=;
        b=NHpYiO0pJV/aIO/FAwrExUQ0w2HuXfi6XgL9WspR+elldDdqxgXm2xWfHM8w6/vb6Q
         7FJu91sbuk7hjeb0I3TzkkOJz+KUJ0GDpJvVngCm/D3UNV2DaKq6d+vAV6XSU0r5NmgM
         7hYbFtX57qXclSH2Qs3KF/6BtS/RQ687VLqZ8yOnMpJ67YMPN78A/bXYzYOlaJ5SL5cP
         KVsp5uyUC6wPgFf9kCAVQOHfZWq+lJXpfnd5yxUuTe/ULJKpvdVf446HbXeWYpQRRKMZ
         aaxrjXBbjF58XPeweVCjESM6LDz8rKExO24nwH9H6uHP7PhyiS8gz1jjg9z2RPz9Bghx
         goMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=79mtyeZRq2M0mbofzOHg0zNB78sTVjll89dsFzzw1/A=;
        b=Pn/C5h4dgNMGMX6EWR0fEpILSyEY/AYFOByfGK0xVcY3RknOG9k1XS2LsiAAx+CKLD
         eFudfZtBlF25QO+SBClmzw246eFIZvkNnmmh0iWtGBINXTSahYGpR18T27mddoPxyPV9
         dZnxYEi3KckbtJf1JmH5UmRCw1HE20FslezaeUlULFn6jMLuwYktj7GAy3jpH9Lb0b6s
         m8odTbyIQ97uwzXTu92qL7Umb0emU+3T5UPIVo2EMZ0x9W2r5cGgl14+KFMTLVm37VHJ
         m0tmrUO30+/huscrLU6WF+lnrUhj/k17BI6KzovcZmn7HUABvvbxId0JKKLFz6gUEKo9
         zmWw==
X-Gm-Message-State: AOAM53016Wl2w8+zST2M4qjQQx4ljAzlDK7cb3+T8tRgNapdLtpn0Bk2
        7PBsM/0rmyBcpP4ebyuyAUg=
X-Google-Smtp-Source: ABdhPJyWxRtGqOVWJHbPHm8CKtWRtRgzWemc3OYy+Bd9RL/zDPoXbrCJYveSipGIWh3fX1pGc90CQw==
X-Received: by 2002:a17:906:5283:: with SMTP id c3mr21898256ejm.22.1592180356065;
        Sun, 14 Jun 2020 17:19:16 -0700 (PDT)
Received: from localhost.localdomain ([188.24.129.96])
        by smtp.gmail.com with ESMTPSA id m30sm7450666eda.16.2020.06.14.17.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 17:19:15 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] dt-bindings: arm: actions: Document RoseapplePi
Date:   Mon, 15 Jun 2020 03:19:10 +0300
Message-Id: <40f7d54f9502f0d33f2dcf18b02c6de0d55d2ecb.1592123160.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1592123160.git.cristian.ciocaltea@gmail.com>
References: <cover.1592123160.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define compatible strings for RoseapplePi, a SBC manufactured
in Taiwan, based on Actions Semi S500 reference design.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
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
2.27.0

