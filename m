Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732CDC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 15:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B9E5208FE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 15:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgGCPzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 11:55:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbgGCPzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 11:55:07 -0400
Received: from localhost.localdomain (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EE4420899;
        Fri,  3 Jul 2020 15:55:05 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH V5 (RESEND) 0/4] arm64/cpufeature: Introduce ID_PFR2, ID_DFR1, ID_MMFR5 and other changes
Date:   Fri,  3 Jul 2020 16:55:03 +0100
Message-Id: <159379155800.20268.8910088727326709928.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1593748297-1965-1-git-send-email-anshuman.khandual@arm.com>
References: <1593748297-1965-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jul 2020 09:21:33 +0530, Anshuman Khandual wrote:
> These are remaining patches from V4 series which had some pending reviews
> from Suzuki (https://patchwork.kernel.org/cover/11557333/). Also dropped
> [PATCH 15/17] as that will need some more investigation and rework.
> 
> This series applies on 5.8-rc3.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: James Morse <james.morse@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: kvmarm@lists.cs.columbia.edu
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> 
> [...]

Applied to arm64 (for-next/cpufeature), thanks!

[1/4] arm64/cpufeature: Add remaining feature bits in ID_AA64MMFR0 register
      https://git.kernel.org/arm64/c/bc67f10ad1d7
[2/4] arm64/cpufeature: Add remaining feature bits in ID_AA64MMFR1 register
      https://git.kernel.org/arm64/c/853772ba8023
[3/4] arm64/cpufeature: Add remaining feature bits in ID_AA64MMFR2 register
      https://git.kernel.org/arm64/c/356fdfbe8761
[4/4] arm64/cpufeature: Replace all open bits shift encodings with macros
      https://git.kernel.org/arm64/c/8d3154afc10d

-- 
Catalin

