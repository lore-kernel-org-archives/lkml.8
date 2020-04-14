Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526A8C3815B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 21:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31CC620774
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 21:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586899896;
	bh=qeG55Sjfpyu47bFN+MIW7aw5s10goy92+ZhxxXPxgLA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=2V7uBu5arF5Z3jgRaROLjr4bU7axoFfVwib7ytwHIigwum5GH2IcwwVzDpB+NFw2P
	 EeQ8rel+TLxCX8z4WS2J8LHWiPZEWLf6fftidt0kdSQKm625eokK/qqKst0YjYFtPi
	 +SjyWwkZV8p38wm+MilWD+lfIWZk+yoM58oNG3vo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633845AbgDNVbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 17:31:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:39886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633809AbgDNVbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 17:31:25 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F369320644;
        Tue, 14 Apr 2020 21:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586899884;
        bh=qeG55Sjfpyu47bFN+MIW7aw5s10goy92+ZhxxXPxgLA=;
        h=From:To:Cc:Subject:Date:From;
        b=GJNTUFI7Ga6QB1tE8ADU5wTm6J3Znm9yDhnzk02eI1nHt2RXGL4ZBivouf8AzK+H+
         2r5KYB9HelKtM8LlTi5bi8/yFDKY3Jc0nUnhKXbOhKJDDy3xVyDIdguYTF0m7M0M8Z
         E6cmcsfaMMjenVFhUnJb+ao24FOPYE0P4rxLGmRE=
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
Subject: [PATCH 0/8] Relax sanity checking for mismatched AArch32 EL1
Date:   Tue, 14 Apr 2020 22:31:06 +0100
Message-Id: <20200414213114.2378-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

For better or worse, there are SoCs in production where some, but not
all of the CPUs, support AArch32 at EL1 and above. Right now, that
results in "SANITY CHECK" warnings during boot and an unconditional
kernel taint.

This patch series tries to do a bit better: the only time we care about
AArch32 at EL1 is for KVM, so rather than throw our toys out of the
pram, we can instead just disable support for 32-bit guests on these
systems. In the unlikely scenario of a late CPU hotplug being the first
time we notice that AArch32 is not available, then we fail the hotplug
(right now we let the thing come online, which leads to hilarious
results for any pre-existing 32-bit guests).

Feedback welcome,

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
 arch/arm64/include/asm/sysreg.h     |  18 +++
 arch/arm64/kernel/cpufeature.c      | 236 +++++++++++++++++++++-------
 arch/arm64/kvm/reset.c              |  12 +-
 5 files changed, 206 insertions(+), 70 deletions(-)

-- 
2.26.0.110.g2183baf09c-goog

