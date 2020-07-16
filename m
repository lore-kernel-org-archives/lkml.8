Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7993C433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 06:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D02720760
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 06:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Ejy7ckch"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgGPGPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 02:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbgGPGPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 02:15:32 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D29BC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 23:15:32 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a24so3194606pfc.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 23:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DVb9BqnCCIXJSwGWTgbhyZjM4qcTaOK8ILi1j32bGuk=;
        b=Ejy7ckchYzB4B/cGUpLwzSLs5SWO7j2kWIG+QyF6S7cM+STr5Pl4msE6B3g3mVMpuY
         Hm4YOy9h2ZNvTyTyoj8vV4ybhx+YAPjv1RWuNVOzdC6IP+Z7PfXGASj1v5jqWLxXgqRr
         eAyUauN1faGhfkiAKtK24NGVy4EXFFBUCxIujb+A3mjvHyc4ykYXS2RFZB44h642U87z
         IWZsDw/RrO6K76WIUZMaPzuBLAgkG5sB6+ntFDxPM/uu99ODtxdV4FeWDXBP2wsTXukt
         8F0A4Iitb8y8P8Z2KaD9gNq8OW6rWkBfuQUEG7WT0fVS7WpIan4dtegFoitWZJ74X7bQ
         Eviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DVb9BqnCCIXJSwGWTgbhyZjM4qcTaOK8ILi1j32bGuk=;
        b=AXguJn7F6SgJ7hUrPUnSHEb5SAkW7Fydu5e8cFY95BpB5KTF+TcGyhhtQoq48S8oFb
         ufEXuIycxMvQpZ+I/h5xFlkRNSXJ2nsDEYcU1D2RaO9zGTVL/wX3X5cqLXB0ULdWAq22
         xxCwHYqiLDVC4mVRAbltBtFNDQoKSQ385nqET+Jetf+rzJd4Bh6yUO1lnbttQWPeANQQ
         8pPTyns2/nSbIhJPCfH+t/k5ylIb7fdQSSNnFX98HOWNgUL3+AsEfJE7vbMUSv4k/I42
         GvNbkbFZLpxWiKfJzQ8Fr43ty4ZzT/simWeZF27LLbfJIv9EQbL/RT0RGM2EAw5s6eyI
         M+BA==
X-Gm-Message-State: AOAM531AZlcrltyhyp/m0HemWck6em4vSWTRePfKsBmnHY6Ck8zN4l+G
        tfQBK+D5lZGXfX5X+NVwkJ7hwg==
X-Google-Smtp-Source: ABdhPJy4dj2Prxcig0aMdKJOiKAGjXoiqLvRtoIWGCfqYZeloqoaeRkaNEjF7GFc8mFQQ/QoRphcYw==
X-Received: by 2002:a63:b06:: with SMTP id 6mr2884850pgl.116.1594880131151;
        Wed, 15 Jul 2020 23:15:31 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id w20sm3669904pfn.44.2020.07.15.23.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 23:15:30 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 0/2] Fix some build warnings when W=1
Date:   Thu, 16 Jul 2020 14:15:25 +0800
Message-Id: <cover.1594880014.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches fix some build warnings when W=1, the most of warnings are
missing prototype as follows:

arch/riscv/mm/init.c:520:13: warning: no previous prototype for 'resource_init' [-Wmissing-prototypes]
arch/riscv/mm/pageattr.c:130:5: warning: no previous prototype for 'set_memory_ro' [-Wmissing-prototypes]
arch/riscv/mm/pageattr.c:136:5: warning: no previous prototype for 'set_memory_rw' [-Wmissing-prototypes]
arch/riscv/mm/pageattr.c:142:5: warning: no previous prototype for 'set_memory_x' [-Wmissing-prototypes]
arch/riscv/mm/pageattr.c:147:5: warning: no previous prototype for 'set_memory_nx' [-Wmissing-prototypes]
arch/riscv/mm/pageattr.c:152:5: warning: no previous prototype for 'set_direct_map_invalid_noflush' [-Wmissing-prototypes]
arch/riscv/mm/pageattr.c:169:5: warning: no previous prototype for 'set_direct_map_default_noflush' [-Wmissing-prototypes]
arch/riscv/mm/pageattr.c:97:1: warning: 'static' is not at beginning of declaration [-Wold-style-declaration]

Zong Li (2):
  riscv: Fix build warning for mm/init
  riscv: fix build warning of mm/pageattr

 arch/riscv/mm/init.c     | 2 +-
 arch/riscv/mm/pageattr.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.27.0

