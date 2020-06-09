Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1903EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 10:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9D1F2078D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 10:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIcDhJTC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgFIKSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 06:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbgFIKRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 06:17:52 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F234C05BD1E;
        Tue,  9 Jun 2020 03:17:52 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b5so9872467pfp.9;
        Tue, 09 Jun 2020 03:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sYZja2GPkizS9cmr8paj+1jHLT3TNrYTxpF+FFiGMT8=;
        b=bIcDhJTCcatY4ggDNPTS8ubPZaYdUJrYKLQYijEc/Olj7keEcU4bWoaQwVHDP4hFrL
         Cy7eK7KQpwSOR2mnEcJ05khRcOTNKQ9+up5yigCE9SDCIJEWkUNZHNAt+ZFv394OcAWW
         2xfUrhvE3cANsRXHl82BSvUrRum9fx0y8c2joPq4CL/sOaLBGdCfmkrCVLjUml8aok31
         BlGDVIGfnVR8zRTrlCDcI1cvDkaft8G91nkRz++yhkfJoaUETUhCcBUEJLEH1eQnJZi/
         Rz8WnK3Do470IvX6OGVUuVtiCwN7qINiMCOzOx86JapZ5ionbzDZTa09qOebTo22Wnrj
         CHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sYZja2GPkizS9cmr8paj+1jHLT3TNrYTxpF+FFiGMT8=;
        b=RxwKLTDbSHGsswYJ/ay/3wRKqazWZF8Qjsn7BcemR6BajvW4P3UT+8h2zTLc9cNJpI
         WTWv8Fg9NNkBW7It8NILt+LXBTm8weFpgy15LUWkTYuIsB8JK244RBF01vIHO3QZ8UNA
         TXNneyUO19mX4DiKG5YYK/FyjAyoyGOPxrxQjw3okNqJDrDjMyzRjBVoWxM9QF9v20L3
         EpyJhOBXBRv97nzWE13fiBAxxURlH9dVB+hzVoKK9nNBVfSTLB5/BUhR9hCtvrl55NuS
         IVafgX/ABDthoOQRPkAFrtvMMuFc6uCL6xEpf1JDTYfbjh3hxW37h5tow+ORJyzN14Mc
         +WcA==
X-Gm-Message-State: AOAM530LxU95Ei74IQDsi1apAT0sn0gOMb331KruWWNakqS6TPwz1dG4
        7G2OCQCEl4FH3T7koHu++94=
X-Google-Smtp-Source: ABdhPJwq6bFtOgYz+uURvmMRxjvekgHvng7JWPHkbsL4XW5DMvdIS0Fks1p0EDrifuU+F7HraNZGUg==
X-Received: by 2002:a63:a84d:: with SMTP id i13mr22967029pgp.342.1591697871778;
        Tue, 09 Jun 2020 03:17:51 -0700 (PDT)
Received: from localhost.localdomain ([223.190.87.90])
        by smtp.gmail.com with ESMTPSA id d189sm9637253pfc.51.2020.06.09.03.17.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2020 03:17:51 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v4 04/10] arm64: dts: actions: limit address range for pinctrl node
Date:   Tue,  9 Jun 2020 15:47:04 +0530
Message-Id: <1591697830-16311-5-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591697830-16311-1-git-send-email-amittomer25@gmail.com>
References: <1591697830-16311-1-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 7cdf8446ed1d ("arm64: dts: actions: Add pinctrl node for
Actions Semi S700") following error has been observed while booting
Linux on Cubieboard7-lite(based on S700 SoC).

[    0.257415] pinctrl-s700 e01b0000.pinctrl: can't request region for
resource [mem 0xe01b0000-0xe01b0fff]
[    0.266902] pinctrl-s700: probe of e01b0000.pinctrl failed with error -16

This is due to the fact that memory range for "sps" power domain controller
clashes with pinctrl.

One way to fix it, is to limit pinctrl address range which is safe
to do as current pinctrl driver uses address range only up to 0x100.

This commit limits the pinctrl address range to 0x100 so that it doesn't
conflict with sps range.

Fixes: 7cdf8446ed1d ("arm64: dts: actions: Add pinctrl node for Actions
Semi S700")

Suggested-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
Changes since v3:
	* No change.
Changes since v2:
        * this is no more don't merge and fixed
          the broken S700 boot by limiting pinctrl
          address range.
        * Modified the subject to reflect the changes.
Changes since v1:
        * No change.
Changes since RFC:
        * kept as do not merge.
---
 arch/arm64/boot/dts/actions/s700.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
index 2006ad5424fa..f8eb72bb4125 100644
--- a/arch/arm64/boot/dts/actions/s700.dtsi
+++ b/arch/arm64/boot/dts/actions/s700.dtsi
@@ -231,7 +231,7 @@
 
 		pinctrl: pinctrl@e01b0000 {
 			compatible = "actions,s700-pinctrl";
-			reg = <0x0 0xe01b0000 0x0 0x1000>;
+			reg = <0x0 0xe01b0000 0x0 0x100>;
 			clocks = <&cmu CLK_GPIO>;
 			gpio-controller;
 			gpio-ranges = <&pinctrl 0 0 136>;
-- 
2.7.4

