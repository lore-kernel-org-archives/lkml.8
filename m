Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61772C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39E532075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e6L6AkxQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731153AbgFVW2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 18:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731043AbgFVW1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:27:44 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCE8C061797
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 15:27:43 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id g7so14541478oti.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 15:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2twIzfs0XUdlpwpGhkxofa+OvC6guPhGkJO/5SWD0ok=;
        b=e6L6AkxQfK4zgaD6G+i1IMw0VPcYhPuMTtZlm1gGZZdFYmjp35ERwxWGbJenH39fq9
         LGdDj0QBZReaSMTlQZ/0auUblx3nWv3eRvJv9T4lueEM8d1aASv00T6NvZJ1Ig97fyUZ
         T8RaWgqyCtH0kuHRANJ6Fv2y8aBUOhYdvfCYWDp1IL5+6SC4f5OOhtP+0HE7rBIA3ZoS
         lyv1qDiYND52PczwcL4pUMj8fW3cmbpZvY1Yjg7IdupTgorfwu4PkRfjzBApTPDA0R2G
         oG3f7qt1gGQq4bYG9HeoqxIqvnppq8Til9queMyxZkkEWMod7EFPTQrC+DgEPl9bSNXW
         Pm6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2twIzfs0XUdlpwpGhkxofa+OvC6guPhGkJO/5SWD0ok=;
        b=TUqL+ctft1/c/LUOH7Q5c0SQvQ9jx/vzsK6fP+n30ccQb94anXUsmXT9EHymDpamJT
         JR78V+TRlXmIkOAqhWqs1N2n6EzyzC8kOC3cBqq9ReXfwWAi5F3Fga99GzKcYCE8c+JS
         BVeNtpllPxr3pIje0jI7gHO7JrtMv6p0zwenThzcyTN95bnHRs2pW1jQkv6DIMeM9wPy
         ziJuuEjAhXWl5uhhUUd+MAkr2eGrBrasd7rlmVJh0YNj0WLq7DUUhiJCaLlRGuSokLfm
         jBBRGfuhKy78j0MOLcxwOIO+yGOLHHvimW8KmNMIVbvU9tQ8aA9sn/H5B8ICQFPCtCAP
         sOMA==
X-Gm-Message-State: AOAM530mOznuDR7tko8rNHpqnzTIGXVilbaRBqboysjHqCj4t/vE+0mb
        jZTxhpmGgMDIlOoNezCKPPlYlg==
X-Google-Smtp-Source: ABdhPJwgey5b7ZI7MvePviVABAMsCQydjl7xm6I27E+P6GcQYA+M+SczI1BLtaOa6STro09MTrS6dA==
X-Received: by 2002:a05:6830:1d8c:: with SMTP id y12mr16164734oti.162.1592864862368;
        Mon, 22 Jun 2020 15:27:42 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h36sm3589304oth.37.2020.06.22.15.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 15:27:41 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/6] arm64: dts: qcom: sm8250: Add SMP2P nodes
Date:   Mon, 22 Jun 2020 15:27:45 -0700
Message-Id: <20200622222747.717306-5-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200622222747.717306-1-bjorn.andersson@linaro.org>
References: <20200622222747.717306-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SMP2P is used for interrupting and being interrupted about remoteproc
state changes related to the audio, compute and sensor subsystems.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 72 ++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 246e6f279aa8..364d9a798673 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -314,6 +314,78 @@ smem: qcom,smem {
 		hwlocks = <&tcsr_mutex 3>;
 	};
 
+	smp2p-adsp {
+		compatible = "qcom,smp2p";
+		qcom,smem = <443>, <429>;
+		interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
+					     IPCC_MPROC_SIGNAL_SMP2P
+					     IRQ_TYPE_EDGE_RISING>;
+		mboxes = <&ipcc IPCC_CLIENT_LPASS
+				IPCC_MPROC_SIGNAL_SMP2P>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <2>;
+
+		smp2p_adsp_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		smp2p_adsp_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smp2p-cdsp {
+		compatible = "qcom,smp2p";
+		qcom,smem = <94>, <432>;
+		interrupts-extended = <&ipcc IPCC_CLIENT_CDSP
+					     IPCC_MPROC_SIGNAL_SMP2P
+					     IRQ_TYPE_EDGE_RISING>;
+		mboxes = <&ipcc IPCC_CLIENT_CDSP
+				IPCC_MPROC_SIGNAL_SMP2P>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <5>;
+
+		smp2p_cdsp_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		smp2p_cdsp_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smp2p-slpi {
+		compatible = "qcom,smp2p";
+		qcom,smem = <481>, <430>;
+		interrupts-extended = <&ipcc IPCC_CLIENT_SLPI
+					     IPCC_MPROC_SIGNAL_SMP2P
+					     IRQ_TYPE_EDGE_RISING>;
+		mboxes = <&ipcc IPCC_CLIENT_SLPI
+				IPCC_MPROC_SIGNAL_SMP2P>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <3>;
+
+		smp2p_slpi_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		smp2p_slpi_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
 	soc: soc@0 {
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
2.26.2

