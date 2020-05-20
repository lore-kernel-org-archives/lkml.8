Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A66C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 19:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3DD020758
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 19:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="k5cGZb8j";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="YAfKhmJw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgETT1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 15:27:23 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:17454 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726560AbgETT1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 15:27:22 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04KJO1Se001286;
        Wed, 20 May 2020 12:27:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=nofm9MPEFWuHDTbfW7X9gmETCR5y032TBU5uz0NDD78=;
 b=k5cGZb8jjepKCvQnF75QkZ7e6ZPolyKD0+3IXfxemCAoxdCU7MCe6wCLtS/FLl6Hc3J7
 R4ZmKR78Hf6FBKYpkLpZr830qO8RkPrUdXZmZjW+oyHLSECjBHs96a1q5Wdl60Q4fLS5
 ilgbvjqb/TnyCi/qpC6RCsZgiL/E5ii9ff0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 312e0hrsmk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 20 May 2020 12:27:13 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 20 May 2020 12:27:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hv9k++RjAmV7/Whgv+/NBWFlFu9jPTZ8U1fqRpzQ8I92xfjBlGqswZ80ZXE2oPcbQOl7zjrZGT9LHra6JdGns9rqN3/Y2RMSTRYKTMB1p790a7DZwXjG+fi+UztpItW+p1jwz9uzLLQ2JDZDHzse+gNDeFad0pHEE7D5zsmv+DmjUheVh3LLlA7pBm6/hou2xYqAvAvpBIwSW560Fdnfb9b+o0HC6f4Wq4MjTaJm4Ago8e1MU6hQZom+YIDRFqCK7ttHmzcWtrElkuR+EmuIi/vRu0fKnNkYeqPBRpKqW2DMIraRIkFqOoE+IKTZOFr5HNTmzMayB7NSkgq/8hdlyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nofm9MPEFWuHDTbfW7X9gmETCR5y032TBU5uz0NDD78=;
 b=CNpWdnOne+yh9a1daKks7BYVHnaCyEhpuchwpI7iBnXaqFdvKI+DEqU2eUa0ZEl4zzz9Jj1YP++JYEzQ7dIxSZ1bVocqVGFeM1levkrGPqUfOeqdi3zTI9xtz7ad6WdEwn6KaOjjgpbfTQ5Xq/kXu/Wf1jcBHPSKR0JJpZ6Rf7XRDx/0dBj1eI1O63u95k0GsN0De5cuM0BbYopjEahrfcxnA/weK8dL4Bjw07dKH6BU7PR5OfON+4fV+bwrR66bzjvuurtDKLN3b9tqDMSBTUQ0cJrfKApsAcMDCy1TujxW/cHtUADH2VKF3BHlso/gzeXScRK4sUKN1QRHCQKK5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nofm9MPEFWuHDTbfW7X9gmETCR5y032TBU5uz0NDD78=;
 b=YAfKhmJwDSrCRoSl8bM0Tt8abIK6ge6zRznu7OxJMu+cBT9YFUtIrfsGOc9mv6VQUZ0AmGDUFYiDoeuxzdCSzSVSAQ3g83qnMHYHufWRP9xL/6nxavUhwbERl/SyJKmZRX5S7mGWp6gLYecBWXIDD1ppnGjtrqPGQeqQ4t+QjQw=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3416.namprd15.prod.outlook.com (2603:10b6:a03:110::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Wed, 20 May
 2020 19:26:55 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 19:26:55 +0000
Date:   Wed, 20 May 2020 12:26:52 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 03/19] mm: memcg: convert vmstat slab counters to bytes
Message-ID: <20200520192652.GA278395@carbon.dhcp.thefacebook.com>
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-4-guro@fb.com>
 <b72ff85a-22aa-f55d-41ee-2ddee00674a7@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b72ff85a-22aa-f55d-41ee-2ddee00674a7@suse.cz>
X-ClientProxiedBy: BY5PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::37) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:e80) by BY5PR04CA0027.namprd04.prod.outlook.com (2603:10b6:a03:1d0::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24 via Frontend Transport; Wed, 20 May 2020 19:26:55 +0000
X-Originating-IP: [2620:10d:c090:400::5:e80]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 121f2e0c-eb21-4173-8d22-08d7fcf3c1d8
X-MS-TrafficTypeDiagnostic: BYAPR15MB3416:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3416ECBB2FFE3C4FB982E0CFBEB60@BYAPR15MB3416.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P8MwGAwI15d++SKi9zDzXyaFoCGnRzcoXrcijjNhKKqJHr12DRPOQCekGooDhZSxa4+ceoXPcUlcaBe9QS2ASA7a4JfBq2o8sAnJASx10pChag/1CugEBBJgvoOe+ywaRzmE4QwjkOcZfVjkp/qofhusej2/7dSlYGRRUMx2da+bEBgxBZlXzW9QqLQORlW5gT4K9HTyo9az+8G/8K0MI+ffvg7TkG4XZq8ebObc/TpN60Ujh3wIT54O9XVcQp+IPX5tnbmz2YOz6wylXAeCT3BfODrLqbdlC27GoOAWlxPg+T7RZzkoUE/fgnA+LjY1W/APs42ze0Z8Cr07GCSSAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39860400002)(376002)(396003)(346002)(366004)(5660300002)(66476007)(66556008)(66946007)(2906002)(6666004)(9686003)(478600001)(55016002)(54906003)(8676002)(16526019)(53546011)(316002)(6916009)(8936002)(86362001)(33656002)(186003)(4326008)(52116002)(7696005)(1076003)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: VNqyV4lzGV7LaFSK1Cs28LAlVTwPUsiDRSF61hGXwV9QkzHaxsSScJdrJZrMZV933z/AEWJd4+WY9GBvXvBzghJyfVRT1SSRMezh1+LMQOGS+Kbrhnltl5l3AOpqYr7+SKqh3IfvF8BuUfbd5Xb8Z+61PBtdAW+3skU2x94xqoYQ7vqc+I4WpuSsfbhjswYcJbCgZSVAdJrcexqAyxV+77uEINqwkYXRYLGJv/kb4oen8RPjttIu/Rxi98nZwhiamLMccnPUCiX8VXikDqYyxbK0yjrfgXZWgg4XKjaOJE9LBx/C/BAE04eOmu/Yt7Q2PjX2wsFKQ86u1ifALLj2PtcL2UfnQhiWVmwd8GPztE6WUNqShTKd2S+L+GpUYb6FqVrnC+Jb2oaBZop42j4ybd62ra2UbC10QhyKgMzHQ9TEF4zIyT3NU1lr6xNasUVjNh6R7juYq+a6XA/gisXgFHNVHPiFNY16F3iMOlpj6+mSFA11OUkY4zd1uIceq+AIScNHLSjJeEm17VCQgFmNjg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 121f2e0c-eb21-4173-8d22-08d7fcf3c1d8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 19:26:55.7120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bXgadTOpH5I6k6VD0pTnQU57RN6/Fpt9LAAnLXwXjn/meqAoF1RLKtjngEYF5zx0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3416
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-20_15:2020-05-20,2020-05-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=999 cotscore=-2147483648 clxscore=1015
 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=1 impostorscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005200155
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 02:25:22PM +0200, Vlastimil Babka wrote:
> On 4/22/20 10:46 PM, Roman Gushchin wrote:
> > In order to prepare for per-object slab memory accounting, convert
> > NR_SLAB_RECLAIMABLE and NR_SLAB_UNRECLAIMABLE vmstat items to bytes.
> > 
> > To make it obvious, rename them to NR_SLAB_RECLAIMABLE_B and
> > NR_SLAB_UNRECLAIMABLE_B (similar to NR_KERNEL_STACK_KB).
> > 
> > Internally global and per-node counters are stored in pages,
> > however memcg and lruvec counters are stored in bytes.
> > This scheme may look weird, but only for now. As soon as slab
> > pages will be shared between multiple cgroups, global and
> > node counters will reflect the total number of slab pages.
> > However memcg and lruvec counters will be used for per-memcg
> > slab memory tracking, which will take separate kernel objects
> > in the account. Keeping global and node counters in pages helps
> > to avoid additional overhead.
> > 
> > The size of slab memory shouldn't exceed 4Gb on 32-bit machines,
> > so it will fit into atomic_long_t we use for vmstats.
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > ---
> >  drivers/base/node.c     |  4 ++--
> >  fs/proc/meminfo.c       |  4 ++--
> >  include/linux/mmzone.h  | 16 +++++++++++++---
> >  kernel/power/snapshot.c |  2 +-
> >  mm/memcontrol.c         | 11 ++++-------
> >  mm/oom_kill.c           |  2 +-
> >  mm/page_alloc.c         |  8 ++++----
> >  mm/slab.h               | 15 ++++++++-------
> >  mm/slab_common.c        |  4 ++--
> >  mm/slob.c               | 12 ++++++------
> >  mm/slub.c               |  8 ++++----
> >  mm/vmscan.c             |  3 ++-
> >  mm/workingset.c         |  6 ++++--
> >  13 files changed, 53 insertions(+), 42 deletions(-)
> 
> 
> > @@ -206,7 +206,17 @@ enum node_stat_item {
> >  
> >  static __always_inline bool vmstat_item_in_bytes(enum node_stat_item item)
> >  {
> > -	return false;
> > +	/*
> > +	 * Global and per-node slab counters track slab pages.
> > +	 * It's expected that changes are multiples of PAGE_SIZE.
> > +	 * Internally values are stored in pages.
> > +	 *
> > +	 * Per-memcg and per-lruvec counters track memory, consumed
> > +	 * by individual slab objects. These counters are actually
> > +	 * byte-precise.
> > +	 */
> > +	return (item == NR_SLAB_RECLAIMABLE_B ||
> > +		item == NR_SLAB_UNRECLAIMABLE_B);

Hello, Vlastimil!

Thank you for looking into the patchset, appreciate it.
In the next version I'll add some comments based on your suggestions in previous
letters.

> >  }
> 
> Ok, so this is no longer a no-op, but __always_inline here and inline in
> global_node_page_state() should hopefully mean that for all users of
> global_node_page_state(<constant>) the compiler will eliminate the branch for
> non-slab counters. But there are also functions such as si_mem_available() that
> use non-constant item. Maybe compiler is smart enough anyway, but perhaps it's
> better to use global_node_page_state_pages() in such callers?

I'll take a look, thanks for the idea.

> 
> However __mod_node_page_state() and mode_node_state() will now branch always. I
> wonder if the "API clean" goal is worth it...

You mean just adding a special write-side helper which will perform a conversion
and put VM_WARN_ON_ONCE() into generic write-side helpers?

> 
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1409,9 +1409,8 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
> >  		       (u64)memcg_page_state(memcg, MEMCG_KERNEL_STACK_KB) *
> >  		       1024);
> >  	seq_buf_printf(&s, "slab %llu\n",
> > -		       (u64)(memcg_page_state(memcg, NR_SLAB_RECLAIMABLE) +
> > -			     memcg_page_state(memcg, NR_SLAB_UNRECLAIMABLE)) *
> > -		       PAGE_SIZE);
> > +		       (u64)(memcg_page_state(memcg, NR_SLAB_RECLAIMABLE_B) +
> > +			     memcg_page_state(memcg, NR_SLAB_UNRECLAIMABLE_B)));
> >  	seq_buf_printf(&s, "sock %llu\n",
> >  		       (u64)memcg_page_state(memcg, MEMCG_SOCK) *
> >  		       PAGE_SIZE);
> > @@ -1445,11 +1444,9 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
> >  			       PAGE_SIZE);
> >  
> >  	seq_buf_printf(&s, "slab_reclaimable %llu\n",
> > -		       (u64)memcg_page_state(memcg, NR_SLAB_RECLAIMABLE) *
> > -		       PAGE_SIZE);
> > +		       (u64)memcg_page_state(memcg, NR_SLAB_RECLAIMABLE_B));
> >  	seq_buf_printf(&s, "slab_unreclaimable %llu\n",
> > -		       (u64)memcg_page_state(memcg, NR_SLAB_UNRECLAIMABLE) *
> > -		       PAGE_SIZE);
> > +		       (u64)memcg_page_state(memcg, NR_SLAB_UNRECLAIMABLE_B));
> 
> So here we are now printing in bytes instead of pages, right? That's fine for
> OOM report, but in sysfs aren't we breaking existing users?
> 

Hm, but it was in bytes previously, look at that x * PAGE_SIZE.
Or do you mean that now it can be not rounded to PAGE_SIZE?
If so, I don't think it breaks any expectations.

Thanks!
