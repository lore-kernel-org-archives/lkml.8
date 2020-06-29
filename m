Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF69C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 971CA206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nvAzSY/g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbgF2VcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:32:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45722 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728691AbgF2SlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:41:08 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05TEW5oH024178;
        Mon, 29 Jun 2020 14:44:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=iypkSq/rSFiyRGsyjH0iS+Ob1Ls3Rp3j/D/U0O2SU5s=;
 b=nvAzSY/g7bZDBSUzmHciv+5/ZkwQOpsO19TScPawDZ/68Mn2ZL4kjY/CmZBcy/h5LjKs
 FGujVkDlAhzCMZfbBWlmELIcc+cRGozkHnVIbc/V8hzZF08X03Ct1+RAbdgZ9R5k6j2I
 kn6wKZjGB7one92gJChBiC+1ObpvsIMEXS2X23nxPb0vi9yKRIhQECQTtV2vXZG8e5X8
 Z620UxA0dONhVsg6+H2zFCOyRkwWA9wBrCrkwNEZRnQkA7S3Wq/i434ceoI/x+4wZAle
 b/Zh9YUCaqJtf9qIKZV2+pzcjXBJkWPVAbHARoEVvNxUj5gKLtbwqHoGjEwrOgR4IXOR bg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 31wxrmxv73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 29 Jun 2020 14:44:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05TERhiU157681;
        Mon, 29 Jun 2020 14:44:18 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 31xg1v5363-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Jun 2020 14:44:18 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05TEi8Gv003370;
        Mon, 29 Jun 2020 14:44:08 GMT
Received: from dhcp-10-154-101-2.vpn.oracle.com (/10.154.101.2)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Jun 2020 14:44:08 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.5\))
Subject: Re: [PATCH v9 0/5] support reserving crashkernel above 4G on arm64
 kdump
From:   John Donnelly <john.p.donnelly@oracle.com>
In-Reply-To: <20200628083458.40066-1-chenzhou10@huawei.com>
Date:   Mon, 29 Jun 2020 09:44:06 -0500
Cc:     Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        dyoung@redhat.com, bhe@redhat.com, catalin.marinas@arm.com,
        will@kernel.org, james.morse@arm.com, robh+dt@kernel.org,
        arnd@arndb.de, prabhakar.pkin@gmail.com, nsaenzjulienne@suse.de,
        corbet@lwn.net, bhsharma@redhat.com, horms@verge.net.au,
        guohanjun@huawei.com, xiexiuqi@huawei.com, huawei.libin@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7DE7332B-1431-466A-A1DB-658A8D65F5CE@oracle.com>
References: <20200628083458.40066-1-chenzhou10@huawei.com>
To:     Chen Zhou <chenzhou10@huawei.com>
X-Mailer: Apple Mail (2.3445.9.5)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9666 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006290100
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9666 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1011
 malwarescore=0 phishscore=0 adultscore=0 cotscore=-2147483648
 lowpriorityscore=0 suspectscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006290100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,=20

> On Jun 28, 2020, at 3:34 AM, Chen Zhou <chenzhou10@huawei.com> wrote:
>=20
> This patch series enable reserving crashkernel above 4G in arm64.
>=20
> There are following issues in arm64 kdump:
> 1. We use crashkernel=3DX to reserve crashkernel below 4G, which will =
fail
> when there is no enough low memory.
> 2. Currently, crashkernel=3DY@X can be used to reserve crashkernel =
above 4G,
> in this case, if swiotlb or DMA buffers are required, crash dump =
kernel
> will boot failure because there is no low memory available for =
allocation.
> 3. commit 1a8e1cef7603 ("arm64: use both ZONE_DMA and ZONE_DMA32") =
broken
> the arm64 kdump. If the memory reserved for crash dump kernel falled =
in
> ZONE_DMA32, the devices in crash dump kernel need to use ZONE_DMA will =
alloc
> fail.
>=20
> To solve these issues, introduce crashkernel=3DX,low to reserve =
specified
> size low memory.
> Crashkernel=3DX tries to reserve memory for the crash dump kernel =
under
> 4G. If crashkernel=3DY,low is specified simultaneously, reserve =
spcified
> size low memory for crash kdump kernel devices firstly and then =
reserve
> memory above 4G.
>=20
> When crashkernel is reserved above 4G in memory and crashkernel=3DX,low
> is specified simultaneously, kernel should reserve specified size low =
memory
> for crash dump kernel devices. So there may be two crash kernel =
regions, one
> is below 4G, the other is above 4G.
> In order to distinct from the high region and make no effect to the =
use of
> kexec-tools, rename the low region as "Crash kernel (low)", and pass =
the
> low region by reusing DT property "linux,usable-memory-range". We made =
the low
> memory region as the last range of "linux,usable-memory-range" to keep
> compatibility with existing user-space and older kdump kernels.
>=20
> Besides, we need to modify kexec-tools:
> arm64: support more than one crash kernel regions(see [1])
>=20
> Another update is document about DT property =
'linux,usable-memory-range':
> schemas: update 'linux,usable-memory-range' node schema(see [2])
>=20
> The previous changes and discussions can be retrieved from:
>=20
> Changes since [v8]
> - Reuse DT property "linux,usable-memory-range".
> Suggested by Rob, reuse DT property "linux,usable-memory-range" to =
pass the low
> memory region.
> - Fix kdump broken with ZONE_DMA reintroduced.
> - Update chosen schema.

 =20
  Nice job Chen,=20

  Does this need a Ack-by from the Raspberry maintainers on this =
ZONE_DMA fix  ?

  This activity has been going on for over a year now.  Can we please =
get this finalized and merged ?
=20
 Thank you,
 John.



>=20
> Changes since [v7]
> - Move x86 CRASH_ALIGN to 2M
> Suggested by Dave and do some test, move x86 CRASH_ALIGN to 2M.
> - Update Documentation/devicetree/bindings/chosen.txt.
> Add corresponding documentation to =
Documentation/devicetree/bindings/chosen.txt
> suggested by Arnd.
> - Add Tested-by from Jhon and pk.
>=20
> Changes since [v6]
> - Fix build errors reported by kbuild test robot.
>=20
> Changes since [v5]
> - Move reserve_crashkernel_low() into kernel/crash_core.c.
> - Delete crashkernel=3DX,high.
> - Modify crashkernel=3DX,low.
> If crashkernel=3DX,low is specified simultaneously, reserve spcified =
size low
> memory for crash kdump kernel devices firstly and then reserve memory =
above 4G.
> In addition, rename crashk_low_res as "Crash kernel (low)" for arm64, =
and then
> pass to crash dump kernel by DT property "linux,low-memory-range".
> - Update Documentation/admin-guide/kdump/kdump.rst.
>=20
> Changes since [v4]
> - Reimplement memblock_cap_memory_ranges for multiple ranges by Mike.
>=20
> Changes since [v3]
> - Add memblock_cap_memory_ranges back for multiple ranges.
> - Fix some compiling warnings.
>=20
> Changes since [v2]
> - Split patch "arm64: kdump: support reserving crashkernel above 4G" =
as
> two. Put "move reserve_crashkernel_low() into kexec_core.c" in a =
separate
> patch.
>=20
> Changes since [v1]:
> - Move common reserve_crashkernel_low() code into kernel/kexec_core.c.
> - Remove memblock_cap_memory_ranges() i added in v1 and implement that
> in fdt_enforce_memory_region().
> There are at most two crash kernel regions, for two crash kernel =
regions
> case, we cap the memory range [min(regs[*].start), max(regs[*].end)]
> and then remove the memory range in the middle.
>=20
> [1]: =
https://urldefense.com/v3/__http://lists.infradead.org/pipermail/kexec/202=
0-June/020737.html__;!!GqivPVa7Brio!OnPQrQrzeDmjwp6OTFe3rN1ddb-AUny-Wq5vla=
MfxI3rSentYYQy-2H91dqbw-1A43Ss$=20
> [2]: =
https://urldefense.com/v3/__https://github.com/robherring/dt-schema/pull/1=
9__;!!GqivPVa7Brio!OnPQrQrzeDmjwp6OTFe3rN1ddb-AUny-Wq5vlaMfxI3rSentYYQy-2H=
91dqbw9xTB8yT$ =20
> [v1]: =
https://urldefense.com/v3/__https://lkml.org/lkml/2019/4/2/1174__;!!GqivPV=
a7Brio!OnPQrQrzeDmjwp6OTFe3rN1ddb-AUny-Wq5vlaMfxI3rSentYYQy-2H91dqbw2EAOIh=
M$=20
> [v2]: =
https://urldefense.com/v3/__https://lkml.org/lkml/2019/4/9/86__;!!GqivPVa7=
Brio!OnPQrQrzeDmjwp6OTFe3rN1ddb-AUny-Wq5vlaMfxI3rSentYYQy-2H91dqbwx3ILnLL$=
=20
> [v3]: =
https://urldefense.com/v3/__https://lkml.org/lkml/2019/4/9/306__;!!GqivPVa=
7Brio!OnPQrQrzeDmjwp6OTFe3rN1ddb-AUny-Wq5vlaMfxI3rSentYYQy-2H91dqbw5YJeYoP=
$=20
> [v4]: =
https://urldefense.com/v3/__https://lkml.org/lkml/2019/4/15/273__;!!GqivPV=
a7Brio!OnPQrQrzeDmjwp6OTFe3rN1ddb-AUny-Wq5vlaMfxI3rSentYYQy-2H91dqbwxbryST=
W$=20
> [v5]: =
https://urldefense.com/v3/__https://lkml.org/lkml/2019/5/6/1360__;!!GqivPV=
a7Brio!OnPQrQrzeDmjwp6OTFe3rN1ddb-AUny-Wq5vlaMfxI3rSentYYQy-2H91dqbwzGOGcM=
s$=20
> [v6]: =
https://urldefense.com/v3/__https://lkml.org/lkml/2019/8/30/142__;!!GqivPV=
a7Brio!OnPQrQrzeDmjwp6OTFe3rN1ddb-AUny-Wq5vlaMfxI3rSentYYQy-2H91dqbw70P0bK=
y$=20
> [v7]: =
https://urldefense.com/v3/__https://lkml.org/lkml/2019/12/23/411__;!!GqivP=
Va7Brio!OnPQrQrzeDmjwp6OTFe3rN1ddb-AUny-Wq5vlaMfxI3rSentYYQy-2H91dqbw29m6W=
rh$=20
> [v8]: =
https://urldefense.com/v3/__https://lkml.org/lkml/2020/5/21/213__;!!GqivPV=
a7Brio!OnPQrQrzeDmjwp6OTFe3rN1ddb-AUny-Wq5vlaMfxI3rSentYYQy-2H91dqbw-jGzSc=
F$=20
>=20
> Chen Zhou (5):
>  x86: kdump: move reserve_crashkernel_low() into crash_core.c
>  arm64: kdump: reserve crashkenel above 4G for crash dump kernel
>  arm64: kdump: add memory for devices by DT property
>    linux,usable-memory-range
>  arm64: kdump: fix kdump broken with ZONE_DMA reintroduced
>  kdump: update Documentation about crashkernel on arm64
>=20
> Documentation/admin-guide/kdump/kdump.rst     | 13 ++-
> .../admin-guide/kernel-parameters.txt         | 17 +++-
> arch/arm64/kernel/setup.c                     |  8 +-
> arch/arm64/mm/init.c                          | 74 ++++++++++++---
> arch/x86/kernel/setup.c                       | 66 ++------------
> include/linux/crash_core.h                    |  3 +
> include/linux/kexec.h                         |  2 -
> kernel/crash_core.c                           | 90 +++++++++++++++++++
> kernel/kexec_core.c                           | 17 ----
> 9 files changed, 196 insertions(+), 94 deletions(-)
>=20
> --=20
> 2.20.1
>=20

