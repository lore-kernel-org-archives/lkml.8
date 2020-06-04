Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B5CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 01:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2072820738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 01:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PSKnA+A3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgFDBxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 21:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbgFDBxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 21:53:30 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27B5C08C5CB
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 18:53:28 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id k22so3955624qtm.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 18:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cx1RfItm8P+5zdZthMwhmTFP4jusIpmaSOa4M7MTCuw=;
        b=PSKnA+A32FTYGNyVZ3JCedIaquwwdMV72TXnPo6jQ5OtwjCTbqy4v+cayuXvcEV+h3
         zdwZeJ8nrs6vtj5J4AFvYymjLdeGkrP7+DzUYcHY3H5dq429Gd+ioqTgp2GB256edagr
         sin0Mxjm1Ra82p1Ny8wMEEm/SuvoitD95Xr3cZVdoYK+AVezR0e+1Prav2RMCe6iU/4N
         j1wM0QWac4RMmJtIRdAVp7wUCmO68mfJzJrebTnWL+k6lvZzFmAdxWU+7SulimOiLd9C
         Jh18p/7qP8dlgFw5GljRiy5MWLAyuGZylM0Pb46DCNgWAaP4u1VrXQ8eo0cUk++O30yp
         R+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cx1RfItm8P+5zdZthMwhmTFP4jusIpmaSOa4M7MTCuw=;
        b=i4OV5/Xw5AA+AMxBPpPt2npJB8uNtLK/yP582bPuSfpmJf6tszebtKhLAf+5+hF8V1
         UMAwr1AdjjJVwvJBeaXg9zgdjSbhte16DgZsW9ioaaEKSRukNyfzJm7Js03P7suEf85Q
         /s4JCq6BRK+qNjleXmfi5tXiJYA1DDa2ktAWYEdZYiRlg2WAUZb9mar6RWqa1SJ/TuvU
         Ha/T6psoFuNpK2qVQsuNHXNZsN9a1ANo2aozJ8Ws34/4ejI6eJQTd7mXZ6OW8YHed6qe
         BO1zxKqacg/zcRggHg5y/4gAm+5zlB3MbnSfAg0hMCK5wb/Z5Tb+3mLPyrOBapoR92j4
         5bDA==
X-Gm-Message-State: AOAM533i0cQs2pkwx+TTtyplweGdbYyXr4xjg0ZNZICmE5F5+Q9pfTEL
        UO+aiCrsu9FMK3omlf7jjPbO/6mJ6p7g7w==
X-Google-Smtp-Source: ABdhPJzFuQ11RGaUFX9ez2ZUYVbvhFKr+5CSf9niClZmUapncKEZa/DruY85eifIRSadG1SF4IIQrg==
X-Received: by 2002:ac8:450a:: with SMTP id q10mr2274459qtn.328.1591235608210;
        Wed, 03 Jun 2020 18:53:28 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id t74sm2986439qka.21.2020.06.03.18.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 18:53:27 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org, robh@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 6/6] arm64: dts: qcom: Indicate rpmhpd hosts a power domain that can be used as a warming device.
Date:   Wed,  3 Jun 2020 21:53:17 -0400
Message-Id: <20200604015317.31389-7-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200604015317.31389-1-thara.gopinath@linaro.org>
References: <20200604015317.31389-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RPMh hosts mx power domain that can be used to warm up the SoC.  Indicate
this by using #cooling-cells property.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

v3->v4:
	- Removed subnode to indicate that mx power domain is a warming
	  device. Instead #cooling-cells is used as a power domain
	  provider property to indicate if the provider hosts a power
	  domain that can be used as a warming device.

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 8eb5a31346d2..dcc3bcd16b68 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3854,6 +3854,7 @@
 			rpmhpd: power-controller {
 				compatible = "qcom,sdm845-rpmhpd";
 				#power-domain-cells = <1>;
+				#cooling-cells = <2>;
 				operating-points-v2 = <&rpmhpd_opp_table>;
 
 				rpmhpd_opp_table: opp-table {
-- 
2.20.1

