Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC24C4BA0E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A5024673
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeKjXayP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgBZJqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 04:46:34 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38268 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbgBZJqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 04:46:32 -0500
Received: by mail-pl1-f194.google.com with SMTP id p7so1078911pli.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 01:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LtPS2nzq1tAOLqZda6KKJ8wN5FQTazZ++gCBndbcBJ0=;
        b=KeKjXayP8+wjxcJF5q9JgwImADDMC9QYCMDkDGJ8ZiTKeG2OBzb+LE5BI//zi51/6G
         Inb9mLRsu1AUztEVuiNRP6ML/S49gyZePcXDaobwIDQE61CkYV1Wj06O90UpHVxCRXGq
         hipb/3naFhgjba/1WlA5+tKZZ7Gr7b/+yz31X963XSIzeB6Ja7JhUdn9ZheP6mmvFP9m
         4bc7pZyQaResx1mStDdADtT+rriypyUResnpCFhITd3811BQjI6XVjD1o8kQH/u3K0FN
         /ZX2ph0FaeqmCXaq1KD6DnU/QiHCfW2x73OWVl2yCRi5Ff/NK5lKA3uUtp4lBZr9ec9+
         olqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LtPS2nzq1tAOLqZda6KKJ8wN5FQTazZ++gCBndbcBJ0=;
        b=GmewZzlWsjoowIElS68+np3w4j0avyEpkGAwtHxAQup3NhHM/y6I5sj5hM3lve0zno
         +CygF+41OtdHMzmXdhtj2ynoyVaU3N+/JOpQU9TD99i5gzyJvQMzaSacRNW9P2rVhbWa
         XHdy6EzG7AkQpZ2/lC3wgI8jVP0f+piFPUNbs5FWD49UCdfBRlPB1DnsZ2RneXfqVYiH
         Xp2qCfp3WnjU4JBH10pkupnYXXMD75yi3oFjBGYUaeiCMs9lPu/uYru6JXhBfbh/TNbc
         dXP7xoLuMnFl0LSHyusOtPxl2TCAi5EjRVz35RWeSjYMcQ3oyzfTWncydiCCpjJNAAYD
         nj/g==
X-Gm-Message-State: APjAAAWYiGDetTQVTKmp7wTnPoBFXwvPBUeXNIjSkh9vFL3Ol/c7WN8O
        x1q0vGBArYFtOQ5CEBapN4g=
X-Google-Smtp-Source: APXvYqwpR/0PX/4hNZ6fE6I0l9u/8V2rSMFV5ao/qEk8R4A4Ryw2HUEuZKtrOzpksvDU/KvG084X0w==
X-Received: by 2002:a17:902:b090:: with SMTP id p16mr3098690plr.337.1582710391529;
        Wed, 26 Feb 2020 01:46:31 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id h185sm2276518pfg.135.2020.02.26.01.46.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Feb 2020 01:46:31 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH RFC v4 1/6] dt-bindings: display: add Unisoc's drm master bindings
Date:   Wed, 26 Feb 2020 17:46:12 +0800
Message-Id: <1582710377-15489-2-git-send-email-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582710377-15489-1-git-send-email-kevin3.tang@gmail.com>
References: <1582710377-15489-1-git-send-email-kevin3.tang@gmail.com>
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

