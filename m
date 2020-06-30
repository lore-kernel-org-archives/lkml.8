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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A33C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0827620759
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjdFdCHe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733052AbgF3Lo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 07:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730225AbgF3Loz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 07:44:55 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6E4C061755;
        Tue, 30 Jun 2020 04:44:54 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id j80so18205562qke.0;
        Tue, 30 Jun 2020 04:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WTlfR6UYku/WsXJmWLdLkNeTBNSHfzrCWj49YXg6FX4=;
        b=HjdFdCHeNG5nSwIBlIe5sqleDI8IXYCBlhSvWIGcRBFUPiTeG8MeTFl4DeTEfTVFgi
         LvWWGMrWiy0QNbCzHJseGA9p3os+NRj0StvEpKbSG11ho5qCdH+Oj8T0FgPcq8aL5mDW
         +8MiiJQi5+r8voU3GgKhUkM+zk0w7UyyKJEc/Pk3PlIXerlZFMVwEZMWwlmTWKu1KC+S
         xwDBkh/cJ2cCXiHZY615RI/9xqmhG0cacyRh0gaQEDz2I8mNc+VsN0QUe8zt6RUUyEuL
         0nRFpTQ0aXvR2em5kLnUzQcbRAsjL/ijWz6JkOzhQ9OXC1M2YbOgCtOAyROVQT0aq0ls
         kFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WTlfR6UYku/WsXJmWLdLkNeTBNSHfzrCWj49YXg6FX4=;
        b=OqsgsK0uAPpgWQ6Y/liZ1nUY4UfD7OvFUiywS05tJF/mBNPogJlIX4jqqE4deee/3N
         eNGPU5DVE03U/z8uiWM23XDdEH/xIBcHv3jeyhFv/YgVtH8nIEAp2+Qhb8Kjx/7Hvn26
         CEqOa+Mt24R46GCG8um188s0p6DZIhVaGgS9FNdxxT5bh8jBa+lSybzaj3i7PH/gqo+a
         bmNEQB+GbC5AmdEvGg9/KLc4xxkLGUjVDqwHU3avCDFSESDeRSqVpFspTMe29SpMrbw0
         Za3XspTpHmoshQVNYozX14dJz9q9cPmyck/lulq+zO9eTh0eaTHtqi7+EcS1jKBlhzGs
         jy8A==
X-Gm-Message-State: AOAM530DRagZVjNrNPJhZP8mA8W3zBnOdyFw5AC8z2890VR7MNzdPcq4
        zUeVbLe45xXqMRUb/IEOXFk=
X-Google-Smtp-Source: ABdhPJzuiJ0gpGbMOpAqXquDKD4CvabrxLl8YTRauEEFPMj26k4aBQ9eN4DWf4qneJrroIG9QRncYg==
X-Received: by 2002:a05:620a:635:: with SMTP id 21mr19760883qkv.491.1593517493723;
        Tue, 30 Jun 2020 04:44:53 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:482:92b:d42f:2bc1:abe3:59f0])
        by smtp.gmail.com with ESMTPSA id i8sm2613647qtr.90.2020.06.30.04.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 04:44:52 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     robh+dt@kernel.org
Cc:     lee.jones@linaro.org, benjamin.gaignard@st.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] dt-bindings: mfd: st,stmfx: Remove extra additionalProperties
Date:   Tue, 30 Jun 2020 08:44:43 -0300
Message-Id: <20200630114443.26414-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following build error is seen with 'make dt_binding_check':

  CHKDT   Documentation/devicetree/bindings/mfd/st,stmfx.yaml
/home/fabio/linux-next/Documentation/devicetree/bindings/mfd/st,stmfx.yaml: properties:pinctrl:patternProperties: {'enum': ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'deprecated', 'description', 'else', 'enum', 'if', 'items', 'maxItems', 'maximum', 'minItems', 'minimum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'propertyNames', 'required', 'then', 'unevaluatedProperties']} is not allowed for 'additionalProperties'

Remove the extra 'additionalProperties' to pass the build.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes since RFC:
- Added Rob's Reviewed-by
- Added lkml on Cc

 Documentation/devicetree/bindings/mfd/st,stmfx.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/st,stmfx.yaml b/Documentation/devicetree/bindings/mfd/st,stmfx.yaml
index 0ce56a0da553..bed22d4abffb 100644
--- a/Documentation/devicetree/bindings/mfd/st,stmfx.yaml
+++ b/Documentation/devicetree/bindings/mfd/st,stmfx.yaml
@@ -73,8 +73,6 @@ properties:
           output-high: true
           output-low: true
 
-      additionalProperties: false
-
     additionalProperties: false
 
     required:
-- 
2.17.1

