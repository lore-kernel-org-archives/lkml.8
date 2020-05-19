Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3406CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ABAE2075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pea7GJeW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgESSXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 14:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgESSXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 14:23:48 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E7BC08C5C0;
        Tue, 19 May 2020 11:23:48 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id u22so221564plq.12;
        Tue, 19 May 2020 11:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wSo9ZWps0QavXFno9IQcZKPqnZAGp1Wm8sA63wsuA8k=;
        b=Pea7GJeWkrC+6aUhH0lcKM3rmTYVbjQuee4ewsJWaENhpOel856SdWQdS4/6wX0f6c
         i5VSliI+4fLITf0UxCEJRiOKN+95ljBtJWULznZ+9wgNWnwzGzMKsaW4e0jvsB7Yp8XD
         zgl6rTts2ShFM/J1t/4vKaYBKh7XkHYuGSADzeTMzoeVUkvJBPzdoOxQtOO8x1ZeQA5H
         RsehQaWf6W5M93ZTVrWm6qZcVo2KP+Ihp/DE+fzjiy4+VTeSRHkJi49pbKhbKE+KW1lV
         HjDIwcJ3cArfnyAX8rDiFHvHrG4+UT//D/+XxUYnvQKm0DwIL/6UQe7WRPqsTv0QVy6u
         tDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wSo9ZWps0QavXFno9IQcZKPqnZAGp1Wm8sA63wsuA8k=;
        b=JthvhYmVl5FhvU7OndQmDCx8TqTs5yizpL7H8qQ8+eVLVxBlh4Sdyk8Or0L9qE4y0R
         YmZg0UmlhZCS+rqEQiDgmxsnjDkCjCJ7tQDnFLh1xINi+3SAKRxuGHDbvLJYHue40RfD
         R3FRkYNKyrSW3XHfsXNukd4Mx4MnnY812UANMzS4yf5hllu0gJ3VfHqfD6kkz7BlaSJG
         4vyac0su0nYav5aNKhd6S4tpwX06eJRqOlOnIuijpiHmiXLMP8m8sKv2sz9c5Z5qOCCL
         +LjjLS4+XX9ap3iw9mV44lYGTnkNLLeeZVIKA955XQRvxICkNxhPMFzpDbazr/k826cW
         bViQ==
X-Gm-Message-State: AOAM533QHL0TRDkKuytzSOjoNblwKJRynSVODf5Vb4QQkWqPJhKGdDg+
        UQHoJeX2uk38cjV6QCDuxZE=
X-Google-Smtp-Source: ABdhPJyMHMiXwlwWs/rkZn6KSMkxndpITLpn/MTzrFfd5CGzHkXrMI3Lu8NEOcDBdhZcqfrgGYfx9Q==
X-Received: by 2002:a17:902:bf43:: with SMTP id u3mr739065pls.240.1589912628279;
        Tue, 19 May 2020 11:23:48 -0700 (PDT)
Received: from localhost.localdomain ([223.235.145.232])
        by smtp.gmail.com with ESMTPSA id p2sm148399pgh.25.2020.05.19.11.23.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2020 11:23:47 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v2 08/10] dt-bindings: mmc: owl: add compatible string actions,s700-mmc
Date:   Tue, 19 May 2020 23:49:26 +0530
Message-Id: <1589912368-480-9-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589912368-480-1-git-send-email-amittomer25@gmail.com>
References: <1589912368-480-1-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit adds a new SoC specific compatible string "actions,s700-mmc"
in combination with more generic string "actions,owl-mmc".

Placement order of these strings should abide by the principle of
"from most specific to most general".

Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
	* Newly added patch in v2.
---
 Documentation/devicetree/bindings/mmc/owl-mmc.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/owl-mmc.yaml b/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
index 12b40213426d..9604ef695585 100644
--- a/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
+++ b/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
@@ -14,7 +14,11 @@ maintainers:
 
 properties:
   compatible:
-    const: actions,owl-mmc
+    oneOf:
+      - const: actions,owl-mmc
+      - items:
+          - const: actions,s700-mmc
+          - const: actions,owl-mmc
 
   reg:
     maxItems: 1
-- 
2.7.4

