Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD836C0044D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 02:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007AD20735
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 02:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="c1mMG2I+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387709AbgCLC6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 22:58:42 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:44538 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387396AbgCLC6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 22:58:42 -0400
Received: by mail-pf1-f170.google.com with SMTP id b72so2468918pfb.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 19:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xjmkUAJV0P0YoZQeq03wBLs4ipixrmI828N0sC8YCYY=;
        b=c1mMG2I+a4RImGoQCDTKsYcKG/bwp8PYVHJrAvIK8DRDiZ+lwBG/C2Ky1Q+cSPObRD
         JGBKmFCmIbAtoEGyFtpRKO8lopfd3fkGBa6Yl75i5sF6D3xIXsNQmZoHGlvS22w+9xEP
         2dLJnVqhouZRMMou/QxjzCe7a61hIdZggh9fBni49Vf2WYJ50VvvMkUxZJzg+x4DSna2
         /3wrt775hBm1Oyw/WZQPQUo74Eyw/evPVg6+2W+H/6Z7Fl3hQVjH491gbkv/ZRiy2MxZ
         5DlyzJU83/zAkozQJBSMeEZC7MrluYWKJ+rrbTxnQnGOWzXm1XD1Nnx9QMYNxjjJGmzS
         YE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xjmkUAJV0P0YoZQeq03wBLs4ipixrmI828N0sC8YCYY=;
        b=qsBPB1x4Hety6EdNAS/gLmPGizx7MY9Dc6ApSK1otqQPcbSTpejXCoP7BXDZ78PP90
         1CQtf0B5U8bw0yeq40ZFQBEkDHKJ5/ow5Gypg34hYv0WHtKFYq/AKlJzLW7sPfELQnGW
         GpCTdoM7Ehl/CqysHfyUH/STUNE6i1003MTO1WgvfOWpWlJiiKli6rkdgduBk9CQmOfn
         gInySnj7rQU5q+3xQ9wR2LwHFXth1+L0/l4hElgBwdsAmZ5Hltk2FFkJCaI9fb60/Jba
         FYMFiyUEwNmsZWxQqSo7/5sgSxevTcTPRTHCqoCh7HFCT/rDbkiSvFFj8Kjijy4T1ytM
         CBAg==
X-Gm-Message-State: ANhLgQ1Ia7bWkPHz4F+63aygEhhvFgprCJgCPvsj02dDs+ZsRzg0xVPS
        sm46h/ZAdVEZYxuzfrrRwZew2te7J94=
X-Google-Smtp-Source: ADFU+vsxz2V6zzv4+5/CZTt5AhT5BOQ0j3WoZWiA9Z7bC4BtMeX4jcXf5VBJ3paF3L0GYn0/pQHx1A==
X-Received: by 2002:a63:c54b:: with SMTP id g11mr5665118pgd.164.1583981921025;
        Wed, 11 Mar 2020 19:58:41 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id i11sm1910322pfd.202.2020.03.11.19.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 19:58:40 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v3 0/2] RISC-V page table dumper
Date:   Thu, 12 Mar 2020 10:58:34 +0800
Message-Id: <20200312025836.68977-1-zong.li@sifive.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch supports dumping page tables, and it's implemented on top of
the generic page table dumper patch set.

Changed in v3:
 - Modify warning message.

Changed in v2:
 - Remove unnecessary #ifdef directive.

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
2.25.1

