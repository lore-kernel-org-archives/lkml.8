Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51457C2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 19:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2909520719
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 19:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MqSe8fIW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388960AbgDBTIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 15:08:01 -0400
Received: from mail-bn8nam11on2050.outbound.protection.outlook.com ([40.107.236.50]:34238
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732598AbgDBTIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 15:08:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llIc3YCjZkmyNN5o0aNvQfN+osYIbIWsu2Upyi6+V9y7u4jLR/6iqoEmg44owMYvHHzpb/KHD4fNXENlmShXk/PYRIUGNzbdiQO0wKvU78GRoz3wcEar41dW+4Yy4+zFQ54kZBlFBAx+Rax1Sk6hXhx6ZNmCnMhKOTCa/5RxI9g+Hg5hmdXOZXP6TH8585g/YHtUBYO+6YR3dbPEY2ZuwazeWVPMjhItw92OIcsu9BAYcjfCoOJBr+x2LOSI4wYQ/+5nI4o57kW8tNA03CDcBwl2nwIzi1Ihh0zqWr9H9Neny/eHpDyIKNrbhEHg813Z70VaTTZZoDoVv157gvo5yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNEe0beCXYSDjfBtQ3gndhOngMgyAESRPXxPNqsukK0=;
 b=DE+/OIp253OVORfSUehSShup79KW4V+7QOEmyj//sVfqA+Sgnj2Dw27PrJllazRzsXpB13LFvKe0y/maa1GeX9bCzqWS1yTql/HBdCrWrt+yVYoY/1/y4uVyuyx1EJ7Gcp7Sg0Kk5YVW5uwPK3Ih5ZZ+qi6wc8Y22wsV15zlAbXFNwtbODKtsrDvmQSVk838cF+YyrqE6mjZ3uHAyqMtUg5gOyk6lTs3K1XvNnX1hunhrKkpjACoauqs1zTNi9vb4mHJFgZ2rUO/PFaDqEobAxEIkuIQOabPxAocJUDGFlmNlgxPgPlwe865fMvd/UAKQmD3itQ1okW6W/KFlq1Cow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNEe0beCXYSDjfBtQ3gndhOngMgyAESRPXxPNqsukK0=;
 b=MqSe8fIWCUDRpkqSD3PBruMcqk0AJeF5Z9I+IuFUtJqR7KxKfNJZywEAi1j7fn8cKB2sQyuu8Qdtx3nzm/+icE1w9Cfv6CCMZqCGt12aQOt/mrJvGgfVvvhWP/4chS4zA2WZvOfMOysx2wk5YJ1VqUFDs++UT3jttRKs42lWl/E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
Received: from SN6PR12MB2845.namprd12.prod.outlook.com (2603:10b6:805:75::33)
 by SN6PR12MB2750.namprd12.prod.outlook.com (2603:10b6:805:77::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Thu, 2 Apr
 2020 19:07:57 +0000
Received: from SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::654c:5d93:fd49:88b3]) by SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::654c:5d93:fd49:88b3%4]) with mapi id 15.20.2878.017; Thu, 2 Apr 2020
 19:07:56 +0000
Subject: Re: [PATCH] perf script report: fix segfault when using DWARF mode
To:     Andreas Gerstmayr <agerstmayr@redhat.com>,
        linux-perf-users@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <05e0d633-54b4-fb3b-3d08-8963271017ea@amd.com>
 <20200402125417.422232-1-agerstmayr@redhat.com>
From:   Kim Phillips <kim.phillips@amd.com>
Message-ID: <6a098ce1-1981-dcff-ea62-af5fc07ec7fb@amd.com>
Date:   Thu, 2 Apr 2020 14:07:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200402125417.422232-1-agerstmayr@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN6PR1201CA0006.namprd12.prod.outlook.com
 (2603:10b6:405:4c::16) To SN6PR12MB2845.namprd12.prod.outlook.com
 (2603:10b6:805:75::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.0.18] (165.204.84.11) by BN6PR1201CA0006.namprd12.prod.outlook.com (2603:10b6:405:4c::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend Transport; Thu, 2 Apr 2020 19:07:54 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 47d680ef-08c5-4504-d337-08d7d7392708
X-MS-TrafficTypeDiagnostic: SN6PR12MB2750:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2750BD125BC8483BBE13511A87C60@SN6PR12MB2750.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 0361212EA8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2845.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(6666004)(54906003)(6486002)(66556008)(4744005)(66476007)(478600001)(66946007)(16576012)(2906002)(5660300002)(8676002)(31696002)(36756003)(956004)(86362001)(4326008)(81156014)(16526019)(31686004)(81166006)(316002)(7416002)(53546011)(52116002)(44832011)(26005)(186003)(8936002)(2616005);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GOp7OrvVtCVG5TuxQVu4f+MbBtovrXrpaSqV4yGsl6xNa3/OH7w/zgtlSI8z9XVAk6Tyl3LRHWa70sVDhQogNybgA+dj1jP3PDTe0U6He3WGvOig9Um0SEx7Zuj4ojZs1A1rhjXTIhHgQA6k1n9ReKBnMU9bZRW9n4hnVVR6B63JnfvaSGIFfNjdbKH38n/DyCC+FmeS8U7/48WtKzNDt0WVpkF9z7W3D8uSWnuOR8cVX+MwIpPFkP1m8zvhRU0Hm1XFr3NSd5r4FXokoOjx3DfKibzbyeXm9MC/fviHofMp0uOX2x8HzZK8VaM5ifpRAiciaFMGFcMOKyqDdtVfDr5hTy/IpYXYrdHUD+G29j3wdzCpsEDivay4/jy7kTF+U6MWrZM3Jy31FSaFbsWzqmxPk0VU8VULPO1xqTsubmKbk5RLWZklG3oSORqoV27j
X-MS-Exchange-AntiSpam-MessageData: /DIshPDhnKNhgp7WP2RgziDCP8SLJCjnSq/9PvMxARf/rMMoXA+KyT8alnHRh+5Cm37WAG/4bfOU+CxttQM0m6uDwscr7f/gS9iyrCDEyVBnHYgUidG3uzAtSkp24qM5PbystuLpBT+D/M7dv1KKhw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d680ef-08c5-4504-d337-08d7d7392708
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2020 19:07:56.7570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eGt0ftC/GSCO67a+NvQvOQ5PfgPnNe0UfIE+X509lupyCq9n8zMDrH7TQVDBHdsMbLRul88ATEauCDecCsM0mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2750
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/20 7:54 AM, Andreas Gerstmayr wrote:
> When running perf script report with a Python script and a callgraph in
> DWARF mode, intr_regs->regs can be 0 and therefore crashing the regs_map
> function.
> 
> Added a check for this condition (same check as in builtin-script.c:595).
> 
> Signed-off-by: Andreas Gerstmayr <agerstmayr@redhat.com>
> ---

Tested-by: Kim Phillips <kim.phillips@amd.com>

Thanks,

Kim
