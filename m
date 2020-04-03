Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49359C2BA12
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0AA2077D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUU2B0i/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgDCUWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:22:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33388 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728589AbgDCUWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 16:22:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id a25so10080866wrd.0;
        Fri, 03 Apr 2020 13:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fhOtbK0ZVL1ABebYKJYf0UxxzluO0JY5MJfCTLBiR34=;
        b=HUU2B0i/AmHt/U6+7pI3Nauxs8P31FCocmOO2SiELa6ftuHKRB5A/klDwvPpBAd+Ft
         dZCIqTaqcZnPCMujHH6Pwp4gyP0HayYsOuCtQ42+7r09dezJ3DHyKjohpu/k+vbRHYIc
         LS5/aP50jeO18Fwhia9Xyea/+z4kaIE1fBubPoh3Yk0eM2D0BpL8N5xznFVgl/HG+ktr
         /V9VsrNDeVgw/+AF/57iazt4FWaIDFrBlFU2rWXvZb9qwdKU5LyBFbS8byg9ep3gaZSj
         d3X/DY+5vlyqezN/Z21RV1OH7KEk6iOoykOKxGbgxlyyNFkgsCzVl0lIX4iMlQnMopz7
         hokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fhOtbK0ZVL1ABebYKJYf0UxxzluO0JY5MJfCTLBiR34=;
        b=FZTakWi7o3BUjUbEMVq6Nukn+2G4y2Td3B7Z0K9JvUiD/LHr2945kOXFy/lx00bkPV
         z/Kn+2kJ9dFyEtEDmCIimW79i1wPXTrOfUDXR18IcelKkUjGZSI7vGdtTFcdwCl5uHaW
         fVNf+CFQHUW7FkAsof9vsTxzKBztBRnnsuoG6/XzEKDd2qi2z1HVz+JY1AC4t/sisJn4
         h1d2vtY9F/odLf6ZtYDcncC9xZtDGGtUYO9+c4LMK1UmGcZrvuSgA8/Ibk044SS7Q5b1
         nmpmEnIq/eCwUtq51kvnceVSBFa/fLEfSEBoko6QBCKHC7RyTLOwBRF7mIRvrsTEVLvy
         Tl6w==
X-Gm-Message-State: AGi0PuaxeKauYtaZspgiixoO6KDbYIJyzRsIyTKwLfIqTUErWdqjvH4P
        GFzGiX27/3lGLAt6QLnVxMw=
X-Google-Smtp-Source: APiQypJwyjlC81w8tMkFTyU/xyPrx4riYwln0dT/JL05SWu258U0MNk5jFQCBvuNXkA7PF2MiX9s9A==
X-Received: by 2002:a5d:4602:: with SMTP id t2mr11734250wrq.347.1585945349386;
        Fri, 03 Apr 2020 13:22:29 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id y189sm13005619wmb.26.2020.04.03.13.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 13:22:28 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/7] arm64: tegra: Enable native timers on Jetson AGX Xavier
Date:   Fri,  3 Apr 2020 22:22:09 +0200
Message-Id: <20200403202209.299823-8-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200403202209.299823-1-thierry.reding@gmail.com>
References: <20200403202209.299823-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Enable the native timers on Jetson AGX Xavier to allow using the
watchdog functionality to recover from system hangs, for example.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
index 623f7d7d216b..d68588f2709e 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
@@ -52,6 +52,10 @@ memory-controller@2c00000 {
 			status = "okay";
 		};
 
+		timer@3010000 {
+			status = "okay";
+		};
+
 		serial@3110000 {
 			status = "okay";
 		};
-- 
2.24.1

