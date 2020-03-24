Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A43C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 07:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF4320735
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 07:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dDc720oR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgCXHa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 03:30:58 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41816 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgCXHa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 03:30:58 -0400
Received: by mail-pg1-f194.google.com with SMTP id b1so8593299pgm.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 00:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R7QvJ+hGlZa7eQ4b0hWGxAvcTaj+cfDyda9vjq1c9co=;
        b=dDc720oR/Wkj0W/tqqtpU16K1HMP3ZDAfHfGEnuFWPjSx3MSeGKybR8G2Wtje6/nnp
         tV6BZG6G/B4txOD53a3Dq1v1spwTwl9WtBATsrV3OnL1ypaLPMdRQSr4xzXz61N6/Dkc
         i7kQy16Px7qhDNrgl+baCuL7LbRMz89MdK5bulJwCnE4r/2SgMrilrOUyXYfmcclHbCI
         jVNiIVt0CpgAWJ2WVQmACNQRy5xB7o6Cc8nihTm8TdWd7fyxKpjvBwAOWGRAMiHipNY/
         CeJJXBTazGvE0o4CXuYOOjjrFhsqYP2RVqqupw4+pdFefLkZ57+Kbwir4QCuSHAqkiZ/
         ygeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R7QvJ+hGlZa7eQ4b0hWGxAvcTaj+cfDyda9vjq1c9co=;
        b=rZPrnRmMPUum/GvScSXsfwYphOEJa0eDZBZZCLTkedYWVQmvdquahi0XhjHt+9XjHL
         PJZX2mGrt46YzrNS5p+76Ip6xCJCPnzmSGCL5376UZqb2WURZYKCPHO7Of85WOSWJmyk
         HhbJPe1fJb/CMPCLjq5AQD+hICyorNfkyRnwdG1zpyNHQ8YLqpbaPqXqxk5ERkCmkAu3
         7JifoscUgBNMyMlE8pSmbYDicEzkD6qid0wdmtkhpOz0w8ZgIcTrQFwhZ0bcY6HiKLJC
         grXn7/oTkDznLNdWIQoKt+MWYR+BnHYMZf2Hfvt9966SqPW6GyJIXM4v+LS32b8FdZf8
         lkhQ==
X-Gm-Message-State: ANhLgQ0dez6JakJw3PRPhZLYSI/+z0Si1JLHnbkAu4jFI9/XA/rp/IKc
        /duduslcbf5BxdQHrLETZgBeYOERt3g=
X-Google-Smtp-Source: ADFU+vtsxA7BrygqHJNRMPjVwJ4JD9w/qFMcUE5ViYWrI55yKi0mVzytAhxC2mpic4Gm7dj4rZ2baA==
X-Received: by 2002:a63:f141:: with SMTP id o1mr24826131pgk.92.1585035057097;
        Tue, 24 Mar 2020 00:30:57 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id i187sm15124648pfg.33.2020.03.24.00.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 00:30:56 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com, alex@ghiti.fr,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH RFC 0/8] Support KASLR for RISC-V
Date:   Tue, 24 Mar 2020 15:30:45 +0800
Message-Id: <cover.1584352425.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series implement KASLR for RISC-V. It copies kernel image to
a proper and random place, and make all harts go to the new destination.

This patch depends on the patch 'riscv: Introduce CONFIG_RELOCATABLE',
but given a small change by making PAGE_OFFSET be constant, so all the
memory could be available after moving kernel physical address. This
patch also depends on 'Support strict kernel memory permissions for security'.

Zong Li (8):
  riscv/kaslr: add interface to get kaslr offset
  riscv/kaslr: introduce functions to clear page table
  riscv/kaslr: support KASLR infrastructure
  riscv/kaslr: randomize the kernel image offset
  riscv/kaslr: support sparse memory model
  riscv/kaslr: clear the original kernel image
  riscv/kaslr: add cmdline support to disable KASLR
  riscv/kaslr: dump out kernel offset information on panic

 arch/riscv/Kconfig             |  15 ++
 arch/riscv/include/asm/kaslr.h |  12 +
 arch/riscv/include/asm/page.h  |   5 +
 arch/riscv/kernel/Makefile     |   2 +
 arch/riscv/kernel/head.S       |  39 +++
 arch/riscv/kernel/kaslr.c      | 442 +++++++++++++++++++++++++++++++++
 arch/riscv/kernel/setup.c      |  23 ++
 arch/riscv/mm/init.c           | 115 ++++++++-
 8 files changed, 651 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/include/asm/kaslr.h
 create mode 100644 arch/riscv/kernel/kaslr.c

-- 
2.25.1

