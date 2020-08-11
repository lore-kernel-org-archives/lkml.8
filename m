Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D04C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80B3D2076B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ME5nK4ym"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgHKQx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 12:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729046AbgHKQx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:53:57 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDD8C06174A;
        Tue, 11 Aug 2020 09:53:57 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id z6so13403732iow.6;
        Tue, 11 Aug 2020 09:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nZ/k9Byto1826yL422aEJoOrFWeBEVpscC6FOqMA7kA=;
        b=ME5nK4ymcdbDyMLRTGXIrkRc9MfpLvEQIypfQ6i7SLtjdscQ9yqRf5etWxP3lgzQqN
         WCkmcuPrpUvn6+F/UgAMbFdy2ioyoNDmVgzF0QS1FGxqFSAOkkCSLmTLJsdgqovV43Yh
         lsIttJxqv6oi4sSUl0Jj4ABVh2hC12n5rb5i/i9u8sW8J2LZu5FhSndWAhGTrcXLtaTl
         kgCRiaY8APBt85uH9U77xmouwnOv60WHMEhmUTAFiGFFq1Tnhw4PgDWonLsxmE2+b0h0
         lHKQSvaHkAmweqs6ezAoljmvb69FbqQsgTLRB7GGh0/+fuMNJayFdmoUOqa7vUawHp8i
         jKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nZ/k9Byto1826yL422aEJoOrFWeBEVpscC6FOqMA7kA=;
        b=Qdm9/EQH1JiG8GMHN+CxNKoZZ+vy6pRShArcbaJ4g5OWupAv6DFevb0b8rBU+9sUwe
         mN69v5JpeWkDIboSBcgFzVOnjDrEZ3BZyuuj1MPTlbZgpBEZ6JU99nvIcsfUs1OBafE3
         UJ+URG/sIe/GBKjMoOkCGvtCA8Q/kaPKjB2sV+1UbwhnRvHB4DwvzsMypydevX3ryqYU
         RFskPsZqyBDZQPxgDV3zEAYc7cU1Q0OJiPKDKI8Cz+vBrQKvu/zRp4L/7FfvEQA5PD7t
         BCnRzfpINTYCYT6eA17A/Cpo9++ZYFba2u4PaFQXshoWkrZE0+4o8ORh2qOMdadeLzRC
         cHTw==
X-Gm-Message-State: AOAM530xkVNveqhttKljVQ5JxhBIzt16Hp+bwgCJBDeZu2ucmF9an5zg
        m1N9RERTtQjfTjhl8rAjHfw2k82IW6nQh3HFU9Q=
X-Google-Smtp-Source: ABdhPJxuLtZbjgoEws5GBiRtQSrFjUhONQp+nc/PcBjemOv4wvx8B6pNySW1uABQ2h17VfUBda5qLktg0/VXklGmSR0=
X-Received: by 2002:a6b:b888:: with SMTP id i130mr23575515iof.182.1597164836425;
 Tue, 11 Aug 2020 09:53:56 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200811112518eucas1p2a751f664a907ac7cd8e1dd235dc2fa54@eucas1p2.samsung.com>
 <20200811112507.24418-1-s.nawrocki@samsung.com> <CA+Ln22Hfys7r2EDstOsdks1X88Fuv77DLTuXLWDynTt4kmiCiQ@mail.gmail.com>
 <66c7330e-507e-d81f-1cb1-b509bf54d050@samsung.com>
In-Reply-To: <66c7330e-507e-d81f-1cb1-b509bf54d050@samsung.com>
From:   Tomasz Figa <tomasz.figa@gmail.com>
Date:   Tue, 11 Aug 2020 18:53:44 +0200
Message-ID: <CA+Ln22E4FPexE1R2dmV=u9U5UFWsAz=8kXgqBntEBgabnUEF+Q@mail.gmail.com>
Subject: Re: [PATCH v2] clk: samsung: Prevent potential endless loop in the
 PLL set_rate ops
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        "moderated list:SAMSUNG SOC CLOCK DRIVERS" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=E5=B9=B48=E6=9C=8811=E6=97=A5(=E7=81=AB) 18:45 Sylwester Nawrocki <s.n=
awrocki@samsung.com>:
>
> Hi Tomasz,
>
> On 11.08.2020 14:59, Tomasz Figa wrote:
> > 2020=E5=B9=B48=E6=9C=8811=E6=97=A5(=E7=81=AB) 13:25 Sylwester Nawrocki =
<s.nawrocki@samsung.com>:
> >>
> >> In the .set_rate callback for some PLLs there is a loop polling state
> >> of the PLL lock bit and it may become an endless loop when something
> >> goes wrong with the PLL. For some PLLs there is already (a duplicated)
> >> code for polling with timeout. This patch replaces that code with
> >> the readl_relaxed_poll_timeout_atomic() macro and moves it to a common
> >> helper function, which is then used for all the PLLs. The downside
> >> of switching to the common macro is that we drop the cpu_relax() call.
> >
> > Tbh. I'm not sure what effect was exactly expected from cpu_relax() in
> > the functions which already had timeout handling. Could someone shed
> > some light on this?
> >
> >> Using a common helper function rather than the macro directly allows
> >> to avoid repeating the error message in the code and to avoid the obje=
ct
> >> code size increase due to inlining.
> >>
> >> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> >> ---
> >> Changes for v2:
> >>  - use common readl_relaxed_poll_timeout_atomic() macro
> >> ---
> >>  drivers/clk/samsung/clk-pll.c | 92 +++++++++++++++-------------------=
---------
> >>  1 file changed, 32 insertions(+), 60 deletions(-)
> >>
> >> diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-p=
ll.c
> >> index ac70ad7..c3c1efe 100644
> >> --- a/drivers/clk/samsung/clk-pll.c
> >> +++ b/drivers/clk/samsung/clk-pll.c
> >> @@ -9,13 +9,14 @@
>
> >> -#define PLL_TIMEOUT_MS         10
> >> +#define PLL_TIMEOUT_US         10000U
> >
> > I'm also wondering if 10ms is the universal value that would cover the
> > oldest PLLs as well, but my loose recollection is that they should
> > still lock much faster than that. Could you double check that in the
> > documentation?
>
> Thanks for your comments.
>
> The oldest PLLs have a hard coded 300 us waiting time for PLL lock and
> are not affected by the patch.
> I have checked some of the PLLs and maximum observed lock time was around
> 370 us and most of the time it was just a few us.
>
> We calculate the lock time in each set_rate op, in the oscillator cycle
> units, as a product of current P divider value and a constant PLL type
> specific LOCK_FACTOR. Maximum possible P value is 64, maximum possible
> LOCK_FACTOR is 3000. Assuming minimum VCO frequency of 24 MHz (which
> I think will usually be much higher than that) maximum lock time
> would be (64 x 3000) / 24 MHz =3D 8 ms. I think we can leave the current
> 10 ms value.

Sounds good to me. Thanks!

>
> But there is other issue, it seems we can't really use the ktime API
> in the set_rate callbacks, as these could be called early, before the
> clocksource is initialized and ktime doesn't work yet. Below trace
> is from a dump_stack() added to the samsung_pll_lock_wait() callback.
> The PLL rate setting is triggered by assigned-clock* properties in
> the clock supplier node.
> I think we need to switch to a simple udelay() loop, as is done in
> clk-tegra210 driver for instance.
>
> [    0.000000] Hardware name: Samsung Exynos (Flattened Device Tree)
> [    0.000000] [<c0111e9c>] (unwind_backtrace) from [<c010d0ec>] (show_st=
ack+0x10/0x14)
> [    0.000000] [<c010d0ec>] (show_stack) from [<c051d890>] (dump_stack+0x=
ac/0xd8)
> [    0.000000] [<c051d890>] (dump_stack) from [<c0578d94>] (samsung_pll_l=
ock_wait+0x14/0x174)
> [    0.000000] [<c0578d94>] (samsung_pll_lock_wait) from [<c057319c>] (cl=
k_change_rate+0x1a8/0x8ac)
> [    0.000000] [<c057319c>] (clk_change_rate) from [<c0573aec>] (clk_core=
_set_rate_nolock+0x24c/0x268)
> [    0.000000] [<c0573aec>] (clk_core_set_rate_nolock) from [<c0573b38>] =
(clk_set_rate+0x30/0x64)
> [    0.000000] [<c0573b38>] (clk_set_rate) from [<c0577df8>] (of_clk_set_=
defaults+0x214/0x384)
> [    0.000000] [<c0577df8>] (of_clk_set_defaults) from [<c0572f34>] (of_c=
lk_add_hw_provider+0x98/0xd8)
> [    0.000000] [<c0572f34>] (of_clk_add_hw_provider) from [<c1120278>] (s=
amsung_clk_of_add_provider+0x1c/0x30)
> [    0.000000] [<c1120278>] (samsung_clk_of_add_provider) from [<c1121844=
>] (exynos5250_clk_of_clk_init_driver+0x1f4/0x240)
> [    0.000000] [<c1121844>] (exynos5250_clk_of_clk_init_driver) from [<c1=
1200d0>] (of_clk_init+0x16c/0x218)
> [    0.000000] [<c11200d0>] (of_clk_init) from [<c1104bdc>] (time_init+0x=
24/0x30)
> [    0.000000] [<c1104bdc>] (time_init) from [<c1100d20>] (start_kernel+0=
x3b0/0x520)

Yeah... I should've thought about this. Interestingly enough, some of
the existing implementations in drivers/clk/samsung/clk-pll.c use the
ktime API. I guess they are lucky enough not to be called too early,
i.e. are not needed for the initialization of timers.

Best regards,
Tomasz


> [    0.000000] [<c1100d20>] (start_kernel) from [<00000000>] (0x0)
> [    0.000000] samsung_pll_lock_wait: PLL fout_epll, lock time: 0 us, ret=
: 0
> [    0.000000] Exynos5250: clock setup completed, armclk=3D1700000000
> [    0.000000] Switching to timer-based delay loop, resolution 41ns
> [    0.000000] clocksource: mct-frc: mask: 0xffffffff max_cycles: 0xfffff=
fff, max_idle_ns: 79635851949 ns
> [    0.000003] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps ever=
y 89478484971ns
> [    0.000032] genirq: irq_chip COMBINER did not update eff. affinity mas=
k of irq 49
> [    0.000523] arch_timer: cp15 timer(s) running at 24.00MHz (virt).
> [    0.000536] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_=
cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
> [    0.000551] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps ever=
y 4398046511097ns
>
> --
> Regards,
> Sylwester
