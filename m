Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC7FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B76CF20723
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732908AbgFWO54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 10:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732859AbgFWO5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 10:57:55 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34276C061798
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 07:57:54 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed20:26:93a1:ff06:f8b0])
        by laurent.telenet-ops.be with bizsmtp
        id uexs2200P4qCYS801exsSt; Tue, 23 Jun 2020 16:57:52 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jnkMy-0007V6-Kn; Tue, 23 Jun 2020 16:57:52 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jnkMy-0007WW-Io; Tue, 23 Jun 2020 16:57:52 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/2] gpio: aggregator: Misc parsing improvements
Date:   Tue, 23 Jun 2020 16:57:46 +0200
Message-Id: <20200623145748.28877-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus, Bartosz, Andy,

This patch series contains two improvements for the parsing code in the
GPIO Aggregator.

The second one converts the driver to use bitmap_parselist() for parsing
GPIO offsets and/or ranges, as suggested by Andy[1].
Note that I'm not super happy with the mask[] array on the stack.  But
there is no real limit on the number of GPIO lines provided by a single
gpiochip, except for the global ARCH_NR_GPIOS.

I also considered getting rid of the custom isrange() function.
However, the check for "!isrange(offsets)" cannot be replaced by a check
for bitmap_parselist() returning -EINVAL, as bitmap_parselist() happily
accepts an empty list.  Hence I'm afraid isrange() has to stay.

Andy also suggested to use strstrip() in get_arg().  However, I see no
point in that, as get_arg() has to find the end of the actual parameter
anyway.

Thanks for your comments!

[1] https://lore.kernel.org/r/20200520121420.GA1867563@smile.fi.intel.com

Geert Uytterhoeven (2):
  gpio: aggregator: Drop pre-initialization in get_arg()
  gpio: aggregator: Use bitmap_parselist() for parsing GPIO offsets

 drivers/gpio/gpio-aggregator.c | 46 ++++++++++++----------------------
 1 file changed, 16 insertions(+), 30 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
