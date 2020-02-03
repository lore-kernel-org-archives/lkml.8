Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B48DC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA6742166E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jH9/4klu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbgBCSci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 13:32:38 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35110 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729991AbgBCSca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 13:32:30 -0500
Received: by mail-pg1-f193.google.com with SMTP id l24so8265716pgk.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 10:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5g1BX8oYOcgjo9pux5M5p2bLE7s9j8ECvjIyZHRTnQY=;
        b=jH9/4kluz76UNEEinon0dfMka4SAYZN1IDWt64qfM1HpWCST1rVre8ZLTVnySBrQE4
         r06F3cdXarrfXJbeH+c55smVRxDpXbI+4b0M3jlK4YWF8O9dGC/4TQ97lsUlI5mgSZgr
         N0cMvp3/6MYuTIjeZSCD36rwx5ScKvjo8aXsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5g1BX8oYOcgjo9pux5M5p2bLE7s9j8ECvjIyZHRTnQY=;
        b=DpyjCFqQGsJUOhxKBN0ewScyxQt5JAilrLn9RFIwq1o4hARY1txL3Hq+JiUYTiKzM7
         4tSQRlILuviplcvcDLS9tH3DC1TJfjklK8WvpCxwCO+d613/lPq5JqhzwEw7XsKtSt4J
         k2t6TfVoPApeMl9oyOhmX6Rx94JazJGkJm5BLQ4btNdflJ4j9MWyyzoqKpMrNL1e23fu
         bK3ZxzHNSoYt5uA6PS1QW6IBsWVfuFG6p26NxLh19jnkihQghOCbK3DS9IpLeo04cYyk
         fCbQIhYe2ON+r04jKMA5635/EHlmf9iQqkqYDwz0F4i5lhyKLRHyJDfVlMLMYeGgvRnI
         HiSg==
X-Gm-Message-State: APjAAAXm4kQ3j0SjxejLdrwgZRNWoqhYg1KNOIVkmz2Wp8oHI+cCAQVh
        eMOrA3ia7j1u0I8L17oPrAlhdA==
X-Google-Smtp-Source: APXvYqzTPiqHWb2iLW58b5qmzi+ONdPRjXdFJef+3ajjCtf9c5DeaPH9Qiwb5Hulf1bb3kru1zEZZA==
X-Received: by 2002:aa7:9567:: with SMTP id x7mr26097051pfq.133.1580754749735;
        Mon, 03 Feb 2020 10:32:29 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id f9sm21009137pfd.141.2020.02.03.10.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 10:32:29 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, jeffrey.l.hugo@gmail.com,
        linux-arm-msm@vger.kernel.org, harigovi@codeaurora.org,
        devicetree@vger.kernel.org, mka@chromium.org,
        kalyan_t@codeaurora.org, Mark Rutland <mark.rutland@arm.com>,
        linux-clk@vger.kernel.org, hoegsberg@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 14/15] arm64: dts: qcom: sdm845: Add the missing clock on the videocc
Date:   Mon,  3 Feb 2020 10:31:47 -0800
Message-Id: <20200203103049.v4.14.Id0599319487f075808baba7cba02c4c3c486dc80@changeid>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200203183149.73842-1-dianders@chromium.org>
References: <20200203183149.73842-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're transitioning over to requiring the Qualcomm Video Clock
Controller to specify all the input clocks.  Let's add the one input
clock for the videocc for sdm845.

NOTE: Until the Linux driver for sdm845's video is updated, this clock
will not actually be used in Linux.  It will continue to use global
clock names to match things up.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v4: None
Changes in v3:
- Unlike in v2, use internal name instead of purist name.

Changes in v2:
- Patch ("arm64: dts: qcom: sdm845: Add...videocc") new for v2.

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 35d7fcbda43c..3ad08d9deb54 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2607,6 +2607,8 @@ video-core1 {
 		videocc: clock-controller@ab00000 {
 			compatible = "qcom,sdm845-videocc";
 			reg = <0 0x0ab00000 0 0x10000>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "bi_tcxo";
 			#clock-cells = <1>;
 			#power-domain-cells = <1>;
 			#reset-cells = <1>;
-- 
2.25.0.341.g760bfbb309-goog

