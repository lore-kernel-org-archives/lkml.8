Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE15C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A11520700
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="LRiL0r3p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XMJBP5GB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbgDXPkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:40:37 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:39489 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728353AbgDXPf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:35:57 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id A560C1338;
        Fri, 24 Apr 2020 11:35:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 24 Apr 2020 11:35:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=YRaDkEkTklAX2
        SkiwK41JMnq4nzpTHlfRqzovGYPSFo=; b=LRiL0r3pGsH7NH0UsiS1ZQyTZko/P
        FagohDpiXdVd/S3MxI4t/rZ8096CFZXNvqEG2vnqhBmpNhRlaWPaaLAcmScXt7eu
        H1qaG6DQtpk4cq2q+xFjxTonQKVXFa2ho/4EZCgl5qDvMNz4+j7Aua0ROYnBdFao
        0UrckhSmgNsQzuZNfBGWB8kZRa62j25gNy5tgWQ3OSgEKZMNVvsbMk0/GHenBXhH
        0WdgnhGNzaW/9Ubr76iCIR40rCct0FBj6vS74tSXqFjbtUDFm/8QO/oiHEtWrTJI
        0GpnjVnDRm9mjs0ZWL7CR56oQiyAH3wNlH+jDbCfsTI/2YNffUF+K33LQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=YRaDkEkTklAX2SkiwK41JMnq4nzpTHlfRqzovGYPSFo=; b=XMJBP5GB
        /bJqUF20ppXOg2IXy6n4jKj4tlyRjY3IEDLvMpE1hdWSZ4xX4iqktdcRoodepNrt
        lg134xyAe3W5nGO7XGm+GmS+LpyiOfoDqPKFicz+BYT2/bXzYPeA/j18pgarg8Gw
        BaHMyBEF0g9mKXIpfkZQ1QTyyVAJE8Vfmn1XK2HJfwZgiU844wTZgpNlfdfy6UXy
        cx1vJQt+ZfYXuElvlgpSgJAJib6VyavijETudd+m3/O8DZ4msVssR/Go0mf1z7x3
        H0f20lNqQM9GC0/TtzXPwenEWY0a7jau37iYWd1IEnd0zwtXLcHPPIvxc9R3phlb
        SFbSS2MBzwuS1g==
X-ME-Sender: <xms:XAejXr5W7-kI-k-ntRqkQLPWi0dF-vX5gRY1FK9a3Z7N7__mSB-tsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrhedugdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    evohgrshhtrghlqdfhgeduvddqtddvucdludehtddmnecujfgurhephffvufffkffojghf
    ggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomhgrgi
    himhgvsegtvghrnhhordhtvggthheqnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdr
    ohhrghenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedune
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:XAejXhUWqZFRNR_5fZsp3aMzApxekHQOufLuZwxSzTrEP3nqQVPRJg>
    <xmx:XAejXiO1FOGTNcMczhzIZV_CIsdRnPyH4ztsR_9xlat1qHJrDJmNGg>
    <xmx:XAejXohhZB0zr4r85_LevF2B5lIibXBh2gUnjgBYyH68CRfv_g-PbA>
    <xmx:XAejXqLUGxn8iB0XqtXvIkK9k1qYa_qVCRJkfrBOxF7xp7wNnnJBpczcW48>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id D40B5328005D;
        Fri, 24 Apr 2020 11:35:55 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 24/91] dt-bindings: clock: Add BCM2711 DVP binding
Date:   Fri, 24 Apr 2020 17:34:05 +0200
Message-Id: <29a820e57e208b5ef8d498b121908604bb82245d.1587742492.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BCM2711 has a unit controlling the HDMI0 and HDMI1 clock and reset
signals. Let's add a binding for it.

Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Reviewed-by: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 Documentation/devicetree/bindings/clock/brcm,bcm2711-dvp.yaml | 47 +++++++-
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/brcm,bcm2711-dvp.yaml

diff --git a/Documentation/devicetree/bindings/clock/brcm,bcm2711-dvp.yaml b/Documentation/devicetree/bindings/clock/brcm,bcm2711-dvp.yaml
new file mode 100644
index 000000000000..08543ecbe35b
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/brcm,bcm2711-dvp.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/brcm,bcm2711-dvp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM2711 HDMI DVP Device Tree Bindings
+
+maintainers:
+  - Maxime Ripard <mripard@kernel.org>
+
+properties:
+  "#clock-cells":
+    const: 1
+
+  "#reset-cells":
+    const: 1
+
+  compatible:
+    const: brcm,brcm2711-dvp
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - "#clock-cells"
+  - "#reset-cells"
+  - compatible
+  - reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    dvp: clock@7ef00000 {
+        compatible = "brcm,brcm2711-dvp";
+        reg = <0x7ef00000 0x10>;
+        clocks = <&clk_108MHz>;
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+    };
+
+...
-- 
git-series 0.9.1
