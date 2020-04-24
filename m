Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E2FC54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3627321775
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgDXREx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:04:53 -0400
Received: from foss.arm.com ([217.140.110.172]:40132 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726793AbgDXREx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 13:04:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BFF431B;
        Fri, 24 Apr 2020 10:04:50 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C01033F6CF;
        Fri, 24 Apr 2020 10:04:49 -0700 (PDT)
Date:   Fri, 24 Apr 2020 18:04:43 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 5.7-rc3
Message-ID: <20200424170440.GA29363@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:

  Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 59bff30ad6cec6b5babc8132eb8dcb48f1c82be0:

  Documentation: arm64: fix amu.rst doc warnings (2020-04-23 17:05:22 +0100)

----------------------------------------------------------------
- Ensure context synchronisation after a write to APIAKey.

- Fix bullet list formatting in Documentation/arm64/amu.rst to eliminate
  doc warnings.

----------------------------------------------------------------
Mark Rutland (1):
      arm64: sync kernel APIAKey when installing

Randy Dunlap (1):
      Documentation: arm64: fix amu.rst doc warnings

 Documentation/arm64/amu.rst           | 47 +++++++++++++++++++----------------
 arch/arm64/include/asm/pointer_auth.h |  9 ++++---
 2 files changed, 32 insertions(+), 24 deletions(-)

-- 
Catalin
