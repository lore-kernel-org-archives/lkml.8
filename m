Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F142BC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE452467D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bXUT9GX0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730261AbgCJNBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:01:24 -0400
Received: from mail-co1nam11on2080.outbound.protection.outlook.com ([40.107.220.80]:6144
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729951AbgCJNBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:01:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebE9AGLRbgPppO97jUtUOGF8Ls+3v+gg41VGPDEOqDMKCSWqW9rad9zueLdxb5AwVq3AN0LUpRxabllrdjyj7srZFM7pQVALeEG7eDUn3mSHHhDu7VNb5n9+vfdKwoj52srl4suGyLTzlKHxPO0CGpQtAYIMCvACDH8Dhia1pTW4e5DYBU0NEmd7OtnqQGNgNERT7E7TjvGHVzHVWy3cZ3HozRBBn3tkhBAuXNRhs8vAvOxG4N8RtYPR87qTV41wjdMbHgB88WabfL2G0Jg6lTvp8y6Prh/VcNZqBvC0VXzVs5G02sdTiMfnbZYAPo6SIVPWWG4QzmBrOgdD2x4XnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3DAaJlOB3m7QyjhiB1YEhKbeHSld0Pi0f/yFT+Coqc=;
 b=nIA77GO3I6+x8JhbyR3+qhNqKy9hwP/7TtW1ok4ZcUi1/ccgGWxSi9cP78mMhVhwr1sjTdtxBgP4dMzA6SL6J97oWdA2Tn5kXzx44idO9jdqJyicUtXWr2mi8LHogeE3K+IChGnyvND+PdlK4QiPqVpACweXEkWRwI/I+FxbHRcr0KuV2ttRBOffVVvxj9uqTzgcgOHTrI8wRkg76gCHJjSCOm+jmvBL1H3itPMTPgmS4d2s4216ijkWOHI1IGXTXF/GiKeGEbWptMDA3icZq3+TRGF11fSIN8+tOpbdBTi0Ek6vY+vjXEqPutrHJEPW+Tvexz5yMoqhOzd48kIfgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3DAaJlOB3m7QyjhiB1YEhKbeHSld0Pi0f/yFT+Coqc=;
 b=bXUT9GX0e8fQ8etjB40Y5etSlCX/Zp0WxO13O7tm7tL9KbaJr/7MZsKD7dWeKAlCr1xsmX2EXeL7cl1xG8XVorqk/wTf6lEzIJO3mG2VAZu6VDLT0za+wYUZKJeU3uMyl8VBtICfgUykKMieAOyks1xB6gFqm//rjYY+x++gVkw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mikita.Lipski@amd.com; 
Received: from DM6PR12MB2906.namprd12.prod.outlook.com (2603:10b6:5:15f::20)
 by DM6PR12MB4563.namprd12.prod.outlook.com (2603:10b6:5:28e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Tue, 10 Mar
 2020 13:01:14 +0000
Received: from DM6PR12MB2906.namprd12.prod.outlook.com
 ([fe80::cd57:c685:c45c:8c07]) by DM6PR12MB2906.namprd12.prod.outlook.com
 ([fe80::cd57:c685:c45c:8c07%6]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 13:01:14 +0000
Subject: Re: [PATCH v2 0/4] drm/dp_mst: Fix bandwidth checking regressions
 from DSC patches
To:     Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     Mikita Lipski <mikita.lipski@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sean Paul <seanpaul@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>
References: <20200306234623.547525-1-lyude@redhat.com>
From:   Mikita Lipski <mlipski@amd.com>
Organization: AMD
Message-ID: <11954bfb-7ab9-19bf-9c8d-6fb2d6a647bd@amd.com>
Date:   Tue, 10 Mar 2020 09:01:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200306234623.547525-1-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::26) To DM6PR12MB2906.namprd12.prod.outlook.com
 (2603:10b6:5:15f::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.29.224.72] (165.204.55.250) by YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14 via Frontend Transport; Tue, 10 Mar 2020 13:01:13 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 05c06a0e-4f89-47d0-7824-08d7c4f31d0e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4563:|DM6PR12MB4563:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB45632B1B06AA1FF3DA25B0E6E4FF0@DM6PR12MB4563.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(199004)(189003)(186003)(16526019)(2616005)(956004)(31696002)(26005)(6486002)(36756003)(7416002)(66476007)(36916002)(81166006)(54906003)(16576012)(478600001)(316002)(52116002)(31686004)(81156014)(53546011)(66556008)(5660300002)(66946007)(2906002)(4326008)(8936002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB4563;H:DM6PR12MB2906.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mdahrCD/MtkkbEaiOyP6n5bhgCapf7Wbg0mIR+iDCOizhNsFfrWLSr+je6SQn1r0rFjcYZ8keyPeNN13vLIxIhVKCvvX3TnE5gp8Y/DBYQb2thU4Qcc9tw8Mbb/TlV/MnOGsO9oYE8/6IKEY90KGy6RxJmge2qnQ9/IfZZVydtzMLQVUqyXaCIptvQHJFUIIRyaibHmNtKhoO/ks5bPWxZyqJyuhPFJx9ANe3caYJa2PCbjO+eRVexDJ6zB8NWnnmgeHNQCLWljoeyhOQUTfw1uIRgk96cOaTVJOk5bZMlcYx1UX4z6HH28+Z2I4WCA0ypiu11dUlLvMWHvJDBoCCNfSwXNhcbnRUHc/oe/4cdLjizc0xxiZWeTOmFEVDQyhRcxBR3GYtyJQxKqdpEJbfd/d2u/31ji8eZ3Z2AD3LLsKx2QIaG0ExnYk3OgT5fcW
X-MS-Exchange-AntiSpam-MessageData: h0zJ77AMAgpKYfwhvonVFTrDF+0cBT3kRO7gfiSG+48V8vQ51T3ORDh6/qVqypRbPDatHzuuWjmhu+bDKBpFCJlX/iagXFOAZ4ECAB3Ylz3dsqut7c2vseAhAksbrZoP2dDfQWYcDbIvWhJLemyidQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c06a0e-4f89-47d0-7824-08d7c4f31d0e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 13:01:14.1378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zK+NhLg7+/J4Cykk/68q7vdbxty8UjNX1PL3ghsnou1w2hAhGpt+ftmuThA6XczF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4563
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/6/20 6:46 PM, Lyude Paul wrote:
> AMD's patch series for adding DSC support to the MST helpers
> unfortunately introduced a few regressions into the kernel that I didn't
> get around to fixing until just now. I would have reverted the changes
> earlier, but seeing as that would have reverted all of amd's DSC support
> + everything that was done on top of that I realllllly wanted to avoid
> doing that.
> 
> Anyway, this should fix everything bandwidth-check related as far as I
> can tell (I found some other regressions unrelated to AMD's DSC patches
> which I'll be sending out patches for shortly). Note that I don't have
> any DSC displays locally yet, so if someone from AMD could sanity check
> this I would appreciate it ♥.

The series is tested and verified with MST DSC Realtek board.
Tested-by: Mikita Lipski <mikita.lipski@amd.com>

> 
> Cc: Mikita Lipski <mikita.lipski@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Sean Paul <seanpaul@google.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> 
> Lyude Paul (4):
>    drm/dp_mst: Rename drm_dp_mst_is_dp_mst_end_device() to be less
>      redundant
>    drm/dp_mst: Use full_pbn instead of available_pbn for bandwidth checks
>    drm/dp_mst: Reprobe path resources in CSN handler
>    drm/dp_mst: Rewrite and fix bandwidth limit checks
> 
>   drivers/gpu/drm/drm_dp_mst_topology.c | 185 ++++++++++++++++++--------
>   include/drm/drm_dp_mst_helper.h       |   4 +-
>   2 files changed, 129 insertions(+), 60 deletions(-)
> 

-- 
Thanks,
Mikita Lipski
Software Engineer 2, AMD
mikita.lipski@amd.com
