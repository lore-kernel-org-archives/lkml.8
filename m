Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842D1C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62B7420835
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="Ge5jW0Vt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391090AbgE0Q0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 12:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391082AbgE0Q0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 12:26:31 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EA3C03E97D
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 09:26:30 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id l15so29337944lje.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 09:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UXNKy8jVJwlU/17I/sp/ZybyCHSHUdutcafty8yAdEU=;
        b=Ge5jW0VtYLWqqDMma/nbdlBeZpgeTS8vtyAZANj2XX3yg3QXM4AHiQqZ79WgDG4p5N
         YYKeV6ZzDTUJNuuyBhxJVb9VhMc20YOZ0I9cGRXfT5bQzsYVA+KM0pjeCRuPIKJVf9ue
         32NVd6UQF14HMD9zTznW93ut95FvH6d4I2JhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UXNKy8jVJwlU/17I/sp/ZybyCHSHUdutcafty8yAdEU=;
        b=BKYlJuj+LWLJ2/4jafb8JRLZCnt7HDMtCkQIseB8USCQmlZBl5Tv3M9JLwZIsXdiBP
         kpiJLzisLmR+spwccYK9AJMiujveEzLpKwG+3pZx69J6Afjxi5EMp652HU4YAVyjAPrB
         uxjZLmqAzVPxgcRyJCBFOrGn6ekfeHgII5IKF8x8jv6yjJPXiqqUDUbkpG1pEu6CB/KS
         +LX9Z0OE9pCp/jzxFaN8gmPxxpQ5GJ4XoGQ1V4E2Eh1cn8Ndg6owIBlgwLg9++Mm7l13
         iN3PHTq4MYFGRbxhrkvX+IEU0djfITh9qJYLvYo/j5waolOXQnvOWBBxP64exCNnaUB5
         HHhw==
X-Gm-Message-State: AOAM531ReK+blLvErTxorofiELNHLJCo0h8sxq07TzOQI4WfBCWGtbsk
        WcISSKktiFOkmOcmYAtU5/1fxA==
X-Google-Smtp-Source: ABdhPJxrDY64t3dA74/QpqFRt+tUdSXEoElVweoLpPPzc2MKtUL05JqbDXfV3yOj9N5L53ZeVE2z3w==
X-Received: by 2002:a2e:9acb:: with SMTP id p11mr3286893ljj.432.1590596789302;
        Wed, 27 May 2020 09:26:29 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id n14sm895937lfi.97.2020.05.27.09.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 09:26:28 -0700 (PDT)
Date:   Wed, 27 May 2020 18:26:23 +0200
From:   Mateusz Holenko <mholenko@antmicro.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc:     Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Filip Kokosinski <fkokosinski@antmicro.com>,
        Pawel Czarnecki <pczarnecki@internships.antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, "Gabriel L. Somlo" <gsomlo@gmail.com>
Subject: [PATCH v6 2/5] dt-bindings: soc: document LiteX SoC Controller
 bindings
Message-ID: <20200527182545.3859622-2-mholenko@antmicro.com>
References: <20200527182545.3859622-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527182545.3859622-0-mholenko@antmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pawel Czarnecki <pczarnecki@internships.antmicro.com>

Add documentation for LiteX SoC Controller bindings.

Signed-off-by: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Notes:
    Changes in v6:
        - fixed license header

    Changes in v5:
        - added reviewed-by tag
    
    Changes in v4:
        - changes compatible to "litex,soc-controller"
        - fixed yaml's header
        - removed unnecessary sections from yaml
        - fixed indentation in yaml
    
    This commit has been introduced in v3 of the patchset.

 .../soc/litex/litex,soc-controller.yaml       | 39 +++++++++++++++++++
 MAINTAINERS                                   |  6 +++
 2 files changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/litex/litex,soc-controller.yaml

diff --git a/Documentation/devicetree/bindings/soc/litex/litex,soc-controller.yaml b/Documentation/devicetree/bindings/soc/litex/litex,soc-controller.yaml
new file mode 100644
index 000000000000..b118ddbf04a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/litex/litex,soc-controller.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+# Copyright 2020 Antmicro <www.antmicro.com>
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/soc/litex/litex,soc-controller.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: LiteX SoC Controller driver
+
+description: |
+  This is the SoC Controller driver for the LiteX SoC Builder.
+  It's purpose is to verify LiteX CSR (Control&Status Register) access
+  operations and provide function for other drivers to read/write CSRs
+  and to check if those accessors are ready to use.
+
+maintainers:
+  - Karol Gugala <kgugala@antmicro.com>
+  - Mateusz Holenko <mholenko@antmicro.com>
+
+properties:
+  compatible:
+    const: litex,soc-controller
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    soc_ctrl0: soc-controller@f0000000 {
+        compatible = "litex,soc-controller";
+        reg = <0x0 0xf0000000 0x0 0xC>;
+        status = "okay";
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 7b58ca29cc80..39be98db7418 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9835,6 +9835,12 @@ L:	kunit-dev@googlegroups.com
 S:	Maintained
 F:	lib/list-test.c
 
+LITEX PLATFORM
+M:	Karol Gugala <kgugala@antmicro.com>
+M:	Mateusz Holenko <mholenko@antmicro.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/*/litex,*.yaml
+
 LIVE PATCHING
 M:	Josh Poimboeuf <jpoimboe@redhat.com>
 M:	Jiri Kosina <jikos@kernel.org>
-- 
2.25.1

