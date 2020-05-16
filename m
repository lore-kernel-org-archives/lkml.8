Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896D1C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 12:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B86220727
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 12:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdZgSeub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgEPMuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 08:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726206AbgEPMuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 08:50:01 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A90C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 05:50:01 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id fu13so2317215pjb.5
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 05:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y/pu6s9heqLQoPscPRtZWIfWJlyEAE3JhcWqjsVnWMo=;
        b=RdZgSeubYs284jc/aj+vQ6MytNBYmTMw9MitZUl3I4N9Iup5ZDFXQE6pvEMdjkcCF1
         ZspPNeToui/wJwJEKDNqRBmdT9QxQhHaD+UBSTScFwosklKooOUmuMHG+ibsYSN2Sxu7
         XfZ8/4fDYQXF7M2q6ZZiO/6RKWgWI+5UeI2hHs1YYBcxHsYy9Ay7/4mTDkfgUA6UtDcv
         Si34VJBFujnZx+3IkwWZnIp9wJciQAKYEnjPeLS3E0usZhOBq5SenAZOfJdE76R8gSCb
         qURUDvhC8wIVwNy9CKGnVqroqfv7MUmYNQj50xuYHhmHl2eSuNcgMpHRudn7fTro3q7O
         MG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y/pu6s9heqLQoPscPRtZWIfWJlyEAE3JhcWqjsVnWMo=;
        b=mEQKOZjIkWsvPNOIRIGK+P6iLCw78oICIShANlRgwG8//id14Z9//N+4ltfhYBcxuw
         cXAua3DRz9Zd4uIKv0bs3uOqtdNQ27ZyRllFp8kkFm+b6cCN5OWJZefk9IwhPbDjrKR+
         g1tkorxNpBbEJRP6+kLBZp0o0gxx3SLlWLQFB3EPGlAfNs5iY2AouaZydPdxoMGbIcKc
         8xumH1mcc5hHNsX90yA/Ih0XnlTtVX8rEydR6++Yi1FF/FhlEO9kP6wTe74WxUKAU//I
         JUhe4oDM3FbGepQO+qIxaddEFZEp9D4u2A3i6HZv6UkJnwmJp4dFvTbXnvOWSdF0Lzuh
         +2bA==
X-Gm-Message-State: AOAM531HTHC4aa+HZLjSUR1TAHTcxneZarhgLE7ImnyS/oxZH+yP9cyP
        jpJEBk4UySys7kfqmDX5ADmY2uwb
X-Google-Smtp-Source: ABdhPJy2I3ru751urDomegpMHM+LuOGE8PrXhFnO8+ShubkkeVhH+WuYkkZ2G/DJlpcqL/9BEjaeFQ==
X-Received: by 2002:a17:90a:c584:: with SMTP id l4mr8877644pjt.195.1589633400684;
        Sat, 16 May 2020 05:50:00 -0700 (PDT)
Received: from localhost.localdomain (61-228-240-171.dynamic-ip.hinet.net. [61.228.240.171])
        by smtp.gmail.com with ESMTPSA id k27sm3768323pgb.30.2020.05.16.05.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 05:50:00 -0700 (PDT)
From:   Lecopzer Chen <lecopzer@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     lecopzer.chen@mediatek.com, linux-arm-kernel@lists.infradead.org,
        matthias.bgg@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, acme@kernel.org,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-mediatek@lists.infradead.org,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        yj.chiang@mediatek.com, Lecopzer Chen <lecopzer@gmail.com>
Subject: [PATCH 0/3] arm64: perf: Add support for Perf NMI interrupts
Date:   Sat, 16 May 2020 20:48:54 +0800
Message-Id: <20200516124857.75004-1-lecopzer@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These series implement Perf NMI funxtionality and depends on
Pseudo NMI [1] which has been upstreamed.

In arm64 with GICv3, Pseudo NMI was implemented for NMI-like interruts.
That can be extended to Perf NMI which is the prerequisite for hard-lockup
detector which had already a standard interface inside Linux.

Thus the first step we need to implement perf NMI interface and make sure
it works fine.

Perf NMI has been test by dd if=/dev/urandom of=/dev/null like the link [2]
did.

[1] https://lkml.org/lkml/2019/1/31/535
[2] https://www.linaro.org/blog/debugging-arm-kernels-using-nmifiq


Lecopzer Chen (3):
  arm_pmu: Add support for perf NMI interrupts registration
  arm64: perf: Support NMI context for perf event ISR
  arm64: Kconfig: Add support for the Perf NMI

 arch/arm64/Kconfig             | 10 +++++++
 arch/arm64/kernel/perf_event.c | 36 ++++++++++++++++++------
 drivers/perf/arm_pmu.c         | 51 ++++++++++++++++++++++++++++++----
 include/linux/perf/arm_pmu.h   |  6 ++++
 4 files changed, 88 insertions(+), 15 deletions(-)

-- 
2.25.1

