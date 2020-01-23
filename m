Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB89C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 10:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8082467B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 10:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgAWKNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 05:13:37 -0500
Received: from ns.iliad.fr ([212.27.33.1]:46430 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbgAWKNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 05:13:36 -0500
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 903D120108;
        Thu, 23 Jan 2020 11:13:33 +0100 (CET)
Received: from [192.168.108.51] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 7A4FF200B9;
        Thu, 23 Jan 2020 11:13:33 +0100 (CET)
Subject: Re: [RFC PATCH v2] clk: Use a new helper in managed functions
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Russell King <linux@armlinux.org.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <56c7b6d5-1248-15bd-8441-5d80557455b3@free.fr>
 <CAMuHMdX3kZoEfCeGamreeWq0-Tu2+Mw8MYEbRUZV8wBS+e2K=A@mail.gmail.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <8f1f01a1-b0c7-77d5-7d01-dd53811fa217@free.fr>
Date:   Thu, 23 Jan 2020 11:13:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdX3kZoEfCeGamreeWq0-Tu2+Mw8MYEbRUZV8wBS+e2K=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Thu Jan 23 11:13:33 2020 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/01/2020 14:33, Geert Uytterhoeven wrote:

> On Wed, Jan 22, 2020 at 2:02 PM Marc Gonzalez wrote:
>
>> Introduce devm_add() to factorize devres_alloc/devres_add calls.
>>
>> Using that helper produces simpler code and smaller object size:
>>
>> 1 file changed, 27 insertions(+), 66 deletions(-)
>>
>>     text           data     bss     dec     hex filename
>> -   1708             80       0    1788     6fc drivers/clk/clk-devres.o
>> +   1508             80       0    1588     634 drivers/clk/clk-devres.o
>>
>> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> 
> Thanks for your patch!
> 
>> --- a/drivers/base/devres.c
>> +++ b/drivers/base/devres.c
>> @@ -685,6 +685,20 @@ int devres_release_group(struct device *dev, void *id)
>>  }
>>  EXPORT_SYMBOL_GPL(devres_release_group);
>>
>> +void *devm_add(struct device *dev, dr_release_t func, void *arg, size_t size)
> 
> Is there any advantage of using dr_release_t over "void (*action)(void *)",
> like devm_add_action() does?  The latter lacks the "device *" parameter.

(I did forget to mention that v1 used devm_add_action.)
https://patchwork.kernel.org/patch/11262685/

A limitation of devm_add_action is that it stores the void *data argument "as is".
Users cannot pass the address of a struct on the stack. devm_add() addresses that
specific use-case, while being a minimal wrapper around devres_alloc + devres_add.
(devm_add_action adds an extra level of indirection.)

>> +{
>> +       void *data = devres_alloc(func, size, GFP_KERNEL);
>> +
>> +       if (data) {
>> +               memcpy(data, arg, size);
>> +               devres_add(dev, data);
>> +       } else
>> +               func(dev, arg);
> 
> Both branchs should use { ...}

Ah yes, scripts/checkpatch.pl needs --strict to point this out.

>> +
>> +       return data;
> 
> Why return data or NULL, instead of 0 or -Efoo, like devm_add_action()?

My intent is to make devm_add a minimal wrapper (it even started out as
a macro). As such, I just transparently pass the result of devres_alloc.

Do you see an advantage in processing the result?

>> @@ -33,10 +25,7 @@ struct clk *devm_clk_get_optional(struct device *dev, const char *id)
>>  {
>>         struct clk *clk = devm_clk_get(dev, id);
>>
>> -       if (clk == ERR_PTR(-ENOENT))
>> -               return NULL;
>> -
>> -       return clk;
>> +       return clk == ERR_PTR(-ENOENT) ? NULL : clk;
> 
> Unrelated change (which is less readable than the original, IMHO).

I'd like to hear the maintainers' opinion. I defer to their preference.

>> +
>> +       if (!ret)
>> +               if (!devm_add(dev, wrap_clk_bulk_put, &arg, sizeof(arg)))
>> +                       ret = -ENOMEM;
> 
> Nested ifs are easier to read when the outer one uses curly braces:
> 
>         if (!ret) {
>                 if (!devm_add(dev, wrap_clk_bulk_put, &arg, sizeof(arg)))
>                         ret = -ENOMEM;
>         }
> 
> Or merge the condition with &&.
> 
>>
>>         return ret;
> 
> But in this case, I would write it as:
> 
>         if (ret)
>                 return ret;
> 
>         if (!devm_add(dev, wrap_clk_bulk_put, &arg, sizeof(arg)))
>                 return -ENOMEM;
> 
>         return 0;

I like the simplicity of this code.


> (+ consider devm_add() returning the error code instead, cfr. above).

Some functions return an int, some a pointer, some might store the
result through a pointer.


> BTW, I'm still wondering if the varargs macro discussed on #armlinux would
> help.  I.e.
> 
>     devm_add(dev, wrap_clk_bulk_put, struct clk_bulk_devres, clks, num_clks)
> 
> would create and populate the temporary arg variable.
> 
> That would require defining an argument struct for the use in devm_clk_get(),
> though.

There could be a helper for the "pass-a-struct" use-case, using a compound literal:

#define helper(dev, func, type, args...) devm_add(dev, func, &(type){args}, sizeof(type))

Regards.
