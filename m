Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CEBC35642
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3022071E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cH/zAuRy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgBUHtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:49:09 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42600 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729201AbgBUHtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:49:07 -0500
Received: by mail-pg1-f194.google.com with SMTP id w21so550319pgl.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 23:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=InvFUNRiPxXOxYMHgJ0FZcGWdDLWenQO6uankp4X5co=;
        b=cH/zAuRygLTMG5vrXLh0wRpvYslN0/4eyqLnEeEXbOuFqjKLYJZ4wXZDafrsK1t2nD
         NJPOaztBE/WnSneu7MnJ/S+IOwRQyQQr8k4Ysq/Fe445TcDqi8e4KnNr61GGsd3Lmaeo
         tD4eRVCtWw8s5Pwg4fJWwjXl2ERLdyccnuofZ7HliCVa73JDx1Se5x16ep5dxSj2g/AG
         xKdwewHFN4V61X4jt/SiKOpjN7xyDxk6tMK9LJO31uwxfiR4ufK3S45/prJwzfdlMY8l
         qdJWX8NRes7TGzzfZtTDFHAm6C5kTlrVofd9xCXLx+wlOXQK20RRzEkyBKSPixaFxxuH
         FDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=InvFUNRiPxXOxYMHgJ0FZcGWdDLWenQO6uankp4X5co=;
        b=UJgACDOGcRd96QyJV/OZnJ8lHSnlGIMS0EkWRr4fG+bZzxbJVla8y0X+yPmOj0LbSI
         e+xXQm5KwikUb9nLTwDZSdIuosp0pGARYHTYY4rZIgAw5S0+GR5AL4bHxA6WFRoP+bvo
         aS+tcqBvCfOOOGuxS9D5lYZC5pMurPPBM9PKd3kbikhBtLwfEWATm2WG771ZR6A+QLSf
         IiMRcSDkYSqVI0EoKj55Z4WFHKNmBZ7QpXjUkTXow+YXneboeUCTchg3/j4QwkVPCkIk
         H/06GAWtTUVM74CH9zHJ9oqT2oHS3RAUuMyHl6O0dtka5y/b42E03UXNmk5+UIuKRFXI
         vMaQ==
X-Gm-Message-State: APjAAAUCb/YpOoQ7qHS87Hivo/dF69Wot+CEIZlNg+RVuUuQQVWPYY0X
        126xk0mgJgi/B8/9ZzDEdeM=
X-Google-Smtp-Source: APXvYqzrktlCrULOant8+rekVokatvRDsgDVLBnEil8PQxbkujjyDkYWFqsKwTCWKS7ERFp5nwkHUQ==
X-Received: by 2002:a63:42c2:: with SMTP id p185mr39122753pga.268.1582271346641;
        Thu, 20 Feb 2020 23:49:06 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id d1sm1444653pgj.79.2020.02.20.23.49.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Feb 2020 23:49:06 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH RFC v3 1/6] dt-bindings: display: add Unisoc's drm master bindings
Date:   Fri, 21 Feb 2020 15:48:51 +0800
Message-Id: <1582271336-3708-2-git-send-email-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582271336-3708-1-git-send-email-kevin3.tang@gmail.com>
References: <1582271336-3708-1-git-send-email-kevin3.tang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Tang <kevin.tang@unisoc.com>

The Unisoc DRM master device is a virtual device needed to list all
DPU devices or other display interface nodes that comprise the
graphics subsystem

Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Baolin Wang <baolin.wang@linaro.org>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
---
 .../devicetree/bindings/display/sprd/drm.yaml      | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sprd/drm.yaml

diff --git a/Documentation/devicetree/bindings/display/sprd/drm.yaml b/Documentation/devicetree/bindings/display/sprd/drm.yaml
new file mode 100644
index 0000000..1614ca6
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/sprd/drm.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/sprd/drm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Unisoc DRM master device
+
+maintainers:
+  - David Airlie <airlied@linux.ie>
+  - Daniel Vetter <daniel@ffwll.ch>
+  - Rob Herring <robh+dt@kernel.org>
+  - Mark Rutland <mark.rutland@arm.com>
+
+description: |
+  The Unisoc DRM master device is a virtual device needed to list all
+  DPU devices or other display interface nodes that comprise the
+  graphics subsystem.
+
+properties:
+  compatible:
+    const: sprd,display-subsystem
+
+  ports:
+    description:
+      Should contain a list of phandles pointing to display interface port
+      of DPU devices.
+
+required:
+  - compatible
+  - ports
+
+examples:
+  - |
+    display-subsystem {
+        compatible = "sprd,display-subsystem";
+        ports = <&dpu_out>;
+    };
\ No newline at end of file
-- 
2.7.4

