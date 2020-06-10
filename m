Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415E5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E6132070B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVT316ld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgFJR3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbgFJR3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 13:29:05 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E02EC03E96F;
        Wed, 10 Jun 2020 10:29:04 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x13so3221902wrv.4;
        Wed, 10 Jun 2020 10:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C2p4/guP6eUoTTnEZEmf3SFA2+OaCJqRAgWR+n+N+dc=;
        b=SVT316ldGqwQIfWUFaw6VBjjDSs7inNVjLANIre1fIWXNZsH4Vdc4zSnhDt4u3bseQ
         l2jQM4ktiZlxZ1dxGl0OibwrU0WlnLiHxSg+AuarMTqcyrasmV7AOG4jDmuLkZW4WAZK
         JKosmhF97DTMuyuejX2Nb/Hlx/vSaYByagT8J7WxikA6gvZ0jaPqVHbXGzLusnqYvT6b
         MvzG1sqX1PPYEU52DeuINrmT7MWUCd3qnbzggirOmeGHvMTlS0TEVxNxVpahSARlzy2e
         fVYXSOt2vppuG9YCy8uZjCTwhiQuZBblg1OVFLoB5UDW2PSFU0QuncymarOfhz3kplmk
         bjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C2p4/guP6eUoTTnEZEmf3SFA2+OaCJqRAgWR+n+N+dc=;
        b=QnQ7iBE4zxaNAgB6xkwf7LecNlth9eGxpJ7i3azLRfj+0h0kRWP3w5HmtYXbnozhpZ
         ojVaFnj9MPFit8uYzUBhPNg0vuemA6+MOJ4hYIb761FUg1UrBoBeC9tZNRAgHpGyXedg
         raW41Debx+Un1DB4UjSXbOdhZHZ0ORSmMMPMhMwWOBo8KRZiGv1LRtVmcIWH7r63YM1R
         iK43LhbgIR6PtQYvQHVnpXRRftpIjXAN+6KQSIHwiSMjSPD+EEIqMNrbJy0icAFYxnkC
         GfJijczQmVMGUwnHuw6NMwVC+fZPpFv0AEQLkL4uGdWSDgbPWwVEQpo65K6TqcPz4rGY
         VZdQ==
X-Gm-Message-State: AOAM532OStsmcoo8IZ7nLfBuRJqEnLve1lzd1S0dubHkabaSkpGslUbp
        d1yFJBjdz52brqNzpo2aJ7c=
X-Google-Smtp-Source: ABdhPJwu5w6QlgnYtEvLR5Q1V/axDnTxsHA33ZcMsL9+rmcsZt1RskYEKxjYnkkiMQa+CwRP/bV7lA==
X-Received: by 2002:a5d:6391:: with SMTP id p17mr5227463wru.118.1591810143304;
        Wed, 10 Jun 2020 10:29:03 -0700 (PDT)
Received: from skynet.lan (28.red-83-49-61.dynamicip.rima-tde.net. [83.49.61.28])
        by smtp.gmail.com with ESMTPSA id h188sm568551wmh.2.2020.06.10.10.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 10:29:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org,
        tsbogend@alpha.franken.de, f.fainelli@gmail.com,
        jonas.gorski@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v3 2/9] dt-bindings: reset: add BCM6345 reset controller bindings
Date:   Wed, 10 Jun 2020 19:28:52 +0200
Message-Id: <20200610172859.466334-3-noltari@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610172859.466334-1-noltari@gmail.com>
References: <20200609160244.4139366-1-noltari@gmail.com>
 <20200610172859.466334-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding documentation for BCM6345 reset controller.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../bindings/reset/brcm,bcm6345-reset.yaml    | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/brcm,bcm6345-reset.yaml

diff --git a/Documentation/devicetree/bindings/reset/brcm,bcm6345-reset.yaml b/Documentation/devicetree/bindings/reset/brcm,bcm6345-reset.yaml
new file mode 100644
index 000000000000..eb3f2182e631
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/brcm,bcm6345-reset.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/reset/brcm,bcm6345-reset.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: BCM6345 reset controller
+
+description: This document describes the BCM6345 reset controller.
+
+maintainers:
+  - Álvaro Fernández Rojas <noltari@gmail.com>
+
+properties:
+  compatible:
+    const: brcm,bcm6345-reset
+
+  reg:
+    maxItems: 2
+
+  "#reset-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - "#reset-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    reset-controller@10000010 {
+      compatible = "brcm,bcm6345-reset";
+      reg = <0x10000010 0x4>;
+      #reset-cells = <1>;
+    };
-- 
2.26.2

