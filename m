Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E056C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAC2A20656
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVBFGmcG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbgHXVUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 17:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHXVT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 17:19:56 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6B5C061574;
        Mon, 24 Aug 2020 14:19:56 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id g6so105692pjl.0;
        Mon, 24 Aug 2020 14:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ubn8Ygt3LOORDEBZIqrY09E37xtge/HiuDXDH6cz5po=;
        b=JVBFGmcGmSWsz9bYllOKTJ2ZeE9TP2Kw+25wP3wiTjEs/w8rXBS3cY6HAo7tZ9b6qq
         z9d2tviGGmc+rYAsiIH/YXjcOj2TeuM4TFih4RDUGQ2fORwBCTHGhNbp51SdUgxpvV5j
         hBqlWgYC5NZO+wsKW7oWPKBersSSzu9iZIQn0MOUJunMyllfdzD65zkVQ7mYC4Y9Ax3P
         tuzsTK6IZ4ccnYcvd5o1+XIGRWxeuHjsmcwbKj5GB/5Ep2/rcPTRNesCfGQxPSQ2L7kT
         1sZZ9ggD3o+v72/YOlmVz6AH6PAqiHsO+q+d/5o+saMWqoitT6AN9JkTeNy8/ND+fiR4
         UZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ubn8Ygt3LOORDEBZIqrY09E37xtge/HiuDXDH6cz5po=;
        b=PZuPxghQ4jUZa3nLP5s/Z2+Qt5IzPQ4xSIqN6JWDUiZAvqDtGxKz5/Si/W+LM3v+YU
         YxwiaCNuce5ur6M115Km3APYJTFzMTkuYmMUcqY13iestxrs9SskQtts76TZxgYeddw5
         GHSdej7Xnam6qlqIwM+tDspt0FSFhF8Pfwz1NmKKwr7144vlnkuWXOA/h87zVlHK7rYm
         II36LN07z16ntHVWikS+Xphzgunk+SvQqe5VpMH45y5lSTXm7/WVM5g3a7+oStEamoqF
         w6hMYmauUhDkR+55KVjOpk0FUCf+IW+3wrUozT2c8UyRvyYsoVxZpFvyiT2iLRKvdSKT
         cXYg==
X-Gm-Message-State: AOAM530I0R7xz7wtZJnDJYR9QquTgFGrwk+L8RbRPimj8xGEFOXKht/v
        xeA5r9syanH2HKTS+BVk42K57rs2tHWrFZkc
X-Google-Smtp-Source: ABdhPJxg+9Q3F3q7vivl+srkbNQE74Bxef4gWwHaXun2cCyrH8AN+9ABF5qNI94MyZFjOgkAml3BMQ==
X-Received: by 2002:a17:90a:ccd:: with SMTP id 13mr915003pjt.123.1598303995731;
        Mon, 24 Aug 2020 14:19:55 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id t10sm97788pfq.77.2020.08.24.14.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 14:19:55 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 0/5] ARM: dts: aspeed: Add Facebook Wedge400 (AST2500) BMC
Date:   Mon, 24 Aug 2020 14:19:43 -0700
Message-Id: <20200824211948.12852-1-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

The patch series adds Facebook Wedge400 (AST2500) BMC device tree, and
FMC flash layout is re-structured because flash size and layout varies
across different Facebook AST2500 OpenBMC platforms.

Patch #1 removes flash layout from ast2500-facebook-netbmc-common.dtsi
because now we have 32MB, 64MB an 128MB flashes on different Facebook
AST2500 OpenBMC platforms.

Patch #2, #3 and #4 sets FMC flash layout in CMM, Yamp and Minipack
device tree explicitly because the original layout settings were removed
from ast2500-facebook-netbmc-common.dtsi (in patch #1).

Patch #5 adds Facebook Wedge400 AST2500 BMC device tree.


Tao Ren (5):
  ARM: dts: aspeed: Remove flash layout from Facebook AST2500 Common
    dtsi
  ARM: dts: aspeed: cmm: Set 32MB FMC flash layout
  ARM: dts: aspeed: yamp: Set 32MB FMC flash layout
  ARM: dts: aspeed: minipack: Update 64MB FMC flash layout
  ARM: dts: aspeed: Add Facebook Wedge400 BMC

 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts |  17 +
 .../boot/dts/aspeed-bmc-facebook-minipack.dts |  47 +-
 .../boot/dts/aspeed-bmc-facebook-wedge400.dts | 420 ++++++++++++++++++
 .../arm/boot/dts/aspeed-bmc-facebook-yamp.dts |  17 +
 .../dts/ast2500-facebook-netbmc-common.dtsi   |  13 -
 6 files changed, 500 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts

-- 
2.17.1

