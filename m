Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C50C11D30
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A2F2084E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r6ksCCt2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgBXPTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:19:17 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:44360 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbgBXPTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 10:19:16 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OFI2E5034195;
        Mon, 24 Feb 2020 15:18:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=IZBlZqW/RTIQGv1FMd6NnbDpL+mTPRKQpYdPDi5jwus=;
 b=r6ksCCt2e4/RgzmgGoAcRpkSgLDZXQXUKG2kQWz3v9wQVSYbOP8YIzNLL8FMj+Q3h9SO
 RYu8sYQnS+gJNnVVWzPh0LLZIUsp8wjj+Bg9iKwwatCvXhNlitWpWRhAWjd3M8nEzLUL
 EhPgp8xTK4SrO5H+/QVRTYlchvWuF2IsQqOIiX8+yQi4a3Sma7mOmPMwlcLCZ3v6guaI
 bA/EatcXahT7rsk1IQe511iwYmyiCwpdadA8g1eyGjKfqbKn8rI97HYBlOKr6dDlLJpH
 11nVSGWAbWFUcr3/VnSfQqpMfBQnqNzWC76wfvITuS/ew26+Vi+hrcTjzBPP5TmULmwz 9Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2ybvr4m8cs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 15:18:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OFIZN9096434;
        Mon, 24 Feb 2020 15:18:39 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2yby5cdxtr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 15:18:39 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01OFIbDD019108;
        Mon, 24 Feb 2020 15:18:37 GMT
Received: from [10.39.217.189] (/10.39.217.189)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Feb 2020 07:18:37 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v7 0/4] support reserving crashkernel above 4G on arm64
 kdump
From:   John Donnelly <john.p.donnelly@oracle.com>
In-Reply-To: <52102118-9b61-5978-3213-062e9c758dcf@Oracle.com>
Date:   Mon, 24 Feb 2020 09:18:27 -0600
Content-Transfer-Encoding: quoted-printable
Message-Id: <BF198E9B-2A9B-4325-A2CA-BB164729704B@oracle.com>
References: <20191223152349.180172-1-chenzhou10@huawei.com>
 <52102118-9b61-5978-3213-062e9c758dcf@Oracle.com>
To:     kexec mailing list <kexec@lists.infradead.org>,
        linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3445.9.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 12, 2020, at 7:20 AM, John Donnelly =
<John.P.Donnelly@Oracle.com> wrote:
>=20
> On 12/23/19 9:23 AM, Chen Zhou wrote:
>> This patch series enable reserving crashkernel above 4G in arm64.
>> There are following issues in arm64 kdump:
>> 1. We use crashkernel=3DX to reserve crashkernel below 4G, which will =
fail
>> when there is no enough low memory.
>> 2. Currently, crashkernel=3DY@X can be used to reserve crashkernel =
above 4G,
>> in this case, if swiotlb or DMA buffers are required, crash dump =
kernel
>> will boot failure because there is no low memory available for =
allocation.
>> To solve these issues, introduce crashkernel=3DX,low to reserve =
specified
>> size low memory.
>> Crashkernel=3DX tries to reserve memory for the crash dump kernel =
under
>> 4G. If crashkernel=3DY,low is specified simultaneously, reserve =
spcified
>> size low memory for crash kdump kernel devices firstly and then =
reserve
>> memory above 4G.
>=20
>=20
> Hi Chen,
>=20
>=20
> I've applied your V7 patches to 5.4.17 test kernel and I am still =
seeing
> failures when I use a kdump kernel .
>=20
>=20
> On the kernel boot I see:
>=20
> Reserving 250MB of low memory at 3618MB for crashkernel (System low =
RAM: 2029MB)
> crashkernel reserved: 0x00000008c0000000 - 0x0000000940000000 (2048 =
MB)
>=20
> # cat /proc/iomem  | grep -i cras
>  e2200000-f1bfffff : Crash kernel (low)
>  8c0000000-93fffffff : Crash kernel
>=20
>=20
> When kdump kernel is started I see what appears to be DMA initialized =
:
>=20
> NUMA: NODE_DATA(1) on node 0
> Zone ranges:
> DMA32    [mem 0x00000000802f0000-0x00000000ffffffff]
> Normal   [mem 0x0000000100000000-0x000000093fffffff]
>=20
> But the sas driver still fails :
>=20
>=20
> [   12.092769] CPU: 0 PID: 149 Comm: kworker/0:13 Not tainted =
5.4.17-4-uek6m_ol8-jpdonnel+ #2
> [   12.101019] Hardware name: To be filled by O.E.M. Saber/Saber, BIOS =
0ACKL028 09/09/2019
> [   12.109019] Workqueue: events work_for_cpu_fn
> [   12.113363] Call trace:
> [   12.115803]  dump_backtrace+0x0/0x19c
> [   12.119453]  show_stack+0x24/0x2c
> [   12.122769]  dump_stack+0xcc/0xf8
> [   12.126078]  warn_alloc+0x108/0x11c
> [   12.129554]  __alloc_pages_slowpath+0x8fc/0xa10
> [   12.134071]  __alloc_pages_nodemask+0x2ec/0x334
> [   12.138597]  __dma_direct_alloc_pages+0x19c/0x238
> [   12.143288]  dma_direct_alloc_pages+0x48/0xf8
> [   12.147632]  dma_direct_alloc+0x4c/0x6c
> [   12.151455]  dma_alloc_attrs+0x88/0xf4
> [   12.155196]  dma_pool_alloc+0x11c/0x2ec
> [   12.159053]  _base_allocate_memory_pools+0x2ec/0x1078 [mpt3sas]
> [   12.164978]  mpt3sas_base_attach+0x444/0x748 [mpt3sas]
> [   12.170121]  _scsih_probe+0x554/0x848 [mpt3sas]
> [   12.174648]  local_pci_probe+0x4c/0x98
>=20
> And the kdump fails to find local storage:
>=20
>=20
> mpt3sas_cm0: reply_post_free pool: dma_pool_alloc failed
> mpt3sas_cm0: failure at =
../drivers/scsi/mpt3sas/mpt3sas_scsih.c:10626/_scsih_probe()!

 Hi Chen,


I was able to unit test these series of kernel  patches  applied to a =
5.4.17 test kernel  along with the kexec CLI  change :

0001-arm64-kdump-add-another-DT-property-to-crash-dump-ke.patch

 Applied to :

kexec-tools-2.0.19-12.0.4.el8.src.rpm

And obtained a vmcore using this cmdline :

BOOT_IMAGE=3D(hd6,gpt2)/vmlinuz-5.4.17-4-uek6m_ol8-jpdonnel+ =
root=3D/dev/mapper/ol01-root ro crashkernel=3D2048M@35G =
crashkernel=3D250M,low rd.lvm.lv=3Dol01/root rd.lvm.lv=3Dol01/swap =
console=3DttyS4 loglevel=3D7

Can you add :

Tested-by: John Donnelly <John.p.donnelly@oracle.com>


How can we  get these changes included into an rc kernel release  ?

Thanks,

John.






>=20
>=20
>=20
>=20
>> When crashkernel is reserved above 4G in memory, that is, =
crashkernel=3DX,low
>> is specified simultaneously, kernel should reserve specified size low =
memory
>> for crash dump kernel devices. So there may be two crash kernel =
regions, one
>> is below 4G, the other is above 4G.
>> In order to distinct from the high region and make no effect to the =
use of
>> kexec-tools, rename the low region as "Crash kernel (low)", and add =
DT property
>> "linux,low-memory-range" to crash dump kernel's dtb to pass the low =
region.
>> Besides, we need to modify kexec-tools:
>> arm64: kdump: add another DT property to crash dump kernel's dtb(see =
[1])
>=20
>=20
> Can you explain what needs done to kexec tools  in more detail ?
>=20
> I'd like to understand why the Arm kdump boot images are so large ( =
1024M+ ) as compared to x86 that can take a vmcore using a 512M kdump =
image .
>=20
>=20
>=20
> =3D=3D=3D=3D=3D=3D=3D <clipped>=3D=3D=3D=3D=3D=3D=3D


   I was able to unit test these series of patches along with the kexec =
CLI  change :

0001-arm64-kdump-add-another-DT-property-to-crash-dump-ke.patch

 Applied to :

kexec-tools-2.0.19-12.0.4.el8.src.rpm


And was able to get a vmcore dump=20

>=20
>=20
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> =
https://urldefense.com/v3/__http://lists.infradead.org/mailman/listinfo/ke=
xec__;!!GqivPVa7Brio!PTJ8J3z7crIzNbPXZr99_vgRkany0mRuHvQqzUIK_4QoWqLEcdWLX=
fjsdyw3vIntYsG7$=20

