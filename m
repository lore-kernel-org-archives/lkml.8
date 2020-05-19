Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532E9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BC2B207D4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/RAtZBA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbgESSWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 14:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729244AbgESSWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 14:22:02 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC780C08C5C0;
        Tue, 19 May 2020 11:22:02 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p21so197638pgm.13;
        Tue, 19 May 2020 11:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nIw/Wm1p9mhtngU9JT40imNSzxd+hOjNvy14i5Yi/sk=;
        b=m/RAtZBA268ogWyV0zd+y7ddhFSa2wnf7yzaJGsJZPgcu4Du5QqE5dNnUqY8YAsO8V
         Ab8otkj74dK65n0oUJwIgKaUa8CW7RR+coQo2VaFpAnrxXUog/AVlPPx3uEUAvsAS2J1
         uJk8BGHatFyX4+oEEeq/mJQDeG1tHArO3XRSzKNuGyqWpy2HY30MTP/Rqn5VxB6kw8hq
         KfXBWO+8OYMDvuzmYzWYisQuKxYsL1BY5RY7fNCoDldvNe+I3opBCLypYGPXhEvSfOBd
         sFCqlDW+mLZz6Q2DVjgIYXIVYos1D2xQI3SM8359abyfNPKCl2NA2DA6bwz0LpX/m4d8
         ursA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nIw/Wm1p9mhtngU9JT40imNSzxd+hOjNvy14i5Yi/sk=;
        b=fWecNGSiYYdF2fVlaOIGIdu1iuzD1YX3t2pwjvZDuW5igo5XjDczmpNQrrqLyDo9GP
         k9qyUwQ29I/XgiZ52RIBVA5Z4fUSiHnNsMld3ypxPcvvbatC6pkgFHx4oiSxemKqjnVH
         1skYqXW8Tob1+BLjpW4yyhU/S8k4ikOdETfZUxMSgqiMLsHLKPwL83FKsrmEmOAgXSec
         Wbyov4JMFaTZxVekfQRz7IMDCry2Vrim2a+f4e2cgS6h6iDiReIDUGCGT5ltIvzOAow4
         Hqa5plegF3ZfVYpRrnAPghe5yb5FjCkIhrokj/KXyXqbKP+rAuTDLCpjEVCmWCO/6+yE
         WdpQ==
X-Gm-Message-State: AOAM531vwU8449bJSbihXg0ShxXVCud1U2DSHLidhISG+yNivJLno3sb
        wIN9ToASMKiMmMdgpwQgzt8=
X-Google-Smtp-Source: ABdhPJy0U1J+zwnKEq+EV027rYJd4hOUnGCdZisBhQTKyjZoAWY9B1JJ1MqYTpbjWgwZSDs/yhPqXQ==
X-Received: by 2002:aa7:8b12:: with SMTP id f18mr363582pfd.81.1589912522309;
        Tue, 19 May 2020 11:22:02 -0700 (PDT)
Received: from localhost.localdomain ([223.235.145.232])
        by smtp.gmail.com with ESMTPSA id p2sm148399pgh.25.2020.05.19.11.21.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2020 11:22:01 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v2 04/10] arm64: dts: actions: *do not merge* disable sps node from S700
Date:   Tue, 19 May 2020 23:49:22 +0530
Message-Id: <1589912368-480-5-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589912368-480-1-git-send-email-amittomer25@gmail.com>
References: <1589912368-480-1-git-send-email-amittomer25@gmail.com>
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

This commit disable "sps" to avoid this conflict and let us test DMA and MMC
related changes.

Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
Changes since v1:
	* No change.
Changes since RFC:
        * kept as do not merge.
---
 arch/arm64/boot/dts/actions/s700.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
index 2006ad5424fa..0397c5dd3dec 100644
--- a/arch/arm64/boot/dts/actions/s700.dtsi
+++ b/arch/arm64/boot/dts/actions/s700.dtsi
@@ -220,6 +220,7 @@
 			compatible = "actions,s700-sps";
 			reg = <0x0 0xe01b0100 0x0 0x100>;
 			#power-domain-cells = <1>;
+			status = "disabled";
 		};
 
 		timer: timer@e024c000 {
-- 
2.7.4

