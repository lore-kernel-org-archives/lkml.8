Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A45C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF1D1207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvYwRU0l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbgG1KIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728509AbgG1KIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 06:08:09 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E67C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:08:09 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u185so10662327pfu.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zjj/ZeDz/jw+vTXOY4hvHXse1jncYmPhmvnsKqVknJ8=;
        b=QvYwRU0lt/Na4sLAvRuuhIUVECA0amQyooQJpmVAzOqVnn2eMUhXePXNhvHNilIkXn
         WHSGvjx+6lKqwSjCxJflh77f50Gl9o/uvHjlSctuL2bfS/ylXfE/Pbk6A2Ou2fP/zLx2
         AkkZ48ECyHTiPZ4GiJ1vrQfc3FPrdcUcTVKGLzgMPUtOg8L3i9TeFBoGbEv6OMzYETdg
         ExBZeVpTdCrUi1ec68wPmXgRoGbNH9Q6h0PTo+/fmNyqmZwEZ8tK/ul8QCQk/ZWZf0nu
         mWvuQw//BuJV4qfto10RqoDuLKvEghZJdX9eMl4L7ws15ArxgRYdPFPxpsnBoWnE1HND
         zzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zjj/ZeDz/jw+vTXOY4hvHXse1jncYmPhmvnsKqVknJ8=;
        b=HQ2/aDXoXNu5tGZLabr619y2AXppB+CuI23kGSIsbLBv6u+Z9Hgw4dUDsPcbqtTJOO
         URA6AT3TE6wQW8NewgeQEoqjDTjeHMGxeiUPNN0F2wXoPJ18TDcmMtz+8hS8xILxg2Ia
         gUzPPXRvIjNXYGEYb5ZKxEDjR/vGhsGxVDLcDS2zv31zbxl5COfuKekkqvxgivzK+Zgy
         pCDHVxXA0SqhcXXSCG0y345xVrILbia5UTih2Hvn/xkq+bqu1iTqXiBeYGQ4KcXC2u5Y
         BNWcn9SM5buF5Ngl0zJSK7BEg+bfJv+XdMQ8L5AT1ZrUMWfw1NO4Z/z6yghhoypKddr/
         E3LA==
X-Gm-Message-State: AOAM532zG6OsHk6/JE54avc7z01y5d5AihEbJBzMl48s47mdsHC+pqg9
        TnYQ1wDI3qpG8XfiIUc5bEc=
X-Google-Smtp-Source: ABdhPJwjfEDyNm2mxgsk4s1CeMrOdYb48jXr9vv3UKMmlRT4apon39t1dz5OlLuc5+BZErOWtVCMTw==
X-Received: by 2002:a63:2146:: with SMTP id s6mr23551943pgm.411.1595930889173;
        Tue, 28 Jul 2020 03:08:09 -0700 (PDT)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id e76sm1704593pfh.108.2020.07.28.03.08.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jul 2020 03:08:08 -0700 (PDT)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH RFC v6 1/6] dt-bindings: display: add Unisoc's drm master bindings
Date:   Tue, 28 Jul 2020 18:07:54 +0800
Message-Id: <1595930879-2478-2-git-send-email-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595930879-2478-1-git-send-email-kevin3.tang@gmail.com>
References: <1595930879-2478-1-git-send-email-kevin3.tang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Tang <kevin.tang@unisoc.com>

The Unisoc DRM master device is a virtual device needed to list all
DPU devices or other display interface nodes that comprise the
graphics subsystem

Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
---
 .../devicetree/bindings/display/sprd/drm.yaml      | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sprd/drm.yaml

diff --git a/Documentation/devicetree/bindings/display/sprd/drm.yaml b/Documentation/devicetree/bindings/display/sprd/drm.yaml
new file mode 100644
index 0000000..b5792c0
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/sprd/drm.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/sprd/drm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Unisoc DRM master device
+
+maintainers:
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
+
-- 
2.7.4

