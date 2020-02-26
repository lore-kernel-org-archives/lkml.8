Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3B9C4BA13
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E4B1222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgBZPzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 10:55:07 -0500
Received: from ns.iliad.fr ([212.27.33.1]:48486 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728470AbgBZPzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 10:55:06 -0500
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id D19A620076;
        Wed, 26 Feb 2020 16:55:04 +0100 (CET)
Received: from [192.168.108.51] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id BF00C20025;
        Wed, 26 Feb 2020 16:55:04 +0100 (CET)
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: [RFC PATCH v4 0/2] Small devm helper for devm implementations
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Russell King <linux@armlinux.org.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Message-ID: <68219a85-295d-7b7c-9658-c3045bbcbaeb@free.fr>
Date:   Wed, 26 Feb 2020 16:44:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Wed Feb 26 16:55:04 2020 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Differences from v3 to v4
x Add a bunch of kerneldoc above devm_add() [Greg KH]
x Split patch in two [Greg KH]

Differences from v2 to v3
x Make devm_add() return an error-code rather than the raw data pointer
  (in case devres_alloc ever returns an ERR_PTR) as suggested by Geert
x Provide a variadic version devm_vadd() to work with structs as suggested
  by Geert
x Don't use nested ifs in clk_devm* implementations (hopefully simpler
  code logic to follow) as suggested by Geert

Marc Gonzalez (2):
  devres: Provide new helper for devm functions
  clk: Use devm_add in managed functions

 drivers/base/devres.c    |  28 +++++++++++
 drivers/clk/clk-devres.c | 101 ++++++++++++++-------------------------
 include/linux/device.h   |   3 ++
 3 files changed, 68 insertions(+), 64 deletions(-)

-- 
2.17.1
