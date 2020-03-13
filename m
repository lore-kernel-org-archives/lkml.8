Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AACC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 13:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B461206BE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 13:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNUHFVq7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgCMNXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 09:23:00 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37556 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgCMNXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 09:23:00 -0400
Received: by mail-pf1-f194.google.com with SMTP id p14so5234007pfn.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 06:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LtPS2nzq1tAOLqZda6KKJ8wN5FQTazZ++gCBndbcBJ0=;
        b=RNUHFVq7y2hg5vSljN8W7njUcYz6k4E624aImJVZAUupkuT2RbT00+OQpZfFy3dSzf
         kO6ATA88Fw/K53bJ5G90V9xqrqKgHyCf2KPMgcAy8n09oVoAckbTqjJrcIzlWlFdBt/H
         GO19OeiKlnSRDdSrQh5fWH4Qstyav+netGMUvro/uaqB4/Ur6Ky1FTqjApntoKiwR+gd
         JsBT16bHF2XKbQ7W9V57UYLjVQT+pvmM6xJprZchUlIol4qxiODNoiemmzTA3YTAtmHv
         DuUqeVxfqmaOw+hjiGIJe7tdHX7u24oYdpiZKPd2OR+FlmgK83dkpc5sQhmDdHJZHDE4
         oFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LtPS2nzq1tAOLqZda6KKJ8wN5FQTazZ++gCBndbcBJ0=;
        b=Nixn1tO4GtUSd0NXy07n/nJ+0PYBdI76AqTd/VEVGpIH3FKRpW4CloCnKrZRtxcxBH
         ej4isVjB0gZB8xw86OeCHkB+Qcldm1cbpk4lvdfzilj0+HDAoYfd1WW53dJ3fpA1BjFg
         2flRPUkeLEhDuKavb0ywATybpFvE62BABmSBRQlhEIRLtH+8ScaZ2vHESNHAqBBYhsIu
         T3aAgQcLL8TXZVKX3IlKjIlNEyjGuGRLOOpad0z468LcdPrC0aqmUHb+r/FNMWVVicuW
         8QNiNhQ5yDwHlk+wtqpta+1GZ+m95r4fBwBEpwtMxgE/DSIp7S1ErzdTZPITJHftnrg5
         g3xA==
X-Gm-Message-State: ANhLgQ2OMOqPk8zmqyIEaXKrkiuZMrbNzLmWUz3mfqCtMSsd+t+2Qo6/
        WewG/kwN7o8B9cDvsF1QSwg=
X-Google-Smtp-Source: ADFU+vspPjZ/gf1dZ/to1aekTTqBguSpk0OaFntppmsOUyXABeCazfg11vF2tTrFU2TmHkd8wje05A==
X-Received: by 2002:aa7:85d3:: with SMTP id z19mr13452629pfn.13.1584105779035;
        Fri, 13 Mar 2020 06:22:59 -0700 (PDT)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id y9sm21490296pgo.80.2020.03.13.06.22.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Mar 2020 06:22:58 -0700 (PDT)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH RFC v5 1/6] dt-bindings: display: add Unisoc's drm master bindings
Date:   Fri, 13 Mar 2020 21:22:42 +0800
Message-Id: <1584105767-11963-2-git-send-email-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584105767-11963-1-git-send-email-kevin3.tang@gmail.com>
References: <1584105767-11963-1-git-send-email-kevin3.tang@gmail.com>
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

