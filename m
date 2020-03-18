Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54A1C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E9220767
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Br9NjAw3";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="AVCH4J1k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgCRRz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:55:57 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43558 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726506AbgCRRz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:55:56 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02IHjYjY016839;
        Wed, 18 Mar 2020 10:55:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=S6t2U554xppq9tEijCburDkvFLUJcM0ll9tzpS5MegE=;
 b=Br9NjAw34OGMHMteR/+KXiwHvfh5v5qagQePWhC2sAXWmxXdTZiMEKtfaH9ghpVtTR+x
 dbpj1HDu2z52/O1FkGEUVNsOZFhtOwHE8yhFn6l7ccjmUQ/gDzSK7PKAYexL5tyadjqU
 Fxu+8UqdWvAQ6v2T4F0dhOQv2ug+PGV1JN8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2yu8x3kwqp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 18 Mar 2020 10:55:38 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 18 Mar 2020 10:55:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IInELBNEDXMsEiSkWMh6QDp3wYUvtiCAFqNQ+uxDwJ0MmcKlmvEGSirX2l9bOd4GOvARG806W9BLs3ArBvVBpfBIDVRIKjxCKy4NUiU66wNgkeRJJl0j7w5rAE1svDxsMO58Bv30FH03jSoxt6QUSsvEXCVhWSU30Deo//2RD32nwPTFwat4OT6IYjXVEomlfnRM28W/A1rKqLtEndx+Z2u7sgLQUH1wIu7QCjI/1KKrYGCWIEwN5x5p1l4S6lVC771SzHowlCl+G7IlYibXiR8iaP5tkqt1Y1ZBoCR0NoDjniACW3rx1+Q5+kLy/pdjhpFz9niTIXJ7FJ8FvcMYIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6t2U554xppq9tEijCburDkvFLUJcM0ll9tzpS5MegE=;
 b=MYn1GYLmpTFf9kKSlHLgTP0/Y5Bhi2dnfgo8hL64FparptU4bli4FmIY0M1tHBA5HcV+FOdf32PyQIwqxDYOxdq2n9UZeC2vsPPqpcIdbVuDhDxJtfDCbOh52NKh6WIzeP06b5IGsETGGbgccLw7Au+U3mivxmWlsDHIA+fIzWOw5g9lsdoTUC40QVn1rQhK6lnD7E85Au5TS+1iNUy1+s7DkCVIesoCxkHV1LeHNkAZJUymDNtTePQr/0wdNWRRxtJvHdSQ2fkyXtAKHbTa2hb+9zwTayEbmVA+H22fY2BJl8Aw6ur7O26K01sEf3elVu/kkARqNq6DQcNolO0/rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6t2U554xppq9tEijCburDkvFLUJcM0ll9tzpS5MegE=;
 b=AVCH4J1kCd8EvhxdN0qY6Se9owEn4e3thjXAmENLvTzpyfCoF8kBWjlrNt6YU0fujzRdFN1wcJlZ53/Vqymu018uK9c2ZErajkSWrxb2umjZcDpECC1mcjjGvHxr2/Ty2pHM4jagNe+DYUa+XYB4RALTBqLnREaU/u1ajsHrOJQ=
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3192.namprd15.prod.outlook.com (2603:10b6:a03:10f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22; Wed, 18 Mar
 2020 17:55:34 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::a0af:3ebe:a804:f648]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::a0af:3ebe:a804:f648%6]) with mapi id 15.20.2814.021; Wed, 18 Mar 2020
 17:55:34 +0000
Date:   Wed, 18 Mar 2020 10:55:29 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Andreas Schaufler <andreas.schaufler@gmx.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH] mm: hugetlb: fix hugetlb_cma_reserve() if CONFIG_NUMA
 isn't set
Message-ID: <20200318175529.GA6263@carbon.dhcp.thefacebook.com>
References: <20200318153424.3202304-1-guro@fb.com>
 <20200318161625.GR21362@dhcp22.suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318161625.GR21362@dhcp22.suse.cz>
X-ClientProxiedBy: MWHPR12CA0055.namprd12.prod.outlook.com
 (2603:10b6:300:103::17) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:5050) by MWHPR12CA0055.namprd12.prod.outlook.com (2603:10b6:300:103::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.21 via Frontend Transport; Wed, 18 Mar 2020 17:55:33 +0000
X-Originating-IP: [2620:10d:c090:400::5:5050]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b20a1ad5-38b3-4244-ab25-08d7cb658e97
X-MS-TrafficTypeDiagnostic: BYAPR15MB3192:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3192EFC9FBAB618C3EC48D74BEF70@BYAPR15MB3192.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 03468CBA43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(136003)(376002)(39860400002)(199004)(54906003)(316002)(66476007)(66556008)(66946007)(4326008)(81156014)(33656002)(9686003)(8676002)(8936002)(81166006)(1076003)(55016002)(86362001)(2906002)(52116002)(7696005)(186003)(16526019)(6916009)(6666004)(6506007)(478600001)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3192;H:BYAPR15MB4136.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F3pmhNGoFY7BhDHdXYiJsLEd2v41W8QCfBy9ty4F63bM86O3A4kJlAFpI/CmuA+BasdqeZEReGPCXTnQcbi9ucW6xCfW0DW6XFhAsGJEeuZu3yTTp4f7+EAHuqKBFDz9y85n2EyO7JLTATgKC6VrFc+bmJenQjgxkyeVtNX/YsKpPwv6lh+PfKDLryGt4hrenIxa7l7Nkc37K1lD8ZWSBukb1Yq9beahxHQCHEveo+Z63Cj68cbtncQAARX2F06J9+e/fMDqYNcS4Ust4UH6/BIxY/XItGh0Bf+Rt5iJCeP2p1xq9LE5N86Byn+UVk85uPvJSVTh+tu2KF2AOjgeYyoeqDPtx1vNWZDgwl2FYx/kUvYORBR558QDSHK5dyakcxaJ0m44C5o6w2HSIvcP1JbU5I2np64+XXK3FS5WCj26iozKJEnCZYImAp6hHurn
X-MS-Exchange-AntiSpam-MessageData: pF+1eo2K7ZxeywwkJxkXHGoDBMS4/JsmbHcoVebS6GDTtF+rxrJffCQRW+jwI01yUXBgVJ/rYI5AV7hwlnovH8FBX+9XrZwlpGyfbdccO1FdhX7kGeIHtyfmlu4xFrx5tsmJtLHPwcEkD/K8YRWELAs9Jl6DCsO0KMUemjyVJOOtP7wuhFbf+UFDZTXEGB4u
X-MS-Exchange-CrossTenant-Network-Message-Id: b20a1ad5-38b3-4244-ab25-08d7cb658e97
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2020 17:55:34.2673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lmkoQW/OrSynCM/hYfuV/I13uSfU8SgAs5Z1P+2P+9cnEuRoGZi//VUL08qa0N7m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3192
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-18_07:2020-03-18,2020-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 spamscore=0 suspectscore=1
 clxscore=1015 mlxscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2003180080
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 05:16:25PM +0100, Michal Hocko wrote:
> On Wed 18-03-20 08:34:24, Roman Gushchin wrote:
> > If CONFIG_NUMA isn't set, there is no need to ensure that
> > the hugetlb cma area belongs to a specific numa node.
> > 
> > min/max_low_pfn can be used for limiting the maximum size
> > of the hugetlb_cma area.
> > 
> > Also for_each_mem_pfn_range() is defined only if
> > CONFIG_HAVE_MEMBLOCK_NODE_MAP is set, and on arm (unlike most
> > other architectures) it depends on CONFIG_NUMA. This makes the
> > build fail if CONFIG_NUMA isn't set.
> 
> CONFIG_HAVE_MEMBLOCK_NODE_MAP has popped out as a problem several times
> already. Is there any real reason we cannot make it unconditional?
> Essentially make the functionality always enabled and drop the config?

It depends on CONFIG_NUMA only on arm, and I really don't know
if there is a good justification for it. It not, that will be a much
simpler fix.

> The code below is ugly as hell. Just look at it. You have
> for_each_node_state without any ifdefery but the having ifdef
> CONFIG_NUMA. That just doesn't make any sense.

I don't think it makes no sense:
it tries to reserve a cma area on each node (need for_each_node_state()),
and it uses the for_each_mem_pfn_range() to get a min and max pfn
for each node. With !CONFIG_NUMA the first part is reduced to one
iteration and the second part is not required at all.

I agree that for_each_mem_pfn_range() here looks quite ugly, but I don't know
of a better way to get min/max pfns for a node so early in the boot process.
If somebody has any ideas here, I'll appreciate a lot.

I know Rik plans some further improvements here, so the goal for now
is to fix the build. If you think that enabling CONFIG_HAVE_MEMBLOCK_NODE_MAP
unconditionally is a way to go, I'm fine with it too.

Rik also posted a different fix for the build problem, but from what I've
seen it didn't fix it completely. I'm fine with either option here.

Thanks!

> 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Reported-by: Andreas Schaufler <andreas.schaufler@gmx.de>
> > ---
> >  mm/hugetlb.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 7a20cae7c77a..a6161239abde 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -5439,16 +5439,21 @@ void __init hugetlb_cma_reserve(int order)
> >  
> >  	reserved = 0;
> >  	for_each_node_state(nid, N_ONLINE) {
> > -		unsigned long start_pfn, end_pfn;
> >  		unsigned long min_pfn = 0, max_pfn = 0;
> > -		int res, i;
> > +		int res;
> > +#ifdef CONFIG_NUMA
> > +		unsigned long start_pfn, end_pfn;
> > +		int i;
> >  
> >  		for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
> >  			if (!min_pfn)
> >  				min_pfn = start_pfn;
> >  			max_pfn = end_pfn;
> >  		}
> > -
> > +#else
> > +		min_pfn = min_low_pfn;
> > +		max_pfn = max_low_pfn;
> > +#endif
> >  		size = max(per_node, hugetlb_cma_size - reserved);
> >  		size = round_up(size, PAGE_SIZE << order);
> >  
> > -- 
> > 2.24.1
> 
> -- 
> Michal Hocko
> SUSE Labs
> 
