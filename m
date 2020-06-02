Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52912C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31771206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yviw9z29"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgFBRhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 13:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFBRhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 13:37:13 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5B7C05BD1E;
        Tue,  2 Jun 2020 10:37:12 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id q16so1636114plr.2;
        Tue, 02 Jun 2020 10:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yC3b8DT3Kq2HwvI7o7BNmEUaQSfwkzDaER9EH5kkdq0=;
        b=Yviw9z295zj5fjLl2vUlLMAJzpUBdI6yODgLo71V+gnRWdy/HAfOku+4RRGF+yzmqK
         t+au//KmqSyun3jNCn8vCEmKZNdAFWTJftT893d+nbe9PjQ8sJDXaTHzCZ/jv3Wa/7/Y
         QigrSViYpDIh7VAmvvZTyDug+wYeFeI+s7pGmAbiZpsKOOY1z3i1+6IG3saPoQPuQW8L
         PRHyMDST7Kx8Ek98ZFeCdl8Ojb5DhgTobkvM0vWcFMfafJCDpPpjqhzsc+N/z6iB08FZ
         DSJW5bxNzFbXaXqd0LKkWoaLxpbP935w0N9J0lqkRULyFI9st4ghdJYOiCX90M0LelV8
         k1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yC3b8DT3Kq2HwvI7o7BNmEUaQSfwkzDaER9EH5kkdq0=;
        b=USIgqTyBh0ZtIVk9pYJfF+BWG2boro1dM0fR1aq1cXWIlSy/Q6hqgvzbuq6/+UICX1
         eZa2fKWtwCzxtE58lZLgKRznAy+yYfOGcfbkZ/J8iMeRlTAaiTtDeSyD6Vs9e6WNhnY+
         ncyyGyBTnTar5pelb9m5FuDIlUtkO65BjFcRSl8uTSJG9Mv8IQpmXk3xbe14k90QI+TP
         7ylrdJ/WT+Qc/Oc1zDuG8cfRSWxj2XMreCNs243TkWLBH+IJmxb6MP0SFb67LynaAQgh
         1j0TOYUmQoawhse3liiSLq8ZcE7F4U5mM6s9LdK8KQVZyAjJUxzf9LYUuml3QXqO/Xtx
         7QHw==
X-Gm-Message-State: AOAM532H8cMTA+QsQrpacOAlWzPzjvwjQbl7Yxcr+IMzx+IXNKUAUfdf
        6wXOHs94IS26Rx+v3COJ/Wk=
X-Google-Smtp-Source: ABdhPJz/gwr+d9DNnYFiNawK6YhfZFHEyC8/iMMp5w+Vh1TRDaGaZmArZRTSZkbx1AZrUmItAtFU5g==
X-Received: by 2002:a17:902:aa48:: with SMTP id c8mr17901684plr.128.1591119432420;
        Tue, 02 Jun 2020 10:37:12 -0700 (PDT)
Received: from localhost.localdomain ([223.235.152.125])
        by smtp.gmail.com with ESMTPSA id i22sm2864382pfo.92.2020.06.02.10.36.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jun 2020 10:37:11 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v3 04/10] arm64: dts: actions: limit address range for pinctrl node
Date:   Tue,  2 Jun 2020 23:03:06 +0530
Message-Id: <1591119192-18538-5-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591119192-18538-1-git-send-email-amittomer25@gmail.com>
References: <1591119192-18538-1-git-send-email-amittomer25@gmail.com>
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

