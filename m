Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8ADFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B188122CB3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="fBfhXqeR";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ck4SimZf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731157AbgGTUUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 16:20:38 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35144 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729223AbgGTUUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 16:20:37 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06KKB0rM015585;
        Mon, 20 Jul 2020 13:20:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=vTcIDB03+L5aGMFWHmfciXOnzsXOVk7qficFIxXYiGI=;
 b=fBfhXqeRxwwFIcxeipSMhXueMVfYtkLTv2i9E8+KM4gdK1sBwlW3V0LA1WTa6IAW2LAl
 BrU62W6pjR90NXBxf/dozpGz9Ji97KqKxwZoTj/daXmQiQ8MCzeaSSQLcUYblOMUOZBZ
 aFMhjGmrnAcdPPeYz0SaUQ4M7nNEuswU5pY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32bxu0gd3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 20 Jul 2020 13:20:29 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 20 Jul 2020 13:20:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4trZpMUQHFTP7lv2ERUVw+CmHLnqclqKq7JUfRS5yyK85M75dfF5EnXy0G+9cAG+4SkcfveQmXPbtPMKq0aIgaJCD1yxvQ/ej5bHYDVna1v8X0PJuB1YfPyCjK/aCxVtcxHb9MYhxP9ddSNtO1cqUykOWWjmej53lDOx+LC5FkGV8DOaSusInkCDJ4doLV8X8+iEzdMFJJV2+Vo2C4Xw3cfPzbrNhlMKuOwatlWCCE4maMivzD8iynw6jug7w9jZtZtPHl2faqgCD9hbP8p4atg8201nLRUge5JmoWagRNd0Ga5ojfuYl308B2wAY5QJMm0ll3LIPy9kJPnLmO08Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTcIDB03+L5aGMFWHmfciXOnzsXOVk7qficFIxXYiGI=;
 b=K8dpQxRt3tsd1sP1Ynu2OUuVYxIJ7z3G16AUuad4WQwxXA/hYAh6/rpfllHU7QtSFbwm4COePO69nUfu4WTuA00qPm0XJe2BCRsQ4gHjUlZXetlus9eSoZJnXEF3kly8ZHsZzT8mVqiXHa7aQQj+mtyT/bkHftyKOLWyD//4V4nvWDGYGOqjsamxqL7E6f0xyM5SgBM8kbMPoiXTDX6U73/FFmWW1Mu4UA7DTjKXsG7mCLC1Aot0gRjnheS6LhC4sSreQaxdBd/WQMrrbMvstlLPMgQRcqkm23DzeOuVEBLWCoWNMgMkUyC9Yfs16+cyDVj7bYZxXKkGvzHYuqWCBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTcIDB03+L5aGMFWHmfciXOnzsXOVk7qficFIxXYiGI=;
 b=ck4SimZf42otD5e07i8H4oZuLPJulVdWI1CMi7/khhvFCUhetnIe7y7OSHJS1xWCy+O9Gsbim+rDCT6w+DMorNgIO0ESXJPhO5y7fcfvrIlHRzB+V5Ema2ubdEaK1F2ClkzbdezGGC5obptJ46vbH5FkmBVonO6xPn+Q1kGRGoI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3603.namprd15.prod.outlook.com (2603:10b6:a03:1f7::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.24; Mon, 20 Jul
 2020 20:20:25 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 20:20:25 +0000
Date:   Mon, 20 Jul 2020 13:20:21 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2] mm: vmstat: fix /proc/sys/vm/stat_refresh generating
 false warnings
Message-ID: <20200720202021.GE139672@carbon.dhcp.thefacebook.com>
References: <20200714173920.3319063-1-guro@fb.com>
 <20200720080349.GC18535@dhcp22.suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720080349.GC18535@dhcp22.suse.cz>
X-ClientProxiedBy: BY3PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:254::28) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:4691) by BY3PR05CA0023.namprd05.prod.outlook.com (2603:10b6:a03:254::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.14 via Frontend Transport; Mon, 20 Jul 2020 20:20:24 +0000
X-Originating-IP: [2620:10d:c090:400::5:4691]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50d94c70-cc37-451a-a5ec-08d82cea55e4
X-MS-TrafficTypeDiagnostic: BY5PR15MB3603:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR15MB3603563625988E56922CD3F9BE7B0@BY5PR15MB3603.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vyd7UzNTjhXZM8n69MHxXDLkA94bawS3dA9nCcQlOTyfmoS87AWKb3i185LE7Suim6P+IcDT52vfbV1dEXxPG5OzulZvekjI17iszirw0HimV4OhBOj3rbfJLSuBxyrukYK03b5bzZYtbvmqpakhlThSPr2ndq67QSqdkaEdc1LlImX7iRXm6FSqgyetaGvjQwXgSXzlJqbqMqa38zNkXWOxFEO+fPuGN5m1IZhoH2TojoB8f7/UluJiRnYl8ilwgbAK9mTWpkD3MMRo+ooNjgGynlAPbqQ+3lJf2S2mEPWBO2ACnjOgvCfKQ/adtQ4LeC/2soNMZfBmYudsMj0JIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(136003)(366004)(396003)(39860400002)(8936002)(2906002)(83380400001)(5660300002)(54906003)(316002)(6506007)(33656002)(6916009)(86362001)(7696005)(186003)(1076003)(16526019)(6666004)(52116002)(55016002)(4326008)(8676002)(9686003)(66946007)(66556008)(66476007)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: SCRNNo2HI0e/iP4BbS/wYsWltvcvNGM712X8lhqysFVFbgWDuRx8ydpONpT7el9Tq3zV22UkQ1PlUIPmJVxNyzrj/v7S2J8tacviM6g8vtHR6EPcSiXNzG/fwao+9d69wl1Rb43qlDVQ0OV8vYSNM0fLkVCqcJ2Xm/eZejwxQnTd5nPaaMjbRndmjgWjlQTrjCYLkUckNsKT4dAP5Imde9L/yfdCBHLLwcDAqjt10RyJzYCWs0bTCAeRfm4NoKFcO5kvdSpj+3/4E962m7iBjh+TXruet2NeHCJayWrrktwnxb6eMhYkFd+58BoyEVBzWSMHHoCDZlpGwAprMmyh+mAWQGz66i7cqVtLrevG7TUs14FIj055dn1DNckkfhI33b2LiOnc3wO1cc0I2LTckSmeMkMXao1FfvZzZ+7YfY5x7zVA3Lh+ZrA498XhgzseWsnGch9j59prcUzEpzJCmlKIF28siRUqw8b5wwlE8o6OWO1RW8NbobWGgt1e9Rr/nzzMoxPvpBYqmtyyyZ4oJw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d94c70-cc37-451a-a5ec-08d82cea55e4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 20:20:25.4908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nUHjOjlzkQImQEysh46DvFPZQHS3lSJ1QRU/3T/n4K4fS+KMdsCbkQ0UdVqSL/Wq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3603
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-20_09:2020-07-20,2020-07-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=5 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007200136
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 10:03:49AM +0200, Michal Hocko wrote:
> On Tue 14-07-20 10:39:20, Roman Gushchin wrote:
> > I've noticed a number of warnings like "vmstat_refresh: nr_free_cma
> > -5" or "vmstat_refresh: nr_zone_write_pending -11" on our production
> > hosts. The numbers of these warnings were relatively low and stable,
> > so it didn't look like we are systematically leaking the counters.
> > The corresponding vmstat counters also looked sane.
> > 
> > These warnings are generated by the vmstat_refresh() function, which
> > assumes that atomic zone and numa counters can't go below zero.
> > However, on a SMP machine it's not quite right: due to per-cpu
> > caching it can in theory be as low as -(zone threshold) * NR_CPUs.
> > 
> > For instance, let's say all cma pages are in use and NR_FREE_CMA_PAGES
> > reached 0. Then we've reclaimed a small number of cma pages on each
> > CPU except CPU0, so that most percpu NR_FREE_CMA_PAGES counters are
> > slightly positive (the atomic counter is still 0). Then somebody on
> > CPU0 consumes all these pages. The number of pages can easily exceed
> > the threshold and a negative value will be committed to the atomic
> > counter.
> > 
> > To fix the problem and avoid generating false warnings, let's just
> > relax the condition and warn only if the value is less than minus
> > the maximum theoretically possible drift value, which is 125 *
> > number of online CPUs. It will still allow to catch systematic leaks,
> > but will not generate bogus warnings.
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Cc: Hugh Dickins <hughd@google.com>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
> One minor nit which can be handled by a separate patch but now that you
> are touching this code...

Thank you!

> 
> > ---
> >  Documentation/admin-guide/sysctl/vm.rst |  4 ++--
> >  mm/vmstat.c                             | 30 ++++++++++++++++---------
> >  2 files changed, 21 insertions(+), 13 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
> > index 4b9d2e8e9142..95fb80d0c606 100644
> > --- a/Documentation/admin-guide/sysctl/vm.rst
> > +++ b/Documentation/admin-guide/sysctl/vm.rst
> > @@ -822,8 +822,8 @@ e.g. cat /proc/sys/vm/stat_refresh /proc/meminfo
> >  
> >  As a side-effect, it also checks for negative totals (elsewhere reported
> >  as 0) and "fails" with EINVAL if any are found, with a warning in dmesg.
> > -(At time of writing, a few stats are known sometimes to be found negative,
> > -with no ill effects: errors and warnings on these stats are suppressed.)
> > +(On a SMP machine some stats can temporarily become negative, with no ill
> > +effects: errors and warnings on these stats are suppressed.)
> >  
> >  
> >  numa_stat
> > diff --git a/mm/vmstat.c b/mm/vmstat.c
> > index a21140373edb..8f0ef8aaf8ee 100644
> > --- a/mm/vmstat.c
> > +++ b/mm/vmstat.c
> > @@ -169,6 +169,8 @@ EXPORT_SYMBOL(vm_node_stat);
> >  
> >  #ifdef CONFIG_SMP
> >  
> > +#define MAX_THRESHOLD 125
> 
> This would deserve a comment. 88f5acf88ae6a didn't really explain why
> this specific value has been selected but the specific value shouldn't
> really matter much. I would go with the following at least.
> "
> Maximum sync threshold for per-cpu vmstat counters. 
> "

Agree. Below is the diff to be squashed into the original patch.

Thanks!

--

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 08e415e0a15d..ddc59b533599 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -167,6 +167,9 @@ EXPORT_SYMBOL(vm_zone_stat);
 EXPORT_SYMBOL(vm_numa_stat);
 EXPORT_SYMBOL(vm_node_stat);
 
+/*
+ * Maximum sync threshold for per-cpu vmstat counters.
+ */
 #ifdef CONFIG_SMP
 #define MAX_THRESHOLD 125
 #else
