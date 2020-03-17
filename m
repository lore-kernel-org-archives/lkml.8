Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BF8C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C50D20738
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ae4n6jEj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgCQQgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 12:36:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55411 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbgCQQgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 12:36:05 -0400
Received: by mail-wm1-f68.google.com with SMTP id 6so22190979wmi.5;
        Tue, 17 Mar 2020 09:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pjMnwjFJerbx0N3L2Dqt4xop1wyGSpDLGCMz6+TnU/s=;
        b=ae4n6jEjH+OoCBS3DnCEY+jJdqGdHoFGgsv2iRa/Cup2ogFIxxfK4FqkXdeKrPHJjG
         Ik/j9T4EEt12OeXtkoJyGcezLGrulc504g7REHd58NzxHSwPYmSw9GQqbCUPGn/uQlnZ
         AiojD5bU/QJsdFQP2QlQcdP+GZTg4N3K2ZHkqL+sPY2H/IRoE5riBfgejccuahVRH71T
         HbrTTgF+1x8EqHv9pBZOoUpFTE17T2HiRjFN0UZKK5ASEK9nl2TOakhivBhivLlFRuqS
         Tmi4R0dsNh3/ScEt2CBSROrbPl03upAOGp4siQdjiOsNF30lNwxBxH/ZFzrRKyglU+zP
         hNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pjMnwjFJerbx0N3L2Dqt4xop1wyGSpDLGCMz6+TnU/s=;
        b=eW4cW+B3JS6ccNXwCkolys4UFQMFdXNBINxRsbTTktR/NjVKnV7Nng1oXDYk1dSDEh
         xMtAKA8KHvD/+mhLElQa3mUIQmdV3Kgk9MIgCA+t0RQ0cXonoVTCpelyBrzjobYSJdIA
         GEBE3dQfLdVUzYn8UkgLhO9fDSrucbsQ3LyF8hFicuFtf+0qlUgDN2lPIF82hA8Ze13X
         hK9Fbc/X47pN9SXnLKyS2NyzOa95FTtl6a1to/y0T8nSjtszllrUaN0JJ7OOZDgEgNLM
         ERQ7H9uJK+SOSJTVNu7aBNeyKHYRVMn3SaLtCBEUh5eA9k6wYD/piDi7MgjylUI1VYd+
         d6mA==
X-Gm-Message-State: ANhLgQ3wQF9H9qeOpaucb5UE0AYjmZ8iZ88nM9D3hSlkbA6OlHTstM2C
        ArsoAzg98XoUF4Af9iQtKCI=
X-Google-Smtp-Source: ADFU+vvBNQ5z4r9YWuB8B/zFVlS25fu6bKiScd+gMjdgNptjWWj9nway+jpZRp+sZT2jBqbDdFBFng==
X-Received: by 2002:a7b:cb44:: with SMTP id v4mr138704wmj.29.1584462963204;
        Tue, 17 Mar 2020 09:36:03 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id b10sm5389702wrm.30.2020.03.17.09.36.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Mar 2020 09:36:02 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] dt-bindings: sram: fix yaml warnings for rk3288-pmu-sram compatible nodes
Date:   Tue, 17 Mar 2020 17:35:55 +0100
Message-Id: <20200317163555.18107-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200317163555.18107-1-jbx6244@gmail.com>
References: <20200317163555.18107-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives for example these warnings:

arch/arm/boot/dts/rk3288-evb-act8846.dt.yaml: sram@ff720000:
'#address-cells' is a required property
arch/arm/boot/dts/rk3288-evb-act8846.dt.yaml: sram@ff720000:
'#size-cells' is a required property
arch/arm/boot/dts/rk3288-evb-act8846.dt.yaml: sram@ff720000:
'ranges' is a required property

Fix this error by making '#address-cells', '#size-cells' and
'ranges' required for all compatible strings except for
'rockchip,rk3288-pmu-sram'.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/sram/sram.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/sram/sram.yaml | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sram/sram.yaml b/Documentation/devicetree/bindings/sram/sram.yaml
index 7b83cc6c9..f06d254ba 100644
--- a/Documentation/devicetree/bindings/sram/sram.yaml
+++ b/Documentation/devicetree/bindings/sram/sram.yaml
@@ -118,9 +118,18 @@ patternProperties:
 required:
   - compatible
   - reg
-  - "#address-cells"
-  - "#size-cells"
-  - ranges
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: rockchip,rk3288-pmu-sram
+
+else:
+  required:
+    - "#address-cells"
+    - "#size-cells"
+    - ranges
 
 additionalProperties: false
 
-- 
2.11.0

