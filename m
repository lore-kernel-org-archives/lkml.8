Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35551C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A46520870
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585047171;
	bh=+iibOFkBWKJV8Q+pH/D981jndLEWtZUGhcDEhF4SEfU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=gpdDoyAdu4XIjV1QU8egiTMyYhOiPulTrmrWyKrNB+DDBWIysO6UnGlM8TU93eJho
	 5vCkhVDCaRF/CZH6d66sfpwckj/dQ0NG5ThxDG+P0VEIcvd6Hld/KfjEEuC8XLSDyg
	 MhBNsDu6OBPtDYU1Try0u2zn4NUdYlwa88bCCtX0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbgCXKwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 06:52:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:32926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbgCXKwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 06:52:49 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B519920786;
        Tue, 24 Mar 2020 10:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585047169;
        bh=+iibOFkBWKJV8Q+pH/D981jndLEWtZUGhcDEhF4SEfU=;
        h=From:To:Cc:Subject:Date:From;
        b=i3lRfVJixvsC2NTSGynPfxWXY8m+3bQnIf5uTNtSbJmfxK5h2sz+Xnwpga0Rg3R2A
         eIl5Ga37mBa9/65lWCLuq26P7ckL8eNCoAaee1vQy47hifYJfnrG8/qXpJsiUJvulx
         eztwd5HCZEcU60PLffQBGNf9Fg7gcPXCCoELyD1I=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        sparclinux@vger.kernel.org
Subject: [PATCH 0/4] Rework sparc32 page-table layout
Date:   Tue, 24 Mar 2020 10:40:01 +0000
Message-Id: <20200324104005.11279-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

This series of patches reworks the sparc32 page-table layout so that
'pmd_t' no longer embeds an array of 16 physical pointers, which means
that we can finally enforce atomicity for accesses made using READ_ONCE():

  https://lkml.kernel.org/r/20200123153341.19947-1-will@kernel.org

I've tested this with QEMU by booting Debian Etch. Please take a look!

Cheers,

Will

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: sparclinux@vger.kernel.org

--->8

Will Deacon (4):
  sparc32: mm: Fix argument checking in __srmmu_get_nocache()
  sparc32: mm: Restructure sparc32 MMU page-table layout
  sparc32: mm: Change pgtable_t type to pte_t * instead of struct page *
  sparc32: mm: Reduce allocation size for PMD and PTE tables

 arch/sparc/include/asm/page_32.h    | 12 ++--
 arch/sparc/include/asm/pgalloc_32.h | 11 ++--
 arch/sparc/include/asm/pgtable_32.h | 40 +++++++-----
 arch/sparc/include/asm/pgtsrmmu.h   | 36 +----------
 arch/sparc/include/asm/viking.h     |  5 +-
 arch/sparc/kernel/head_32.S         |  8 +--
 arch/sparc/mm/hypersparc.S          |  3 +-
 arch/sparc/mm/srmmu.c               | 95 ++++++++++-------------------
 arch/sparc/mm/viking.S              |  5 +-
 9 files changed, 85 insertions(+), 130 deletions(-)

-- 
2.20.1

