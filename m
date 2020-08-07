Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27310C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 04:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15D4F22CAF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 04:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgHGE46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 00:56:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgHGE45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 00:56:57 -0400
Received: from [10.44.0.192] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98557221E2;
        Fri,  7 Aug 2020 04:56:55 +0000 (UTC)
From:   Greg Ungerer <gerg@linux-m68k.org>
Subject: [git pull] m68knommu changes for v5.9
To:     torvalds@linux-foundation.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <71db8f0b-0178-30a7-3871-c56eb5688432@linux-m68k.org>
Date:   Fri, 7 Aug 2020 14:56:52 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the m68knommu changes for v5.9.

Regards
Greg



The following changes since commit 92ed301919932f777713b9172e525674157e983d:

   Linux 5.8-rc7 (2020-07-26 14:14:06 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v5.9

for you to fetch changes up to fde87ebf1daa8d96e4412aa06536da4b55103e02:

   m68k: stmark2: enable edma support for dspi (2020-07-27 12:32:00 +1000)

----------------------------------------------------------------
m68knommu: collection of fixes for v5.9

Fixes include:
. cleanup compiler warnings (IO access functions and unused variables)
. ColdFire v3 cache control fix
. ColdFire MMU comment cleanup
. switch to using asm-generic cmpxchg_local()
. stmark platform updates

----------------------------------------------------------------
Angelo Dureghello (2):
       m68k: stmark2: defconfig updates
       m68k: stmark2: enable edma support for dspi

Greg Ungerer (5):
       m68knommu: __force type casts for raw IO access
       m68knommu: fix use of cpu_to_le() on IO access
       m68k: fix ColdFire mmu init compile warning
       m68knommu: fix overwriting of bits in ColdFire V3 cache control
       m68k: use asm-generic cmpxchg_local()

Mike Rapoport (1):
       m68k: mcfmmu: remove stale part of comment about steal_context

  arch/m68k/coldfire/stmark2.c        |  5 ++++
  arch/m68k/configs/stmark2_defconfig | 47 +++++++++++++++++++++----------------
  arch/m68k/include/asm/cmpxchg.h     |  8 -------
  arch/m68k/include/asm/io_no.h       | 20 ++++++++--------
  arch/m68k/include/asm/m53xxacr.h    |  6 ++---
  arch/m68k/mm/mcfmmu.c               |  6 -----
  6 files changed, 45 insertions(+), 47 deletions(-)
