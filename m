Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E56C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A03D2085B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="QhA7yD3S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgGASrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 14:47:45 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:15687 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgGASro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 14:47:44 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efcda430001>; Wed, 01 Jul 2020 11:47:31 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 01 Jul 2020 11:47:44 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 01 Jul 2020 11:47:44 -0700
Received: from [10.26.73.166] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 1 Jul
 2020 18:47:38 +0000
Subject: Re: [PATCH v8 2/3] dt-bindings: arm-smmu: Add binding for Tegra194
 SMMU
To:     Krishna Reddy <vdumpa@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
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
 <20200630001051.12350-3-vdumpa@nvidia.com>
 <3e655881-bac4-f083-44ed-cfa0a61298d0@arm.com>
 <BYAPR12MB28222D6ADEBA966AA27FA9ECB36C0@BYAPR12MB2822.namprd12.prod.outlook.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <0d4f46d6-6a4e-bca0-bcf3-0e22a950e57b@nvidia.com>
Date:   Wed, 1 Jul 2020 19:47:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB28222D6ADEBA966AA27FA9ECB36C0@BYAPR12MB2822.namprd12.prod.outlook.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593629251; bh=nLZVfvXpow546Ny83X7PcHnsthMkaf6xSSXWofMs2TM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=QhA7yD3SiAXf8VfDA29dJYVFq4lFOI+mC9BDgt2r9dl8Kvi5BN3aHtHabdaaamiuO
         jjzQYJuItO3tKtk9rmoEvOtkxWCpicS4HjEd7BVS0xuwPflbFglLL25XERE0Kb1kEL
         f+Y4jrWIZX72JtcW6JqTTpoZw3pXpHiWxsOvwV4hUJLzJjYYuYjFQVcPMQjBMHW9m9
         WKLldH2lVQRNPXmjH1h2cdIbrou+EqYPW10a7tsgKPsbU0NKxlCLsLiU9KQV9Mt9O2
         oi4sGee+2uOl6ensDh5tbnu2mxe8ZsTIDTP7tp+wom+uED6UXXT11VsMWpe2BzP4Le
         dYLj68hsZuw8Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01/07/2020 19:28, Krishna Reddy wrote:
>>> +      - description: NVIDIA SoCs that use more than one "arm,mmu-500"
>> Hmm, there must be a better way to word that to express that it only applies to the sets of SMMUs that must be programmed identically, and not any other independent MMU-500s that might also happen to be in the same SoC.
> 
> Let me reword it to "NVIDIA SoCs that must program multiple MMU-500s identically".
> 
>>> +        items:
>>> +          - enum:
>>> +              - nvdia,tegra194-smmu
>>> +          - const: arm,mmu-500
> 
>> Is the fallback compatible appropriate here? If software treats this as a standard MMU-500 it will only program the first instance (because the second isn't presented as a separate MMU-500) - is there any way that isn't going to blow up?
> 
> When compatible is set to both nvidia,tegra194-smmu and arm,mmu-500, implementation override ensure that both instances are programmed. Isn't it? I am not sure I follow your comment fully.

The problem is, if for some reason someone had a Tegra194, but only set
the compatible string to 'arm,mmu-500' it would assume that it was a
normal arm,mmu-500 and only one instance would be programmed. We always
want at least 2 of the 3 instances programmed and so we should only
match 'nvidia,tegra194-smmu'. In fact, I think that we also need to
update the arm_smmu_of_match table to add 'nvidia,tegra194-smmu' with
the data set to &arm_mmu500.

Jon

-- 
nvpublic
