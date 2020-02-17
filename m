Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD26C7619F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F46C20725
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hJQ43EsI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgBQIca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:32:30 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33813 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgBQIc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:32:29 -0500
Received: by mail-pl1-f195.google.com with SMTP id j7so6423949plt.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 00:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hcs3IYu1loQeGMz6D7BaruDwBKpT/QAWJLc9WJ9RvcU=;
        b=hJQ43EsIlapSjLKR42NfRJjH1Lsaw4P+FKomgrWFxgqnsCwR2ujO2E5Mqw+bPn0Yxu
         wipai+3ldCMpM3eS07bSj3k5yqo6YZQVMW0tuIltyYqE4aqN0JIUZjlt0uSkIgN4ob1o
         LoJjzNq62ebA+QLaIeie7/kd4Kvrq7jvVAz8DfqYhXkAx8DOUF69YcY38Kav0xSrk6zY
         QbgebI39Tva9CMqOkV6GCu3glUouzusjITCZT/XCA0/MYiiAgxxOcjHtbyOlDEQ7cVm9
         NDjvXCMOA3VE52APYJEffDbdHhbZLuJ7Q+a2OhrKWfTIzEkj45SeJmOQpZtt1HDZGWyR
         dJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hcs3IYu1loQeGMz6D7BaruDwBKpT/QAWJLc9WJ9RvcU=;
        b=fnhavxxysWHJwDfhzKeYI0McMjXZ3ER5eiicPmeNsc8UyrAaKObpbS28ZUmjkhwR9g
         9BLi2vW88Xl/+ZFp73nj46wof+hdat7dKLf7Acge/bIfrOnQbtmeYklAZ+g86fUqerNa
         IUcc5ciQfiK6j05H2x7LRRp4pZnoKxyN3LVb66X+iUy+BOgRMGdP0cRB6cHMeZtvVwBm
         uTINTocyzps+H4mmcAuv2ZUH9F6JK1zE3a6wKwNOeWHzL6Gv6SBVR9kvGgKw0HPyoGyZ
         EQADmyQ+NLTe7yU+zQPRWD7xvC1ZYKYMnZiXZMHL8CSIGO0jbdTYpfaJeBTDu0pYa7xP
         7RGw==
X-Gm-Message-State: APjAAAUvxBDruMioyp9uuCIAXl+uRXCAOdLzxkdos72nZNGbbDstY7s8
        1gVeZxs3pNu6AUCGKVzFl00q8g==
X-Google-Smtp-Source: APXvYqxB9MmYpJKEMtx+61G6Xv0FfZl6HfdanIBdAUEALAkOL7licVIihuYQiaDeJscs1E4Ns8JUMQ==
X-Received: by 2002:a17:90a:1785:: with SMTP id q5mr18885984pja.143.1581928349196;
        Mon, 17 Feb 2020 00:32:29 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id z10sm16989319pgz.88.2020.02.17.00.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 00:32:28 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 0/8] Support strict kernel memory permissions for security
Date:   Mon, 17 Feb 2020 16:32:15 +0800
Message-Id: <20200217083223.2011-1-zong.li@sifive.com>
X-Mailer: git-send-email 2.25.0
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

Zong Li (8):
  riscv: add ARCH_HAS_SET_MEMORY support
  riscv: add ARCH_HAS_SET_DIRECT_MAP support
  riscv: add ARCH_SUPPORTS_DEBUG_PAGEALLOC support
  riscv: move exception table immediately after RO_DATA
  riscv: add alignment for text, rodata and data sections
  riscv: add STRICT_KERNEL_RWX support
  riscv: add DEBUG_WX support
  riscv: add two hook functions of ftrace

 arch/riscv/Kconfig                  |   6 +
 arch/riscv/Kconfig.debug            |  30 +++++
 arch/riscv/include/asm/ptdump.h     |   6 +
 arch/riscv/include/asm/set_memory.h |  41 ++++++
 arch/riscv/kernel/ftrace.c          |  18 +++
 arch/riscv/kernel/vmlinux.lds.S     |  12 +-
 arch/riscv/mm/Makefile              |   1 +
 arch/riscv/mm/init.c                |  47 +++++++
 arch/riscv/mm/pageattr.c            | 187 ++++++++++++++++++++++++++++
 9 files changed, 344 insertions(+), 4 deletions(-)
 create mode 100644 arch/riscv/include/asm/set_memory.h
 create mode 100644 arch/riscv/mm/pageattr.c

-- 
2.25.0

