Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD635C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 06:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A912024677
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 06:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V1jmB1G5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgCJGfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 02:35:13 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:50856 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgCJGfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 02:35:12 -0400
Received: by mail-pj1-f67.google.com with SMTP id u10so11874pjy.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 23:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R9+Cz75X2xC9BKj2OQiTJ8bjAVhl/I7+7z1qVqyLDrM=;
        b=V1jmB1G5Zlkt0ryXphg23tulWUgLBoqk2rhFKHNbVsBmULNHNahNbtQvfwHnQ4k5Cg
         suhvai42EuD2RVxCidOf0goKxu5QLX3VPPpFjGY9IjXUQiOF3zEpiGj2lb2ZFopnXm4/
         mGQOrOHJVNNheEpS+uI5Ebb4fE1YLY2FFxXnBb9xHHG0N1k6U0HTsSPTxsNgbGAsaEly
         dd2KEAmWEaygTR71maEKvGLDo+ljqPWuVVq3Msqy2b5Z+yPRfcP4zJhm/irYg9oECXSA
         N+GZBgEJp+tBRBeHNoiA+wtuNkgFX4IJdxDMgoeSwi0vvX1vp6MGq73YhqzG7mcLj6iJ
         VM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R9+Cz75X2xC9BKj2OQiTJ8bjAVhl/I7+7z1qVqyLDrM=;
        b=j6luFdEV62nEvHusrzQWHU3LDWCHcOUo5K9iykH9voO/lilLsrIaBqbeq8uVfTUfmJ
         HOHgcZdDgfcz1z+tdtN2iZ45cB5Hr/7L1MGIWtBO5Yf/MMGA1Fyr+tBbtrHXCweBH9+x
         xQcM4FiM/G/Gu1dkI4KkNFj+Utoo4T0ZJ0yVjh2jgWaGIjAEwe01MwMQpZ3z/UyahRPc
         6nX0QvdfY+S0VRn8cjrq5iu2PH+oYQRP7x/ImSLZXjHj9qe5H87pumVF7u7EsC8xcsHe
         nDKVnP/VCp24rVCtPuR9F6+E/15dWEnPv7gCgYd6otXoNhfbbVg5G96RG4ZipJoRZqPZ
         xV7w==
X-Gm-Message-State: ANhLgQ3tI7V9VKEHzMnKDaUSyD2FWHlBq6LyAUQXxfLhNhGv/Bz7wV66
        HMvVoRw+1Pak6jI0nuQ66CYHbA==
X-Google-Smtp-Source: ADFU+vsrwfcreJGQ+JSaDzsnazWGtLpAqzN4oLxDhrwI8e8/gJeU2YtogiZdY8SY5DsYgbH7uyK/gQ==
X-Received: by 2002:a17:902:d70e:: with SMTP id w14mr18532590ply.181.1583822111887;
        Mon, 09 Mar 2020 23:35:11 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v8sm1388029pjr.10.2020.03.09.23.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 23:35:11 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v4 1/5] dt-bindings: remoteproc: Add Qualcomm PIL info binding
Date:   Mon,  9 Mar 2020 23:33:34 -0700
Message-Id: <20200310063338.3344582-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200310063338.3344582-1-bjorn.andersson@linaro.org>
References: <20200310063338.3344582-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a devicetree binding for the Qualcomm peripheral image loader
relocation information region found in the IMEM.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Change since v3:
- Fixed spelling mistakes pointed out by Mathieu
- Fixed description as requested by Stephen
- Specify unit address in example
- Add missing ranges in example

 .../bindings/remoteproc/qcom,pil-info.yaml    | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml
new file mode 100644
index 000000000000..44d87fd2a07e
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
+      reg = <0 0x146bf000 0 0x1000>;
+
+      #address-cells = <1>;
+      #size-cells = <1>;
+
+      ranges = <0 0 0x146bf000 0x1000>;
+
+      pil-reloc@94c {
+        compatible = "qcom,pil-reloc-info";
+        reg = <0x94c 0xc8>;
+      };
+    };
+...
-- 
2.24.0

