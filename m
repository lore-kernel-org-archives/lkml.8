Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8563C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 10:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D43D24684
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 10:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PK5GOb+g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbgAJKqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 05:46:36 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40172 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbgAJKqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 05:46:36 -0500
Received: by mail-pf1-f194.google.com with SMTP id q8so947668pfh.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 02:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id;
        bh=+1JMH3O1qhWg8U2E+XjrJRR+Lg3GG1qOiYki3Lbx/N0=;
        b=PK5GOb+g1UwA8M3PiwFU2ug4hFEgL1/6tvc1NdbZfz8h4xV6lOxAojI9imoJXfaHud
         Hr0AeHsuKESAg78NwDRNUsNYX1dOG7LRoQoj+uANdWxPPT08to8mkR4Ivu6BNeZJYw/f
         Q4DGIGllx/551GGHCG67UG6KL3hl6oOYiymIGBwBohjypre3Qc/htOXhsa+fzQv2dsY3
         apkTBUKvNuJvh0kaZPZaEDGU6lCXf4sRLNDzLfcis4oXVYJDcq19uyh/3fc+3kqnv43D
         vwWt9VeeuWOyDLyN5jwb8DTINyCVpIl7/7ky4KVWbAugnFbjKH6hEZKdcQgU8467T1p3
         WA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=+1JMH3O1qhWg8U2E+XjrJRR+Lg3GG1qOiYki3Lbx/N0=;
        b=lTNTK7G4mNJ5SMMIFgeZArFgPnvoHVgphLILM+IszdRTfQv3X85DTirEkuE1VOCvsN
         o+IBJdfq8qdiXXoEfsENCDM7164ADYj+13+P36tD1raMMempe/LogcCdq3pvRAOVwSpf
         9dlRRFE7Ls6GzFVwaY0Opa60W4AwjIk7LzLNpAI+vQsIz0e1E7+7XYvIPYGI8YIYvlvT
         3eHTy6slEgWUG0cFhNRXCnFILj8Oq6PRI2Y5+Zt9gnJa0E9I3gczQexINrN764G1Diui
         d+FnS4IQlTFTHn0pCcG8/t5qSgCJXBbHD8D0HiKVCM/g5qxkz75uV77AHI0QOfgD/mJP
         IVHQ==
X-Gm-Message-State: APjAAAWYmRLWSCSxzaurkZUYlsw2NG/m7Th6wgPCezES/cLQRpvRhjQ4
        7KK0yE47+M1d5Ukwy36KVqjgWA==
X-Google-Smtp-Source: APXvYqzopepT7mtIC0eNuWFQ0ZudFWgCJ/+AAjUfIW3P4MLVwsJdOvlttFMiAHZWi4JGlJL2KthQzQ==
X-Received: by 2002:a63:f202:: with SMTP id v2mr3530796pgh.420.1578653195226;
        Fri, 10 Jan 2020 02:46:35 -0800 (PST)
Received: from greentime-VirtualBox.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id e10sm2590901pfj.7.2020.01.10.02.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 02:46:34 -0800 (PST)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, greentime@kernel.org, anup@brainfault.org,
        palmer@dabbelt.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, rppt@linux.ibm.com,
        gkulkarni@marvell.com, will@kernel.org, catalin.marinas@arm.com,
        mark.rutland@arm.com, paul.walmsley@sifive.com, hch@lst.de
Subject: [RFC PATCH v2 0/4] riscv: Add numa support for riscv64 platform
Date:   Fri, 10 Jan 2020 18:46:23 +0800
Message-Id: <cover.1577694824.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

riscv: Add numa support for riscv64 platform

This implementation is based on arm64 porting. It is tested with
qemu-system-riscv64, SiFive Unleashed board and OmniXtend FPGA platform.

There will be two nodes in /sys/devices/system/node if it is described in
dts and CONFIG_NUMA is enabled. We can use numastat/numactl/numademo to see
its status.

Changes in v2:
- split this patch to more patches to be more readable
- set cpu->hotplugable to 0 since it is not supported yet
- add more explanation for moving unflatten_device_tree() to paging_init()

Greentime Hu (4):
  riscv: Add support pte_protnone and pmd_protnone if
    CONFIG_NUMA_BALANCING
  riscv: Move unflatten_device_tree() to paging_init() because
    riscv_numa_init() needs the dt information.
  riscv: Use variable this_cpu instead of smp_processor_id()
  riscv: Add numa support for riscv64 platform

 arch/riscv/Kconfig               |  30 ++-
 arch/riscv/include/asm/mmzone.h  |  13 ++
 arch/riscv/include/asm/numa.h    |  46 ++++
 arch/riscv/include/asm/pci.h     |  10 +
 arch/riscv/include/asm/pgtable.h |  20 ++
 arch/riscv/kernel/setup.c        |  26 ++-
 arch/riscv/kernel/smpboot.c      |  20 +-
 arch/riscv/mm/Makefile           |   1 +
 arch/riscv/mm/init.c             |   3 +
 arch/riscv/mm/numa.c             | 372 +++++++++++++++++++++++++++++++
 10 files changed, 536 insertions(+), 5 deletions(-)
 create mode 100644 arch/riscv/include/asm/mmzone.h
 create mode 100644 arch/riscv/include/asm/numa.h
 create mode 100644 arch/riscv/mm/numa.c

-- 
2.17.1

