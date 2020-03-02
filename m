Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A38C3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9777220842
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbgCBKBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 05:01:49 -0500
Received: from ns.iliad.fr ([212.27.33.1]:38100 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727060AbgCBKBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 05:01:48 -0500
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 25B9D20025;
        Mon,  2 Mar 2020 11:01:46 +0100 (CET)
Received: from [192.168.108.51] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 3E52720020;
        Mon,  2 Mar 2020 11:01:45 +0100 (CET)
Subject: Re: [RFC PATCH v4 2/2] clk: Use devm_add in managed functions
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Russell King <linux@armlinux.org.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <68219a85-295d-7b7c-9658-c3045bbcbaeb@free.fr>
 <e88ca46a-799d-9c86-f2d2-6284eb3c3419@free.fr>
 <CAMuHMdUZfR6pYG-hourZCKT-jhh1t+x-ySF4JnEPJjscGAQT+A@mail.gmail.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <7622db71-b1f4-62b4-86ee-78e00d5bd52c@free.fr>
Date:   Mon, 2 Mar 2020 11:01:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUZfR6pYG-hourZCKT-jhh1t+x-ySF4JnEPJjscGAQT+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Mon Mar  2 11:01:46 2020 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/2020 14:36, Geert Uytterhoeven wrote:

> Hi Marc,
> 
> Thanks for your patch!
> 
> On Wed, Feb 26, 2020 at 4:55 PM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
>> Using the helper produces simpler code, and smaller object size.
>> E.g. with gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu:
>>
>>     text           data     bss     dec     hex filename
>> -   1708             80       0    1788     6fc drivers/clk/clk-devres.o
>> +   1524             80       0    1604     644 drivers/clk/clk-devres.o
> 
> And the size reduction could have been even more ;-)

I'll see what I can do! ;-)

I have another patch with even smaller object code, but it requires
C11 to be well-defined (memcmp the whole struct, which requires zeros
in the padding holes).


>> --- a/drivers/clk/clk-devres.c
>> +++ b/drivers/clk/clk-devres.c
> 
>> @@ -55,25 +51,17 @@ static void devm_clk_bulk_release(struct device *dev, void *res)
>>  static int __devm_clk_bulk_get(struct device *dev, int num_clks,
>>                                struct clk_bulk_data *clks, bool optional)
>>  {
>> -       struct clk_bulk_devres *devres;
>>         int ret;
>>
>> -       devres = devres_alloc(devm_clk_bulk_release,
>> -                             sizeof(*devres), GFP_KERNEL);
>> -       if (!devres)
>> -               return -ENOMEM;
>> -
>>         if (optional)
>>                 ret = clk_bulk_get_optional(dev, num_clks, clks);
>>         else
>>                 ret = clk_bulk_get(dev, num_clks, clks);
>> -       if (!ret) {
>> -               devres->clks = clks;
>> -               devres->num_clks = num_clks;
>> -               devres_add(dev, devres);
>> -       } else {
>> -               devres_free(devres);
>> -       }
>> +
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = devm_vadd(dev, my_clk_bulk_put, clk_bulk_args, num_clks, clks);
>>
>>         return ret;
> 
> return devm_vadd(...);

If you think that makes it look better, I'll make the change!


>> @@ -128,30 +109,22 @@ static int devm_clk_match(struct device *dev, void *res, void *data)
>>
>>  void devm_clk_put(struct device *dev, struct clk *clk)
>>  {
>> -       int ret;
>> -
>> -       ret = devres_release(dev, devm_clk_release, devm_clk_match, clk);
>> -
>> -       WARN_ON(ret);
>> +       WARN_ON(devres_release(dev, my_clk_put, devm_clk_match, clk));
> 
> Getting rid of "ret" is an unrelated change, which actually increases
> kernel size, as the WARN_ON() parameter is stringified for the warning
> message.

Weird... Are you sure about that? I built the preprocessed file,
and it didn't appear to be so.

#ifndef WARN_ON
#define WARN_ON(condition) ({						\
	int __ret_warn_on = !!(condition);				\
	if (unlikely(__ret_warn_on))					\
		__WARN();						\
	unlikely(__ret_warn_on);					\
})
#endif

Maybe you were thinking of i915's WARN_ON?

#define WARN_ON(x) WARN((x), "%s", "WARN_ON(" __stringify(x) ")")

Regards.
