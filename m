Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C915C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BC652078D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTt1cEYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgHXSnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 14:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbgHXSnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 14:43:02 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84571C061574;
        Mon, 24 Aug 2020 11:43:01 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id h12so4991578pgm.7;
        Mon, 24 Aug 2020 11:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VJrx+AWRDEEJgr3DuJf5FGtuFm676MmhtRSCNhrUo5I=;
        b=KTt1cEYiXU1s2DyRWGrMCMo6aJgvTJHSOS5G/PYktd3Wc3mxeZoM15gjdxnPZe78K9
         XE9kcJ59YIkPbY8QB1lvDFs/JjIQzAi6D7il7Ftv97hGIAlmL3nZSUWNu222bfOExK5y
         cGVNuCNUbgVJvmdzGAms4T7gFByYkXSMm+vTCf8p30/l2RnccdsynVF1xU0oPQ6SeIng
         TdWYS/jga0mys7CXXXSfJmRn19C/gx/34duKD2WlVftweVsNx8rowU6Vpn5ovYm0oy05
         Pyer/HwI/331NwJN8A0NuiS9QKTGkWSHYYCvTJCa+5Sztp9QmcZHZvwQvMinpKic6mNh
         KoXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VJrx+AWRDEEJgr3DuJf5FGtuFm676MmhtRSCNhrUo5I=;
        b=Y6xjeqLijmJ4a0O6j8GDHeVp047/xgamMa/WZyO3njbdBPzS30VslD8hidbCmY2OEQ
         hoaAEb0Dh9HzMx8i0PKkOvkmokOyZNk5PxHInlTVHzxJj0lCpo5YBEmRioIRCEKXXsHa
         IyQnZOlX3dNdJdNJWiZ9Z+T42dqK1xbjQj8wfgMAYofJ06MvPlRTY4U+qKH+YRSptRLi
         VYEXkOzWHNfsYpQmmyJKl3TyrFimBrx3RtLtv+wvRjLVZAs57BZCpJzWQ48Vt0q1soA8
         FHAVFHPD8QGf/z3Gcb/C714BnOG9FHzJpD3cnrA9z+jI9WTcBvOXIpOL1TcKLtR6OcfZ
         osbg==
X-Gm-Message-State: AOAM531e6bYT04S4NPT84HFeqhuJewCtWAY/ykJ7f7TDM/U9sL8jrpDa
        /Ci6Qk3Wy81qVYvkLhR453Q=
X-Google-Smtp-Source: ABdhPJxVOMMAzbTzCneKhacGBtyMfiXVyO5KNsF0pzpQXeI8dRQjCOIVGM8GwnqXHXzy+GM65O2HsA==
X-Received: by 2002:a17:902:900a:: with SMTP id a10mr4551045plp.203.1598294580998;
        Mon, 24 Aug 2020 11:43:00 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id x14sm11840582pfj.157.2020.08.24.11.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 11:42:59 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org
Cc:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Will Deacon <will@kernel.org>, freedreno@lists.freedesktop.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Clark <robdclark@chromium.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Brian Masney <masneyb@onstation.org>,
        Eric Anholt <eric@anholt.net>, Joerg Roedel <jroedel@suse.de>,
        John Stultz <john.stultz@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 17/20] arm: dts: qcom: sm845: Set the compatible string for the GPU SMMU
Date:   Mon, 24 Aug 2020 11:37:51 -0700
Message-Id: <20200824183825.1778810-18-robdclark@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200824183825.1778810-1-robdclark@gmail.com>
References: <20200824183825.1778810-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jordan Crouse <jcrouse@codeaurora.org>

Set the qcom,adreno-smmu compatible string for the GPU SMMU to enable
split pagetables and per-instance pagetables for drm/msm.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi | 9 +++++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi       | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
index 64fc1bfd66fa..39f23cdcbd02 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
@@ -633,6 +633,15 @@ &mdss_mdp {
 	status = "okay";
 };
 
+/*
+ * Cheza fw does not properly program the GPU aperture to allow the
+ * GPU to update the SMMU pagetables for context switches.  Work
+ * around this by dropping the "qcom,adreno-smmu" compat string.
+ */
+&adreno_smmu {
+	compatible = "qcom,sdm845-smmu-v2", "qcom,smmu-v2";
+};
+
 &mss_pil {
 	iommus = <&apps_smmu 0x781 0x0>,
 		 <&apps_smmu 0x724 0x3>;
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 2884577dcb77..76a8a34640ae 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -4058,7 +4058,7 @@ opp-257000000 {
 		};
 
 		adreno_smmu: iommu@5040000 {
-			compatible = "qcom,sdm845-smmu-v2", "qcom,smmu-v2";
+			compatible = "qcom,sdm845-smmu-v2", "qcom,adreno-smmu", "qcom,smmu-v2";
 			reg = <0 0x5040000 0 0x10000>;
 			#iommu-cells = <1>;
 			#global-interrupts = <2>;
-- 
2.26.2

