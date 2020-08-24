Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAB2C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC2D220838
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=trendmicro.com header.i=@trendmicro.com header.b="f4nkMAP2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgHXQSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 12:18:33 -0400
Received: from sjdcvmout02.udc.trendmicro.com ([66.180.82.11]:36446 "EHLO
        sjdcvmout02.udc.trendmicro.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725947AbgHXQSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 12:18:30 -0400
Received: from sjdcvmout02.udc.trendmicro.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5BCB764138;
        Mon, 24 Aug 2020 09:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=trendmicro.com;
        s=tmoutbound; t=1598285909;
        bh=2nVRUjnFHIHu1xztXsTP8QJ38S4NA6lKNT9m4xvIcts=; h=From:To:Date;
        b=f4nkMAP2Ykq034OJ6x//XUpg9LBDl0Fi01fipNhcBKFpSpbaqgjHzhtKRHI7M8LMu
         HVIpvPqWEwVrxBR3b/olA0NZkhCC8SrMoPuQIWJ6aCgG6xyq7DzlU9iAkUorxlkUBG
         LgbJgOiwfNFCXlshHYsL7EWsZdJ5UXZTa2v9ENas=
Received: from sjdcvmout02.udc.trendmicro.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4EDA964130;
        Mon, 24 Aug 2020 09:18:29 -0700 (PDT)
Received: from SJDC-EXNABU02.us.trendnet.org (unknown [10.45.175.98])
        by sjdcvmout02.udc.trendmicro.com (Postfix) with ESMTPS;
        Mon, 24 Aug 2020 09:18:29 -0700 (PDT)
Received: from ADC-EXAPAC12.tw.trendnet.org (10.28.2.229) by
 SJDC-EXNABU02.us.trendnet.org (10.45.175.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1979.3; Mon, 24 Aug 2020 09:18:28 -0700
Received: from ADC-EXAPAC11.tw.trendnet.org (10.28.2.228) by
 ADC-EXAPAC12.tw.trendnet.org (10.28.2.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1979.3; Mon, 24 Aug 2020 16:18:26 +0000
Received: from ADC-EXAPAC11.tw.trendnet.org ([fe80::e9de:ebb1:bcf0:5913]) by
 ADC-EXAPAC11.tw.trendnet.org ([fe80::e9de:ebb1:bcf0:5913%18]) with mapi id
 15.01.1979.003; Mon, 24 Aug 2020 16:18:26 +0000
From:   "Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Masami Hiramatsu <mhiramat@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: RE: x86/kprobes: kretprobe fails to triggered if kprobe at function
 entry is not optimized (trigger by int3 breakpoint)
Thread-Topic: x86/kprobes: kretprobe fails to triggered if kprobe at function
 entry is not optimized (trigger by int3 breakpoint)
Thread-Index: AdZ5/y9ucVi7Kf0NSwa8vnc6Q/ol0wAIbHKAAAJItrA=
Date:   Mon, 24 Aug 2020 16:18:26 +0000
Message-ID: <9ad9a770de884a45be1fc20d58559c63@trendmicro.com>
References: <8816bdbbc55c4d2397e0b02aad2825d3@trendmicro.com>
 <20200824141429.GA3982@worktop.programming.kicks-ass.net>
In-Reply-To: <20200824141429.GA3982@worktop.programming.kicks-ass.net>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.28.4.6]
X-TM-AS-Product-Ver: IMSVA-9.1.0.1960-8.6.0.1013-25624.001
X-TM-AS-Result: No--38.245-5.0-31-10
X-TMASE-MatchedRID: AGI6IuWlRrrUL3YCMmnG4vHkpkyUphL9Ud7Bjfo+5jTw9qL6KtqraENf
        BZcEsxYNzs6CJTbJG4Phz2FFF3n+pBJ49ZBgqflrlVHM/F6YkvSTnpV+S7Y80XaucMF8JglMnVt
        gvxMdrIMxa/5NSyylo1vsExJdwcaGdghCgcSLH6r/Te3t5cJMGyY6ALX8FNLOgOlK2zN496m/IN
        05VFzhe/uBAQFQ9xUBfIPceilDx+VBxk0KgEGnjyhJ5tvbfbyLcJuzZ/5RoVYBlDj6sccc9+zn6
        eE2grwnFbUgcXdD3THX6cuSGZUoH/Elb/MQoiaz0H8ihGEHNUfjZVW6jxrCoiuGKh4AkqKVQBzo
        PKhLashk1QMds9nkrZn71czlKWUsKJj5KNt9CBuCCtrY06jaLbzETYfYS4xZVWQnHKxp38gi/Xm
        IrdQH6Gz2ktDX1ee2/byIu6KDdyKiN61W1OfKwaEhJ1MFZG4p6HigDLMyLuaXbcZfsC7t1Ja5p7
        +rhqhx0VKPb3kkU5W88rM0HBKhmlP3I2ELpBKChQwmwdAU7bIHgh3sKJBzP/yQXCBzKijhlUcxG
        fWk0G3hEoMMfDhvOuxeaIGweo11L3vAnkncsWmtBybNxXyi/HHv4qNcyiZV0oZ3TtkkYiovq8gZ
        Q6OEO3rB/EX0Zo5QzLb2wizLvKYJ2oMC12kj6aSaWLOeEVFWiVpgBTlcQW3c9KE2iwgwHsFy0tC
        5DwmoXVPMY/qHE/qkcfSwgrPEELcPoq9kz4iKAkW6JTMS9Izedb5F0QMS/NZd/DOmlnxISB+g0L
        +JM1DrcFn67wIg3bAlI/LikmeekfRhdidsajP+xOhjarOnHmgVPcrOkeoT1GcRAJRT6PP3FLeZX
        NZS4LU+KYi1qWO6ftwZ3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--38.244600-10.000000
X-TMASE-Version: IMSVA-9.1.0.1960-8.6.1013-25624.001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-TM-SNTS-SMTP: BEDA607B9AACD5835D1668190977EA77FC2A05BF9376F4D4BBBF29E1DB1F08D72000:8
X-TM-AS-GCONF: 00
X-imss-scan-details: No--38.245-5.0-31-10
X-TMASE-SNAP-Result: 1.821001.0001-0-1-12:0,22:0,33:0,34:0-0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Peter Zijlstra <peterz@infradead.org>
> Sent: Monday, August 24, 2020 10:14 PM
> To: Eddy Wu <Eddy_Wu@trendmicro.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>; linux-kernel@vger.kernel.org;=
 x86@kernel.org; David S. Miller <davem@davemloft.net>
> Subject: Re: x86/kprobes: kretprobe fails to triggered if kprobe at funct=
ion entry is not optimized (trigger by int3 breakpoint)
>
> On Mon, Aug 24, 2020 at 12:02:58PM +0000, Eddy_Wu@trendmicro.com wrote:
> > After bisecting, I found this behavior seems to introduce by this
> > commit: (5.8-rc1) 0d00449c7a28a1514595630735df383dec606812 x86:
> > Replace ist_enter() with nmi_enter() This make kprobe_int3_handler()
> > effectively running as NMI context, which pre_handler_kretprobe()
> > explicitly checked to prevent recursion.
> >
> > (in_nmi() check appears from v3.17)
> > f96f56780ca584930bb3a2769d73fd9a101bcbbe kprobes: Skip kretprobe hit
> > in NMI context to avoid deadlock
> >
> > To make kretprobe work again with int3 breakpoint, I think we can
> > replace the in_nmi() check with in_nmi() =3D=3D (1 << NMI_SHIFT) at
> > kprobe_int3_handler() and skip kretprobe if nested NMI.  Did a quick
> > test on 5.9-rc2 and it seems to be working.  I'm not sure if it is the
> > best way to do since it may also require change to other architecture
> > as well, any thought?
>
> Masami, would it be possible to have a kretprobe specific recursion
> count here?
>
> I did the below, but i'm not at all sure that isn't horrible broken. I
> can't really find many rp->lock sites and this might break things by
> limiting contention.
>
> ---
>
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index 9be1bff4f586..0bff314cc800 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -153,6 +153,7 @@ struct kretprobe {
>         size_t data_size;
>         struct hlist_head free_instances;
>         raw_spinlock_t lock;
> +       atomic_t recursion;
>  };
>
>  struct kretprobe_instance {
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 287b263c9cb9..27fd096bcb9a 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1934,22 +1934,17 @@ unsigned long __weak arch_deref_entry_point(void =
*entry)
>  static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
>  {
>         struct kretprobe *rp =3D container_of(p, struct kretprobe, kp);
> -       unsigned long hash, flags =3D 0;
>         struct kretprobe_instance *ri;
> -
> -       /*
> -        * To avoid deadlocks, prohibit return probing in NMI contexts,
> -        * just skip the probe and increase the (inexact) 'nmissed'
> -        * statistical counter, so that the user is informed that
> -        * something happened:
> -        */
> -       if (unlikely(in_nmi())) {
> -               rp->nmissed++;
> -               return 0;
> -       }
> +       unsigned long hash, flags;
> +       int rec;
>
>         /* TODO: consider to only swap the RA after the last pre_handler =
fired */
>         hash =3D hash_ptr(current, KPROBE_HASH_BITS);
> +       rec =3D atomic_fetch_inc_acquire(&rp->recursion);
> +       if (rec) {
> +               rp->nmissed++;
> +               goto out;
> +       }
>         raw_spin_lock_irqsave(&rp->lock, flags);
>         if (!hlist_empty(&rp->free_instances)) {
>                 ri =3D hlist_entry(rp->free_instances.first,
> @@ -1964,7 +1959,7 @@ static int pre_handler_kretprobe(struct kprobe *p, =
struct pt_regs *regs)
>                         raw_spin_lock_irqsave(&rp->lock, flags);
>                         hlist_add_head(&ri->hlist, &rp->free_instances);
>                         raw_spin_unlock_irqrestore(&rp->lock, flags);
> -                       return 0;
> +                       goto out;
>                 }
>
>                 arch_prepare_kretprobe(ri, regs);
> @@ -1978,6 +1973,8 @@ static int pre_handler_kretprobe(struct kprobe *p, =
struct pt_regs *regs)
>                 rp->nmissed++;
>                 raw_spin_unlock_irqrestore(&rp->lock, flags);
>         }
> +out:
> +       atomic_dec(&rp->recursion);
>         return 0;
>  }
>  NOKPROBE_SYMBOL(pre_handler_kretprobe);
>
I think kprobe_int3_handler() already prevented pre_handler_kretprobe() fro=
m recursing, we need to protect critical section in recycle_rp_inst() that =
might be interrupt by NMI.
There is another kretprobe_table_lock has other call site maybe be interrup=
t by NMI too
TREND MICRO EMAIL NOTICE

The information contained in this email and any attachments is confidential=
 and may be subject to copyright or other intellectual property protection.=
 If you are not the intended recipient, you are not authorized to use or di=
sclose this information, and we request that you notify us by reply mail or=
 telephone and delete the original message from your mail system.

For details about what personal information we collect and why, please see =
our Privacy Notice on our website at: Read privacy policy<http://www.trendm=
icro.com/privacy>
