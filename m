Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE93C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 15:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76D0F2074F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 15:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="q9Bxtrvg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389376AbgF3PRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:17:55 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:13063 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729565AbgF3PRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 11:17:55 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efb57700000>; Tue, 30 Jun 2020 08:17:04 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 30 Jun 2020 08:17:54 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 30 Jun 2020 08:17:54 -0700
Received: from [10.26.75.203] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Jun
 2020 15:17:47 +0000
Subject: Re: [PATCH v8 1/3] iommu/arm-smmu: add NVIDIA implementation for dual
 ARM MMU-500 usage
To:     Robin Murphy <robin.murphy@arm.com>,
        Krishna Reddy <vdumpa@nvidia.com>
CC:     <snikam@nvidia.com>, <nicoleotsuka@gmail.com>,
        <mperttunen@nvidia.com>, <bhuntsman@nvidia.com>, <will@kernel.org>,
        <linux-kernel@vger.kernel.org>, <praithatha@nvidia.com>,
        <talho@nvidia.com>, <iommu@lists.linux-foundation.org>,
        <nicolinc@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <yhsu@nvidia.com>, <treding@nvidia.com>,
        <linux-arm-kernel@lists.infradead.org>, <bbiswas@nvidia.com>
References: <20200630001051.12350-1-vdumpa@nvidia.com>
 <20200630001051.12350-2-vdumpa@nvidia.com>
 <53bfa5c8-c32d-6fa3-df60-a18ab33ca1c2@nvidia.com>
 <d59b7220-168c-419f-db16-194307e11065@arm.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <a9d6b11b-d904-153a-6363-6e3a8f62e03f@nvidia.com>
Date:   Tue, 30 Jun 2020 16:17:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <d59b7220-168c-419f-db16-194307e11065@arm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593530224; bh=91KsOAnm+BDzvr6bvaKraTo/wHSaB0sGjCjoXk18ABA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=q9BxtrvgjxBZFZAUIswW2E+r9jYacMdtRAXU31UzobonciMILCOiTgOrglSBJWXOC
         Nw3Ld3OJhRkalYzLHH6M6kaQEDByt/jtTjFRrLnlErsAZMdnejdtXGLw1KUiIWGYpb
         xAYw9H68xASCHxw1KB8ySRZZPWT/UC0ykO89X7KdmPhuSFwModgBnGKcX3mANhq4cA
         1jUaHUwaV277q2HZRs76LVNMDr7HqpnG3uB5TjwjQR+mgZW16EGe8bO4ySAU87ovHL
         KC7amklSwvERe8WmBdhZcfamoWB3m75rZDrJSuvtt9Sh3dSz214FWxGsEZkOkFxGhS
         u+d/2ZM3DBT1A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30/06/2020 15:53, Robin Murphy wrote:
> On 2020-06-30 09:19, Jon Hunter wrote:
>>
>> On 30/06/2020 01:10, Krishna Reddy wrote:
>>> NVIDIA's Tegra194 SoC uses two ARM MMU-500s together to interleave
>>> IOVA accesses across them.
>>> Add NVIDIA implementation for dual ARM MMU-500s and add new compatible
>>> string for Tegra194 SoC SMMU topology.
>>
>> There is no description here of the 3rd SMMU that you mention below.
>> I think that we should describe the full picture here.
>> =C2=A0
>>> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>

...

>>> +static void nvidia_smmu_tlb_sync(struct arm_smmu_device *smmu, int
>>> page,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 int sync, int status)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 unsigned int delay;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 arm_smmu_writel(smmu, page, sync, 0);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 for (delay =3D 1; delay < TLB_LOOP_TIMEOUT_IN_US; d=
elay *=3D 2) {
>>
>> So we are doubling the delay every time? Is this better than just using
>> the same on each loop?
>=20
> This is the same logic as the main driver (see 8513c8930069) - the sync
> is expected to complete relatively quickly, hence why we have the inner
> spin loop to avoid the delay entirely in the typical case, and the
> longer it's taking, the more likely it is that something's wrong and it
> will never complete anyway. Realistically, a heavily loaded SMMU at a
> modest clock rate might take us through a couple of iterations of the
> outer loop, but beyond that we're pretty much just killing time until we
> declare it wedged and give up, and by then there's not much point in
> burning power frantically hamering on the interconnect.

Ah OK. Then maybe we should move the definitions for TLB_LOOP_TIMEOUT
and TLB_SPIN_COUNT into the arm-smmu.h so that we can use them directly
in this file instead of redefining them. Then it maybe clear that these
are part of the main driver.

 >>> +struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device
>>> *smmu)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 unsigned int i;
>>> +=C2=A0=C2=A0=C2=A0 struct nvidia_smmu *nvidia_smmu;
>>> +=C2=A0=C2=A0=C2=A0 struct platform_device *pdev =3D to_platform_device=
(smmu->dev);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 nvidia_smmu =3D devm_kzalloc(smmu->dev, sizeof(*nvi=
dia_smmu),
>>> GFP_KERNEL);
>>> +=C2=A0=C2=A0=C2=A0 if (!nvidia_smmu)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ERR_PTR(-ENOMEM);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 nvidia_smmu->smmu =3D *smmu;
>>> +=C2=A0=C2=A0=C2=A0 /* Instance 0 is ioremapped by arm-smmu.c after thi=
s function
>>> returns */
>>> +=C2=A0=C2=A0=C2=A0 nvidia_smmu->num_inst =3D 1;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 for (i =3D 1; i < MAX_SMMU_INSTANCES; i++) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct resource *res;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 res =3D platform_get_resour=
ce(pdev, IORESOURCE_MEM, i);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!res)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bre=
ak;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nvidia_smmu->bases[i] =3D d=
evm_ioremap_resource(smmu->dev, res);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(nvidia_smmu->bas=
es[i]))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn ERR_CAST(nvidia_smmu->bases[i]);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nvidia_smmu->num_inst++;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 nvidia_smmu->smmu.impl =3D &nvidia_smmu_impl;
>>> +=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Free the arm_smmu_device struct allocated i=
n arm-smmu.c.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Once this function returns, arm-smmu.c woul=
d use arm_smmu_device
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * allocated as part of nvidia_smmu struct.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 devm_kfree(smmu->dev, smmu);
>>
>> Why don't we just store the pointer of the smmu struct passed to this
>> function
>> in the nvidia_smmu struct and then we do not need to free this here.
>> In other
>> words make ...
>>
>> =C2=A0 struct nvidia_smmu {
>> =C2=A0=C2=A0=C2=A0=C2=A0struct arm_smmu_device=C2=A0=C2=A0=C2=A0 *smmu;
>> =C2=A0=C2=A0=C2=A0=C2=A0unsigned int=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 num_inst;
>> =C2=A0=C2=A0=C2=A0=C2=A0void __iomem=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 *bases[MAX_SMMU_INSTANCES];
>> =C2=A0 };
>>
>> This seems more appropriate, than copying the struct and freeing memory
>> allocated else-where.
>=20
> But then how do you get back to struct nvidia_smmu given just a pointer
> to struct arm_smmu_device?

Ah yes of course that is what I was missing. I wondered what was going
on here. So I think we should add a nice comment in the above function
of why we are copying this and cannot simply store the pointer.

Cheers
Jon

--=20
nvpublic
