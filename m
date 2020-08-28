Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA41C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 07:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82C4520CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 07:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="GkihBHMi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbgH1HJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 03:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgH1HJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 03:09:11 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FB4C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 00:09:11 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id z15so52094plo.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 00:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=00tHBY+tCae86zJA9u8natH/+4zIXXYCZ45d5NLgLfg=;
        b=GkihBHMiec5eMP8OBax8z+XGlIotQbtSLdAk9+CKKrSigh++uPLy3NE9fIHGHajhKs
         hepKEyC3Fdjd+VsvrGyFoSGKa8gNH4CPiTt7s9mgbEtuLz9UWo3CuHdcxNFiiksdzGQz
         MIVSm7hpK0Upa1rStmgqygQkNzx6CQay1LhTHHz1l2vMYdM06/OyRIKMZG1nlxop1yLt
         3oIEKzgv9Ha/3/AdGRdr2IEUTYUNkvmDJwOe48gTld/aPyaBcJHwNKUK5XdOxarYXqaf
         AUerArzoGkJTP9A2AVjhYhZDudLr5EEiiWTrEUsC5GWCEN/wAVVY1Skodx/YMh2hY5fQ
         56LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=00tHBY+tCae86zJA9u8natH/+4zIXXYCZ45d5NLgLfg=;
        b=SjV/IqFWqIcj36PsGycxi3x2QMzNj1l9XQDqpu1FQdNyylHJyiwLwC7nog5hBs+/N+
         l+zQSSFzbxj4xWQcB5vK/ZxOiaPdTVmbYF82FSpR4nE0YQOTFTsVLW7zEFamT5pV3A+o
         vBQQjddoBkf53x8VByCfUjcc4wvWd+aGsfrTjD/ZTN94KjmuUVb5GUMBqWtqNK6FWHZr
         Q3OqDh15NQ01uZtciO61tnGEySpVJNQdvrYg9vh/0t8aJu6tA/QIVXZcIOgbDhuhzY+B
         xozNT9Rk5MD5AD0DcvRlOEdWNgj5JToxDlAbR9a4zyi/KxGbSNlh1B6CqWAatK+KOiZk
         UoiA==
X-Gm-Message-State: AOAM533DiSSjNjjaMGZ0KI9m8+Cqn32qAre9UBwL/BshfOgWE85yRxyd
        OdxWVPa1GrmueMTSFghf1ZwSSkJl2NF9Bg==
X-Google-Smtp-Source: ABdhPJyZ4o7THBO7qI2ndy4SmPKgzdv1mWtlbc51RdLvmXIbDlBctm5ebi+0sr6GtXbn15DXvmPqJw==
X-Received: by 2002:a17:902:7e4b:: with SMTP id a11mr228346pln.325.1598598551032;
        Fri, 28 Aug 2020 00:09:11 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id b8sm434158pfp.48.2020.08.28.00.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 00:09:10 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        david.abdurachmanov@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v3 0/3] Get cache information from userland
Date:   Fri, 28 Aug 2020 15:09:04 +0800
Message-Id: <cover.1598598459.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.28.0
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

Changed in v3:
  - Fix sparse warning: Use NULL instead of integer 0

Changed in v2:
  - Add error checking for parsing cache properties.

Zong Li (3):
  riscv: Set more data to cacheinfo
  riscv: Define AT_VECTOR_SIZE_ARCH for ARCH_DLINFO
  riscv: Add cache information in AUX vector

 arch/riscv/include/asm/cacheinfo.h   |  5 ++
 arch/riscv/include/asm/elf.h         | 13 ++++
 arch/riscv/include/uapi/asm/auxvec.h | 24 ++++++++
 arch/riscv/kernel/cacheinfo.c        | 91 +++++++++++++++++++++++-----
 4 files changed, 117 insertions(+), 16 deletions(-)

-- 
2.28.0

