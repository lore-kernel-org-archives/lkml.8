Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D055C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A88020771
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCiAjhKb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730118AbgGBOxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730093AbgGBOxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:53:45 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D42BC08C5C1;
        Thu,  2 Jul 2020 07:53:45 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id l6so9461650pjq.1;
        Thu, 02 Jul 2020 07:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mYopmo1QBURxBReeOvkyb4h/1ly+5I6BoxpJA64kn10=;
        b=kCiAjhKb7ZPCkH158lWZPcMXv3MO0ArqKd6DTfiZepXpUNh9e7vAQbcyQHlR6vbQYl
         TNL+3G5nxfJ72EucIziSFz90+14Aj3vdW6j38NbXGFcyo+eY8LFyi9WCgYeBARhQEwco
         D5LR1rY1Dt6qE6eTEMQ0pbxS50zcDd9krt7UJumi9Dbk/k0CK5e71SnJ9oPHu8fbnf1t
         swXRvvIQvrTGgNyoe9/02FnFFDVbBkqlrpqcZA3Csg1tO8k02pjhB8enLET+c0UfqYyo
         SLclEnRUKF+/Oxq71lwO7EJwJteUQUzPAGGw2csdPwFWrNGgZvNIXUyELaohAavMulTu
         Ebyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mYopmo1QBURxBReeOvkyb4h/1ly+5I6BoxpJA64kn10=;
        b=qI2SmxIrdjECzGV6L5dkEpfP+FmFSNtZcyp8DbnpfbitJx1RmkAM7mt97ciUxjHEW5
         Gjpb9TaxVG3ScvrwfcW/khHA4jpQTY9EJZAFeE41VwMPpndGBWRuSAGeD5TWgpoHThW3
         TpQwzQqOCl04ItdP7f040D5qOjQIInuaCwnxUg8nbgZAk0g4lS1v5UPmflRcsTm+VgDA
         AbTgSfyRh0L3L8W3p5nETOpzuahq2+sQ8XDHefPWqM4P97Rg7bJZD244Gh5DgS1PcOOf
         AIssGCDWuUWwul70WjdzBwsXrOCyQPLutsLSKE6HdaRYQYmH46AMnP2m9Y4BC6Yo4wZD
         K+oQ==
X-Gm-Message-State: AOAM532EuhOAKx3lgwGI/Pbu52WVHoUj+YRU8Yeb6hNjFmVwfL+QafgB
        bl5iFRWhj8qou9nyhxQ5Kf8ecHGjqaOABQ==
X-Google-Smtp-Source: ABdhPJxupsFb04RY/hgMT8GQWqc156FJz5i+PZf/E+i+Q3b1IhAackvmZzIN6uY6CdajVwz2TOJYqA==
X-Received: by 2002:a17:90a:26a4:: with SMTP id m33mr13170620pje.124.1593701624760;
        Thu, 02 Jul 2020 07:53:44 -0700 (PDT)
Received: from localhost.localdomain ([223.190.0.253])
        by smtp.gmail.com with ESMTPSA id 204sm9487891pfc.18.2020.07.02.07.53.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jul 2020 07:53:44 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de, vkoul@kernel.org,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     dan.j.williams@intel.com, cristian.ciocaltea@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v5 06/10] arm64: dts: actions: Add DMA Controller for S700
Date:   Thu,  2 Jul 2020 20:22:52 +0530
Message-Id: <1593701576-28580-7-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593701576-28580-1-git-send-email-amittomer25@gmail.com>
References: <1593701576-28580-1-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds DMA controller present on Actions S700, it differs from
S900 in terms of number of dma channels and requests.

Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
Changes since v4:
	* No change.
Changes since v3:
        * Fixed typo in commit message.
        * Placed owl-s700-powergate.h in alphabetical order.
Changes since v2:
        * added power-domain property as sps
          is enabled now and DMA needs it.
Changes since v1:
        * No Change.
Changes since RFC:
        * No Change.
---
 arch/arm64/boot/dts/actions/s700.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
index f8eb72bb4125..2c78caebf515 100644
--- a/arch/arm64/boot/dts/actions/s700.dtsi
+++ b/arch/arm64/boot/dts/actions/s700.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/clock/actions,s700-cmu.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/power/owl-s700-powergate.h>
 #include <dt-bindings/reset/actions,s700-reset.h>
 
 / {
@@ -244,5 +245,19 @@
 				     <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		dma: dma-controller@e0230000 {
+			compatible = "actions,s700-dma";
+			reg = <0x0 0xe0230000 0x0 0x1000>;
+			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			dma-channels = <10>;
+			dma-requests = <44>;
+			clocks = <&cmu CLK_DMAC>;
+			power-domains = <&sps S700_PD_DMA>;
+		};
 	};
 };
-- 
2.7.4

