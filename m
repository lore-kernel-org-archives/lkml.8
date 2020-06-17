Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C1AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 131F321527
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuWRHNm7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgFQQsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgFQQsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:48:30 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B8EC061755;
        Wed, 17 Jun 2020 09:48:29 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id t21so2476611edr.12;
        Wed, 17 Jun 2020 09:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lJKpt55I3R2NHkjVsgV/EWx4EQxkw9Y42GuSmQWOQXU=;
        b=SuWRHNm7e/2dXvHjlXZn0QaZypCtAgtrifRw8rwQWgE54p1v4gdCeAV3HzELa0cOUT
         NqjqJwR3GcIFqOIr2vEictKG/pCzUYfAVnataPnFzQnh0ANBCrrVnIgslT7RTyKQTOnj
         vrKhJMHVZ7e5JPjeKsIYjLzTAX+uwIIHZEWzddzbwc73CnPVdeJl1N1jviZrlvBK35wr
         0zJiSrVrU+oCgIc2G/yRZlev6qcHLFYXZW+GjCscUYokGMAa/FPB7nmlIcEPARgObtKx
         SEvrzBB78PyZnVxKU7Jfa+USiKOlpvcb6xBrrlACe2DakKHp2yzaOIbQRmITI+tD+4M+
         FIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lJKpt55I3R2NHkjVsgV/EWx4EQxkw9Y42GuSmQWOQXU=;
        b=tVhyR/uINtZyjCF0Z3hRXXYcBkxVq0n14DmyWgbQwdrMQ1bkmB215yqlGzZIFkw2Yc
         orpJBupaoF5WOkJqJ/EEknKQcvIsiLUA83eRmV2ZA7Om6svs4uaYdU6TrlRyCCCm7OSB
         OhlLDsJbu+Kmke580tEYiqJnEMsAp745pzHdcX8rESc4u+dyRaCzPDmI+BpANCt4rnRa
         ePxTEABP+Z+yqv3vX53Lkr4k0dPnkIsOvYtWsb/aGI33bmgepjxAeNEk9Nnclm7DFuiX
         fYlqtxFjbARnY29u4pYf6+eZkwNRea21YiHr4wrhoWR53tENScGuIrv9NNN/teJ5QSR+
         cf9A==
X-Gm-Message-State: AOAM531+2p5ax6I4Bd8XWMB+/roy+qx3Of3WQuHJQN+MpwGkY71q7lcV
        yaELhWFyVhCH9HTpKylOVKL4SX+x+x8=
X-Google-Smtp-Source: ABdhPJzeRmr0uDJj/7U2GJ2r5I6AA3DS92T7LUZ/ga5mx5c0Ixaylw/uHtMWYjNSa4bQd2zTQrkEfA==
X-Received: by 2002:a05:6402:307c:: with SMTP id bs28mr77851edb.3.1592412508568;
        Wed, 17 Jun 2020 09:48:28 -0700 (PDT)
Received: from localhost.localdomain ([188.24.129.96])
        by smtp.gmail.com with ESMTPSA id v3sm127124edj.89.2020.06.17.09.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:48:27 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] arm: dts: owl-s500: Add Reset Controller support
Date:   Wed, 17 Jun 2020 19:48:10 +0300
Message-Id: <0722104f0a281ef8b628de384b6e6e52b75ae6b9.1592407030.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1592407030.git.cristian.ciocaltea@gmail.com>
References: <cover.1592407030.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset controller property and bindings header for the
Actions Semi S500 SoC DTS.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 arch/arm/boot/dts/owl-s500.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/owl-s500.dtsi
index 0f4fc5487dad..0b7ba2926f0e 100644
--- a/arch/arm/boot/dts/owl-s500.dtsi
+++ b/arch/arm/boot/dts/owl-s500.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/actions,s500-cmu.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/owl-s500-powergate.h>
+#include <dt-bindings/reset/actions,s500-reset.h>
 
 / {
 	compatible = "actions,s500";
@@ -188,6 +189,7 @@ cmu: clock-controller@b0160000 {
 			reg = <0xb0160000 0x8000>;
 			clocks = <&hosc>, <&losc>;
 			#clock-cells = <1>;
+			#reset-cells = <1>;
 		};
 
 		timer: timer@b0168000 {
-- 
2.27.0

