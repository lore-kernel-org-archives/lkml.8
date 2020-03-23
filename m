Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E112C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A3C120409
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="dyPpHo5T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgCWP3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:29:30 -0400
Received: from mail-eopbgr680073.outbound.protection.outlook.com ([40.107.68.73]:26436
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727053AbgCWP33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:29:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pn70p+d1ho5BDR/l6xZloLjUKlO2GOWMgAUUU2hrIq/Y5fiuo4NN8SE5NJUWCnk+EX8D1B8SIEfn6v7zIgDvvACicusi1y0hfIAnQWbRQQTEfhB+ImrylutRROQzmSPz4ykFEwv4lfH5+4d0n/Megty+jbJgiWVzNomhjtsoZJIxGvIJILHCm3sNu+bbXFv+1WnEARnhimuxF5xgce6jTUrc7A/wCCNmlDC6aUp6JQYvgVYvw6ezjt4lIyzYipofaS+X90jpajvLOOMUAqTpilaZuGQQiPbgJpXKvL0sbWSSeFzk2ihHE0BFSPHqguDplP87IPuTmTSB1wumcHr+JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GL+k9C5pyEGwf8iKGdIKyUQOtFqUJ02IbY3oSFSW7sU=;
 b=Ulqg3edY7nKXdnMvQLhJhg56lTMSrLZofBnnYEpMREu4gC2L7hbAg809FrJ1efa/0uqCBDefAEKXKICHSOo7nZLNASdC97lg5L+4Rl7ubstXnFcXrTNXryKC9WOtgY5l2UMQpJt6rP+47mcrL9ujlEkc6BmvgSLjoW6KusLlVcQhFGo0PodOTTtw8qq0BTCWPLyCSgz7ZZq5gYd6tpprfEWCwBYv6GxbpKvwC/PTKN8NjE/nQnsfHR4dG2/2alzhuhPuBinm7fUSlWfZ4dtjL/70vSoWGf8XWIQRTZZ809qkd+O3YFIpTJJhwIKkiQNdu9hqTHcd4x+MpzbTyM64KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GL+k9C5pyEGwf8iKGdIKyUQOtFqUJ02IbY3oSFSW7sU=;
 b=dyPpHo5TMRyGhkNdgQKHMLjba5d35B8/tt2gnOksssJXtgoCBHZIc+CSxiw/rNmycoeqkCkM8lkwXNETaewy3DMqSn+x+HRWA0XPNYtOPhpsB85veqGT5Kpe6IzlMPVB9VGDIh+TVElijlw+7pKbCuV1jPZslZyTd/6MeQVbqS8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Friesen@windriver.com; 
Received: from BYAPR11MB3271.namprd11.prod.outlook.com (2603:10b6:a03:7b::26)
 by BYAPR11MB3592.namprd11.prod.outlook.com (2603:10b6:a03:fb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Mon, 23 Mar
 2020 15:29:26 +0000
Received: from BYAPR11MB3271.namprd11.prod.outlook.com
 ([fe80::394c:8038:a488:13ba]) by BYAPR11MB3271.namprd11.prod.outlook.com
 ([fe80::394c:8038:a488:13ba%7]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 15:29:26 +0000
Subject: Re: [PATCH] affine kernel threads to specified cpumask
To:     Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Christoph Lameter <cl@linux.com>, Vu Tran <vu.tran@windriver.com>,
        Jim Somerville <Jim.Somerville@windriver.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200323135414.GA28634@fuller.cnet>
From:   Chris Friesen <chris.friesen@windriver.com>
Message-ID: <e76aedad-8c55-1651-007d-6e17882403cb@windriver.com>
Date:   Mon, 23 Mar 2020 09:29:23 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200323135414.GA28634@fuller.cnet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0107.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::48) To BYAPR11MB3271.namprd11.prod.outlook.com
 (2603:10b6:a03:7b::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.25.39.6] (70.64.94.148) by BYAPR07CA0107.namprd07.prod.outlook.com (2603:10b6:a03:12b::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend Transport; Mon, 23 Mar 2020 15:29:25 +0000
X-Originating-IP: [70.64.94.148]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10ea2432-8fad-4b1a-ae89-08d7cf3ef854
X-MS-TrafficTypeDiagnostic: BYAPR11MB3592:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR11MB3592808ADF698013498B14AAF6F00@BYAPR11MB3592.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0351D213B3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(136003)(346002)(39850400004)(199004)(186003)(6486002)(31696002)(8936002)(44832011)(54906003)(86362001)(316002)(16576012)(2906002)(52116002)(66556008)(966005)(8676002)(66476007)(66946007)(4326008)(81166006)(81156014)(36756003)(53546011)(26005)(5660300002)(956004)(2616005)(31686004)(478600001)(16526019);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB3592;H:BYAPR11MB3271.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: windriver.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nG4aFhhWHv3eYRU9ZhodvvmXz7e6aKvvICUQBXTsUYk09SYJp9Ykw9s+FYIX06QGPJ6NnWrVwxXtMUlp4UXyuaWy7aSX6hwMUForQ6Xq4GTN3VGw9DeolIM74Hcg6SY8pIQxQDrBa4wIuFe3XoVYGsiOjiZpIUpoMbW73YP8neBA5X2CLlchmSjjyrVzyjfaCoLTiw7y476YVIQ7mCc9Y8W9nwk9B+zWVnqVQpI3xNpxv6Kc+U5yBY2/BQDrVoZkAyWq+kGiIzamk5+D9dbEW5+phClVTUqt1wpkuh+XBmqRhKblPpK9KSEjjglCPp0YQu/V0HraeXqCqWG6oSZjWP6wqMbc4PoOFQmy3Ogq9zix+4uwPoodVvbb9FB0yJYGanBUI3jJ2tcJXyNrWKe+zMdoYmmvGhk6Oe98KPMixeK/x2L+FArMo45U1GZ9LXX2j+YOQrDWbS6D3KKeXEF3M0wQ1NDLV2ZNBZGfxg5xUPlmgbAt81ZBr//Tt/5TctYAhWOwbscKUMRD7dRFOlwdrQ==
X-MS-Exchange-AntiSpam-MessageData: C+L7owzareRd2BzrBk/1xPZEZOZxUsfrNnh5Pv6NmfHN+cXDqAqg9IMS11nhq9tUuTBx+2EIsGva+mmpBfdkimZezzI8R2MYT8EYxUFhuy1nv0Ef+Tm2U0ysnq1BvZHg3Wq4apgguUmVD8sV35CKxw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ea2432-8fad-4b1a-ae89-08d7cf3ef854
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2020 15:29:26.0444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xiRVNG6TK1gf4mie04n0/cbKRc2k7mxrXLIKjjfCuaumrKMeDbfwb0T4Ez0sG1aUxay/BWdaU3s1kBZWtW7Xp+8Q3KKxoCXt7936tqOnv0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3592
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/2020 7:54 AM, Marcelo Tosatti wrote:
> 
> This is a kernel enhancement to configure the cpu affinity of kernel
> threads via kernel boot option kthread_cpus=<cpulist>.
> 
> With kthread_cpus specified, the cpumask is immediately applied upon
> thread launch. This does not affect kernel threads that specify cpu
> and node.
> 
> This allows CPU isolation (that is not allowing certain threads
> to execute on certain CPUs) without using the isolcpus= parameter,
> making it possible to enable load balancing on such CPUs
> during runtime.
> 
> Note-1: this is based off on MontaVista's patch at
> https://github.com/starlingx-staging/stx-integ/blob/master/kernel/kernel-std/centos/patches/affine-compute-kernel-threads.patch

It's Wind River, not MontaVista. :)

> Difference being that this patch is limited to modifying
> kernel thread cpumask: Behaviour of other threads can
> be controlled via cgroups or sched_setaffinity.

What cgroup would the usermode helpers called by the kernel end up in?
Same as init?

Assuming that's covered, I'm good with this patch.

<snip>

> +static struct cpumask user_cpu_kthread_mask __read_mostly;
> +static int user_cpu_kthread_mask_valid __read_mostly;

Would it be cleaner to get rid of user_cpu_kthread_mask_valid and just
move the "if (!cpumask_empty" check into init_kthread_cpumask()?  I'm
not really opinionated, just thinking out loud.

> +int __init init_kthread_cpumask(void)
> +{
> +	if (user_cpu_kthread_mask_valid == 1)
> +		cpumask_copy(&__cpu_kthread_mask, &user_cpu_kthread_mask);
> +	else
> +		cpumask_copy(&__cpu_kthread_mask, cpu_all_mask);
> +
> +	return 0;
> +}
> +
> +static int __init kthread_setup(char *str)
> +{
> +	cpulist_parse(str, &user_cpu_kthread_mask);
> +	if (!cpumask_empty(&user_cpu_kthread_mask))
> +		user_cpu_kthread_mask_valid = 1;
> +
> +	return 1;
> +}
