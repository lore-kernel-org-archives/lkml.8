Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7884CC47258
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 07:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5266C2071C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 07:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uHgfP9cW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbgEAHkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 03:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728383AbgEAHkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 03:40:13 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA75DC035495
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 00:40:13 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o185so4250153pgo.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 00:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QD+OM/IPa9x7hJvHclwxEGNJ9gIn9LRrmuc2cMqM+jk=;
        b=uHgfP9cWbKjgsICCn22DXY5E8YVkK4lR5mSH38oijVyLq+WDsYAckO411+fCRx4fSG
         92T98KiXWYh/Veuu9k4mILrjo6zo4M8S4hPIn1pjXH4afDJRgMkF3HIHomYHPtbJ2CIT
         oHO3AozrS69KPbj/CTUAtS0sIYMkdKaiEqIvnSOR5NCG1ZOjYGvWsRTbWlGF2X+swrpU
         pF1SZxSAvCiYlvGEZHBmQuMPgM/YMkwvPoLMwh2SWAo7qUkc5ifkQoPpgJfJmVVL5VBG
         jEdBB2/STxwoSAR6Dj/ZZDJ0PZXyVaXxiFVJoKoWWEDCYQLst2EN08W0fE9yARqfug+f
         NI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QD+OM/IPa9x7hJvHclwxEGNJ9gIn9LRrmuc2cMqM+jk=;
        b=et8tJTQswvwQaxnzrZCDlsTr/FN/PZjhEkBn5w+pwVYrFKD8tqO3te5Z012xlwhxhQ
         sIxcitKRtdlX2BtFshmjIoYkFzKClkHlc0fJXD3oSHqW3gRyL2+wXfqkSngJ92+H3mbi
         qGUKxh2RWp0CEEfU9nBplrhvAUgWPROc1FPswf2YO976f81jn/9itf0G5Y3yFAnv3ahn
         seIbBRcZJSXHS89Jx1JrpvQ8P2QhqynlN0sDrS4vBdE4XHl35qF87YKCrSifWU4d01+5
         gNkYZ2VZUV+0YU56B43KAH6dhCWy6agv2qc5TLhmo+dktWDUBHJtS6kfavy0Lndcgr3P
         80Ig==
X-Gm-Message-State: AGi0PublD/IM3oZaxfM5nfS4Em7XgAlQ5aP2f76dGo97xZxmfHWQHgFA
        UbpQhnkQhGr8jW2bIub3L/9DZY/9cbY=
X-Google-Smtp-Source: APiQypIe0OyaYrak6ULk6jy1juCWPHfm+627JYy+N9jmFW5Ppc7wa4zxgW6OTSiIq3XBtubeLxsMWQ==
X-Received: by 2002:a62:e113:: with SMTP id q19mr2839382pfh.107.1588318813249;
        Fri, 01 May 2020 00:40:13 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id w12sm1557841pfq.133.2020.05.01.00.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 00:40:12 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "Andrew F. Davis" <afd@ti.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org
Subject: [RFC][PATCH 4/4] example: dts: hi3660-hikey960: Add dts entries to test cma heap binding
Date:   Fri,  1 May 2020 07:39:49 +0000
Message-Id: <20200501073949.120396-5-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200501073949.120396-1-john.stultz@linaro.org>
References: <20200501073949.120396-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds example test entry to create and expose a dummy "camera"
cma region via the dmabuf heaps interface

This isn't a patch I'm submitting to merge, but just an example
of how this functionality can be used, which I've used for
testing.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: "Andrew F. Davis" <afd@ti.com>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Liam Mark <lmark@codeaurora.org>
Cc: Pratik Patel <pratikp@codeaurora.org>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Brian Starkey <Brian.Starkey@arm.com>
Cc: Chenbo Feng <fengc@google.com>
Cc: Alistair Strachan <astrachan@google.com>
Cc: Sandeep Patil <sspatil@google.com>
Cc: Hridya Valsaraju <hridya@google.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: devicetree@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-mm@kvack.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index c0a6aad9593f..5eef1a76d51a 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -81,6 +81,13 @@
 			reusable;
 			linux,cma-default;
 		};
+
+		cma_camera: cma-camera {
+			compatible = "shared-dma-pool";
+			reg = <0x0 0x24C00000 0x0 0x4000000>;
+			reusable;
+			linux,cma-heap;
+		};
 	};
 
 	reboot-mode-syscon@32100000 {
-- 
2.17.1

