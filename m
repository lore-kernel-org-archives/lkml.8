Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629D6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45CAD2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgFQOgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 10:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFQOgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 10:36:51 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A37FC0613F0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 07:36:50 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed20:b57b:2191:a081:571d])
        by michel.telenet-ops.be with bizsmtp
        id sEcm2200P1Jlgh206Ecml0; Wed, 17 Jun 2020 16:36:47 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jlZBG-0007ph-L8; Wed, 17 Jun 2020 16:36:46 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jlZBG-0004mJ-I1; Wed, 17 Jun 2020 16:36:46 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 0/9] sh: Modernize printing of kernel messages
Date:   Wed, 17 Jun 2020 16:36:30 +0200
Message-Id: <20200617143639.18315-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

This patch series fixes the broken lines in kernel output, which I
presume have been happening since commit 4bcc595ccd80decb ("printk:
reinstate KERN_CONT for printing continuat ion lines").
Most annoying are the ones in call traces and disassembly dumps, as they
cause lots of small bits of information to fly by your serial console.

Changes compared to v1[1]:
  - Add Tested-by,
  - Drop "sh: fault: Modernize printing of kernel messages", which was
    picked up by Mike and Andrew, but subject to an unintended mutation,
  - Add a fix for the mutation,
  - Rebase on top of "[PATCHv3 00/50] Add log level to show_stack()":
      - Drop conversion of remaining printk() calls to pr_*(), as they
	have all received a loglvl parameter,
      - Remove loglvl parameters from continuations.
  - Add two reverts for commits in the above series, due to people being
    mislead by the lack of pr_cont() use,
  - Add note about printk(KERN_DEBUG ...).

Thanks!

[1] https://lore.kernel.org/r/20191203162645.19950-1-geert+renesas@glider.be

Geert Uytterhoeven (9):
  sh: fault: Fix duplicate printing of "PC:"
  Revert "sh: add loglvl to printk_address()"
  Revert "sh: remove needless printk()"
  sh: kernel: disassemble: Fix broken lines in disassembly dumps
  sh: dump_stack: Fix broken lines and ptrval in calltrace dumps
  sh: process: Fix broken lines in register dumps
  sh: sh2007: Modernize printing of kernel messages
  sh: pci: Modernize printing of kernel messages
  sh: machvec: Modernize printing of kernel messages

 arch/sh/boards/board-sh2007.c    |   4 +-
 arch/sh/drivers/pci/common.c     |   6 +-
 arch/sh/drivers/pci/pci-sh7780.c |  23 ++++---
 arch/sh/drivers/pci/pci.c        |  11 ++--
 arch/sh/include/asm/kdebug.h     |   3 +-
 arch/sh/kernel/disassemble.c     | 103 ++++++++++++++++---------------
 arch/sh/kernel/dumpstack.c       |  23 +++----
 arch/sh/kernel/machvec.c         |   8 +--
 arch/sh/kernel/process_32.c      |  38 +++++-------
 arch/sh/mm/fault.c               |   3 +-
 10 files changed, 108 insertions(+), 114 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
