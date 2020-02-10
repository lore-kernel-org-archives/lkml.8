Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE6CC352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 08:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E9E208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 08:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DDtmRvlY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbgBJIfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 03:35:22 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36108 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbgBJIfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 03:35:22 -0500
Received: by mail-pf1-f194.google.com with SMTP id 185so3363759pfv.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 00:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IAH21rRjZvmTngJjoV1HKPcK//riioA2iI4jMy/qJc8=;
        b=DDtmRvlYqXkEKZHw98V0R01Uu1kN9/ARvVSbOe2ybfFV9gwpPvK+IPY6zymXr7pYXU
         PNvfULtk/HbkzlHvzBMkwzCSteRUMDegujbsd/8+33JMkZ9apZr9LCihHlbgcsStys+s
         KvlPpITUlz2A2lC4j6WEMr6kZJavnEFJSOrvMk/Mqrq2PiINYTCOZsJQwwhELxehy2Dg
         clfzB+S/FCQhfWnZ+6bTq7KQ1JivzzjwepeQStaMJ+Nm+4X2JQCEOE/jKvuRGKICaevX
         JhZNjX4svsJV8o9Ex4NKON2HAx/Kc2KyF7Z73HAt0eSyM1pIxYlUJ6Z5cd359+ev6ehX
         4BQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IAH21rRjZvmTngJjoV1HKPcK//riioA2iI4jMy/qJc8=;
        b=VrRpvAHly6cFl7x/E+KfaI6wu13DEgeYpOIslOYZpSyoNjFQGAGQUgsSAQkLTSITcD
         odGAkKGz1LNBBQa4SOpuFEbSogF/VWEdmuDkDxzdH3mag1BiaPrVpE7iBpHuKSvTxKap
         ANP+ptyu/qmyCn0EoUBclfT1iOi84UbALResF+wnZqpOOuzmtcI95NLE4qq9/a31BGch
         Wk7citvLdcm4ingkmNMsqdINvMPwZl6TzOsZNwGv9ZIByNLwFPuCxNCRCo/I6S/O7TM7
         H1p93dNarZpJ2gsKItnHNXoX+75nvw9r+D2BW3/6LLCX3AcdcBXsWFZF0FnPlR1nI9/4
         x4oA==
X-Gm-Message-State: APjAAAUX2Gk+r1YAD57A3WAK+I1msba1hs/EvxTju8RBwir4Buflr4V2
        0+T1aZ9N62HqbgS7gwyqk4rpXA==
X-Google-Smtp-Source: APXvYqxUgZWp9tHcFfptZfFiaukDBc1kZJaHKTL4vCwtJmXCYdFm7baLfsW3dKm+41KT3uZB/75uvw==
X-Received: by 2002:aa7:8bda:: with SMTP id s26mr125990pfd.194.1581323720533;
        Mon, 10 Feb 2020 00:35:20 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id q8sm10582409pje.2.2020.02.10.00.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 00:35:19 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v2 0/2] RISC-V page table dumper
Date:   Mon, 10 Feb 2020 16:35:13 +0800
Message-Id: <20200210083515.10864-1-zong.li@sifive.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the support for dumping the page tables, and it's
implemented on top of the generic page table dumper patch set. The generic
page table dumper patch set is merged at 5.6-rc1.

This patch also depends on the fix about KASAN issue which causes the
segmentation fault. (https://patchwork.kernel.org/patch/11372493/)

Zong Li (2):
  riscv: Add support to dump the kernel page tables
  riscv: Use macro definition instead of magic number

 arch/riscv/Kconfig               |   1 +
 arch/riscv/include/asm/kasan.h   |   2 +-
 arch/riscv/include/asm/pgtable.h |  10 +
 arch/riscv/include/asm/ptdump.h  |  11 ++
 arch/riscv/mm/Makefile           |   1 +
 arch/riscv/mm/ptdump.c           | 317 +++++++++++++++++++++++++++++++
 6 files changed, 341 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/include/asm/ptdump.h
 create mode 100644 arch/riscv/mm/ptdump.c

-- 
2.25.0

