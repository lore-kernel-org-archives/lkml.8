Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6A3C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECB5B20767
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L0AntvfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbgDWSLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 14:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730163AbgDWSLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 14:11:00 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452A8C09B043
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 11:11:00 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s18so605271pgl.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 11:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hoJh63kKG0D1+kAjjOCcewUCrHwScAwF4fHmVhu3yEY=;
        b=L0AntvfFKEA4nZ8QFmeepfjDCUe1xnSA9QJTsWXvTnYODCycIN8mNS0gJEzeGP1bSm
         wAKsdRcfKn9KaXt/gq8ndbLWHH2gdqKsRHAnbuE0qS/y1T1uJTkskpHaDDwLp/nRJBwE
         Pz48JtbiG88ZSUwUhkb6gOIErAL4odG5iY1q0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hoJh63kKG0D1+kAjjOCcewUCrHwScAwF4fHmVhu3yEY=;
        b=iskie/QT3dv7f1rPUONh+1g5m25yJhc4SHfiQf+IBQ3eVZUsVlkzaoXcjLPMIUfXy4
         PnM67yc0IDSTSTBsPq2NTMJqGTBd4ABypwUcvF7CVEn9GbDU338s8+8iDoZltgqCdyr8
         mqVDrwAj7Bx7nxVnkqZ8x3IWBW/I0YlAFHhBA5zwr8Ao4rr2Yo8wjdu3FyoMKrQDpsju
         3fnbeqt+ouCDQm+KizsQr2HqigFhoft8hv4x6EqGUP+r1JmQpE+8Wv/ZlxZr0wKAyM1K
         mIUIvELpXRVGAxW9u31OsPbbZCA0Zo0a8qHCnE4PbISh8DIrLfS2ACY/8hGJtftamib2
         nI9g==
X-Gm-Message-State: AGi0PuZoFis9JITWD6b9KzJFU0Iltv63snmnTL58oQ4ieWDu8G9CR9tM
        s/07MqTOcp/HvsxWhe0dIOSw3g==
X-Google-Smtp-Source: APiQypI8KmAiqWhTqcfvYHF1yYC3JCBs4eDoNyXAdnzNlAEdjbJVyLX6yor26Tit0MPP0rQlJBaAjQ==
X-Received: by 2002:a62:e306:: with SMTP id g6mr4896489pfh.182.1587665459750;
        Thu, 23 Apr 2020 11:10:59 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id u9sm2858156pfn.197.2020.04.23.11.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 11:10:59 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Sandeep Maheswaram <sanm@codeaurora.org>, mka@chromium.org,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: phy: qcom-qusb2: Fix defaults
Date:   Thu, 23 Apr 2020 11:10:27 -0700
Message-Id: <20200423111015.1.Ifa8039b6f3031e9a69c4a526a6efc2f499f07292@changeid>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The defaults listed in the bindings don't match what the code is
actually doing.  Presumably existing users care more about keeping
existing behavior the same, so change the bindings to match the code
in Linux.

The "qcom,preemphasis-level" default has been wrong for quite a long
time (May 2018).  The other two were recently added.

As some evidence that these values are wrong, this is from the Linux
driver:
- qcom,preemphasis-level: sets "PORT_TUNE1", lower 2 bits.  Driver
  programs PORT_TUNE1 to 0x30 by default and (0x30 & 0x3) = 0.
- qcom,bias-ctrl-value: sets "PLL_BIAS_CONTROL_2", lower 6 bits.
  Driver programs PLL_BIAS_CONTROL_2 to 0x20 by default and (0x20 &
  0x3f) = 0x20 = 32.
- qcom,hsdisc-trim-value: sets "PORT_TUNE2", lower 2 bits.  Driver
  programs PORT_TUNE2 to 0x29 by default and (0x29 & 0x3) = 1.

Fixes: 1e6f134eb67a ("dt-bindings: phy: qcom-qusb2: Add support for overriding Phy tuning parameters")
Fixes: a8b70ccf10e3 ("dt-bindings: phy-qcom-usb2: Add support to override tuning values")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
index 144ae29e7141..f8bd28ff31c1 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
@@ -97,7 +97,7 @@ then:
         - $ref: /schemas/types.yaml#/definitions/uint32
         - minimum: 0
           maximum: 63
-          default: 0
+          default: 32
 
     qcom,charge-ctrl-value:
      description:
@@ -130,7 +130,7 @@ then:
         - $ref: /schemas/types.yaml#/definitions/uint32
         - minimum: 0
           maximum: 3
-          default: 2
+          default: 0
 
     qcom,preemphasis-width:
       description:
@@ -152,7 +152,7 @@ then:
         - $ref: /schemas/types.yaml#/definitions/uint32
         - minimum: 0
           maximum: 3
-          default: 0
+          default: 1
 
 required:
   - compatible
-- 
2.26.1.301.g55bc3eb7cb9-goog

