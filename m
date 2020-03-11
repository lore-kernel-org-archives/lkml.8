Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F38C18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 10:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3FD52071B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 10:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbgCKKMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 06:12:05 -0400
Received: from elvis.franken.de ([193.175.24.41]:33982 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgCKKMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 06:12:05 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jByLL-00075u-00; Wed, 11 Mar 2020 11:12:03 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 4A00BC0FDD; Wed, 11 Mar 2020 11:11:55 +0100 (CET)
Date:   Wed, 11 Mar 2020 11:11:55 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mips <linux-mips@vger.kernel.org>
Subject: [GIT PULL] MIPS fixes for v5.6
Message-ID: <20200311101155.GA9476@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here are some small MIPS fixes for v5.6. Please pull.

Thomas.

The following changes since commit 3234f4ed3066a58cd5ce8edcf752fa4fe0c95cb5:

  MAINTAINERS: Hand MIPS over to Thomas (2020-02-24 22:43:18 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_fixes_5.6.1

for you to fetch changes up to f7d5f5655ef7e5d2a128f6696ac35256e83b119b:

  MAINTAINERS: Correct MIPS patchwork URL (2020-03-09 12:10:01 +0100)

----------------------------------------------------------------
A few MIPS fixes:

- DT fixes for CI20

- Fix command line handling

- Correct patchwork URL

----------------------------------------------------------------
H. Nikolaus Schaller (2):
      MIPS: DTS: CI20: fix PMU definitions for ACT8600
      MIPS: DTS: CI20: fix interrupt for pcf8563 RTC

Paul Cercueil (1):
      MIPS: Fix CONFIG_MIPS_CMDLINE_DTB_EXTEND handling

Thomas Bogendoerfer (1):
      MAINTAINERS: Correct MIPS patchwork URL

 MAINTAINERS                         |  2 +-
 arch/mips/boot/dts/ingenic/ci20.dts | 44 +++++++++++++++++++++++--------------
 arch/mips/kernel/setup.c            |  3 ++-
 3 files changed, 31 insertions(+), 18 deletions(-)

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
