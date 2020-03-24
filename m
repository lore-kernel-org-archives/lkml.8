Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0358C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D9B2076F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="p1IQoEIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgCXP4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:56:33 -0400
Received: from mail-bn8nam11on2045.outbound.protection.outlook.com ([40.107.236.45]:6132
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727491AbgCXP4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:56:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCYOVFRCFwGFpydKoD8moWI98i12+NyKskbjbVpX/4RW1nhQhI9rYWvWyE2aUzqxibKT2z6C+OKpQMuhxOILKBCQOZSn4UAPQF5M8jqdYy9sSUxj9RWYgBhjovizYXAblhZTRu/hU0IBX1cghyLKv3CYLnlNBW3oYUl8kzLbcLTktMWMtrc0gCND9h9s5+AnnqP0JMY1xUvjmxenIsjEyeL0jDBUkR4YIuzYhOJhDL5iS+CwlVD+BJFvI1d9zo5F/xKap6ffUpgSdKJMzNa3XhXTsbtjPMDpFUVkNTwof1481KJTi1I0C4ShBtz4sn6GCf6Cwb86MxohpO43aHBXYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSqd4dgzfEg76DvdZMn7YTPNNKDMKlonXoO1V/AsPdY=;
 b=GR5QgP6igFzKRL4tBEMvAcn2D2UFYG8oQY0VrtoRC7+10XsVEknYKw+k+EmZHVjiRNX8nCC++zZBf3zZkaldW7w9NmjjDtH0asr/95KFw3s8q4h3/7g0Edk0u/q+LDDNqzg9gQNZVLVhbedynCBvEi0ugQgwEyIcZLiKtksD/V7a/IhC3pe1id0+n3Q0eMr6lLqiIfnj6u/uPe8uQLNnxL6hMyQ0/5lq4OMZZK4B1a7ncZuZOloQjrof8TvBONKVz8igdAqfjq4KGt2uSXxcJvUlHf8efO0U99o5LnCU2koNW503o+fLX1u9cvHcQvfkhy9RIHD6L8y7oJKdGHfncg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSqd4dgzfEg76DvdZMn7YTPNNKDMKlonXoO1V/AsPdY=;
 b=p1IQoEIk1PO2/PVq8l9255BqpOmrJr2BL/UNfAWWzfrGTgXJjXTRayZQlqWZq3UuRqQ36Vj4MSMpSEOiKfJSYowI2nW7qxH2k0GvCeJbBDzBQkN04EpUN1U2CzDTxxsATZ+tTMMS9pdhIxbZD/5KwHIqJnNZ90Uln+wcIEb8/4M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Friesen@windriver.com; 
Received: from BYAPR11MB3271.namprd11.prod.outlook.com (2603:10b6:a03:7b::26)
 by BYAPR11MB3222.namprd11.prod.outlook.com (2603:10b6:a03:79::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Tue, 24 Mar
 2020 15:56:29 +0000
Received: from BYAPR11MB3271.namprd11.prod.outlook.com
 ([fe80::394c:8038:a488:13ba]) by BYAPR11MB3271.namprd11.prod.outlook.com
 ([fe80::394c:8038:a488:13ba%7]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 15:56:29 +0000
Subject: Re: [PATCH v2] isolcpus: affine kernel threads to specified cpumask
To:     Marcelo Tosatti <mtosatti@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Jim Somerville <Jim.Somerville@windriver.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20200323135414.GA28634@fuller.cnet>
 <87k13boxcn.fsf@nanos.tec.linutronix.de>
 <af285c22-2a3f-5aa6-3fdb-27fba73389bd@windriver.com>
 <87imiuq0cg.fsf@nanos.tec.linutronix.de> <20200324152016.GA25422@fuller.cnet>
From:   Chris Friesen <chris.friesen@windriver.com>
Message-ID: <f40c828e-5168-bd08-69b8-f7a54fd53f42@windriver.com>
Date:   Tue, 24 Mar 2020 09:56:26 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200324152016.GA25422@fuller.cnet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::15) To BYAPR11MB3271.namprd11.prod.outlook.com
 (2603:10b6:a03:7b::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.25.39.6] (70.64.94.148) by BYAPR02CA0002.namprd02.prod.outlook.com (2603:10b6:a02:ee::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend Transport; Tue, 24 Mar 2020 15:56:28 +0000
X-Originating-IP: [70.64.94.148]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b98521e-59e7-4d41-b7f1-08d7d00bea45
X-MS-TrafficTypeDiagnostic: BYAPR11MB3222:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR11MB32226BDC76EFE407DDA2FB7AF6F10@BYAPR11MB3222.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 03524FBD26
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39850400004)(136003)(376002)(346002)(396003)(366004)(110136005)(36756003)(66946007)(8676002)(53546011)(6486002)(54906003)(31686004)(86362001)(8936002)(5660300002)(966005)(956004)(186003)(4326008)(31696002)(44832011)(16526019)(16576012)(81166006)(52116002)(66556008)(316002)(66476007)(2906002)(26005)(478600001)(2616005)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB3222;H:BYAPR11MB3271.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: windriver.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X75WKd2e3nqCZHnZ/etV1emtS8wUCLAYw5HWPSWfi/L/fUdR0c35+dGr+D8HNtENFTzU4K7Oad8Ygz4XusaFRNpOu7bhv1gMXagM2bH9l46VI/YXU+GuQ9uH47CvZm/jn+H1zUspzMt4xYMqQk22UHTyvvqwU2orSZvZvF8Iyuo06ON0Q2KuxbNfVqrE46rnv6/IGMWzJwj/FJSChXlxtoPa+b+3FoPBkfC05SoDo3vfzMestvSjTme9I/kwi1T7KnJ7hy/0LVIo0OLkhKbAeyDYJrDx598LUD47SH1oALHAaeWwCb8DIcTDbHJyHgN+GPvZPoeerfI7q77odxvWUiyoKte8lUuUp90M0OXTX2kb+kuPA84NxBpNRmGqifCkzfMVEb4J9CtiF1BvSfvWRnQjXJDAtaz0qJPM961Tm3BS6o7idHqlLz/GrdKJ/kdWgutnfV7+7BKu+qeQUKkxnJq53JCfKfJk2oneVVZewl2VhVNhaE01v2kmEpXivt8FgKQAUZUJOq3+d572uZJ7QQ==
X-MS-Exchange-AntiSpam-MessageData: MjCtPA9qlDHyjWNHt9vO2yUqwmk3/VhKBI18gvfskk6y0dtBjVeTGq/lS2NtYRrKX4GYoLSQpiHxgYayizXQpf8s2JsoksmHI8lKALl7rpAdGoT9G1LT6mh4uMtljDkYF9Cmsu4baA56HB7NKROTVw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b98521e-59e7-4d41-b7f1-08d7d00bea45
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 15:56:29.1818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q2UVH7oBu8mfmWYzx1VPexpLpN4PWr5kB0Bfz9R9HSICXikbRtjCV8nma4vN00zBIS0VAjQjW3gzKXp/oSN6SP9ZPlZCWR2L8iZLefBVtdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3222
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I hadn't been keeping up with all the changes to the "isolcpus" boot 
arg.  Given how it's been extended, I agree that it seems the logical 
place to deal with this.  Patch seems okay to me, but I've got a couple 
of nits in the message portion.

If I want to specify both no_kthreads and managed_irq it then something 
like "isolcpus=managed_irq,no_kthreads,2-16" would work?


On 3/24/2020 9:20 AM, Marcelo Tosatti wrote:
> 
> This is a kernel enhancement to configure the cpu affinity of kernel
> threads via kernel boot option isolcpus=no_kthreads,<isolcpus_params>,<cpulist>

https://github.com/torvalds/linux/blob/master/Documentation/admin-guide/kernel-parameters.txt 
says that "isolcpus" is deprecated.  Are we un-deprecating it?  Or is it 
only really deprecated for the "domain" option?

> When this option is specified, the cpumask is immediately applied upon
> thread launch. This does not affect kernel threads that specify cpu
> and node.
> 
> This allows CPU isolation (that is not allowing certain threads
> to execute on certain CPUs) without using the isolcpus=domain parameter,
> making it possible to enable load balancing on such CPUs
> during runtime (see

I think you're missing the rest of the sentence here.

> Note-1: this is based off on Wind River's patch at
> https://github.com/starlingx-staging/stx-integ/blob/master/kernel/kernel-std/centos/patches/affine-compute-kernel-threads.patch
> 
> Difference being that this patch is limited to modifying
> kernel thread cpumask: Behaviour of other threads can
> be controlled via cgroups or sched_setaffinity.
> 
> Note-2: MontaVista's patch was based off Christoph Lameter's patch at
> https://lwn.net/Articles/565932/ with the only difference being
> the kernel parameter changed from kthread to kthread_cpus.

Wind River, not MontaVista.  I know all us embedded linux folks look the 
same...

> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> ---
> 
> v2: use isolcpus= subcommand (Thomas Gleixner)
> 
>   Documentation/admin-guide/kernel-parameters.txt |    8 ++++++++
>   include/linux/cpumask.h                         |    5 +++++
>   include/linux/sched/isolation.h                 |    1 +
>   init/main.c                                     |    1 +
>   kernel/cpu.c                                    |   13 +++++++++++++
>   kernel/kthread.c                                |    4 ++--
>   kernel/sched/isolation.c                        |    6 ++++++
>   7 files changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index c07815d230bc..7318e3057383 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1959,6 +1959,14 @@
>   			  the CPU affinity syscalls or cpuset.
>   			  <cpu number> begins at 0 and the maximum value is
>   			  "number of CPUs in system - 1".
> +			  When using cpusets, use the isolcpus option no_kthreads
> +			  to avoid creation of kernel threads on isolated CPUs.
> +
> +			no_kthreads
> +			  Adjust the CPU affinity mask of unbound kernel threads to
> +			  not contain CPUs on the isolated list. This complements
> +			  the isolation provided by the cpusets mechanism described
> +			  above.

It also complements the "managed_irq" option below.  In many cases I'd 
expect the same set of CPUs to be isolated from both irqs and kernel 
threads.


Chris
