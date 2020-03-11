Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8416AC0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 20:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AED82074A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 20:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gFG/WAL+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387471AbgCKUR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 16:17:58 -0400
Received: from mail-eopbgr70095.outbound.protection.outlook.com ([40.107.7.95]:9824
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387404AbgCKUR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 16:17:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkH+zu3gfGuF6PsK1CVkykgI98l9LI4SNxhUA/E4mwLbuAitdeD4OK1/6Qma5PxckdOOI4ksPqMt/q8yoii6qDSA6O3hG+VD1ejx59+REF1uFariKZmtuM3RaHhsokxxQKlyITplhprb2sDSUpej8z+fqOuURYU1GLseWPpt4AJ4e/ygVUsaJSA40TvCR7r5tketpnXMBiLSZIvxWaWk5dkGi0VmPKEmkyozIO5HQRrJFZmcWOI6aBQyckjwGqaet0XCjdgw7EzQhp7RNh4RJ+Zf8QNbT9TWnD+i6O/4vMWBafsvBo32W0ZhIFH/79nOh5ZlWI6Wzv4eL+sgk9l8VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4lHHNtHYiqImhWmB9zWj0uGuv88Rl8uwW4R+35Kjnc=;
 b=M+MCCQigQzB22Vthbeqx4SrVL75rwnlJS5z+/w5QhOoAroSl1X+xmYhHrNkFB8J0hwJydnS82nrlvofEOv36SysGsg7CGJxy34d7oiCveJJli5tHPc/dioj5C8iS4TqOjd4ItAEYjxHjgURf9MUaLEHqc2/cHbe5O+PCeBRAN94pb/aEcbLrMVi+Ruys4WHkDvYH1HLJYjtKWoq6ewf/KzhQkHqTZBZErak+mcnDKJ2vU8NUp9TR2Xik7gOe4IcS6tyKlBMGwUq6WZmMWcFMe/1JOSIiQaS43Ysou2CZy8lckCePvysKx7bBmllIeiEEIBwLYTNSWkOzDaiedGafqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4lHHNtHYiqImhWmB9zWj0uGuv88Rl8uwW4R+35Kjnc=;
 b=gFG/WAL+ZgSPpN9QfQzsVq7wGJ5vT6V+dHPLT3N+TXi2hwUcpVPqlnHXUApMrJL7Xw5TvCf8owoRb/MCfa+EhMFdsdDWN6JXLpHh6VSFdI19agEAr29BprhwJbRCZUiOHR6f81PQhxwcYfRWMd0WbzC73OYcY3lkMjISLRI6cE0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from DB7PR08MB3276.eurprd08.prod.outlook.com (52.135.128.26) by
 DB7PR08MB3259.eurprd08.prod.outlook.com (52.134.111.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13; Wed, 11 Mar 2020 20:17:52 +0000
Received: from DB7PR08MB3276.eurprd08.prod.outlook.com
 ([fe80::5cbb:db23:aa64:5a91]) by DB7PR08MB3276.eurprd08.prod.outlook.com
 ([fe80::5cbb:db23:aa64:5a91%3]) with mapi id 15.20.2793.018; Wed, 11 Mar 2020
 20:17:52 +0000
Subject: Re: [PATCH v3] mm: fix tick timer stall during deferred page init
To:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200311123848.118638-1-shile.zhang@linux.alibaba.com>
 <CA+CK2bBdim9dEYsRJ+3HNg4+FsTM0185q54PU=gNKGPAWDpcNA@mail.gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <bd155ed2-e0a6-bdc6-3a44-2d4bbeb1886b@virtuozzo.com>
Date:   Wed, 11 Mar 2020 23:16:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <CA+CK2bBdim9dEYsRJ+3HNg4+FsTM0185q54PU=gNKGPAWDpcNA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0402CA0020.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::30) To DB7PR08MB3276.eurprd08.prod.outlook.com
 (2603:10a6:5:21::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (176.14.212.145) by HE1PR0402CA0020.eurprd04.prod.outlook.com (2603:10a6:3:d0::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend Transport; Wed, 11 Mar 2020 20:17:50 +0000
X-Originating-IP: [176.14.212.145]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9991edd-3d0a-4bac-f990-08d7c5f94687
X-MS-TrafficTypeDiagnostic: DB7PR08MB3259:
X-Microsoft-Antispam-PRVS: <DB7PR08MB3259A4F5C5CD299E4E1E693ACDFC0@DB7PR08MB3259.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:561;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(396003)(39850400004)(376002)(199004)(478600001)(36756003)(26005)(31696002)(186003)(66556008)(66476007)(66946007)(86362001)(53546011)(81166006)(2906002)(8936002)(8676002)(31686004)(81156014)(6506007)(54906003)(52116002)(316002)(16526019)(5660300002)(110136005)(6486002)(2616005)(6666004)(6512007)(956004)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3259;H:DB7PR08MB3276.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6MCocO1J9npVFVdV5i8S220xBFqUbbaKMQr1fvAeBsNQ4fL7OG1nC7AYvU+B49OohOm72M5oI7ePJ8CX3N6+nGwotoZcy8QMRChwsGZNXHQP0xsyeZOedZuFF0ROv+N24cdcVRhud+PscOFFs6PB/gsYYZmRn4kvqSPD2qQtjt/Mojoha6+KP2xSSRilxHpcqsfFjM/Gkw9D1MKQ1L8drfUDLruHk9A/CQoYbdzVDMIQ1R4vE5hLq0cEyTqB1kwxmbBtzpDRP3oQpPQjvArBDvKyvkvJATsK2DgW5IoWsB7GrtpFCVV0pXnxhvQQwBc3fGEn3I3s9vNoPmRz8GDXI6Y8FA9dIJ+XU9GHi5+H+gNKAUPMEPWzIhlYJrA0XKXnqimpp4Q/dh0e+8KWrvPsRmchoqDCBbv/ksCrS/rPszJX+d9jrgElRhzMN8Gkl0Ms
X-MS-Exchange-AntiSpam-MessageData: ZEWLbZh/MzbWjGRA4Kav1jJN3BZtBUJC02pWY4oo1/3/8vzvNLQA3XhrgSG2uol5WX8GMbK3hiNRWQ3bLuVgiQeWMB59KwirL7fn2HEDDXrkSZxCaj8OMK6LubcH4loJERx9G9M52HaTit3fPN7IKQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9991edd-3d0a-4bac-f990-08d7c5f94687
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 20:17:51.9907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VxipqE9rYYLd8gLstE4f5mIIjDI4819TqgLR/SIWWdYAt3le3Jk0r5uPd3SQWrnOvdM3GOhU74Qu6oZAnwW2jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3259
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Pasha,

On 11.03.2020 20:45, Pavel Tatashin wrote:
> On Wed, Mar 11, 2020 at 8:39 AM Shile Zhang
> <shile.zhang@linux.alibaba.com> wrote:
>>
>> When 'CONFIG_DEFERRED_STRUCT_PAGE_INIT' is set, 'pgdatinit' kthread will
>> initialise the deferred pages with local interrupts disabled. It is
>> introduced by commit 3a2d7fa8a3d5 ("mm: disable interrupts while
>> initializing deferred pages").
>>
>> On machine with NCPUS <= 2, the 'pgdatinit' kthread could be bound to
>> the boot CPU, which could caused the tick timer long time stall, system
>> jiffies not be updated in time.
>>
>> The dmesg shown that:
>>
>>     [    0.197975] node 0 initialised, 32170688 pages in 1ms
>>
>> Obviously, 1ms is unreasonable.
>>
>> Now, fix it by restore in the pending interrupts for every 32*1204 pages
>> (128MB) initialized, give the chance to update the systemd jiffies.
>> The reasonable demsg shown likes:
>>
>>     [    1.069306] node 0 initialised, 32203456 pages in 894ms
> 
> Sorry for joining late to this thread. I wonder if we could use
> sched_clock() to print this statistics. Or not to print statistics at
> all?

This won't work for all cases since sched_clock() may fall back to jiffies-based
implementation, which gives wrong result, when interrupts are disabled.

And a bigger problem is not a statistics, but it's advancing jiffies. Some parallel
thread may expect jiffies are incrementing, and this will be a surprise for that
another component.

So, this fix is more about modularity and about not introduction a new corner case.

> ==============
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3c4eb750a199..5958f599aced 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1770,7 +1770,7 @@ static int __init deferred_init_memmap(void *data)
>         const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
>         unsigned long spfn = 0, epfn = 0, nr_pages = 0;
>         unsigned long first_init_pfn, flags;
> -       unsigned long start = jiffies;
> +       unsigned long start = sched_clock();
>         struct zone *zone;
>         int zid;
>         u64 i;
> @@ -1817,8 +1817,8 @@ static int __init deferred_init_memmap(void *data)
>         /* Sanity check that the next zone really is unpopulated */
>         WARN_ON(++zid < MAX_NR_ZONES && populated_zone(++zone));
> 
> -       pr_info("node %d initialised, %lu pages in %ums\n",
> -               pgdat->node_id, nr_pages, jiffies_to_msecs(jiffies - start));
> +       pr_info("node %d initialised, %lu pages in %lldns\n",
> +               pgdat->node_id, nr_pages, sched_clock() - start);
> 
>         pgdat_init_report_one_done();
>         return 0;
> ==============
> 
> [    1.245331] node 0 initialised, 10256176 pages in 373565742ns
> 
> Pasha
> 
> 
> 
>> Fixes: 3a2d7fa8a3d5 ("mm: disable interrupts while initializing deferred pages").
>>
>> Co-developed-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>> Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
>> ---
>>  mm/page_alloc.c | 25 ++++++++++++++++++++++---
>>  1 file changed, 22 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 3c4eb750a199..a3a47845e150 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1763,12 +1763,17 @@ deferred_init_maxorder(u64 *i, struct zone *zone, unsigned long *start_pfn,
>>         return nr_pages;
>>  }
>>
>> +/*
>> + * Release the pending interrupts for every TICK_PAGE_COUNT pages.
>> + */
>> +#define TICK_PAGE_COUNT        (32 * 1024)
>> +
>>  /* Initialise remaining memory on a node */
>>  static int __init deferred_init_memmap(void *data)
>>  {
>>         pg_data_t *pgdat = data;
>>         const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
>> -       unsigned long spfn = 0, epfn = 0, nr_pages = 0;
>> +       unsigned long spfn = 0, epfn = 0, nr_pages = 0, prev_nr_pages = 0;
>>         unsigned long first_init_pfn, flags;
>>         unsigned long start = jiffies;
>>         struct zone *zone;
>> @@ -1779,6 +1784,7 @@ static int __init deferred_init_memmap(void *data)
>>         if (!cpumask_empty(cpumask))
>>                 set_cpus_allowed_ptr(current, cpumask);
>>
>> +again:
>>         pgdat_resize_lock(pgdat, &flags);
>>         first_init_pfn = pgdat->first_deferred_pfn;
>>         if (first_init_pfn == ULONG_MAX) {
>> @@ -1790,7 +1796,6 @@ static int __init deferred_init_memmap(void *data)
>>         /* Sanity check boundaries */
>>         BUG_ON(pgdat->first_deferred_pfn < pgdat->node_start_pfn);
>>         BUG_ON(pgdat->first_deferred_pfn > pgdat_end_pfn(pgdat));
>> -       pgdat->first_deferred_pfn = ULONG_MAX;
>>
>>         /* Only the highest zone is deferred so find it */
>>         for (zid = 0; zid < MAX_NR_ZONES; zid++) {
>> @@ -1809,9 +1814,23 @@ static int __init deferred_init_memmap(void *data)
>>          * that we can avoid introducing any issues with the buddy
>>          * allocator.
>>          */
>> -       while (spfn < epfn)
>> +       while (spfn < epfn) {
>>                 nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
>> +               /*
>> +                * Release the interrupts for every TICK_PAGE_COUNT pages
>> +                * (128MB) to give tick timer the chance to update the
>> +                * system jiffies.
>> +                */
>> +               if ((nr_pages - prev_nr_pages) > TICK_PAGE_COUNT) {
>> +                       prev_nr_pages = nr_pages;
>> +                       pgdat->first_deferred_pfn = spfn;
>> +                       pgdat_resize_unlock(pgdat, &flags);
>> +                       goto again;
>> +               }
>> +       }
>> +
>>  zone_empty:
>> +       pgdat->first_deferred_pfn = ULONG_MAX;
>>         pgdat_resize_unlock(pgdat, &flags);
>>
>>         /* Sanity check that the next zone really is unpopulated */
>> --
>> 2.24.0.rc2
>>

