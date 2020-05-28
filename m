Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4BBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E17B8207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HZLKPY0R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437096AbgE1WXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 18:23:35 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45162 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436992AbgE1WX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 18:23:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04SMMCO8077828;
        Thu, 28 May 2020 22:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=pgGnLsM1bSn7Hitbxv/OnsybTse9rQRdmkPsorQ6A70=;
 b=HZLKPY0RlGYg8QG5DpTqwSBVmljIjt4jzyRpaOst39SbYms+6S9VtDBIaX0P1HDNk8rD
 +AYsE1YiSh4T3tZoB9JqlGbu0WIeeGbU0sl+InLeDMZV/bv5gK7NLfcFZpvaEB5syy3h
 I4IxgkqNx13bynn9sos6GcR82P7pdKMbEAS/8VFaUNMV/dB5DHnC14bspIoWiDzrqmsU
 7FMCxx2brbqH8lFoNkM1+ilWS7sy41RSI5hH/mh8f7eyFLMA0DURe8jE3gl+8a+hNXM6
 tPAOtjiY598J7XNKWpMdmj0pRPPkV9YtSB8KanlB0v0gFlRYtCPax+KenAhV84UE552W IA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 318xe1qhca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 May 2020 22:22:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04SMDflD066940;
        Thu, 28 May 2020 22:20:46 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 31a9kt94ry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 May 2020 22:20:46 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04SMKa36012836;
        Thu, 28 May 2020 22:20:36 GMT
Received: from [192.168.1.106] (/47.220.71.223)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 May 2020 15:20:36 -0700
Subject: Re: [PATCH v8 0/5] support reserving crashkernel above 4G on arm64
 kdump
To:     Baoquan He <bhe@redhat.com>, Chen Zhou <chenzhou10@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, catalin.marinas@arm.com,
        will@kernel.org, dyoung@redhat.com, robh+dt@kernel.org,
        arnd@arndb.de, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, horms@verge.net.au,
        guohanjun@huawei.com, pkushwaha@marvell.com,
        linux-arm-kernel@lists.infradead.org
References: <20200521093805.64398-1-chenzhou10@huawei.com>
 <20200526014242.GF20045@MiWiFi-R3L-srv>
From:   John Donnelly <John.P.donnelly@oracle.com>
Message-ID: <897ea1b9-a68c-8544-6532-a21be135ce01@oracle.com>
Date:   Thu, 28 May 2020 17:20:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200526014242.GF20045@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9635 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005280142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9635 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 cotscore=-2147483648 mlxscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1011 impostorscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005280143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/25/20 8:42 PM, Baoquan He wrote:
> On 05/21/20 at 05:38pm, Chen Zhou wrote:
>> This patch series enable reserving crashkernel above 4G in arm64.
>>
>> There are following issues in arm64 kdump:
>> 1. We use crashkernel=X to reserve crashkernel below 4G, which will fail
>> when there is no enough low memory.
>> 2. Currently, crashkernel=Y@X can be used to reserve crashkernel above 4G,
>> in this case, if swiotlb or DMA buffers are required, crash dump kernel
>> will boot failure because there is no low memory available for allocation.
>>
>> To solve these issues, introduce crashkernel=X,low to reserve specified
>> size low memory.
>> Crashkernel=X tries to reserve memory for the crash dump kernel under
>> 4G. If crashkernel=Y,low is specified simultaneously, reserve spcified
>> size low memory for crash kdump kernel devices firstly and then reserve
>> memory above 4G.
>>
>> When crashkernel is reserved above 4G in memory, that is, crashkernel=X,low
>> is specified simultaneously, kernel should reserve specified size low memory
>> for crash dump kernel devices. So there may be two crash kernel regions, one
>> is below 4G, the other is above 4G.
>> In order to distinct from the high region and make no effect to the use of
>> kexec-tools, rename the low region as "Crash kernel (low)", and add DT property
>> "linux,low-memory-range" to crash dump kernel's dtb to pass the low region.
>>
>> Besides, we need to modify kexec-tools:
>> arm64: kdump: add another DT property to crash dump kernel's dtb(see [1])
>>
>> The previous changes and discussions can be retrieved from:
>>
>> Changes since [v7]
>> - Move x86 CRASH_ALIGN to 2M
>> Suggested by Dave and do some test, move x86 CRASH_ALIGN to 2M.
> OK, moving x86 CRASH_ALIGN to 2M is suggested by Dave. Because
> CONFIG_PHYSICAL_ALIGN can be selected from 2M to 16M. So 2M seems good.
> But, anyway, we should tell the reason why it need be changed in commit
> log.
>
>
> arch/x86/Kconfig:
> config PHYSICAL_ALIGN
>          hex "Alignment value to which kernel should be aligned"
>          default "0x200000"
>          range 0x2000 0x1000000 if X86_32
>          range 0x200000 0x1000000 if X86_64
>
>> - Update Documentation/devicetree/bindings/chosen.txt
>> Add corresponding documentation to Documentation/devicetree/bindings/chosen.txt suggested by Arnd.
>> - Add Tested-by from Jhon and pk
>>
>> Changes since [v6]
>> - Fix build errors reported by kbuild test robot.
>>
>> Changes since [v5]
>> - Move reserve_crashkernel_low() into kernel/crash_core.c.
>> - Delete crashkernel=X,high.
> And the crashkernel=X,high being deleted need be told too. Otherwise
> people reading the commit have to check why themselves. I didn't follow
> the old version, can't see why ,high can't be specified explicitly.
>
>> - Modify crashkernel=X,low.
>> If crashkernel=X,low is specified simultaneously, reserve spcified size low
>> memory for crash kdump kernel devices firstly and then reserve memory above 4G.
>> In addition, rename crashk_low_res as "Crash kernel (low)" for arm64, and then
>> pass to crash dump kernel by DT property "linux,low-memory-range".
>> - Update Documentation/admin-guide/kdump/kdump.rst.
>>
>> Changes since [v4]
>> - Reimplement memblock_cap_memory_ranges for multiple ranges by Mike.
>>
>> Changes since [v3]
>> - Add memblock_cap_memory_ranges back for multiple ranges.
>> - Fix some compiling warnings.
>>
>> Changes since [v2]
>> - Split patch "arm64: kdump: support reserving crashkernel above 4G" as
>> two. Put "move reserve_crashkernel_low() into kexec_core.c" in a separate
>> patch.
>>
>> Changes since [v1]:
>> - Move common reserve_crashkernel_low() code into kernel/kexec_core.c.
>> - Remove memblock_cap_memory_ranges() i added in v1 and implement that
>> in fdt_enforce_memory_region().
>> There are at most two crash kernel regions, for two crash kernel regions
>> case, we cap the memory range [min(regs[*].start), max(regs[*].end)]
>> and then remove the memory range in the middle.
>>
>> [1]: https://urldefense.com/v3/__http://lists.infradead.org/pipermail/kexec/2020-May/025128.html__;!!GqivPVa7Brio!NHQIQVbVz5bR1SSP7U7SwT3uHb6OnycPGa6nM0oLTaQdZT4pjRsjrMjn5GqOJwQs3C4x$
>> [v1]: https://urldefense.com/v3/__https://lkml.org/lkml/2019/4/2/1174__;!!GqivPVa7Brio!NHQIQVbVz5bR1SSP7U7SwT3uHb6OnycPGa6nM0oLTaQdZT4pjRsjrMjn5GqOJ6e-mIEp$
>> [v2]: https://urldefense.com/v3/__https://lkml.org/lkml/2019/4/9/86__;!!GqivPVa7Brio!NHQIQVbVz5bR1SSP7U7SwT3uHb6OnycPGa6nM0oLTaQdZT4pjRsjrMjn5GqOJyUVjUta$
>> [v3]: https://urldefense.com/v3/__https://lkml.org/lkml/2019/4/9/306__;!!GqivPVa7Brio!NHQIQVbVz5bR1SSP7U7SwT3uHb6OnycPGa6nM0oLTaQdZT4pjRsjrMjn5GqOJ3CXBRdT$
>> [v4]: https://urldefense.com/v3/__https://lkml.org/lkml/2019/4/15/273__;!!GqivPVa7Brio!NHQIQVbVz5bR1SSP7U7SwT3uHb6OnycPGa6nM0oLTaQdZT4pjRsjrMjn5GqOJ7SxW1Vj$
>> [v5]: https://urldefense.com/v3/__https://lkml.org/lkml/2019/5/6/1360__;!!GqivPVa7Brio!NHQIQVbVz5bR1SSP7U7SwT3uHb6OnycPGa6nM0oLTaQdZT4pjRsjrMjn5GqOJ2wyJ9tj$
>> [v6]: https://urldefense.com/v3/__https://lkml.org/lkml/2019/8/30/142__;!!GqivPVa7Brio!NHQIQVbVz5bR1SSP7U7SwT3uHb6OnycPGa6nM0oLTaQdZT4pjRsjrMjn5GqOJzvGhWBh$
>> [v7]: https://urldefense.com/v3/__https://lkml.org/lkml/2019/12/23/411__;!!GqivPVa7Brio!NHQIQVbVz5bR1SSP7U7SwT3uHb6OnycPGa6nM0oLTaQdZT4pjRsjrMjn5GqOJ6pAg6tX$
>>
>> Chen Zhou (5):
>>    x86: kdump: move reserve_crashkernel_low() into crash_core.c
>>    arm64: kdump: reserve crashkenel above 4G for crash dump kernel
>>    arm64: kdump: add memory for devices by DT property, low-memory-range
>>    kdump: update Documentation about crashkernel on arm64
>>    dt-bindings: chosen: Document linux,low-memory-range for arm64 kdump
>>
>>   Documentation/admin-guide/kdump/kdump.rst     | 13 ++-
>>   .../admin-guide/kernel-parameters.txt         | 12 ++-
>>   Documentation/devicetree/bindings/chosen.txt  | 25 ++++++
>>   arch/arm64/kernel/setup.c                     |  8 +-
>>   arch/arm64/mm/init.c                          | 61 ++++++++++++-
>>   arch/x86/kernel/setup.c                       | 66 ++------------
>>   include/linux/crash_core.h                    |  3 +
>>   include/linux/kexec.h                         |  2 -
>>   kernel/crash_core.c                           | 85 +++++++++++++++++++
>>   kernel/kexec_core.c                           | 17 ----
>>   10 files changed, 208 insertions(+), 84 deletions(-)
>>
>> -- 
>> 2.20.1
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> https://urldefense.com/v3/__http://lists.infradead.org/mailman/listinfo/kexec__;!!GqivPVa7Brio!NHQIQVbVz5bR1SSP7U7SwT3uHb6OnycPGa6nM0oLTaQdZT4pjRsjrMjn5GqOJwwX8HSl$
>>



Hi,



This proposal to improve vmcore creation on Arm  has been going on for 
almost a year now.

Who is the  final maintainer that needs to approve and except these ?

What are the lingering issues that are remaining so we get these 
accepted into a upstream commit ?


Thank you.

John.



