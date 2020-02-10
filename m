Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACC8C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9621A20733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WVHrC8ZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbgBJQrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 11:47:15 -0500
Received: from mail-dm6nam10on2066.outbound.protection.outlook.com ([40.107.93.66]:34100
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727003AbgBJQrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 11:47:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AacIuNcRoqtvqyTTIRMY9QJxe66B50ooM8h19wA0uaLpLfjfty81cGJHV0y7EuOoAyD9unpI6T1PfwBHJXMh8UvZJMBJtBFvwUmMk1X9JiMvKT/9GEdp8d2rTUxf5NqnnXPxBe8p0Hv8ZyXqh2IYc65sZJIAC5Zyv1h67za4YMXRyRlsCjD4HM/6UD8FCrQ4h/JncjLiJNPzBz7UzTnJSv82KnhWENREhg2c69/lJlY1/n3WUVvv6e/g6FWAFDAW8JlKox0wYjknieWQ/ERbcfh8AQgbDIEcaCgMGNJ4+Ih/acC/8KfRDQBH0pY7b9Lpr3ysYRoHwwUi3KyFWwyEwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A58UgXQkq+C1jVWPkw4UUEnDKnSxC5M3pSeZF1uJd1E=;
 b=jW8VK+oS7ySqplg/PljWdttGBNov2QnE+d5TFHDKBVy9w5co1ihqDlDzn7G8bTXObSQ1tq0OEhqm7shuyxrN/OHEfTCy7OnoGOXBY5H0TJZEWhxo2P50nUgNT2pf0PoRkuXr7fv6vtQT34EN6pA/AZpIxrkNPrK2YoOCOgR9k50Ug79S8bl4HFvwpwoRHDt8LXDAi37N9i+Tk2VpF6WkmNOjygGnxw9Wdb+gR1WR3FkUWHcsrw12K5Qp5LOZja0Xl1f3sS1jLRL6N1Y+v0ZN1nggvF0etAMZeQOIh7K0oCGre1i+aJ78n75SlEhpWGb5v+mkOxa49TdsjA+fAoSHZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A58UgXQkq+C1jVWPkw4UUEnDKnSxC5M3pSeZF1uJd1E=;
 b=WVHrC8ZZQqRPtUqD3SkFDa2N53HGOYNhmsOM06tqOv1uOr5EWu8t+g0GaUe55Vw1a8Mzi4DxJjowazfEG+jIVZD4IidII7Q06fuVVH9rDmuxyx/oTGQ3+9sogFFbbYMTrNjXxmimi3bKlF3I4qtABMij+jSh8s1ROrep959kgso=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
Received: from SN6PR12MB2845.namprd12.prod.outlook.com (52.135.106.33) by
 SN6PR12MB2608.namprd12.prod.outlook.com (52.135.99.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Mon, 10 Feb 2020 16:47:12 +0000
Received: from SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b]) by SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b%7]) with mapi id 15.20.2707.030; Mon, 10 Feb 2020
 16:47:12 +0000
Subject: Re: [PATCH 0/4] perf tools: Fix kmap handling
To:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200210143218.24948-1-jolsa@kernel.org>
From:   Kim Phillips <kim.phillips@amd.com>
Message-ID: <7de7aa09-d59b-3e98-6289-d497aa0496d4@amd.com>
Date:   Mon, 10 Feb 2020 10:47:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200210143218.24948-1-jolsa@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0601CA0012.namprd06.prod.outlook.com
 (2603:10b6:803:2f::22) To SN6PR12MB2845.namprd12.prod.outlook.com
 (2603:10b6:805:75::33)
MIME-Version: 1.0
Received: from [10.236.136.247] (165.204.77.1) by SN4PR0601CA0012.namprd06.prod.outlook.com (2603:10b6:803:2f::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.25 via Frontend Transport; Mon, 10 Feb 2020 16:47:11 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 56fe4ccb-241f-4c97-fcec-08d7ae48e058
X-MS-TrafficTypeDiagnostic: SN6PR12MB2608:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2608000F09769DD59CBD4DB687190@SN6PR12MB2608.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 03094A4065
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(136003)(39860400002)(396003)(346002)(189003)(199004)(316002)(66476007)(66946007)(16576012)(54906003)(110136005)(66556008)(8676002)(5660300002)(81166006)(81156014)(26005)(2906002)(186003)(16526019)(478600001)(86362001)(31686004)(6486002)(52116002)(53546011)(44832011)(36756003)(31696002)(2616005)(8936002)(956004)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2608;H:SN6PR12MB2845.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lA5aUumwbNWaAflRkvV98cOeL+FRECKVQ3oRWp6O3t528zguhxgchCvcM+Z79sz1HQSn8mUVvzDp5RH+pX1FbfjoYMC72ddmC/HXEtIq2Aab8zV4I1FrOw6gsIk3KhAPF4eHYnhjdCoculrJrrWX8OoZ/YOJt7vyvbTgQcvsL3S0PxPKLJrFRY53vUyCDpEVNUmKxB6CFofx95WHYaaVsH2uKP+fRxvbokZM+ihtFVYQyxDmORdUTthw4P3imB8XyDdkXHvLOh4lARNdK6PP2qkiId08XK6v1aKEP1eglRBRFmuVlxQQ6WdlzGarq2fatMJX4fnl4lj4SuVP7UB3oeMcCofXGaQ3E0RLi4t46fD+ec0CwBgzUWpA51/b1/mPHWR79N8UdXY/wPOYZ1yBWJhY8gb5Xb7D9b1HoIdrPm7r3eANfFPXeo6MCSJXAE3G
X-MS-Exchange-AntiSpam-MessageData: 10/de2bb92zSkn2MH1xph7txRkoXBicfO6xQagJrpQwE1hoNWujeSCxMLztj5YTw6yVEQgT6EsqA8uSLpJudX8P+T3STAxDg02uw8mLs9I4zW1Q53RSCCFNpHcFCVVrUKppYVQ6hOCwx++ELoxXa0Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56fe4ccb-241f-4c97-fcec-08d7ae48e058
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2020 16:47:12.3199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QB5r6HnZLzJrTmWEd72MH8A68wWBoeHh0dFfl7q4AhweeMDQniH1vVvQgoEZIN2SrBL79IdoP8s4k2PWkYVVuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2608
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/20 8:32 AM, Jiri Olsa wrote:
> hi,
> Ravi Bangoria reported crash in perf top due to wrong kmap
> objects management, this patchset should fix that.
> 
> thanks,
> jirka
> 
> 
> ---
> Jiri Olsa (4):
>       perf tools: Mark modules dsos with kernel type
>       perf tools: Mark ksymbol dsos with kernel type
>       perf tools: Fix map__clone for struct kmap
>       perf tools: Move kmap::kmaps setup to maps__insert
> 
>  tools/perf/util/machine.c | 24 ++++++++++--------------
>  tools/perf/util/map.c     | 17 ++++++++++++++++-
>  2 files changed, 26 insertions(+), 15 deletions(-)
> 

This series fixes a segmentation fault I was seeing on a
couple of AMD systems, so:

Tested-by: Kim Phillips <kim.phillips@amd.com>

Thanks,

Kim

Thread 259 "perf" received signal SIGSEGV, Segmentation fault.
                                                              [Switching to Thread 0x7fff3b7b6700 (LWP 13241)]
__map__is_kernel (map=0x7fffd80098d0) at util/map.c:244
244		return machine__kernel_map(map__kmaps((struct map *)map)->machine) == map;
(gdb) bt
#0  __map__is_kernel (map=0x7fffd80098d0) at util/map.c:244
#1  0x000055555575d756 in perf_event__process_sample (machine=<optimized out>, sample=0x7fff3b7b5710, 
    evsel=0x555555ef9dd0, event=<optimized out>, tool=0x7fffffff8660) at builtin-top.c:799
#2  deliver_event (qe=<optimized out>, qevent=<optimized out>) at builtin-top.c:1192
#3  0x0000555555831f81 in do_flush (show_progress=false, oe=0x7fffffff8960) at util/ordered-events.c:244
#4  __ordered_events__flush (oe=oe@entry=0x7fffffff8960, how=how@entry=OE_FLUSH__TOP, timestamp=timestamp@entry=0)
    at util/ordered-events.c:323
#5  0x00005555558328df in __ordered_events__flush (timestamp=<optimized out>, how=<optimized out>, oe=<optimized out>)
    at util/ordered-events.c:342
#6  ordered_events__flush (oe=oe@entry=0x7fffffff8960, how=how@entry=OE_FLUSH__TOP) at util/ordered-events.c:341
#7  0x000055555575d0f1 in process_thread (arg=0x7fffffff8660) at builtin-top.c:1104
#8  0x00007ffff7bbd6db in start_thread (arg=0x7fff3b7b6700) at pthread_create.c:463
#9  0x00007ffff5d9788f in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
(gdb) p map
$1 = (const struct map *) 0x7fffd80098d0
