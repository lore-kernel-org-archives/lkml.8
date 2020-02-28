Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A97C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346A12469D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CSks3nTL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgB1Phb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:37:31 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33721 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbgB1Pha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:37:30 -0500
Received: by mail-lf1-f66.google.com with SMTP id n25so2442129lfl.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 07:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jsMr9PwKlV6hW2UfKrEYvfLWZEkA/BrzzXQ84+cmBfs=;
        b=CSks3nTLUD+1I5uLlRFpeISkekru7BSipMbiSksgun3E3cQWZog+W6OL2bMRWC2ysW
         WLqr4p4cJPX6ILTJHanToZosS38KYXSs8PqupZ1tw0L4YSNOF2Gkh2laWxYm4yocZzJg
         /g4q+VRN2zGqyxz9A7doZN1p5Tb3yC5pgeMwTGkjiUVYjZeB1i6ho1oZ4Fy7RYXfcdv4
         OdXVLAZVQwITJ+JHfZE7R+roZCxlFlbocmcdVfZHrXoRoOSNNLMgD/NijKuiPrN+gik7
         XoJ8qzRReHW9q9l/b0hLY6jWB7w5FKw7kF7h8MOxvZc9mP2KnmosxMldW86+fpmPJCCS
         xF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jsMr9PwKlV6hW2UfKrEYvfLWZEkA/BrzzXQ84+cmBfs=;
        b=WkgwghibkSASq960QYTsEJkoMPbSk7AnyfFX4dEOEu8NE3q/x5xEQUkxQ7iVQKKNwC
         ztJT1Ql2cpdaui00DBFnDqDYg10NGfCoSvNFehsZ95wasaNIlDs2Kq33MB3RsW9XIgkO
         VcKP969e17pWew36WRRdDbjhU42nsVHP0GSG7yHbOCPmc/JVNlk7Xxh3imo+h61mCqQ4
         9vvQVWjBkmVK7LqZoVEFXHn7aUYZ6nBS+qhIserP/JKRjLh1COT9QCaA11h2TWL4DJJt
         4+S44xGRrzUnQxctrazQSvLKj5E0YxXJaPACi/GJa+p0/uZdPhXuKO/65UID7fjZ+tc/
         TaEg==
X-Gm-Message-State: ANhLgQ2MoGOPdFpGjYj5Klx0+7wq3dgFEb+X2Y3QEbyza71v60yySxcF
        52uvQ6+3wvDKW6jbM7Fwj6MqBeiJihrEaO2M7NpdCPMSEOc=
X-Google-Smtp-Source: ADFU+vtiAzkhGvQgec+BRaWXMJ4Zh67JGKr9jY/HlmYwlW+LVtLVVCrWJeIzkufc+K2JB4jNab2Dw6zJqSx9MvDfkuw=
X-Received: by 2002:a19:4a08:: with SMTP id x8mr3012548lfa.133.1582904247628;
 Fri, 28 Feb 2020 07:37:27 -0800 (PST)
MIME-Version: 1.0
References: <ace7327f-0fd6-4f36-39ae-a8d7d1c7f06b@de.ibm.com>
 <afacbbd1-3d6b-c537-34e2-5b455e1c2267@de.ibm.com> <CAKfTPtBikHzpHY-NdRJFfOFxx+S3=4Y0aPM5s0jpHs40+9BaGA@mail.gmail.com>
 <b073a50e-4b86-56db-3fbd-6869b2716b34@de.ibm.com> <1a607a98-f12a-77bd-2062-c3e599614331@de.ibm.com>
In-Reply-To: <1a607a98-f12a-77bd-2062-c3e599614331@de.ibm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 28 Feb 2020 16:37:16 +0100
Message-ID: <CAKfTPtBZ2X8i6zMgrA1gNJmwoSnyRc76yXmLZEwboJmF-R9QVg@mail.gmail.com>
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

On Fri, 28 Feb 2020 at 16:08, Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
>
> Also happened with 5.4:
> Seems that I just happen to have an interesting test workload/system size=
 interaction
> on a newly installed system that triggers this.

you will probably go back to 5.1 which is the version where we put
back the deletion of unused cfs_rq from the list which can trigger the
warning:
commit 039ae8bcf7a5 : (Fix O(nr_cgroups) in the load balancing path)

AFAICT, we haven't changed this since

>
>
> [ 9761.439278] ------------[ cut here ]------------
> [ 9761.439283] rq->tmp_alone_branch !=3D &rq->leaf_cfs_rq_list
> [ 9761.439300] WARNING: CPU: 58 PID: 17405 at kernel/sched/fair.c:381 enq=
ueue_task_fair+0x7cc/0x9b0
> [ 9761.439303] Modules linked in: kvm xt_CHECKSUM xt_MASQUERADE nf_nat_tf=
tp nf_conntrack_tftp xt_CT tun bridge stp llc xt_tcpudp ip6t_REJECT nf_reje=
ct_ipv6 ip6t_rpfilter ipt_REJECT nf_reject_ipv4 xt_conntrack ip6table_nat i=
p6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat iptable_ma=
ngle iptable_raw iptable_security nf_conntrack nf_defrag_ipv6 nf_defrag_ipv=
4 ip_set nfnetlink ip6table_filter ip6_tables iptable_filter rpcrdma sunrpc=
 rdma_ucm rdma_cm iw_cm ib_cm configfs s390_trng ghash_s390 prng mlx5_ib ae=
s_s390 ib_uverbs des_s390 libdes ib_core sha3_512_s390 sha3_256_s390 sha512=
_s390 genwqe_card sha1_s390 crc_itu_t vfio_ccw vfio_mdev mdev vfio_iommu_ty=
pe1 eadm_sch vfio zcrypt_cex4 sch_fq_codel ip_tables x_tables mlx5_core sha=
256_s390 sha_common pkey zcrypt rng_core autofs4
> [ 9761.439335] CPU: 58 PID: 17405 Comm: sh Not tainted 5.4.0 #27
> [ 9761.439336] Hardware name: IBM 3906 M04 704 (LPAR)
> [ 9761.439338] Krnl PSW : 0404c00180000000 00000007353f2d4c (enqueue_task=
_fair+0x7cc/0x9b0)
> [ 9761.439340]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:0 P=
M:0 RI:0 EA:3
> [ 9761.439342] Krnl GPRS: 00000000000003e0 0400000735f500bc 0000000000000=
02d 00000007365f4bc2
> [ 9761.439343]            000000000000002c 0000000735a49388 0000000000000=
001 0400001f00000000
> [ 9761.439344]            000003e0015ebc88 0000001fbd856c00 0000001fbd856=
d00 0000000000000000
> [ 9761.439345]            0000001bc8a12000 0000000735d853c0 00000007353f2=
d48 000003e0015ebad0
> [ 9761.439385] Krnl Code: 00000007353f2d3c: c020005ae9c0        larl    %=
r2,735f500bc
>                           00000007353f2d42: c0e5fffdc487        brasl   %=
r14,7353ab650
>                          #00000007353f2d48: a7f40001            brc     1=
5,7353f2d4a
>                          >00000007353f2d4c: a7f4fcda            brc     1=
5,7353f2700
>                           00000007353f2d50: e33073480004        lg      %=
r3,840(%r7)
>                           00000007353f2d56: 41b07340            la      %=
r11,832(%r7)
>                           00000007353f2d5a: b9040063            lgr     %=
r6,%r3
>                           00000007353f2d5e: b904004b            lgr     %=
r4,%r11
> [ 9761.439397] Call Trace:
> [ 9761.439399] ([<00000007353f2d48>] enqueue_task_fair+0x7c8/0x9b0)
> [ 9761.439401]  [<00000007353e1b48>] activate_task+0x88/0xf0
> [ 9761.439403]  [<00000007353e20c6>] ttwu_do_activate+0x56/0x80
> [ 9761.439405]  [<00000007353e3106>] try_to_wake_up+0x256/0x650
> [ 9761.439408]  [<000000073540353e>] swake_up_locked.part.0+0x2e/0x70
> [ 9761.439409]  [<0000000735403764>] swake_up_one+0x54/0x90
> [ 9761.439449]  [<000003ff8047be52>] kvm_vcpu_wake_up+0x52/0x80 [kvm]
> [ 9761.439458]  [<000003ff80498e3a>] kvm_s390_vcpu_wakeup+0x2a/0x40 [kvm]
> [ 9761.439466]  [<000003ff8049959e>] kvm_s390_idle_wakeup+0x6e/0xa0 [kvm]
> [ 9761.439470]  [<000000073544acb4>] __hrtimer_run_queues+0x114/0x2f0
> [ 9761.439472]  [<000000073544b97c>] hrtimer_interrupt+0x12c/0x2b0
> [ 9761.439475]  [<0000000735370a1a>] do_IRQ+0xaa/0xb0
> [ 9761.439480]  [<0000000735d75998>] ext_int_handler+0x128/0x12c
> [ 9761.439485]  [<00000007355abd28>] get_page_from_freelist+0x528/0x1860
> [ 9761.439486] ([<00000007355abc36>] get_page_from_freelist+0x436/0x1860)
> [ 9761.439488]  [<00000007355ae420>] __alloc_pages_nodemask+0x120/0x320
> [ 9761.439492]  [<00000007355cca8a>] alloc_pages_vma+0x9a/0x280
> [ 9761.439494]  [<0000000735588062>] wp_page_copy+0xb2/0x730
> [ 9761.439495]  [<000000073558b642>] do_wp_page+0xa2/0x760
> [ 9761.439497]  [<000000073558def2>] __handle_mm_fault+0x852/0x910
> [ 9761.439498]  [<000000073558e076>] handle_mm_fault+0xc6/0x180
> [ 9761.439500]  [<0000000735389c44>] do_protection_exception+0x164/0x4b0
> [ 9761.439502]  [<0000000735d7558c>] pgm_check_handler+0x1c8/0x220
> [ 9761.439502] Last Breaking-Event-Address:
> [ 9761.439503]  [<00000007353f2d48>] enqueue_task_fair+0x7c8/0x9b0
> [ 9761.439504] ---[ end trace 40ea9b5f62b01ed1 ]---
>
