Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C28C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 20:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60801205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 20:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="i7S3ZZgs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388030AbgEMUEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 16:04:04 -0400
Received: from mail-eopbgr760047.outbound.protection.outlook.com ([40.107.76.47]:53189
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733117AbgEMUED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 16:04:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmbXVoXPA+rpRzrWF6rLJXIIgccjJ/7a1/MHSbyMWLy2AAfW+PAwrMqTesnULrBxxzswrvNBNV5x7Dw0Qkc5NgVuJGNMHUW9bI8zemaPb880mydsEg7ywRx+r0Ufzo4N4d8Gu/iH3nfV/LGeEb5IWVxAKoWo/mdXW06Mh9dQfRAVdWZY/pd1UyLNn2m392IsUY2wqc7HiyVGEc9Dctii3hj/0hXlJOigQOvY0PolUIXVMT+jVWd9jD0hkI9y+7xQOsK7HGQ/iSIgFI0ODIuhbl4cOv4hDk0YIZMcoihXCIloclX4n8680CF2RMsylAm1/GaDdOiG50Vlb5H8xpxc0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuG3vqVSWDRHyegkjYzc6GeJ+wqoA2KANOAoAvQE3Yg=;
 b=oeyw60IJzmyJj2pBDnTyAhVnHcSZXWPBNO+WjpHqPr8HrC18rNDbMEAzs1FVHBpbqMvJO+uXhVd+W6NU/OeBJQIDrFauuQ/NlgFzdhEDcwGBAZG2vZt5eUNNtNFGsurCuwQl60N0liood6rR39Rm9RC8ndewwGUFhEu/RyUGo6laeMf58ymFLYs8sF+nT54lWXFd2d6ESZ3gRPSWUnazZxmEr/lUfkvdQFsnO0wznj1aB+JY7mNX8lNUblE3T7nKLZ5CXL2aZ/3ISk7OpfjqPaGx8JLAPVeUBh+3dIgubRoFjfJMzuhbZHWL0UyY+NPOIbvWF9j8X+KRWHTApeCmkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuG3vqVSWDRHyegkjYzc6GeJ+wqoA2KANOAoAvQE3Yg=;
 b=i7S3ZZgsjfsbpAX3vUHcw5T4Ev06iuODHY/Ks7znwbTAy8n7Ihtvqst1Q4eu3ZEl9xUuolGjeef1+1kuZoAGZ+kMwjIyEBg8ZeMr8/By2y3M61YOV8MEaW8dWzyn2t+tA/EDyVIWuulmKA7Bewn5HEfJh2Zhyma39xNy32Y1+iI=
Authentication-Results: zytor.com; dkim=none (message not signed)
 header.d=none;zytor.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2352.namprd12.prod.outlook.com (2603:10b6:802:25::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Wed, 13 May
 2020 20:04:00 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::c0f:2938:784f:ed8d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::c0f:2938:784f:ed8d%7]) with mapi id 15.20.3000.022; Wed, 13 May 2020
 20:04:00 +0000
Subject: RE: [PATCH v2 09/10] x86/resctrl: Add arch_has_sparse_bitmaps to
 explain AMD/Intel CAT difference
To:     Reinette Chatre <reinette.chatre@intel.com>,
        James Morse <james.morse@arm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>
References: <20200430170400.21501-1-james.morse@arm.com>
 <20200430170400.21501-10-james.morse@arm.com>
 <8383ddd9-5849-d948-c391-aeb0cc927423@intel.com>
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <980a693a-b823-96e1-9b4f-d7bbf4f09714@amd.com>
Date:   Wed, 13 May 2020 15:03:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <8383ddd9-5849-d948-c391-aeb0cc927423@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM5PR17CA0059.namprd17.prod.outlook.com
 (2603:10b6:3:13f::21) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.87] (165.204.77.1) by DM5PR17CA0059.namprd17.prod.outlook.com (2603:10b6:3:13f::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Wed, 13 May 2020 20:03:58 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 55cac04e-c07a-421f-ec06-08d7f778c6b6
X-MS-TrafficTypeDiagnostic: SN1PR12MB2352:
X-Microsoft-Antispam-PRVS: <SN1PR12MB235283EE129C9D62E80039AB95BF0@SN1PR12MB2352.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0402872DA1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Un8nTROHKySk8jbJ5oBEDzKb7DcSzCqLGCQpA3FUVbxy6+GGDtq+uNLkBYfBE7IETSCX9m6hvVOxMlud4zrqloEKN+AQALyBH3CgyZcjKg4vhZtwC11TOUp/SkqDGJlnj+StuVzwW9+Io0xAucGQGAXRq1l4b1qgcZxNexNrhcBxM2xe6jwqKupZ1+540pmnQmqyhoX48ZRCH8lxMyJ+yFk3KT1dkVJ4PHNfFgYATxadWKj2BlH028b8UIBx4fIZDDdb/iT1HiHpyEpdByZL4nW8NjQFfRmwkqj2puCBqtPBwXDf9B9XUpcRoycANZ2sxgR4Q7+w4K1pcrUv6/zeYxT3ZNmosrAdA+dShRXDsJ+/ikL3v+COHct+jLkbENM4DxSTOhP64cOclnsBeQJjpsqnYlClBmKv2/zxnTakkGKyUgs/ZJu8CZz7AQJ4ThdbLvLD+hSmOfTgsW2uKoBDCf4x6KbThingQ4weCrQ5zypAJpqZ+AGzaGt5q56ugn7G5yuxosHJwIvF7P4n9KCsrMDQ+nvsJfdT6+35lvc0gcIOZN/lLl2lpSZJRvBOJqpu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(33430700001)(110136005)(6486002)(16576012)(33440700001)(44832011)(31696002)(66556008)(4326008)(66476007)(316002)(478600001)(31686004)(54906003)(8676002)(956004)(2906002)(36756003)(86362001)(186003)(2616005)(53546011)(8936002)(26005)(52116002)(16526019)(66946007)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: HxnJgKIXlzV1RTo8vCub89zMaXTKGZ7ckMu74rlULSgfBT1OZmIthee5u8lxwDP1AGNfEUQspJ97ax6A8HiE28tmyNEGszvp7sAPkYIJVHFncEuoikSUfXm93d2/Ob76yvORX0GQieVKS5h88mITP7ilgUuH0YLOb3pj4I3zdXkt1OFkfdbsNBrFUyHX89H/+zHnZZQcTaDpjIRpqnCQGlc8zYXZqUvqVaEvPBe+Zk0FXv0bNn46fFE9/NChPgmgmSL4THMobr00UWFQZHv52F3tf+vm/t5JzoFWN/SUFFkfS+BIVM+PNuZ0WVWTpjZtqVjtZeXXbNPjTtYkDbL60k1naEdEWUzokW467bPj0/iKNA9+W8Rh8/oCZ2g3ZtoYKZAxgOQaz27GnoBmAVTJHsOw6wZwiw7K9net4sJ8U+uQhsVYIAxD3i+XQzdYUE17HliYu2DJOTgYNuoYUwCtryTiHoYu1uKX5UdqQAIjCqM=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55cac04e-c07a-421f-ec06-08d7f778c6b6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2020 20:03:59.9796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7l6fH7ifX4K+cCUOHFxjQ6cA4HxIEo/kv449KMA/2+hRm4RV3tSk1PEtoxieKHxX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2352
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Reinette Chatre <reinette.chatre@intel.com>
> Sent: Monday, May 11, 2020 1:15 PM
> To: James Morse <james.morse@arm.com>; x86@kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Fenghua Yu <fenghua.yu@intel.com>; Thomas Gleixner
> <tglx@linutronix.de>; Ingo Molnar <mingo@redhat.com>; Borislav Petkov
> <bp@alien8.de>; H Peter Anvin <hpa@zytor.com>; Moger, Babu
> <Babu.Moger@amd.com>
> Subject: Re: [PATCH v2 09/10] x86/resctrl: Add arch_has_sparse_bitmaps to
> explain AMD/Intel CAT difference
> 
> Hi James,
> 
> On 4/30/2020 10:03 AM, James Morse wrote:
> > Intel expects the cache bitmap provided by user-space to have on a
> > single span of 1s, whereas AMD can support bitmaps like 0xf00f.
> > Arm's MPAM support also allows sparse bitmaps.
> >
> > To move resctrl out to /fs/ we need to explain platform differences
> > like this. Add a resource property arch_has_sparse_bitmaps. Test this
> > around the 'non-consecutive' test in cbm_validate().
> >
> > Merging the validate calls causes AMD top gain the min_cbm_bits test
> > needed for Haswell, but as it always sets this value to 1, it will
> > never match.
> >
> > CC: Babu Moger <Babu.Moger@amd.com>
> > Signed-off-by: James Morse <james.morse@arm.com>
> > Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> 
> The Intel bits do indeed look good to me but we should check the AMD
> portion ... I peeked at the AMD spec [1] and found "If an L3_MASK_n
> register is programmed with all 0’s, that COS will be prevented from
> allocating any lines in the L3 cache" ... so AMD does allow bitmasks of
> all 0's (Intel does not).
> 
> Does MPAM also allow all 0's? Perhaps "arch_has_sparse_bitmaps" can be
> used to indicate that also?

That is right. AMD allows  L3 mask be all 0s.  I will be great if this
property can be indicated it here. Thanks
