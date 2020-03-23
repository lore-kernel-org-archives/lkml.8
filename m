Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36775C54EEB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 17:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02ACD20658
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 17:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="b+0PtS3a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgCWRCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 13:02:45 -0400
Received: from mail-dm6nam12on2046.outbound.protection.outlook.com ([40.107.243.46]:60480
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727164AbgCWRCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 13:02:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSfnuidFjIiRmIIj54HA+VVozDqVXRxvovaj1SMugRIrvcXluDd2+2vX8xhACSopZy8FN46pWyd0oTW8c8887HAUG5+ZntWMrbtJlU94YdyxgHY97Cgu+6aybnu/2t3ejXzQAB00d9IaW2YbHKfhaBchSecHz+ApNobu3UalAN8xaYj7Wq3hPmU5DYQkmHknstaDfZtknsd45be+YmY9rXAL3baPIwI9YREbfHefGgeDQaqvJGf++ettY3Wcuo5GzmBKBkuhRL0e6lb1Q7XlqFeq93pQO0/LHI1urFvJjPKxNAyYQLSKMWm307w7u+j5agEaFeD8ygj5yDXJCUjbiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBQCs/DcOUSHMHHfivNasc9oPcE9+vp+BUI0Vf6AJKg=;
 b=bjkp53lFGCCPdLxlKHEh16UJWxKq1xK67kUyS/ojEfta206AZNDcS4YTfQgkha1ZvzSE0CpbYAQiwAIx8nJ5ASCsdyRKoHQmp3h0hJq9FkDBI4zKW6Reqw/TohJBgAM4LxoM7acoBOSoHl+mVQquehuCM+ZAIvpnPYZGpj5GrhxdltFqp+PoHURAQBd577cnMmZtiZaMYj6x8JyPbTbEdSDEvPxpT6G1RUMfwQvD7zxW/PARqQM5KbyitaZ6fN/xTUKLSGYsOq7r3kehbfAquZFkIeOUSlRlkieMkGla6YnHMkY/spL+N422kwNlI0B2dqJgwxEm/jhwzD8a0vxwxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBQCs/DcOUSHMHHfivNasc9oPcE9+vp+BUI0Vf6AJKg=;
 b=b+0PtS3aVCJVgxC/+jeOCqzqEn/8kJKVehvU+CNEeDgW1KcC2yPYmu0Z0kcCaOzylsS6p5xuCGe48UqM2ScwHmt6a4moYT2cuSNU0Vso7xwHiiL4P4OfckcHDVZelqPCaHCrclGgavQlmVK9jGfjhjCZYtHkYOw6nIm8z1JeqTo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Friesen@windriver.com; 
Received: from BYAPR11MB3271.namprd11.prod.outlook.com (2603:10b6:a03:7b::26)
 by BYAPR11MB2616.namprd11.prod.outlook.com (2603:10b6:a02:c6::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19; Mon, 23 Mar
 2020 17:02:40 +0000
Received: from BYAPR11MB3271.namprd11.prod.outlook.com
 ([fe80::394c:8038:a488:13ba]) by BYAPR11MB3271.namprd11.prod.outlook.com
 ([fe80::394c:8038:a488:13ba%7]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 17:02:40 +0000
Subject: Re: [PATCH] affine kernel threads to specified cpumask
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Christoph Lameter <cl@linux.com>, Vu Tran <vu.tran@windriver.com>,
        Jim Somerville <Jim.Somerville@windriver.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20200323135414.GA28634@fuller.cnet>
 <87k13boxcn.fsf@nanos.tec.linutronix.de>
From:   Chris Friesen <chris.friesen@windriver.com>
Message-ID: <af285c22-2a3f-5aa6-3fdb-27fba73389bd@windriver.com>
Date:   Mon, 23 Mar 2020 11:02:37 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <87k13boxcn.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR05CA0073.namprd05.prod.outlook.com
 (2603:10b6:102:2::41) To BYAPR11MB3271.namprd11.prod.outlook.com
 (2603:10b6:a03:7b::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.25.39.6] (70.64.94.148) by CO2PR05CA0073.namprd05.prod.outlook.com (2603:10b6:102:2::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.12 via Frontend Transport; Mon, 23 Mar 2020 17:02:39 +0000
X-Originating-IP: [70.64.94.148]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9d95a14-5175-452d-61b3-08d7cf4bfecd
X-MS-TrafficTypeDiagnostic: BYAPR11MB2616:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR11MB261690B2D6FEFB072E17BB70F6F00@BYAPR11MB2616.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0351D213B3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(136003)(366004)(396003)(346002)(39850400004)(199004)(478600001)(54906003)(16526019)(186003)(5660300002)(6486002)(26005)(44832011)(956004)(2906002)(316002)(2616005)(4326008)(8936002)(16576012)(52116002)(66946007)(110136005)(81166006)(81156014)(31686004)(8676002)(66556008)(53546011)(66476007)(36756003)(86362001)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB2616;H:BYAPR11MB3271.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: windriver.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gc4PrGGNLMn3ea75rdJNo7fKc8E815r8iP3iArDVdg3ZD8YfrkxIC09MPPGtdlgHtEvU+vgT+xGN8Pe25bCLRWbJToPhxOuJFGVioA4+nkFnw+7KQKJpnm/LlHTungRFL+8UPsqW3OlikQyUf7/mD0Qhu9UKmgc+ihyhuJpMLJ27duNyCNx5U9ZrOyiZ67AWVjGK8JAmQtr0QBPxQxKb0KTzA7ZXEarfMDGG5fTl73VVtDdOKMsB57EWCQG4xZ5xGHhWl321hyZRneGOORIiPKcZ9l0279HGlz0HCWFPjzvDLf+cqFusq2Y1KZjD3t+2HnAuZSYaM8Cm3IKRLSqPoiq2XMD76BYloEFwXSZ0EnRVmtkoheFFyoaa1efP0J2DS0MDadwEQSI0JMCeZwZXg3AM8rS8YNVFchmHFF8Ztg2IT//148675LjK9U5A6iBF
X-MS-Exchange-AntiSpam-MessageData: 51nfBnwTOLmlFh4+Se3HL3LPifzlH66aAdQ9w+IxUQCZdCNG2fQ8YNq1ccAWAO9epSTvrzBXEEc+R9WMVTBnW9Y5gM/QC6msx1vFuUeQaK+MHREuzlj8y2Zvr4f0oYPiQz7haGp4q9CfOIE+hNxEGQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d95a14-5175-452d-61b3-08d7cf4bfecd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2020 17:02:40.2583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GqEj/O2xYSth3SVYNasT/rqITVjbbkMO1/uUnOXuL0LdOGjck82cNFr1Wk1CLiMCcywGYiHJtE3jh2vVJTujie1UZkHoQlMzXq7UCZzb2LE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2616
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/2020 10:22 AM, Thomas Gleixner wrote:
> Marcelo,
> Marcelo Tosatti <mtosatti@redhat.com> writes:
> 
> the subject lacks a prefix and the CC list a few people.
> 
>> This is a kernel enhancement to configure the cpu affinity of kernel
>> threads via kernel boot option kthread_cpus=<cpulist>.
>>
>> With kthread_cpus specified, the cpumask is immediately applied upon
>> thread launch. This does not affect kernel threads that specify cpu
>> and node.
>>
>> This allows CPU isolation (that is not allowing certain threads
>> to execute on certain CPUs) without using the isolcpus= parameter,
>> making it possible to enable load balancing on such CPUs
>> during runtime.
> 
> I'm surely missing some background information, but that sentence does
> not make any sense to me.
> 
> Thanks,
> 
>          tglx
> 

The idea is to affine general kernel threads to specific "housekeeping" 
CPUs, while still allowing load balancing of tasks.

The isolcpus= boot parameter would prevent kernel threads from running 
on the isolated CPUs, but it disables load balancing on the isolated CPUs.

Chris
