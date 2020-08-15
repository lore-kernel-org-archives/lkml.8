Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE52C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2822206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ufYZ+30q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbgHOV4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729000AbgHOVwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:14 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE005C06136E;
        Fri, 14 Aug 2020 20:14:42 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id t6so5436616pgq.1;
        Fri, 14 Aug 2020 20:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FqSECy1e8pf4zPO1wLfxKO6fNIKZ/7qUNS0/BJgrcMo=;
        b=ufYZ+30quFDBCzg4srtITHVAen+/jehkrQalOGraipxZT22PqjRzIFhVTPT0RhNKfN
         qoRadlyfv0iOkhb4P75x1kswVeoWwhW42gJlDycYYeICNcZxnqhIp1e9gjnriX2sgSht
         c3y46FMbx+6iTvTtIgEMI9hKC1EHfFf65gZBvNThcwZMkbfN1s8jMv/CE0URG+0wsWFX
         RV9+noAsRrIu2Y+uJyUvPV32rdT4sPG77XVQpnLxivnJIqDzvDb+tYONs5S3c3K+5V8D
         /q4o29ZLlfsfMGdPNf/C4D+tAGNH87ItwBZOoqW6GfjGWqKSqhZiEzi6osPSSIBr4u1u
         9x+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FqSECy1e8pf4zPO1wLfxKO6fNIKZ/7qUNS0/BJgrcMo=;
        b=se2gpN+OF2TyuPpzCSJAjm29GiQhqdqF6IIPpIXQZeepsOkMS2yNk2bCGexo9O1cQu
         /Oe52FFZwDVO6ATZBo7VDJeuoQfQjAE6qvAOii9IW/mjQSyRoLGbtkiCUDMS2Js6JLpF
         2DQ0y/1ga1b+vafspn3oWvFqhidD4NAye81qMuMzrXXpFFAJC7X/6VnbaGlsvn7Mj6M/
         JLkBPE3RB7w4/GVQN8yLtNo1+86FrSl3VIiAZQEsaT0QIEhW5kGSdXJurlAw9TbuJSoH
         2gLUwc5m35sQBL053FaCRui35Zy1SDaR7j+xppJcnS6T697U4j1n2S0KWsxvpkcvOdZG
         n95Q==
X-Gm-Message-State: AOAM530BxhZtNZmB+PaD8CmneFz6c3EcclLuC4H0uEFWbTMP9TxpVCs+
        RqyYlx1k/1dyTyasFz2x3jo=
X-Google-Smtp-Source: ABdhPJx9cEC0BcWfo5fzU/pX3baQBxNja6vMLC7W8acmUbjxKltv4qU0nFFifPBJRkcQh2AQEu4F4A==
X-Received: by 2002:a63:6341:: with SMTP id x62mr3601383pgb.354.1597461282175;
        Fri, 14 Aug 2020 20:14:42 -0700 (PDT)
Received: from localhost.localdomain ([123.110.251.91])
        by smtp.gmail.com with ESMTPSA id 196sm10981534pfc.178.2020.08.14.20.14.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Aug 2020 20:14:41 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org
Cc:     cy_huang@richtek.com, gene_chen@richtek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 3/3] regulator: rt4801: Fix the dt-binding document for dtc check.
Date:   Sat, 15 Aug 2020 11:14:22 +0800
Message-Id: <1597461262-25878-3-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597461262-25878-1-git-send-email-u0084500@gmail.com>
References: <1597461262-25878-1-git-send-email-u0084500@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Fix the dt-binding document for dtc check.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 .../devicetree/bindings/regulator/richtek,rt4801-regulator.yaml        | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml
index 28d30e2..fa075c6 100644
--- a/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml
@@ -49,9 +49,6 @@ required:
   - compatible
   - reg
 
-additionalProperties:
-  - enable-gpios
-
 examples:
   - |
     i2c {
-- 
2.7.4

