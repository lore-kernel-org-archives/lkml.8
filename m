Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43DDC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7FF20727
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mF9Mfr/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgCIQzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 12:55:54 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34463 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbgCIQzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 12:55:53 -0400
Received: by mail-pl1-f194.google.com with SMTP id a23so1515811plm.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 09:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YKC9LNaZtyUY/Ff2305WgJwZtiH/JDgzAH1pAGoBoKg=;
        b=mF9Mfr/83Mi60PJDifAAgN2akM9nEfNqk9CHt5jlMY4lyvbmaTza7qEmUrnkqWu/87
         sdoudwgpopvaiVKUindhwzWAUUFvQrua85KAxeRhVvmHl1bvM4dQqqf50bCU50nQ6at+
         Te7+0a/h9Pwf9iIdxhJPJvFd0U8Hpf01Z41NLsSlRvv+8P8FQ6xNa7lT+l0WlFh4XJbI
         IyXTvv105PQQC8xZuBcKi20Y2rC0AY5y12jIoyR5SyiISQBWoQ1KLl4iqZ2WJOYI7iZ1
         ZvVW1QUQiiV+piqh0Et7/UnA120i6gC0R2iNFkENXxIN1fRjl86xLib0acsjL1niES5X
         5bJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YKC9LNaZtyUY/Ff2305WgJwZtiH/JDgzAH1pAGoBoKg=;
        b=j6qqW2xCft8orACALyK8+Zs/SUfvqOQUc0JEe+ufFGCuSEoFPX1eHZCyPe/gWLwKE+
         f58NPL0f3CUKX3dnR2oVM0fkXtFwegHMFPWOfFB63aIAF+KETlB/E0luBJQ29cq+RxJ0
         r3A+oS9pnV9u2Q/E3Gl0ifj1NT8G1GVrFov8V8/ST54dn3XZwe1yjMM5qZAbsf1BGs79
         +T57DcDSxam6pePlKt2c+YB7K/WNoH/jRUljUvZTx/jwmiGSgYa8z161Bthw3gyVMIzx
         mXPvwu/A0S2tJEPM1k67biG/obNmoDewZyynz/unUYht4bm/wXdBWjsj5wMM105PRNl3
         wcFQ==
X-Gm-Message-State: ANhLgQ2r6o/k/YlYay8biAMpeW38LsifxNzzECHnnVN027XJqXyaQ4Z1
        2I1kwB2lib6Mzj4mpjR6I77G6g==
X-Google-Smtp-Source: ADFU+vtfAu9oURnvRZb4wdaOx8JAoyHiyo47BPzGc96sPN8/2lneZdc9XKADgW+HjDDeUytpou7qnA==
X-Received: by 2002:a17:902:8d93:: with SMTP id v19mr16980723plo.327.1583772951184;
        Mon, 09 Mar 2020 09:55:51 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id cm2sm104013pjb.23.2020.03.09.09.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 09:55:50 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v3 0/9] Support strict kernel memory permissions for security
Date:   Tue, 10 Mar 2020 00:55:35 +0800
Message-Id: <cover.1583772574.git.zong.li@sifive.com>
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

Changes in v3:
 - Fix build error on nommu configuration. We already support nommu on
   RISC-V, so we should consider nommu case and test not only rv32/64,
   but also nommu.

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
 arch/riscv/include/asm/set_memory.h |  48 +++++++
 arch/riscv/kernel/Makefile          |   4 +-
 arch/riscv/kernel/ftrace.c          |  13 +-
 arch/riscv/kernel/patch.c           | 120 ++++++++++++++++++
 arch/riscv/kernel/traps.c           |   3 +-
 arch/riscv/kernel/vmlinux.lds.S     |  11 +-
 arch/riscv/mm/Makefile              |   2 +-
 arch/riscv/mm/init.c                |  44 +++++++
 arch/riscv/mm/pageattr.c            | 187 ++++++++++++++++++++++++++++
 13 files changed, 445 insertions(+), 15 deletions(-)
 create mode 100644 arch/riscv/include/asm/patch.h
 create mode 100644 arch/riscv/include/asm/set_memory.h
 create mode 100644 arch/riscv/kernel/patch.c
 create mode 100644 arch/riscv/mm/pageattr.c

-- 
2.25.1

