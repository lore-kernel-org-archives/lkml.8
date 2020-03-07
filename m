Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34754C10F26
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 18:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1116C2073C
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 18:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aqul3OUz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgCGSoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 13:44:10 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:36640 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgCGSoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 13:44:09 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 027IYRJ1148148;
        Sat, 7 Mar 2020 18:43:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=x0rdGTG4PgqzGEHHwl4BQb+eQt+cgv+7FrZuLnwZOc4=;
 b=aqul3OUz7zAvhP3G6oSUZbNY1p7L9NLj8jWjr8Z4fTZygjG1s7UfVlqpM/Vie6NxY32U
 XXIwiilKzqnqRpf9+rV2XYMY5FxzVCHSBtod4uKRJHGk0IgfTpE6RnnWL2GoZeB5V74Q
 HFoQUc7Su+fMv2HvAiLii5rdOzT3+kEazNK1xCgcdu9CBUOaCODeYKWlcMu3tKv7Ku3V
 rJ5x6hT7avtBnRydBTwY1nlz0lCQWJXHipC/pNRl9ioIDgBIfopr2niZ/+Wvg2oM6nyX
 RLqTzeI2VNpBbgyWCG/6/+YK8MJ+9j85ptdMZE/xeNU/aSXUk8cqkH1mN7lKCSX/vDs2 3A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2ym31u1h74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Mar 2020 18:43:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 027IhOgQ109522;
        Sat, 7 Mar 2020 18:43:24 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2ym1nerqx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Mar 2020 18:43:24 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 027Ih9Tk031374;
        Sat, 7 Mar 2020 18:43:09 GMT
Received: from dhcp-10-154-175-234.vpn.oracle.com (/10.154.175.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 07 Mar 2020 10:43:09 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v7 2/4] arm64: kdump: reserve crashkenel above 4G for
 crash dump kernel
From:   John Donnelly <john.p.donnelly@oracle.com>
In-Reply-To: <0c00f14a-15ca-44db-7f82-00f15ddd3c88@huawei.com>
Date:   Sat, 7 Mar 2020 12:43:07 -0600
Cc:     Prabhakar Kushwaha <prabhakar.pkin@gmail.com>, horms@verge.net.au,
        Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>,
        Will Deacon <will@kernel.org>, xiexiuqi@huawei.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        kexec mailing list <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, dyoung@redhat.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B6820665-123F-422A-8E49-BB2A48D02CA7@oracle.com>
References: <20191223152349.180172-1-chenzhou10@huawei.com>
 <20191223152349.180172-3-chenzhou10@huawei.com>
 <CAJ2QiJ+SQ1orriXJWyhKDcDL9s4Vh5+HQHhWFOKPVmijGpMGvw@mail.gmail.com>
 <0c00f14a-15ca-44db-7f82-00f15ddd3c88@huawei.com>
To:     Chen Zhou <chenzhou10@huawei.com>
X-Mailer: Apple Mail (2.3445.9.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9553 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003070136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9553 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003070135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 7, 2020, at 5:06 AM, Chen Zhou <chenzhou10@huawei.com> wrote:
>=20
>=20
>=20
> On 2020/3/5 18:13, Prabhakar Kushwaha wrote:
>> On Mon, Dec 23, 2019 at 8:57 PM Chen Zhou <chenzhou10@huawei.com> =
wrote:
>>>=20
>>> Crashkernel=3DX tries to reserve memory for the crash dump kernel =
under
>>> 4G. If crashkernel=3DX,low is specified simultaneously, reserve =
spcified
>>> size low memory for crash kdump kernel devices firstly and then =
reserve
>>> memory above 4G.
>>>=20
>>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>>> ---
>>> arch/arm64/kernel/setup.c |  8 +++++++-
>>> arch/arm64/mm/init.c      | 31 +++++++++++++++++++++++++++++--
>>> 2 files changed, 36 insertions(+), 3 deletions(-)
>>>=20
>>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>>> index 56f6645..04d1c87 100644
>>> --- a/arch/arm64/kernel/setup.c
>>> +++ b/arch/arm64/kernel/setup.c
>>> @@ -238,7 +238,13 @@ static void __init =
request_standard_resources(void)
>>>                    kernel_data.end <=3D res->end)
>>>                        request_resource(res, &kernel_data);
>>> #ifdef CONFIG_KEXEC_CORE
>>> -               /* Userspace will find "Crash kernel" region in =
/proc/iomem. */
>>> +               /*
>>> +                * Userspace will find "Crash kernel" region in =
/proc/iomem.
>>> +                * Note: the low region is renamed as Crash kernel =
(low).
>>> +                */
>>> +               if (crashk_low_res.end && crashk_low_res.start >=3D =
res->start &&
>>> +                               crashk_low_res.end <=3D res->end)
>>> +                       request_resource(res, &crashk_low_res);
>>>                if (crashk_res.end && crashk_res.start >=3D =
res->start &&
>>>                    crashk_res.end <=3D res->end)
>>>                        request_resource(res, &crashk_res);
>>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>>> index b65dffd..0d7afd5 100644
>>> --- a/arch/arm64/mm/init.c
>>> +++ b/arch/arm64/mm/init.c
>>> @@ -80,6 +80,7 @@ static void __init reserve_crashkernel(void)
>>> {
>>>        unsigned long long crash_base, crash_size;
>>>        int ret;
>>> +       phys_addr_t crash_max =3D arm64_dma32_phys_limit;
>>>=20
>>>        ret =3D parse_crashkernel(boot_command_line, =
memblock_phys_mem_size(),
>>>                                &crash_size, &crash_base);
>>> @@ -87,12 +88,38 @@ static void __init reserve_crashkernel(void)
>>>        if (ret || !crash_size)
>>>                return;
>>>=20
>>> +       ret =3D reserve_crashkernel_low();
>>> +       if (!ret && crashk_low_res.end) {
>>> +               /*
>>> +                * If crashkernel=3DX,low specified, there may be =
two regions,
>>> +                * we need to make some changes as follows:
>>> +                *
>>> +                * 1. rename the low region as "Crash kernel (low)"
>>> +                * In order to distinct from the high region and =
make no effect
>>> +                * to the use of existing kexec-tools, rename the =
low region as
>>> +                * "Crash kernel (low)".
>>> +                *
>>> +                * 2. change the upper bound for crash memory
>>> +                * Set MEMBLOCK_ALLOC_ACCESSIBLE upper bound for =
crash memory.
>>> +                *
>>> +                * 3. mark the low region as "nomap"
>>> +                * The low region is intended to be used for crash =
dump kernel
>>> +                * devices, just mark the low region as "nomap" =
simply.
>>> +                */
>>> +               const char *rename =3D "Crash kernel (low)";
>>> +
>>> +               crashk_low_res.name =3D rename;
>>> +               crash_max =3D MEMBLOCK_ALLOC_ACCESSIBLE;
>>> +               memblock_mark_nomap(crashk_low_res.start,
>>> +                                   resource_size(&crashk_low_res));
>>> +       }
>>> +
>>>        crash_size =3D PAGE_ALIGN(crash_size);
>>>=20
>>>        if (crash_base =3D=3D 0) {
>>>                /* Current arm64 boot protocol requires 2MB alignment =
*/
>>> -               crash_base =3D memblock_find_in_range(0, =
arm64_dma32_phys_limit,
>>> -                               crash_size, SZ_2M);
>>> +               crash_base =3D memblock_find_in_range(0, crash_max, =
crash_size,
>>> +                               SZ_2M);
>>>                if (crash_base =3D=3D 0) {
>>>                        pr_warn("cannot allocate crashkernel =
(size:0x%llx)\n",
>>>                                crash_size);
>>> --
>>=20
>> I tested this patch series on ARM64-ThunderX2 with no issue with
>> bootargs crashkenel=3DX@Y crashkernel=3D250M,low
>>=20
>> $ dmesg | grep crash
>> [    0.000000] crashkernel reserved: 0x0000000b81200000 -
>> 0x0000000c81200000 (4096 MB)
>> [    0.000000] Kernel command line:
>> BOOT_IMAGE=3D/boot/vmlinuz-5.6.0-rc4+
>> root=3DUUID=3D866b8df3-14f4-4e11-95a1-74a90ee9b694 ro
>> crashkernel=3D4G@0xb81200000 crashkernel=3D250M,low nowatchdog =
earlycon
>> [   29.310209]     crashkernel=3D250M,low
>>=20
>> $  kexec -p -i /boot/vmlinuz-`uname -r`
>> --initrd=3D/boot/initrd.img-`uname -r` --reuse-cmdline
>> $ echo 1 > /proc/sys/kernel/sysrq ; echo c > /proc/sysrq-trigger
>>=20
>> But when i tried with crashkernel=3D4G crashkernel=3D250M,low as =
bootargs.
>> Kernel is not able to allocate memory.
>> [    0.000000] cannot allocate crashkernel (size:0x100000000)
>> [    0.000000] Kernel command line:
>> BOOT_IMAGE=3D/boot/vmlinuz-5.6.0-rc4+
>> root=3DUUID=3D866b8df3-14f4-4e11-95a1-74a90ee9b694 ro crashkernel=3D4G
>> crashkernel=3D250M,low nowatchdog
>> [   29.332081]     crashkernel=3D250M,low
>>=20
>> does crashkernel=3DX@Y mandatory to get allocated beyond 4G?
>> am I missing something?
>=20

   crashkernel=3D4G

   You need to look at the memory map on node 0  from dmesg     ( or =
/proc/iomem ) to determine if there is any memory in that range  - =
0x100000000 =3D=3D 1st byte above 4G .

On the Arm server class machines  I=E2=80=99ve seen the 1st usable =
memory range above 4G is 32G area. It is platform dependent where the =
1st range is.=20

> I can't reproduce the problem in my environment, can you test with =
other size,
> such as "crashkernel=3D1G crashkernel=3D250M,low", see if there is the =
same issue.
>=20
> Besides, crashkernel=3DX@Y isn't mandatory to get allocated beyond 4G,
> can you show the whole file /proc/iomem.
>=20
> Thanks,
> Chen Zhou
>=20
>>=20
>> --pk
>>=20
>> .
>>=20
>=20
>=20
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> =
https://urldefense.com/v3/__http://lists.infradead.org/mailman/listinfo/ke=
xec__;!!GqivPVa7Brio!ODmAWng4F8H39PjvA-8q-Y9yOCQN8plPM95XeJsrXLMwbkFCZ5r3N=
PBr0duY0Rku_MCe$

