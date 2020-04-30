Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A005C47253
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 18:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01BEE20731
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 18:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L+/38IZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgD3SBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 14:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726285AbgD3SB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 14:01:29 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A18C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 11:01:29 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t7so2543882plr.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 11:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C0Yze1/IavdG5gy4jtW1GeNJSvg2I9EP1FDFnBHu0wY=;
        b=L+/38IZbHQhw8T0IEXSfBpOcGMhxgd4r+su+uW/4Wv3ZlRfjby6gzR3fp62u3Ez+1c
         YCCjU7fPazg5eY0f+w/Fe2u47AvrwiKeL805UqjHV74oqzx28Bjb6VkzcDPrI+rO7V6m
         GoBxUOzHjAhTunRsreZls4p/bmZgYDdEZ2MRDJ0v86Kp7NZzcjS8LBPzBKJXFMuE+eHQ
         yFR+dnrmyeRJicZJb0dQNNu8ojm3DJfhwAmsIj2muLHiup4AE1Wru0W7lD3vgNqruJPZ
         ijYoiR3WRCDcHseZOHXamHepQPlVeSqIl91tMuxykYpmtXRdCj/E1uF08PKqHHEXkI5p
         9BXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C0Yze1/IavdG5gy4jtW1GeNJSvg2I9EP1FDFnBHu0wY=;
        b=fMrfciWX6LWQAyR3c0yCtesgplQK1Bpxs1YpQpJLr4v7wFbvJwcitS3VwqNBmwKmBv
         P09/CwpZxIpjvPP51nU0a5RY/81o/ltzVFRmx0MB4N3bqNFrwU7SA+nF/hpW28P3lwYa
         eNyi6rTYc5nQ6DIrM5jv7ktom/dKOjCSQY4NBuGhkUDQWtiiQ2y1J/FjJ7jnytsMC+30
         vEt5Nb30e/2SBcB1Xx40wK6R+mvciqU6tjs2TiZFqlS0o5q8dwXKeeRp3H9YfREwpPeI
         1Gf9tVngipO1UUq2d63xsu+d2qUKC+8lYh7hyR+l38XNV+IE3M67u28FDsvnIdfum+in
         SuHQ==
X-Gm-Message-State: AGi0PuaPEZgpePMSktZOmND/ct47OtWY+ZBVEVh3WPDo22J79moo/ncJ
        GBJXZYtDxS9s100s9FpISHRhrg==
X-Google-Smtp-Source: APiQypKHYL1gUtj6Z9vxDjxgBdu/Hcis3QIeB8G/ahhZn63CN3tK+qdhIbUuX4NhcFMhnN2OuQbSpw==
X-Received: by 2002:a17:902:56c:: with SMTP id 99mr203208plf.124.1588269687924;
        Thu, 30 Apr 2020 11:01:27 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id o68sm357741pfb.206.2020.04.30.11.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 11:01:27 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v2 1/2] dt-bindings: remoteproc: qcom: pas: Add SM8250 remoteprocs
Date:   Thu, 30 Apr 2020 11:00:50 -0700
Message-Id: <20200430180051.3795305-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SM8250 audio, compute and sensor remoteprocs to the PAS DT
binding.

Reviewed-by: Sibi Sankar <sibis@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Changed adsp power-domains to lcx and added missing lmx

 .../devicetree/bindings/remoteproc/qcom,adsp.txt         | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
index 9938918b2fea..c18c1b8d2869 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
@@ -21,6 +21,9 @@ on the Qualcomm ADSP Hexagon core.
 		    "qcom,sm8150-cdsp-pas"
 		    "qcom,sm8150-mpss-pas"
 		    "qcom,sm8150-slpi-pas"
+		    "qcom,sm8250-adsp-pas"
+		    "qcom,sm8250-cdsp-pas"
+		    "qcom,sm8250-slpi-pas"
 
 - interrupts-extended:
 	Usage: required
@@ -44,6 +47,9 @@ on the Qualcomm ADSP Hexagon core.
 	qcom,sm8150-adsp-pas:
 	qcom,sm8150-cdsp-pas:
 	qcom,sm8150-slpi-pas:
+	qcom,sm8250-adsp-pas:
+	qcom,sm8250-cdsp-pas:
+	qcom,sm8250-slpi-pas:
 		    must be "wdog", "fatal", "ready", "handover", "stop-ack"
 	qcom,qcs404-wcss-pas:
 	qcom,sm8150-mpss-pas:
@@ -105,10 +111,13 @@ on the Qualcomm ADSP Hexagon core.
 	qcom,sdm845-cdsp-pas:
 	qcom,sm8150-adsp-pas:
 	qcom,sm8150-cdsp-pas:
+	qcom,sm8250-cdsp-pas:
 		    must be "cx", "load_state"
 	qcom,sm8150-mpss-pas:
 		    must be "cx", "load_state", "mss"
+	qcom,sm8250-adsp-pas:
 	qcom,sm8150-slpi-pas:
+	qcom,sm8250-slpi-pas:
 		    must be "lcx", "lmx", "load_state"
 
 - memory-region:
-- 
2.24.0

