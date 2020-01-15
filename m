Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0054AC33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C322465A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h2avPzgt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbgAOONw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 09:13:52 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39944 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730328AbgAOONa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:13:30 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so15890767wrn.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 06:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=utrms9phUtFiuVDkbSHkMcIIB+hqEFiylLVtYFCLs98=;
        b=h2avPzgtHS2x2OYDax1t4VNWKLqty6XA4E9ZjqJab0pKdQByRf1PEj7tqgfbT1rFOC
         +tENLeDKBOT8PQfZQe4cJQdhBk5tDerzipgC46tWGHbhhRloQqY8NwK1VT/2R2mK4Kzn
         HnmQjbZbdO0t1U07yQe5h3IcPXYY7KVs51OCDTYJ7FEJa/dKyH7I0jB53geercfQdC7X
         NBdP4Gr+LnIaavxzM3YZP+XkJUNe5G7KuTt9eLSjyv7pVluSs06/y2ulrPilSIYBrFtl
         asFezWef6PblRiEpOXxP1wUQcQHrUtHDJm5iDEE6KAyGtXOMq1YXk3HbGOAsY1DGaaTT
         WNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=utrms9phUtFiuVDkbSHkMcIIB+hqEFiylLVtYFCLs98=;
        b=jfeN9Xp94hST1raJdgO/3CPXOKOvLqEKgR6VpzllrcRVPXBtaqmje6dNIkYve86y8G
         djZUKFGp96YicVVmVihJCybygRvueoeTioDcFasa/FyN5o7dtcQ+kDOFhFdyCKcTkXgC
         cjvVSaFMBzyXp0DHVAimjOwJTLQtQUBCBCCS2njEyJYRQEYNRkwo2yWYgI5sm36BdAHL
         +x9zWINK8RsijwM4UCzknIgC7s59JF+AeXapmdgU02lQWYNjFQ1iHfOIDdbSYKgcKy2Q
         0chd9CWczasLlVqPvP7qK/ZiOrZ+ShrVkit3kq6uTXtmy8MqfU1hS/THwGe3GTvhmims
         glBw==
X-Gm-Message-State: APjAAAV8WGGNH9QZZhIjDMu4ckMmzXeJ0JRFbhI6y974rf7FKfEUtUd0
        2xxvsb53jRCh/5YR67SAzmSk6w==
X-Google-Smtp-Source: APXvYqyTuamJ9fHx0PYuc9zHO/uCqxLay9MiZeaYDixnvT9qgiT7T1DxVJet5UBmYWb5t8PaSKTN9A==
X-Received: by 2002:a5d:6a8e:: with SMTP id s14mr32360617wru.150.1579097608303;
        Wed, 15 Jan 2020 06:13:28 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id m21sm23730720wmi.27.2020.01.15.06.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 06:13:27 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH 17/19] arm64: dts: qcom: qcs404-evb: Raise vreg_l12_3p3 minimum voltage
Date:   Wed, 15 Jan 2020 14:13:31 +0000
Message-Id: <20200115141333.1222676-18-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200115141333.1222676-1-bryan.odonoghue@linaro.org>
References: <20200115141333.1222676-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than set the minimum microvolt for this regulator in the USB SS PHY
driver, set it in the DTS.

Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Andy Gross <agross@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index 01ef59e8e5b7..0fff50f755ef 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -199,7 +199,7 @@ vreg_l11_sdc2: l11 {
 		};
 
 		vreg_l12_3p3: l12 {
-			regulator-min-microvolt = <2968000>;
+			regulator-min-microvolt = <3050000>;
 			regulator-max-microvolt = <3300000>;
 		};
 
-- 
2.24.0

