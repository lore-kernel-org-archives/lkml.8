Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6191EC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 19:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38EEA20734
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 19:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UbMGy8Pt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgFCTrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 15:47:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35393 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725985AbgFCTrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 15:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591213649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MpiPTiZE4QKP6LGRxdgsc2DNZHl5BTlPB8Z9SBWQ1V8=;
        b=UbMGy8PtAEjprmtdhcgVNxehSiuWSscyyKwSvtjXJlA2D9n3vyTnXdKE9wc1njNzvfx8/o
        3hujiprWEBPkQD/8xnKHf05aRv5AFKwMovgE/VLp6pSM39BzF3RTQnj+NSGuXTBCD/GjJF
        q4ssGgvdrSCxcF6ySFO3/tWCpmNhdDc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-kU_y6cE6M2-MNP8IVTt5iw-1; Wed, 03 Jun 2020 15:47:21 -0400
X-MC-Unique: kU_y6cE6M2-MNP8IVTt5iw-1
Received: by mail-qv1-f72.google.com with SMTP id t20so2483993qvy.16
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 12:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MpiPTiZE4QKP6LGRxdgsc2DNZHl5BTlPB8Z9SBWQ1V8=;
        b=Dqt5iscYbi2YRY6/cs1Ot0dyKIwZ48zqc7IqivrTj9yfhQohq7A9qq5JaVHNmfDHg8
         ohZv9CLNTJVs5X3vffpMqGpn3bfabFGI1ZIHPAcV6fLIBeGa34wxOvYx+BXOm/RT4Mhq
         0mtwlknLD0BX2YCmqpm7isoLLjM2bSaePlSnYT0bWytK0WcUYiDMxr2jzwmo5Y9QkDUQ
         4POcGYF7nzIF5p69sjKwxi+0VpCXppXPS+3N4QvT0iUozWF+JLbbKvwwe8nr/EgRKt0F
         TxCkz2pnHI+k8Wb2JvtohIONXVG1KFFi0BcVWhFhXXybjwV1d4K/eG+4+kAAit45UEIx
         9lyA==
X-Gm-Message-State: AOAM530zeDXH4hsi0nbPItGl9ADSRH8G8g41+wU5leMlI6/fgBmrD0Fn
        ynELoKyNzFKem9cSDQuhyNKvZznl8In06P2AsE4nihK7kUs9YwZmBUWOvOrtIsA1wfyAK3mdg/Z
        9nA8jjGRU99dJ2gu7xVjuiFZNGPBkyAAog/UhIvXb
X-Received: by 2002:aed:2d44:: with SMTP id h62mr1027614qtd.167.1591213640536;
        Wed, 03 Jun 2020 12:47:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1Io1aYd8IlFBCtau1L5drogfSTHZcw8fgoyzbdNnIk9SmSkewQ442qi8Pp7FEqs5YJBjc4zyfQsZo9A24+1A=
X-Received: by 2002:aed:2d44:: with SMTP id h62mr1027568qtd.167.1591213640117;
 Wed, 03 Jun 2020 12:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200521093805.64398-1-chenzhou10@huawei.com> <CAJ2QiJ+1Hj2OQzpR5CfvLGMfTTbXAST94hsbfm0VcDmJKV3WTw@mail.gmail.com>
 <303695cc-d3ea-9f51-1489-07d27d4253d4@oracle.com> <CACi5LpOZzdfEKUYAfYxtgeUbk9K6YFVUKLaGS8XoS0kForjH9A@mail.gmail.com>
 <F64A309C-B9C0-45F2-A50D-D677005C33A6@oracle.com> <CAJ2QiJJE-jeRL1HPUZCwi1LtV9CBMmYrsOaS6vX1R1sJ6Z1t8g@mail.gmail.com>
 <6EA47B07-5119-49DF-9980-12A2066F22CA@oracle.com> <CAJ2QiJJhUCnobrMHui5=6zLzgy3KsoPxrqiH_oYT8Jhb5MkmbA@mail.gmail.com>
 <8463464e-5461-f328-621c-bacc6a3b88dd@huawei.com> <8E0D45DC-12BF-437D-A342-03E974D9C6D4@oracle.com>
In-Reply-To: <8E0D45DC-12BF-437D-A342-03E974D9C6D4@oracle.com>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Thu, 4 Jun 2020 01:17:06 +0530
Message-ID: <CACi5LpN-+NRnaDoWWWidbzma8BNzmofA5FQBV=cPF1Mc84FpFg@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] support reserving crashkernel above 4G on arm64 kdump
To:     John Donnelly <john.p.donnelly@oracle.com>
Cc:     chenzhou <chenzhou10@huawei.com>,
        Simon Horman <horms@verge.net.au>,
        Devicetree List <devicetree@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Baoquan He <bhe@redhat.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        guohanjun@huawei.com,
        kexec mailing list <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        James Morse <james.morse@arm.com>, nsaenzjulienne@suse.de,
        Prabhakar Kushwaha <prabhakar.pkin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Prabhakar Kushwaha <pkushwaha@marvell.com>,
        RuiRui Yang <dyoung@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On Wed, Jun 3, 2020 at 9:03 PM John Donnelly <john.p.donnelly@oracle.com> w=
rote:
>
>
>
> > On Jun 3, 2020, at 8:20 AM, chenzhou <chenzhou10@huawei.com> wrote:
> >
> > Hi,
> >
> >
> > On 2020/6/3 19:47, Prabhakar Kushwaha wrote:
> >> Hi Chen,
> >>
> >> On Tue, Jun 2, 2020 at 8:12 PM John Donnelly <john.p.donnelly@oracle.c=
om> wrote:
> >>>
> >>>
> >>>> On Jun 2, 2020, at 12:38 AM, Prabhakar Kushwaha <prabhakar.pkin@gmai=
l.com> wrote:
> >>>>
> >>>> On Tue, Jun 2, 2020 at 3:29 AM John Donnelly <john.p.donnelly@oracle=
.com> wrote:
> >>>>> Hi .  See below !
> >>>>>
> >>>>>> On Jun 1, 2020, at 4:02 PM, Bhupesh Sharma <bhsharma@redhat.com> w=
rote:
> >>>>>>
> >>>>>> Hi John,
> >>>>>>
> >>>>>> On Tue, Jun 2, 2020 at 1:01 AM John Donnelly <John.P.donnelly@orac=
le.com> wrote:
> >>>>>>> Hi,
> >>>>>>>
> >>>>>>>
> >>>>>>> On 6/1/20 7:02 AM, Prabhakar Kushwaha wrote:
> >>>>>>>> Hi Chen,
> >>>>>>>>
> >>>>>>>> On Thu, May 21, 2020 at 3:05 PM Chen Zhou <chenzhou10@huawei.com=
> wrote:
> >>>>>>>>> This patch series enable reserving crashkernel above 4G in arm6=
4.
> >>>>>>>>>
> >>>>>>>>> There are following issues in arm64 kdump:
> >>>>>>>>> 1. We use crashkernel=3DX to reserve crashkernel below 4G, whic=
h will fail
> >>>>>>>>> when there is no enough low memory.
> >>>>>>>>> 2. Currently, crashkernel=3DY@X can be used to reserve crashker=
nel above 4G,
> >>>>>>>>> in this case, if swiotlb or DMA buffers are required, crash dum=
p kernel
> >>>>>>>>> will boot failure because there is no low memory available for =
allocation.
> >>>>>>>>>
> >>>>>>>> We are getting "warn_alloc" [1] warning during boot of kdump ker=
nel
> >>>>>>>> with bootargs as [2] of primary kernel.
> >>>>>>>> This error observed on ThunderX2  ARM64 platform.
> >>>>>>>>
> >>>>>>>> It is observed with latest upstream tag (v5.7-rc3) with this pat=
ch set
> >>>>>>>> and https://urldefense.com/v3/__https://lists.infradead.org/pipe=
rmail/kexec/2020-May/025128.html__;!!GqivPVa7Brio!LnTSARkCt0V0FozR0KmqooaH5=
ADtdXvs3mPdP3KRVqALmvSK2VmCkIPIhsaxbiIAAlzu$
> >>>>>>>> Also **without** this patch-set
> >>>>>>>> "https://urldefense.com/v3/__https://www.spinics.net/lists/arm-k=
ernel/msg806882.html__;!!GqivPVa7Brio!LnTSARkCt0V0FozR0KmqooaH5ADtdXvs3mPdP=
3KRVqALmvSK2VmCkIPIhsaxbjC6ujMA$"
> >>>>>>>>
> >>>>>>>> This issue comes whenever crashkernel memory is reserved after 0=
xc000_0000.
> >>>>>>>> More details discussed earlier in
> >>>>>>>> https://urldefense.com/v3/__https://www.spinics.net/lists/arm-ke=
rnel/msg806882.html__;!!GqivPVa7Brio!LnTSARkCt0V0FozR0KmqooaH5ADtdXvs3mPdP3=
KRVqALmvSK2VmCkIPIhsaxbjC6ujMA$  without any
> >>>>>>>> solution
> >>>>>>>>
> >>>>>>>> This patch-set is expected to solve similar kind of issue.
> >>>>>>>> i.e. low memory is only targeted for DMA, swiotlb; So above ment=
ioned
> >>>>>>>> observation should be considered/fixed. .
> >>>>>>>>
> >>>>>>>> --pk
> >>>>>>>>
> >>>>>>>> [1]
> >>>>>>>> [   30.366695] DMI: Cavium Inc. Saber/Saber, BIOS
> >>>>>>>> TX2-FW-Release-3.1-build_01-2803-g74253a541a mm/dd/yyyy
> >>>>>>>> [   30.367696] NET: Registered protocol family 16
> >>>>>>>> [   30.369973] swapper/0: page allocation failure: order:6,
> >>>>>>>> mode:0x1(GFP_DMA), nodemask=3D(null),cpuset=3D/,mems_allowed=3D0
> >>>>>>>> [   30.369980] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.7.0-r=
c3+ #121
> >>>>>>>> [   30.369981] Hardware name: Cavium Inc. Saber/Saber, BIOS
> >>>>>>>> TX2-FW-Release-3.1-build_01-2803-g74253a541a mm/dd/yyyy
> >>>>>>>> [   30.369984] Call trace:
> >>>>>>>> [   30.369989]  dump_backtrace+0x0/0x1f8
> >>>>>>>> [   30.369991]  show_stack+0x20/0x30
> >>>>>>>> [   30.369997]  dump_stack+0xc0/0x10c
> >>>>>>>> [   30.370001]  warn_alloc+0x10c/0x178
> >>>>>>>> [   30.370004]  __alloc_pages_slowpath.constprop.111+0xb10/0xb50
> >>>>>>>> [   30.370006]  __alloc_pages_nodemask+0x2b4/0x300
> >>>>>>>> [   30.370008]  alloc_page_interleave+0x24/0x98
> >>>>>>>> [   30.370011]  alloc_pages_current+0xe4/0x108
> >>>>>>>> [   30.370017]  dma_atomic_pool_init+0x44/0x1a4
> >>>>>>>> [   30.370020]  do_one_initcall+0x54/0x228
> >>>>>>>> [   30.370027]  kernel_init_freeable+0x228/0x2cc
> >>>>>>>> [   30.370031]  kernel_init+0x1c/0x110
> >>>>>>>> [   30.370034]  ret_from_fork+0x10/0x18
> >>>>>>>> [   30.370036] Mem-Info:
> >>>>>>>> [   30.370064] active_anon:0 inactive_anon:0 isolated_anon:0
> >>>>>>>> [   30.370064]  active_file:0 inactive_file:0 isolated_file:0
> >>>>>>>> [   30.370064]  unevictable:0 dirty:0 writeback:0 unstable:0
> >>>>>>>> [   30.370064]  slab_reclaimable:34 slab_unreclaimable:4438
> >>>>>>>> [   30.370064]  mapped:0 shmem:0 pagetables:14 bounce:0
> >>>>>>>> [   30.370064]  free:1537719 free_pcp:219 free_cma:0
> >>>>>>>> [   30.370070] Node 0 active_anon:0kB inactive_anon:0kB
> >>>>>>>> active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon)=
:0kB
> >>>>>>>> isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB
> >>>>>>>> shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:=
0kB
> >>>>>>>> unstable:0kB all_unreclaimable? no
> >>>>>>>> [   30.370073] Node 1 active_anon:0kB inactive_anon:0kB
> >>>>>>>> active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon)=
:0kB
> >>>>>>>> isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB
> >>>>>>>> shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:=
0kB
> >>>>>>>> unstable:0kB all_unreclaimable? no
> >>>>>>>> [   30.370079] Node 0 DMA free:0kB min:0kB low:0kB high:0kB
> >>>>>>>> reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB
> >>>>>>>> active_file:0kB inactive_file:0kB unevictable:0kB writepending:0=
kB
> >>>>>>>> present:128kB managed:0kB mlocked:0kB kernel_stack:0kB pagetable=
s:0kB
> >>>>>>>> bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> >>>>>>>> [   30.370084] lowmem_reserve[]: 0 250 6063 6063
> >>>>>>>> [   30.370090] Node 0 DMA32 free:256000kB min:408kB low:664kB
> >>>>>>>> high:920kB reserved_highatomic:0KB active_anon:0kB inactive_anon=
:0kB
> >>>>>>>> active_file:0kB inactive_file:0kB unevictable:0kB writepending:0=
kB
> >>>>>>>> present:269700kB managed:256000kB mlocked:0kB kernel_stack:0kB
> >>>>>>>> pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0k=
B
> >>>>>>>> [   30.370094] lowmem_reserve[]: 0 0 5813 5813
> >>>>>>>> [   30.370100] Node 0 Normal free:5894876kB min:9552kB low:15504=
kB
> >>>>>>>> high:21456kB reserved_highatomic:0KB active_anon:0kB inactive_an=
on:0kB
> >>>>>>>> active_file:0kB inactive_file:0kB unevictable:0kB writepending:0=
kB
> >>>>>>>> present:8388608kB managed:5953112kB mlocked:0kB kernel_stack:216=
72kB
> >>>>>>>> pagetables:56kB bounce:0kB free_pcp:876kB local_pcp:176kB free_c=
ma:0kB
> >>>>>>>> [   30.370104] lowmem_reserve[]: 0 0 0 0
> >>>>>>>> [   30.370107] Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*12=
8kB
> >>>>>>>> 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 0kB
> >>>>>>>> [   30.370113] Node 0 DMA32: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*=
128kB
> >>>>>>>> 0*256kB 0*512kB 0*1024kB 1*2048kB (M) 62*4096kB (M) =3D 256000kB
> >>>>>>>> [   30.370119] Node 0 Normal: 2*4kB (M) 3*8kB (ME) 2*16kB (UE) 3=
*32kB
> >>>>>>>> (UM) 1*64kB (U) 2*128kB (M) 2*256kB (ME) 3*512kB (ME) 3*1024kB (=
ME)
> >>>>>>>> 3*2048kB (UME) 1436*4096kB (M) =3D 5893600kB
> >>>>>>>> [   30.370129] Node 0 hugepages_total=3D0 hugepages_free=3D0
> >>>>>>>> hugepages_surp=3D0 hugepages_size=3D1048576kB
> >>>>>>>> [   30.370130] 0 total pagecache pages
> >>>>>>>> [   30.370132] 0 pages in swap cache
> >>>>>>>> [   30.370134] Swap cache stats: add 0, delete 0, find 0/0
> >>>>>>>> [   30.370135] Free swap  =3D 0kB
> >>>>>>>> [   30.370136] Total swap =3D 0kB
> >>>>>>>> [   30.370137] 2164609 pages RAM
> >>>>>>>> [   30.370139] 0 pages HighMem/MovableOnly
> >>>>>>>> [   30.370140] 612331 pages reserved
> >>>>>>>> [   30.370141] 0 pages hwpoisoned
> >>>>>>>> [   30.370143] DMA: failed to allocate 256 KiB pool for atomic
> >>>>>>>> coherent allocation
> >>>>>>>
> >>>>>>> During my testing I saw the same error and Chen's  solution corre=
cted it .
> >>>>>> Which combination you are using on your side? I am using Prabhakar=
's
> >>>>>> suggested environment and can reproduce the issue
> >>>>>> with or without Chen's crashkernel support above 4G patchset.
> >>>>>>
> >>>>>> I am also using a ThunderX2 platform with latest makedumpfile code=
 and
> >>>>>> kexec-tools (with the suggested patch
> >>>>>> <https://urldefense.com/v3/__https://lists.infradead.org/pipermail=
/kexec/2020-May/025128.html__;!!GqivPVa7Brio!J6lUig58-Gw6TKZnEEYzEeSU36T-1S=
qlB1kImU00xtX_lss5Tx-JbUmLE9TJC3foXBLg$ >).
> >>>>>>
> >>>>>> Thanks,
> >>>>>> Bhupesh
> >>>>>
> >>>>> I did this activity 5 months ago and I have moved on to other activ=
ities. My DMA failures were related to PCI devices that could not be enumer=
ated because  low-DMA space was not  available when crashkernel was moved a=
bove 4G; I don=E2=80=99t recall the exact platform.
> >>>>>
> >>>>>
> >>>>>
> >>>>> For this failure ,
> >>>>>
> >>>>>>>> DMA: failed to allocate 256 KiB pool for atomic
> >>>>>>>> coherent allocation
> >>>>>
> >>>>> Is due to :
> >>>>>
> >>>>>
> >>>>> 3618082c
> >>>>> ("arm64 use both ZONE_DMA and ZONE_DMA32")
> >>>>>
> >>>>> With the introduction of ZONE_DMA to support the Raspberry DMA
> >>>>> region below 1G, the crashkernel is placed in the upper 4G
> >>>>> ZONE_DMA_32 region. Since the crashkernel does not have access
> >>>>> to the ZONE_DMA region, it prints out call trace during bootup.
> >>>>>
> >>>>> It is due to having this CONFIG item  ON  :
> >>>>>
> >>>>>
> >>>>> CONFIG_ZONE_DMA=3Dy
> >>>>>
> >>>>> Turning off ZONE_DMA fixes a issue and Raspberry PI 4 will
> >>>>> use the device tree to specify memory below 1G.
> >>>>>
> >>>>>
> >>>> Disabling ZONE_DMA is temporary solution.  We may need proper soluti=
on
> >>>
> >>> Perhaps the Raspberry platform configuration dependencies need separa=
ted  from =E2=80=9Cserver class=E2=80=9D Arm  equipment ?  Or auto-configur=
ed on boot ?  Consult an expert ;-)
> >>>
> >>>
> >>>
> >>>>> I would like to see Chen=E2=80=99s feature added , perhaps as EXPER=
IMENTAL,  so we can get some configuration testing done on it.   It correct=
s having a DMA zone in low memory while crash-kernel is above 4GB.  This ha=
s been going on for a year now.
> >>>> I will also like this patch to be added in Linux as early as possibl=
e.
> >>>>
> >>>> Issue mentioned by me happens with or without this patch.
> >>>>
> >>>> This patch-set can consider fixing because it uses low memory for DM=
A
> >>>> & swiotlb only.
> >>>> We can consider restricting crashkernel within the required range li=
ke below
> >>>>
> >>>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> >>>> index 7f9e5a6dc48c..bd67b90d35bd 100644
> >>>> --- a/kernel/crash_core.c
> >>>> +++ b/kernel/crash_core.c
> >>>> @@ -354,7 +354,7 @@ int __init reserve_crashkernel_low(void)
> >>>>                       return 0;
> >>>>       }
> >>>>
> >>>> -       low_base =3D memblock_find_in_range(0, 1ULL << 32, low_size,=
 CRASH_ALIGN);
> >>>> +       low_base =3D memblock_find_in_range(0,0xc0000000, low_size, =
CRASH_ALIGN);
> >>>>       if (!low_base) {
> >>>>               pr_err("Cannot reserve %ldMB crashkernel low memory,
> >>>> please try smaller size.\n",
> >>>>                      (unsigned long)(low_size >> 20));
> >>>>
> >>>>
> >>>    I suspect  0xc0000000  would need to be a CONFIG item  and not har=
d-coded.
> >>>
> >> if you consider this as valid change,  can you please incorporate as
> >> part of your patch-set.
> >
> > After commit 1a8e1cef7 ("arm64: use both ZONE_DMA and ZONE_DMA32")=EF=
=BC=8Cthe 0-4G memory is splited
> > to DMA [mem 0x0000000000000000-0x000000003fffffff] and DMA32 [mem 0x000=
0000040000000-0x00000000ffffffff] on arm64.
> >
> > From the above discussion, on your platform, the low crashkernel fall i=
n DMA32 region, but your environment needs to access DMA
> > region, so there is the call trace.
> >
> > I have a question, why do you choose 0xc0000000 here?
> >
> > Besides, this is common code, we also need to consider about x86.
> >
>
>  + nsaenzjulienne@suse.de
>
>   Exactly .  This is why it needs to be a CONFIG option for  Raspberry ..=
,  or device tree option.
>
>
>   We could revert 1a8e1cef7 since it broke  Arm kdump too.

Well, unfortunately the patch for commit 1a8e1cef7603 ("arm64: use
both ZONE_DMA and ZONE_DMA32") was not Cc'ed to the kexec mailing
list, thus we couldn't get many eyes on it for a thorough review from
kexec/kdump p-o-v.

Also we historically never had distinction in common arch code on the
basis of the intended end use-case: embedded, server or automotive, so
I am not sure introducing a Raspberry specific CONFIG option would be
a good idea.

So, rather than reverting the patch, we can look at addressing the
same properly this time - especially from a kdump p-o-v.
This issue has been reported by some Red Hat arm64 partners with
upstream kernel also and as we have noticed in the past as well,
hardcoding the placement of the crashkernel base address (unless the
base address is specified by a crashkernel=3DX@Y like bootargs) is also
not a portable suggestion.

I am working on a possible fix and will have more updates on the same
in a day-or-two.

Thanks,
Bhupesh

