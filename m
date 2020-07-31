Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59135C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 286AA20838
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uKRgypIp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731723AbgGaIRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 04:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731522AbgGaIRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 04:17:37 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE67EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 01:17:36 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id i15so361602wmb.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 01:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bTFDKHrOr0tLXLfJr207JWB+wcjynanq3pgWKIqA4K4=;
        b=uKRgypIpCW1rKGDco0MjUuNmUbafZbwdvtPDmkTCuGAJAMv67JbMOZ+FvdlcCuS5Cl
         sxCjqq5OZzU5FWipwo39QGDUqzjZraaz6z3FxW+pTQvisFV59NFONXqW66SBtjTdWpvW
         tO0XL0TOBFmg7f6DOBFuasGkOGhwVWUJXPcHoetht5bT6Ci7aSu1mCAneQi7Zd0j+oef
         g5ZeC58X7t/m5qE7s0TGVposLQhVWNwnYNjUlwCUMtxF6mBJ8z+6qW3uZzF7l5QZO+rP
         eGp2qpNFeyzscy3mF/EFLFDMRkCO2XZ1P4T2/+Rf3VEIH1oaLVRlXyL4Ly/nE51cYYky
         SG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bTFDKHrOr0tLXLfJr207JWB+wcjynanq3pgWKIqA4K4=;
        b=NwCCkz0F32sRdRYyKx2D4nTPK1P2D2z8XsyVPweUCOchI819zwHPHAofpLAXFY+GP2
         3/l3iHgx3EhI6Sv6VAWImTiA3144GprE+xKjTk85e5c1zTNGRAsHXnyId23+AMAwSL2/
         RQSzPye/WvWfb+Ybwa4kheVByKal2cpHI7CetN6kMMacdR7sPV7ijrbg3MkSwUapvDCP
         4baX5pDVT/6mERhL6L8VEN79NC61PpR8cyqhJmXDP/ZPnEnSkYCZ9OFXqdciG+H83lrU
         jANPr+gBkSueKIghN1uZrfOzgjcoPi4MIkZkeqdjcuCfNuUBOlkJL4WOsZfwyZHLh/RO
         xIQA==
X-Gm-Message-State: AOAM533eo61AW+amRfl81xo76ZDI6dTif2+DFQh1ayzgWC1IvEV6uLS9
        M1Hl6ZsOeclpqu0BZVJnR9o/JBB1zA==
X-Google-Smtp-Source: ABdhPJwtK/PKPKQK+A93qc3fHQBjpTVlA/3r5NPxqVxu1V40px8jDWWKeH3DS6D1B7R6bDE4GcBCAyvdVA==
X-Received: by 2002:a1c:6604:: with SMTP id a4mr2728713wmc.81.1596183455023;
 Fri, 31 Jul 2020 01:17:35 -0700 (PDT)
Date:   Fri, 31 Jul 2020 10:17:18 +0200
Message-Id: <20200731081723.2181297-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH 0/5] kcsan: Cleanups, readability, and cosmetic improvements
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     dvyukov@google.com, glider@google.com, andreyknvl@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanups, readability, and cosmetic improvements for KCSAN.

Marco Elver (5):
  kcsan: Simplify debugfs counter to name mapping
  kcsan: Simplify constant string handling
  kcsan: Remove debugfs test command
  kcsan: Show message if enabled early
  kcsan: Use pr_fmt for consistency

 kernel/kcsan/core.c     |   8 ++-
 kernel/kcsan/debugfs.c  | 111 ++++++++--------------------------------
 kernel/kcsan/report.c   |   4 +-
 kernel/kcsan/selftest.c |   8 +--
 4 files changed, 33 insertions(+), 98 deletions(-)

-- 
2.28.0.163.g6104cc2f0b6-goog

