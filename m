Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4399C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 22:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4952465A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 22:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgAVWYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 17:24:02 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:47744 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgAVWYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 17:24:01 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 16A7E299A4; Wed, 22 Jan 2020 17:23:59 -0500 (EST)
Message-Id: <cover.1579730846.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH net v3 00/12] Fixes for SONIC ethernet driver
Date:   Thu, 23 Jan 2020 09:07:26 +1100
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Chris Zankel <chris@zankel.net>,
        Laurent Vivier <laurent@vivier.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Various SONIC driver problems have become apparent over the years,
including tx watchdog timeouts, lost packets and duplicated packets.

The problems are mostly caused by bugs in buffer handling, locking and
(re-)initialization code.

This patch series resolves these problems.

This series has been tested on National Semiconductor hardware (macsonic),
qemu-system-m68k (macsonic) and qemu-system-mips64el (jazzsonic).

The emulated dp8393x device used in QEMU also has bugs.
I have fixed the bugs that I know of in a series of patches at,
https://github.com/fthain/qemu/commits/sonic
---
Changed since v1:
 - Minor revisions as described in commit logs.
 - Deferred net-next patches.
Changed since v2:
 - Minor revisions as described in commit logs.


Finn Thain (12):
  net/sonic: Add mutual exclusion for accessing shared state
  net/sonic: Clear interrupt flags immediately
  net/sonic: Use MMIO accessors
  net/sonic: Fix interface error stats collection
  net/sonic: Fix receive buffer handling
  net/sonic: Avoid needless receive descriptor EOL flag updates
  net/sonic: Improve receive descriptor status flag check
  net/sonic: Fix receive buffer replenishment
  net/sonic: Quiesce SONIC before re-initializing descriptor memory
  net/sonic: Fix command register usage
  net/sonic: Fix CAM initialization
  net/sonic: Prevent tx watchdog timeout

 drivers/net/ethernet/natsemi/sonic.c | 380 ++++++++++++++++-----------
 drivers/net/ethernet/natsemi/sonic.h |  44 +++-
 2 files changed, 262 insertions(+), 162 deletions(-)

-- 
2.24.1

