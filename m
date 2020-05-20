Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16206C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 01:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1EF520708
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 01:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="de/dkpon"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgETBO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 21:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgETBO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 21:14:58 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE66C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 18:14:58 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id h4so1028794wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 18:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K2epbnXt/qyxg2wIAsJNGGs3c+mHSSqu57LJYIjAlUQ=;
        b=de/dkponQWsvYBvKCdidTRLToaZF/S4ImkV+j5yM7b5we4hjNsoBbOOxWvWfz3IWvA
         FJCUumA3Kj89syDqZc7wZ9sh/MUXIlPPmguAmU1K+zj00v+qlAlo/cjR0QxD0gFY/EM4
         4asDfHBJgn50U4H8omWGscPD4nAlPPjRKB8k1iCfPRlJ+7FK2Qwh2euSS7REw1TPJYn4
         HhVfefiEi3jeXEvDibQTRez0TNYhoK5gYQcTlatNpc7njIHV1gzeFiMLm4k5pwV9YTvh
         787w1k8u1Se4Cwz1SkZhSY07T5DNe5yvU0ozm+7aHFblu0OQQ+CQNduk9tpwJQLPy5eC
         YsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K2epbnXt/qyxg2wIAsJNGGs3c+mHSSqu57LJYIjAlUQ=;
        b=XEqoR/uViwi46O4a5mG5rs4fWtLo4Qt5hV1JanmZGN6Bplm6yN0DmprjRqnZQ+Lcgb
         xvwODX1ENDlwuUxG8FZJtMcHt2nevrW+WYc90m3e2WIzrBwXFTWzc9RmZfaHpYUDeehz
         TiamTBI5bIbzmYVg1v8Tp3n2c60cliBJQW1UJeC6ptr10JA699hhuSQWAObCjv1nQNMf
         VjbCGI6+8pCPqBDgO5ALgOiFiapCPUd+CXwn1KS95e5vR4gUtbP+e33eyh5wdJimiy+8
         EhZ2PcO0IecRwjcVhybc+tMyPFijLcWDGSU5UBDefow2FitG7fyALwH3e0TR/wL31alo
         hOHQ==
X-Gm-Message-State: AOAM530xZ8H9Nz/pRNWK7X2rklPkqwyd9+cgduQSwA+Sed4to2AE6pXt
        P2QzcosP0kKNoBpRee7loTTV/wkSTFC9N6OMdfc0Vw==
X-Google-Smtp-Source: ABdhPJyzl/XxyPdwYt8l0bZn6VCPsb1ht7zSdC7tE0o4uwIM6zuGV7Up4G3KICdfOwg0Y2Rrxga+Y1opJ1QIChKufz8=
X-Received: by 2002:a7b:c0d1:: with SMTP id s17mr1988043wmh.157.1589937296422;
 Tue, 19 May 2020 18:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-0c491e9e-41fd-4f76-a048-55c03d9359f0@palmerdabbelt-glaptop1>
 <66121f9a-48f3-d3a5-7c96-d71397e12aed@linaro.org> <0bc3eb36-7b9d-7c86-130c-68b566e85c10@huawei.com>
 <e1916079-c209-bfad-6b0c-ccfb2e136ca4@linaro.org> <29dc112e-d8c2-2749-7f5d-7c0c19aa9092@huawei.com>
 <8c5ecbd3-c23a-ccd4-b5d8-2e7d2bd10699@linaro.org>
In-Reply-To: <8c5ecbd3-c23a-ccd4-b5d8-2e7d2bd10699@linaro.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 20 May 2020 06:44:44 +0530
Message-ID: <CAAhSdy2wsnkYMLpT1_2OAjr334t6dAy9LCPNefC=h+aPuRqFrg@mail.gmail.com>
Subject: Re: [PATCH 09/10] timer-riscv: Fix undefined riscv_time_val
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        hulkci@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 7:21 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 19/05/2020 14:39, Kefeng Wang wrote:
> >
> > On 2020/5/19 4:23, Daniel Lezcano wrote:
> >> Hi Kefeng,
> >>
> >> On 18/05/2020 17:40, Kefeng Wang wrote:
> >>> On 2020/5/18 22:09, Daniel Lezcano wrote:
> >>>> On 13/05/2020 23:14, Palmer Dabbelt wrote:
> >>>>> On Sun, 10 May 2020 19:20:00 PDT (-0700), wangkefeng.wang@huawei.co=
m
> >>>>> wrote:
> >>>>>> ERROR: modpost: "riscv_time_val" [crypto/tcrypt.ko] undefined!
> >>>>>>
> >>>>>> Reported-by: Hulk Robot <hulkci@huawei.com>
> >>>>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> >>>>>> ---
> >>>>>>    drivers/clocksource/timer-riscv.c | 1 +
> >>>>>>    1 file changed, 1 insertion(+)
> >>>>>>
> >>>>>> diff --git a/drivers/clocksource/timer-riscv.c
> >>>>>> b/drivers/clocksource/timer-riscv.c
> >>>>>> index c4f15c4068c0..071b8c144027 100644
> >>>>>> --- a/drivers/clocksource/timer-riscv.c
> >>>>>> +++ b/drivers/clocksource/timer-riscv.c
> >>>>>> @@ -19,6 +19,7 @@
> >>>>>>
> >>>>>>    u64 __iomem *riscv_time_cmp;
> >>>>>>    u64 __iomem *riscv_time_val;
> >>>>>> +EXPORT_SYMBOL(riscv_time_val);
> >>>>>>
> >>>>>>    static inline void mmio_set_timer(u64 val)
> >>>>>>    {
> >>>>> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> >>>>> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
> >>>>>
> >>>>> Adding the clocksource maintainers.  Let me know if you want this
> >>>>> through my
> >>>>> tree, I'm assuming you want it through your tree.
> >>>> How can we end up by an export symbol here ?!
> >>> Hi Danile,
> >> s/Danile/Daniel/
> > Sorry for typing error.
> >>
> >>> Found this build error when CONFIG_RISCV_M_MODE=3Dy and CONFIG_RISCV_=
SBI
> >>> is not,
> >>>
> >>> see patch "4f9bbcefa142 riscv: add support for MMIO access to the tim=
er
> >>> registers"
> >> Thanks for the pointer.
> >>
> >> The question still remains, how do we end up with this EXPORT_SYMBOL?
> >>
> >> There is something wrong if the fix is an EXPORT_SYMBOL for a global
> >> variable.
> >
> > Not very clear, there are some global variable( eg, acpi_disabled,
> > memstart_addr in arm64,) is exported by EXPORT_SYMBOL,  do you mean tha=
t
> > export riscv_time_val is wrong way?
>
> I do not maintain acpi neither arm64.mm.
>
> AFAICT, riscv_time_val is globally declared in
> drivers/clocksource/timer-riscv.c
>
> The driver does not use this variable at all. Then there is a readl on
> it in the header file arch/riscv/include/asm/timex.h
>
> And finally it is initialized in arch/riscv/kernel/clint.c
>
> Same thing for riscv_time_cmp.
>
> The correct fix is to initialize the variables in the place where they
> belong to (drivers/clocksource/timer-riscv.c), create a function to read
> their content and export-symbol-gpl the function.

I agree with Daniel. Exporting riscv_time_val is a temporary fix.

The problem is timer-riscv.c is pretty convoluted right now. It is
implementing two different clocksources and clockevents in one-place.

I think we need two separate drivers for RISC-V world.

1. timer-riscv: This for regular S-mode kernel with MMU. The clocksource
will use TIME CSR and the clockevent device will use SBI calls.

2. timer-clint: This for M-mode kernel without MMU (or NoMMU kernel).
The clocksource will use MMIO counter for clocksource and the
clockevent device will use MMIO compare registers.

I will send a patch to have a separate timer-clint driver under
drivers/clocksource. (@Daniel, I hope you will be fine with this?)

Regards,
Anup

>
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
