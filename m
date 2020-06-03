Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8951C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7F6220829
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFh28SEI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgFCPnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 11:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgFCPnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 11:43:43 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0D9C08C5C0;
        Wed,  3 Jun 2020 08:43:43 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id j8so2728972iog.13;
        Wed, 03 Jun 2020 08:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Hp0r2xPnJNrha2DVieLRioPgVG67WvOK9q2U4d3AFHc=;
        b=MFh28SEIZjKIYeTS80r07x+w06bvc1UCEKGMOjk0KHFvIIlbCuO422TotrvXhE0mOu
         ryVPWQhyUuvGkkEp71ZcHvYE4CigstOKWyNDU0Govmn4wSeZDEOYebIVVpIff0xlgmmF
         q52W1f2NBZefYBh50hFBUiG7wKEy8Z/YVRf+U21LzCgKuZnErN/KGTZqHPuAsX4WYc4X
         Vhhx54YLg0frMCcCk3JzL+miR/BADdRhJJZrKm5/NyY4LkUpClQskG+cojjoXlUgvjiH
         GKxjLgf2oHPYx6zXL6rGVM9/RoOLKtAzr+f7mRuJFAW5qmK2zxgsV4a7XD6XmNvtNGd7
         ZSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Hp0r2xPnJNrha2DVieLRioPgVG67WvOK9q2U4d3AFHc=;
        b=EKa4Z64HS5evGLp5IR6oX32ZKrXheKCAUoE8MGG7D/siwvmgfXdPwwPQ0hbD52dWwu
         P4EYDDJjyU0a8qGNA2emtSOyiqgUScB8y6MALDu7xpgdHUoCUHV3liPh+SuaLjZNe0b2
         vYVSElwJx+zXG2h+zbems+ShSjTlfXJ3KRCCECRWrbwnyHRuYl6hIDIVFEZ/XtU5fX4+
         4flwq66Cmp3yvjtGj12HVDru+Msf93srUk9mTKJDpMB33a3+6Jpp97CW0RT9znIGPsbQ
         4TGXEtR8wAMtPH5MxAzSb2geXS+t3eXO2z/n1I1oYrMUhplSL94tBUDT8OlpdiObsErU
         /oyw==
X-Gm-Message-State: AOAM5327BwZCHTdknVhf36ZnYlM1A3VZINFHdDgneJtHkssxW5Yu/2+M
        V1TmNdQ9HkU03n4l2ib7Hd1drTKy
X-Google-Smtp-Source: ABdhPJwsnQ72Fvrna00tnTvxOZZ8L8lkwgQMAioS/xu3IHnWU2WUl+mCzyHwnBaJ7jXzwSP4dFQJYw==
X-Received: by 2002:a6b:f911:: with SMTP id j17mr301135iog.139.1591199022484;
        Wed, 03 Jun 2020 08:43:42 -0700 (PDT)
Received: from aford-OptiPlex-7050.logicpd.com ([174.46.170.158])
        by smtp.gmail.com with ESMTPSA id l26sm1237027ild.59.2020.06.03.08.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 08:43:41 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     Adam Ford <aford173@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/3] dt: Add additional option bindings for IDT VersaClock
Date:   Wed,  3 Jun 2020 10:43:28 -0500
Message-Id: <20200603154329.31579-2-aford173@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603154329.31579-1-aford173@gmail.com>
References: <20200603154329.31579-1-aford173@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VersaClock driver now supports some additional bindings to support
child nodes which can configure optional settings like mode, voltage
and slew.

This patch updates the binding document to describe what is available
in the driver.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
V3:  Re-order binding change and driver change so biding comes first.
     Move all binding related changes to this patch.

diff --git a/Documentation/devicetree/bindings/clock/idt,versaclock5.txt b/Documentation/devicetree/bindings/clock/idt,versaclock5.txt
index bcff681a4bd0..6165b6ddb1a9 100644
--- a/Documentation/devicetree/bindings/clock/idt,versaclock5.txt
+++ b/Documentation/devicetree/bindings/clock/idt,versaclock5.txt
@@ -31,6 +31,29 @@ Required properties:
 		- 5p49v5933 and
 		- 5p49v5935: (optional) property not present or "clkin".
 
+For all output ports, a corresponding, optional child node named OUT1,
+OUT2, etc. can represent a each output, and the node can be used to
+specify the following:
+
+- itd,mode: can be one of the following:
+                 - VC5_LVPECL
+                 - VC5_CMOS
+                 - VC5_HCSL33
+                 - VC5_LVDS
+                 - VC5_CMOS2
+                 - VC5_CMOSD
+                 - VC5_HCSL25
+
+- idt,voltage-microvolts:  can be one of the following
+                 - 1800000
+                 - 2500000
+                 - 3300000
+-  idt,slew-percent: Percent of normal, can be one of
+                 - 80
+                 - 85
+                 - 90
+                 - 100
+
 ==Mapping between clock specifier and physical pins==
 
 When referencing the provided clock in the DT using phandle and
@@ -81,6 +104,16 @@ i2c-master-node {
 		/* Connect XIN input to 25MHz reference */
 		clocks = <&ref25m>;
 		clock-names = "xin";
+
+		OUT1 {
+			itd,mode = <VC5_CMOS>;
+			idt,voltage-microvolts = <1800000>;
+			idt,slew-percent = <80>;
+		};
+		OUT2 {
+			...
+		};
+		...
 	};
 };
 
diff --git a/include/dt-bindings/clk/versaclock.h b/include/dt-bindings/clk/versaclock.h
new file mode 100644
index 000000000000..c6a6a0946564
--- /dev/null
+++ b/include/dt-bindings/clk/versaclock.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/* This file defines field values used by the versaclock 6 family
+ * for defining output type
+ */
+
+#define VC5_LVPECL	0
+#define VC5_CMOS	1
+#define VC5_HCSL33	2
+#define VC5_LVDS	3
+#define VC5_CMOS2	4
+#define VC5_CMOSD	5
+#define VC5_HCSL25	6
-- 
2.17.1

