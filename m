Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B870C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 12:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06F85217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 12:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgAWMSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 07:18:02 -0500
Received: from ns.iliad.fr ([212.27.33.1]:50400 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbgAWMSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 07:18:01 -0500
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 901F22084B;
        Thu, 23 Jan 2020 13:17:59 +0100 (CET)
Received: from [192.168.108.51] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 72A25201A4;
        Thu, 23 Jan 2020 13:17:59 +0100 (CET)
Subject: Re: [RFC PATCH v2] clk: Use a new helper in managed functions
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Guenter Roeck <linux@roeck-us.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <56c7b6d5-1248-15bd-8441-5d80557455b3@free.fr>
 <CAMuHMdX3kZoEfCeGamreeWq0-Tu2+Mw8MYEbRUZV8wBS+e2K=A@mail.gmail.com>
 <8f1f01a1-b0c7-77d5-7d01-dd53811fa217@free.fr>
 <CAMuHMdW=0Qf=bdE8Vy75wySRV5wzWhgM=-vhXjc0RhLGwomF_g@mail.gmail.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <91058d8f-7075-6baa-6131-cce1ccd160a6@free.fr>
Date:   Thu, 23 Jan 2020 13:17:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdW=0Qf=bdE8Vy75wySRV5wzWhgM=-vhXjc0RhLGwomF_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Thu Jan 23 13:17:59 2020 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2020 11:32, Geert Uytterhoeven wrote:

> On Thu, Jan 23, 2020 at 11:13 AM Marc Gonzalez wrote:
> 
>> A limitation of devm_add_action is that it stores the void *data argument "as is".
>> Users cannot pass the address of a struct on the stack. devm_add() addresses that
>> specific use-case, while being a minimal wrapper around devres_alloc + devres_add.
>> (devm_add_action adds an extra level of indirection.)
> 
> I didn't mean the advantage of devm_add() over devm_add_action(),
> but the advantage of dr_release_t, which has a device pointer.

I'm confused...

	void *devres_alloc(dr_release_t release, size_t size, gfp_t gfp);
	int devm_add_action(struct device *dev, void (*action)(void *), void *data);

devres_alloc() expects a dr_release_t argument; devm_add() is a thin wrapper
around devres_alloc(); ergo devm_add() expects that dr_release_t argument.

devm_add_action() is a "heavier" wrapper around devres_alloc() which defines
a "private" release function which calls a user-defined "action".
(i.e. the extra level of indirection I mentioned above.)

I don't understand the question about the advantage of dr_release_t.


>>>> +       void *data = devres_alloc(func, size, GFP_KERNEL);
>>>> +
>>>> +       if (data) {
>>>> +               memcpy(data, arg, size);
>>>> +               devres_add(dev, data);
>>>> +       } else
>>>> +               func(dev, arg);
>>>> +
>>>> +       return data;
>>>
>>> Why return data or NULL, instead of 0 or -Efoo, like devm_add_action()?
>>
>> My intent is to make devm_add a minimal wrapper (it even started out as
>> a macro). As such, I just transparently pass the result of devres_alloc.
>>
>> Do you see an advantage in processing the result?
> 
> There are actually two questions to consider here:
>   1. Is there a use case for returning the data pointer?
>      I.e. will the caller ever use it?
>   2. Can there be another failure mode than out-of-memory?
>      Changing from NULL to ERR_PTR() later means that all callers
>      need to be updated.

I think I see your point. You're saying it's not good to kick the can down
the road, because callers won't know what to do with the pointer.

Actually, I'm in the same boat as these users. I looked at
devres_alloc -> devres_alloc_node -> alloc_dr -> kmalloc_node_track_caller -> __do_kmalloc

Basically, the result is NULL when something went wrong, but the actual
error condition is not propagated. It could be:
1) check_add_overflow() finds an overflow
2) size > KMALLOC_MAX_CACHE_SIZE
3) kmalloc_slab() or kasan_kmalloc() fail
4) different errors on the CONFIG_NUMA path

Basically, if lower-level functions don't propagate errors, it's not
easy for a wrapper to do something sensible... ENOMEM looks reasonable
for kmalloc-related failures.

Regards.
