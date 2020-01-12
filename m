Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA9DC33CA2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 16:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C122080D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 16:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733162AbgALQ4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 11:56:22 -0500
Received: from xavier.telenet-ops.be ([195.130.132.52]:57814 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733111AbgALQ4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 11:56:18 -0500
Received: from ramsan ([84.195.182.253])
        by xavier.telenet-ops.be with bizsmtp
        id pUwG210045USYZQ01UwG3F; Sun, 12 Jan 2020 17:56:16 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iqgXA-00082s-5Q; Sun, 12 Jan 2020 17:56:16 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iqgXA-0005Sq-36; Sun, 12 Jan 2020 17:56:16 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Philip Blundell <philb@gnu.org>
Cc:     linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 0/3] dio: Miscellaneous cleanups
Date:   Sun, 12 Jan 2020 17:56:10 +0100
Message-Id: <20200112165613.20960-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

This patch series contains miscellaneous cleanups for the Zorro bus
code.

Geert Uytterhoeven (3):
  dio: Make dio_match_device() static
  dio: Fix dio_bus_match() kerneldoc
  dio: Remove unused dio_dev_driver()

 drivers/dio/dio-driver.c | 9 ++++-----
 include/linux/dio.h      | 5 -----
 2 files changed, 4 insertions(+), 10 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
