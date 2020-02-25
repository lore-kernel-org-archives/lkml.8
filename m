Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FB6C35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 12:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F9920CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 12:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbgBYM0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 07:26:02 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39026 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbgBYM0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 07:26:01 -0500
Received: from [IPv6:2a00:5f00:102:0:6dae:eb08:2e0f:5281] (unknown [IPv6:2a00:5f00:102:0:6dae:eb08:2e0f:5281])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: gtucker)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 535F7294D77;
        Tue, 25 Feb 2020 12:25:59 +0000 (GMT)
Subject: Re: next/master bisection: baseline.login on
 sun8i-h2-plus-orangepi-zero
To:     Stephen Boyd <sboyd@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     broonie@kernel.org, tomeu.vizoso@collabora.com,
        Michael Turquette <mturquette@baylibre.com>,
        enric.balletbo@collabora.com, khilman@baylibre.com,
        mgalka@collabora.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <5e4b4889.1c69fb81.bc072.65a9@mx.google.com>
 <50f9ce8b-c303-3b25-313b-cfb62d7e8735@collabora.com>
 <158215618721.184098.2077489323832918966@swboyd.mtv.corp.google.com>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <9bfacff8-33f2-8145-4210-dd382e6e4f27@collabora.com>
Date:   Tue, 25 Feb 2020 12:25:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <158215618721.184098.2077489323832918966@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/02/2020 23:49, Stephen Boyd wrote:
> Adding some Allwinner folks. Presumably there is some sort of clk that
> is failing to calculate a phase when it gets registered. Maybe that's
> because the parent isn't registered yet?

FYI this is still happening on several Allwinner boards:

On 25/02/2020 11:57, kernelci.org bot wrote:
> next/master bisection: baseline.login on sun7i-a20-cubieboard2
> 
> Summary:
>   Start:      c99b17ac03994 Add linux-next specific files for 20200225
>   Plain log:  https://storage.kernelci.org//next/master/next-20200225/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-sun7i-a20-cubieboard2.txt
>   HTML log:   https://storage.kernelci.org//next/master/next-20200225/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-sun7i-a20-cubieboard2.html
>   Result:     2760878662a29 clk: Bail out when calculating phase fails during clk registration
> 
> Checks:
>   revert:     PASS
>   verify:     PASS
> 
> Parameters:
>   Tree:       next
>   URL:        git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>   Branch:     master
>   Target:     sun7i-a20-cubieboard2
>   CPU arch:   arm
>   Lab:        lab-baylibre
>   Compiler:   gcc-8
>   Config:     multi_v7_defconfig
>   Test case:  baseline.login

Guillaume

> Quoting Guillaume Tucker (2020-02-17 23:45:41)
>> Hi Stephen,
>>
>> Please see the bisection report below about a boot failure.
>>
>> Reports aren't automatically sent to the public while we're
>> trialing new bisection features on kernelci.org but this one
>> looks valid.
>>
>> There's nothing in the serial console log, probably because it's
>> crashing too early during boot.  I'm not sure if other platforms
>> on kernelci.org were hit by this in the same way, it's tricky to
>> tell partly because there is no output.  It should possible to
>> run it again with earlyprintk enabled in BayLibre's test lab
>> though.
>>
>> Thanks,
>> Guillaume
>>
>>
>> On 18/02/2020 02:14, kernelci.org bot wrote:
>>> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>>> * This automated bisection report was sent to you on the basis  *
>>> * that you may be involved with the breaking commit it has      *
>>> * found.  No manual investigation has been done to verify it,   *
>>> * and the root cause of the problem may be somewhere else.      *
>>> *                                                               *
>>> * If you do send a fix, please include this trailer:            *
>>> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
>>> *                                                               *
>>> * Hope this helps!                                              *
>>> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>>>
>>> next/master bisection: baseline.login on sun8i-h2-plus-orangepi-zero
>>>
>>> Summary:
>>>   Start:      c25a951c50dc Add linux-next specific files for 20200217
>>>   Plain log:  https://storage.kernelci.org//next/master/next-20200217/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-sun8i-h2-plus-orangepi-zero.txt
>>>   HTML log:   https://storage.kernelci.org//next/master/next-20200217/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-sun8i-h2-plus-orangepi-zero.html
>>>   Result:     2760878662a2 clk: Bail out when calculating phase fails during clk registration
>>>
>>> Checks:
>>>   revert:     PASS
>>>   verify:     PASS
>>>
>>> Parameters:
>>>   Tree:       next
>>>   URL:        git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>>>   Branch:     master
>>>   Target:     sun8i-h2-plus-orangepi-zero
>>>   CPU arch:   arm
>>>   Lab:        lab-baylibre
>>>   Compiler:   gcc-8
>>>   Config:     multi_v7_defconfig
>>>   Test case:  baseline.login
>>>
>>> Breaking commit found:
>>>
>>> -------------------------------------------------------------------------------
>>> commit 2760878662a290ac57cff8a5a8d8bda8f4dddc37
>>> Author: Stephen Boyd <sboyd@kernel.org>
>>> Date:   Wed Feb 5 15:28:02 2020 -0800
>>>
>>>     clk: Bail out when calculating phase fails during clk registration
>>>     
>>>     Bail out of clk registration if we fail to get the phase for a clk that
>>>     has a clk_ops::get_phase() callback. Print a warning too so that driver
>>>     authors can easily figure out that some clk is unable to read back phase
>>>     information at boot.
>>>     
>>>     Cc: Douglas Anderson <dianders@chromium.org>
>>>     Cc: Heiko Stuebner <heiko@sntech.de>
>>>     Suggested-by: Jerome Brunet <jbrunet@baylibre.com>
>>>     Signed-off-by: Stephen Boyd <sboyd@kernel.org>
>>>     Link: https://lkml.kernel.org/r/20200205232802.29184-5-sboyd@kernel.org
>>>     Acked-by: Jerome Brunet <jbrunet@baylibre.com>
>>>
>>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>>> index dc8bdfbd6a0c..ed1797857bae 100644
>>> --- a/drivers/clk/clk.c
>>> +++ b/drivers/clk/clk.c
>>> @@ -3457,7 +3457,12 @@ static int __clk_core_init(struct clk_core *core)
>>>        * Since a phase is by definition relative to its parent, just
>>>        * query the current clock phase, or just assume it's in phase.
>>>        */
>>> -     clk_core_get_phase(core);
>>> +     ret = clk_core_get_phase(core);
>>> +     if (ret < 0) {
>>> +             pr_warn("%s: Failed to get phase for clk '%s'\n", __func__,
>>> +                     core->name);
>>> +             goto out;
>>> +     }
>>>  
>>>       /*
>>>        * Set clk's duty cycle.
>>> -------------------------------------------------------------------------------
>>>
>>>
>>> Git bisection log:
>>>
>>> -------------------------------------------------------------------------------
>>> git bisect start
>>> # good: [11a48a5a18c63fd7621bb050228cebf13566e4d8] Linux 5.6-rc2
>>> git bisect good 11a48a5a18c63fd7621bb050228cebf13566e4d8
>>> # bad: [c25a951c50dca1da4a449a985a9debd82dc18573] Add linux-next specific files for 20200217
>>> git bisect bad c25a951c50dca1da4a449a985a9debd82dc18573
>>> # bad: [5859c179b7ed01050641bd565959a2c4571923da] Merge remote-tracking branch 'swiotlb/linux-next'
>>> git bisect bad 5859c179b7ed01050641bd565959a2c4571923da
>>> # bad: [ecf5a6e1ec22ecbe1c9086f40130188f31e37a38] Merge remote-tracking branch 'xtensa/xtensa-for-next'
>>> git bisect bad ecf5a6e1ec22ecbe1c9086f40130188f31e37a38
>>> # good: [e475ff54b7d62c550768ce36617e8c8fec72cfc0] Merge remote-tracking branch 'reset/reset/next'
>>> git bisect good e475ff54b7d62c550768ce36617e8c8fec72cfc0
>>> # bad: [9e86f8cc2d2f464e27c172127e02641fe77eccea] Merge remote-tracking branch 'sh/sh-next'
>>> git bisect bad 9e86f8cc2d2f464e27c172127e02641fe77eccea
>>> # good: [1752d66d86600e9cb508612ded6984774b72321d] Merge remote-tracking branch 'tegra/for-next'
>>> git bisect good 1752d66d86600e9cb508612ded6984774b72321d
>>> # bad: [0ecb83df935b058a2c3727716a7fab539dbaba88] Merge remote-tracking branch 'csky/linux-next'
>>> git bisect bad 0ecb83df935b058a2c3727716a7fab539dbaba88
>>> # bad: [898fe3af935a45236cbfd053e79ae01506ae7aa2] Merge branch 'clk-formatting' into clk-next
>>> git bisect bad 898fe3af935a45236cbfd053e79ae01506ae7aa2
>>> # bad: [0d426990beac93127a4ee37cc056fce928466f7d] Merge branch 'clk-phase-errors' into clk-next
>>> git bisect bad 0d426990beac93127a4ee37cc056fce928466f7d
>>> # good: [6e37add6b938941f755928159ede3c9855307066] Merge branch 'clk-qcom' into clk-next
>>> git bisect good 6e37add6b938941f755928159ede3c9855307066
>>> # good: [5d98429bbebc5dc683ea6919d9b9e6e83e8c8867] Merge branch 'clk-fixes' into clk-next
>>> git bisect good 5d98429bbebc5dc683ea6919d9b9e6e83e8c8867
>>> # good: [768a5d4f63c29d3bed5abb3c187312fcf623fa05] clk: Use 'parent' to shorten lines in __clk_core_init()
>>> git bisect good 768a5d4f63c29d3bed5abb3c187312fcf623fa05
>>> # bad: [2760878662a290ac57cff8a5a8d8bda8f4dddc37] clk: Bail out when calculating phase fails during clk registration
>>> git bisect bad 2760878662a290ac57cff8a5a8d8bda8f4dddc37
>>> # good: [0daa376d832f4ce585f153efee4233b52fa3fe58] clk: Move rate and accuracy recalc to mostly consumer APIs
>>> git bisect good 0daa376d832f4ce585f153efee4233b52fa3fe58
>>> # first bad commit: [2760878662a290ac57cff8a5a8d8bda8f4dddc37] clk: Bail out when calculating phase fails during clk registration
>>> -------------------------------------------------------------------------------
>>>
>>

