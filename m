Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0C4C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 20:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B49F20725
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 20:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="om7388ZR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgGKUYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 16:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbgGKUYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 16:24:02 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86729C08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 13:24:02 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l63so4081834pge.12
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 13:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=paG/UTKUPg8LNNMM5UIfbQX1NT/A+O79kxOkghupz2c=;
        b=om7388ZRsX8MUL1apUipxboeW7eErLSG8gOfHTWrT6hzYJwAVJTbGU/WgJsN7byyz+
         RhilSMP2KIoFZM5+qoCt7Hk/OSxDXHQyWzdzjyHrda8QUttUcv0PAN318Bx4mLQyTTW5
         6UylyNpcmxq4ifBr+5iQY8y/+PtLN8eRJ/gFlA+OHJN/q4Mvqp+wvfKz6G5FNmgnXwSr
         FBpQtowAX9ueYC4ZnpXt+SEfgX7baxkARbD8LQ5PqDVvzZaIDb4jtKlGkq8F282g6945
         33gSUHGB/ZuAR36qv3uFKqjzYyOWvtOkHedEehET6iZC9m1sZ0WGTARVtVwWWa/g0FG1
         lebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=paG/UTKUPg8LNNMM5UIfbQX1NT/A+O79kxOkghupz2c=;
        b=Zj8wOaE0QJJEuOlI7J5WJbnzwYtClUj1FXk4DyRAaBoJIUV7+j/dAx19fyfAoGsJRY
         BhilP7Rz8LsRfCZjREWEncnj71kDG8+gK0xp4R9poKphRN1HzNePQkB3Y0nDbWLwv0L7
         dfgxqVwnkVDtd+RQwHJ0da+VsrOZiCp2+Q57QHs2zH6xXU7q3S95i1fcQPp7HzSyIlnk
         XbwVx5iZmVxoO6hl3BAabgPf4UAqd1rkyj8X6qHkY9E8mydt4dl0cn+VSAbv2wWAQmiS
         cWsT4Csl8rMeCfowHBJ1VUP8D3xguydFyR4ofWyK2PkEzxXRdlowqqLrjRy+ZF7QDWH6
         mXFg==
X-Gm-Message-State: AOAM533/Y86TFF7lHHlfv9eB6tYkrdzOJJ2CTMyesAqiuvkvkdUCe3Fp
        GXBJ+3q9gVbNGdXJ/S71+7xPtx5Cvjc=
X-Google-Smtp-Source: ABdhPJxlIjk8lduBkdIXyv51+7bw5E4xwnJISJhykecgIyxhu0I7/UfrP/Cx3jA+e1ElRTlQMtNP6g==
X-Received: by 2002:a63:310f:: with SMTP id x15mr64432364pgx.221.1594499041744;
        Sat, 11 Jul 2020 13:24:01 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id g18sm9668435pfi.141.2020.07.11.13.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2020 13:24:01 -0700 (PDT)
Date:   Sat, 11 Jul 2020 13:24:01 -0700 (PDT)
X-Google-Original-Date: Sat, 11 Jul 2020 13:23:48 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 5.8-rc5 (ideally)
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-f8b65a3e-17ea-448d-be82-0d1c42c0bf37@palmerdabbelt-glaptop1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit dcb7fd82c75ee2d6e6f9d8cc71c52519ed52e258:

  Linux 5.8-rc4 (2020-07-05 16:20:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.8-rc5

for you to fetch changes up to 70ee5731a40b1f07f151e52c3c4ed27d70d4f9fe:

  riscv: Avoid kgdb.h including gdb_xml.h to solve unused-const-variable warning (2020-07-09 20:12:28 -0700)

----------------------------------------------------------------
RISC-V Fixes for 5.8-rc5 (ideally)

I have a few KGDB-related fixes that I'd like to target for 5.8-rc5.  They're
mostly fixes for build warnings, but there's also:

* Support for the qSupported and qXfer packets, which are necessary to pass
  around GDB XML information which we need for the RISC-V GDB port to fully
  function.
* Users can now select STRICT_KERNEL_RWX instead of forcing it on.

I know it's a bit late for rc5, as these are not critical it's not a big deal
if they don't make it in.

----------------------------------------------------------------
Vincent Chen (5):
      kgdb: enable arch to support XML packet.
      riscv: enable the Kconfig prompt of STRICT_KERNEL_RWX
      riscv: Fix "no previous prototype" compile warning in kgdb.c file
      kgdb: Move the extern declaration kgdb_has_hit_break() to generic kgdb.h
      riscv: Avoid kgdb.h including gdb_xml.h to solve unused-const-variable warning

 arch/riscv/Kconfig               |  2 ++
 arch/riscv/include/asm/gdb_xml.h |  3 +--
 arch/riscv/include/asm/kgdb.h    |  5 +++--
 arch/riscv/kernel/kgdb.c         | 10 +++++-----
 include/linux/kgdb.h             | 12 ++++++++++++
 kernel/debug/gdbstub.c           | 13 +++++++++++++
 lib/Kconfig.kgdb                 |  5 +++++
 7 files changed, 41 insertions(+), 9 deletions(-)
