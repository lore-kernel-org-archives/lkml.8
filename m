Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8B7C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37D382072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbgHQJUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 05:20:35 -0400
Received: from foss.arm.com ([217.140.110.172]:51626 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728139AbgHQJUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 05:20:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C522E31B;
        Mon, 17 Aug 2020 02:20:30 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.65.199])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 88B433F6CF;
        Mon, 17 Aug 2020 02:20:27 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] arm64/mm: Enable THP migration
Date:   Mon, 17 Aug 2020 14:49:42 +0530
Message-Id: <1597655984-15428-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables THP migration on arm64 via ARCH_ENABLE_THP_MIGRATION.
But first this modifies all existing THP helpers like pmd_present() and
pmd_trans_huge() etc per expected generic memory semantics as concluded
from a previous discussion here.

https://lkml.org/lkml/2018/10/9/220

This series is based on v5.9-rc1.

Changes in V1:

- Used new PMD_PRESENT_INVALID (bit 59) to represent invalidated PMD state per Catalin

Changes in RFC V2: (https://patchwork.kernel.org/project/linux-mm/list/?series=302965)

- Used PMD_TABLE_BIT to represent splitting PMD state per Catalin

Changes in RFC V1: (https://patchwork.kernel.org/project/linux-mm/list/?series=138797)

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Suzuki Poulose <suzuki.poulose@arm.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (2):
  arm64/mm: Change THP helpers to comply with generic MM semantics
  arm64/mm: Enable THP migration

 arch/arm64/Kconfig                    |  4 +++
 arch/arm64/include/asm/pgtable-prot.h |  7 +++++
 arch/arm64/include/asm/pgtable.h      | 39 ++++++++++++++++++++++++---
 3 files changed, 47 insertions(+), 3 deletions(-)

-- 
2.20.1

