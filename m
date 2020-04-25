Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980BEC55191
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 17:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 741BA206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 17:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4JzYTSp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgDYRIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 13:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726146AbgDYRIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 13:08:42 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291F8C09B04D;
        Sat, 25 Apr 2020 10:08:42 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x4so14740132wmj.1;
        Sat, 25 Apr 2020 10:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=O1616GdJZQwMAYCstXMQMO+mfdnUnYcAiAdqWMQMdCk=;
        b=j4JzYTSp3PtLbLbdxcMK87wTyBA+cZ9QfDr8XV3TqsDzR2+kzS0Thq0j4qF6+KhnwD
         IxkXuVSgY+8xgG+zJPuIeQg4Z2vDQiIT8YdYB8qJCICmhw2XZJgLGhC8pW2KTQ30UnvX
         hSicDM9OkRCqIoKETGn428fQxa/T6bS2DIHZvssE6ZumH4i8Qg/36eFvQceQJw1BS5dQ
         RFxaawFiG8yK71Ig4F793o4iV8/Gf3F3o6tzuYu/7YvWSp++XqnqLyQlQpX4vuFJm/Ik
         8PXvxpO4gXICnXdJN3zj8WK9i2ilkslQMO1i5n8tGbhl6IEiKWi/pGD33gsrMe960Bv0
         qVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O1616GdJZQwMAYCstXMQMO+mfdnUnYcAiAdqWMQMdCk=;
        b=H7W/94ObsOlHcC2g3rFCvgL8gUozgBtuO53Pw6kao66s6oLPo6mW/tVSV+lBvQ1f9l
         4LKs+jsFSKxRmR3n6xbfPa7sgVlq1iq3/MGIQ9mOBZhX8bEAT4HXTV/CJix48ilKGd/J
         KBt2xGL1fpk4fpr6LC5jRn9FDLKSzdOz0MgY98qmn2IDL+1zVLw31UG6Y8Z5wEWh/mXV
         yOweEEGtKJwuG2T6ttdmbn9FKp+Lb7Rr4OTP3PHLkec9Yx0urTYf+MPMhbmh6DWT/aww
         USvoA0JL7Mo+UcHGATVQW4kuYrBEI0odj8MQTz62L8LDLLI/F9TjzRRunHdk2J+tpLCA
         n7XQ==
X-Gm-Message-State: AGi0Pua/1BkHgyd5rI4wKShp7KTp+uhYW6AQmME+g56AhAAtk+zYOP20
        SOpdAVyBvVF+8x/0nZYAFwE=
X-Google-Smtp-Source: APiQypJ0HdhWPnrZxWn5tl/nMOJwIvph3SNIW4dQKPyjSEoo+S9vKcobegz/uTrZe6sqeXJ61115cA==
X-Received: by 2002:a1c:9d84:: with SMTP id g126mr15715568wme.184.1587834520927;
        Sat, 25 Apr 2020 10:08:40 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id t67sm8549717wmg.40.2020.04.25.10.08.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Apr 2020 10:08:40 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: usb: dwc2: add power-domains property
Date:   Sat, 25 Apr 2020 19:08:33 +0200
Message-Id: <20200425170833.26718-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives this error:

arch/arm64/boot/dts/rockchip/px30-evb.dt.yaml: usb@ff300000:
'power-domains' does not match any of the regexes: 'pinctrl-[0-9]+'

With the conversion to yaml it also filters things
in a node that are used by other drivers like
'power-domains' for Rockchip px30 usb nodes,
so add them to 'dwc2.yaml'.

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/usb/dwc2.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/usb/dwc2.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc2.yaml b/Documentation/devicetree/bindings/usb/dwc2.yaml
index fb2f62aef..9352a8ef6 100644
--- a/Documentation/devicetree/bindings/usb/dwc2.yaml
+++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
@@ -78,6 +78,9 @@ properties:
   phy-names:
     const: usb2-phy
 
+  power-domains:
+    maxItems: 1
+
   vbus-supply:
     description: reference to the VBUS regulator. Depending on the current mode
       this is enabled (in "host" mode") or disabled (in "peripheral" mode). The
-- 
2.11.0

