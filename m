Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214C8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2FB62075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r0rg84zI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbgFVW2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 18:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730864AbgFVW1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:27:42 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA76EC061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 15:27:41 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id m2so14552187otr.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 15:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=np06MBoJ0AuPrMypeIwHblD2LOFOM+rqs7EtZrEx3Pw=;
        b=r0rg84zIbL8kV63uOUn5+t2IYIe5xGcfcJIXWWbnqpMFBmhHPYvLmbvKLz3bI49DpB
         9GCapPYUnEg2FOGhkvUKxsoUfr7PZ43oOihybXzLwMCVY5h2qfjTnQwjxeSfWIgQ26pF
         amaqn8BNJzRVInEJvpxSJI9ZPQpULYN+d1wZV0Z26Hk6moQY2PvJpfCRqKu7rSqFqwmI
         Z0Hec+pOHqbc+XQ3rSA9P7T3cyRbn7BCfoO8Ptf2Q9IiMBGv0o/t4dv9VrbqJ0WUxpdK
         AmTHI+baqgMXQcoVK3D9/RbbH7ALZISQb87ZFDRlTuZ67MZJTOd72f8KCBKtTVsECcag
         1UMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=np06MBoJ0AuPrMypeIwHblD2LOFOM+rqs7EtZrEx3Pw=;
        b=EpaQYbQE6LYgFWkyOJ0pk0aSJ/Y4Dq7uJDyO325kPB/i2s0zX9anNMePiBQeheW17w
         mg1irCmqq1U4huIU+cyxJsjT+DCAhE4/gxAKbMwClSqo0S27tg+j3nR3Sfh8xSMPbK2B
         W93gqsOYeNXFlGaz3RIriK0ZkT7xKhezWK+MR/LnfBbfbAPdugsTd9D3fGVpIbYYC1w2
         G/vmCr/gnnhuB13K/MpU0z2BL+owOQ7hFY75vzPSfnyMwrZbt4ZmwEHficxUG/fV5ZwZ
         Ei4XMAl6WNqPGovP4mZsekiLEcIEbeBa5qH1d9bFoW3HF4HdTVOz/fBMRrj/Nh3kKKXj
         WcCg==
X-Gm-Message-State: AOAM530+JyT6hM4unzfpUIp3zSiuAasopCKQnLWgtWn2sau7Z+8N/mB4
        gbwmpNXLfT4OkTu+eqRnV6XzhQ==
X-Google-Smtp-Source: ABdhPJyFaBDzpgqSiNBG+6lr3jq8HwxV1odT6pvGc+rG78De/yGfdOA1I/wF9744YHOjfDcVOHmURg==
X-Received: by 2002:a9d:aaa:: with SMTP id 39mr15107908otq.269.1592864861102;
        Mon, 22 Jun 2020 15:27:41 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h36sm3589304oth.37.2020.06.22.15.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 15:27:40 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/6] arm64: dts: qcom: sm8250: Add QMP AOSS node
Date:   Mon, 22 Jun 2020 15:27:44 -0700
Message-Id: <20200622222747.717306-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200622222747.717306-1-bjorn.andersson@linaro.org>
References: <20200622222747.717306-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node for the QMP AOSS.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 74a7ca96177e..246e6f279aa8 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/clock/qcom,gcc-sm8250.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
+#include <dt-bindings/power/qcom-aoss-qmp.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
@@ -989,6 +990,19 @@ pdc: interrupt-controller@b220000 {
 			interrupt-controller;
 		};
 
+		aoss_qmp: qmp@c300000 {
+			compatible = "qcom,sm8250-aoss-qmp";
+			reg = <0 0x0c300000 0 0x100000>;
+			interrupts-extended = <&ipcc IPCC_CLIENT_AOP
+						     IPCC_MPROC_SIGNAL_GLINK_QMP
+						     IRQ_TYPE_EDGE_RISING>;
+			mboxes = <&ipcc IPCC_CLIENT_AOP
+					IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+			#clock-cells = <0>;
+			#power-domain-cells = <1>;
+		};
+
 		spmi_bus: spmi@c440000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0x0 0x0c440000 0x0 0x0001100>,
-- 
2.26.2

