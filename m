Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9995FC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 763F6206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzO7N1IJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgHaStW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgHaStV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:49:21 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BB8C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 11:49:21 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id v54so4068783qtj.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 11:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1cLKbrfJy/ZGWttaSw8KlAZUFaKAWrS+yHm9C8wTwuc=;
        b=BzO7N1IJW/105kqPoLoVuE1QamuzdOIPyBu8Oa2WvipHCs9Z5jp7KhYBcM9Iig/zPs
         OP1rWZL/QxUbGOf1lmYJ1ln8gZwftqbDc0JswX8TwvnfOoyZ/9YeH5LKXysxQJaPGrRX
         w16G9XhvTtIb7AqweRgYdhFXqj2RD1M7um6OWG8wVDHBdYhCFbPkWaZaL27hAxq9DNPC
         r8yO2HZbKJXKtZgT1G1FL1GXSalLRcUXZH4OSF//Q31hLIWN39bfNbZgT7y4gvnRgr2C
         lzWwpwbV4R2WP8hwpr/3tF0xkYVdvkFaP4FRobW4ekPuPliC6XALWAldtA1fE2ysqJEJ
         pvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1cLKbrfJy/ZGWttaSw8KlAZUFaKAWrS+yHm9C8wTwuc=;
        b=Ovukd1tLBHg/cq/dJC6of2ngi/zjXwC0YQr/NErtmKbL/GxbEXYDUI+w+TjNZc7TPT
         1W0fA5WHmZw73X8UT4dq4OViVMR++nu1v7TaR0HqKJgqdOLsM/1bcXtxkA/wHBkLkFyI
         Lnqj1Uea1h0b/e57sFnnOG3cDCKxOXngnYpHbbCnmUS873JG3Fh6h/bazlSNJqM2suKi
         27g1K7NOjNFPG+rKk8ftXWYJAk6OhzScRXvN4rc/Ni/aWyLAXiMBlqeFpTZTa7QWE28N
         Sk/3PsGLP5Q7v5gmfptAoDvj4R/Uw8fToiHI195FOnfXWAENnE3YPr0eQ4+9rvVLl/3O
         kNbw==
X-Gm-Message-State: AOAM531GzT2GzmllJCG4P8YAmaGVIRaOK7zDCKw1mrIjyD156tmmURdC
        uQh12gj3+IcsWEXrN3UOuIY=
X-Google-Smtp-Source: ABdhPJwrU//AIQuoxvEgis/nTcNp0HgSLFIRo8YjHf0Sy1UbWZK10GmXnZ+6ozodFL0tmiiFglf2Hw==
X-Received: by 2002:ac8:4248:: with SMTP id r8mr2635412qtm.218.1598899760454;
        Mon, 31 Aug 2020 11:49:20 -0700 (PDT)
Received: from LeoBras.ibmuc.com ([2804:14d:8084:8e41:9b0d:571e:a65:b5d8])
        by smtp.gmail.com with ESMTPSA id s17sm11779070qte.50.2020.08.31.11.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 11:49:19 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Leonardo Bras <leobras.c@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Nayna Jain <nayna@linux.ibm.com>,
        Eric Richter <erichte@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Brian King <brking@linux.vnet.ibm.com>,
        Murilo Fossa Vicentini <muvic@linux.ibm.com>,
        David Dai <zdai@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] DMA pagecache
Date:   Mon, 31 Aug 2020 15:48:57 -0300
Message-Id: <20200831184859.110660-1-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This RFC improves the performance of indirect mapping on all tested DMA
usages, based on a mlx5 device, ranging from 64k packages to 1-byte
packages, from 1 thread to 64 threads.

In all workloads tested, the performance of indirect mapping gets very
near to direct mapping case.

The whole thing is designed to have as much perfomance as possible, so
the impact of the pagecache is not too big.

As I am not very experienced in XArrays usage, nor in lockless
algorithms, I would specially appreaciate feedback on possible
failures on it's usage, missing barriers, and so on.

Also, this size for the FIFO is just for testing purposes.
It's also very possible that it will not be a good idea in platforms
other than pseries, (i have not tested them).
I can plan I bypass for those cases without much work.

Thank you!

Leonardo Bras (2):
  dma-direction: Add DMA_DIR_COMPAT() macro to test direction
    compability
  powerpc/kernel/iommu: Introduce IOMMU DMA pagecache

 arch/powerpc/include/asm/iommu-cache.h |  31 ++++
 arch/powerpc/include/asm/iommu.h       |   4 +
 arch/powerpc/kernel/Makefile           |   2 +-
 arch/powerpc/kernel/iommu-cache.c      | 247 +++++++++++++++++++++++++
 arch/powerpc/kernel/iommu.c            |  15 +-
 include/linux/dma-direction.h          |   3 +
 6 files changed, 296 insertions(+), 6 deletions(-)
 create mode 100644 arch/powerpc/include/asm/iommu-cache.h
 create mode 100644 arch/powerpc/kernel/iommu-cache.c

-- 
2.25.4

