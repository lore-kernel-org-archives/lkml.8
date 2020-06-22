Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0853C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CF122073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ptebOAxv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgFVTTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 15:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728072AbgFVTTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 15:19:35 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7EEC061798
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 12:19:35 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id d67so16634652oig.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 12:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WpdygEuxEbkEHwJ7Dc7yTeQc0s6WGpubIGVPN8hUzwI=;
        b=ptebOAxvDdaND1bSmx+wZ0WhkMUfYrP4NqBlrOz/GpBppJcuw1tk1uUy+i7V13LWhH
         s0UO1oY/AyHU1T/Es4lhiqpz/RTShFaacDb8lGR3pSwZrh7MofFAUI/EqnOYVXe4t2Vd
         e9BO75ciF7zO40MPLegW44aW1clYneJChKo7/X1FP82k9qBXRNfvUITgoPUu3uTmGvSD
         0bb1wdoHI4Crq6siiscGwkg7P5q82flpWWOjbGiIYYwwKrjm2R7Gn/WQlwGuymzSRRhG
         Ra5XQz37tzPKUX9cQB9FnfaVIs4mo4danY29Wz9XyFTbnXqtNCcrpBNjG9O1zpkXRYex
         G16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WpdygEuxEbkEHwJ7Dc7yTeQc0s6WGpubIGVPN8hUzwI=;
        b=da0YI4+ecrCtZd7dDIcyYlRQ50xrKz/KXHivHu++NN7jyosSWOUDBdjq/tsDX2CTvN
         TiDmhDpSzavUJzo7kulnDvUYXCq4LbnaxWIaJJjbcPmP/KjrMVz7c4UyKwXt0Qg1O8gh
         BNaGZPcQzg5XVxbi5vC8ucobMaVBPj+U5wRiS0jTN9epLChlzkFM57Ns/ODdSCd3tTk2
         UqrCu3UvkfGUhdhxx9rBc8GnJCl7JN/xq7ua49K4CK/pfcDkS0izPzsM+bvYFTDXcEwv
         IzIZ3TvRjdeeebg0+jm4ZY0zIvyvqH0MOoVJLVeiOXI64P1d1JmrXAUsHN1gk5CkR2Ap
         Oj6w==
X-Gm-Message-State: AOAM533MwUWxKodT+5BcChEjqHf7M9IGOmSsWSxOGgbrHDNNkxTNooQN
        6aBnQp6cB5k2oQuMD57gL7oBEQ==
X-Google-Smtp-Source: ABdhPJxCQJjXXe3MeYjxEJNBUioEcpD4vOcB90cUSGsvH5+8BuzTtqMKADCuuOeTccITGNegZeaqow==
X-Received: by 2002:a54:4d96:: with SMTP id y22mr12894021oix.55.1592853574476;
        Mon, 22 Jun 2020 12:19:34 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m84sm3348294oif.32.2020.06.22.12.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 12:19:33 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v7 1/5] dt-bindings: remoteproc: Add Qualcomm PIL info binding
Date:   Mon, 22 Jun 2020 12:19:38 -0700
Message-Id: <20200622191942.255460-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200622191942.255460-1-bjorn.andersson@linaro.org>
References: <20200622191942.255460-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a devicetree binding for the Qualcomm peripheral image loader
relocation information region found in the IMEM.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v6:
- None

 .../bindings/remoteproc/qcom,pil-info.yaml    | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml
new file mode 100644
index 000000000000..87c52316ddbd
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/qcom,pil-info.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm peripheral image loader relocation info binding
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+description:
+  The Qualcomm peripheral image loader relocation memory region, in IMEM, is
+  used for communicating remoteproc relocation information to post mortem
+  debugging tools.
+
+properties:
+  compatible:
+    const: qcom,pil-reloc-info
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
+    imem@146bf000 {
+      compatible = "syscon", "simple-mfd";
+      reg = <0x146bf000 0x1000>;
+
+      #address-cells = <1>;
+      #size-cells = <1>;
+
+      ranges = <0 0x146bf000 0x1000>;
+
+      pil-reloc@94c {
+        compatible = "qcom,pil-reloc-info";
+        reg = <0x94c 0xc8>;
+      };
+    };
+...
-- 
2.26.2

