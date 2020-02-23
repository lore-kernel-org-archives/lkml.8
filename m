Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FF3C35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 04:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D3B2217F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 04:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="F5CpqO+O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eRehqDob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgBWEI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 23:08:56 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:36975 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726983AbgBWEI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 23:08:56 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id B087015D8;
        Sat, 22 Feb 2020 23:08:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 22 Feb 2020 23:08:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=8Gmm1jV3gADOP
        RofRHQkO+7+tEPK7Er+RIxVB5tuf4g=; b=F5CpqO+OECK8RIsZPvjvJHJZcCdWS
        FcQXDp4hqcsChQOfb5DKnWxjy+FzUOdvdxEt2ELhbWTH4FNlAne7QwWzWlAioKw6
        GgecB2fUNa3CAErCvGWWOVgnihGDPrHt8MfjNJ2xLpqUAIWa5OFx6eDl8eFZPlIO
        BzYYesuBKdx+qxclCHgsGQclyR5L8lPxumYaMvJKVT+7IDe3uzpzb35R9sQl7tfi
        +DfgK5UC1mfeYRboYcDCya7/AkJcreEM1TVlP07k4edXZyA1ZNKroh9DeoD6ZHCu
        wQGA5HeSgCt4tu0u/KJ/kk53bTY16JSRcDkwYy65SG5mGgVesA4NgjSPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=8Gmm1jV3gADOPRofRHQkO+7+tEPK7Er+RIxVB5tuf4g=; b=eRehqDob
        Ka0zAQvFp0KrZF1WQuLaODYip5HHUr2Yjtn5oqKMhW+LqRcGGi0+/ltrReWajcTZ
        MdOJLGpS/qRRUiyt/BeGEXjTVK9yLz442UoslRck9a79SyhUjfq7FG5ha5mkAk7E
        xihg7SPnfTvhPntSGgkXhmaOfqP28+h5KkY8BdAH7onz4mXVFhgTRg3AAjW+69nC
        u47aFBmhx5/NSoAPNrAKFe2v1zPVg+NeVlMLs9Serpf69yPiCS4JxVuSv779bSBq
        9B5K1N9gnyGf2ZS53k+u/v1Jl93iFTM/oCZ5r9YtLJqdGcZvWt0PrDDDrHb/iQ7P
        1jW/8PGRFtKCWg==
X-ME-Sender: <xms:1_pRXqMvCPM20Jwq7RrTwwzHBYUb28AwVATQanqpjzSlENuMx3dWqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrkeejgdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuffhomh
    grihhnpeguvghvihgtvghtrhgvvgdrohhrghenucfkphepjedtrddufeehrddugeekrddu
    hedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    grmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:1_pRXi_YdY7DpIkltQC-037Aq3-PUYMbNkvpnZaiITcd0sPcTF0CUw>
    <xmx:1_pRXn7U-b3PTM2-Xv4lbx_Y-QC1rXUJFtrROw2WAJuMRRgCzYDxZA>
    <xmx:1_pRXo6rKGFI2c7pFzDi59rzteGoTTXKV8K-0rJGE1Kmr3U8rEE6uQ>
    <xmx:1_pRXrcnlDbojTLFqzaLuQ-bKXIgYmegSg0xZrtVZR8-ej7Ii8wwPg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9CE1B3280062;
        Sat, 22 Feb 2020 23:08:54 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ondrej Jirman <megous@megous.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v7 1/6] dt-bindings: mailbox: Add a binding for the sun6i msgbox
Date:   Sat, 22 Feb 2020 22:08:48 -0600
Message-Id: <20200223040853.2658-2-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200223040853.2658-1-samuel@sholland.org>
References: <20200223040853.2658-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This mailbox hardware is present in Allwinner sun6i, sun8i, sun9i, and
sun50i SoCs. Add a device tree binding for it.

Acked-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
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
2.24.1

