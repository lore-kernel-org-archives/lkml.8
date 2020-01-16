Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72219C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 15:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E6EB2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 15:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="akPl5NBU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgAPPst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 10:48:49 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56964 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgAPPst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 10:48:49 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00GFhTOE085058;
        Thu, 16 Jan 2020 15:48:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=PaqPTMWc+RQXSpJWqh1zx/aHhm5SeMGvC6e6opMEO/Q=;
 b=akPl5NBU+n6z2ZPGKNeCLlf4ah8QUZWKTUZs2LNb/zs5hNwC329MKk1zsG1VgrbJbTvw
 hn+1KxdFx8k5WJw5YiQ9gTMKRbyCwCtxdkgm8RQghrg0J07x13iTv11rYB34Xp/bO3WA
 +lPByhGPUrF4Uf4JuaXPWQlHRzWZGzLTqa6ni5jU3h6PjWMcQR3jdY/YhdAJP/poQthA
 GmXsXxlKrutxSxn6dA59ywHQl9yMZyQ1eLl8uiv1ZV6RJtQ/tcJF8Bo3QdSCcLpW026B
 O3dT0GCVQroLi2QcGyzB900euJUWD/sIgK9JTjHdse62oHJ2JvFIkyUGozVy25vITFxe KQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2xf73u38cn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 15:48:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00GFeCuR102007;
        Thu, 16 Jan 2020 15:48:04 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2xj1ptabvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 15:48:03 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00GFlvtd018057;
        Thu, 16 Jan 2020 15:47:57 GMT
Received: from dhcp-10-154-96-54.vpn.oracle.com (/10.154.96.54)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 16 Jan 2020 07:47:57 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v7 1/4] x86: kdump: move reserve_crashkernel_low() into
 crash_core.c
From:   John Donnelly <john.p.donnelly@oracle.com>
In-Reply-To: <77c971a4-608f-ee35-40cb-77186a2ddbd1@arm.com>
Date:   Thu, 16 Jan 2020 09:47:55 -0600
Cc:     Dave Young <dyoung@redhat.com>, Chen Zhou <chenzhou10@huawei.com>,
        kbuild test robot <lkp@intel.com>, horms@verge.net.au,
        linux-doc@vger.kernel.org, catalin.marinas@arm.com,
        bhsharma@redhat.com, xiexiuqi@huawei.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <08C19FFB-C6FC-4BB7-A1C2-67CE6B99D2AB@oracle.com>
References: <20191223152349.180172-1-chenzhou10@huawei.com>
 <20191223152349.180172-2-chenzhou10@huawei.com>
 <20191227055458.GA14893@dhcp-128-65.nay.redhat.com>
 <09d42854-461b-e85c-ba3f-0e1173dc95b5@huawei.com>
 <20191228093227.GA19720@dhcp-128-65.nay.redhat.com>
 <77c971a4-608f-ee35-40cb-77186a2ddbd1@arm.com>
To:     James Morse <james.morse@arm.com>
X-Mailer: Apple Mail (2.3445.9.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9502 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001160130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9502 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001160130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 16, 2020, at 9:17 AM, James Morse <james.morse@arm.com> wrote:
>=20
> Hi guys,
>=20
> On 28/12/2019 09:32, Dave Young wrote:
>> On 12/27/19 at 07:04pm, Chen Zhou wrote:
>>> On 2019/12/27 13:54, Dave Young wrote:
>>>> On 12/23/19 at 11:23pm, Chen Zhou wrote:
>>>>> In preparation for supporting reserve_crashkernel_low in arm64 as
>>>>> x86_64 does, move reserve_crashkernel_low() into =
kernel/crash_core.c.
>>>>>=20
>>>>> Note, in arm64, we reserve low memory if and only if =
crashkernel=3DX,low
>>>>> is specified. Different with x86_64, don't set low memory =
automatically.
>>>>=20
>>>> Do you have any reason for the difference?  I'd expect we have same
>>>> logic if possible and remove some of the ifdefs.
>>>=20
>>> In x86_64, if we reserve crashkernel above 4G, then we call =
reserve_crashkernel_low()
>>> to reserve low memory.
>>>=20
>>> In arm64, to simplify, we call reserve_crashkernel_low() at the =
beginning of reserve_crashkernel()
>>> and then relax the arm64_dma32_phys_limit if =
reserve_crashkernel_low() allocated something.
>>> In this case, if reserve crashkernel below 4G there will be 256M low =
memory set automatically
>>> and this needs extra considerations.
>=20
>> Sorry that I did not read the old thread details and thought that is
>> arch dependent.  But rethink about that, it would be better that we =
can
>> have same semantic about crashkernel parameters across arches.  If we
>> make them different then it causes confusion, especially for
>> distributions.
>=20
> Surely distros also want one crashkernel* string they can use on all =
platforms without
> having to detect the kernel version, platform or changeable memory =
layout...
>=20
>=20
>> OTOH, I thought if we reserve high memory then the low memory should =
be
>> needed.  There might be some exceptions, but I do not know the exact
>> one,
>=20
>> can we make the behavior same, and special case those systems which
>> do not need low memory reservation.
>=20
> Its tricky to work out which systems are the 'normal' ones.
>=20
> We don't have a fixed memory layout for arm64. Some systems have no =
memory below 4G.
> Others have no memory above 4G.
>=20
> Chen Zhou's machine has some memory below 4G, but its too precious to =
reserve a large
> chunk for kdump. Without any memory below 4G some of the drivers won't =
work.
>=20
> I don't see what distros can set as their default for all platforms if =
high/low are
> mutually exclusive with the 'crashkernel=3D' in use today. How did x86 =
navigate this, ... or
> was it so long ago?
>=20
> No one else has reported a problem with the existing placement logic, =
hence treating this
> 'low' thing as the 'in addition' special case.


Hi,

I am seeing similar  Arm crash dump issues  on  5.4 kernels  where we =
need  rather large amount of crashkernel memory reserved that is not =
available below 4GB ( The maximum reserved size appears to be around =
768M ) . When I pick memory range higher than 4GB , I see  adapters that =
fail to initialize :


There is no low-memory  <4G  memory for DMA ;    =20

[   11.506792] kworker/0:14: page allocation failure: order:0,=20
mode:0x104(GFP_DMA32|__GFP_ZERO), =
nodemask=3D(null),cpuset=3D/,mems_allowed=3D0=20
[   11.518793] CPU: 0 PID: 150 Comm: kworker/0:14 Not tainted=20
5.4.0-1948.3.el8uek.aarch64 #1=20
[   11.526955] Hardware name: To be filled by O.E.M. Saber/Saber, BIOS=20=

0ACKL025 01/18/2019=20
[   11.534948] Workqueue: events work_for_cpu_fn=20
[   11.539291] Call trace:=20
[   11.541727]  dump_backtrace+0x0/0x18c=20
[   11.545376]  show_stack+0x24/0x30=20
[   11.548679]  dump_stack+0xbc/0xe0=20
[   11.551982]  warn_alloc+0xf0/0x15c=20
[   11.555370]  __alloc_pages_slowpath+0xb4c/0xb84=20
[   11.559887]  __alloc_pages_nodemask+0x2d0/0x330=20
[   11.564405]  alloc_pages_current+0x8c/0xf8=20
[   11.568496]  ttm_bo_device_init+0x188/0x220 [ttm]=20
[   11.573187]  drm_vram_mm_init+0x58/0x80 [drm_vram_helper]=20
[   11.578572]  drm_vram_helper_alloc_mm+0x64/0xb0 [drm_vram_helper]=20
[   11.584655]  ast_mm_init+0x38/0x80 [ast]=20
[   11.588566]  ast_driver_load+0x474/0xa70 [ast]=20
[   11.593029]  drm_dev_register+0x144/0x1c8 [drm]=20
[   11.597573]  drm_get_pci_dev+0xa4/0x168 [drm]=20
[   11.601919]  ast_pci_probe+0x8c/0x9c [ast]=20
[   11.606004]  local_pci_probe+0x44/0x98=20
[   11.609739]  work_for_cpu_fn+0x20/0x30=20
[   11.613474]  process_one_work+0x1c4/0x41c=20
[   11.617470]  worker_thread+0x150/0x4b0=20
[   11.621206]  kthread+0x110/0x114=20
[   11.624422]  ret_from_fork+0x10/0x18=20

This failure is related to a graphics adapter.=20

The more complex kdump configurations that use networking stack to NFS =
mount a filesystem to dump to , or use ssh to copy to another machine,  =
require more crashkernel memory reservations than perhaps the =
=E2=80=9Cdefault*=E2=80=9D settings of  a minimal kdump that creates a =
minimal  vmcore to local storage in  /var/crash. If crashkernel is too =
small I get Out of Memory issues and the entire vmcore  process fails.=20=


( *default kdump setting I assume are a minimal vmcore to /var/crash =
using primary boot device where /root is located  )=20




>=20
>=20
>>> previous discusses:
>>> 	=
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lkml.org_lkml_2019_=
6_5_670&d=3DDwICAg&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=3Dt2f=
Pg9D87F7D8jm0_3CG9yoiIKdRg4qc_thBw4bzMhc&m=3DjOAu1DTDpohsWszalfTCYx46eGF19=
TSWVLchN5yBPgk&s=3DgS9BLOkmj78lP5L7SP6_VLHwvP249uWKaE2R7N7sxgM&e=3D=20
>>> 	=
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lkml.org_lkml_2019_=
6_13_229&d=3DDwICAg&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=3Dt2=
fPg9D87F7D8jm0_3CG9yoiIKdRg4qc_thBw4bzMhc&m=3DjOAu1DTDpohsWszalfTCYx46eGF1=
9TSWVLchN5yBPgk&s=3DU1Nis29n3A7XSBzED53fiE4MDAv5NlxYp1UorvvBOOw&e=3D=20
>>=20
>> Another concern from James:
>> "
>> With both crashk_low_res and crashk_res, we end up with two entries =
in /proc/iomem called
>> "Crash kernel". Because its sorted by address, and kexec-tools stops =
searching when it
>> find "Crash kernel", you are always going to get the kernel placed in =
the lower portion.
>> "
>>=20
>> The kexec-tools code is iterating all "Crash kernel" ranges and add =
them
>> in an array.  In X86 code, it uses the higher range to locate memory.
>=20
> Then my hurried reading of what the user-space code does was wrong!
>=20
> If kexec-tools places the kernel in the low region, there may not be =
enough memory left
> for whatever purpose it was reserved for. This was the motivation for =
giving it a
> different name.
>=20
>=20
> Thanks,
>=20
> James
>=20
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> =
https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__lists.infradead.org_=
mailman_listinfo_kexec&d=3DDwICAg&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65e=
apI_JnE&r=3Dt2fPg9D87F7D8jm0_3CG9yoiIKdRg4qc_thBw4bzMhc&m=3DjOAu1DTDpohsWs=
zalfTCYx46eGF19TSWVLchN5yBPgk&s=3Dbqp02iQDP_Ez-XvLIvj-IPHqbbZwMPlDgmEcG8vh=
XFE&e=3D=20

