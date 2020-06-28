Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B949CC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 14:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 987DA20738
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 14:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgF1OMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 10:12:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:34042 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbgF1OMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 10:12:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 543E6ACBD;
        Sun, 28 Jun 2020 14:12:46 +0000 (UTC)
Date:   Sun, 28 Jun 2020 16:12:45 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] objtool/urgent for 5.8
Message-ID: <20200628141245.GB18884@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull three fixes from peterz suppressing KCOV instrumentation in
noinstr sections.

Thx.

---

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/objtool_urgent_for_5.8_rc3

for you to fetch changes up to 0f1441b44e823a74f3f3780902a113e07c73fbf6:

  objtool: Fix noinstr vs KCOV (2020-06-18 17:36:33 +0200)

----------------------------------------------------------------
Peter Zijlstra says:

Address KCOV vs noinstr. There is no function attribute to selectively
suppress KCOV instrumentation, instead teach objtool to NOP out the
calls in noinstr functions.

This cures a bunch of KCOV crashes (as used by syzcaller).

----------------------------------------------------------------
Peter Zijlstra (3):
      objtool: Clean up elf_write() condition
      objtool: Provide elf_write_{insn,reloc}()
      objtool: Fix noinstr vs KCOV

 arch/x86/Kconfig                          |  2 +-
 tools/objtool/arch.h                      |  2 ++
 tools/objtool/arch/x86/decode.c           | 18 +++++++++++
 tools/objtool/arch/x86/include/arch_elf.h |  6 ++++
 tools/objtool/check.c                     | 23 +++++++++++++-
 tools/objtool/elf.c                       | 53 +++++++++++++++++++++++++++++--
 tools/objtool/elf.h                       | 12 +++++--
 tools/objtool/orc_gen.c                   |  2 +-
 8 files changed, 109 insertions(+), 9 deletions(-)
 create mode 100644 tools/objtool/arch/x86/include/arch_elf.h

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
