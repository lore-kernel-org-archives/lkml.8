Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACC3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 05:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0971A2078C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 05:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P/u5REte"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgGJF3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 01:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727911AbgGJF3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 01:29:42 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC31C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 22:29:42 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id k71so2126125pje.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 22:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gVIUeXQMCzWAcTP6WaAZI7/yPZyluiCjZUpguitY3Jw=;
        b=P/u5REteL/HeTai6cE+dPZwjiV9k45Y4NLnHY/lfDl47b/TH7IYwoItVnpyoWNzEwM
         6JGv23tEcx6U4hePPsyw74Hfjs2Yz9Neipt4eposDrzASCdglgWRr34EkrHURio4/qBj
         Z3xvQf4yms3QgpM6rQLSnnbaDQKSrZhPBW33tEZtZutBTBjXkxuhYhB9m/jgYjc+losm
         lNkfdM8XoGwpuf53dV5pDb7JLFt2TgVPvvUJlz7iPpTEbrohj4aPWL9vSVMagftZLgvA
         n4PQN7OYSdeEdD2wNWJE48CX4FacFMVW5rUOPU4xi9fEh7zodbFDNJabUL9mNXtQabka
         wRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gVIUeXQMCzWAcTP6WaAZI7/yPZyluiCjZUpguitY3Jw=;
        b=N9NJXeh1PsfnRQMKzeODvXLuKDsxKHZB08R88jZ6/KRdbTrFYSxqiFWOa0eOJXlujX
         wwhgi/R2r6eFHcZkdrOfRbzGwS24grFspLUDF5PPj0ptYFkmiuda53AiTeVtmOVk1ufn
         M7xA9JTAOk6KnkkXVMNcdaobNmMm42C3OkrzVYQ8G3qs0WiY3uFN6Pl1QvHUcLYkNN3t
         i0rqaF+st4k0Cg9+DO/4qshKe+4HVDboPO040VW0uRvrtLW78GZ1dto3R9AHoXpiCe3c
         MQNlgWIroE6dMPS01AsIDS8zO5+VzgsXQHvS0YrRyrRSGbW57KGATMj7wRaHjG1GRtZY
         AgEQ==
X-Gm-Message-State: AOAM531o0p2EGWXLlcNlFddCy76a45TyjqsU5yFWemRBYkqMmK8FBw8y
        JrE6hYBpI60PB3dH3AqYXMHkmQ==
X-Google-Smtp-Source: ABdhPJzIuQ0yZotGXpNCWaIQ1/eS9a2x8OHmZ8rZCozWUj5XQgvP6wsYMa3AmkDZBQsnw+5EmhUdww==
X-Received: by 2002:a17:902:44:: with SMTP id 62mr57666397pla.104.1594358982126;
        Thu, 09 Jul 2020 22:29:42 -0700 (PDT)
Received: from nagraj.local ([49.206.21.239])
        by smtp.gmail.com with ESMTPSA id j17sm4168320pgn.87.2020.07.09.22.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 22:29:41 -0700 (PDT)
From:   Sumit Semwal <sumit.semwal@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org
Cc:     nishakumari@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kgunda@codeaurora.org, rnayak@codeaurora.org,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [RESEND PATCH v5 3/4] arm64: dts: qcom: pmi8998: Add nodes for LAB and IBB regulators
Date:   Fri, 10 Jul 2020 10:59:18 +0530
Message-Id: <20200710052919.2611-4-sumit.semwal@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710052919.2611-1-sumit.semwal@linaro.org>
References: <20200710052919.2611-1-sumit.semwal@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nisha Kumari <nishakumari@codeaurora.org>

This patch adds devicetree nodes for LAB and IBB regulators.

Signed-off-by: Nisha Kumari <nishakumari@codeaurora.org>
Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
  [sumits: Updated for better compatible strings and names]

---
v5: sumits: removed interrupt-names, since there is only one
            interrupt per node
v4: sumits: removed labibb label which is not needed
v3: sumits: updated interrupt-names as per review comments
v2: sumits: updated for better compatible string and names
---
 arch/arm64/boot/dts/qcom/pmi8998.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pmi8998.dtsi b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
index 23f9146a161e..d016b12967eb 100644
--- a/arch/arm64/boot/dts/qcom/pmi8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
@@ -25,5 +25,17 @@ pmi8998_lsid1: pmic@3 {
 		reg = <0x3 SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+
+		labibb {
+			compatible = "qcom,pmi8998-lab-ibb";
+
+			ibb: ibb {
+				interrupts = <0x3 0xdc 0x2 IRQ_TYPE_EDGE_RISING>;
+			};
+
+			lab: lab {
+				interrupts = <0x3 0xde 0x0 IRQ_TYPE_EDGE_RISING>;
+			};
+		};
 	};
 };
-- 
2.27.0

