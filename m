Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F6EC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E5320714
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729909AbgBJNAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:00:42 -0500
Received: from foss.arm.com ([217.140.110.172]:60716 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729921AbgBJNAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 08:00:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EF771FB;
        Mon, 10 Feb 2020 05:00:20 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 67CB93F68E;
        Mon, 10 Feb 2020 05:00:19 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     broonie@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        richard.henderson@linaro.org, tytso@mit.edu, will@kernel.org
Subject: [PATCH 0/4] random/arm64: enable RANDOM_TRUST_CPU for arm64
Date:   Mon, 10 Feb 2020 13:00:11 +0000
Message-Id: <20200210130015.17664-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On arm64 systems some CPUs may have RNG instructions while others do
not, and consequently we cannot generally enable the use of RNG
instructions until all CPUs have been booted (as otherwise we'd have
problems with preemption, etc). This prevents us from seeding the
primary CRNG using the RNG, as this occurs before secondary CPUs are
onlined.

These patches rework the core CRNG intialization code so that the arch
code can (optionally) distinguish boot-time usage from runtime usage of
the arch_get_random_*() functions. This allows arm64 to use the boot
CPU's RNG to seed the primary CRNG, regardless of whether secondary CPUs
support the RNG instructions. Other architectures should see no
functional change as a result of this patches.

Thanks,
Mark.

Mark Rutland (3):
  random: split primary/secondary crng init paths
  random: add arch_get_random_*long_early()
  arm64: add credited/trusted RNG support

Richard Henderson (1):
  random: Make RANDOM_TRUST_CPU depend on ARCH_RANDOM

 arch/arm64/include/asm/archrandom.h | 14 ++++++++++
 drivers/char/Kconfig                |  2 +-
 drivers/char/random.c               | 52 ++++++++++++++++++++++++++++---------
 include/linux/random.h              | 22 ++++++++++++++++
 4 files changed, 77 insertions(+), 13 deletions(-)

-- 
2.11.0

