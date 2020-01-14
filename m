Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F58C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF6F24670
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IQMFSASc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgANJsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 04:48:14 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40420 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgANJsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 04:48:14 -0500
Received: by mail-wm1-f65.google.com with SMTP id t14so12894266wmi.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 01:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Av6R897MwPJYaUFbeySb8X+lrEgD6Ka/Lapd1oVQYxQ=;
        b=IQMFSAScN6150muQWE3TPyVLfIYy0czJHjwNWVAgkyvZgWPfBZ+eHuwWrjU1XkCaIP
         DK/TXzdz1mtJgYtcji134GMFQefvifRjx7TqE8h36Lj4HSs/GsBOaYILyJehZmDsajIg
         t9uAfiqDLs4MKErEtIrh9nKww4ji7pd2U1GEXPelhtjGAVG6ICG1HLRphdUhdUxFITFg
         Z1BdJJu8eGpHBCF/WmOeTlFtACpLVc0Ue6IhkfuXapPqfUjR94BFfuGBrkLNGJiCO0Rk
         6+ZZBu7YwK982Nr0ckvTTz8CjmqNjbQ4TK77dvdEQJo2QWw0Zb4T0Z3ivkC4LyB/u3tC
         FHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Av6R897MwPJYaUFbeySb8X+lrEgD6Ka/Lapd1oVQYxQ=;
        b=uAHvt2HbKqvI9xMxBFLKSZnJkUkJhH0EXdC/n/LVHL9GJHa9pbeApEHM6uxkMVzTJC
         9pQfRm91hUWuakO4prNrJ7b6K4WcRLO1zi10AjwBPpDynBpsqkvHtvderKZmLg6WybBr
         bEmS6dlxcMWPFjoI5ShdNrBhDtMuk1WcU1OXXayg5EivWJfxy8jMBDzJ6FocKSa3QV0r
         lD8XHdZlcPJTFcIA5Lyx8XxFSucBCJL5PUJVCkS19MGJsW4sluIbNs03G7/fxQvbeAXs
         dx3rkR4+0fU54i2PGEloL+2ntGZWXryZnFoSkZ9P3Dcvf9BjgW1S7gtfLTdwOaTRAkas
         AlIQ==
X-Gm-Message-State: APjAAAVcHxVK1Ul335TBgQzhSD0GTNFPwNEpj/XVQP74npzsiIQxJbIE
        O69j9M818BaDddAFpIVSbQsGnw==
X-Google-Smtp-Source: APXvYqxf5aQ6H3nRjfBxIr795lLJZTMPfkO87+3kIpo/fctg5qDkW97JHna4R1IxAedKKdSVGpwsXQ==
X-Received: by 2002:a7b:c851:: with SMTP id c17mr26738795wml.71.1578995291824;
        Tue, 14 Jan 2020 01:48:11 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id k16sm19277659wru.0.2020.01.14.01.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 01:48:11 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org, robh@kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] dt-bindings: soundwire: fix example
Date:   Tue, 14 Jan 2020 09:48:06 +0000
Message-Id: <20200114094806.15846-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As wsa881x schema mentions #sound-dai-cells as required property,
so update soundwire-controller.yaml example so that dt_bindings_check
does not fail as below:

Documentation/devicetree/bindings/soundwire/soundwire-controller.example.dt.yaml:
speaker@0,1: '#sound-dai-cells' is a required property
Documentation/devicetree/bindings/soundwire/soundwire-controller.example.dt.yaml:
speaker@0,2: '#sound-dai-cells' is a required property

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/soundwire/soundwire-controller.yaml     | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml b/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
index 1b43993bccdb..330924b8618e 100644
--- a/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
+++ b/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
@@ -69,6 +69,7 @@ examples:
             reg = <0 1>;
             powerdown-gpios = <&wcdpinctrl 2 0>;
             #thermal-sensor-cells = <0>;
+            #sound-dai-cells = <0>;
         };
 
         speaker@0,2 {
@@ -76,6 +77,7 @@ examples:
             reg = <0 2>;
             powerdown-gpios = <&wcdpinctrl 2 0>;
             #thermal-sensor-cells = <0>;
+            #sound-dai-cells = <0>;
         };
     };
 
-- 
2.21.0

