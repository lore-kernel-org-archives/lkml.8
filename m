Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B18C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22F372068D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EH0abBKq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgFBOmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 10:42:53 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35192 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgFBOmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 10:42:52 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052EfvdT009136;
        Tue, 2 Jun 2020 14:42:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=f27y03fv745c02yIbYexRAAwPCBiWvLJPcvvXS3z+xM=;
 b=EH0abBKqZG1gX4ZmZVAkyesz9yZtGV/Wxw+m8+aVic6drI2msG3P3lWpaymd+PGaLLin
 Js91irIvCtJJCH8Jb2BYC0nQyQsrbJCOTEoBIIjLMb9PBhj0a20r69IyI5sPxrXZGRDX
 CwZhHmWoblfiPbn7cH6Rnp35fbOR3L38RfTtjuNSOUYb9zmtN2vK93BEPyFBVDhNAsjK
 Io8dMBxCHZq0pIaZ1x+9Eldka0ks9kKAAz/gm5+QtGc1uL39wOzR40FyRkneU96Qdc2g
 F13UHMwD2v4fwSTnVicwjGX4ghqWPwHDfI8m0uI1ZcQoFkOo3GZLE8jDfgY3041XDAdF 3w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 31bewqvfwm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 02 Jun 2020 14:42:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052EXHBY038281;
        Tue, 2 Jun 2020 14:42:09 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 31c1dxbhwn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jun 2020 14:42:09 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 052Eg0sC006406;
        Tue, 2 Jun 2020 14:42:00 GMT
Received: from dhcp-10-154-181-125.vpn.oracle.com (/10.154.181.125)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Jun 2020 07:42:00 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v8 0/5] support reserving crashkernel above 4G on arm64
 kdump
From:   John Donnelly <john.p.donnelly@oracle.com>
In-Reply-To: <CAJ2QiJJE-jeRL1HPUZCwi1LtV9CBMmYrsOaS6vX1R1sJ6Z1t8g@mail.gmail.com>
Date:   Tue, 2 Jun 2020 09:41:58 -0500
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
Content-Transfer-Encoding: quoted-printable
Message-Id: <6EA47B07-5119-49DF-9980-12A2066F22CA@oracle.com>
References: <20200521093805.64398-1-chenzhou10@huawei.com>
 <CAJ2QiJ+1Hj2OQzpR5CfvLGMfTTbXAST94hsbfm0VcDmJKV3WTw@mail.gmail.com>
 <303695cc-d3ea-9f51-1489-07d27d4253d4@oracle.com>
 <CACi5LpOZzdfEKUYAfYxtgeUbk9K6YFVUKLaGS8XoS0kForjH9A@mail.gmail.com>
 <F64A309C-B9C0-45F2-A50D-D677005C33A6@oracle.com>
 <CAJ2QiJJE-jeRL1HPUZCwi1LtV9CBMmYrsOaS6vX1R1sJ6Z1t8g@mail.gmail.com>
To:     Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
X-Mailer: Apple Mail (2.3445.9.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=1 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006020104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 bulkscore=0
 phishscore=0 suspectscore=1 impostorscore=0 cotscore=-2147483648
 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006020105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 2, 2020, at 12:38 AM, Prabhakar Kushwaha =
<prabhakar.pkin@gmail.com> wrote:
>=20
> On Tue, Jun 2, 2020 at 3:29 AM John Donnelly =
<john.p.donnelly@oracle.com> wrote:
>>=20
>> Hi .  See below !
>>=20
>>> On Jun 1, 2020, at 4:02 PM, Bhupesh Sharma <bhsharma@redhat.com> =
wrote:
>>>=20
>>> Hi John,
>>>=20
>>> On Tue, Jun 2, 2020 at 1:01 AM John Donnelly =
<John.P.donnelly@oracle.com> wrote:
>>>>=20
>>>> Hi,
>>>>=20
>>>>=20
>>>> On 6/1/20 7:02 AM, Prabhakar Kushwaha wrote:
>>>>> Hi Chen,
>>>>>=20
>>>>> On Thu, May 21, 2020 at 3:05 PM Chen Zhou <chenzhou10@huawei.com> =
wrote:
>>>>>> This patch series enable reserving crashkernel above 4G in arm64.
>>>>>>=20
>>>>>> There are following issues in arm64 kdump:
>>>>>> 1. We use crashkernel=3DX to reserve crashkernel below 4G, which =
will fail
>>>>>> when there is no enough low memory.
>>>>>> 2. Currently, crashkernel=3DY@X can be used to reserve =
crashkernel above 4G,
>>>>>> in this case, if swiotlb or DMA buffers are required, crash dump =
kernel
>>>>>> will boot failure because there is no low memory available for =
allocation.
>>>>>>=20
>>>>>> To solve these issues, introduce crashkernel=3DX,low to reserve =
specified
>>>>>> size low memory.
>>>>>> Crashkernel=3DX tries to reserve memory for the crash dump kernel =
under
>>>>>> 4G. If crashkernel=3DY,low is specified simultaneously, reserve =
spcified
>>>>>> size low memory for crash kdump kernel devices firstly and then =
reserve
>>>>>> memory above 4G.
>>>>>>=20
>>>>>> When crashkernel is reserved above 4G in memory, that is, =
crashkernel=3DX,low
>>>>>> is specified simultaneously, kernel should reserve specified size =
low memory
>>>>>> for crash dump kernel devices. So there may be two crash kernel =
regions, one
>>>>>> is below 4G, the other is above 4G.
>>>>>> In order to distinct from the high region and make no effect to =
the use of
>>>>>> kexec-tools, rename the low region as "Crash kernel (low)", and =
add DT property
>>>>>> "linux,low-memory-range" to crash dump kernel's dtb to pass the =
low region.
>>>>>>=20
>>>>>> Besides, we need to modify kexec-tools:
>>>>>> arm64: kdump: add another DT property to crash dump kernel's =
dtb(see [1])
>>>>>>=20
>>>>>> The previous changes and discussions can be retrieved from:
>>>>>>=20
>>>>>> Changes since [v7]
>>>>>> - Move x86 CRASH_ALIGN to 2M
>>>>>> Suggested by Dave and do some test, move x86 CRASH_ALIGN to 2M.
>>>>>> - Update Documentation/devicetree/bindings/chosen.txt
>>>>>> Add corresponding documentation to =
Documentation/devicetree/bindings/chosen.txt suggested by Arnd.
>>>>>> - Add Tested-by from Jhon and pk
>>>>>>=20
>>>>>> Changes since [v6]
>>>>>> - Fix build errors reported by kbuild test robot.
>>>>>>=20
>>>>>> Changes since [v5]
>>>>>> - Move reserve_crashkernel_low() into kernel/crash_core.c.
>>>>>> - Delete crashkernel=3DX,high.
>>>>>> - Modify crashkernel=3DX,low.
>>>>>> If crashkernel=3DX,low is specified simultaneously, reserve =
spcified size low
>>>>>> memory for crash kdump kernel devices firstly and then reserve =
memory above 4G.
>>>>>> In addition, rename crashk_low_res as "Crash kernel (low)" for =
arm64, and then
>>>>>> pass to crash dump kernel by DT property =
"linux,low-memory-range".
>>>>>> - Update Documentation/admin-guide/kdump/kdump.rst.
>>>>>>=20
>>>>>> Changes since [v4]
>>>>>> - Reimplement memblock_cap_memory_ranges for multiple ranges by =
Mike.
>>>>>>=20
>>>>>> Changes since [v3]
>>>>>> - Add memblock_cap_memory_ranges back for multiple ranges.
>>>>>> - Fix some compiling warnings.
>>>>>>=20
>>>>>> Changes since [v2]
>>>>>> - Split patch "arm64: kdump: support reserving crashkernel above =
4G" as
>>>>>> two. Put "move reserve_crashkernel_low() into kexec_core.c" in a =
separate
>>>>>> patch.
>>>>>>=20
>>>>>> Changes since [v1]:
>>>>>> - Move common reserve_crashkernel_low() code into =
kernel/kexec_core.c.
>>>>>> - Remove memblock_cap_memory_ranges() i added in v1 and implement =
that
>>>>>> in fdt_enforce_memory_region().
>>>>>> There are at most two crash kernel regions, for two crash kernel =
regions
>>>>>> case, we cap the memory range [min(regs[*].start), =
max(regs[*].end)]
>>>>>> and then remove the memory range in the middle.
>>>>>>=20
>>>>>> [1]: =
https://urldefense.com/v3/__http://lists.infradead.org/pipermail/kexec/202=
0-May/025128.html__;!!GqivPVa7Brio!LnTSARkCt0V0FozR0KmqooaH5ADtdXvs3mPdP3K=
RVqALmvSK2VmCkIPIhsaxbvpn1uM1$
>>>>>> [v1]: =
https://urldefense.com/v3/__https://lkml.org/lkml/2019/4/2/1174__;!!GqivPV=
a7Brio!LnTSARkCt0V0FozR0KmqooaH5ADtdXvs3mPdP3KRVqALmvSK2VmCkIPIhsaxbt0xN9P=
E$
>>>>>> [v2]: =
https://urldefense.com/v3/__https://lkml.org/lkml/2019/4/9/86__;!!GqivPVa7=
Brio!LnTSARkCt0V0FozR0KmqooaH5ADtdXvs3mPdP3KRVqALmvSK2VmCkIPIhsaxbub7yUQH$=

>>>>>> [v3]: =
https://urldefense.com/v3/__https://lkml.org/lkml/2019/4/9/306__;!!GqivPVa=
7Brio!LnTSARkCt0V0FozR0KmqooaH5ADtdXvs3mPdP3KRVqALmvSK2VmCkIPIhsaxbnc4zPPV=
$
>>>>>> [v4]: =
https://urldefense.com/v3/__https://lkml.org/lkml/2019/4/15/273__;!!GqivPV=
a7Brio!LnTSARkCt0V0FozR0KmqooaH5ADtdXvs3mPdP3KRVqALmvSK2VmCkIPIhsaxbvsAsZL=
u$
>>>>>> [v5]: =
https://urldefense.com/v3/__https://lkml.org/lkml/2019/5/6/1360__;!!GqivPV=
a7Brio!LnTSARkCt0V0FozR0KmqooaH5ADtdXvs3mPdP3KRVqALmvSK2VmCkIPIhsaxbl24n-7=
9$
>>>>>> [v6]: =
https://urldefense.com/v3/__https://lkml.org/lkml/2019/8/30/142__;!!GqivPV=
a7Brio!LnTSARkCt0V0FozR0KmqooaH5ADtdXvs3mPdP3KRVqALmvSK2VmCkIPIhsaxbs7r8G2=
a$
>>>>>> [v7]: =
https://urldefense.com/v3/__https://lkml.org/lkml/2019/12/23/411__;!!GqivP=
Va7Brio!LnTSARkCt0V0FozR0KmqooaH5ADtdXvs3mPdP3KRVqALmvSK2VmCkIPIhsaxbiFUH9=
0G$
>>>>>>=20
>>>>>> Chen Zhou (5):
>>>>>>  x86: kdump: move reserve_crashkernel_low() into crash_core.c
>>>>>>  arm64: kdump: reserve crashkenel above 4G for crash dump kernel
>>>>>>  arm64: kdump: add memory for devices by DT property, =
low-memory-range
>>>>>>  kdump: update Documentation about crashkernel on arm64
>>>>>>  dt-bindings: chosen: Document linux,low-memory-range for arm64 =
kdump
>>>>>>=20
>>>>> We are getting "warn_alloc" [1] warning during boot of kdump =
kernel
>>>>> with bootargs as [2] of primary kernel.
>>>>> This error observed on ThunderX2  ARM64 platform.
>>>>>=20
>>>>> It is observed with latest upstream tag (v5.7-rc3) with this patch =
set
>>>>> and =
https://urldefense.com/v3/__https://lists.infradead.org/pipermail/kexec/20=
20-May/025128.html__;!!GqivPVa7Brio!LnTSARkCt0V0FozR0KmqooaH5ADtdXvs3mPdP3=
KRVqALmvSK2VmCkIPIhsaxbiIAAlzu$
>>>>> Also **without** this patch-set
>>>>> =
"https://urldefense.com/v3/__https://www.spinics.net/lists/arm-kernel/msg8=
06882.html__;!!GqivPVa7Brio!LnTSARkCt0V0FozR0KmqooaH5ADtdXvs3mPdP3KRVqALmv=
SK2VmCkIPIhsaxbjC6ujMA$"
>>>>>=20
>>>>> This issue comes whenever crashkernel memory is reserved after =
0xc000_0000.
>>>>> More details discussed earlier in
>>>>> =
https://urldefense.com/v3/__https://www.spinics.net/lists/arm-kernel/msg80=
6882.html__;!!GqivPVa7Brio!LnTSARkCt0V0FozR0KmqooaH5ADtdXvs3mPdP3KRVqALmvS=
K2VmCkIPIhsaxbjC6ujMA$  without any
>>>>> solution
>>>>>=20
>>>>> This patch-set is expected to solve similar kind of issue.
>>>>> i.e. low memory is only targeted for DMA, swiotlb; So above =
mentioned
>>>>> observation should be considered/fixed. .
>>>>>=20
>>>>> --pk
>>>>>=20
>>>>> [1]
>>>>> [   30.366695] DMI: Cavium Inc. Saber/Saber, BIOS
>>>>> TX2-FW-Release-3.1-build_01-2803-g74253a541a mm/dd/yyyy
>>>>> [   30.367696] NET: Registered protocol family 16
>>>>> [   30.369973] swapper/0: page allocation failure: order:6,
>>>>> mode:0x1(GFP_DMA), nodemask=3D(null),cpuset=3D/,mems_allowed=3D0
>>>>> [   30.369980] CPU: 0 PID: 1 Comm: swapper/0 Not tainted =
5.7.0-rc3+ #121
>>>>> [   30.369981] Hardware name: Cavium Inc. Saber/Saber, BIOS
>>>>> TX2-FW-Release-3.1-build_01-2803-g74253a541a mm/dd/yyyy
>>>>> [   30.369984] Call trace:
>>>>> [   30.369989]  dump_backtrace+0x0/0x1f8
>>>>> [   30.369991]  show_stack+0x20/0x30
>>>>> [   30.369997]  dump_stack+0xc0/0x10c
>>>>> [   30.370001]  warn_alloc+0x10c/0x178
>>>>> [   30.370004]  __alloc_pages_slowpath.constprop.111+0xb10/0xb50
>>>>> [   30.370006]  __alloc_pages_nodemask+0x2b4/0x300
>>>>> [   30.370008]  alloc_page_interleave+0x24/0x98
>>>>> [   30.370011]  alloc_pages_current+0xe4/0x108
>>>>> [   30.370017]  dma_atomic_pool_init+0x44/0x1a4
>>>>> [   30.370020]  do_one_initcall+0x54/0x228
>>>>> [   30.370027]  kernel_init_freeable+0x228/0x2cc
>>>>> [   30.370031]  kernel_init+0x1c/0x110
>>>>> [   30.370034]  ret_from_fork+0x10/0x18
>>>>> [   30.370036] Mem-Info:
>>>>> [   30.370064] active_anon:0 inactive_anon:0 isolated_anon:0
>>>>> [   30.370064]  active_file:0 inactive_file:0 isolated_file:0
>>>>> [   30.370064]  unevictable:0 dirty:0 writeback:0 unstable:0
>>>>> [   30.370064]  slab_reclaimable:34 slab_unreclaimable:4438
>>>>> [   30.370064]  mapped:0 shmem:0 pagetables:14 bounce:0
>>>>> [   30.370064]  free:1537719 free_pcp:219 free_cma:0
>>>>> [   30.370070] Node 0 active_anon:0kB inactive_anon:0kB
>>>>> active_file:0kB inactive_file:0kB unevictable:0kB =
isolated(anon):0kB
>>>>> isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB
>>>>> shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB =
writeback_tmp:0kB
>>>>> unstable:0kB all_unreclaimable? no
>>>>> [   30.370073] Node 1 active_anon:0kB inactive_anon:0kB
>>>>> active_file:0kB inactive_file:0kB unevictable:0kB =
isolated(anon):0kB
>>>>> isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB
>>>>> shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB =
writeback_tmp:0kB
>>>>> unstable:0kB all_unreclaimable? no
>>>>> [   30.370079] Node 0 DMA free:0kB min:0kB low:0kB high:0kB
>>>>> reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB
>>>>> active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB
>>>>> present:128kB managed:0kB mlocked:0kB kernel_stack:0kB =
pagetables:0kB
>>>>> bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
>>>>> [   30.370084] lowmem_reserve[]: 0 250 6063 6063
>>>>> [   30.370090] Node 0 DMA32 free:256000kB min:408kB low:664kB
>>>>> high:920kB reserved_highatomic:0KB active_anon:0kB =
inactive_anon:0kB
>>>>> active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB
>>>>> present:269700kB managed:256000kB mlocked:0kB kernel_stack:0kB
>>>>> pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
>>>>> [   30.370094] lowmem_reserve[]: 0 0 5813 5813
>>>>> [   30.370100] Node 0 Normal free:5894876kB min:9552kB low:15504kB
>>>>> high:21456kB reserved_highatomic:0KB active_anon:0kB =
inactive_anon:0kB
>>>>> active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB
>>>>> present:8388608kB managed:5953112kB mlocked:0kB =
kernel_stack:21672kB
>>>>> pagetables:56kB bounce:0kB free_pcp:876kB local_pcp:176kB =
free_cma:0kB
>>>>> [   30.370104] lowmem_reserve[]: 0 0 0 0
>>>>> [   30.370107] Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB =
0*128kB
>>>>> 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 0kB
>>>>> [   30.370113] Node 0 DMA32: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB =
0*128kB
>>>>> 0*256kB 0*512kB 0*1024kB 1*2048kB (M) 62*4096kB (M) =3D 256000kB
>>>>> [   30.370119] Node 0 Normal: 2*4kB (M) 3*8kB (ME) 2*16kB (UE) =
3*32kB
>>>>> (UM) 1*64kB (U) 2*128kB (M) 2*256kB (ME) 3*512kB (ME) 3*1024kB =
(ME)
>>>>> 3*2048kB (UME) 1436*4096kB (M) =3D 5893600kB
>>>>> [   30.370129] Node 0 hugepages_total=3D0 hugepages_free=3D0
>>>>> hugepages_surp=3D0 hugepages_size=3D1048576kB
>>>>> [   30.370130] 0 total pagecache pages
>>>>> [   30.370132] 0 pages in swap cache
>>>>> [   30.370134] Swap cache stats: add 0, delete 0, find 0/0
>>>>> [   30.370135] Free swap  =3D 0kB
>>>>> [   30.370136] Total swap =3D 0kB
>>>>> [   30.370137] 2164609 pages RAM
>>>>> [   30.370139] 0 pages HighMem/MovableOnly
>>>>> [   30.370140] 612331 pages reserved
>>>>> [   30.370141] 0 pages hwpoisoned
>>>>> [   30.370143] DMA: failed to allocate 256 KiB pool for atomic
>>>>> coherent allocation
>>>>=20
>>>>=20
>>>> During my testing I saw the same error and Chen's  solution =
corrected it .
>>>=20
>>> Which combination you are using on your side? I am using Prabhakar's
>>> suggested environment and can reproduce the issue
>>> with or without Chen's crashkernel support above 4G patchset.
>>>=20
>>> I am also using a ThunderX2 platform with latest makedumpfile code =
and
>>> kexec-tools (with the suggested patch
>>> =
<https://urldefense.com/v3/__https://lists.infradead.org/pipermail/kexec/2=
020-May/025128.html__;!!GqivPVa7Brio!J6lUig58-Gw6TKZnEEYzEeSU36T-1SqlB1kIm=
U00xtX_lss5Tx-JbUmLE9TJC3foXBLg$ >).
>>>=20
>>> Thanks,
>>> Bhupesh
>>=20
>>=20
>> I did this activity 5 months ago and I have moved on to other =
activities. My DMA failures were related to PCI devices that could not =
be enumerated because  low-DMA space was not  available when crashkernel =
was moved above 4G; I don=E2=80=99t recall the exact platform.
>>=20
>>=20
>>=20
>> For this failure ,
>>=20
>>>>> DMA: failed to allocate 256 KiB pool for atomic
>>>>> coherent allocation
>>=20
>>=20
>> Is due to :
>>=20
>>=20
>> 3618082c
>> ("arm64 use both ZONE_DMA and ZONE_DMA32")
>>=20
>> With the introduction of ZONE_DMA to support the Raspberry DMA
>> region below 1G, the crashkernel is placed in the upper 4G
>> ZONE_DMA_32 region. Since the crashkernel does not have access
>> to the ZONE_DMA region, it prints out call trace during bootup.
>>=20
>> It is due to having this CONFIG item  ON  :
>>=20
>>=20
>> CONFIG_ZONE_DMA=3Dy
>>=20
>> Turning off ZONE_DMA fixes a issue and Raspberry PI 4 will
>> use the device tree to specify memory below 1G.
>>=20
>>=20
>=20
> Disabling ZONE_DMA is temporary solution.  We may need proper solution


Perhaps the Raspberry platform configuration dependencies need separated =
 from =E2=80=9Cserver class=E2=80=9D Arm  equipment ?  Or =
auto-configured on boot ?  Consult an expert ;-)=20



>=20
>> I would like to see Chen=E2=80=99s feature added , perhaps as =
EXPERIMENTAL,  so we can get some configuration testing done on it.   It =
corrects having a DMA zone in low memory while crash-kernel is above =
4GB.  This has been going on for a year now.
>=20
> I will also like this patch to be added in Linux as early as possible.
>=20
> Issue mentioned by me happens with or without this patch.
>=20
> This patch-set can consider fixing because it uses low memory for DMA
> & swiotlb only.
> We can consider restricting crashkernel within the required range like =
below
>=20
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 7f9e5a6dc48c..bd67b90d35bd 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -354,7 +354,7 @@ int __init reserve_crashkernel_low(void)
>                        return 0;
>        }
>=20
> -       low_base =3D memblock_find_in_range(0, 1ULL << 32, low_size, =
CRASH_ALIGN);
> +       low_base =3D memblock_find_in_range(0,0xc0000000, low_size, =
CRASH_ALIGN);
>        if (!low_base) {
>                pr_err("Cannot reserve %ldMB crashkernel low memory,
> please try smaller size.\n",
>                       (unsigned long)(low_size >> 20));
>=20
>=20

    I suspect  0xc0000000  would need to be a CONFIG item  and not =
hard-coded.
   =20
   =20

> Similar change can be considered for scenario "without" this patch.
> But it will decrease memory availability for crashkernel.
> Hence increase the failure probability of crashkernel reservation.
>=20
> --pk

