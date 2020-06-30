Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EBAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 12:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8631E2073E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 12:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlg+lxzE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387402AbgF3MSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 08:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732509AbgF3MSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 08:18:17 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531FEC061755;
        Tue, 30 Jun 2020 05:18:17 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id u12so15315764qth.12;
        Tue, 30 Jun 2020 05:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vOMMQVIga0beBT3w7vXuKPKMQNuuOqyf8on6+kC9jVU=;
        b=nlg+lxzE0jp5jmPKZfHKLR3+9sM6BtieN520qJBBFjy4xLQBqYJwAayqpptHcFFOh6
         VajWH/M5J9BeACaUfzglsvSrAgiID/iFlood3g+kRCRnd6XbXdajaZD9dAFDoYOt+Hqu
         bbtNY7FZHyTT+uSIqytmr2EuFsQzkhVp8IvNwbJfzCPgc0+0JB9xcifsO1jWNvLIo2ye
         rnRpXfTW0cOP0l7fxbLCTGj35zu1P4rSAf8dcee2oscshEslcMhAF1hQFb/a1DIpXSd0
         ewgPnZgMkPJEGG7qLssMNhQjsWhODU9NZDA+8tPRk68IWGWcTruw8A1yKG53PK5Wrbbb
         AqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vOMMQVIga0beBT3w7vXuKPKMQNuuOqyf8on6+kC9jVU=;
        b=YEhdj6BgqRp8mn2Xj3AZV3HepLYUkjuaz88unmXlIby+kEpMoZVKrguzLLvW+jxU84
         PCo0lJ5cknz+jZPIMCLZU1TwtX3otvpDuxkyLRNXmZLaXW8qV1hIy9ruo8qoxU9SBNgg
         OZviR8EGD0WS8D5odwojaE3tCMLk0Jw5zqo+JjprAdeDWOhaOXs35EP8uadSh4cPfHFg
         b9KeXGn+RzSEN9zUyZoCvLYBpCkN3KC+1Hn6nqs1iaS6BO0DuPhrBeynaO0LK8Fm29df
         Xoqnw/Pty4ZCck8DAFVhaxDnFB+Z0Y9rwcZILk9Xt+SmRWyamewNQJ2ZdO9Kf+keXHhP
         ERpA==
X-Gm-Message-State: AOAM533Zw0MItcU5I6r4T9ZrVTJjvZE3tB4T6qhucxl8UhPWohI99gi/
        hHMCnHeFgxx1Oh1JqixTYvjNmp0+QeQ=
X-Google-Smtp-Source: ABdhPJxkZfDQqtr0npeZl1dS+FUq7vXS0nVwrVCawTiGkteXTN50Z1H97zhn/mmvohszMxIyd+rQFw==
X-Received: by 2002:ac8:2af0:: with SMTP id c45mr20371651qta.296.1593519496475;
        Tue, 30 Jun 2020 05:18:16 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:482:92b:d42f:2bc1:abe3:59f0])
        by smtp.gmail.com with ESMTPSA id r2sm2738129qtn.27.2020.06.30.05.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 05:18:15 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     robh+dt@kernel.org
Cc:     amit.kucheria@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] dt-bindings: thermal: Remove soc unit address
Date:   Tue, 30 Jun 2020 09:18:04 -0300
Message-Id: <20200630121804.27887-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the soc unit address to fix the following warning seen with
'make dt_binding_check':

Documentation/devicetree/bindings/thermal/thermal-sensor.example.dts:22.20-49.11: Warning (unit_address_vs_reg): /example-0/soc@0: node has a unit name, but no reg or ranges property

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 Documentation/devicetree/bindings/thermal/thermal-sensor.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal-sensor.yaml b/Documentation/devicetree/bindings/thermal/thermal-sensor.yaml
index fcd25a0af38c..727d04550324 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-sensor.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-sensor.yaml
@@ -41,7 +41,7 @@ examples:
     #include <dt-bindings/interrupt-controller/arm-gic.h>
 
     // Example 1: SDM845 TSENS
-    soc: soc@0 {
+    soc: soc {
             #address-cells = <2>;
             #size-cells = <2>;
 
-- 
2.17.1

