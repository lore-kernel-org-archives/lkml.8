Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4EDC3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 06:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 473AE2072A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 06:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIlSEBP/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgCFGHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 01:07:36 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40941 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgCFGHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 01:07:36 -0500
Received: by mail-pj1-f66.google.com with SMTP id gv19so623711pjb.5;
        Thu, 05 Mar 2020 22:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kHeb+SfnGLtuUMgz17H7K7hcVcSru/jDISCxMI3+cKE=;
        b=FIlSEBP/hwE9JRFB2Mz0xw/mVNomFhTh4xaXxcy7QjVpaf1LzULOLtPyfnie2sU4gN
         /mqY3YKNFx3QE6F4taYt6GuS8aL85L5zVcXhPrr6z+aUGSBFo5J9DTDVxSzFWcdUAUdV
         SRr31Dz2bCsMYhpebO12LTmCyE7NEv8pWttdEmPnEQPhtM36sV7ZwOn9dKfZTbGw6sIe
         gyT/3qDHDbZpul/+2EKPrq7ZQQsCukDkxtWctUEIM4qgmLRbRLp10lCg1Ou9CbJp97+7
         thGQkdDnOvMYi/K09RA9fxQcAx8BHmey5TizBPoNMM2NhcqxFUN4g8JG/1rxvknurXdJ
         DCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kHeb+SfnGLtuUMgz17H7K7hcVcSru/jDISCxMI3+cKE=;
        b=HGq6cV8FvKbxbZ5ZPfKx3bbZbpJamtjTFmVzwMOOcyV8BNDYLJZay1WYkw7hcYE+ay
         PWNbbUj30qfH3xFOWDtF07TQnVu/2RQnfPD0YO0BtYX632JPVVV9LCPbzNu3KOj+ucwy
         QZQYjQiyAgD7Tzq2isBa3CMX9A83GZ9q0DfSY/zpR4U0Wgx9RaqA3mhpo0mGf1woBS19
         Uns1ggBWkcsPS9Q8KllsZIfQQ+EKkHoirL3CKQXe9vjV7EUzAoncScuZXo9ZICxn+01V
         BXJcBmgtHg9sNgmcKo6RCDmZYWWLMNS3b7KYWZUw5G4JimlJA8CPrYhoWjcMLapKCMWL
         Yvsw==
X-Gm-Message-State: ANhLgQ3hsXSjGZmH+lZrEKTQT/YPYL7c3GPk3y1ChVYtknbU3KbXXFAB
        Fc4r1db3ZrAaARbWmQUmP84=
X-Google-Smtp-Source: ADFU+vt0EuSoyMjaxiGVKTdK2ttkJ6O5RMFlIjqX+zW1/VSv5o5EnnL4CFxGGldjU1nsECjzGbskfg==
X-Received: by 2002:a17:90b:30c2:: with SMTP id hi2mr1920843pjb.7.1583474854718;
        Thu, 05 Mar 2020 22:07:34 -0800 (PST)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id z19sm16890761pfn.121.2020.03.05.22.07.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Mar 2020 22:07:34 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, jassisinghbrar@gmail.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang7@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: mailbox: Add the Spreadtrum mailbox documentation
Date:   Fri,  6 Mar 2020 14:07:21 +0800
Message-Id: <9bc2631ff3ab60fc607a5215e561aace83c0e8ca.1583464821.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baolin Wang <baolin.wang@unisoc.com>

Add the Spreadtrum mailbox documentation.

Signed-off-by: Baolin Wang <baolin.wang@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 .../devicetree/bindings/mailbox/sprd-mailbox.yaml  | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml
new file mode 100644
index 0000000..2f2fdcf
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/mailbox/sprd-mailbox.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Spreadtrum mailbox controller bindings
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - sprd,sc9860-mailbox
+
+  reg:
+    minItems: 2
+
+  interrupts:
+    minItems: 2
+    description:
+      Contains the inbox and outbox interrupt information.
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: enable
+
+  "#mbox-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - "#mbox-cells"
+  - clocks
+  - clock-names
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    mailbox: mailbox@400a0000 {
+      compatible = "sprd,sc9860-mailbox";
+      reg = <0 0x400a0000 0 0x8000>, <0 0x400a8000 0 0x8000>;
+      #mbox-cells = <1>;
+      clock-names = "enable";
+      clocks = <&aon_gate 53>;
+      interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+    };
+...
-- 
1.9.1

