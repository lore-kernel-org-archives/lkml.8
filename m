Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19816C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 18:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E35B1207FC
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 18:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEobQgKo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390708AbgFYSVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 14:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389648AbgFYSVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 14:21:31 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75654C08C5C1;
        Thu, 25 Jun 2020 11:21:31 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a1so6852689ejg.12;
        Thu, 25 Jun 2020 11:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wyyTfoYKUal+Im2XFp9aLfEoAp0H4cTyYoV6q1T4GSs=;
        b=PEobQgKoEMEyUg8apMi927oZD8vIUM5Vx61Zcb0XYEKgk7OCQy44rz/H7p364Aw1QM
         KX2XuJls+eqCLGFYYJOTeaQvC7D5ejt2X559pNy16Nw55LETU6LXHeID9ICxFNTPge72
         9wiUrKOIXeoajpUDMsJ1Fum9SsHkdbdsyIda3OLUBv8IhvFmql7WFGhMVgHeiBbh28iE
         vxE1I/dCJ0f8Z+7NuEt73SwRQ0Vj1YjsOEKbKstrGlNspcMlSD9yTY9GXD9kTBa1Ea85
         TmLntu4Kg2ePJ7Tth8AFgOoLtfc/kxstLf9yGSdfUeuEo7zZ82zzcMnyVwfD0PXy5wBI
         94dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wyyTfoYKUal+Im2XFp9aLfEoAp0H4cTyYoV6q1T4GSs=;
        b=ablDQX4AXMqrAjO4LtEnUzYtQ/hEJumDxkHWcdwmPWwdY4VpFdG3m15gooUS7nNhlt
         e5vVAc4kU1M/LE2gl30sCylVlYsTvW5s2PalqpooxztK5RBeTJZjF/+cxJJOPYdvB4fR
         sCnGZBvqdd9HDf6JcPcF4vZUOSHMiOC78M4JgU5sAXE8U67xDj+JunVpC61laaDQJ6Wb
         EWFGnXO2PiO1VJoOlnuZYJ8MUyRezSr/8Q0gPZ/qQqv+JFCzVVmvk9D+kVbzZgKazehA
         079Cqe2pJrAyNds37ByiYv+N2vRUQQ0lz3+fKOk2NcCrGgcoOdkQ+ri2EmfAbs6C+MMp
         74DQ==
X-Gm-Message-State: AOAM532X+a0P80onay28AVsWZUKpr8VrDU0zLJLKZJ6LHgxoh3ERgt/g
        aqNPzJPpdGrpPL6rWWrtrW4=
X-Google-Smtp-Source: ABdhPJxnomW7lt+1hVr9XadS5o1FSgjDDK7gmE17NGMsjJSOo+qmfY0FFhWDbsA3eiCykt4+H6oMEg==
X-Received: by 2002:a17:906:ecef:: with SMTP id qt15mr30155704ejb.91.1593109290233;
        Thu, 25 Jun 2020 11:21:30 -0700 (PDT)
Received: from localhost.localdomain (abag196.neoplus.adsl.tpnet.pl. [83.6.170.196])
        by smtp.googlemail.com with ESMTPSA id lm22sm1523448ejb.109.2020.06.25.11.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 11:21:29 -0700 (PDT)
From:   Konrad Dybcio <konradybcio@gmail.com>
To:     skrzynka@konradybcio.pl
Cc:     Konrad Dybcio <konradybcio@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/13] arm64: dts: qcom: bullhead: Add qcom,msm-id
Date:   Thu, 25 Jun 2020 20:21:07 +0200
Message-Id: <20200625182118.131476-4-konradybcio@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200625182118.131476-1-konradybcio@gmail.com>
References: <20200625182118.131476-1-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the property required for the bootloader to select
the correct device tree blob. It has been removed from
the SoC device tree as it should be set on a per-device
basis.

Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8992-bullhead-rev-101.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8992-bullhead-rev-101.dts b/arch/arm64/boot/dts/qcom/msm8992-bullhead-rev-101.dts
index 1061fd5404aa..4f70681e730d 100644
--- a/arch/arm64/boot/dts/qcom/msm8992-bullhead-rev-101.dts
+++ b/arch/arm64/boot/dts/qcom/msm8992-bullhead-rev-101.dts
@@ -11,6 +11,7 @@ / {
 	model = "LG Nexus 5X";
 	compatible = "lg,bullhead", "qcom,msm8992";
 	/* required for bootloader to select correct board */
+	qcom,msm-id = <251 0>, <252 0>;
 	qcom,board-id = <0xb64 0>;
 	qcom,pmic-id = <0x10009 0x1000A 0x0 0x0>;
 
-- 
2.27.0

