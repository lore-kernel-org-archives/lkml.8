Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0612DC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 23:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0BA02068D
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 23:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbgE3XUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 19:20:35 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:51170 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729356AbgE3XUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 19:20:33 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id E3A9327F0C; Sat, 30 May 2020 19:20:32 -0400 (EDT)
Message-Id: <cover.1590880623.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 0/8] Mac ADB IOP driver fixes
Date:   Sun, 31 May 2020 09:17:03 +1000
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Joshua Thompson <funaho@jurai.org>,
        linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        "Geert Uytterhoeven" <geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The adb-iop driver was never finished. Some deficiencies have become
apparent over the years. For example,

 - Mouse and/or keyboard may stop working if used together

 - SRQ autopoll list cannot be changed

 - Some bugs were found by inspection

This patch series contains fixes for the known bugs in the driver, plus
a few clean-ups.


Finn Thain (8):
  macintosh/adb-iop: Remove dead and redundant code
  macintosh/adb-iop: Correct comment text
  macintosh/adb-iop: Adopt bus reset algorithm from via-macii driver
  macintosh/adb-iop: Access current_req and adb_iop_state when inside
    lock
  macintosh/adb-iop: Resolve static checker warnings
  macintosh/adb-iop: Implement idle -> sending state transition
  macintosh/adb-iop: Implement sending -> idle state transition
  macintosh/adb-iop: Implement SRQ autopolling

 arch/m68k/include/asm/adb_iop.h |   1 +
 drivers/macintosh/adb-iop.c     | 186 +++++++++++++++-----------------
 2 files changed, 86 insertions(+), 101 deletions(-)

-- 
2.26.2

