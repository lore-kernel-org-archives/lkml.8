Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26651C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 22:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE9742075D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 22:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgG0WJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 18:09:25 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:36534 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgG0WJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 18:09:25 -0400
Date:   Mon, 27 Jul 2020 18:09:24 -0400
From:   Rich Felker <dalias@libc.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-sh list <linux-sh@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [GIT PULL] arch/sh additional critical fixes 5.8
Message-ID: <20200727220922.GP6949@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I have some last-minute fixes I hope you can still pull in for 5.8.
One is for a boot regression (mmu code broken) and the other fixes a
long-standing broken syscall number bounds check.

Rich



The following changes since commit 92ed301919932f777713b9172e525674157e983d:

  Linux 5.8-rc7 (2020-07-26 14:14:06 -0700)

are available in the Git repository at:

  git://git.libc.org/linux-sh tags/sh-for-5.8-part2

for you to fetch changes up to 04a8a3d0a73f51c7c2da84f494db7ec1df230e69:

  sh: Fix validation of system call number (2020-07-27 16:12:49 -0400)

----------------------------------------------------------------
Fixes for major regression and longstanding bounds-checking error.

----------------------------------------------------------------
Michael Karcher (1):
      sh: Fix validation of system call number

Peter Zijlstra (1):
      sh/tlb: Fix PGTABLE_LEVELS > 2

 arch/sh/include/asm/pgalloc.h | 10 +---------
 arch/sh/kernel/entry-common.S |  6 +++---
 2 files changed, 4 insertions(+), 12 deletions(-)
