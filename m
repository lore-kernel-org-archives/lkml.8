Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C800C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 16:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CE0120700
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 16:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587745032;
	bh=yWXVNro5I0u4D9d7cF0jVM/W+4ylI+8/zO8G9gZnl8k=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=c9RYqS3ab8v3gevrIJ9Ol+zAH8vOTvoCmsg5nM+25tVNASPDbavX7sXCHX81uUnu9
	 q7TnZAcwto5e2cb85jkxoep6kqdr5ANJyKaBnCrhwcDBFmTw/oyEwbe98bctfLAIqu
	 EkoG9Ei/uo1xNqIXxGrIEx3Us0HoaKRCVxURrJfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbgDXQRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 12:17:11 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44847 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgDXQRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 12:17:11 -0400
Received: by mail-ot1-f67.google.com with SMTP id j4so13309073otr.11;
        Fri, 24 Apr 2020 09:17:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NhnUZSf5UlRx50w9PHpFzuqoGbduCG7D+ErtmW3uoCQ=;
        b=A78sF6D0MmJ5tZctHqkvCTTZKI/B1KTZjEXcCwH7dwKV1FDjgP1gcLJbZtJcySFA6G
         vwd1hH8DtRjM4GqINI/hl/JO6U+GOCLkIEzrfMdB481QJJ/QRL0loPELij4nfI8H65/8
         I8ZRneDwrS6kQXbIkWgi9tlQ87pTk1FcbVVYfrmCX6wM0qnUNlmW/mL+vr6DCL8PKGfj
         RqbnwxjRPXV32JpZQfdeh6KeNhmUn+Rz/PwSO3RWINh4vX6jnV45yHeXNiilyla571At
         z6cPMwEPFGua8BtL7Eu4EFNxmLReDoHdYWSfrTgbogfZpUN46hHL7sVAVv606Lb1Jtvk
         teow==
X-Gm-Message-State: AGi0PuYEDkWNCW44+LfWibJm8VvONpmfdSwDESFL14bsMjGtfdl0N+V6
        WAUITB15Jmg9S2TyJUMU4t+fWKE=
X-Google-Smtp-Source: APiQypJwy/nD2OpvHdyhyYsbs/oAw9OJZfI1iZj2tpczoTndgavD9eW5KwnSv/0NBqnsHkauqg8K+g==
X-Received: by 2002:aca:5dc4:: with SMTP id r187mr5009088oib.133.1587745030132;
        Fri, 24 Apr 2020 09:17:10 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n6sm1677837oof.35.2020.04.24.09.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 09:17:09 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] dt-bindings: Fix erroneous 'additionalProperties'
Date:   Fri, 24 Apr 2020 11:17:07 -0500
Message-Id: <20200424161708.2906-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's several cases of json-schema 'additionalProperties' at the wrong
indentation level which has the effect of making them DT properties. This
is harmless, but let's fix them so a meta-schema check for this can be
added.

In all the cases, either the 'additionalProperties' was extra or doesn't
work because there's a $ref to more properties. In the latter case, we
can use 'unevaluatedProperties' instead.

Reported-by: Iskren Chernev <iskren.chernev@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Saravanan Sekar <sravanhome@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mfd/st,stpmic1.yaml       | 2 --
 Documentation/devicetree/bindings/regulator/mps,mp5416.yaml | 1 -
 .../devicetree/bindings/regulator/mps,mpq7920.yaml          | 3 ++-
 .../bindings/regulator/rohm,bd71828-regulator.yaml          | 6 +++++-
 .../bindings/regulator/rohm,bd71837-regulator.yaml          | 6 +++++-
 .../bindings/regulator/rohm,bd71847-regulator.yaml          | 6 +++++-
 6 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml b/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
index f88d13d70441..be7faa6dc055 100644
--- a/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
+++ b/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
@@ -259,8 +259,6 @@ properties:
 
     additionalProperties: false
 
-  additionalProperties: false
-
 additionalProperties: false
 
 required:
diff --git a/Documentation/devicetree/bindings/regulator/mps,mp5416.yaml b/Documentation/devicetree/bindings/regulator/mps,mp5416.yaml
index f0acce2029fd..3b019fa6db31 100644
--- a/Documentation/devicetree/bindings/regulator/mps,mp5416.yaml
+++ b/Documentation/devicetree/bindings/regulator/mps,mp5416.yaml
@@ -37,7 +37,6 @@ properties:
         type: object
 
     additionalProperties: false
-  additionalProperties: false
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml b/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
index a682af0dc67e..ae6e7ab36c58 100644
--- a/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
+++ b/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
@@ -75,7 +75,8 @@ properties:
             description: |
               disables over voltage protection of this buck
 
-      additionalProperties: false
+        unevaluatedProperties: false
+
     additionalProperties: false
 
 required:
diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd71828-regulator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd71828-regulator.yaml
index 71ce032b8cf8..1e52dafcb5c9 100644
--- a/Documentation/devicetree/bindings/regulator/rohm,bd71828-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/rohm,bd71828-regulator.yaml
@@ -35,6 +35,8 @@ patternProperties:
         description:
           should be "ldo1", ..., "ldo7"
 
+    unevaluatedProperties: false
+
   "^BUCK[1-7]$":
     type: object
     allOf:
@@ -103,5 +105,7 @@ patternProperties:
 
     required:
       - regulator-name
-  additionalProperties: false
+
+    unevaluatedProperties: false
+
 additionalProperties: false
diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.yaml
index a323b1696eee..543d4b52397e 100644
--- a/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.yaml
@@ -41,6 +41,8 @@ patternProperties:
         description:
           should be "ldo1", ..., "ldo7"
 
+    unevaluatedProperties: false
+
   "^BUCK[1-8]$":
     type: object
     allOf:
@@ -99,5 +101,7 @@ patternProperties:
 
     required:
       - regulator-name
-  additionalProperties: false
+
+    unevaluatedProperties: false
+
 additionalProperties: false
diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd71847-regulator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd71847-regulator.yaml
index 526fd00bcb16..d797cc23406f 100644
--- a/Documentation/devicetree/bindings/regulator/rohm,bd71847-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/rohm,bd71847-regulator.yaml
@@ -40,6 +40,8 @@ patternProperties:
         description:
           should be "ldo1", ..., "ldo6"
 
+    unevaluatedProperties: false
+
   "^BUCK[1-6]$":
     type: object
     allOf:
@@ -93,5 +95,7 @@ patternProperties:
 
     required:
       - regulator-name
-  additionalProperties: false
+
+    unevaluatedProperties: false
+
 additionalProperties: false
-- 
2.20.1

