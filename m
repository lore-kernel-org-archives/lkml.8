Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A39C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 489282469D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KsYtsoPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgB1Ncw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:32:52 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37997 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgB1Ncv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 08:32:51 -0500
Received: by mail-lf1-f68.google.com with SMTP id w22so1102255lfk.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 05:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PunA6AUK9cJGI3B2uIEL1v/3settudK+J/D27AJP2p8=;
        b=KsYtsoPTSK49sgG9sfQp+xP5YzLk8MIBliWazEsfyfyMjgOPGlBxSJnyGEbGKW3UlP
         TPeBGoL+o5FzJNAqS/5erWL9bgYHRywPCmfjjJ/Kc6lJQr3qz0YHoHC5cBM7VmTabTCd
         DwkyX9667g97qL5OsN+t0P4CFex0+S4KeuX9/3n2g5psJ7XBaBpoyuHxQ2JQEp7BwW2L
         IN9zBfB5dpf8HJq7SFN23cIlM06UvTRx5y0cf9J+VqWIaQoYdzvSGTr7vmgK/Mdze2by
         AiaM6DLRTJGpGiOdLuox3mFim/NZcilWB0s0lHAen6StXSzZyQBOJngIyY27qyMBIyTm
         Dwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PunA6AUK9cJGI3B2uIEL1v/3settudK+J/D27AJP2p8=;
        b=irrdaB8xq2t3+9NgwUahL7gfb+4O9owYH/00PJ2KO0Tu+dWi/TLmBQclZF4K3HfQgA
         2zw1CqDYqxLwM4GKWdVikw6D2kf4vlLOpgv8RG3zDczqNmvU0U1S6xpLLxDq/dGKEpfp
         Gk/5pJ2VIPljsVSdnEcKVlmw5BLzKMVegyS392JGMGkEoTQ7y91czMFQYC9JYSi9PrBL
         x2L8j05GGk5y/cUn/T2+MXw2pUx4uSGmVOK5p780iItB+MFNhhJOR5FFR2z/hYhBUMhJ
         KfBjvbYevyjYRuBRcfh+XJxZKb3r5NGdPE0BddQDoY6eFqfmW0iWDhrrD7xoXJdBI1wc
         Sdhw==
X-Gm-Message-State: ANhLgQ1FpsdfMmX7/Gpc8gLoJ44Qjrw60kkiQrDw4O/ogrj/9bKMpq3U
        oLlqIt32ttYDeOZw5SFJ+oedPTSvRqwL0hd6BYnPkA==
X-Google-Smtp-Source: ADFU+vsliWQrj7zIasG5Uc2LwuRr0lv2BkeHZfFUaSZhtsCGYWriCPj4ZOeSlh/qShGkDZSYdhMXq85thsE7Azho7WA=
X-Received: by 2002:ac2:596d:: with SMTP id h13mr2695022lfp.190.1582896767762;
 Fri, 28 Feb 2020 05:32:47 -0800 (PST)
MIME-Version: 1.0
References: <ace7327f-0fd6-4f36-39ae-a8d7d1c7f06b@de.ibm.com> <afacbbd1-3d6b-c537-34e2-5b455e1c2267@de.ibm.com>
In-Reply-To: <afacbbd1-3d6b-c537-34e2-5b455e1c2267@de.ibm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 28 Feb 2020 14:32:36 +0100
Message-ID: <CAKfTPtBikHzpHY-NdRJFfOFxx+S3=4Y0aPM5s0jpHs40+9BaGA@mail.gmail.com>
Subject: Re: 5.6-rc3: WARNING: CPU: 48 PID: 17435 at kernel/sched/fair.c:380 enqueue_task_fair+0x328/0x440
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Feb 2020 at 13:04, Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
>
> I was able to reproduce this with 5.5.0

This might even be earlier as there weren't any changes on this area recent=
ly

Do you have more details about your setup ? Are you using cgroup
bandwidth an an example ?


>
>
> On 28.02.20 08:54, Christian Borntraeger wrote:
> > Peter,
> >
> > it seems that your new assert did trigger for me:
> >
> > The system was running fine for 4 hours and then this happened.
> > Unfortunately I have no idea if this reproduces and if so how.
> >
> > [15260.753944] ------------[ cut here ]------------
> > [15260.753949] rq->tmp_alone_branch !=3D &rq->leaf_cfs_rq_list
> > [15260.753959] WARNING: CPU: 48 PID: 17435 at kernel/sched/fair.c:380 e=
nqueue_task_fair+0x328/0x440
> > [15260.753961] Modules linked in: kvm xt_CHECKSUM xt_MASQUERADE nf_nat_=
tftp nf_conntrack_tftp xt_CT tun bridge stp llc xt_tcpudp ip6t_REJECT nf_re=
ject_ipv6 ip6t_rpfilter ipt_REJECT nf_reject_ipv4 xt_conntrack ip6table_nat=
 ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat iptable_=
mangle iptable_raw iptable_security nf_conntrack nf_defrag_ipv6 nf_defrag_i=
pv4 ip_set nfnetlink ip6table_filter ip6_tables iptable_filter rpcrdma sunr=
pc rdma_ucm rdma_cm iw_cm ib_cm configfs s390_trng mlx5_ib ghash_s390 prng =
ib_uverbs aes_s390 ib_core des_s390 libdes sha3_512_s390 genwqe_card vfio_c=
cw vfio_mdev sha3_256_s390 mdev crc_itu_t sha512_s390 vfio_iommu_type1 sha1=
_s390 vfio eadm_sch zcrypt_cex4 sch_fq_codel ip_tables x_tables mlx5_core s=
ha256_s390 sha_common pkey zcrypt rng_core autofs4
> > [15260.754002] CPU: 48 PID: 17435 Comm: cc1 Not tainted 5.6.0-rc3+ #24
> > [15260.754004] Hardware name: IBM 3906 M04 704 (LPAR)
> > [15260.754005] Krnl PSW : 0404c00180000000 0000000942282e3c (enqueue_ta=
sk_fair+0x32c/0x440)
> > [15260.754008]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:0=
 PM:0 RI:0 EA:3
> > [15260.754010] Krnl GPRS: 00000000000003e0 0000001fbd60ee00 00000000000=
0002d 00000009435347c2
> > [15260.754012]            000000000000002c 00000009428ec950 00000009000=
00000 0000000000000001
> > [15260.754013]            0000001fbd60ed00 0000001fbd60ed00 0000001fbd6=
0ee00 0000000000000000
> > [15260.754014]            0000001c633ea000 0000000942c34670 00000009422=
82e38 000003e00140baf8
> > [15260.754066] Krnl Code: 0000000942282e2c: c020005d39d8      larl    %=
r2,0000000942e2a1dc
> >                           0000000942282e32: c0e5fffdcc3f      brasl   %=
r14,000000094223c6b0
> >                          #0000000942282e38: af000000          mc      0=
,0
> >                          >0000000942282e3c: a7f4ff22          brc     1=
5,0000000942282c80
> >                           0000000942282e40: 41b06340          la      %=
r11,832(%r6)
> >                           0000000942282e44: e3d063480004      lg      %=
r13,840(%r6)
> >                           0000000942282e4a: b904004b          lgr     %=
r4,%r11
> >                           0000000942282e4e: b904003d          lgr     %=
r3,%r13
> > [15260.754080] Call Trace:
> > [15260.754083]  [<0000000942282e3c>] enqueue_task_fair+0x32c/0x440
> > [15260.754085] ([<0000000942282e38>] enqueue_task_fair+0x328/0x440)
> > [15260.754087]  [<0000000942272d78>] activate_task+0x88/0xf0
> > [15260.754088]  [<00000009422732e8>] ttwu_do_activate+0x58/0x78
> > [15260.754090]  [<00000009422742ce>] try_to_wake_up+0x256/0x650
> > [15260.754093]  [<000000094229248e>] swake_up_locked.part.0+0x2e/0x70
> > [15260.754095]  [<00000009422927ac>] swake_up_one+0x54/0x88
> > [15260.754151]  [<000003ff8044c15a>] kvm_vcpu_wake_up+0x52/0x78 [kvm]
> > [15260.754161]  [<000003ff8046af02>] kvm_s390_vcpu_wakeup+0x2a/0x40 [kv=
m]
> > [15260.754171]  [<000003ff8046b68e>] kvm_s390_idle_wakeup+0x6e/0xa0 [kv=
m]
> > [15260.754175]  [<00000009422dd05c>] __hrtimer_run_queues+0x114/0x2f0
> > [15260.754178]  [<00000009422dddb4>] hrtimer_interrupt+0x12c/0x2a8
> > [15260.754181]  [<0000000942200d3c>] do_IRQ+0xac/0xb0
> > [15260.754185]  [<0000000942c25684>] ext_int_handler+0x130/0x134
> > [15260.754186] Last Breaking-Event-Address:
> > [15260.754189]  [<000000094223c710>] __warn_printk+0x60/0x68
> > [15260.754190] ---[ end trace e84a48be72a8b514 ]---
> >
>
