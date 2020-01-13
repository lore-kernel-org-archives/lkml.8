Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C541C33CAB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 05:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6676214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 05:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="TX1kx6z3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cUZbY8fd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387628AbgAMFTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 00:19:19 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:51725 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726127AbgAMFS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 00:18:58 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5962A61D0;
        Mon, 13 Jan 2020 00:18:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 13 Jan 2020 00:18:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=EmmLtCjrK7RsX
        RRqPJrB9bPRF/NolERlt2uFv3dLhTc=; b=TX1kx6z3NpofCraAdgp9otpxgSE5p
        vKMli4ZP6LFzdCfz/wuNh5f3kK7OSnU7/n6eHsEwNN4zVDku2kbfimmTk6kCGJeK
        NOPdQyvWx4gc3FOacM8VBuTWV2IoB6qL5cZHQt+7C/j1EZFPUMGcIlSosbInMDu0
        VkNVxn5RAghoQbuZSa/YtTpVZThIVLS6mexZiuhgcdzbAjevQbV4RM7mYtxVcz/W
        KyEpMH2XDNEmsj9Fe5+roV2oBMjIwHUFUQHAEiMKiHA9dBdRZfxTetr6ljft39nH
        my/JmcQ9C6yAg2r9s5A9FTADe/v6JJmTQIlFTIw3X4L5ljVMCcczbKXWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=EmmLtCjrK7RsXRRqPJrB9bPRF/NolERlt2uFv3dLhTc=; b=cUZbY8fd
        yrvLF71QKUy/fHI6c9irvJyq3GPDGdKFV9mnM7thfkY2753qAIqFfNVr+9eM+G9U
        B++rODEtF6E5XhpMcrVkab0/ik+ENvYpnt9/FwNnzx7TCbMe4uNn4sTmEwLG6xak
        7YmupRYr/XONe/1PTIPIZAmrUMbNW4Fk7YvXYW6FaE4CRqlkMGFvaSLu/kYkVz54
        8rtiE+F3paOXMOSksJzBX20MXlJpDaRZXhkd/t2hRLyDXmp/Nlp4pJpfLB702bv+
        B77WU2IeYP46BtkatUmprDZu799bXStluiXgbsXGkDvDv1Ui88qp88fPe5ScrTaD
        cW4gFjLt8Cpp/g==
X-ME-Sender: <xms:vf0bXktms61j_Pnj0J_f7WUeqObswn1CKYGII5tFqeCZoCyVGfE4iA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdeiledgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucffoh
    hmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecukfhppeejtddrudefhedrudegkedr
    udehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnug
    drohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:vf0bXsX5QOgUAs85nzMPcubWRq9kYP3sOffYRsuhBhbfpuEVSCfJ5w>
    <xmx:vf0bXnkX3L7Tyd-Rxb9mhlBL7BcOtuLHLKpBd-wNZmr3SigyaG_k2Q>
    <xmx:vf0bXlbCQgBDv4roZVvAulJKFeq5VPYSK0pU_dSzo4XiOS4gKlabNQ>
    <xmx:wf0bXjVABqRYl4XUHO3vwy_oyon7YhLg3SxS5fuEHPsFnpcMXGrlEw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0239330602DB;
        Mon, 13 Jan 2020 00:18:52 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ondrej Jirman <megous@megous.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v6 1/6] dt-bindings: mailbox: Add a sun6i message box binding
Date:   Sun, 12 Jan 2020 23:18:47 -0600
Message-Id: <20200113051852.15996-2-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200113051852.15996-1-samuel@sholland.org>
References: <20200113051852.15996-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This mailbox hardware is present in Allwinner sun6i, sun8i, sun9i, and
sun50i SoCs. Add a device tree binding for it.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 .../mailbox/allwinner,sun6i-a31-msgbox.yaml   | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/allwinner,sun6i-a31-msgbox.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/allwinner,sun6i-a31-msgbox.yaml b/Documentation/devicetree/bindings/mailbox/allwinner,sun6i-a31-msgbox.yaml
new file mode 100644
index 000000000000..75d5d97305e1
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/allwinner,sun6i-a31-msgbox.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/allwinner,sun6i-a31-msgbox.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner sunxi Message Box
+
+maintainers:
+  - Samuel Holland <samuel@sholland.org>
+
+description: |
+  The hardware message box on sun6i, sun8i, sun9i, and sun50i SoCs is a
+  two-user mailbox controller containing 8 unidirectional FIFOs. An interrupt
+  is raised for received messages, but software must poll to know when a
+  transmitted message has been acknowledged by the remote user. Each FIFO can
+  hold four 32-bit messages; when a FIFO is full, clients must wait before
+  attempting more transmissions.
+
+  Refer to ./mailbox.txt for generic information about mailbox device-tree
+  bindings.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - allwinner,sun8i-a83t-msgbox
+              - allwinner,sun8i-h3-msgbox
+              - allwinner,sun9i-a80-msgbox
+              - allwinner,sun50i-a64-msgbox
+              - allwinner,sun50i-h6-msgbox
+          - const: allwinner,sun6i-a31-msgbox
+      - const: allwinner,sun6i-a31-msgbox
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description: bus clock
+
+  resets:
+    maxItems: 1
+    description: bus reset
+
+  interrupts:
+    maxItems: 1
+
+  '#mbox-cells':
+    const: 1
+    description: first cell is the channel number (0-7)
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+  - interrupts
+  - '#mbox-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/sun8i-h3-ccu.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/reset/sun8i-h3-ccu.h>
+
+    msgbox: mailbox@1c17000 {
+            compatible = "allwinner,sun8i-h3-msgbox",
+                         "allwinner,sun6i-a31-msgbox";
+            reg = <0x01c17000 0x1000>;
+            clocks = <&ccu CLK_BUS_MSGBOX>;
+            resets = <&ccu RST_BUS_MSGBOX>;
+            interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+            #mbox-cells = <1>;
+    };
+
+...
-- 
2.23.0

