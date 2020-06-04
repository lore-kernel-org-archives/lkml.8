Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F86C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 10:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF60F2088E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 10:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="cUHBio21"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgFDKOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 06:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728218AbgFDKOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 06:14:11 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8816BC03E97D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 03:14:11 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id s1so6573824ljo.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 03:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GKI9f+wljRQ2bu2SCyIYzWUkBbEcdk6KmefvDDgkdUc=;
        b=cUHBio210vSBmUouL/ognVAIvIRivErICd0JHKYnbQOMc/TIyQWfJM9IlVI+ppFpIb
         FdX1H6kvjPrVc/8uy73SSs6qNybmam4pDYxxwwFdsfsWfYwpQl7No8eFAES7qry94CyV
         UNpR83yLpoOZWK0JH4pb+EcsOQYjailkWgIFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GKI9f+wljRQ2bu2SCyIYzWUkBbEcdk6KmefvDDgkdUc=;
        b=te4YSldwpqi88WQ2GfTRuYsQNqhMBNdJHPhsdR5yMhRF4+ZYbC5S165Hsi5bQ01mGN
         JvDMdVOROMmMjxHRkKI2PBJw3L9CglwSwBtwZMYPrcVqiUwVlZeudFdh7Oo4UpozIVdV
         I90xfTQDuF6Ng1Y+JsM4iUpkmJwAnLjmxoxr6n0fhYWcpbNT37c0nKof5z2tIgHTxkJa
         rqwUjQAJOmzMAZ7N0QqcIcF7okrRmKehfZtTvnbEoFU07tQ6mRJYDl5/sOUT4rX5NYwt
         1W1dtJzR3UtQ7V/zPDOFm48l6piInevPhFGgn3vb9O4pdczKDHljTj/gnB00nFjucq7n
         iQXw==
X-Gm-Message-State: AOAM530Ux3vJioIDLFpg1ZZUXdV0mRJOBzNkTtmksqbpLdXCs3XaJY29
        QNnZ2WQ6UHHsuuLEvpoxTRUdow==
X-Google-Smtp-Source: ABdhPJwsTwnipMP/V0HhlzvKGAObXRF/0JSDWsDsgc/WUwfA7esD6rLv8o77P6u6nvV2uBIkyoW+CQ==
X-Received: by 2002:a2e:7610:: with SMTP id r16mr1897830ljc.88.1591265650032;
        Thu, 04 Jun 2020 03:14:10 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id v28sm1101730ljv.40.2020.06.04.03.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 03:14:09 -0700 (PDT)
Date:   Thu, 4 Jun 2020 12:14:04 +0200
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
Subject: [PATCH v7 4/5] dt-bindings: serial: document LiteUART bindings
Message-ID: <20200604121142.2964437-4-mholenko@antmicro.com>
References: <20200604121142.2964437-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604121142.2964437-0-mholenko@antmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Filip Kokosinski <fkokosinski@antmicro.com>

Add documentation for LiteUART devicetree bindings.

Signed-off-by: Filip Kokosinski <fkokosinski@antmicro.com>
Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Notes:
    No changes in v7.

    Changes in v6:
    - fixed license header

    No changes in v5.

    No changes in v4.

    Changes in v3:
    - added Reviewed-by tag
    - patch number changed from 3 to 4
    - removed changes in MAINTAINERS file (moved to patch #2)
    
    Changes in v2:
    - binding description rewritten to a yaml schema file
    - added interrupt line
    - fixed unit address
    - patch number changed from 2 to 3

 .../bindings/serial/litex,liteuart.yaml       | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/litex,liteuart.yaml

diff --git a/Documentation/devicetree/bindings/serial/litex,liteuart.yaml b/Documentation/devicetree/bindings/serial/litex,liteuart.yaml
new file mode 100644
index 000000000000..87bf846b170a
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/litex,liteuart.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/litex,liteuart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LiteUART serial controller
+
+maintainers:
+  - Karol Gugala <kgugala@antmicro.com>
+  - Mateusz Holenko <mholenko@antmicro.com>
+
+description: |
+  LiteUART serial controller is a part of LiteX FPGA SoC builder. It supports
+  multiple CPU architectures, currently including e.g. OpenRISC and RISC-V.
+
+properties:
+  compatible:
+    const: litex,liteuart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    uart0: serial@e0001800 {
+      compatible = "litex,liteuart";
+      reg = <0xe0001800 0x100>;
+      interrupts = <2>;
+    };
-- 
2.25.1

