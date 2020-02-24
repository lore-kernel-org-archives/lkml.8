Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87880C35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F3C20658
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="MGDZcc/A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c+QKLXSW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgBXJOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:14:38 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:46793 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727282AbgBXJJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:09:01 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id E69695C7;
        Mon, 24 Feb 2020 04:08:58 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:09:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=HvoZm/CXRFjaX
        9itj5UKgqnwKV1jLHEaQ0lrY8kkzVk=; b=MGDZcc/Aq+Rw4qJP/RvJzxTT9zuhi
        Vw+TSvutgz7J4MvR9+z/TbcjkJv4Zi88/MjjG+cIgUqJsI6OO5SuD6cRd72CXOQt
        JxLhFehkvSPlU3Yt2PPeUezeD8RxbQ4PMvq33YaFO0gZSq09wVLDMkWB1nol/HYU
        zKJ+4w2Txt1LtjjDqVyb3jQFYTc1pLhDQ9m90nKDOGn1+VeU5CEZEEQYc8WGeWrs
        7hP4oZ1/foDhV2db+JDIY7KrI6OJfLakLunHY9SQXPmBh3y2zqRDAd6eP4pWny2o
        sIHXd8Voz0Vo+ngIbUWFwe980Mbxc4t/nPmSzlPgrB4vfa38Dqd5m32wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=HvoZm/CXRFjaX9itj5UKgqnwKV1jLHEaQ0lrY8kkzVk=; b=c+QKLXSW
        +lO4HtiCmhypK+Tn77ju2BGiGE7BW8mK1MP50t1b4EQ6lLOqGGTBV82mAINI5Xpa
        c9BFIe4wm1tirltt+UcyDrTn4jy2fCDSd35PXwpblyEdb6Db9fl2WK3BFnvJTyOc
        A1N9YrBqwqUynzJ2lVZ+9dBnXsg0KFQDzRf35dfQldUZDPyjbvBrF6pi6rzYIEZ2
        VLaFWgRTTe7Z6O93/VZyloD70+j1TC08nV35OS9x/KY3NqoBrnGvhX5r2+qNyS4H
        OL8rqQSdRQX5KiS2uFMc11sSQa2J73YBVw4OQf0pS44k5UL224UO9p7Xgo6pgxjJ
        W1g1YvEbQGr0Zw==
X-ME-Sender: <xms:qpJTXui9P-ESxQHWQI0LBhgMVPCVH-_TflmnM0T37CJ4nj8eXhQIeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegovehorg
    hsthgrlhdqhfeguddvqddtvdculdduhedtmdenucfjughrpefhvffufffkofgjfhgggfes
    tdekredtredttdenucfhrhhomhepofgrgihimhgvucftihhprghrugcuoehmrgigihhmvg
    estggvrhhnohdrthgvtghhqeenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhg
    necukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudenucfrrg
    hrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:qpJTXptRT016RRkMhbPQfof06Wfpic8DS3Pheb28o5RxhTaMcZ1pyw>
    <xmx:qpJTXuzKfIDjKvfhnyFsq8vH8PHwy67PHK6l2qfL59Ixa8tVZi1GGw>
    <xmx:qpJTXuYQ-EYI7Ph_T6fUEUFtwoVw5M2SOelNa6j3CuwQXXR9bbteHQ>
    <xmx:qpJTXqIMbS5I4ZHSFhuiDyYWNPNy0FtWfuosE_chf1Ddj-TKPAbvkKnsV_4>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2D4A3328005A;
        Mon, 24 Feb 2020 04:08:58 -0500 (EST)
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
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 06/89] dt-bindings: clock: Add a binding for the RPi Firmware clocks
Date:   Mon, 24 Feb 2020 10:06:08 +0100
Message-Id: <9166f3acdc2a64e3f3ca1cd2e283005ee2df37c9.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The firmare running on the RPi VideoCore can be used to discover and
change the various clocks running in the BCM2711. Since devices will
need to use them through the DT, let's add a pretty simple binding.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-clk@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 Documentation/devicetree/bindings/clock/raspberrypi,firmware-clocks.yaml | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/raspberrypi,firmware-clocks.yaml

diff --git a/Documentation/devicetree/bindings/clock/raspberrypi,firmware-clocks.yaml b/Documentation/devicetree/bindings/clock/raspberrypi,firmware-clocks.yaml
new file mode 100644
index 000000000000..d37bc311321d
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/raspberrypi,firmware-clocks.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/raspberrypi,firmware-clocks.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RaspberryPi Firmware Clocks Device Tree Bindings
+
+maintainers:
+  - Maxime Ripard <mripard@kernel.org>
+
+properties:
+  "#clock-cells":
+    const: 1
+
+  compatible:
+    const: raspberrypi,firmware-clocks
+
+  raspberrypi,firmware:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: >
+      Phandle to the mailbox node to communicate with the firmware.
+
+required:
+  - "#clock-cells"
+  - compatible
+  - raspberrypi,firmware
+
+additionalProperties: false
+
+examples:
+  - |
+    firmware_clocks: firmware-clocks {
+        compatible = "raspberrypi,firmware-clocks";
+        raspberrypi,firmware = <&firmware>;
+        #clock-cells = <1>;
+    };
+
+...
-- 
git-series 0.9.1
