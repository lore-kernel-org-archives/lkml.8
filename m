Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0C1C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 07:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC20B215A4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 07:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7AvK//P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgCDH2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 02:28:22 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45843 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgCDH2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 02:28:22 -0500
Received: by mail-pl1-f196.google.com with SMTP id b22so620268pls.12;
        Tue, 03 Mar 2020 23:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Gs8xOV9REFN752Csx9CR2qaFoIT578nSg5oH4PWWVU=;
        b=E7AvK//Pei/U+IA69nqJ7WRPQAak3EW/ixi9ZZDm5pp3n4vnr7PD/RbaGczhzgvTjU
         R83FR1c9MiJEV75uJg8q1ixnlL8ohA2seGp6sOG6PZ6wwF0FjX8TxZPuGa/nTQ8ZVwg3
         9O5+46CKQJ8P3ABz9TiTGzLFyW7A/LiXQQRAAVeRD7rR688oSn2LPfEmal/tJhfZRqKM
         IH530iphBf+XEqUpilREEWa7f+uEVSwFjgmXg52YSpulRzsLMQJbLcJ4mP9GEU39Z4fA
         lXv9CqJVVsDxiO5qm10+iRKjtnwhqFycl2dVFYz1sBDN7tlYO8LfghU49jvvPi69Q6y3
         jc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Gs8xOV9REFN752Csx9CR2qaFoIT578nSg5oH4PWWVU=;
        b=O7C84k2sq3KR8Aa7N58LvfFfahkmLpmOvM36tw9kL6H2ePOP+oA/PTji+GdqJFB+J1
         QHyWP7fh5ZqXArSnWKwLfhPOSMhZg83QZOnX9+n2AbWExBZBWtDCcZ+Ql4XIPpD50hiD
         v8nAFy/2x3wjtSAIqauPVVfKshkJGoKVJ009E9jenAe0lQiG3OaHwcXbqFdrYZxQZKMt
         D73WHbNBuJVg3rdtHJ1Yo9Ffd1SD+xCm2WOQ7kgLNgeu+nfT0+wlOFZigANIpgb7krPj
         6UaNThZADrYC1rDzvbMakHkOLsEgwh5AHZk4txNPeehfe86pOen4latqzDylaD1M+jmc
         6bXg==
X-Gm-Message-State: ANhLgQ3evQ/S43xwojaol2QWCLFqDEuHpY1IsYRemlWowpX2nctzge80
        MHWUU8+rNowTos9V1XphvJNTVsCR
X-Google-Smtp-Source: ADFU+vsonc0H7lXp9Rcj4M/Ph4erby4o7IXyQrWIfSamFgTNUPPA+VEmW/5/EkU4egBkoLxksWKe7g==
X-Received: by 2002:a17:90b:3612:: with SMTP id ml18mr1776107pjb.148.1583306900732;
        Tue, 03 Mar 2020 23:28:20 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j38sm23435859pgi.51.2020.03.03.23.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 23:28:20 -0800 (PST)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH v6 2/7] dt-bindings: clk: sprd: rename the common file name sprd.txt to SoC specific
Date:   Wed,  4 Mar 2020 15:27:25 +0800
Message-Id: <20200304072730.9193-3-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304072730.9193-1-zhang.lyra@gmail.com>
References: <20200304072730.9193-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Only SC9860 clocks were described in sprd.txt, rename it with a SoC
specific name, so that we can add more SoC support.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/clock/{sprd.txt => sprd,sc9860-clk.txt} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/clock/{sprd.txt => sprd,sc9860-clk.txt} (98%)

diff --git a/Documentation/devicetree/bindings/clock/sprd.txt b/Documentation/devicetree/bindings/clock/sprd,sc9860-clk.txt
similarity index 98%
rename from Documentation/devicetree/bindings/clock/sprd.txt
rename to Documentation/devicetree/bindings/clock/sprd,sc9860-clk.txt
index e9d179e882d9..aaaf02ca2a6a 100644
--- a/Documentation/devicetree/bindings/clock/sprd.txt
+++ b/Documentation/devicetree/bindings/clock/sprd,sc9860-clk.txt
@@ -1,4 +1,4 @@
-Spreadtrum Clock Binding
+Spreadtrum SC9860 Clock Binding
 ------------------------
 
 Required properties:
-- 
2.20.1

