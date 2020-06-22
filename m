Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72731C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53A5D20656
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20150623.gappssmtp.com header.i=@beagleboard-org.20150623.gappssmtp.com header.b="IvuoGUIW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbgFVRcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 13:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730067AbgFVRcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 13:32:20 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC496C061797
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 10:32:19 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id mb16so18853288ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 10:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bp2iCF0V+pxEB1qX+I4xhpc7NppyeLuUVo+dt6mFcSk=;
        b=IvuoGUIWcCIQo6CK77cG7w8/8i6yMRGu3jqAVtDneEVMOskWKPt1H5oEvI8WqMhZNy
         q3SZWQbxGmZX1YAnVnJLK3IZb+MNj06WDzV3WIOWGXbePqjg6Gr32LVdAm+ea4xL1J1R
         3uHLkLBW/4wYUdbOWNMEPxv0aCuTQsY3P2oXIKSxqAuZexLhJMJjaysulNWtJ9oTIJfK
         72vrHtPOxvoSYRgMDiorDeWTFthyA+/CQfOVWG7szw4j5gleM7rbHk0lDC2nfCgr24FK
         SVj5JBtkX2fLH2Ifz7i/LUeoqZubDhCzule77jMfzb6forrMTIIRz/JN/qtFMGyKwyrj
         QMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bp2iCF0V+pxEB1qX+I4xhpc7NppyeLuUVo+dt6mFcSk=;
        b=sZ2prVq5CtX5/9US4dPMRf5DHHNTPb8SwSojurFKNFLvcrSalYgLeu25DeS4fqNasz
         JfTt3rfk1uPr+A2aoesydW82PzBd1q7J14SsHgzWV5bN5tpd7c+SOfD3YhoEoSV2kFxi
         7adNTOhOkGCZnKNntmXQy9EyPNXeZj+AU3cPv9JQ1EJBcjtRp0FqpGVZvF/YrVhG0G+9
         J+q3QmCATxCihxeD9ydyML8o3qIQBhwmPacs6Absb+gxDuulh9RlwhmLdv2U321glydz
         RBkLJoHTdQA0DPpCnfEeBd/7RCLUaO5Ga0cBwCgkOyi/5GjDjb+m9ywNDK33LxGSutUE
         7Unw==
X-Gm-Message-State: AOAM533kbsqEvwBJoVaQjcaUCZTKrP4mGp0xihh2u0lJY27nxuy9aCO/
        /0Ra7enEfOlzb6PtY0/mO8eltg==
X-Google-Smtp-Source: ABdhPJy021kLIGLXUWAQwFLlIxfxylwPiPKp9FWG0opDvmlw8+MPskGqjPkQP4pPHMC+fjUtjPUFfA==
X-Received: by 2002:a17:906:454b:: with SMTP id s11mr17460979ejq.546.1592847138559;
        Mon, 22 Jun 2020 10:32:18 -0700 (PDT)
Received: from localhost.localdomain (i59F66838.versanet.de. [89.246.104.56])
        by smtp.gmail.com with ESMTPSA id z1sm4747386ejb.41.2020.06.22.10.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 10:32:17 -0700 (PDT)
From:   Drew Fustini <drew@beagleboard.org>
To:     Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        devicetree@vger.kernel.org, bcousson@baylibre.com,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@gmail.com>
Cc:     Drew Fustini <drew@beagleboard.org>
Subject: [PATCH v3 2/3] ARM: dts: change AM33XX_PADCONF macro separate conf and mux
Date:   Mon, 22 Jun 2020 19:29:50 +0200
Message-Id: <20200622172951.524306-3-drew@beagleboard.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200622172951.524306-1-drew@beagleboard.org>
References: <20200622172951.524306-1-drew@beagleboard.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM33XX_PADCONF macro is modified to keep pin conf and pin mux separate.

This requires #pinctrl-cells = 2 in am33xx-l4.dtsi

pinctrl-single.c but also be changed to support "pinctrl-single,pins"
with 3 arguments (offset, conf, mux)

Signed-off-by: Drew Fustini <drew@beagleboard.org>
---
 include/dt-bindings/pinctrl/omap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/dt-bindings/pinctrl/omap.h b/include/dt-bindings/pinctrl/omap.h
index 625718042413..2d2a8c737822 100644
--- a/include/dt-bindings/pinctrl/omap.h
+++ b/include/dt-bindings/pinctrl/omap.h
@@ -65,7 +65,7 @@
 #define DM814X_IOPAD(pa, val)		OMAP_IOPAD_OFFSET((pa), 0x0800) (val)
 #define DM816X_IOPAD(pa, val)		OMAP_IOPAD_OFFSET((pa), 0x0800) (val)
 #define AM33XX_IOPAD(pa, val)		OMAP_IOPAD_OFFSET((pa), 0x0800) (val)
-#define AM33XX_PADCONF(pa, dir, mux)	OMAP_IOPAD_OFFSET((pa), 0x0800) ((dir) | (mux))
+#define AM33XX_PADCONF(pa, conf, mux)	OMAP_IOPAD_OFFSET((pa), 0x0800) (conf) (mux)
 
 /*
  * Macros to allow using the offset from the padconf physical address
-- 
2.25.1

