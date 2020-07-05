Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28593C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 10:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 114AE2075B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 10:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgGEKkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 06:40:16 -0400
Received: from elvis.franken.de ([193.175.24.41]:49460 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726355AbgGEKkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 06:40:16 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1js24E-0003Dc-00; Sun, 05 Jul 2020 12:40:14 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 4E5B7C077D; Sun,  5 Jul 2020 12:40:08 +0200 (CEST)
Date:   Sun, 5 Jul 2020 12:40:08 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     torvalds@linux-foundation.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] MIPS fixes for v5.8
Message-ID: <20200705104008.GA5156@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the few MIPS fixes.

Thomas.

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_fixes_5.8_1

for you to fetch changes up to 5868347a192afb99b189d72946ab6a321b6115ac:

  MIPS: Do not use smp_processor_id() in preemptible code (2020-07-05 11:43:52 +0200)

----------------------------------------------------------------
A few MIPS fixes:

- fix for missing hazard barrier

- DT fix for ingenic

- DT fix of GPHY names for lantiq

- fix usage of smp_processor_id() while preemption is enabled

----------------------------------------------------------------
Hauke Mehrtens (1):
      MIPS: Add missing EHB in mtc0 -> mfc0 sequence for DSPen

João H. Spies (1):
      MIPS: ingenic: gcw0: Fix HP detection GPIO.

Martin Blumenstingl (1):
      MIPS: lantiq: xway: sysctrl: fix the GPHY clock alias names

Xingxing Su (1):
      MIPS: Do not use smp_processor_id() in preemptible code

 arch/mips/boot/dts/ingenic/gcw0.dts | 2 +-
 arch/mips/kernel/traps.c            | 9 ++++++---
 arch/mips/lantiq/xway/sysctrl.c     | 8 ++++----
 3 files changed, 11 insertions(+), 8 deletions(-)
-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
