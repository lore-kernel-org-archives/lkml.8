Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4682AC47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21EED216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FoPvLdc2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgEAVqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 17:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbgEAVqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 17:46:33 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4482AC08E934
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 14:46:32 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id g26so5214906qtv.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 14:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7feKFMGg4GPGIWvo5qLBoNVV6FQKy+Rod2p/i6GH6LU=;
        b=FoPvLdc2DRWZKrxVhNrrfD3gQQjINc9Mx91B7hF9oRDGkECJOhZGg7mYlYiBi/CxUm
         X38TPhcbJBAj8tQa2226QjwoC1B162RMPg5rynuh8S++MSmP773m1KhmhobndysMJIgI
         KGyefw2SGNpvrw9JCpJNU/zmsC03yAb8P3rkaQNRxh7L04EXPfMmFkmZ3dymoJrUTqWT
         zB0e0o/abeN90jQqred927YOzTWIzK2UZv2UXmaOHAaA1I1v9UGe4Lv5Q2w1yezH/WtT
         m56b47X/FOX4j63jA0IDHzc7CDKBPO+W2+7YCCEP0fX9gnYi11qfe5vIOkdtBRJo21W6
         Vd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7feKFMGg4GPGIWvo5qLBoNVV6FQKy+Rod2p/i6GH6LU=;
        b=q2WQeD34InEQKKGc0GLXYS1yDD0V1oxMs+sxvTk9sVn1cOYY4SkNNRWMefiZcXYSrg
         mZDqf4tRq6E8rO3t/6IrRUqA30JdmpGig9332SPXDm4TM2nJLT0v8C+4eazGUdZRQxbZ
         V0F1oiYh8pYSrsYu+KFjqZU+ROqIWh09bSux3N2ZN3rcFIgC2j7Ir3vq6K842myhvf+N
         C1yAzLki/+KqzPyBhlGkZ1arK+yw0x2GcZ0yRTJ51U7dZhs8LV3GC6QmGcymEuRBfYgy
         08Zd6gRcqlS6qV8O7YlvQZVos2oMqxTkHhXAzwhN8iMGMuR4UTpUcnUI+GpvhjYCiNux
         nlQQ==
X-Gm-Message-State: AGi0PuYuWHqid6hvoYsk/CJhCDEzQZyDRBy4lCgvOicwCHhy3rH2fxno
        zf8OcWXHvrUMSm8oSUpXwokscg==
X-Google-Smtp-Source: APiQypKFhQRa4VjEaoeR/o7gsskZE9XQbrTzrYQKw9zJNHa0WlH2UqhRXODOpcTtlPjqQZ1JgKGprg==
X-Received: by 2002:ac8:4818:: with SMTP id g24mr5998881qtq.377.1588369591468;
        Fri, 01 May 2020 14:46:31 -0700 (PDT)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id z18sm3470982qti.47.2020.05.01.14.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 14:46:31 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net
Cc:     evgreen@chromium.org.net, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        agross@kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH net-next 1/4] arm64: dts: sdm845: add IPA iommus property
Date:   Fri,  1 May 2020 16:46:22 -0500
Message-Id: <20200501214625.31539-2-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200501214625.31539-1-elder@linaro.org>
References: <20200501214625.31539-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an "iommus" property to the IPA node in "sdm845.dtsi".  It is
required because there are two regions of memory the IPA accesses
through an SMMU.  The next few patches define and map those regions.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 8f926b5234d4..de6bb86c4968 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1761,6 +1761,8 @@
 
 		ipa: ipa@1e40000 {
 			compatible = "qcom,sdm845-ipa";
+
+			iommus = <&apps_smmu 0x720 0x3>;
 			reg = <0 0x1e40000 0 0x7000>,
 			      <0 0x1e47000 0 0x2000>,
 			      <0 0x1e04000 0 0x2c000>;
-- 
2.20.1

