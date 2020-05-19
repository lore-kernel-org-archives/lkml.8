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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F90C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C33E207D4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ij6+bxv7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbgESSXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 14:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgESSXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 14:23:00 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC9CC08C5C0;
        Tue, 19 May 2020 11:22:59 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id c75so225803pga.3;
        Tue, 19 May 2020 11:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uGEwfxSdBJsa1cl2OhaQcNUabf3AWdgD6M5N7pLugTg=;
        b=ij6+bxv7fFtCxpEQ9Gr6ekFLP/RsJYV+6sbKkhvZCCXww7tao0vEz4DvtyhfyAY2Wg
         EN28jlRR3zk6z1NkVF5o1y/ACBVEeokemkFjj1inJAGM1uP+Qxn5bmSLxm//Mkh5oOds
         kU/KQRcsQTswUfSLWcKd65s5z5ZrLcnTZa/RBXINDA2EtXFWrgVKwDvQX6y/NeKK823B
         V6d9h9YVKcgenTvjqWQvOwyAygT1vwkOlC03tdtmqWEurMrqQtoLxDvY+Hn23aE6Rb7G
         Fqp6rrQEAXtVw8fBfwc9ZPlFjHsdN2FTl+3LjnROjGWxIf5UjH8NNjrBGSECS4sRPUAn
         5pbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uGEwfxSdBJsa1cl2OhaQcNUabf3AWdgD6M5N7pLugTg=;
        b=bVJUoGynNNm4cnr/ib7I3lfZn0sqEpwcByd1BHXM+pcS62jYW1uQZ6bssLYGuDs85A
         0EuO/PYzlfC5H7h5MXqthp5vjKuDFtlEU98ynRcIGr9d95lgNHAS0nyLAwya8qwjs0F9
         UoxfgWMVKEo75z1SDTHZ/XFrOYbyDwltmIV0hBtbJ7r6yPlKP+pE5DO0s7JmwYWCF2fX
         Pw/XCh5uLfFz9aHgnwPnwRFRvZwNWmcBk7HcD4646Q9kZXTr/Yan79HjabEVH7Ex20zE
         b9orDZUSlqad+c9PZ6uUh1Ky42MNas7Z9bOOV1hVqHxyGtEJVWiT04mLE6pmMnIdoKfn
         cUhA==
X-Gm-Message-State: AOAM531+vs/5FTw6YXwYHBwVGZZA/5ctOQT8EoDpK74bOsKzamwilehv
        vvwfxMu0MOxN10ddCOQS9lw=
X-Google-Smtp-Source: ABdhPJxZ9KFCkQajAnh38GMums9lL5yY536fO7g6rycFYOQ7DRp9V8mWl/fpQGYMcK1GwcCpgGnRlw==
X-Received: by 2002:a63:e70b:: with SMTP id b11mr503149pgi.88.1589912578979;
        Tue, 19 May 2020 11:22:58 -0700 (PDT)
Received: from localhost.localdomain ([223.235.145.232])
        by smtp.gmail.com with ESMTPSA id p2sm148399pgh.25.2020.05.19.11.22.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2020 11:22:58 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de, vkoul@kernel.org,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     dan.j.williams@intel.com, cristian.ciocaltea@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v2 06/10] arm64: dts: actions: Add DMA Controller for S700
Date:   Tue, 19 May 2020 23:49:24 +0530
Message-Id: <1589912368-480-7-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589912368-480-1-git-send-email-amittomer25@gmail.com>
References: <1589912368-480-1-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds DAM controller present on Actions S700, it differs from
S900 in terms of number of dma channels and requests.

Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
Changes since v1:
        * No Change.
Changes since RFC:
        * No Change.
---
 arch/arm64/boot/dts/actions/s700.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
index 0397c5dd3dec..56f2f84812cb 100644
--- a/arch/arm64/boot/dts/actions/s700.dtsi
+++ b/arch/arm64/boot/dts/actions/s700.dtsi
@@ -245,5 +245,18 @@
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
+		};
 	};
 };
-- 
2.7.4

