Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C2FC352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 21:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324242070A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 21:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbgBJV0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 16:26:49 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:59710 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbgBJV0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 16:26:49 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id E437F29B4B; Mon, 10 Feb 2020 16:26:47 -0500 (EST)
Message-Id: <cover.1581369530.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH net-next 0/7] Improvements for SONIC ethernet drivers
Date:   Tue, 11 Feb 2020 08:18:50 +1100
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Chris Zankel <chris@zankel.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Now that the necessary sonic driver fixes have been merged, and the merge
window has closed again, I'm sending the remainder of my sonic driver
patch queue.

A couple of these patches will have to be applied in sequence to avoid
'git am' rejects. The others are independent and could have been submitted
individually. Please let me know if I should do that.

The complete sonic driver patch queue was tested on National Semiconductor
hardware (macsonic), qemu-system-m68k (macsonic) and qemu-system-mips64el
(jazzsonic).


Finn Thain (7):
  net/sonic: Remove obsolete comment
  net/sonic: Refactor duplicated code
  net/sonic: Remove redundant next_tx variable
  net/sonic: Remove redundant netif_start_queue() call
  net/sonic: Remove explicit memory barriers
  net/sonic: Start packet transmission immediately
  net/macsonic: Remove interrupt handler wrapper

 drivers/net/ethernet/natsemi/jazzsonic.c | 31 +----------
 drivers/net/ethernet/natsemi/macsonic.c  | 48 +++--------------
 drivers/net/ethernet/natsemi/sonic.c     | 66 +++++++++++++++++-------
 drivers/net/ethernet/natsemi/sonic.h     |  2 +-
 drivers/net/ethernet/natsemi/xtsonic.c   | 40 +-------------
 5 files changed, 60 insertions(+), 127 deletions(-)

-- 
2.24.1

