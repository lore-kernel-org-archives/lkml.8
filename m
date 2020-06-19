Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455DCC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 23:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BDF620706
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 23:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="dj06qqFZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730419AbgFSXYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 19:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730379AbgFSXYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 19:24:32 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFC3C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 16:24:30 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ga6so4734446pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 16:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=X1ACXT/DA2EOrh6dthja9XGbnQySlyTnGfW8+pIJPtM=;
        b=dj06qqFZtuuzpy1sB8T/rBBZoc5WKAo3+J1atENDZ27/hwTsmucUnjLhw6YOFHFDN4
         R2I8hHXovIHede+nj2D2KcMq1GA9CLFl7/AbIoUMRCIlS9Ngj8OA9aVmKLJEYNqYsjSu
         47srG9m+Uc83qk471bE3P87baa7gBRuwXOqV23PuW7xXLCDglxJc+7jb/mwS86TePdd4
         e9KBUnduO+3OLsstPnz7h9f0X7CpUPWdH4hfsRo1A7zkmMUeP0qE/Kf0nEiM4xjQhDXs
         15QLLU6mCMcPxJYnyCbRpoD2I/VJmqZnvbZvKShEdA9hj2soYV46UVJS+Obofm/vTH86
         3n+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=X1ACXT/DA2EOrh6dthja9XGbnQySlyTnGfW8+pIJPtM=;
        b=XCt4jpRor4F9LvYOFQR1zen+x+Ne09uewQd2YxEJ3wOtLdJIIzrvyKmIH+pPJDaL+A
         v1ZGAe+AjIG8TsZm1RDtsbpDMv2APKkaoM7EEwZX2Wa0tN2HF+BsnRNjebEpfXQwuTmZ
         AfzwV2rLaGSPn/fJ/sFxIBN6mLZRQRrzygPbIGTQNac66QSrSv2MyMoPT9bY8+I8sE1B
         Fwnvcc2N63ftOPVvFU9UIJDteiO4s8Adf4HWMMl8mftx4ULEIQw1wBq6WrFTNynAp3CZ
         elhG7kKZ+iMlVbymOcuWFzHz7r99Gg/8SK2PWRnjatkDN0puxZQ3+AGDAv1heMdWlJhT
         MGmA==
X-Gm-Message-State: AOAM531j61eTTMcPc7AtkoDP/nOzw/5gpKZ1JNG+QKtg/lCE11gzjvcO
        nUcVf/ACXwFIAid3b6QWhCuAfi8/odb7zw==
X-Google-Smtp-Source: ABdhPJxaoAdk78I9DqIuqHRbQaVPKoiDu/sqcl30wD7iBjN09aZnpoKNxT23N/LXnOHtZyrGa1gp0Q==
X-Received: by 2002:a17:902:44:: with SMTP id 62mr10116464pla.104.1592609070126;
        Fri, 19 Jun 2020 16:24:30 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id g29sm6737042pfr.47.2020.06.19.16.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 16:24:29 -0700 (PDT)
Date:   Fri, 19 Jun 2020 16:24:29 -0700 (PDT)
X-Google-Original-Date: Fri, 19 Jun 2020 16:24:24 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 5.8-rc2
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-ff59c9fd-a367-4804-bc35-73c8a572b016@palmerdabbelt-glaptop1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit cd16ed33c3c618930ccda7049dcea05ee707a9c0:

  Merge tag 'riscv-for-linus-5.8-mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux (2020-06-11 12:55:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.8-rc2

for you to fetch changes up to 0e2c09011d4de4161f615ff860a605a9186cf62a:

  RISC-V: Acquire mmap lock before invoking walk_page_range (2020-06-18 18:46:09 -0700)

----------------------------------------------------------------
RISC-V Fixes for 5.8-rc2

This contains three fixes that I'd like to target for rc2:

* A workaround for a compiler surprise related to the "r" inline assembly that
  allows LLVM to boot.
* A fix to avoid WX-only mappings, which the ISA does not allow.  While this
  probably manifests in many ways, the bug was found in stress-ng.
* A missing lock in set_direct_map_*(), which due to a recent lockdep change
  started asserting.

----------------------------------------------------------------
Atish Patra (1):
      RISC-V: Acquire mmap lock before invoking walk_page_range

Nathan Huckleberry (1):
      riscv/atomic: Fix sign extension for RV64I

Yash Shah (1):
      RISC-V: Don't allow write+exec only page mapping request in mmap

 arch/riscv/include/asm/cmpxchg.h |  8 ++++----
 arch/riscv/kernel/sys_riscv.c    |  6 ++++++
 arch/riscv/mm/pageattr.c         | 14 ++++++++++++--
 3 files changed, 22 insertions(+), 6 deletions(-)
