Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F9EC3402F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 04:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18AC24655
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 04:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vLyMPGSJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgBSEKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 23:10:16 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40558 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgBSEKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 23:10:15 -0500
Received: by mail-pj1-f68.google.com with SMTP id 12so1959478pjb.5;
        Tue, 18 Feb 2020 20:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Gs8xOV9REFN752Csx9CR2qaFoIT578nSg5oH4PWWVU=;
        b=vLyMPGSJt+lHmUwpSvxy7BpwgUeatvKf9++z2u7QG9F3XAEqyLLmYTi9i22YEBuDCb
         nnOWtqjysHSgwKPkPQxhah9RKmYlOKhcfcvvPwl9wAZth2PGbXVXG/hLQSUf4XXZFmb6
         vE7cLNJ1sA7DOKAFSWWMh6tmCclD+lnYfD1r0J+vt3tV1v/iR8onx0JFwEafSFCnTkqF
         dvPP+kVRFcnLJMVMTJ4HaOgd+HydrSbFQ1aZEFMwXcx/OE0aukK7/gven8xyWffL47gh
         BbLIAm98PSOZqutfIbAz/n3jo3h7fB58HIUXqN+Nb/hIBl5lpt0em6wm5nGsNUs0eo30
         EOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Gs8xOV9REFN752Csx9CR2qaFoIT578nSg5oH4PWWVU=;
        b=VHgPksJlHu/oBiAnaNvnMeh9rmYuMtxqMsAuEQdSSIioNuwG3tc7p60KeCbhTtYX3t
         Vdiy0SwT8LK5wxpOG/rl4fnzSGYQnwSzCHDON8hE7AE6u1QE7+vin9vKal7AqEwRWxDW
         GBgZ3yHeRfafIx6eM0bbgBowja8ej0+R0LVp1JXq776JyVUvsRjb0ar49TJf9jPmT7pE
         f5uXDNpHpf+jvazoHI8iKUqoVLHEfE4MUEKZtsGNpF1B40MF8Fj70rl0yBHp+tKBrm1h
         LyaS5SlBWRpmW9/VSHyscIWZ/tCB94pb2+80EsLn9rs63MgOExjCktu/DrwCvB5wT1NE
         yhwQ==
X-Gm-Message-State: APjAAAUcLa5H7qCjdmzuW/NB1nCHCLLBZPEZLI1dzuh4zuEr4giG1ahA
        kKAfEZH+OiULQwQqV5gKBvI=
X-Google-Smtp-Source: APXvYqxAicWm/tKrK+rxINEefsUWz/ugxNUI5I+nENIlMM3af6gWzoMdNjBGVpUFVlZEZ+iy/raodw==
X-Received: by 2002:a17:902:264:: with SMTP id 91mr24696850plc.335.1582085414568;
        Tue, 18 Feb 2020 20:10:14 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id q66sm578748pfq.27.2020.02.18.20.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 20:10:13 -0800 (PST)
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
Subject: [PATCH v5 2/7] dt-bindings: clk: sprd: rename the common file name sprd.txt to SoC specific
Date:   Wed, 19 Feb 2020 12:09:10 +0800
Message-Id: <20200219040915.2153-3-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200219040915.2153-1-zhang.lyra@gmail.com>
References: <20200219040915.2153-1-zhang.lyra@gmail.com>
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

