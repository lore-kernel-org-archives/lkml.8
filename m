Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223C5C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD6562075E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VFFFdjmD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgHZPWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:22:10 -0400
Received: from mail-bn8nam12on2042.outbound.protection.outlook.com ([40.107.237.42]:59873
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726999AbgHZPWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 11:22:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsTxwI8hYSMntIpmjHCqrFl1RIKSqLy5VMJ80oSdqZTAww+km+AGimMmXzcIOqVzkTLNRBdwDXoEe2dsBcBkzNHOY5QeSafkL3CSW9/hcju38ZOrZQKLFgHBexjmepEqvO0+y2wJwsIJJmEi8v7Yz2hoQKJQjf8G+xAtY20m4fXdvwvXdqzC4UlMBH4cPmwa6yqt6gz/ABoXdz8JYgFI5s292plQbx+FIod/UMbYRcyxAw7T9UY4K7xmU5WhHxE1LHSzniPgOHACxrKFUMvzq37ERPCcC0y5bDl+hVaGuo267tghLmLkyRZ/CjEpO+3fg8edxqGIs3cgUbSLxqAwGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tQHKdGudG23SIJjjBh+uLES2iq+PgXhlz8izbCKPf4=;
 b=asgjNwkTkwLvNbBdnk6AT+pjCUU4L3fLHAleNTg3fQQoCR0m3xurEBCm2DJcXcQnVfBpJsdQmdLTNpc6JYSNCPzqAWvR+jRgk6G0R5omWiz8XyN9zIk9tCDW6A1wieHHd73iojhp0KZ1f+MUcfYOnMSJtabEEt+Ub99X/OVoQnG+IwqYVu8Q9RK1180DldaEHAYBymITp4dBX7mS4LocCb8ql7pO9UYEQf6eRwZtXKPe4o6qhqTG/kfkGukLvdGjUaU2EuW9/BSghu9QYI++ZLYXyTSpiyFYr/P0ve3PICVwFw1zOOdh4iAcCnbBc9CufJU3QmStfkFyueSAs06YCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tQHKdGudG23SIJjjBh+uLES2iq+PgXhlz8izbCKPf4=;
 b=VFFFdjmD97NI6MdVA2evm4NW6wc9wn/aDKgclXUEL3wbCfcbQUYW8KNqo7BtDwehTntTYqwoP4NoMoD46NOOMG6fs/78dQboBYctQWmGwfdtxk+cODbRBYpbp4lNf5VcdYLh4idJsIO+MWBWUligQRto6yczjRQU40kfacCTDE4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SA0PR12MB4574.namprd12.prod.outlook.com (2603:10b6:806:94::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Wed, 26 Aug
 2020 15:22:03 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9%7]) with mapi id 15.20.3305.032; Wed, 26 Aug 2020
 15:22:03 +0000
Subject: Re: [PATCH 0/2] iommu/amd: Fix IOMMUv2 devices when SME is active
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Huang, Ray" <ray.huang@amd.com>
Cc:     "jroedel@suse.de" <jroedel@suse.de>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200824105415.21000-1-joro@8bytes.org>
 <MN2PR12MB4488D6B7BBF98845DF796E0BF7540@MN2PR12MB4488.namprd12.prod.outlook.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <34db343f-cd23-09af-3bc5-29b9d385f85d@amd.com>
Date:   Wed, 26 Aug 2020 11:22:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <MN2PR12MB4488D6B7BBF98845DF796E0BF7540@MN2PR12MB4488.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0042.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::11) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by YT1PR01CA0042.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Wed, 26 Aug 2020 15:22:02 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 37f73252-70fe-4f43-b178-08d849d3c900
X-MS-TrafficTypeDiagnostic: SA0PR12MB4574:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4574569FD87929C1ED26302C92540@SA0PR12MB4574.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RdU+IID6MzxhezuvM/Nt8Tldf5B6Ks979awK+dfVt1N7SaDciHkp9cmfT9u6RqOgVTAXGxPSon0jat0kkjVrjEi1MvPwPiCJwOdoIqX18NHSm9tQO0dtamLFBnODh+DwdLASsJZx7yBV6arXoSaGLn6ZxZoFino5I8t4Jh0jj6mfcSTTos0Ovldzko5lw+/GwGSF1QpDZkjX4pYD0i2EwG3BYCNtc2Hab+tApsuvR2PQ+xESLC9k/+FvFHf1tLMSaYcxXtIQo9WQ4ggMPaK/PrATMWpwrbZlXrEBP550b4CVEPnJ2V+ksMA/DRadtW9YUZLmJdZRog/rV9c7kgH200uRt7o7mvaVtyNXRevqBSxHkC1Odb2y4qOELpt+1nth
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2414.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(6636002)(110136005)(2906002)(8676002)(86362001)(4326008)(31696002)(478600001)(316002)(6486002)(16576012)(8936002)(2616005)(36756003)(186003)(83380400001)(66476007)(31686004)(66946007)(52116002)(54906003)(5660300002)(26005)(66556008)(44832011)(956004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: l9sh78XTEvu4Gyy7ZjsQxcoXQ297MchS0ffLybLKoxiN4R3+0KFwnC6t2PvS5/3+5xKCqrbZV4b73dDjGe7Khdc8KK1HA1AVavChiMaSLLhgjJjBkzRMZvqU14bDGOfdM8uofcI1xtz1/3ICNPxaP/3Zv58HRvi3+vynF7uWu9vb2qFJ3PYbpj4+qVAPmGt2vwN1qrxMTk/79HFWikzPvLKBDDY5jzO2v4/I8ucSTsjPX7lro2SBG8+YkICcCqU1J3/PJ4oajHAhaGS3mI/iyGpL72z9mVQylv9d/5mDYqPsHF1NhGDyVrL3vUjwqra0dqI5SNQaA2FBnh82rAyShE9DIgCEY4FsjN3ibOJCROxRgrz4jnnUEWjM85tIajxg0JApFk2DOIAF8JpJ7pI/Or58mgtziktRXsY4WTyAU5QdR5KTWHmWPWnJtgmBD6rdmy2ZYnp8NC8Dprdf0ITk82kcu2lzAPfa9J8XcfU7/OJNKBBF0KuPmSNXf47GfRRx4F28EV3UpjXohw8KVxeuoV+BZPYS6G+nkseEeyguJ4hA6AWYc6WPdCDoxJ/j47EHFMcLY7kpkcNdeLzhmYXGbXm/CMbB05A3lXQK4/vCvdpNO1+plzU87npTUEEWfpmA/JLRUuqmAJquevXth4GjwQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f73252-70fe-4f43-b178-08d849d3c900
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 15:22:03.4286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uBj+JI6DJknJRqEHHVFJxhsJZiwZn3aLTflZMEjKK4qYC5HEs+4I+ed6z73NKhqLg7Znt2JvCfWGpv0SxtF5SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4574
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Ray]


Thanks for the heads up. Currently KFD won't work on APUs when IOMMUv2
is disabled. But Ray is working on fallbacks that will allow KFD to work
on APUs even without IOMMUv2, similar to our dGPUs. Along with changes
in ROCm user mode, those fallbacks are necessary for making ROCm on APUs
generally useful.


How common is SME on typical PCs or laptops that would use AMD APUs?


Alex, do you know if anyone has tested amdgpu on an APU with SME
enabled? Is this considered something we support?


Thanks,
  Felix


Am 2020-08-26 um 10:14 a.m. schrieb Deucher, Alexander:
>
> [AMD Official Use Only - Internal Distribution Only]
>
>
> + Felix
> ------------------------------------------------------------------------
> *From:* Joerg Roedel <joro@8bytes.org>
> *Sent:* Monday, August 24, 2020 6:54 AM
> *To:* iommu@lists.linux-foundation.org <iommu@lists.linux-foundation.org>
> *Cc:* Joerg Roedel <joro@8bytes.org>; jroedel@suse.de
> <jroedel@suse.de>; Lendacky, Thomas <Thomas.Lendacky@amd.com>;
> Suthikulpanit, Suravee <Suravee.Suthikulpanit@amd.com>; Deucher,
> Alexander <Alexander.Deucher@amd.com>; linux-kernel@vger.kernel.org
> <linux-kernel@vger.kernel.org>
> *Subject:* [PATCH 0/2] iommu/amd: Fix IOMMUv2 devices when SME is active
>  
> From: Joerg Roedel <jroedel@suse.de>
>
> Hi,
>
> Some IOMMUv2 capable devices do not work correctly when SME is
> active, because their DMA mask does not include the encryption bit, so
> that they can not DMA to encrypted memory directly.
>
> The IOMMU can jump in here, but the AMD IOMMU driver puts IOMMUv2
> capable devices into an identity mapped domain. Fix that by not
> forcing an identity mapped domain on devices when SME is active and
> forbid using their IOMMUv2 functionality.
>
> Please review.
>
> Thanks,
>
>         Joerg
>
> Joerg Roedel (2):
>   iommu/amd: Do not force direct mapping when SME is active
>   iommu/amd: Do not use IOMMUv2 functionality when SME is active
>
>  drivers/iommu/amd/iommu.c    | 7 ++++++-
>  drivers/iommu/amd/iommu_v2.c | 7 +++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> -- 
> 2.28.0
>
