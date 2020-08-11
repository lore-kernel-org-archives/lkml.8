Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE6BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A1972076B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="goKn7SB7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbgHKQpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 12:45:22 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:43888 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbgHKQpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:45:22 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200811164519euoutp019ff0b82ad33562cefd5c9f1c03127f38~qRHxw6pls1597615976euoutp01d
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 16:45:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200811164519euoutp019ff0b82ad33562cefd5c9f1c03127f38~qRHxw6pls1597615976euoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597164319;
        bh=JKDK83B6xWL5+zSWfe2UkHzkQ9e9L1lsqMvwJjcoyFU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=goKn7SB7TF6X0lL+a36N8G/wNwUOUgQ8SyEGFoRRYbKYoCP35iZ0ala5ly7D+5faC
         6C0tQPzUqu/wA6D7Nj2ynBZQE3Yr1aFyosecxPjUCdBS/+fCSCMxPCweU59PsAsAeQ
         Pr7RN3IUlQjZnmsyvIZro3YKE49Az/1M6WXNO2aw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200811164518eucas1p1edab260148c580dc47242d68d10a47d3~qRHxIcjkR2510225102eucas1p10;
        Tue, 11 Aug 2020 16:45:18 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C5.A4.06456.E1BC23F5; Tue, 11
        Aug 2020 17:45:18 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200811164517eucas1p186b6839ef0b5fed018d9f860cc15805b~qRHwYYUza2513125131eucas1p1P;
        Tue, 11 Aug 2020 16:45:17 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200811164517eusmtrp1f9695b3beee7d6c4c0b68b30c9662611~qRHwXs7WW0119301193eusmtrp1K;
        Tue, 11 Aug 2020 16:45:17 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-27-5f32cb1ec7b2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 98.4A.06017.D1BC23F5; Tue, 11
        Aug 2020 17:45:17 +0100 (BST)
Received: from [106.210.123.115] (unknown [106.210.123.115]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200811164516eusmtip17a0d4424fb3caab52d76af7571a5cb5e~qRHvkPtGj1927919279eusmtip1m;
        Tue, 11 Aug 2020 16:45:16 +0000 (GMT)
Subject: Re: [PATCH v2] clk: samsung: Prevent potential endless loop in the
 PLL set_rate ops
To:     Tomasz Figa <tomasz.figa@gmail.com>
Cc:     "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        "moderated list:SAMSUNG SOC CLOCK DRIVERS" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <66c7330e-507e-d81f-1cb1-b509bf54d050@samsung.com>
Date:   Tue, 11 Aug 2020 18:45:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CA+Ln22Hfys7r2EDstOsdks1X88Fuv77DLTuXLWDynTt4kmiCiQ@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsWy7djPc7pyp43iDXb9FrHYOGM9q8X1L89Z
        LT723GO1uLxrDpvFjPP7mCzWHrnLbnHxlKvFv2sbWSxW7frD6MDp8f5GK7vHzll32T02repk
        8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6ME9euMhcs06y41v2QtYFxoVIXIyeHhICJxPRl
        a1m6GLk4hARWMEpsnnUdyvnCKPHwxFNGCOczo8SruXcYYVrW7p/BBJFYzihx6esFqKqPjBKN
        F28wg1QJC8RJbNlxkwnEFhFQl/g2pZ8dpIhZYDazxLMdJ9hBEmwChhK9R/vAxvIK2ElsvXqF
        DcRmEVCVeHh2GiuILQo0aOvxq0wQNYISJ2c+YQGxOQUCJVYtmABWzywgLnHryXwmCFteonnr
        bGaQZRICx9glVkw6wgZxt4vEhkcbWCBsYYlXx7ewQ9gyEqcn97BANDQzSvTsvs0O4UxglLh/
        fAHU19YSd879AprEAbRCU2L9Ln2IsKPExtfXmUHCEgJ8EjfeCkIcwScxadt0qDCvREebEES1
        isTvVdOZIGwpie4n/1kmMCrNQvLaLCTvzELyziyEvQsYWVYxiqeWFuempxYb5qWW6xUn5haX
        5qXrJefnbmIEpqbT/45/2sH49VLSIUYBDkYlHt4FE43ihVgTy4orcw8xSnAwK4nwOp09HSfE
        m5JYWZValB9fVJqTWnyIUZqDRUmc13jRy1ghgfTEktTs1NSC1CKYLBMHp1QDo1WcvaXX9BM5
        Qv98E5vkn/5faf30Rn9zG//faUes9lvrbvaZx6SgXskd01f17GXmxCCVvLBmX9/UoKeX/W/U
        rypil5u8clnb6kJ+qdBLQVEdKzavb1xWodCiuuFilmDCy8M9SXs6pq/7HnKqymjNc5aN+6y/
        NMk7ry5RThNs2O0y9dKnljRTJZbijERDLeai4kQAk9FRh0kDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsVy+t/xu7qyp43iDZYcV7LYOGM9q8X1L89Z
        LT723GO1uLxrDpvFjPP7mCzWHrnLbnHxlKvFv2sbWSxW7frD6MDp8f5GK7vHzll32T02repk
        8+jbsorR4/MmuQDWKD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSc
        zLLUIn27BL2ME9euMhcs06y41v2QtYFxoVIXIyeHhICJxNr9M5i6GLk4hASWMkqcuL+PrYuR
        AyghJTG/BapGWOLPtS42iJr3jBLTvyxiB0kIC8RJbNlxkwnEFhFQl/g2pZ8dpIhZYD6zxPL3
        e8CKhASuMUp8n+cAYrMJGEr0Hu1jBLF5Bewktl69wgZiswioSjw8O40VxBYFGvq49z8zRI2g
        xMmZT1hAbE6BQIlVCyaA1TMDLfsz7xIzhC0ucevJfCYIW16ieets5gmMQrOQtM9C0jILScss
        JC0LGFlWMYqklhbnpucWG+kVJ+YWl+al6yXn525iBMbhtmM/t+xg7HoXfIhRgINRiYd3wUSj
        eCHWxLLiytxDjBIczEoivE5nT8cJ8aYkVlalFuXHF5XmpBYfYjQFem4is5Rocj4wReSVxBua
        GppbWBqaG5sbm1koifN2CByMERJITyxJzU5NLUgtgulj4uCUamC87Dvp1KEQzh/iT3qnxexZ
        IV6y0XqCjpB3/11TN7H7m6f/OyLJc50reOcL+ysT5Y+5ZC03bLXhmrqhuN42kz/qwVGdtkuW
        rTvXxLD19Uq9v1kUJPLzSj6Lbcvim5taZnufcayLMg++6te/icth2w35b5snzC7fHORfl7b/
        s6PrwpWvn8/g2rpaiaU4I9FQi7moOBEAhhHsC9kCAAA=
X-CMS-MailID: 20200811164517eucas1p186b6839ef0b5fed018d9f860cc15805b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200811112518eucas1p2a751f664a907ac7cd8e1dd235dc2fa54
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200811112518eucas1p2a751f664a907ac7cd8e1dd235dc2fa54
References: <CGME20200811112518eucas1p2a751f664a907ac7cd8e1dd235dc2fa54@eucas1p2.samsung.com>
        <20200811112507.24418-1-s.nawrocki@samsung.com>
        <CA+Ln22Hfys7r2EDstOsdks1X88Fuv77DLTuXLWDynTt4kmiCiQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomasz,

On 11.08.2020 14:59, Tomasz Figa wrote:
> 2020年8月11日(火) 13:25 Sylwester Nawrocki <s.nawrocki@samsung.com>:
>>
>> In the .set_rate callback for some PLLs there is a loop polling state
>> of the PLL lock bit and it may become an endless loop when something
>> goes wrong with the PLL. For some PLLs there is already (a duplicated)
>> code for polling with timeout. This patch replaces that code with
>> the readl_relaxed_poll_timeout_atomic() macro and moves it to a common
>> helper function, which is then used for all the PLLs. The downside
>> of switching to the common macro is that we drop the cpu_relax() call.
> 
> Tbh. I'm not sure what effect was exactly expected from cpu_relax() in
> the functions which already had timeout handling. Could someone shed
> some light on this?
> 
>> Using a common helper function rather than the macro directly allows
>> to avoid repeating the error message in the code and to avoid the object
>> code size increase due to inlining.
>>
>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> ---
>> Changes for v2:
>>  - use common readl_relaxed_poll_timeout_atomic() macro
>> ---
>>  drivers/clk/samsung/clk-pll.c | 92 +++++++++++++++----------------------------
>>  1 file changed, 32 insertions(+), 60 deletions(-)
>>
>> diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
>> index ac70ad7..c3c1efe 100644
>> --- a/drivers/clk/samsung/clk-pll.c
>> +++ b/drivers/clk/samsung/clk-pll.c
>> @@ -9,13 +9,14 @@

>> -#define PLL_TIMEOUT_MS         10
>> +#define PLL_TIMEOUT_US         10000U
> 
> I'm also wondering if 10ms is the universal value that would cover the
> oldest PLLs as well, but my loose recollection is that they should
> still lock much faster than that. Could you double check that in the
> documentation?

Thanks for your comments.

The oldest PLLs have a hard coded 300 us waiting time for PLL lock and 
are not affected by the patch.
I have checked some of the PLLs and maximum observed lock time was around 
370 us and most of the time it was just a few us.

We calculate the lock time in each set_rate op, in the oscillator cycle
units, as a product of current P divider value and a constant PLL type 
specific LOCK_FACTOR. Maximum possible P value is 64, maximum possible
LOCK_FACTOR is 3000. Assuming minimum VCO frequency of 24 MHz (which 
I think will usually be much higher than that) maximum lock time
would be (64 x 3000) / 24 MHz = 8 ms. I think we can leave the current 
10 ms value.

But there is other issue, it seems we can't really use the ktime API
in the set_rate callbacks, as these could be called early, before the
clocksource is initialized and ktime doesn't work yet. Below trace 
is from a dump_stack() added to the samsung_pll_lock_wait() callback.
The PLL rate setting is triggered by assigned-clock* properties in 
the clock supplier node.
I think we need to switch to a simple udelay() loop, as is done in 
clk-tegra210 driver for instance.

[    0.000000] Hardware name: Samsung Exynos (Flattened Device Tree)
[    0.000000] [<c0111e9c>] (unwind_backtrace) from [<c010d0ec>] (show_stack+0x10/0x14)
[    0.000000] [<c010d0ec>] (show_stack) from [<c051d890>] (dump_stack+0xac/0xd8)
[    0.000000] [<c051d890>] (dump_stack) from [<c0578d94>] (samsung_pll_lock_wait+0x14/0x174)
[    0.000000] [<c0578d94>] (samsung_pll_lock_wait) from [<c057319c>] (clk_change_rate+0x1a8/0x8ac)
[    0.000000] [<c057319c>] (clk_change_rate) from [<c0573aec>] (clk_core_set_rate_nolock+0x24c/0x268)
[    0.000000] [<c0573aec>] (clk_core_set_rate_nolock) from [<c0573b38>] (clk_set_rate+0x30/0x64)
[    0.000000] [<c0573b38>] (clk_set_rate) from [<c0577df8>] (of_clk_set_defaults+0x214/0x384)
[    0.000000] [<c0577df8>] (of_clk_set_defaults) from [<c0572f34>] (of_clk_add_hw_provider+0x98/0xd8)
[    0.000000] [<c0572f34>] (of_clk_add_hw_provider) from [<c1120278>] (samsung_clk_of_add_provider+0x1c/0x30)
[    0.000000] [<c1120278>] (samsung_clk_of_add_provider) from [<c1121844>] (exynos5250_clk_of_clk_init_driver+0x1f4/0x240)
[    0.000000] [<c1121844>] (exynos5250_clk_of_clk_init_driver) from [<c11200d0>] (of_clk_init+0x16c/0x218)
[    0.000000] [<c11200d0>] (of_clk_init) from [<c1104bdc>] (time_init+0x24/0x30)
[    0.000000] [<c1104bdc>] (time_init) from [<c1100d20>] (start_kernel+0x3b0/0x520)
[    0.000000] [<c1100d20>] (start_kernel) from [<00000000>] (0x0)
[    0.000000] samsung_pll_lock_wait: PLL fout_epll, lock time: 0 us, ret: 0
[    0.000000] Exynos5250: clock setup completed, armclk=1700000000
[    0.000000] Switching to timer-based delay loop, resolution 41ns
[    0.000000] clocksource: mct-frc: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635851949 ns
[    0.000003] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 89478484971ns
[    0.000032] genirq: irq_chip COMBINER did not update eff. affinity mask of irq 49
[    0.000523] arch_timer: cp15 timer(s) running at 24.00MHz (virt).
[    0.000536] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
[    0.000551] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps every 4398046511097ns

-- 
Regards,
Sylwester
