Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3E7C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 21:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DBFA205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 21:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xHNPCx4Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732727AbgCPVv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 17:51:59 -0400
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com ([40.107.236.41]:17380
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732636AbgCPVv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 17:51:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bk6PNT6loKm0oQfyZ1AiR0fR6on/JZraeQHCUqA+U6HXQZKu0TVZLmKd50m0kvvubewnUlQMuz3Cvg7m9Q8w+ay8nKDfGfOHkGyWG3PYI8PRtxh7wukFHEJoa6J1pxpAaYO7gO74rkojfTiZt8OJ2Vb/nRmFb0kWDz+ROAJTmTYlLfQ8Me9WU47COZso0ktUHNYfeyn3wTxV4mD3KoRmyl2TDJBdrqogY7ZCZ98jR4LpvKSFnwCkC2pMvSL7rc4uYqfAIlAdbf37UUYY3/FdaujDDI+KmPDpX3h0rgQwxiG4lngsTrMOFRApcHd6v3y+vz/8kIAomAyfiTj29WCrOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hP5aAKE02oMvx9S8S6LqmRbAl3duOEjPKRuLNhtAfU=;
 b=HymhTP4mrskEnoDKjaqNC2V+hZl+WiDVmw9SGTlBQKOXgFkkez7noU98XT6JDwoihXr/lkyZilBnOHvAuXhRz1zdz600LTQI1V5RFu8pQ4st3G3VQqAji3YmC8d2JAtZtAgXvKWxLYhKcij7ZE8t+1I1ZZfgkkMqN+oZIVUuJvTJNTHxd/JyjD7YtgyZhVn2l2dKXo4vnc7pQo3/bCbCvrDLj9clW7EGZ4kxX9exP6mAED6xb7w3qU4odKA5W6eK8VAjpJ0lx7U/XAK4C/P+ETG1cV66Ps2aHxFvG7mhyyy7NEFoDfEl5H8jvI0Prwmy/0PGfEKyW9Hqyhtf5GM1bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hP5aAKE02oMvx9S8S6LqmRbAl3duOEjPKRuLNhtAfU=;
 b=xHNPCx4QrcBC3SZE39YLF+Wz+cWs8n6MxCOJVS2r9JV26JqIBEICxbPMVdHDtz6XL2/hYq+QDZllNd7paiWiG72Yi/1qo01Jt7vdlwDEY8hcNibm7ubK08znNmks7NajGwLJ8xUdrLg3sE8+bZf3QHUR2BtRJiHOAiAgfBHTZMY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
Received: from SN6PR12MB2845.namprd12.prod.outlook.com (2603:10b6:805:75::33)
 by SN6PR12MB2623.namprd12.prod.outlook.com (2603:10b6:805:6f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Mon, 16 Mar
 2020 21:51:55 +0000
Received: from SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b]) by SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b%7]) with mapi id 15.20.2814.019; Mon, 16 Mar 2020
 21:51:55 +0000
Subject: Re: [PATCH v4 2/3] perf vendor events amd: add Zen2 events
To:     Vijay Thakkar <vijaythakkar@me.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>,
        Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20200314044453.82554-1-vijaythakkar@me.com>
 <20200314044453.82554-3-vijaythakkar@me.com>
From:   Kim Phillips <kim.phillips@amd.com>
Message-ID: <34be3999-34ef-871f-0950-089a00e5b1dd@amd.com>
Date:   Mon, 16 Mar 2020 16:51:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200314044453.82554-3-vijaythakkar@me.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR06CA0071.namprd06.prod.outlook.com
 (2603:10b6:3:37::33) To SN6PR12MB2845.namprd12.prod.outlook.com
 (2603:10b6:805:75::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.136.247] (165.204.77.1) by DM5PR06CA0071.namprd06.prod.outlook.com (2603:10b6:3:37::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22 via Frontend Transport; Mon, 16 Mar 2020 21:51:54 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 778247e1-3da2-4fce-ecb7-08d7c9f43e94
X-MS-TrafficTypeDiagnostic: SN6PR12MB2623:|SN6PR12MB2623:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB26230F56F4AE1B34940E3C0A87F90@SN6PR12MB2623.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 03449D5DD1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(199004)(5660300002)(16526019)(186003)(2906002)(31696002)(86362001)(8676002)(8936002)(26005)(52116002)(4326008)(4744005)(53546011)(44832011)(110136005)(31686004)(956004)(316002)(16576012)(2616005)(7416002)(81156014)(66476007)(478600001)(66556008)(81166006)(36756003)(54906003)(66946007)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2623;H:SN6PR12MB2845.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lan+1i32AQy5KT32U6NKxbbAgCqwfD/FWKOnjyZECaMwtCVi6K4F5AM/fjI8UUMa25iZUG93L8xO1MDQ0bwY2gRm/KH7mDaCd0hPjLukLY1201aSEqQjberhp/Gx2X2L+xIz739ywzr9XC8Uz3rK4iDzPYshfay0HxrkkpjeaJcPzYk5Do9b2nX/5cWNlkxi/vfyAs71pfdk0SFcqA5fifVIc/FQCChKrXXAqvHCR2RSpvLoSwl9EMLXNAEGBzv2P25pnzwAsahY5XXAQndTOE1YFxqlP8bwdOlGaHOStAe/z8ZANtogCsVgsP0vODDGkHUD4Nug3yx8s3KFYcBzn4ee6ZEYlPw/A/Xby/ABH80BSQh/RtXJW7Zbkj27M4LyspiMmmzaqgVozhgmdojSyPni6N1+CwuM6PnuWHAfnK90YZjezDV/5o3vj18vjN10
X-MS-Exchange-AntiSpam-MessageData: ERAX6SkHojfN7vxFJXY6uhBZ3KrSCZdeIjZiHtvfQEoWYZC/vZxjluJoXpRDw6ahe5jsTrNBJ7y82d0tP4rSJ9nF+RPbnCiUTiQ30ofOhSzTauW2FQaN+S0S4xlLQPFLZxLjnPnKAQqTHdC3xvdIsA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 778247e1-3da2-4fce-ecb7-08d7c9f43e94
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 21:51:55.7116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ocdt1Sm7TXGYWvdlwvLf8ONC14Y45pWV/8aQA9aV75B2g2w3qTUwED7c0gMSV++DecvMEDRW8bpz5qpkqioUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2623
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/20 11:44 PM, Vijay Thakkar wrote:
> Signed-off-by: Vijay Thakkar <vijaythakkar@me.com>

This email address differs from patch 1/3's S-o-b:

Signed-off-by: thakkarv <thakkarv@gatech.edu>

Choose one, and please spell your whole name out - Vijay Thakkar.

> +++ b/tools/perf/pmu-events/arch/x86/amdzen2/branch.json
> @@ -0,0 +1,52 @@
> +[
> +  {
> +    "EventName": "bp_l1_btb_correct",
> +    "EventCode": "0x8a",
> +    "BriefDescription": "[L1 Branch Prediction Overrides Existing Prediction (speculative)."

Remove the leading '[' in the BriefDescription string.

Other than the above two nit picks:

Acked-by: Kim Phillips <kim.phillips@amd.com>

Thanks,

Kim
