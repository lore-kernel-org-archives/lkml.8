Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B62EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BC5D2067C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=trendmicro.com header.i=@trendmicro.com header.b="OvHKxgqf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbgHXQmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 12:42:32 -0400
Received: from sjdcvmout02.udc.trendmicro.com ([66.180.82.11]:55596 "EHLO
        sjdcvmout02.udc.trendmicro.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728037AbgHXQmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 12:42:07 -0400
Received: from sjdcvmout02.udc.trendmicro.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8757C64132;
        Mon, 24 Aug 2020 09:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=trendmicro.com;
        s=tmoutbound; t=1598287321;
        bh=nNLor1Ldc4R6nmhqS0qNrewmb+9tKmzXS8u1yugS++A=; h=From:To:Date;
        b=OvHKxgqfvAyMwFhldKYLLJufcE0TfeWUQtppvwNVCeSnHKF3FwHJEZlh3QZgw0wxD
         w/SIE3fEzAm8fOSD54O8why3ABwlcj3jsGg9VR54kFHEcg9B47Al2sFHEZdiKPbGZy
         vbkeEI57iAa9K0mWPWMAjlW/KE5HeT17ZSeJzNmI=
Received: from sjdcvmout02.udc.trendmicro.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70AF864120;
        Mon, 24 Aug 2020 09:42:01 -0700 (PDT)
Received: from SJDC-EXNABU02.us.trendnet.org (unknown [10.45.175.98])
        by sjdcvmout02.udc.trendmicro.com (Postfix) with ESMTPS;
        Mon, 24 Aug 2020 09:42:01 -0700 (PDT)
Received: from ADC-EXAPAC12.tw.trendnet.org (10.28.2.229) by
 SJDC-EXNABU02.us.trendnet.org (10.45.175.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1979.3; Mon, 24 Aug 2020 09:42:01 -0700
Received: from ADC-EXAPAC11.tw.trendnet.org (10.28.2.228) by
 ADC-EXAPAC12.tw.trendnet.org (10.28.2.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1979.3; Mon, 24 Aug 2020 16:41:58 +0000
Received: from ADC-EXAPAC11.tw.trendnet.org ([fe80::e9de:ebb1:bcf0:5913]) by
 ADC-EXAPAC11.tw.trendnet.org ([fe80::e9de:ebb1:bcf0:5913%18]) with mapi id
 15.01.1979.003; Mon, 24 Aug 2020 16:41:58 +0000
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
Thread-Index: AdZ5/y9ucVi7Kf0NSwa8vnc6Q/ol0wAL6hEAAAENaQA=
Date:   Mon, 24 Aug 2020 16:41:58 +0000
Message-ID: <7396e7b2079644a6aafd9670a111232b@trendmicro.com>
References: <8816bdbbc55c4d2397e0b02aad2825d3@trendmicro.com>
 <20200825005426.f592075d13be740cb3c9aa77@kernel.org>
In-Reply-To: <20200825005426.f592075d13be740cb3c9aa77@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.28.4.6]
X-TM-AS-Product-Ver: IMSVA-9.1.0.1960-8.6.0.1013-25624.001
X-TM-AS-Result: No--38.420-5.0-31-10
X-TMASE-MatchedRID: AGI6IuWlRrrUL3YCMmnG4vHkpkyUphL9Ud7Bjfo+5jRsMPuLZB/IR0Nf
        BZcEsxYNvXnGYu7ygE5NcSg5oj+tVRJ49ZBgqflrlVHM/F6YkvSTnpV+S7Y80XaucMF8JglMnVt
        gvxMdrINGDjcibnDYB6TRVhN59X1QBtssTatiD/2tBybNxXyi/D0oG3q2fIVyvzxCJAsySU2/2z
        YC9kXlCnPBv2ppF7iTW+wTEl3BxoZ2CEKBxIsfqsNRQaXfz1r2N5dqZcIK7VgW6M2A15L1QLETh
        U84InSzvbGAAtRxOqueNYAEO5cb8/r252PTOmm/GRGzW800PG/AmOfzKotTogMADm5EdqKWZ4eW
        k5EoTKkMtQQ01+lvQ93Aaqefw2As8ien0Tfl19wSEYfcJF0pRT4H4hoqLeJJkY8eITaSJPhuNRG
        oPKGTofoN8+l3dEUSbe9EjMnITTu2eGGESuJjB/VY7U3NX8JgBGvINcfHqheEAZ+8YfT0PVbTtJ
        pG9MBBJv8aazh7O1DxRmueCpwtPdwGyLnS1FSdolVO7uyOCDUdLjiwtocA8mz3xnx8b/qRUurv+
        FQWpSDE0AQvp+oKYVTUqH8/USCeD+SZ39UdMDYK4MBRf7I7pggqPpbA7sp1I0YrtQLsSUxGIzSv
        kOhmQHxs7qFZ9FbOj0IvV7jlqDgancMs9QMk2xo8wYJxWb0O4F58RPNYsrHsvb7MYS5s3qWr0Pe
        scWVkWTcRxKLTHtYCRNhmiU8GRJNvbw3UTmBbSVHYMTQ1F1piNQON9IBz8gFUJiJ1WpVkc1K0mN
        2c/Whl4GC6K3GWyJxF3ywhGxXFHrdNH7JogAeeAiCmPx4NwMidYBYDjITp+gD2vYtOFhgqtq5d3
        cxkNQwWxr7XDKH8lExlQIQeRG0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--38.419900-10.000000
X-TMASE-Version: IMSVA-9.1.0.1960-8.6.1013-25624.001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-TM-SNTS-SMTP: EB017DEE485AACB0945A6DEDC6141A0BE18502A14170612E8473CAD2D5781F1C2000:8
X-TM-AS-GCONF: 00
X-imss-scan-details: No--38.420-5.0-31-10
X-TMASE-SNAP-Result: 1.821001.0001-0-1-12:0,22:0,33:0,34:0-0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Masami Hiramatsu <mhiramat@kernel.org>
> Sent: Monday, August 24, 2020 11:54 PM
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
> On Mon, 24 Aug 2020 12:02:58 +0000
> "Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com> wrote:
>
> > Greetings!
> >
> > Starting from kernel 5.8 (x86_64), kretprobe handler will always missed=
 if corresponding kprobe on function entry is not optimized
> (using break point instead).
>
> Oops, good catch. I always enabled ftrace hook for kretprobe, I didn't no=
ticed that.
>
> > Step to reproduce this:
> > 1) Build the kretprobe example module (CONFIG_SAMPLE_KRETPROBES=3Dm)
> > 2) Disable jump optimization (`sysctl debug.kprobes-optimization=3D0` o=
r register any kprobe.post_handler at same location)
> > 3) Insert the kretprobe_example module
> > 4) Launch some process to trigger _do_fork
> > 5) Remove kretprobe_example module
> > 6) dmesg shows that all probing instances are missed
> >
> > Example output:
> > # sysctl debug.kprobes-optimization=3D0
> > debug.kprobes-optimization =3D 0
> > # insmod samples/kprobes/kretprobe_example.ko
> > # ls > /dev/null
> > # rmmod kretprobe_example
> > # dmesg
> > [48555.067295] Planted return probe at _do_fork: 0000000038ae0211
> > [48560.229459] kretprobe at 0000000038ae0211 unregistered
> > [48560.229460] Missed probing 3 instances of _do_fork
> >
> > After bisecting, I found this behavior seems to introduce by this commi=
t: (5.8-rc1)
> > 0d00449c7a28a1514595630735df383dec606812 x86: Replace ist_enter() with =
nmi_enter()
> > This make kprobe_int3_handler() effectively running as NMI context, whi=
ch pre_handler_kretprobe() explicitly checked to prevent
> recursion.
>
> Thanks for the bisecting!
>
> >
> > (in_nmi() check appears from v3.17)
> > f96f56780ca584930bb3a2769d73fd9a101bcbbe kprobes: Skip kretprobe hit in=
 NMI context to avoid deadlock
> >
> > To make kretprobe work again with int3 breakpoint, I think we can repla=
ce the in_nmi() check with in_nmi() =3D=3D (1 << NMI_SHIFT) at
> kprobe_int3_handler() and skip kretprobe if nested NMI.
>
> Ah, I see. Now int3 is a kind of NMI, so in the handler in_nmi() always r=
eturns !0.
>
> > Did a quick test on 5.9-rc2 and it seems to be working.
> > I'm not sure if it is the best way to do since it may also require chan=
ge to other architecture as well, any thought?
>
> Hmm, this behavior is arch-dependent. So I think we need an weak function=
 like this.
>
> @kernel/kprobes.c
>
> bool __weak arch_kprobe_in_nmi(void)
> {
>         return in_nmi()
> }
>
> @arch/x86/kernel/kprobes/core.c
>
> bool arch_kprobe_in_nmi(void)
> {
>        /*
>         * Since the int3 is one of NMI, we have to check in_nmi() is
>         * bigger than 1 << NMI_SHIFT instead of !0.
>         */
>        return in_nmi() > (1 << NMI_SHIFT);
> }
>
> And use arch_kprobe_in_nmi() instead of in_nmi() in kprobes.c.
>
> Thanks,
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>

Kretprobe might still trigger from NMI with nmi counter =3D=3D 1 (if entry =
kprobe is jump-optimized).
The arch- dependent weak function looks cleaner than doing this in kprobe_i=
nt3_handler() under x86/, but I don't know if there is a way to check if ca=
lled by specific int3 handler or not.

My original patch below, need to change all architecture support kretprobe =
though

Thanks

---
 arch/x86/kernel/kprobes/core.c |  6 ++++++
 include/linux/kprobes.h        |  1 +
 kernel/kprobes.c               | 13 +------------
 3 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.=
c
index fdadc37d72af..1b785aef85ef 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -699,6 +699,12 @@ int kprobe_int3_handler(struct pt_regs *regs)
 set_current_kprobe(p, regs, kcb);
 kcb->kprobe_status =3D KPROBE_HIT_ACTIVE;

+if (p->pre_handler =3D=3D pre_handler_kretprobe && in_nmi() !=3D (1 << NMI=
_SHIFT)) {
+struct kretprobe *rp =3D container_of(p, struct kretprobe, kp);
+rp->nmissed++;
+setup_singlestep(p, regs, kcb, 0);
+return 1;
+}
 /*
  * If we have no pre-handler or it returned 0, we
  * continue with normal processing.  If we have a
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 9be1bff4f586..3ded8e46ada5 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -494,5 +494,6 @@ static nokprobe_inline bool kprobe_page_fault(struct pt=
_regs *regs,
 return false;
 return kprobe_fault_handler(regs, trap);
 }
+int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs);

 #endif /* _LINUX_KPROBES_H */
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 287b263c9cb9..0f4d61613ded 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1931,23 +1931,12 @@ unsigned long __weak arch_deref_entry_point(void *e=
ntry)
  * This kprobe pre_handler is registered with every kretprobe. When probe
  * hits it will set up the return probe.
  */
-static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
+int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
 {
 struct kretprobe *rp =3D container_of(p, struct kretprobe, kp);
 unsigned long hash, flags =3D 0;
 struct kretprobe_instance *ri;

-/*
- * To avoid deadlocks, prohibit return probing in NMI contexts,
- * just skip the probe and increase the (inexact) 'nmissed'
- * statistical counter, so that the user is informed that
- * something happened:
- */
-if (unlikely(in_nmi())) {
-rp->nmissed++;
-return 0;
-}
-
 /* TODO: consider to only swap the RA after the last pre_handler fired */
 hash =3D hash_ptr(current, KPROBE_HASH_BITS);
 raw_spin_lock_irqsave(&rp->lock, flags);
--
2.17.1

TREND MICRO EMAIL NOTICE

The information contained in this email and any attachments is confidential=
 and may be subject to copyright or other intellectual property protection.=
 If you are not the intended recipient, you are not authorized to use or di=
sclose this information, and we request that you notify us by reply mail or=
 telephone and delete the original message from your mail system.

For details about what personal information we collect and why, please see =
our Privacy Notice on our website at: Read privacy policy<http://www.trendm=
icro.com/privacy>
