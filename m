Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50434C47257
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E891206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbgEEPqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729636AbgEEPqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:46:01 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457D2C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 08:46:01 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:bd97:8453:3b10:1832])
        by andre.telenet-ops.be with bizsmtp
        id b3le2200W3VwRR3013leCg; Tue, 05 May 2020 17:45:39 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jVzlK-0003Gp-QD; Tue, 05 May 2020 17:45:38 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jVzlK-00014u-Nq; Tue, 05 May 2020 17:45:38 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 0/3] ARM: Replace <linux/clk-provider.h> by <linux/of_clk.h>
Date:   Tue,  5 May 2020 17:45:33 +0200
Message-Id: <20200505154536.4099-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi arm-soc folks,

The OF clock helpers were moved to <linux/of_clk.h> a while ago.
Hence code that is not a clock provider, but just needs to call
of_clk_init(), can (and should) include <linux/of_clk.h> instead of
<linux/clk-provider.h>.

This series contains the patches from [1] that haven't been applied yet.

Changes compared to v1:
  - Add Reviewed-by.

Thanks for applying!

[2] "[PATCH 0/7] ARM: Replace <linux/clk-provider.h> by <linux/of_clk.h>"
    https://lore.kernel.org/r/20200212100830.446-1-geert+renesas@glider.be

Geert Uytterhoeven (3):
  ARM/time: Replace <linux/clk-provider.h> by <linux/of_clk.h>
  ARM: mediatek: Replace <linux/clk-provider.h> by <linux/of_clk.h>
  ARM: mmp: Replace <linux/clk-provider.h> by <linux/of_clk.h>

 arch/arm/kernel/time.c            | 2 +-
 arch/arm/mach-mediatek/mediatek.c | 2 +-
 arch/arm/mach-mmp/mmp-dt.c        | 2 +-
 arch/arm/mach-mmp/mmp2-dt.c       | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
