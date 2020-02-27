Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AE1C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 965C1246A2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbgB0TO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 14:14:58 -0500
Received: from foss.arm.com ([217.140.110.172]:57566 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729327AbgB0TO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 14:14:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 332531FB;
        Thu, 27 Feb 2020 11:14:57 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 992CE3F73B;
        Thu, 27 Feb 2020 11:14:55 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        morten.rasmussen@arm.com, qperret@google.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 0/2] sched, arm64: enable CONFIG_SCHED_SMT for arm64
Date:   Thu, 27 Feb 2020 19:14:31 +0000
Message-Id: <20200227191433.31994-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Strictly speaking those two patches are independent, but I figured it would
make sense to send them together (since one led to the other).

Patch 1 adds a sanity check against EAS + SMT.
Patch 2 enables CONFIG_SCHED_SMT in the arm64 defconfig.

Cheers,
Valentin

Revisions
=========

v1 -> v2
--------
o Collected Reviewed-by, Acked-by (Dietmar, Quentin)
o Added a warning when disabling EAS due to SMT (Dietmar)

Valentin Schneider (2):
  sched/topology: Don't enable EAS on SMT systems
  arm64: defconfig: enable CONFIG_SCHED_SMT

 arch/arm64/configs/defconfig |  1 +
 kernel/sched/topology.c      | 12 ++++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

--
2.24.0

