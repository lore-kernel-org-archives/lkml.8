Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB6AC11D07
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9277620656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgBTOF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 09:05:57 -0500
Received: from ns.iliad.fr ([212.27.33.1]:53816 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727943AbgBTOF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 09:05:57 -0500
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id E162B20050;
        Thu, 20 Feb 2020 15:05:54 +0100 (CET)
Received: from [192.168.108.51] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id AEA9E1FF6A;
        Thu, 20 Feb 2020 15:05:54 +0100 (CET)
Subject: Re: [RESEND RFC PATCH v3] clk: Use new helper in managed functions
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
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
        Rafael Wysocki <rjw@rjwysocki.net>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <f48d1df3-fc1f-ac5c-b11e-330f18aad539@free.fr>
 <20200220112700.GJ3374196@kroah.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <8866e533-967f-e208-1ec8-888d72f3052e@free.fr>
Date:   Thu, 20 Feb 2020 15:05:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200220112700.GJ3374196@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Thu Feb 20 15:05:54 2020 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/02/2020 12:27, Greg Kroah-Hartman wrote:

> On Thu, Feb 20, 2020 at 11:04:58AM +0100, Marc Gonzalez wrote:
>
>> Introduce devm_add() to wrap devres_alloc() / devres_add() calls.
>>
>> Using that helper produces simpler code, and smaller object size.
>> E.g. with gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu:
>>
>>     text	   data	    bss	    dec	    hex	filename
>> -   1708	     80	      0	   1788	    6fc	drivers/clk/clk-devres.o
>> +   1524	     80	      0	   1604	    644	drivers/clk/clk-devres.o
>>
>> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
>> ---
>> Differences from v2 to v3
>> x Make devm_add() return an error-code rather than the raw data pointer
>>   (in case devres_alloc ever returns an ERR_PTR) as suggested by Geert
>> x Provide a variadic version devm_vadd() to work with structs as suggested
>>   by Geert
>> x Don't use nested ifs in clk_devm* implementations (hopefully simpler
>>   code logic to follow) as suggested by Geert
>>
>> Questions:
>> x This patch might need to be split in two? (Introduce the new API, then use it)
>> x Convert other subsystems to show the value of this proposal?
>> x Maybe comment the API usage somewhere
>> ---
>>  drivers/base/devres.c    | 15 ++++++
>>  drivers/clk/clk-devres.c | 99 ++++++++++++++--------------------------
>>  include/linux/device.h   |  3 ++
>>  3 files changed, 53 insertions(+), 64 deletions(-)
>>
>> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
>> index 0bbb328bd17f..b2603789755b 100644
>> --- a/drivers/base/devres.c
>> +++ b/drivers/base/devres.c
>> @@ -685,6 +685,21 @@ int devres_release_group(struct device *dev, void *id)
>>  }
>>  EXPORT_SYMBOL_GPL(devres_release_group);
>>  
>> +int devm_add(struct device *dev, dr_release_t func, void *arg, size_t size)
> 
> Please add a bunch of kerneldoc here, as I have no idea what this
> function does just by looking at the name of it :(

Fair enough. (This was one of my "Questions" in the patch comments.)

Note: My patch adds a new function, then makes use of said function.
Is this typically done in two patches or one?

Patch 1/2 augmenting the API.
Patch 2/2 making use of the new function.

Regards.
