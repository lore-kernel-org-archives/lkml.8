Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D90C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CD2D20724
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="QneoFIKU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgHUSg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbgHUSgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:36:09 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FA5C0613ED
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:26:45 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id z23so1252058plo.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=UfiaKNHVUOJp6y83l+zDDzL8YjdP1aXCnAawlT70F7Q=;
        b=QneoFIKULFQitVGh39KS/agGfZlihosqNChwoNV86tLkjBCSXBKLRSShLPhpp1FKhq
         AEZPYX6IDEQQ4biSE5STbp9xPyc3EsEPdqzqjlSYC0I4SOKhsrNz76VWy8lV1Z0EouOo
         H3N17Ps1PgP7KquaNRd0fk9Br/XuSxk0ROaK6hX/cGDSVhEcoiCIxlXwtPjWZFAAASFx
         2QsVCrJC0lh7dbWCWo9Nl8YujyyIcFnNeZc12NYDA0Nj4Ewd4O9a/EIsjNsHTXsPN4ue
         aYSTbRu+ZCer6h4HLo+zK4o5U9Vp/2qHk4e1HM2j9WpKDxbG5SkGGyludWa/E2vWB8gz
         JH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=UfiaKNHVUOJp6y83l+zDDzL8YjdP1aXCnAawlT70F7Q=;
        b=Bs0gVQWF5/rmFSYeM4qAtnkj+StPutr3NHIEl0ewlnLNTi/5+9P7HDpGwR4a+AuxBV
         cPM+Uss6siHMkeCbqRb7kfstSDCFp7O31bGdGA/b0slVKST5h/jqTcSaPmWO7TujUy0d
         vMs3xvJ+zgMqRtHvKlGoXtIF5XLTIw5tIDjEaaa2lbcRAsu1lcH9L/5C1dE3y1RLo8P2
         Fcw2imnrKjPfLfsaaM6C5Jeu09ozCR1YPr36j4K9UzrWggJxdvcStzRRSXaaNV7A47zA
         rrpUsxpJ8kNqOdGy/9sQ1VaPX6Bq9tm5Yko6hbv06BdBlB7QkKoUTFfivXvSzPVwzEII
         +9XA==
X-Gm-Message-State: AOAM530e0vxRCOKcP+smk39SOYBR/9ZpVaI/SJwt61wt57Epu2GGm4L3
        EcinALO6gFSNYS/HrY6+pPcymNwah5rxug==
X-Google-Smtp-Source: ABdhPJx7mlC6cSX/hC1RAvE6kOfVwNUoESPycgeHVvTL2/zAwXnbTiu7M/ky+vhG8r6P0WNCeC0Bxw==
X-Received: by 2002:a17:902:6545:: with SMTP id d5mr3327296pln.257.1598034404762;
        Fri, 21 Aug 2020 11:26:44 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id w3sm3509478pff.56.2020.08.21.11.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 11:26:44 -0700 (PDT)
Date:   Fri, 21 Aug 2020 11:26:44 -0700 (PDT)
X-Google-Original-Date: Fri, 21 Aug 2020 11:20:22 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 5.9-rc2
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-32c8d053-acbd-4c72-b41d-8d6042ac639d@palmerdabbelt-glaptop1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.9-rc2

for you to fetch changes up to fc26f5bbf19459930b7290c87b65a9ae6a274650:

  riscv: Add SiFive drivers to rv32_defconfig (2020-08-20 11:00:21 -0700)

----------------------------------------------------------------
RISC-V Fixes for 5.9-rc2

* The CLINT driver has been split in two: one to handle the M-mode CLINT
  (memory mapped and used on NOMMU systems) and one to handle the S-mode CLINT
  (via SBI).
* The addition of SiFive's drivers to rv32_defconfig

----------------------------------------------------------------
Anup Patel (4):
      RISC-V: Add mechanism to provide custom IPI operations
      clocksource/drivers: Add CLINT timer driver
      RISC-V: Remove CLINT related code from timer and arch
      dt-bindings: timer: Add CLINT bindings

Bin Meng (1):
      riscv: Add SiFive drivers to rv32_defconfig

 .../devicetree/bindings/timer/sifive,clint.yaml    |  60 ++++++
 arch/riscv/Kconfig                                 |   2 +-
 arch/riscv/Kconfig.socs                            |   2 +
 arch/riscv/configs/nommu_virt_defconfig            |   7 +-
 arch/riscv/configs/rv32_defconfig                  |   5 +
 arch/riscv/include/asm/clint.h                     |  39 ----
 arch/riscv/include/asm/smp.h                       |  19 ++
 arch/riscv/include/asm/timex.h                     |  28 +--
 arch/riscv/kernel/Makefile                         |   2 +-
 arch/riscv/kernel/clint.c                          |  44 ----
 arch/riscv/kernel/sbi.c                            |  14 ++
 arch/riscv/kernel/setup.c                          |   2 -
 arch/riscv/kernel/smp.c                            |  44 ++--
 arch/riscv/kernel/smpboot.c                        |   4 +-
 drivers/clocksource/Kconfig                        |  12 +-
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/timer-clint.c                  | 226 +++++++++++++++++++++
 drivers/clocksource/timer-riscv.c                  |  17 +-
 include/linux/cpuhotplug.h                         |   1 +
 19 files changed, 376 insertions(+), 153 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/sifive,clint.yaml
 delete mode 100644 arch/riscv/include/asm/clint.h
 delete mode 100644 arch/riscv/kernel/clint.c
 create mode 100644 drivers/clocksource/timer-clint.c
