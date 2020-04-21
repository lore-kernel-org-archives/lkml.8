Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0371C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE0902070B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587479369;
	bh=s5Sab4jJiJDHJIpjD4RvCm2z34zP3dXNvjG8qk3JShE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=WxorjtURXFtqh2gqEhsxjICgnxxOlkMjOsDdW07ODVXWfhUULk7cu24kqzVCm2GFB
	 x9h8HRqWeCmDNPo0aN32yUkHWyCnoLofjINaDyYwgzOgC+1jik6AfzeSrxlyHxzF51
	 neKzBKuRCLOCyTReaUXWUfk/lSNwJIa8dANHDWjM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbgDUO33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 10:29:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbgDUO32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 10:29:28 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03F4F206B8;
        Tue, 21 Apr 2020 14:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587479368;
        bh=s5Sab4jJiJDHJIpjD4RvCm2z34zP3dXNvjG8qk3JShE=;
        h=From:To:Cc:Subject:Date:From;
        b=lzpP1FSGfbR/3p7IVdtgVFBf7t6Kgb/fybDrn+J9ySJZy9hpI+kFaRHIz2yOU8hg2
         iFs6Ze2Hxjz3yyrg2ROMU9YOm0b6kqPKS5d1zkqvyTFq9vAZ4aCtJC4y4oFavDrM7G
         n64/U9FpYOqS9ta9AX9SxGMl0ruF1YCwnqJsD1i8=
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>, kernel-team@android.com
Subject: [PATCH v2 0/8] Relax sanity checking for mismatched AArch32 EL1
Date:   Tue, 21 Apr 2020 15:29:14 +0100
Message-Id: <20200421142922.18950-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

This is version two of the patches I previously posted here:

	https://lore.kernel.org/lkml/20200414213114.2378-1-will@kernel.org/

Changes since v1 include:

  * Typo fixes
  * Added comment to update_32bit_cpu_features() callsite regarding sanitisation
  * Extended comment in final patch to mention KVM
  * Add acks/tested-bys

Cheers,

Will

Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc: Doug Anderson <dianders@chromium.org>
Cc: kernel-team@android.com

--->8

Sai Prakash Ranjan (1):
  arm64: cpufeature: Relax check for IESB support

Will Deacon (7):
  arm64: cpufeature: Spell out register fields for ID_ISAR4 and ID_PFR1
  arm64: cpufeature: Add CPU capability for AArch32 EL1 support
  arm64: cpufeature: Remove redundant call to id_aa64pfr0_32bit_el0()
  arm64: cpufeature: Factor out checking of AArch32 features
  arm64: cpufeature: Relax AArch32 system checks if EL1 is 64-bit only
  arm64: cpufeature: Relax checks for AArch32 support at EL[0-2]
  arm64: cpufeature: Add an overview comment for the cpufeature
    framework

 arch/arm64/include/asm/cpucaps.h    |   3 +-
 arch/arm64/include/asm/cpufeature.h |   7 +
 arch/arm64/include/asm/sysreg.h     |  18 ++
 arch/arm64/kernel/cpufeature.c      | 247 +++++++++++++++++++++-------
 arch/arm64/kvm/reset.c              |  12 +-
 5 files changed, 217 insertions(+), 70 deletions(-)

-- 
2.26.1.301.g55bc3eb7cb9-goog

