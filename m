Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797FAC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 20:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 443F420757
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 20:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586463936;
	bh=FqZZyRWNedoHw8WL71Vs8Cf07Eww+PbhCLq5spNRf7A=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=DN+arXhYwBKs9qgUZr21S1FO9PLWD/pPXiHBT0+Zji/WDdFavCOKx2c6BQ0YWZI1D
	 /oT/Y3oWK5Azpuhqh+JhRu9m/bqiLCeWZ8Rc72LVbNCiUyNWMrB4ZcE0nNUp97OEgN
	 Q7s5nieGOiAmmIwLr8H0IFeW2s9+sqUss2rcPCPo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgDIUZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 16:25:34 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:42516 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgDIUZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 16:25:34 -0400
Received: by mail-il1-f193.google.com with SMTP id f16so953444ilj.9;
        Thu, 09 Apr 2020 13:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gXUwa06vZwL6x1t/SJK4W0bICpt4Py/Wq2j3O5BCR6s=;
        b=fAD0j4BQT84Jiw3Z7B4+tnjEE8hQtV/N60Dro0QiFQd7EZTTTNvc9Msk5wIgPFxqW8
         XHygXwHkv5s2KDKb5MxBD8Oxkf6Cf25TOgBxsy6m6JWoTBiBN0hxDaEgUO3ZWSi8OW6G
         kxZ3XrHPfxeOK0Oj6R/OUHYkriSWJ+XcOUYwxqmRfpqi/EjepBk6A+KNwjlqI6paloOn
         VOG5/Zq9+GDCt5AsYcJbJwpDr7aZRUiyYbXhAkJUQ7iOgrlAPI72SK6BJ5/jEDIK+dhJ
         N7hwjfVSO/XpIuOXcYajlxVNgAFNUGSfifGOnJaz6/eE0I7cwrMjkc+xknRC9fxLL1Ug
         BHpw==
X-Gm-Message-State: AGi0PuaRlw+FbegMdLAIkkbTxUjCsyhuMyogl/+HktxeI6gAlJzdlfjv
        faCig3RvdcfJMVCMXFTbz9G4uuQ=
X-Google-Smtp-Source: APiQypIKKEX2iOUPUALGPbiTMi7yg5LcSctrYW9Lt5dTuemdG/CaezitWE9LCXuToVcYeYtb6lgphA==
X-Received: by 2002:a92:7e07:: with SMTP id z7mr1713542ilc.289.1586463932044;
        Thu, 09 Apr 2020 13:25:32 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id x15sm26202ilg.29.2020.04.09.13.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 13:25:31 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH] dt-bindings: interrupt-controller: Fix loongson,parent_int_map property schema
Date:   Thu,  9 Apr 2020 14:25:29 -0600
Message-Id: <20200409202529.25699-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'loongson,parent_int_map' is an array, but the schema is defining a
matrix resulting in the follow warnings:

Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.example.dt.yaml:
  interrupt-controller@3ff01400: loongson,parent_int_map:0: [4043309055] is too short
Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.example.dt.yaml:
  interrupt-controller@3ff01400: loongson,parent_int_map:1: [251658240] is too short
Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.example.dt.yaml:
  interrupt-controller@3ff01400: loongson,parent_int_map:2: [0] is too short
Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.example.dt.yaml:
  interrupt-controller@3ff01400: loongson,parent_int_map:3: [0] is too short

The correct way to define an array is a list in 'items' and/or a size
defined by 'minItems' and 'maxItems'.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <maz@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
Will take this via the DT tree.

Rob

 .../bindings/interrupt-controller/loongson,liointc.yaml      | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
index 9c6b91fee477..26f1fcf0857a 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
@@ -56,9 +56,8 @@ properties:
       cell with zero.
     allOf:
       - $ref: /schemas/types.yaml#/definitions/uint32-array
-      - items:
-          minItems: 4
-          maxItems: 4
+      - minItems: 4
+        maxItems: 4
 
 
 required:
-- 
2.20.1

