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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5A0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 23:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF3082081A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 23:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ew6AmTKs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgFYXed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 19:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgFYXe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 19:34:27 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADD7C08C5C1;
        Thu, 25 Jun 2020 16:34:27 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id n24so7636470ejd.0;
        Thu, 25 Jun 2020 16:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HbW3NKNom8juXI2NoyDjAEEkKyRH9dumXigRxuvNwKY=;
        b=Ew6AmTKssf2v/cyQeO5Y1e/8dZ4+HeAs3VVDf3775Azsh2mnWBEfGQjbKuZGreCr3P
         6TGm4m6S+DCTSUJiPQyXFIzJbqjJqns475FPvcSfdNetTPq3p7ObiWqafYB+F5IUfN+U
         WUxp1aSR31ZJOtdLEjl1pMhHaH3rYzU3M1YR0+E812S0vq3mu6zT0NRK7lfKikavA2Rc
         DU/TdinllQO/9g/KkhgasEjZNODKB+/BZFF1jm3e2qOZIuOO4Zv4KKBydWXN+KiYgWx3
         6BH8bZFUplpjCUIk4Vjdi8Ulcftp/UBzHrr9LHw254hOTYYt80toA5qBRDAy81JNHmNZ
         SG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HbW3NKNom8juXI2NoyDjAEEkKyRH9dumXigRxuvNwKY=;
        b=UeLSAhtOxz/9TtlWJmSZpzMKV2TP3EuA6LX8ofn9wr+eGfeV3nQ34IDhVuPrUgAn/W
         BQpoinamnwdiSkV6hU/1HR/YkTDuOFgKImPUpGytds0S8kb5px9shKqLwtjtJUeYR54E
         feeVMeKunLMcqFtdBHfp0n2E0PIAKOfFr4sYbHkNKLIjTmP+qditVB1WAOXvTkCTRTUX
         D+eq7kgdB+3t71EluHbG3W/C9veGvbA4wFEaOsWpBbExYtusi2Qo/mu6zcaWypok7KjG
         0c1dZzRT9Gb2aO9ms2+BMeh+FZI1MkcdScQpGlzPAqjQx40czpPSPPDgYSSEm7v1ELHW
         5r7Q==
X-Gm-Message-State: AOAM5306iSReNXIT0FNCs91W8jdTre4dChxaTfW1R+6Zqa+HjBqYzLUp
        FnqnVZ0WUh4OwnMH+tVdjzo=
X-Google-Smtp-Source: ABdhPJwOSdzX6Md9aW2T3lAAqEvgQur426QhGKd5yRVXCoQnODQ1/97Pw8KuwyCCz2+T+b7NxK/sxA==
X-Received: by 2002:a17:906:6dcd:: with SMTP id j13mr163854ejt.131.1593128065834;
        Thu, 25 Jun 2020 16:34:25 -0700 (PDT)
Received: from localhost.localdomain ([188.24.137.55])
        by smtp.gmail.com with ESMTPSA id u2sm13699184edq.29.2020.06.25.16.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 16:34:25 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org
Subject: [PATCH 01/10] arm: dts: owl-s500: Add Clock Management Unit
Date:   Fri, 26 Jun 2020 02:34:13 +0300
Message-Id: <3c51f6c9d4a8bd21cd7c3797cc3f32dfcadcf512.1593124368.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1593124368.git.cristian.ciocaltea@gmail.com>
References: <cover.1593124368.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Clock Management Unit for Actions Semi S500 SoC.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 arch/arm/boot/dts/owl-s500.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/owl-s500.dtsi
index 1dbe4e8b38ac..5d5ad9db549b 100644
--- a/arch/arm/boot/dts/owl-s500.dtsi
+++ b/arch/arm/boot/dts/owl-s500.dtsi
@@ -5,6 +5,7 @@
  * Copyright (c) 2016-2017 Andreas Färber
  */
 
+#include <dt-bindings/clock/actions,s500-cmu.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/owl-s500-powergate.h>
 
@@ -70,6 +71,12 @@ hosc: hosc {
 		#clock-cells = <0>;
 	};
 
+	losc: losc {
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+		#clock-cells = <0>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -169,6 +176,13 @@ uart6: serial@b012c000 {
 			status = "disabled";
 		};
 
+		cmu: clock-controller@b0160000 {
+			compatible = "actions,s500-cmu";
+			reg = <0xb0160000 0x8000>;
+			clocks = <&hosc>, <&losc>;
+			#clock-cells = <1>;
+		};
+
 		timer: timer@b0168000 {
 			compatible = "actions,s500-timer";
 			reg = <0xb0168000 0x8000>;
-- 
2.27.0

