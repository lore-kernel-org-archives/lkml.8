Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2C9C433E7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 17:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12BC021744
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 17:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qniJkCyp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgGSRm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 13:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgGSRmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 13:42:55 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3865DC0619D2;
        Sun, 19 Jul 2020 10:42:55 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 207so7922582pfu.3;
        Sun, 19 Jul 2020 10:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bZxcR2KZzn+4XZ0ufduODiRcz7ZfigdmNagILQzXPSU=;
        b=qniJkCyp1nHKRjS4t75bL6r00uUD1VRlgUFg/d1qpq50yyoK/6XC/Ni5h+4Blm/ubE
         IqrXREPesdEnzkmGSxyt8BgMtvMM8etn8Ks9f/FrqFROsB+Fc/zY/I7DLF8vXV5bEEKz
         u4fyGV9n6yMy/KHffy27rq5VmtHMiK55R/o3+oqT8Tda/rNK8RiUSHOfACd7p5Gfxwow
         BlBicKHTPsC1oVNLR+RL7LHPvSMU72Zr6lLDwqyh4NyA9MWjvhFVKdAXiebP3AzkMGUq
         DabfV2TeAoygnwgP9cATknegkWln+stj3kHxi1ghEThV6DaEbcleojeEMCsagL8o4KQt
         bXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bZxcR2KZzn+4XZ0ufduODiRcz7ZfigdmNagILQzXPSU=;
        b=Mz09y1HOOQwOYoFTDuyFD71uiWftZ1vBwY/8Ih+vS51GEjruRw4LABUbMdglrWzt9/
         EvMfRP9tSFN0VMxVjfayt4CwFoJ0fUTrHvqmYqrDks11KIuaQeepoXk2W2fFgEjl6iDL
         ZjFwYvJsQgST/w9mwxNY41CNB4eM27fZXUxNy8yE5neQjmdWiOR78Fzko31t4tuw3bmh
         irGBc5/k7PYazUkJIUrABvKqejunaoM924vVzb+tDytpS5g0lacROhLfbt1s7093qPN5
         YCT3Axs5reADlwkctmYKAs3isyrzijpvwFUb6bymWliM1NsosEJoGZDVkBbEXA8A5VoL
         0SQQ==
X-Gm-Message-State: AOAM533waeiaZL5DpEyuzAezwPbi4ACauWd8S86XW1f55iAUGPBKtF2/
        cBIygb3SZ3dEJK1enpr3eOg=
X-Google-Smtp-Source: ABdhPJwTHRQChGBUhy+aOEq3A5g+j6eC9CZB7yP9nkAAjETquKlYP/Xx+R0WHz8fxyKyN91ctp2YHw==
X-Received: by 2002:a62:4ec8:: with SMTP id c191mr15859767pfb.15.1595180574674;
        Sun, 19 Jul 2020 10:42:54 -0700 (PDT)
Received: from localhost.localdomain ([182.69.248.222])
        by smtp.gmail.com with ESMTPSA id e191sm13906083pfh.42.2020.07.19.10.42.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jul 2020 10:42:53 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v7 05/10] arm64: dts: actions: limit address range for pinctrl node
Date:   Sun, 19 Jul 2020 23:12:02 +0530
Message-Id: <1595180527-11320-6-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595180527-11320-1-git-send-email-amittomer25@gmail.com>
References: <1595180527-11320-1-git-send-email-amittomer25@gmail.com>
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

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Suggested-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
Changes since v6:
	* No change.
Changes since v5:
        * Added Mani's Reviewed-by: tag.
Changes since v4:
        * Reordered it from 04/10 to 05/10.
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

