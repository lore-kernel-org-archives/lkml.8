Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE56EC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 05:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB43D20748
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 05:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="pU68ckCo";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="NLoN3c4k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgIDFDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 01:03:21 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48494 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725812AbgIDFDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 01:03:20 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0844vun4003642;
        Thu, 3 Sep 2020 22:03:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=uD3Z2KNMz1p5zjb7LqoM4lZhhfMPOR/McDy1S5mpo70=;
 b=pU68ckCokxJ11F98LUWl2CVZm15gXoyGT4MzmDR1d2++Eqg3Q9wAZxh6yjDcGu3eagvT
 IbOEgLPRlVBYk81NquLJF85dAXnGB3zV8OPCNkjAVTTuJvAfuaHvS/d6mLLyG4vh0T2b
 ziAMzt2Gfmf6jsM9oI11+pJxX31JROm0n8M= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33b8yphpbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 03 Sep 2020 22:03:07 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 3 Sep 2020 22:03:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2ycekJFjccxJBfoFanpoWsTD3MxyRaxcnnzbMwSjiJDcBnDs0i0d+uzD7o2uxVwkCFCFwzPv4O+4umJuBS3cd30l8jfY04qQTkoCLqFGhfBiOBf0oA3DvkqcLo5cDlEN4FVXv32q4i1a9JhbvLyJREI8rOakTolVAtaqRWNA+3OIiuzFVNlMT9Q98p/gyD8ctprQf576gjBxwBGHvkdh3z8UIWTip2y/5J2at45YJMuMV9Y444JxhgvKaF/Tg0eu+rpV36qMF7BRAZWeS5ZO9zlCwL3nxRysMs77T88Rup2MuP9Gx3EDrz6f51PGxJn3v6+5sHs2LfA0EZUI94R0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uD3Z2KNMz1p5zjb7LqoM4lZhhfMPOR/McDy1S5mpo70=;
 b=jscBU6HEYJ3hcCSSfB3ofHq0Drg7oUNpAuGK06Gk7fMxtswWXYq9N9dwjztzVaZYvzZQu1yMbL7xfLFxryM5K2Vt7Di5dGBsTeefYI0n5pUag4KYGaU+o1so/vZPoTu5Oc7AdZMSWJzItDPe82TtiW6mj83YT7gv7tVdMQu2F6RH+0hIBTjka87yR1cW4ek4CMzlOpcTTBypbDF11knkOs5iLnnrI6qkkeQ4WNZeXQMlY9UwCjgoR5z2pI60j/l1DArkPvH9DCygHkPyjy4+8bEzSPnzX7iFxf52wG0hUNcI4/pJQPIm8oR5W5bmiLGAGFz574wuzCoMRJvvRIynSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uD3Z2KNMz1p5zjb7LqoM4lZhhfMPOR/McDy1S5mpo70=;
 b=NLoN3c4kW2aQR3g1YT8q6YofBkuoou+FsM7MXK634RsTQJ5DSEvobcEUbb0dBIkE7rBc3Gz48lX5Idb7UZPENzAi7cdZlz3JVOk8ZyHOEzTsdxS7YuhypnexcT/0bJAr71PRC1hdt7C6CbOGy216lbs22eD+veyj5tUuKqHPGBA=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2629.namprd15.prod.outlook.com (2603:10b6:a03:14f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Fri, 4 Sep
 2020 05:02:51 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e%6]) with mapi id 15.20.3348.016; Fri, 4 Sep 2020
 05:02:51 +0000
Date:   Thu, 3 Sep 2020 22:02:47 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm: workingset: ignore slab memory size when calculating
 shadows pressure
Message-ID: <20200904050205.GA483835@carbon.lan>
References: <20200903230055.1245058-1-guro@fb.com>
 <20200903211059.7dc9530e6d988eaeefe53cf7@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903211059.7dc9530e6d988eaeefe53cf7@linux-foundation.org>
X-ClientProxiedBy: BYAPR07CA0063.namprd07.prod.outlook.com
 (2603:10b6:a03:60::40) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:4235) by BYAPR07CA0063.namprd07.prod.outlook.com (2603:10b6:a03:60::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Fri, 4 Sep 2020 05:02:50 +0000
X-Originating-IP: [2620:10d:c090:400::5:4235]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29091482-81c0-48fd-493d-08d8508fc65b
X-MS-TrafficTypeDiagnostic: BYAPR15MB2629:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2629D7DCED085B959E2ECAA0BE2D0@BYAPR15MB2629.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yrJ70i/XHeyqIQIMprBKaYZ7WsQ8FAIu4TjoFhVDHpdmfLTchy0OP84I+OBBqyMB+X7kJ0vLJu2Wh1rJjCQX+yhp6bh3jvNb3vAqXZzEBmvFGkpB0ac7pYufHzcuwZHSUZj2W0e3H1qFpfS+2yIIywvoqnQhfAG27YRpiM9mwIcaAsre4rcF8X5KCFQUm5Wmc6CmZvcofEEkzTWMaN8xfYWGmGn5+1vWrCznE6mePnFT6zvvipB30zJtR2WYo1mul3Axdxiuw6UlrJ7VQRa0O2LLkRgcJibt6fuKBauuBHUXY+IzWU8U78i7sQx3UZuZQjTLMxGtwVq8+kh0yiLD6UX+DS9O3Y5jzRILq2LTIhK1QqivVcm4Ir4RppKg4xUP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(346002)(366004)(376002)(55016002)(86362001)(83380400001)(7696005)(52116002)(4326008)(316002)(54906003)(5660300002)(8886007)(478600001)(1076003)(2906002)(6506007)(16526019)(186003)(36756003)(6916009)(66556008)(66476007)(8676002)(8936002)(33656002)(6666004)(66946007)(9686003)(27376004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: mJUJ08I6ye+cwKAT8C+mzNQ0bk3HgwLbrloXEG4fpKeX3L+Az7/t4SQvOsKZo5D4UMAshSvmHFkZzRLgmsjFgd1BL5i+cvCIStTdlokFnKqndZhfL1lcSRAfRnbaYj19/K8h+keFrPkyk3EskKk8eCUQnhBLlrN06Vxrk/bqEqQKHpDy+7Q8zTb+tVaqz3oZnJWAbXqqnP2XwOezdKfDzMtfc9ub9v8AZfMBdhM0UZo2DI50t7queK1M+yb4orext1cDbt11+YdNvOf2czmIlJvs/AGR2ko2IhbWAUXGqsGWGWk0xOF5jh5p/wkFJbiIwVPOszIDLlRvRc5PHxItDhi++FMmFuVBEcD7x0IbowJGeK5AHDRmg26OANzR1BX8nTWwNX+Xslg3T6r2SPdv3lIA7aZvaTpY2sVOm4TpR6a8an7HGzqj7f6XQVB/eNkYoDmMGWlmB6OGjgXQ01Do/EYKXEennim1AYl5EWN1r44oUxv1oQta9i1vGjthKshBrKV9HeAJs7doGKEKi2WL+8Q63rjslqGJaKAlAlBlwBVzec9ltuY+6Ug9pzkhq8qRenn6OH2XcOSftQWQNHTa86ajahtGEzdIbBWrLCSo2xE/OWg1rBNBSmi18wEth+CuYwib1036PKMuvVCmWjZzE0/Le4wPZrt6rh8mBleygW138Avi5VufF1ljxtztzRuf
X-MS-Exchange-CrossTenant-Network-Message-Id: 29091482-81c0-48fd-493d-08d8508fc65b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 05:02:51.4430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hm7Aa08gSze7XkpqPbCchsDKfjo4kKnZje65jFX1tEx2usA3kj/XHmDWQjzmHkR4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2629
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-04_02:2020-09-03,2020-09-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009040046
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 09:10:59PM -0700, Andrew Morton wrote:
> On Thu, 3 Sep 2020 16:00:55 -0700 Roman Gushchin <guro@fb.com> wrote:
> 
> > In the memcg case count_shadow_nodes() sums the number of pages in lru
> > lists and the amount of slab memory (reclaimable and non-reclaimable)
> > as a baseline for the allowed number of shadow entries.
> > 
> > It seems to be a good analogy for the !memcg case, where
> > node_present_pages() is used. However, it's not quite true, as there
> > two problems:
> > 
> > 1) Due to slab reparenting introduced by commit fb2f2b0adb98 ("mm:
> > memcg/slab: reparent memcg kmem_caches on cgroup removal") local
> > per-lruvec slab counters might be inaccurate on non-leaf levels.
> > It's the only place where local slab counters are used.
> > 
> > 2) Shadow nodes by themselves are backed by slabs. So there is a loop
> > dependency: the more shadow entries are there, the less pressure the
> > kernel applies to reclaim them.
> > 
> > Fortunately, there is a simple way to solve both problems: slab
> > counters shouldn't be taken into the account by count_shadow_nodes().
> > 
> > ...
> >
> > --- a/mm/workingset.c
> > +++ b/mm/workingset.c
> > @@ -495,10 +495,6 @@ static unsigned long count_shadow_nodes(struct shrinker *shrinker,
> >  		for (pages = 0, i = 0; i < NR_LRU_LISTS; i++)
> >  			pages += lruvec_page_state_local(lruvec,
> >  							 NR_LRU_BASE + i);
> > -		pages += lruvec_page_state_local(
> > -			lruvec, NR_SLAB_RECLAIMABLE_B) >> PAGE_SHIFT;
> > -		pages += lruvec_page_state_local(
> > -			lruvec, NR_SLAB_UNRECLAIMABLE_B) >> PAGE_SHIFT;
> >  	} else
> >  #endif
> >  		pages = node_present_pages(sc->nid);
> 
> Did this have any observable runtime effects?

Most likely not.

I maybe saw the second effect once, but it was backed up by a bug in the inode
reclaim path in the exact kernel version I used (not an upstream one).

The first problem is pure theoretical, I'm just not comfortable with using these
counters, which are known to be inaccurate after reparenting.

That's why I didn't add stable@.

Thanks!
