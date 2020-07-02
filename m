Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A84EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA65420723
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5m2sPJX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgGBLc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 07:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbgGBLc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 07:32:57 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAA7C08C5C1;
        Thu,  2 Jul 2020 04:32:57 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c139so25189555qkg.12;
        Thu, 02 Jul 2020 04:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=W7AlP+eA8SjThL4Tu3H/MzC59XsrBZF7Nd7uQUhGMq0=;
        b=B5m2sPJXRFNRj9m1IAKGW5w88Xrt7xaddltd52qWHzI5K9RVpgwDQcq0uW3iOPNxV9
         68fuOzxpGqJbJFQPBb6T3uKAO60HPGGyivA1Yr/Amz8faVf8CaVYuvBhdZohEeD2w/JC
         sQbuQZAgJH1HpjN0UN8v9dD0MXF9oxHWk/8963iXHv4HQxIdmTKsr3tpHgFmLxlnlkxv
         5frLFoN1UDxfzPho3vDw1sHH1dNQXyMnCT5Tst5A+o17ukJnXi6xaGi5Kdv8J8Z1doi4
         Jie9QNhvMIBNq2WO0GKz9Gv/gIdDrPhhdAn7MYyFNEyI+PqlO89TmKxaQwi20zmQ7ckU
         6UFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=W7AlP+eA8SjThL4Tu3H/MzC59XsrBZF7Nd7uQUhGMq0=;
        b=q731vh6XwQQCjHwoisuSf60217V72xfZmndu53E6YDZZTOqo0oH1gaFosJi/wRU6lI
         idnge/cQAg6G0tU0JpY38JJGlgjxk10fwO2z5LGGmxLLOPnF0YYSWlXTvwOtkF01x7G7
         EFWNzZLVdqZP8dsAASgbD1knx+rB3kiWe8uuA9QpNhIdz7HaRY0y5gt92xotOeTJFmj7
         2kvE0GGLxe2M0ZwU3pw4wsfAQsANxJTxILdppCVXVlRkcAJtAEjhVTZlRsp4I1A7/AD8
         aIUk3e01I0daWIgU7f7wKoETV4CplJB7h8cw8nqrwbv+yGEAIfHpdO2QJk/bvnYpjOQ4
         QDog==
X-Gm-Message-State: AOAM533A1bFaJdD7u6DJpVZaLwrYk3xvHfHO/hhMyxuEOtc1w8pTIUID
        ZnZccW6j874Dna0x6HQdi/4=
X-Google-Smtp-Source: ABdhPJy0sUFttBRLwHCZQKChFUsgAn03L+qTOY8yXkoD8TvR5+IG6+8puGT/7qDXB+9CEKPcFqhR0A==
X-Received: by 2002:a37:a056:: with SMTP id j83mr20924410qke.248.1593689576918;
        Thu, 02 Jul 2020 04:32:56 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:482:92b:d42f:2bc1:abe3:59f0])
        by smtp.gmail.com with ESMTPSA id f22sm10474830qko.89.2020.07.02.04.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 04:32:56 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     lee.jones@linaro.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benjamin.gaignard@st.com,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] dt-bindings: mfd: st,stmfx: Remove I2C unit name
Date:   Thu,  2 Jul 2020 08:32:33 -0300
Message-Id: <20200702113233.5327-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the I2C unit name to fix the following build warning with
'make dt_binding_check':

Warning (unit_address_vs_reg): /example-0/i2c@0: node has a unit name, but no reg or ranges property

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 Documentation/devicetree/bindings/mfd/st,stmfx.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/st,stmfx.yaml b/Documentation/devicetree/bindings/mfd/st,stmfx.yaml
index bed22d4abffb..888ab4b5df45 100644
--- a/Documentation/devicetree/bindings/mfd/st,stmfx.yaml
+++ b/Documentation/devicetree/bindings/mfd/st,stmfx.yaml
@@ -93,7 +93,7 @@ required:
 examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
-    i2c@0 {
+    i2c {
       #address-cells = <1>;
       #size-cells = <0>;
       stmfx@42 {
-- 
2.17.1

