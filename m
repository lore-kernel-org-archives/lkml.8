Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79691C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B06B21739
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bc5P7UOa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgCIIWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 04:22:40 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40284 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCIIWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 04:22:39 -0400
Received: by mail-pj1-f68.google.com with SMTP id gv19so4105433pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 01:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nWObDgjgZezZgCL2wVWQ9blCPfrUhtUR9HjDvFFeTdY=;
        b=bc5P7UOaxBHY8fLZDV2BLlVD8GNbOYfXYuJxoL286xHGxp49CPe8qq1h+xycDZELlj
         nBc2Xr9xYT34ZPVpOEHHtl7R3XpyUVvc9CsztPBOwQhz5B7SkNH9BobviqvnBAE6JFtG
         tXhTEUO9uEc3AIp9qcvkHxNxNTtHMjmib4zVUDXw6bK3K+sry5Kr17tSOOLREo5vkjRW
         mlh7DwT5kdX4nRFWznpDBAGlBO87EJrPUV4znEfTrcLuOAGtO09FrMhP82npOyjh9DLn
         0md1fu0+As8F7dn9TaGYzeG9B+coygjdCgnGA5H1ehi1ByRkI7n6Novvc1zUm4bjQUxo
         Kw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nWObDgjgZezZgCL2wVWQ9blCPfrUhtUR9HjDvFFeTdY=;
        b=D+IW7vO1Jwk/0kCDQY+G2Sp//fFlZZa8czV0wqSih6yr3/eyHE7FmWWrdSRGRIdVYk
         Fb3Kb1YnXNC6Cd+tZ5vQLW1sqj3OrXji4ieg1GUZPDr3ciZFLlAHn7zxOg/4Wi9u1PPB
         uQQbngquPem00APsE+uHBFniYpGGfcpOomUAbjXqshfhPGCdDvyWtvnK+EWrGQHvZFZE
         0G+5yjM2IS0m+s0MfZfdiAHz8IRVi0lBVzqFiWEOK4w++c1WN2Jtc/y5RMwLiYCXfkll
         4OG0MeOrXn6cit7OK0lz+LojxBj1IJRBlxxZwZfcVFcGzU7+GNThaCuQe2M8yCvKiY8a
         gvFA==
X-Gm-Message-State: ANhLgQ0uiCJyEPB80VnHxdmETQQMTEMZUon1KKN1AJ2HpAKJ+061ovOr
        X7Dtg89fWnzILYVTuuTEGz3Yqw==
X-Google-Smtp-Source: ADFU+vtFnBt37omYLnPWPoZcI3BtAUZIMhCWGDpPntjbGLQaCRb4SJZ4PFLY/wRjPwzVFN3YpeNECA==
X-Received: by 2002:a17:902:8603:: with SMTP id f3mr14981196plo.235.1583742158258;
        Mon, 09 Mar 2020 01:22:38 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id v5sm18364779pfn.64.2020.03.09.01.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 01:22:37 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v2 0/9] Support strict kernel memory permissions for security
Date:   Mon,  9 Mar 2020 16:22:20 +0800
Message-Id: <cover.1583741997.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main purpose of this patch series is changing the kernel mapping permission
, make sure that code is not writeable, data is not executable, and read-only
data is neither writable nor executable.

This patch series also supports the relevant implementations such as
ARCH_HAS_SET_MEMORY, ARCH_HAS_SET_DIRECT_MAP,
ARCH_SUPPORTS_DEBUG_PAGEALLOC and DEBUG_WX.

Changes in v2:
 - Use _data to specify the start of data section with write permission.
 - Change ftrace patch text implementaion.
 - Separate DEBUG_WX patch to another patchset.

Zong Li (9):
  riscv: add ARCH_HAS_SET_MEMORY support
  riscv: add ARCH_HAS_SET_DIRECT_MAP support
  riscv: add ARCH_SUPPORTS_DEBUG_PAGEALLOC support
  riscv: move exception table immediately after RO_DATA
  riscv: add alignment for text, rodata and data sections
  riscv: add STRICT_KERNEL_RWX support
  riscv: add macro to get instruction length
  riscv: introduce interfaces to patch kernel code
  riscv: patch code by fixmap mapping

 arch/riscv/Kconfig                  |   6 +
 arch/riscv/include/asm/bug.h        |   8 ++
 arch/riscv/include/asm/fixmap.h     |   2 +
 arch/riscv/include/asm/patch.h      |  12 ++
 arch/riscv/include/asm/set_memory.h |  41 ++++++
 arch/riscv/kernel/Makefile          |   4 +-
 arch/riscv/kernel/ftrace.c          |  13 +-
 arch/riscv/kernel/patch.c           | 124 ++++++++++++++++++
 arch/riscv/kernel/traps.c           |   3 +-
 arch/riscv/kernel/vmlinux.lds.S     |  11 +-
 arch/riscv/mm/Makefile              |   1 +
 arch/riscv/mm/init.c                |  45 +++++++
 arch/riscv/mm/pageattr.c            | 187 ++++++++++++++++++++++++++++
 13 files changed, 443 insertions(+), 14 deletions(-)
 create mode 100644 arch/riscv/include/asm/patch.h
 create mode 100644 arch/riscv/include/asm/set_memory.h
 create mode 100644 arch/riscv/kernel/patch.c
 create mode 100644 arch/riscv/mm/pageattr.c

-- 
2.25.1

