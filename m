Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B50C34050
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 13:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D30220801
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 13:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pgi+TBIf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgBSNhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 08:37:01 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40396 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbgBSNhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 08:37:00 -0500
Received: by mail-wr1-f65.google.com with SMTP id t3so557239wru.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 05:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=idNFPyAtkmq04AJWh7a0/gnkZseJQQBbr31aSDqpxTo=;
        b=pgi+TBIfgcN3kTkndoro2wO8PcZFOTmypoXoT9oPvzBxZMrgOYmFREyP3GAWSdSFA9
         W/vH5mTeEJe6txM2vOAQ6qcI5zMlhWbBDJBd2DseAl76AwuZqBKKQCYRDewdfbQw+GNe
         jmsusBY99uLMfYUT0ZBXI87iPS9HRDmepSofoFVnzq+oTg3I9o+n3eHIv7Bf0DJi1GS6
         vPhREp4T+t+eKJkx9tcRWI3GlCMwIaMz0UT0dco4O68gnMIfvLVfpoSoW8iZIvblHvJp
         Wi6RwXWNKVFscVbHLjzE9FpD2OBeVcieFINJ3GJD1KQlakxunb2k4k1KzbE2esIPCnde
         LE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=idNFPyAtkmq04AJWh7a0/gnkZseJQQBbr31aSDqpxTo=;
        b=ZYQLboPZ6a9xffouBU+69fS/KTc3zWYj6+n+Idq5jgXRcgXysVIJwoU+ZJMeCyBfhu
         c1AfgXAYDpiRNeejPCRtKMuhFAoeSSfco2CD97WPLyrs7lq72bUg5t8Bkgp9HD5hw3OG
         alrjaf6gaN6P1JR43Xkk1DrbMOVznalO1H3e+g9g6mJ7/uWSqbnmJOyNZwflXxCCe3J5
         kzZwNlH/RURfuPJvC9DkRdRgikjfZkdTyAL8I7gf0sZfI0ZnaVCy5jlwz8p+/J7FIXoi
         oNi221IJ+aKHHiVmNa/NZWhz/LhxEA6oMbbyDV5SyJu4Es/LMdEFdhYvHUJz/uOEIOSn
         rxog==
X-Gm-Message-State: APjAAAXaKPFGnCojY6aDe2FmzfN/KpMdE0PGpTVVA75OeE8ejsFAREY2
        W6Rt7QmJnQ2N1Gg6j5Tx9Ix5qQ==
X-Google-Smtp-Source: APXvYqwCdG6arwwkXKRGXknOCJ7az3kOoi5ADFVldBeUfvCD9Xrxom8biCGNQ4YGwzDvnmboPbXyrw==
X-Received: by 2002:adf:dd0b:: with SMTP id a11mr37802096wrm.150.1582119416706;
        Wed, 19 Feb 2020 05:36:56 -0800 (PST)
Received: from localhost.localdomain (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id q124sm8856480wme.2.2020.02.19.05.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 05:36:56 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 1/2] ASoC: meson: add t9015 internal codec binding documentation
Date:   Wed, 19 Feb 2020 14:36:45 +0100
Message-Id: <20200219133646.1035506-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200219133646.1035506-1-jbrunet@baylibre.com>
References: <20200219133646.1035506-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DT binding documention of the internal DAC found in the Amlogic
gxl, g12a and sm1 SoC family.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/sound/amlogic,t9015.yaml         | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,t9015.yaml

diff --git a/Documentation/devicetree/bindings/sound/amlogic,t9015.yaml b/Documentation/devicetree/bindings/sound/amlogic,t9015.yaml
new file mode 100644
index 000000000000..b7c38c2b5b54
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,t9015.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/amlogic,t9015.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic T9015 Internal Audio DAC
+
+maintainers:
+  - Jerome Brunet <jbrunet@baylibre.com>
+
+properties:
+  $nodename:
+    pattern: "^audio-controller@.*"
+
+  "#sound-dai-cells":
+    const: 0
+
+  compatible:
+    items:
+      - const: amlogic,t9015
+
+  clocks:
+    items:
+      - description: Peripheral clock
+
+  clock-names:
+    items:
+      - const: pclk
+
+  reg:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - "#sound-dai-cells"
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+
+examples:
+  - |
+    #include <dt-bindings/clock/g12a-clkc.h>
+    #include <dt-bindings/reset/amlogic,meson-g12a-reset.h>
+
+    acodec: audio-controller@32000 {
+        compatible = "amlogic,t9015";
+        reg = <0x0 0x32000 0x0 0x14>;
+        #sound-dai-cells = <0>;
+        clocks = <&clkc CLKID_AUDIO_CODEC>;
+        clock-names = "pclk";
+        resets = <&reset RESET_AUDIO_CODEC>;
+    };
+
-- 
2.24.1

