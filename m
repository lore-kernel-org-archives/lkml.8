Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C137EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F35220836
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UYyFvt0y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgGCI6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 04:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgGCI6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 04:58:00 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248FBC08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 01:58:00 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mn17so319645pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 01:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l5krbZyzVlqtJlOtCzvF9lWot4EaX2wFJODMLjpfT4I=;
        b=UYyFvt0yHy8s+GaHXFDWNpCmUSIIUi1ARn1Nol8baUVBhpIIPAvw//y55ov/JDYZ9E
         DcIzzfh7GLHhx7zBBS2T/noiqaLvQdRYIVsvbapYFWozPXkRSqMdDYptpp/J68qPJbVs
         PuZlS69ZvO2fuKtpWKI9YGWVG293nIWvJGUQ8M0yySw1WJhkPDKsxKY3cSrbVK7RX6Wx
         40MeCtPwwA25KJ4/SF9fp8Xa2f7vZr46RMz9dzrcvdRpNkfsz0CXSBgTAJ/G2zyJYBhY
         dl/8a9rInKt8BA9505EvF6SVg9U9MgQLAMJbQVeGdEsxJH+PsbIzskM1fdx+ctoHn8hs
         wPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l5krbZyzVlqtJlOtCzvF9lWot4EaX2wFJODMLjpfT4I=;
        b=qsKsLKEIsmVZRk7qcUXCBaphHtyCc4co1uRV/i1cF+gO3zvuIxfo44ETFqgCX1efk/
         FxKJAbHsjQGbPHIIie4mqL+Cd4eSWiYdfeigy0aqlYKCiEpBdMKWA5+Wqgmk43+c7aNo
         6LcwAZezdDYj261PlYzrBFZi67Xw/WHQHtAnti+jygONKpMRzXIyjucOnQG7wBR5qG7L
         tMRF0QtUiSa2cjusmBxc4NWg8d+NNrKHrQ4yAwvOC1Nu7jKiYXWrRR7pG2fQ70zMna5k
         JVceKQQLIa/NpRh72rudaufqPN4ey29SOTOVY4zsBVJZBZxkm4TDNpI5BUv4MnvGcTsj
         pefA==
X-Gm-Message-State: AOAM5311tUcfHZBZgOf5JXbfeijOO3ywbRlZHf+Ww+yK7YLJYkm/NSsm
        tz7l89e7gQAwN5HEQ86Pp88Fo/bh9zI=
X-Google-Smtp-Source: ABdhPJziBzbhbh7LkHtY3EnPldKzpWtTLtYu7SsscIuCrPkd9X2YdWZoAir/RegXx6s4AkyF+pNL6Q==
X-Received: by 2002:a17:90b:1386:: with SMTP id hr6mr35394676pjb.93.1593766679662;
        Fri, 03 Jul 2020 01:57:59 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id l23sm2126287pjy.45.2020.07.03.01.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 01:57:59 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 0/3] Get cache information from userland
Date:   Fri,  3 Jul 2020 16:57:52 +0800
Message-Id: <cover.1593766028.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no standard CSR registers to provide cache information, the
way for RISC-V is to get this information from DT. Currently, AT_L1I_X,
AT_L1D_X and AT_L2_X are present in glibc header, and sysconf syscall
could use them to get information of cache through AUX vector. We
exploit 'struct cacheinfo' to obtain the information of cache, then we
don't need additional variable or data structure to record it.

We also need some works in glibc, but we have to support the function in
kernel first by rule of glibc, then post the patch to glibc site.

The result of 'getconf -a' as follows:

LEVEL1_ICACHE_SIZE                 32768
LEVEL1_ICACHE_ASSOC                8
LEVEL1_ICACHE_LINESIZE             64
LEVEL1_DCACHE_SIZE                 32768
LEVEL1_DCACHE_ASSOC                8
LEVEL1_DCACHE_LINESIZE             64
LEVEL2_CACHE_SIZE                  2097152
LEVEL2_CACHE_ASSOC                 32
LEVEL2_CACHE_LINESIZE              64

Zong Li (3):
  riscv: Set more data to cacheinfo
  riscv: Define AT_VECTOR_SIZE_ARCH for ARCH_DLINFO
  riscv: Add cache information in AUX vector

 arch/riscv/include/asm/cacheinfo.h   | 14 +++++
 arch/riscv/include/asm/elf.h         | 13 ++++
 arch/riscv/include/uapi/asm/auxvec.h | 24 ++++++++
 arch/riscv/kernel/cacheinfo.c        | 92 +++++++++++++++++++++++-----
 4 files changed, 127 insertions(+), 16 deletions(-)
 create mode 100644 arch/riscv/include/asm/cacheinfo.h

-- 
2.27.0

