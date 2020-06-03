Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E64EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D941420738
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeCYn6pZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgFCLry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 07:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgFCLrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 07:47:51 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377CEC08C5C0;
        Wed,  3 Jun 2020 04:47:50 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id y17so1999671wrn.11;
        Wed, 03 Jun 2020 04:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8yyjDaO/b+3MP+LO9tztKOqPVt2nNrC78Gf79JCQ7+Q=;
        b=KeCYn6pZ0rNcVLm/ig4zWsWuAgfgfQXMVxsAXloca2S4t0ni/U16pdte7iI4p9+enc
         ueF7rOmdZkF1RYUKOB0g2GB2ks0IdCf38U8P31Hj9bRzJo4Z7xqQYY1Erq0YkPGTp46E
         UqO7FvjNoFivV5wckAv3s+4m4zCDXuI/jA4gbphhtFm+CJLgxmGY1l9RMlDyxdJe5dvt
         u1RAF7kAK+1QlwUb/+6ymiqbwOO7SR/3ixEMVUckzME13p/t9qIQWxmteo1E2jQcNTja
         +ikb2TUA11aKTZtKZnYrV181naorK+4dG13FqSeXxVJxnbzqweTWDXWYgOqVNzRFlMIp
         qAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8yyjDaO/b+3MP+LO9tztKOqPVt2nNrC78Gf79JCQ7+Q=;
        b=tQGEUX2bJgSk9stQA1zi7wGOwyZmuAMNE7jXvaodsYun+titb9tC/6jNnDI75szHGr
         C4o1k1Kde+mtw/5OZgePJopM+MCIFGYL0Gjxh7kRklD2vGC+c+v+yTY0U50J2VO93bUQ
         3DnIKk5exmxZygKW7gqLOEvBcd89dKOeCB+ababtzyrn0fwlQXjUIPhT8xT3TjWnya1L
         LT2xasWlGKh7t1bwajJdSKYppGiKqEVq3hgdzAA2XmxQDdkx90SnCLy3oDv+brcdmTWd
         Hm0Pb5pc7tV8U2C2KEqWdB1fHwa6b1uYFYueSWqG0FeOSYNUpyHmoxJIKDCBgDn1wJwK
         4CFg==
X-Gm-Message-State: AOAM531ryhY3IOR6sLaNhoIk4Fc8kAF/3QCzvsqQTfeZems8FA13Bv1D
        XT/gxnUc1IDybBEoj5l1lO8QDcwnL8jbCQNcX0Q=
X-Google-Smtp-Source: ABdhPJwflTwPXjA4P5HUTh5c02UfV6ZCBWlujr3brOF9xdM02IV42Q1K+6j53kRNVCVhPyAYFxlqt/xChpoL/73aNFc=
X-Received: by 2002:adf:e588:: with SMTP id l8mr32932861wrm.255.1591184868713;
 Wed, 03 Jun 2020 04:47:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200521093805.64398-1-chenzhou10@huawei.com> <CAJ2QiJ+1Hj2OQzpR5CfvLGMfTTbXAST94hsbfm0VcDmJKV3WTw@mail.gmail.com>
 <303695cc-d3ea-9f51-1489-07d27d4253d4@oracle.com> <CACi5LpOZzdfEKUYAfYxtgeUbk9K6YFVUKLaGS8XoS0kForjH9A@mail.gmail.com>
 <F64A309C-B9C0-45F2-A50D-D677005C33A6@oracle.com> <CAJ2QiJJE-jeRL1HPUZCwi1LtV9CBMmYrsOaS6vX1R1sJ6Z1t8g@mail.gmail.com>
 <6EA47B07-5119-49DF-9980-12A2066F22CA@oracle.com>
In-Reply-To: <6EA47B07-5119-49DF-9980-12A2066F22CA@oracle.com>
From:   Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
Date:   Wed, 3 Jun 2020 17:17:12 +0530
Message-ID: <CAJ2QiJJhUCnobrMHui5=6zLzgy3KsoPxrqiH_oYT8Jhb5MkmbA@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] support reserving crashkernel above 4G on arm64 kdump
To:     John Donnelly <john.p.donnelly@oracle.com>
Cc:     Bhupesh Sharma <bhsharma@redhat.com>,
        Chen Zhou <chenzhou10@huawei.com>,
        Simon Horman <horms@verge.net.au>,
        Devicetree List <devicetree@vger.kernel.org>,
        Baoquan He <bhe@redhat.com>, Will Deacon <will@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        guohanjun@huawei.com, James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Prabhakar Kushwaha <pkushwaha@marvell.com>,
        RuiRui Yang <dyoung@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen,

On Tue, Jun 2, 2020 at 8:12 PM John Donnelly <john.p.donnelly@oracle.com> w=
rote:
>
>
>
> > On Jun 2, 2020, at 12:38 AM, Prabhakar Kushwaha <prabhakar.pkin@gmail.c=
om> wrote:
> >
> > On Tue, Jun 2, 2020 at 3:29 AM John Donnelly <john.p.donnelly@oracle.co=
m> wrote:
> >>
> >> Hi .  See below !
> >>
> >>> On Jun 1, 2020, at 4:02 PM, Bhupesh Sharma <bhsharma@redhat.com> wrot=
e:
> >>>
> >>> Hi John,
> >>>
> >>> On Tue, Jun 2, 2020 at 1:01 AM John Donnelly <John.P.donnelly@oracle.=
com> wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>>
> >>>> On 6/1/20 7:02 AM, Prabhakar Kushwaha wrote:
> >>>>> Hi Chen,
> >>>>>
> >>>>> On Thu, May 21, 2020 at 3:05 PM Chen Zhou <chenzhou10@huawei.com> w=
rote:
> >>>>>> This patch series enable reserving crashkernel above 4G in arm64.
> >>>>>>
> >>>>>> There are following issues in arm64 kdump:
> >>>>>> 1. We use crashkernel=3DX to reserve crashkernel below 4G, which w=
ill fail
> >>>>>> when there is no enough low memory.
> >>>>>> 2. Currently, crashkernel=3DY@X can be used to reserve crashkernel=
 above 4G,
> >>>>>> in this case, if swiotlb or DMA buffers are required, crash dump k=
ernel
> >>>>>> will boot failure because there is no low memory available for all=
ocation.
> >>>>>>
> >>>>>> To solve these issues, introduce crashkernel=3DX,low to reserve sp=
ecified
> >>>>>> size low memory.
> >>>>>> Crashkernel=3DX tries to reserve memory for the crash dump kernel =
under
> >>>>>> 4G. If crashkernel=3DY,low is specified simultaneously, reserve sp=
cified
> >>>>>> size low memory for crash kdump kernel devices firstly and then re=
serve
> >>>>>> memory above 4G.
> >>>>>>
> >>>>>> When crashkernel is reserved above 4G in memory, that is, crashker=
nel=3DX,low
> >>>>>> is specified simultaneously, kernel should reserve specified size =
low memory
> >>>>>> for crash dump kernel devices. So there may be two crash kernel re=
gions, one
> >>>>>> is below 4G, the other is above 4G.
> >>>>>> In order to distinct from the high region and make no effect to th=
e use of
> >>>>>> kexec-tools, rename the low region as "Crash kernel (low)", and ad=
d DT property
> >>>>>> "linux,low-memory-range" to crash dump kernel's dtb to pass the lo=
w region.
> >>>>>>
> >>>>>> Besides, we need to modify kexec-tools:
> >>>>>> arm64: kdump: add another DT property to crash dump kernel's dtb(s=
ee [1])
> >>>>>>
> >>>>>> The previous changes and discussions can be retrieved from:
> >>>>>>
> >>>>>> Changes since [v7]
> >>>>>> - Move x86 CRASH_ALIGN to 2M
> >>>>>> Suggested by Dave and do some test, move x86 CRASH_ALIGN to 2M.
> >>>>>> - Update Documentation/devicetree/bindings/chosen.txt
> >>>>>> Add corresponding documentation to Documentation/devicetree/bindin=
gs/chosen.txt suggested by Arnd.
> >>>>>> - Add Tested-by from Jhon and pk
> >>>>>>
> >>>>>> Changes since [v6]
> >>>>>> - Fix build errors reported by kbuild test robot.
> >>>>>>
> >>>>>> Changes since [v5]
> >>>>>> - Move reserve_crashkernel_low() into kernel/crash_core.c.
> >>>>>> - Delete crashkernel=3DX,high.
> >>>>>> - Modify crashkernel=3DX,low.
> >>>>>> If crashkernel=3DX,low is specified simultaneously, reserve spcifi=
ed size low
> >>>>>> memory for crash kdump kernel devices firstly and then reserve mem=
ory above 4G.
> >>>>>> In addition, rename crashk_low_res as "Crash kernel (low)" for arm=
64, and then
> >>>>>> pass to crash dump kernel by DT property "linux,low-memory-range".
> >>>>>> - Update Documentation/admin-guide/kdump/kdump.rst.
> >>>>>>
> >>>>>> Changes since [v4]
> >>>>>> - Reimplement memblock_cap_memory_ranges for multiple ranges by Mi=
ke.
> >>>>>>
> >>>>>> Changes since [v3]
> >>>>>> - Add memblock_cap_memory_ranges back for multiple ranges.
> >>>>>> - Fix some compiling warnings.
> >>>>>>
> >>>>>> Changes since [v2]
> >>>>>> - Split patch "arm64: kdump: support reserving crashkernel above 4=
G" as
> >>>>>> two. Put "move reserve_crashkernel_low() into kexec_core.c" in a s=
eparate
> >>>>>> patch.
> >>>>>>
> >>>>>> Changes since [v1]:
> >>>>>> - Move common reserve_crashkernel_low() code into kernel/kexec_cor=
e.c.
> >>>>>> - Remove memblock_cap_memory_ranges() i added in v1 and implement =
that
> >>>>>> in fdt_enforce_memory_region().
> >>>>>> There are at most two crash kernel regions, for two crash kernel r=
egions
> >>>>>> case, we cap the memory range [min(regs[*].start), max(regs[*].end=
)]
> >>>>>> and then remove the memory range in the middle.
> >>>>>>
> >>>>>> [1]: https://urldefense.com/v3/__http://lists.infradead.org/piperm=
ail/kexec/2020-May/025128.html__;!!GqivPVa7Brio!LnTSARkCt0V0FozR0KmqooaH5AD=
tdXvs3mPdP3KRVqALmvSK2VmCkIPIhsaxbvpn1uM1$
> >>>>>> [v1]: https://urldefense.com/v3/__https://lkml.org/lkml/2019/4/2/1=
174__;!!GqivPVa7Brio!LnTSARkCt0V0FozR0KmqooaH5ADtdXvs3mPdP3KRVqALmvSK2VmCkI=
PIhsaxbt0xN9PE$
> >>>>>> [v2]: https://urldefense.com/v3/__https://lkml.org/lkml/2019/4/9/8=
6__;!!GqivPVa7Brio!LnTSARkCt0V0FozR0KmqooaH5ADtdXvs3mPdP3KRVqALmvSK2VmCkIPI=
hsaxbub7yUQH$
> >>>>>> [v3]: https://urldefense.com/v3/__https://lkml.org/lkml/2019/4/9/3=
06__;!!GqivPVa7Brio!LnTSARkCt0V0FozR0KmqooaH5ADtdXvs3mPdP3KRVqALmvSK2VmCkIP=
Ihsaxbnc4zPPV$
> >>>>>> [v4]: https://urldefense.com/v3/__https://lkml.org/lkml/2019/4/15/=
273__;!!GqivPVa7Brio!LnTSARkCt0V0FozR0KmqooaH5ADtdXvs3mPdP3KRVqALmvSK2VmCkI=
PIhsaxbvsAsZLu$
> >>>>>> [v5]: https://urldefense.com/v3/__https://lkml.org/lkml/2019/5/6/1=
360__;!!GqivPVa7Brio!LnTSARkCt0V0FozR0KmqooaH5ADtdXvs3mPdP3KRVqALmvSK2VmCkI=
PIhsaxbl24n-79$
> >>>>>> [v6]: https://urldefense.com/v3/__https://lkml.org/lkml/2019/8/30/=
142__;!!GqivPVa7Brio!LnTSARkCt0V0FozR0KmqooaH5ADtdXvs3mPdP3KRVqALmvSK2VmCkI=
PIhsaxbs7r8G2a$
> >>>>>> [v7]: https://urldefense.com/v3/__https://lkml.org/lkml/2019/12/23=
/411__;!!GqivPVa7Brio!LnTSARkCt0V0FozR0KmqooaH5ADtdXvs3mPdP3KRVqALmvSK2VmCk=
IPIhsaxbiFUH90G$
> >>>>>>
> >>>>>> Chen Zhou (5):
> >>>>>>  x86: kdump: move reserve_crashkernel_low() into crash_core.c
> >>>>>>  arm64: kdump: reserve crashkenel above 4G for crash dump kernel
> >>>>>>  arm64: kdump: add memory for devices by DT property, low-memory-r=
ange
> >>>>>>  kdump: update Documentation about crashkernel on arm64
> >>>>>>  dt-bindings: chosen: Document linux,low-memory-range for arm64 kd=
ump
> >>>>>>
> >>>>> We are getting "warn_alloc" [1] warning during boot of kdump kernel
> >>>>> with bootargs as [2] of primary kernel.
> >>>>> This error observed on ThunderX2  ARM64 platform.
> >>>>>
> >>>>> It is observed with latest upstream tag (v5.7-rc3) with this patch =
set
> >>>>> and https://urldefense.com/v3/__https://lists.infradead.org/piperma=
il/kexec/2020-May/025128.html__;!!GqivPVa7Brio!LnTSARkCt0V0FozR0KmqooaH5ADt=
dXvs3mPdP3KRVqALmvSK2VmCkIPIhsaxbiIAAlzu$
> >>>>> Also **without** this patch-set
> >>>>> "https://urldefense.com/v3/__https://www.spinics.net/lists/arm-kern=
el/msg806882.html__;!!GqivPVa7Brio!LnTSARkCt0V0FozR0KmqooaH5ADtdXvs3mPdP3KR=
VqALmvSK2VmCkIPIhsaxbjC6ujMA$"
> >>>>>
> >>>>> This issue comes whenever crashkernel memory is reserved after 0xc0=
00_0000.
> >>>>> More details discussed earlier in
> >>>>> https://urldefense.com/v3/__https://www.spinics.net/lists/arm-kerne=
l/msg806882.html__;!!GqivPVa7Brio!LnTSARkCt0V0FozR0KmqooaH5ADtdXvs3mPdP3KRV=
qALmvSK2VmCkIPIhsaxbjC6ujMA$  without any
> >>>>> solution
> >>>>>
> >>>>> This patch-set is expected to solve similar kind of issue.
> >>>>> i.e. low memory is only targeted for DMA, swiotlb; So above mention=
ed
> >>>>> observation should be considered/fixed. .
> >>>>>
> >>>>> --pk
> >>>>>
> >>>>> [1]
> >>>>> [   30.366695] DMI: Cavium Inc. Saber/Saber, BIOS
> >>>>> TX2-FW-Release-3.1-build_01-2803-g74253a541a mm/dd/yyyy
> >>>>> [   30.367696] NET: Registered protocol family 16
> >>>>> [   30.369973] swapper/0: page allocation failure: order:6,
> >>>>> mode:0x1(GFP_DMA), nodemask=3D(null),cpuset=3D/,mems_allowed=3D0
> >>>>> [   30.369980] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.7.0-rc3+=
 #121
> >>>>> [   30.369981] Hardware name: Cavium Inc. Saber/Saber, BIOS
> >>>>> TX2-FW-Release-3.1-build_01-2803-g74253a541a mm/dd/yyyy
> >>>>> [   30.369984] Call trace:
> >>>>> [   30.369989]  dump_backtrace+0x0/0x1f8
> >>>>> [   30.369991]  show_stack+0x20/0x30
> >>>>> [   30.369997]  dump_stack+0xc0/0x10c
> >>>>> [   30.370001]  warn_alloc+0x10c/0x178
> >>>>> [   30.370004]  __alloc_pages_slowpath.constprop.111+0xb10/0xb50
> >>>>> [   30.370006]  __alloc_pages_nodemask+0x2b4/0x300
> >>>>> [   30.370008]  alloc_page_interleave+0x24/0x98
> >>>>> [   30.370011]  alloc_pages_current+0xe4/0x108
> >>>>> [   30.370017]  dma_atomic_pool_init+0x44/0x1a4
> >>>>> [   30.370020]  do_one_initcall+0x54/0x228
> >>>>> [   30.370027]  kernel_init_freeable+0x228/0x2cc
> >>>>> [   30.370031]  kernel_init+0x1c/0x110
> >>>>> [   30.370034]  ret_from_fork+0x10/0x18
> >>>>> [   30.370036] Mem-Info:
> >>>>> [   30.370064] active_anon:0 inactive_anon:0 isolated_anon:0
> >>>>> [   30.370064]  active_file:0 inactive_file:0 isolated_file:0
> >>>>> [   30.370064]  unevictable:0 dirty:0 writeback:0 unstable:0
> >>>>> [   30.370064]  slab_reclaimable:34 slab_unreclaimable:4438
> >>>>> [   30.370064]  mapped:0 shmem:0 pagetables:14 bounce:0
> >>>>> [   30.370064]  free:1537719 free_pcp:219 free_cma:0
> >>>>> [   30.370070] Node 0 active_anon:0kB inactive_anon:0kB
> >>>>> active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0k=
B
> >>>>> isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB
> >>>>> shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB
> >>>>> unstable:0kB all_unreclaimable? no
> >>>>> [   30.370073] Node 1 active_anon:0kB inactive_anon:0kB
> >>>>> active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0k=
B
> >>>>> isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB
> >>>>> shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB
> >>>>> unstable:0kB all_unreclaimable? no
> >>>>> [   30.370079] Node 0 DMA free:0kB min:0kB low:0kB high:0kB
> >>>>> reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB
> >>>>> active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB
> >>>>> present:128kB managed:0kB mlocked:0kB kernel_stack:0kB pagetables:0=
kB
> >>>>> bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> >>>>> [   30.370084] lowmem_reserve[]: 0 250 6063 6063
> >>>>> [   30.370090] Node 0 DMA32 free:256000kB min:408kB low:664kB
> >>>>> high:920kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0k=
B
> >>>>> active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB
> >>>>> present:269700kB managed:256000kB mlocked:0kB kernel_stack:0kB
> >>>>> pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> >>>>> [   30.370094] lowmem_reserve[]: 0 0 5813 5813
> >>>>> [   30.370100] Node 0 Normal free:5894876kB min:9552kB low:15504kB
> >>>>> high:21456kB reserved_highatomic:0KB active_anon:0kB inactive_anon:=
0kB
> >>>>> active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB
> >>>>> present:8388608kB managed:5953112kB mlocked:0kB kernel_stack:21672k=
B
> >>>>> pagetables:56kB bounce:0kB free_pcp:876kB local_pcp:176kB free_cma:=
0kB
> >>>>> [   30.370104] lowmem_reserve[]: 0 0 0 0
> >>>>> [   30.370107] Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB
> >>>>> 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 0kB
> >>>>> [   30.370113] Node 0 DMA32: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128=
kB
> >>>>> 0*256kB 0*512kB 0*1024kB 1*2048kB (M) 62*4096kB (M) =3D 256000kB
> >>>>> [   30.370119] Node 0 Normal: 2*4kB (M) 3*8kB (ME) 2*16kB (UE) 3*32=
kB
> >>>>> (UM) 1*64kB (U) 2*128kB (M) 2*256kB (ME) 3*512kB (ME) 3*1024kB (ME)
> >>>>> 3*2048kB (UME) 1436*4096kB (M) =3D 5893600kB
> >>>>> [   30.370129] Node 0 hugepages_total=3D0 hugepages_free=3D0
> >>>>> hugepages_surp=3D0 hugepages_size=3D1048576kB
> >>>>> [   30.370130] 0 total pagecache pages
> >>>>> [   30.370132] 0 pages in swap cache
> >>>>> [   30.370134] Swap cache stats: add 0, delete 0, find 0/0
> >>>>> [   30.370135] Free swap  =3D 0kB
> >>>>> [   30.370136] Total swap =3D 0kB
> >>>>> [   30.370137] 2164609 pages RAM
> >>>>> [   30.370139] 0 pages HighMem/MovableOnly
> >>>>> [   30.370140] 612331 pages reserved
> >>>>> [   30.370141] 0 pages hwpoisoned
> >>>>> [   30.370143] DMA: failed to allocate 256 KiB pool for atomic
> >>>>> coherent allocation
> >>>>
> >>>>
> >>>> During my testing I saw the same error and Chen's  solution correcte=
d it .
> >>>
> >>> Which combination you are using on your side? I am using Prabhakar's
> >>> suggested environment and can reproduce the issue
> >>> with or without Chen's crashkernel support above 4G patchset.
> >>>
> >>> I am also using a ThunderX2 platform with latest makedumpfile code an=
d
> >>> kexec-tools (with the suggested patch
> >>> <https://urldefense.com/v3/__https://lists.infradead.org/pipermail/ke=
xec/2020-May/025128.html__;!!GqivPVa7Brio!J6lUig58-Gw6TKZnEEYzEeSU36T-1SqlB=
1kImU00xtX_lss5Tx-JbUmLE9TJC3foXBLg$ >).
> >>>
> >>> Thanks,
> >>> Bhupesh
> >>
> >>
> >> I did this activity 5 months ago and I have moved on to other activiti=
es. My DMA failures were related to PCI devices that could not be enumerate=
d because  low-DMA space was not  available when crashkernel was moved abov=
e 4G; I don=E2=80=99t recall the exact platform.
> >>
> >>
> >>
> >> For this failure ,
> >>
> >>>>> DMA: failed to allocate 256 KiB pool for atomic
> >>>>> coherent allocation
> >>
> >>
> >> Is due to :
> >>
> >>
> >> 3618082c
> >> ("arm64 use both ZONE_DMA and ZONE_DMA32")
> >>
> >> With the introduction of ZONE_DMA to support the Raspberry DMA
> >> region below 1G, the crashkernel is placed in the upper 4G
> >> ZONE_DMA_32 region. Since the crashkernel does not have access
> >> to the ZONE_DMA region, it prints out call trace during bootup.
> >>
> >> It is due to having this CONFIG item  ON  :
> >>
> >>
> >> CONFIG_ZONE_DMA=3Dy
> >>
> >> Turning off ZONE_DMA fixes a issue and Raspberry PI 4 will
> >> use the device tree to specify memory below 1G.
> >>
> >>
> >
> > Disabling ZONE_DMA is temporary solution.  We may need proper solution
>
>
> Perhaps the Raspberry platform configuration dependencies need separated =
 from =E2=80=9Cserver class=E2=80=9D Arm  equipment ?  Or auto-configured o=
n boot ?  Consult an expert ;-)
>
>
>
> >
> >> I would like to see Chen=E2=80=99s feature added , perhaps as EXPERIME=
NTAL,  so we can get some configuration testing done on it.   It corrects h=
aving a DMA zone in low memory while crash-kernel is above 4GB.  This has b=
een going on for a year now.
> >
> > I will also like this patch to be added in Linux as early as possible.
> >
> > Issue mentioned by me happens with or without this patch.
> >
> > This patch-set can consider fixing because it uses low memory for DMA
> > & swiotlb only.
> > We can consider restricting crashkernel within the required range like =
below
> >
> > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > index 7f9e5a6dc48c..bd67b90d35bd 100644
> > --- a/kernel/crash_core.c
> > +++ b/kernel/crash_core.c
> > @@ -354,7 +354,7 @@ int __init reserve_crashkernel_low(void)
> >                        return 0;
> >        }
> >
> > -       low_base =3D memblock_find_in_range(0, 1ULL << 32, low_size, CR=
ASH_ALIGN);
> > +       low_base =3D memblock_find_in_range(0,0xc0000000, low_size, CRA=
SH_ALIGN);
> >        if (!low_base) {
> >                pr_err("Cannot reserve %ldMB crashkernel low memory,
> > please try smaller size.\n",
> >                       (unsigned long)(low_size >> 20));
> >
> >
>
>     I suspect  0xc0000000  would need to be a CONFIG item  and not hard-c=
oded.
>

if you consider this as valid change,  can you please incorporate as
part of your patch-set.

--pk.
