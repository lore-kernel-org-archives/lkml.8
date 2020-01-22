Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EF7C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 18:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC4424656
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 18:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z81j9cQc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbgAVS4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 13:56:39 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37184 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729268AbgAVS4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 13:56:36 -0500
Received: by mail-wr1-f66.google.com with SMTP id w15so247619wru.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 10:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LUSoU/XhVbuFFL332MrsGCHzak9+7MGgmls9JTYC/Cw=;
        b=Z81j9cQc59ByCvqGfgPVf5SYC2nDMYVoOYsp+gZF6bE5tX+7eRQlm5cwL8Vol7FxF9
         r8/baY1Y7xQum/um/I91ep+Z8NR+VNLuSoOLHo71qAymEDVvJLcPATcaEjtSUeMQMshj
         H4ThNKetDK9/ZLn0RSHm/tCiezmmFmGk20Vn5xPw/JFfJL0WMwDNNX895/citXV1JxT6
         yY8grBkoc2PEMfc6frdUNOy42m/oo6/CghAMPCQzDXBuOvYusXAISaR4uy35Avt9dslK
         PQH9ZROroVlWO7ywB1HpfwK7es4eDYOo3NsflzgCkZ4vob21K7bDqe+3c92/ItLmHaGF
         T2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LUSoU/XhVbuFFL332MrsGCHzak9+7MGgmls9JTYC/Cw=;
        b=dNX/zvF5tfpbuLj6wIo97dIw8/yCSZK5yzBqWzRso/6zmXkdSgqupzIY7eMLAfMsdp
         XnrSW/B3aPTovQ0JV4cc8vOKpIZXJvTb2pFwSopUePoF7P5hblXwxfx5TS5+LasOVtN6
         U5FTes4AX95gIl6UmGgrVPwwX0XlfBYy5bo8M41xZ2R54XqhcXFSZm4de0e4FPEd3/2Q
         YJCmZuvoSYIY8fmcwzdzQ7J2W8qfgrSPhnbnRM9lLQflSeQ9ZFIZlr9ic1Q/1YNjiypc
         h5rJn+NxDJVjGTpgODKJEmQHkCOT+HMxcNamEoKux4lTh0s8OFf+FL05WxcVJdpM1zbB
         G77g==
X-Gm-Message-State: APjAAAUKww34+sZ2cLkRC6vnw1I5uBsYtX3RHKY1cLJUVOWtCYn5EevE
        Vo8wmH+n9RjrtXq0BoyeqgarWw==
X-Google-Smtp-Source: APXvYqzRjZpoadQq8kfDamN1yJIgXYj6ibo6BkWwx5fH7am5l4OrnMyYThfzLWfguyV6rr/QOYK6Kw==
X-Received: by 2002:a5d:6206:: with SMTP id y6mr12491477wru.130.1579719394659;
        Wed, 22 Jan 2020 10:56:34 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id q15sm58590390wrr.11.2020.01.22.10.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 10:56:34 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v3 18/19] arm64: dts: qcom: qcs404-evb: Enable secondary USB controller
Date:   Wed, 22 Jan 2020 18:56:09 +0000
Message-Id: <20200122185610.131930-19-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122185610.131930-1-bryan.odonoghue@linaro.org>
References: <20200122185610.131930-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables the second DWC3 controller which has one USB Hi-Speed
PHY attached to it.

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index 0fff50f755ef..07d6d793a922 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -318,6 +318,17 @@ pinconf {
 	};
 };
 
+&usb2 {
+	status = "okay";
+};
+
+&usb2_phy_sec {
+	vdd-supply = <&vreg_l4_1p2>;
+	vdda1p8-supply = <&vreg_l5_1p8>;
+	vdda3p3-supply = <&vreg_l12_3p3>;
+	status = "okay";
+};
+
 &wifi {
 	status = "okay";
 	vdd-0.8-cx-mx-supply = <&vreg_l2_1p275>;
-- 
2.25.0

