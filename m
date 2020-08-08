Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A1EC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 20:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A811B206B5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 20:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgHHUxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 16:53:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbgHHUxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 16:53:15 -0400
Received: from localhost.localdomain (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E508E206B5;
        Sat,  8 Aug 2020 20:53:13 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fix for 5.9-rc1
Date:   Sat,  8 Aug 2020 21:53:12 +0100
Message-Id: <20200808205312.565-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 updates below. The fix addresses a symbol export
for the tegra194-cpufreq module that made its way into mainline (the
issue was found in -next but still debating an alternative fix without
exporting __cpu_logical_map).

Thanks.

The following changes since commit 0e4cd9f2654915be8d09a1bd1b405ce5426e64c4:

  Merge branch 'for-next/read-barrier-depends' into for-next/core (2020-07-31 18:09:57 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to eaecca9e7710281be7c31d892c9f447eafd7ddd9:

  arm64: Fix __cpu_logical_map undefined issue (2020-08-08 19:25:04 +0100)

----------------------------------------------------------------
- Fix tegra194-cpufreq module build failure caused  __cpu_logical_map
  not exported.

- Improve fixed_addresses comment regarding the fixmap buffer sizes.

----------------------------------------------------------------
Kefeng Wang (1):
      arm64: Fix __cpu_logical_map undefined issue

Pingfan Liu (1):
      arm64/fixmap: make notes of fixed_addresses more precisely

 arch/arm64/include/asm/fixmap.h | 7 +++----
 arch/arm64/include/asm/smp.h    | 7 ++++++-
 arch/arm64/kernel/setup.c       | 8 +++++++-
 arch/arm64/kernel/smp.c         | 6 +++---
 4 files changed, 19 insertions(+), 9 deletions(-)
