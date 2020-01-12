Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CE0C33CA2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 16:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5E7214D8
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 16:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733121AbgALQtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 11:49:53 -0500
Received: from michel.telenet-ops.be ([195.130.137.88]:36626 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730020AbgALQtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 11:49:53 -0500
Received: from ramsan ([84.195.182.253])
        by michel.telenet-ops.be with bizsmtp
        id pUpr210015USYZQ06UprVy; Sun, 12 Jan 2020 17:49:51 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iqgQw-0007yE-TY; Sun, 12 Jan 2020 17:49:50 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iqgQw-0005Ge-RN; Sun, 12 Jan 2020 17:49:50 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 0/5] zorro: Miscellaneous cleanups
Date:   Sun, 12 Jan 2020 17:49:44 +0100
Message-Id: <20200112164949.20196-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

This patch series contains miscellaneous cleanups for the Zorro bus
code.

Geert Uytterhoeven (5):
  zorro: Make zorro_match_device() static
  zorro: Fix zorro_bus_match() kerneldoc
  zorro: Use zorro_match_device() helper in zorro_bus_match()
  zorro: Remove unused zorro_dev_driver()
  zorro: Move zorro_bus_type to bus-private header file

 drivers/zorro/zorro-driver.c | 16 +++++-----------
 drivers/zorro/zorro.h        |  7 +++++++
 include/linux/zorro.h        | 12 ------------
 3 files changed, 12 insertions(+), 23 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
