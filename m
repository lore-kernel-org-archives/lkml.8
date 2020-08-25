Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C8FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 08:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A60D20706
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 08:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=trendmicro.com header.i=@trendmicro.com header.b="gSsgIs/K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbgHYIdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 04:33:40 -0400
Received: from sjdcvmout02.udc.trendmicro.com ([66.180.82.11]:39802 "EHLO
        sjdcvmout02.udc.trendmicro.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726365AbgHYIdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 04:33:40 -0400
Received: from sjdcvmout02.udc.trendmicro.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4ACCF64140;
        Tue, 25 Aug 2020 01:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=trendmicro.com;
        s=tmoutbound; t=1598344418;
        bh=Luir7nR2XTrp6W8uw7NkrO08j4VDTUfSx+6kri2mgvM=; h=From:To:Date;
        b=gSsgIs/KnTTrJTFXZmkatc4q5A8k1yWBfYUFVjufCBS6s7H/9cOoF7mZ3mLs97AIC
         iax6jPkF4MvfzFXiozjAG/oDFGiLczU999bXQYhMvSBEq0uBqaN7nzACwcYcC42HpJ
         UsQt7fUsiGKFA1oXE7EGXa98P0sxa03QIAfmnyn8=
Received: from sjdcvmout02.udc.trendmicro.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D9BE64101;
        Tue, 25 Aug 2020 01:33:38 -0700 (PDT)
Received: from SJDC-EXNABU01.us.trendnet.org (unknown [10.45.175.97])
        by sjdcvmout02.udc.trendmicro.com (Postfix) with ESMTPS;
        Tue, 25 Aug 2020 01:33:38 -0700 (PDT)
Received: from ADC-EXAPAC11.tw.trendnet.org (10.28.2.228) by
 SJDC-EXNABU01.us.trendnet.org (10.45.175.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1979.3; Tue, 25 Aug 2020 01:33:37 -0700
Received: from ADC-EXAPAC11.tw.trendnet.org (10.28.2.228) by
 ADC-EXAPAC11.tw.trendnet.org (10.28.2.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1979.3; Tue, 25 Aug 2020 08:33:35 +0000
Received: from ADC-EXAPAC11.tw.trendnet.org ([fe80::e9de:ebb1:bcf0:5913]) by
 ADC-EXAPAC11.tw.trendnet.org ([fe80::e9de:ebb1:bcf0:5913%18]) with mapi id
 15.01.1979.003; Tue, 25 Aug 2020 08:33:35 +0000
From:   "Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: RE: x86/kprobes: kretprobe fails to triggered if kprobe at function
 entry is not optimized (trigger by int3 breakpoint)
Thread-Topic: x86/kprobes: kretprobe fails to triggered if kprobe at function
 entry is not optimized (trigger by int3 breakpoint)
Thread-Index: AdZ5/y9ucVi7Kf0NSwa8vnc6Q/ol0wAL6hEAAAENaQAAHQZRAAADkvVw
Date:   Tue, 25 Aug 2020 08:33:34 +0000
Message-ID: <6e13d34ef07a4d90b7bb71b073cd968b@trendmicro.com>
References: <8816bdbbc55c4d2397e0b02aad2825d3@trendmicro.com>
        <20200825005426.f592075d13be740cb3c9aa77@kernel.org>
        <7396e7b2079644a6aafd9670a111232b@trendmicro.com>
 <20200825151538.f856d701a34f4e0561a64932@kernel.org>
In-Reply-To: <20200825151538.f856d701a34f4e0561a64932@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.28.4.6]
X-TM-AS-Product-Ver: IMSVA-9.1.0.1960-8.6.0.1013-25624.005
X-TM-AS-Result: No--35.256-5.0-31-10
X-TMASE-MatchedRID: muXOB2O84tnUL3YCMmnG4vHkpkyUphL9Ud7Bjfo+5jRsMPuLZB/IR0Nf
        BZcEsxYNvXnGYu7ygE5NcSg5oj+tVRJ49ZBgqflrlVHM/F6YkvSTnpV+S7Y80XaucMF8JglMnVt
        gvxMdrINGDjcibnDYB6TRVhN59X1QBtssTatiD/2tBybNxXyi/D0oG3q2fIVyvzxCJAsySU2/2z
        YC9kXlCnPBv2ppF7iTW+wTEl3BxoZ2CEKBxIsfqsNRQaXfz1r2N5dqZcIK7VgW6M2A15L1QLETh
        U84InSzvbGAAtRxOqueNYAEO5cb8/r252PTOmm/GRGzW800PG/AmOfzKotTogMADm5EdqKWZ4eW
        k5EoTKkMtQQ01+lvQ93Aaqefw2As8ien0Tfl19wSEYfcJF0pRT4H4hoqLeJJkY8eITaSJPhuNRG
        oPKGTofoN8+l3dEUSbe9EjMnITTu2eGGESuJjB/VY7U3NX8JgBGvINcfHqheEAZ+8YfT0PVbTtJ
        pG9MBBJv8aazh7O1DxRmueCpwtPdwGyLnS1FSdolVO7uyOCDUdLjiwtocA8mz3xnx8b/qRUurv+
        FQWpSDE0AQvp+oKYVTUqH8/USCeD+SZ39UdMDYK4MBRf7I7pggqPpbA7sp1BCzD0Dc8iUtpcrNT
        w4Vi6HgF4L3ED9sFxIlmjVV6USrzmirc8akziUjBb8q+S/OCGnGYpZN+xAgS39b8+3nDx0n0rj6
        eJPFK5OWBVbml6arEN2457SKi0pzAN0sNcMp5PwKTD1v8YV5MkOX0UoduuU3hJDbXzhXf0iSXG6
        dWPlts87vaSu5/M6jH4LMV+yok42nbKJncaZSeAiCmPx4NwMidYBYDjITp+gD2vYtOFhgqtq5d3
        cxkNQP90fJP9eHt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--35.255500-10.000000
X-TMASE-Version: IMSVA-9.1.0.1960-8.6.1013-25624.005
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-TM-SNTS-SMTP: CA764E2959D7CBC70FE86B85FED883BB1F82B8996BDA5491D3D9D155A10D52082000:8
X-TM-AS-GCONF: 00
X-imss-scan-details: No--35.256-5.0-31-10
X-TMASE-SNAP-Result: 1.821001.0001-0-1-12:0,22:0,33:0,34:0-0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Masami Hiramatsu <mhiramat@kernel.org>
> Sent: Tuesday, August 25, 2020 2:16 PM
> To: Eddy Wu (RD-TW) <Eddy_Wu@trendmicro.com>
> Cc: Peter Zijlstra <peterz@infradead.org>; linux-kernel@vger.kernel.org; =
x86@kernel.org; David S. Miller <davem@davemloft.net>
> Subject: Re: x86/kprobes: kretprobe fails to triggered if kprobe at funct=
ion entry is not optimized (trigger by int3 breakpoint)
>
>
> This message was sent from outside of Trend Micro. Please do not click li=
nks or open attachments unless you recognise the source of this
> email and know the content is safe.
>
>
> Hi Eddy,
>
> On Mon, 24 Aug 2020 16:41:58 +0000
> "Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com> wrote:
>
> > > -----Original Message-----
> > > From: Masami Hiramatsu <mhiramat@kernel.org>
> > > Sent: Monday, August 24, 2020 11:54 PM
> > > To: Eddy Wu (RD-TW) <Eddy_Wu@trendmicro.com>
> > > Cc: Peter Zijlstra <peterz@infradead.org>; linux-kernel@vger.kernel.o=
rg; x86@kernel.org; David S. Miller <davem@davemloft.net>
> > > Subject: Re: x86/kprobes: kretprobe fails to triggered if kprobe at f=
unction entry is not optimized (trigger by int3 breakpoint)
> > >
> > >
> > > This message was sent from outside of Trend Micro. Please do not clic=
k links or open attachments unless you recognise the source of
> this
> > > email and know the content is safe.
> > >
> > >
> > > On Mon, 24 Aug 2020 12:02:58 +0000
> > > "Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com> wrote:
> > >
> > > > Greetings!
> > > >
> > > > Starting from kernel 5.8 (x86_64), kretprobe handler will always mi=
ssed if corresponding kprobe on function entry is not optimized
> > > (using break point instead).
> > >
> > > Oops, good catch. I always enabled ftrace hook for kretprobe, I didn'=
t noticed that.
> > >
> > > > Step to reproduce this:
> > > > 1) Build the kretprobe example module (CONFIG_SAMPLE_KRETPROBES=3Dm=
)
> > > > 2) Disable jump optimization (`sysctl debug.kprobes-optimization=3D=
0` or register any kprobe.post_handler at same location)
> > > > 3) Insert the kretprobe_example module
> > > > 4) Launch some process to trigger _do_fork
> > > > 5) Remove kretprobe_example module
> > > > 6) dmesg shows that all probing instances are missed
> > > >
> > > > Example output:
> > > > # sysctl debug.kprobes-optimization=3D0
> > > > debug.kprobes-optimization =3D 0
> > > > # insmod samples/kprobes/kretprobe_example.ko
> > > > # ls > /dev/null
> > > > # rmmod kretprobe_example
> > > > # dmesg
> > > > [48555.067295] Planted return probe at _do_fork: 0000000038ae0211
> > > > [48560.229459] kretprobe at 0000000038ae0211 unregistered
> > > > [48560.229460] Missed probing 3 instances of _do_fork
> > > >
> > > > After bisecting, I found this behavior seems to introduce by this c=
ommit: (5.8-rc1)
> > > > 0d00449c7a28a1514595630735df383dec606812 x86: Replace ist_enter() w=
ith nmi_enter()
> > > > This make kprobe_int3_handler() effectively running as NMI context,=
 which pre_handler_kretprobe() explicitly checked to prevent
> > > recursion.
> > >
> > > Thanks for the bisecting!
> > >
> > > >
> > > > (in_nmi() check appears from v3.17)
> > > > f96f56780ca584930bb3a2769d73fd9a101bcbbe kprobes: Skip kretprobe hi=
t in NMI context to avoid deadlock
> > > >
> > > > To make kretprobe work again with int3 breakpoint, I think we can r=
eplace the in_nmi() check with in_nmi() =3D=3D (1 << NMI_SHIFT) at
> > > kprobe_int3_handler() and skip kretprobe if nested NMI.
> > >
> > > Ah, I see. Now int3 is a kind of NMI, so in the handler in_nmi() alwa=
ys returns !0.
> > >
> > > > Did a quick test on 5.9-rc2 and it seems to be working.
> > > > I'm not sure if it is the best way to do since it may also require =
change to other architecture as well, any thought?
> > >
> > > Hmm, this behavior is arch-dependent. So I think we need an weak func=
tion like this.
> > >
> > > @kernel/kprobes.c
> > >
> > > bool __weak arch_kprobe_in_nmi(void)
> > > {
> > >         return in_nmi()
> > > }
> > >
> > > @arch/x86/kernel/kprobes/core.c
> > >
> > > bool arch_kprobe_in_nmi(void)
> > > {
> > >        /*
> > >         * Since the int3 is one of NMI, we have to check in_nmi() is
> > >         * bigger than 1 << NMI_SHIFT instead of !0.
> > >         */
> > >        return in_nmi() > (1 << NMI_SHIFT);
> > > }
> > >
> > > And use arch_kprobe_in_nmi() instead of in_nmi() in kprobes.c.
> > >
> > > Thanks,
> > >
> > > --
> > > Masami Hiramatsu <mhiramat@kernel.org>
> >
> > Kretprobe might still trigger from NMI with nmi counter =3D=3D 1 (if en=
try kprobe is jump-optimized).
>
> Ah, right. Hmm, in that case, we can store the int3 status in
> the kprobe_ctlblk and refer it in the handler.
>
>
> > The arch- dependent weak function looks cleaner than doing this in kpro=
be_int3_handler() under x86/, but I don't know if there is a
> way to check if called by specific int3 handler or not.
> >
> > My original patch below, need to change all architecture support kretpr=
obe though
>
> OK, here is my fix. This will not change the other arches. please try it.
>
>
> From 24390dffe6eb9a3e95f7d46a528a1dcfd716dc81 Mon Sep 17 00:00:00 2001
> From: Masami Hiramatsu <mhiramat@kernel.org>
> Date: Tue, 25 Aug 2020 01:37:00 +0900
> Subject: [PATCH] kprobes/x86: Fixes NMI context check on x86
>
> Since commit 0d00449c7a28 ("x86: Replace ist_enter() with nmi_enter()")
> made int3 as one of NMI, in_nmi() in kprobe handlers always returns !0.
> Thus the kretprobe handlers always skipped the execution on x86 if it
> is using int3. (CONFIG_KPROBES_ON_FTRACE=3Dn and
> echo 0 > /proc/sys/debug/kprobe_optimization)
>
> To avoid this issue, introduce arch_kprobe_in_nmi() and check the
> in_nmi() count is bigger than 1 << NMI_SHIFT on x86 if the handler
> has been invoked from kprobe_int3_handler. By default, the
> arch_kprobe_in_nmi() will be same as in_nmi().
>
> Fixes: 0d00449c7a28 ("x86: Replace ist_enter() with nmi_enter()")
> Reported-by: Eddy Wu <Eddy_Wu@trendmicro.com>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  arch/x86/include/asm/kprobes.h |  1 +
>  arch/x86/kernel/kprobes/core.c | 18 ++++++++++++++++++
>  kernel/kprobes.c               |  8 +++++++-
>  3 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/kprobes.h b/arch/x86/include/asm/kprobe=
s.h
> index 143bc9abe99c..ddb24feb95ad 100644
> --- a/arch/x86/include/asm/kprobes.h
> +++ b/arch/x86/include/asm/kprobes.h
> @@ -98,6 +98,7 @@ struct kprobe_ctlblk {
>         unsigned long kprobe_old_flags;
>         unsigned long kprobe_saved_flags;
>         struct prev_kprobe prev_kprobe;
> +       bool    in_int3;
>  };
>
>  extern int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/cor=
e.c
> index 2ca10b770cff..649d467c8231 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -583,6 +583,20 @@ static nokprobe_inline void restore_btf(void)
>         }
>  }
>
> +bool arch_kprobe_in_nmi(void)
> +{
> +       struct kprobe_ctlblk *kcb =3D get_kprobe_ctlblk();
> +
> +       if (kcb->in_int3) {
> +               /*
> +                * Since the int3 is one of NMI, we have to check in_nmi(=
) is
> +                * bigger than 1 << NMI_SHIFT instead of !0.
> +                */
> +               return in_nmi() > (1 << NMI_SHIFT);
> +       } else
> +               return in_nmi();
> +}
> +
>  void arch_prepare_kretprobe(struct kretprobe_instance *ri, struct pt_reg=
s *regs)
>  {
>         unsigned long *sara =3D stack_addr(regs);
> @@ -697,6 +711,7 @@ int kprobe_int3_handler(struct pt_regs *regs)
>                                 return 1;
>                 } else {
>                         set_current_kprobe(p, regs, kcb);
> +                       kcb->in_int3 =3D true;
>                         kcb->kprobe_status =3D KPROBE_HIT_ACTIVE;
>
>                         /*
> @@ -710,6 +725,7 @@ int kprobe_int3_handler(struct pt_regs *regs)
>                                 setup_singlestep(p, regs, kcb, 0);
>                         else
>                                 reset_current_kprobe();
> +                       kcb->in_int3 =3D false;
>                         return 1;
>                 }
>         } else if (*addr !=3D INT3_INSN_OPCODE) {
> @@ -994,7 +1010,9 @@ int kprobe_debug_handler(struct pt_regs *regs)
>
>         if ((kcb->kprobe_status !=3D KPROBE_REENTER) && cur->post_handler=
) {
>                 kcb->kprobe_status =3D KPROBE_HIT_SSDONE;
> +               kcb->in_int3 =3D true;
>                 cur->post_handler(cur, regs, 0);
> +               kcb->in_int3 =3D false;
>         }
>
>         /* Restore back the original saved kprobes variables and continue=
. */
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 287b263c9cb9..9564928fb882 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1927,6 +1927,12 @@ unsigned long __weak arch_deref_entry_point(void *=
entry)
>  }
>
>  #ifdef CONFIG_KRETPROBES
> +
> +bool __weak arch_kprobe_in_nmi(void)
> +{
> +       return in_nmi();
> +}
> +
>  /*
>   * This kprobe pre_handler is registered with every kretprobe. When prob=
e
>   * hits it will set up the return probe.
> @@ -1943,7 +1949,7 @@ static int pre_handler_kretprobe(struct kprobe *p, =
struct pt_regs *regs)
>          * statistical counter, so that the user is informed that
>          * something happened:
>          */
> -       if (unlikely(in_nmi())) {
> +       if (unlikely(arch_kprobe_in_nmi())) {
>                 rp->nmissed++;
>                 return 0;
>         }
> --
> 2.25.1
>
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>

This works on my machine, thanks!

TREND MICRO EMAIL NOTICE

The information contained in this email and any attachments is confidential=
 and may be subject to copyright or other intellectual property protection.=
 If you are not the intended recipient, you are not authorized to use or di=
sclose this information, and we request that you notify us by reply mail or=
 telephone and delete the original message from your mail system.

For details about what personal information we collect and why, please see =
our Privacy Notice on our website at: Read privacy policy<http://www.trendm=
icro.com/privacy>
