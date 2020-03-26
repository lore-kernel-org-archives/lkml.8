Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C5FC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A36221D7B
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="Lfmz2v6C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgCZQc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:32:57 -0400
Received: from mail-co1nam11on2054.outbound.protection.outlook.com ([40.107.220.54]:6057
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727752AbgCZQc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 12:32:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVBMaAvp266m3dWMADFXR7mZkhGR4MWZY5DfiqGCGVRRVl3UAMY2aHfU4hn6JbvZPywREycw3aLrGeIQ5ZiPDU3oKHR+nM4R9tD9R8ZyJ9NZS4SijsyBINh0sud8KmpzH4zaKv8vhCAJA+6hbAX21OeiGDmz8N9+G2O9f4KHZ+79mC2+jGzEs3IYUiTAQ2I0s/1gm60/pnMP7EcmwtREzuH4OxAJrOGHXcolWWpkS0GMfC3Fuzj9ktdq8F1MAJkDkIKon3ULGYarWHG1hZFmB0e+GO09X6+mu46ThUrmZCsWZJKgkJ+7VE7eIIqOv0qpDRsjbm1/LSqzfPpeqS63Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kg5z8EUDsSLh9vWLK+waJGLrDxG650MidKnAdACajxY=;
 b=MqbD9ho+SZEqyRQx1zq7LvqO8RHGfTQ3fd8qb3zpqsse1JTGUFKFYlm11Q5ytxiAfUDHOY0Nbq5D9BGamtpB7/L7UVUlSdGH5a93JKi6bR5NH5wYx1iheiJ2c23byGqChS33FjjIQTQqJ0j+A2q/HVmXcOGeSpp93lR/VNcIVF7OFMakDpP/vLLvk/gxPegnoZOUjxWTZ9O/zn5kZEECQw6CQXbkjk8JnShOoRIxq1pynBZ+yGVPWZZY0A3+ur95kSXiogxMiolYu/nQl2DdFwBlca5njEIScAx/BVgwEFMWKOyrDLWFRWdeWqqUwzwqj5a2yrnBauvNMJbRuIB8Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kg5z8EUDsSLh9vWLK+waJGLrDxG650MidKnAdACajxY=;
 b=Lfmz2v6COQGrhAxZi4xBNGohhgyWnvSTC+YSLLeLlnFfED4S8Ue0d436zvg5GO1X9W3zraFFLsWrYwJhlGtF0ax5QvtweeRUDACNoGzwDB1y3f9ADTtFz05Y4TpA3U7PHfHt1vy3Ag7mKj5Bd/vQqqcKTeuNd0r64UWwRQptuwU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Friesen@windriver.com; 
Received: from BYAPR11MB3271.namprd11.prod.outlook.com (2603:10b6:a03:7b::26)
 by BYAPR11MB3573.namprd11.prod.outlook.com (2603:10b6:a03:fe::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Thu, 26 Mar
 2020 16:32:54 +0000
Received: from BYAPR11MB3271.namprd11.prod.outlook.com
 ([fe80::394c:8038:a488:13ba]) by BYAPR11MB3271.namprd11.prod.outlook.com
 ([fe80::394c:8038:a488:13ba%7]) with mapi id 15.20.2856.019; Thu, 26 Mar 2020
 16:32:54 +0000
Subject: Re: [PATCH v2] isolcpus: affine kernel threads to specified cpumask
To:     Frederic Weisbecker <frederic@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>
Cc:     'Marcelo Tosatti' <mtosatti@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Jim Somerville <Jim.Somerville@windriver.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20200323135414.GA28634@fuller.cnet>
 <87k13boxcn.fsf@nanos.tec.linutronix.de>
 <af285c22-2a3f-5aa6-3fdb-27fba73389bd@windriver.com>
 <87imiuq0cg.fsf@nanos.tec.linutronix.de> <20200324152016.GA25422@fuller.cnet>
 <b88327780661496fbee6d8ebe2e0d965@AcuMS.aculab.com>
 <20200326162218.GB3946@lenoir>
From:   Chris Friesen <chris.friesen@windriver.com>
Message-ID: <76fa0270-40c5-aac7-1c53-38384fa3467d@windriver.com>
Date:   Thu, 26 Mar 2020 10:32:51 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200326162218.GB3946@lenoir>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:a03:180::20) To BYAPR11MB3271.namprd11.prod.outlook.com
 (2603:10b6:a03:7b::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.25.39.6] (70.64.94.148) by BY5PR13CA0007.namprd13.prod.outlook.com (2603:10b6:a03:180::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.9 via Frontend Transport; Thu, 26 Mar 2020 16:32:52 +0000
X-Originating-IP: [70.64.94.148]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f246097c-07ee-466b-a505-08d7d1a3556c
X-MS-TrafficTypeDiagnostic: BYAPR11MB3573:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR11MB35739FCD9F29BFBF893E78A9F6CF0@BYAPR11MB3573.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 0354B4BED2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39850400004)(396003)(366004)(136003)(346002)(376002)(6486002)(2616005)(956004)(186003)(316002)(8676002)(26005)(36756003)(16526019)(5660300002)(16576012)(44832011)(110136005)(54906003)(66556008)(66946007)(8936002)(478600001)(66476007)(53546011)(31696002)(81156014)(81166006)(86362001)(52116002)(2906002)(4744005)(31686004)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB3573;H:BYAPR11MB3271.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: windriver.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E72LHfN697r0iG2jwT1gldutWHGDyuoxu3STbtrQTRwhoi/97KENrAkxXeaqCYLdRpoyNdWQOBvrLB3AI33tXjkMqyfB1Eld4D6lWBiaW8gVX/dLXoDY+V/iN5bxzEStJaEP/zYbn/Cvmlh5Uy15MPrwb8J+8+DPLai8NqARDbx9HdFWKQCnTOpQzG/7olu7/uYtmbWpCSq+5QA4ReKhvOhbsLSKvceUM82xa26OaPp6V5e5CDp+aIm1hFq4BNXnEyavi9s0TzMCCYwdoCf1d0jnSUH2ad6xwiXu608Bxu0zwxLh3NgWQI+9SeghRlrYufzfRRn4mqVyXomGiEWp4dqLuxhe/n/XWI2HxUqGlA+Wd/nSqfXXzH4NajZZumEKQYqiJSTn94pqjbUk1K9ZRGa6zZN7XYnlVt79cbmvHT7Sp7LaSU45f27FTfcIJD/F
X-MS-Exchange-AntiSpam-MessageData: xXXv3iOLLx8E6SPN99jnqYL+GjZ4bAFD8964Us5qaW3konAsoFf3pwA5P1n1yyPBKaUlGoidhlV7jKs8PEOMD3vMQpoP9fRT4807yBExnv8xaCiDh8JHA9M+ijJtRmgDxU8921LEshkvCzeGwoDoeA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f246097c-07ee-466b-a505-08d7d1a3556c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2020 16:32:54.2060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O3UT7lAItltVdsnBuB1eWYn3yWrT47j7ZP/uQeL17L19LQ8COKNGE1mmlli1p+EEJUqVG1kBARREGsvc65iLZTw59TnSofg7hOEEJbkiqbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3573
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/2020 10:22 AM, Frederic Weisbecker wrote:
> On Wed, Mar 25, 2020 at 06:05:27PM +0000, David Laight wrote:

>> How about making it possible to change the default affinity
>> for new kthreads at run time?
>> Is it possible to change the affinity of existing threads?
>> Or maybe only those that didn't specify an explicit one??
> 
> That's already possible yes, most unbound kthreads are accessible
> through /proc including kthreadd from which new kthread will inherit
> their CPU affinity.

Are you sure that the new kthread will inherit the CPU affinity?

__kthread_create_on_node() explicitly sets the new thread as 
SCHED_NORMAL with a mask of "cpu_all_mask".

Chris
