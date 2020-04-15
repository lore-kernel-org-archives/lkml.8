Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8F4C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9717D20775
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+a6HRSY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895885AbgDOJ7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2408508AbgDOJ7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:59:35 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B638DC061A0C;
        Wed, 15 Apr 2020 02:59:34 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id l11so2156283lfc.5;
        Wed, 15 Apr 2020 02:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=63vRFQmPky+5Sun2Opkz9FUwUHHMbnn+8rcnJyfbXrg=;
        b=O+a6HRSYtexYUcRf2vogJPvF/gD1KELnuZj6kV7IzsLHhvD1ryxo8ZXyhMxj9oja2I
         T3mKdn9yFI5+RKfmhbvG/nbjMxrVSpPhpXgZJAboj11pvYuLsGQSReYdnaLgOCHE6G70
         bM789lHrYlz91lpKf5MMGdPttYhx6aCoBWj482d6qI2D++FdHz0GPAOhRJOhGqw84OjZ
         GL+AOHaLE9BipLjl54B36Jn9AdGtgJE0TeS6xZnq3WKfUPqz+/Me09yAa5zw2gjZIE5s
         2Dw/JWCO54aVJPPX7f6DTt9e3njJ9IJIkxbexcOSKvXRgIdiO6mFVGSiO6BvJNNAfsKe
         1IXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=63vRFQmPky+5Sun2Opkz9FUwUHHMbnn+8rcnJyfbXrg=;
        b=TAghxwsHOqiKeKKSd8AT+pNpqZJRCMRaX4m9DQfsjuFRAUxi5lE5Q+cOGaD9GIOz7B
         jWSNwLq1d1S0tV6INvlP2SMPemdC84fxKRgkxtZ9cExPLGEP3XN/+a0Xs0+mUzBpMs6I
         FP3DgK5dC4ESxZ3oUt3Uxz9+XYu/itUCIAnELag/MI9J5yeWpoyH4A4ey8aRMd6Avvd1
         +PcdyLf9eOcr0qp9xYfAQihCIIvNbMoSm/3SON6H3eObLRt5IumdjdKSIDfiEySgkUKQ
         kvG1SCi9DebQ41cyTZNokScN2Eshkgxlcfei/lD0v38esWhM+Sh6Q+n3ULBHB/xuIE4g
         ZKnA==
X-Gm-Message-State: AGi0Puai0MLHseKk7BcaCrpT3wJST2RSbi8+kwAHAnUfs26mFK46NNXn
        Rx/AHBolCloCYhF2P2R+cVU=
X-Google-Smtp-Source: APiQypKvCI1atszqVmdui44gkRzNjRuvl0XeDay9w1RcX0HQfX4ZxaC9Ip6qE2cjuqz9J8NIMZa19g==
X-Received: by 2002:a05:6512:304e:: with SMTP id b14mr2479583lfb.119.1586944773169;
        Wed, 15 Apr 2020 02:59:33 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id m13sm12290424lfk.12.2020.04.15.02.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 02:59:32 -0700 (PDT)
From:   chewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] arm64: dts: meson-g12b-khadas-vim3: fix missing frddr_a node
Date:   Wed, 15 Apr 2020 09:59:27 +0000
Message-Id: <20200415095927.3780-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Hewitt <christianshewitt@gmail.com>

The frddr_a node was accidently deleted when creating a common dtsi for the
Khadas VIM3/VIM3L boards, preventing audio from working on the VIM3.

Fixes: 4f26cc1c96c9 ("arm64: dts: khadas-vim3: move common nodes into meson-khadas-vim3.dtsi")
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
index c33e85fbdaba..c6c8caed8327 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
@@ -154,6 +154,10 @@
 	clock-latency = <50000>;
 };
 
+&frddr_a {
+	status = "okay";
+};
+
 &frddr_b {
 	status = "okay";
 };
-- 
2.17.1

