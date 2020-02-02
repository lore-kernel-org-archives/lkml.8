Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12B5C3524B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 02:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C16BE2067C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 02:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgBBCiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 21:38:19 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:40180 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbgBBCiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 21:38:19 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id C87F129AFA; Sat,  1 Feb 2020 21:38:15 -0500 (EST)
Message-Id: <cover.1580610812.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 0/3] Improve MIPS Magnum support
Date:   Sun, 02 Feb 2020 13:33:32 +1100
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        James Hogan <jhogan@kernel.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Bartlomiej Zolnierkiewicz" <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few minor patches are needed to more easily boot a MIPS Magnum build
under 'qemu-system-mips64el -M magnum'. This series fixes a build failure
in the g364fb driver and modifies jazz_defconfig for use with QEMU.

Note that QEMU's dp8393x implementation has bugs, one of which prevents
the Linux jazzsonic driver from probing the chip. I have fixed the bugs
that I know of in a series of patches at,
https://github.com/fthain/qemu/commits/sonic


Finn Thain (3):
  fbdev/g364fb: Fix build failure
  mips/jazz: Remove redundant settings and shrink jazz_defconfig
  mips/jazz: Update jazz_defconfig for MIPS Magnum

 arch/mips/configs/jazz_defconfig | 267 ++-----------------------------
 drivers/video/fbdev/g364fb.c     |  29 +---
 2 files changed, 15 insertions(+), 281 deletions(-)

-- 
2.24.1

