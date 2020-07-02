Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F28DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F103720771
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fp72dDXS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbgGBOxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730044AbgGBOxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:53:40 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9533C08C5C1;
        Thu,  2 Jul 2020 07:53:40 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id g17so11402387plq.12;
        Thu, 02 Jul 2020 07:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3Ynzzwh0ep2RlxJN0DnaTzqUk//cwR0h7tefX5O2u2o=;
        b=fp72dDXSfvCEMxTpNw3En2AC02y0KK5weQjL4qAM6d27+hJjzH/NK8z1m9L9zgdjNA
         7NCL1iwPKNaHrSaypZ5n71IdtCeIOC09VcTcn6FzDXVHb+MZkv1ozL8hE/S5TtKAV5sL
         6quNwUoanoDHwTgRa2PdzkUFaGXMZ2FMGxme80H4dBRQQNGQxRYs95MuTSU/scGmMv7S
         32IoZvHJJdkLoJIENvw5pt8XKfxDOGh+RlAeJJjuCOZOSHKoCBec1OndXG+IC+EKynuG
         ZfX/7LyTFwQCSBwm5dEQ2k30ln9afvxUG2zunkEQr4bkHdbYPuDHi6WvB9iUtVnyDwql
         mxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3Ynzzwh0ep2RlxJN0DnaTzqUk//cwR0h7tefX5O2u2o=;
        b=kRHGoNSoSVMMZHqnURSkjDzJTySSv3FiZWARPI/4Q31D/QbMOEC6Lgfw7e9AFc7Wzk
         /66h722lFjRYygGOLmYvcvWj0KA+qOBBzPoz3THqH41/gkXdsSGitflO6bHpSBVH9ShM
         5D2Cg6nMsUV8PYEZ3ItTHQFPT1YC8RwWrshlCsFli/Wc2oAwJmaxYDI3MFYV4MEqPAsi
         wWrueDyQi+oBCgzj9VSJRE8gUxC3fQqVArFozjyiw34n6YyC0MPFJRU9h0ibmh7b74d1
         I6WKteIcwf/DjztrwS/1ziqZuo52P448SPqFTGOWVYjQpAR+Gs2TbcghsxYDCj+baF1t
         99Pg==
X-Gm-Message-State: AOAM532uBFeL1P3ie4dHMGhoN9ZNS+84bQ21hSUK8gWIRRt1GkxDX4Dq
        AiknB0h4SN3RfIv2kmagjQg=
X-Google-Smtp-Source: ABdhPJyretCP/qZUG8JG0H+goPz5I9Erp8NO7mNSD7j0qgjVdLDoymPB2eMol1AzXwtomr4SK25eOw==
X-Received: by 2002:a17:902:6bc1:: with SMTP id m1mr27572008plt.158.1593701620165;
        Thu, 02 Jul 2020 07:53:40 -0700 (PDT)
Received: from localhost.localdomain ([223.190.0.253])
        by smtp.gmail.com with ESMTPSA id 204sm9487891pfc.18.2020.07.02.07.53.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jul 2020 07:53:39 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v5 05/10] arm64: dts: actions: limit address range for pinctrl node
Date:   Thu,  2 Jul 2020 20:22:51 +0530
Message-Id: <1593701576-28580-6-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593701576-28580-1-git-send-email-amittomer25@gmail.com>
References: <1593701576-28580-1-git-send-email-amittomer25@gmail.com>
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

