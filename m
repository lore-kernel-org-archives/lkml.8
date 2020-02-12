Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727BAC3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1362073C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbgBLKPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 05:15:53 -0500
Received: from albert.telenet-ops.be ([195.130.137.90]:43374 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbgBLKPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 05:15:50 -0500
Received: from ramsan ([84.195.182.253])
        by albert.telenet-ops.be with bizsmtp
        id 1mFm2200D5USYZQ06mFm6Q; Wed, 12 Feb 2020 11:15:48 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j1p3a-0001Mz-LW; Wed, 12 Feb 2020 11:15:46 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j1p3a-0002If-Ip; Wed, 12 Feb 2020 11:15:46 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        James Hartley <james.hartley@sondrel.com>,
        John Crispin <john@phrozen.org>
Cc:     linux-mips@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/7] MIPS: Replace <linux/clk-provider.h> by <linux/of_clk.h>
Date:   Wed, 12 Feb 2020 11:15:37 +0100
Message-Id: <20200212101544.8793-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

The OF clock helpers were moved to <linux/of_clk.h> a while ago.
Hence code that is not a clock provider, but just needs to call
of_clk_init(), can (and should) include <linux/of_clk.h> instead of
<linux/clk-provider.h>.

All these patches are independent of each others, and thus can be
applied by the corresponding subsystem maintainers.

Thanks!

Geert Uytterhoeven (7):
  MIPS: ath79: Replace <linux/clk-provider.h> by <linux/of_clk.h>
  MIPS: BMIPS: Replace <linux/clk-provider.h> by <linux/of_clk.h>
  MIPS: generic: Replace <linux/clk-provider.h> by <linux/of_clk.h>
  MIPS: jz4740: Replace <linux/clk-provider.h> by <linux/of_clk.h>
  MIPS: pic32mzda: Replace <linux/clk-provider.h> by <linux/of_clk.h>
  MIPS: Pistachio: Replace <linux/clk-provider.h> by <linux/of_clk.h>
  MIPS: ralink: Replace <linux/clk-provider.h> by <linux/of_clk.h>

 arch/mips/ath79/setup.c          | 2 +-
 arch/mips/bmips/setup.c          | 2 +-
 arch/mips/generic/init.c         | 2 +-
 arch/mips/jz4740/time.c          | 2 +-
 arch/mips/pic32/pic32mzda/time.c | 2 +-
 arch/mips/pistachio/time.c       | 2 +-
 arch/mips/ralink/timer-gic.c     | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
