Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2C4C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A49B0206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584122851;
	bh=dqIuswp1RKk/FdTFaLj3rD9WStIXPmXy//brccWYJDs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=iK7APLlnkzv/0yQ68GTqRJ4bwHo7TWyFKLG2ADNUshTOnrnZlQVaA0KzsWrUSVSp0
	 LBCSQfaG78BgQYZ4Fk5TjvASM22VF+bQZEfUWpalaZwoGmb9GKu5soa1JGasvtNmIk
	 kMdYTj+6lWE4uI6wTZpWXHkLtbfFS4qLKfnl+5n0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgCMSHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 14:07:30 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34906 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgCMSHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 14:07:30 -0400
Received: by mail-oi1-f195.google.com with SMTP id k8so8913139oik.2;
        Fri, 13 Mar 2020 11:07:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XfdUP3YGPmXKGkwHkk+uuVO8kCTOJvEs+/FfsSsBG+o=;
        b=TsImVrcyGRWLdZ+ghcPIMZerBiFeMOY3FYbeIXP2tDC9gcSf7HAqba+rZzv/Zc/xoQ
         3JgZwcUifupmtoYxzbVFvoLDzB3LYqu54s5tLfn+hE/9XSEQ/do+U4oKs+DdfPKjY/Qt
         nTkumcqPdGgR7VrF2bu6xcRhnFztFi0beZ2T1AKdGfive17Ne3Cs0Dk+tkmGXMxnbM8p
         EBu9lvGbV6+F/3zpLDlccfDxj8uszf/ukmv3JshExtoK9ac3pzocoL4j+N2Cyv1413/G
         98WVZRYXuTzcMraRuc9FTssb7wPtvsBRBdI0Y4nqC74K+go0kLaYXUmqeiDw7Oa/0dnK
         1Eyg==
X-Gm-Message-State: ANhLgQ2oGc/3PxgkVog/1mrmhKXpEYTcd+Wf7QuHynWT2Hc3TgIGklCi
        jxrXeatIZ44Qu8QG/9aR6w==
X-Google-Smtp-Source: ADFU+vvVX5P8LfcDS2EEYM59OmWbE1ipOo1GIc6HBscLEHtBCb9LizJUYnklHCLbjBQQR2+W7LYBFg==
X-Received: by 2002:a05:6808:9bb:: with SMTP id e27mr2718525oig.36.1584122849148;
        Fri, 13 Mar 2020 11:07:29 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id w18sm13886991otl.60.2020.03.13.11.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 11:07:28 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     dri-devel@lists.freedesktop.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>, Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH v2] dt-bindings: display: ti: Fix dtc unit-address warnings in examples
Date:   Fri, 13 Mar 2020 13:07:27 -0500
Message-Id: <20200313180727.23044-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extra dtc warnings (roughly what W=1 enables) are now enabled by default
when building the binding examples. These were fixed treewide in
5.6-rc5, but some new display bindings have been added with new
warnings:

Documentation/devicetree/bindings/display/ti/ti,am65x-dss.example.dts:21.27-49.11: Warning (unit_address_format): /example-0/dss@04a00000: unit name should not have leading 0s
Documentation/devicetree/bindings/display/ti/ti,j721e-dss.example.dts:21.27-72.11: Warning (unit_address_format): /example-0/dss@04a00000: unit name should not have leading 0s
Documentation/devicetree/bindings/display/ti/ti,k2g-dss.example.dts:20.27-42.11: Warning (unit_address_format): /example-0/dss@02540000: unit name should not have leading 0s

Cc: Jyri Sarha <jsarha@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Drop panel fixes as there's another patch fixing the 3 panels plus
   others.
---
 Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml | 2 +-
 Documentation/devicetree/bindings/display/ti/ti,j721e-dss.yaml | 2 +-
 Documentation/devicetree/bindings/display/ti/ti,k2g-dss.yaml   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
index cac61a998203..aa5543a64526 100644
--- a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
+++ b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
@@ -121,7 +121,7 @@ examples:
     #include <dt-bindings/interrupt-controller/irq.h>
     #include <dt-bindings/soc/ti,sci_pm_domain.h>
 
-    dss: dss@04a00000 {
+    dss: dss@4a00000 {
             compatible = "ti,am65x-dss";
             reg =   <0x0 0x04a00000 0x0 0x1000>, /* common */
                     <0x0 0x04a02000 0x0 0x1000>, /* vidl1 */
diff --git a/Documentation/devicetree/bindings/display/ti/ti,j721e-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,j721e-dss.yaml
index ade9b2f513f5..6d47cd7206c2 100644
--- a/Documentation/devicetree/bindings/display/ti/ti,j721e-dss.yaml
+++ b/Documentation/devicetree/bindings/display/ti/ti,j721e-dss.yaml
@@ -154,7 +154,7 @@ examples:
     #include <dt-bindings/interrupt-controller/irq.h>
     #include <dt-bindings/soc/ti,sci_pm_domain.h>
 
-    dss: dss@04a00000 {
+    dss: dss@4a00000 {
             compatible = "ti,j721e-dss";
             reg =   <0x00 0x04a00000 0x00 0x10000>, /* common_m */
                     <0x00 0x04a10000 0x00 0x10000>, /* common_s0*/
diff --git a/Documentation/devicetree/bindings/display/ti/ti,k2g-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,k2g-dss.yaml
index 385bd060ccf9..7cb37053e95b 100644
--- a/Documentation/devicetree/bindings/display/ti/ti,k2g-dss.yaml
+++ b/Documentation/devicetree/bindings/display/ti/ti,k2g-dss.yaml
@@ -81,7 +81,7 @@ examples:
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/interrupt-controller/irq.h>
 
-    dss: dss@02540000 {
+    dss: dss@2540000 {
             compatible = "ti,k2g-dss";
             reg =   <0x02540000 0x400>,
                     <0x02550000 0x1000>,
-- 
2.20.1

