Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EA1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 03:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AA8E2075F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 03:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgE0DEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 23:04:40 -0400
Received: from foss.arm.com ([217.140.110.172]:59766 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgE0DEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 23:04:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B9B030E;
        Tue, 26 May 2020 20:04:39 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.76.100])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D387E3F6C4;
        Tue, 26 May 2020 20:04:35 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        suzuki.poulose@arm.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Subject: [PATCH V5 0/4] arm64/cpufeature: Introduce ID_PFR2, ID_DFR1, ID_MMFR5 and other changes
Date:   Wed, 27 May 2020 08:33:35 +0530
Message-Id: <1590548619-3441-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are remaining patches from V4 series which had some pending reviews
from Suzuki (https://patchwork.kernel.org/cover/11557333/). Also dropped
[PATCH 15/17] as that will need some more investigation and rework.

This series applies on arm64/for-next/cpufeature.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com> 
Cc: Marc Zyngier <maz@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvmarm@lists.cs.columbia.edu
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Changes in V5:

- Dropped TGRAN features along with it's macros from ID_AA64MMFR0 per Suzuki
- Replaced with FTR_HIGHER_SAFE for SpecSEI feature in ID_AA64MMFR1 per Suzuki
- Dropped patch "arm64/cpufeature: Add remaining feature bits in ID_AA64DFR0 register"

Changes in V4: (https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=290085)

- Updated ftr_id_dfr0[] with a documentation for now missing [31:28] Tracfilt per Will
- Fixed erroneous bit width value from 28 to 4 for double lock feature per Will
- Replaced ID_SANITIZED() with ID_HIDDEN() for SYS_ID_DFR1_EL1 per Suzuki
- Fixed positions for register definitions as per new name based grouping per Will
- Replaced FTR_VISIBLE with FTR_HIDDEN for TLB feature in ID_AA64ISAR0 per Suzuki
- Replaced FTR_VISIBLE with FTR_HIDDEN for MPAM and SEL2 in ID_AA64PFR0 per Suzuki
- Replaced FTR_VISIBLE with FTR_HIDDEN for MPAMFRAC and RASFRAC in ID_AA64PFR1 per Suzuki
- Dropped both MTE and BT features from ftr_id_aa64pfr1[] to be added later per Suzuki
- Added ID_MMFR4_EL1 into the cpuinfo_arm64 context per Will

Changes in V3: (https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=281211)

- Rebased on git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git (for-next/cpufeature)

Changes in V2: (https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=270605)

- Added Suggested-by tag from Mark Rutland for all changes he had proposed
- Added comment for SpecSEI feature on why it is HIGHER_SAFE per Suzuki
- Added a patch which makes ID_AA64DFR0_DOUBLELOCK a signed feature per Suzuki
- Added ID_DFR1 and ID_MMFR5 system register definitions per Will
- Added remaining features bits for relevant 64 bit system registers per Will
- Changed commit message on [PATCH 5/7] regarding TraceFilt feature per Suzuki
- Changed ID_PFR2.CSV3 (FTR_STRICT -> FTR_NONSTRICT) as 64 bit registers per Will
- Changed ID_PFR0.CSV2 (FTR_STRICT -> FTR_NONSTRICT) as 64 bit registers per Will 
- Changed some commit messages

Changes in V1: (https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=234093)

Anshuman Khandual (4):
  arm64/cpufeature: Add remaining feature bits in ID_AA64MMFR0 register
  arm64/cpufeature: Add remaining feature bits in ID_AA64MMFR1 register
  arm64/cpufeature: Add remaining feature bits in ID_AA64MMFR2 register
  arm64/cpufeature: Replace all open bits shift encodings with macros

 arch/arm64/include/asm/sysreg.h | 42 +++++++++++++++++++++
 arch/arm64/kernel/cpufeature.c  | 67 ++++++++++++++++++++-------------
 2 files changed, 83 insertions(+), 26 deletions(-)

-- 
2.20.1

