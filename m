Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C643AC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BECB24679
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3MBTdJX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgAUIvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 03:51:24 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39534 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgAUIvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:51:23 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so1044604plp.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 00:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=InvFUNRiPxXOxYMHgJ0FZcGWdDLWenQO6uankp4X5co=;
        b=a3MBTdJXqtlvKHgxE6X+zPUuhYOUm3tjJwTE9L1wRtHyaPUXEXJgq/kVXrMuwVMDpM
         PC4LVhSch3A+rJczDpBoVLWb/QDkC6OLDKN2xnGoluGRdFhLLMNO2axXI5pj+h/Qwz1N
         NHxAYQOhIAIcvqRh5ZWn3VjWwzzkcKlE+N+ed91b6dGb8RawqJBTY8kE4s/TCZfioOYO
         N0UEU6J55yPCv7+ch78JUbMeD4uT7rxE4uqJEaVmZRTT9duKk+wtamtfqorun9OCwdCF
         pAG2C5yQvc6lmKfLn4/Uth0y6nmWFP+Swkk7V6N14pg8ieBlLaIi7piZX3qIPl7iw74u
         uq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=InvFUNRiPxXOxYMHgJ0FZcGWdDLWenQO6uankp4X5co=;
        b=o6KUyFqmd8KjLPFWaPdFOdLR7/LFVj462gNaIcRFklr8hteJS+regPAsgU3aZfCRaR
         iuncbyNa+1G0lCVTlYCC2YSXTGmR0uMx53H5M3Fr1d8XnIMRWTiAzq/dCncFtaRuGtCH
         iiRbIZlV3AZfGc7/YEIs3QpNrBMhLd7u1GpUDGUSSYlfaxQXh9hGXXytkGErjbzGBeKx
         sElcn2xZYjDurS05H4VaWOXNExdBdHTzKfjsw2+nMMnh4LD19oqxh0FquKpYtgtgDl+t
         y4F7mISdejn11N00c9oabV2kM3coRaB45lb4raVwf1GCUnFSPbdt2JpKK8rRxm5fYUZU
         ABqg==
X-Gm-Message-State: APjAAAXVBrjwwHK4s/dPrAViEO5LVuEGN3F6YjrxJ/rQBSsbhEXCMDMP
        s707jpq7GHb9yQI+mQb9DfI=
X-Google-Smtp-Source: APXvYqwhsFdEe7Z6zpory3TxabU0PWCwAHasLLUAeGZhpZXoqCLwoXU7a5khdBNRts36cDnpZL0Z9A==
X-Received: by 2002:a17:902:d705:: with SMTP id w5mr4439295ply.68.1579596682873;
        Tue, 21 Jan 2020 00:51:22 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 80sm42820957pfw.123.2020.01.21.00.51.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Jan 2020 00:51:22 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH RFC v2 1/6] dt-bindings: display: add Unisoc's drm master bindings
Date:   Tue, 21 Jan 2020 16:50:57 +0800
Message-Id: <1579596662-15466-2-git-send-email-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579596662-15466-1-git-send-email-kevin3.tang@gmail.com>
References: <1579596662-15466-1-git-send-email-kevin3.tang@gmail.com>
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

