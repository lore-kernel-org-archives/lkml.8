Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C82C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63CA020738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbgFDQOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 12:14:41 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:30694 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728972AbgFDQOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 12:14:41 -0400
Received: from [192.168.1.91] (unknown [77.207.133.132])
        (Authenticated sender: marc.w.gonzalez)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id D6B3219F5E1;
        Thu,  4 Jun 2020 18:13:26 +0200 (CEST)
Subject: Re: [PATCH v5 0/2] Small devm helper for devm implementations
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
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
References: <e8221bff-3e2a-7607-c5c8-abcf9cebb1b5@free.fr>
Message-ID: <217b892d-678f-8c32-b9ab-a3dd238c197a@free.fr>
Date:   Thu, 4 Jun 2020 18:13:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <e8221bff-3e2a-7607-c5c8-abcf9cebb1b5@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like this series has fallen through the cracks :(
Greg, you would be taking the drivers/base/devres.c changes?
As mentioned in patch 2, "This patch needs testing on a platform with many clocks."
(I've only tested using a trivial kernel module)

On 10/03/2020 11:11, Marc Gonzalez wrote:

> Differences from v4 to v5
> x Fix the grammar in devm_add comments [Geert]
> x Undo an unrelated change in devm_clk_put [Geert]
> 
> Differences from v3 to v4
> x Add a bunch of kerneldoc above devm_add() [Greg KH]
> x Split patch in two [Greg KH]
> 
> Differences from v2 to v3
> x Make devm_add() return an error-code rather than the raw data pointer
>   (in case devres_alloc ever returns an ERR_PTR) as suggested by Geert
> x Provide a variadic version devm_vadd() to work with structs as suggested
>   by Geert
> x Don't use nested ifs in clk_devm* implementations (hopefully simpler
>   code logic to follow) as suggested by Geert
> 
> Marc Gonzalez (2):
>   devres: Provide new helper for devm functions
>   clk: Use devm_add in managed functions
> 
>  drivers/base/devres.c    | 28 ++++++++++++
>  drivers/clk/clk-devres.c | 97 +++++++++++++++-------------------------
>  include/linux/device.h   |  3 ++
>  3 files changed, 67 insertions(+), 61 deletions(-)
