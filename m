Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810A3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 21:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F0C22083E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 21:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BfrhqJod"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgERVsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 17:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgERVsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 17:48:45 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10484C05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 14:48:43 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id n14so12136588qke.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 14:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N4f7sy046N4O9Xu2U7ii9VWzSrJHNeqxjMTUXW3SrmY=;
        b=BfrhqJodaQneMVl3aAmmSjNLriVaIoX98o9ucrt6CzSWOfGHpzpdl7hgCo1EzUVxHm
         KTwcG62mdu40SqfZw1cqveHX85FlhH+hZnn+Ge9gwijeStWuVa8rUswsmFidxrzIE+eF
         Vi/vsOwykYR2yms5K9ALkYzMOWLhFTp5srjffz0fKSPYjQcGOl5y5Z+jZfl9xy3wL2+E
         cJ+V6al5qTWWAlpQCz/58b/JQ9HUFcpUU6ORXyze9zysx7a+ZD1DKNmhmPj0aGDkP6gM
         ZRwNVFNiwvRKLaoRD6/6Y6xra2ampmGK1hi/k35kFEtZO9mHTEOeCfWtwLRsUfshgOE+
         WLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N4f7sy046N4O9Xu2U7ii9VWzSrJHNeqxjMTUXW3SrmY=;
        b=BsbpniQDPAR4vUgBJS62rWwWkZ130T4hrdMS/a+kWUJ9e1Kv7d5c69/+HcGY4KSbx2
         4NcWeeQryv52AYpPNCn7w63nNqF9zzweVsSGdqHrmaZFd2l8yalEoluvRrgJ6rNVldDr
         ETMuifiNBN6+KNZio82SOXr5npushSP9bzvHJ8hiK4hcKp7FLesBsSvk/2/mtsUxdwib
         fTNaTZMttRnpnC+42Ab4LMhrvQ8FKnrlKtpmeiuH5hFgZerq+9ROCvOAl5MyBPQL+lkz
         m1IGFZxjLEWigTYYQ3ookFOChKT/OFCtgo9rSZptn33Ur0BWC7kNEtTZavaqzLJBuBp0
         /Qmw==
X-Gm-Message-State: AOAM530Oi4e/CjZvSX8EWeo2zdr/kHL9oHvy4FgUnGCAI9o7mikqwv9K
        lHlEdt4wXXVKnNoXsg/6TeJX/N5qTTQ=
X-Google-Smtp-Source: ABdhPJxItb/XfkXTmeN9EHeUdpMv27YwTIR0P3ktyb9EdTa5wklLsgpcsPUT4m8qZcqpNZA35vV8Rg==
X-Received: by 2002:a37:aa93:: with SMTP id t141mr17288698qke.65.1589838522233;
        Mon, 18 May 2020 14:48:42 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id l184sm9151468qke.115.2020.05.18.14.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 14:48:41 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] arm64: dts: qcom: sdm845-mtp: enable IPA
Date:   Mon, 18 May 2020 16:48:34 -0500
Message-Id: <20200518214834.9630-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable IPA on the SDM845 MTP.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index 1372fe8601f5..2f942daeb9d1 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -448,6 +448,11 @@
 	clock-frequency = <400000>;
 };
 
+&ipa {
+	status = "okay";
+	modem-init;
+};
+
 &mdss {
 	status = "okay";
 };
-- 
2.20.1

