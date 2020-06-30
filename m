Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24ECC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A47262067D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="oygIkTzD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgF3TDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 15:03:15 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:13495 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgF3TDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 15:03:15 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efb8c400000>; Tue, 30 Jun 2020 12:02:24 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 30 Jun 2020 12:03:14 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 30 Jun 2020 12:03:14 -0700
Received: from [10.26.75.203] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Jun
 2020 19:03:07 +0000
Subject: Re: [PATCH v8 1/3] iommu/arm-smmu: add NVIDIA implementation for dual
 ARM MMU-500 usage
To:     Krishna Reddy <vdumpa@nvidia.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        "Yu-Huan Hsu" <YHsu@nvidia.com>, Sachin Nikam <Snikam@nvidia.com>,
        Pritesh Raithatha <praithatha@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        Bitan Biswas <bbiswas@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Bryan Huntsman <bhuntsman@nvidia.com>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>
References: <20200630001051.12350-1-vdumpa@nvidia.com>
 <20200630001051.12350-2-vdumpa@nvidia.com>
 <e6da9661-4e62-6e34-ac21-63ff993ca8bc@nvidia.com>
 <BYAPR12MB282210677459B8D62623C642B36F0@BYAPR12MB2822.namprd12.prod.outlook.com>
 <4037efc7-fbed-e8cf-dac7-212c65014e4e@nvidia.com>
 <eb0ffc7e-f41b-d17c-6a90-049335098cd2@nvidia.com>
 <BYAPR12MB2822B43B0218F6E55C97451BB36F0@BYAPR12MB2822.namprd12.prod.outlook.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <64ffa84f-a8cf-ae81-6306-b5d8b1ff0618@nvidia.com>
Date:   Tue, 30 Jun 2020 20:03:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB2822B43B0218F6E55C97451BB36F0@BYAPR12MB2822.namprd12.prod.outlook.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593543744; bh=NSo37Qb0oL3TJClVwPMiygr0t+oa9JglD9JeIRV3gD0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=oygIkTzDFvzDTGmAiQUZwCNND//8nYEOd9JcPxruivrWwg5BWUi2yTMgqfW2Iq0N0
         IR49MR/Eb2tRVzIXK9Mr9i8kpHyfDI4BohtIayTOdAFHUXKa8k5j2J6cx/xmwHdWf1
         hBGMXWvkc/LBrRjZVqPpl47R0zaT1G+6kwgU6EZyjFX8TE4KMbrA/39DZzZjzIMIo4
         ORQztpInF2vPs0KPzR1r0/mSYpqI5SFOLTqkj2IsURh/qhOlRXoWJ3e/HEMrj8A4jF
         uofGKmGbN4yRh+AfpwVDaRxJaJWdiPEY1SAkPaEjvj5VNYSw8Ojh1MAcHAAauhy4dt
         m6kv/m96gFH9w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30/06/2020 18:16, Krishna Reddy wrote:
>> OK, well I see what you are saying, but if we intended to support all 3 for Tegra194, then we should ensure all 3 are initialised correctly.
> 
> The driver intend to support up to 3 instances. It doesn't really mandate that all three instances be present in same DT node.
> Each mmio aperture in "reg" property is an instance here. reg = <inst0_base, size>, <inst1_base, size>, <inst2_base, size>;
> The reg can have all three or less and driver just configures based on reg and it works fine.

So it sounds like we need at least 2 SMMUs (for non-iso and iso) but we
have up to 3 (for Tegra194). So the question is do we have a use-case
where we only use 2 and not 3? If not, then it still seems that we
should require that all 3 are present.

The other problem I see here is that currently the arm-smmu binding
defines the 'reg' with a 'maxItems' of 1, whereas we have 3. I believe
that this will get caught by the 'dt_binding_check' when we try to
populate the binding.

>> It would be better to query the number of SMMUs populated in device-tree and then ensure that all are initialised correctly.
> 
> Getting the IORESOURCE_MEM is the way to count the instances driver need to support.  
> In a way, It is already querying through IORESOURCE_MEM here. 

Yes I was wondering that. I think we just need to decide if the 3rd SMMU
is optional or not. The DT binding should detail and min and max supported.	

Jon

-- 
nvpublic
