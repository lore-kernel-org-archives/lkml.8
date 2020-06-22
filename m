Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53609C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 03:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 257982415E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 03:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="NDuQiFqb";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="KY6B+gHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbgFVD0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 23:26:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:31684 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731108AbgFVD0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 23:26:52 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05M3AS3C000552;
        Sun, 21 Jun 2020 20:26:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=CZFfsnf5aAqrdLTOIdCkatcZSl4a2uguLxKdN9dQ718=;
 b=NDuQiFqbh+ZWjA//cOYuWcPFpz4OVTpVUS8ZVQ+rRwlhxNfhT2Z/FPQm/QcqqkivPC6Z
 H1PzJL/l+gYyrvpWOhx6QD0Z6Oo1gWCqPsYobdNJ5ThTEgS84slzDzcD7XrdABUdz6ig
 8PBC5693qaLeX4uO8Y2IG8ev6lLjC9yw7DQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31sg6s5t6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 21 Jun 2020 20:26:41 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 21 Jun 2020 20:26:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=doNZ+viHmprdLHvW0c25r220dYSq4bT4CuN34wJCAbWq3XgCVcVO8K9mUg9mFJFE+QjAULv329OIulaiQN0LL0H5LxHYxbuKRJiSSPSr18NmWj2IstjqUj8blq3ypJ9PkN7fYse3umfUf7F80RqlTLvZHY3tqO5rpdjTIBrnE5YLRAcc/GdR9FhgkD1NUMjUPopkVoOCEApzmRch38y0asW76dLr/3cqIox0cUsKgPucwCanXJE2ZN8RjLJVCe6EdVolRxGs5yjd53RVwfpqvMBftTmHDVQppGhSK6GCMa0ghuUkpaQ07/LEpk4O+eh5x52GapCRYKHOIujHi9RkHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZFfsnf5aAqrdLTOIdCkatcZSl4a2uguLxKdN9dQ718=;
 b=YmCzXDfYijJRvW9OJznALUOkt3UF2BoydS4mWzJf+ShMTd+erLfUHO50WHHYvuIQce75U01GlmmlcUkvHXcyTKCKJ4swNIPo07U7591WH3njogKZfTCpUO+z7oivBRyu2uqAREnrolrmNpd6LriG4+GX3MTWiduQwMWpeBAQxiU+D5bDlGpE6TY7X63N/a2W/i1DrOYEWbGAS/IQ982M/LsfFxpErCFNT/kscttWU5WBRRktj1r+GGvcFT+S6i7r/q/ZmTtWp0ZB+l+JAcv0d0+nliS33iGhkQOrZS95qsEZOZFTI5GHObjtXX+a3rtqE7P3tz8edXbOVgfKKhHA/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZFfsnf5aAqrdLTOIdCkatcZSl4a2uguLxKdN9dQ718=;
 b=KY6B+gHDfvEvA39V2gmqt7DbFoad7+f3tRQV9XxhrIIbfE5inTQbTleVLN/fsehlD9p5D8Iyvga6L80Njgdnh4VY11WqksEccIShU1QYb7n/AMy9CpGmKbhTS2Hgd3jaRiQU6UKxWV1ra3tHwWgBt6XfuTiQzp7AEb2rsTNlwFs=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2933.namprd15.prod.outlook.com (2603:10b6:a03:f6::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Mon, 22 Jun
 2020 03:26:38 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 03:26:38 +0000
Date:   Sun, 21 Jun 2020 20:26:35 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH v2 3/5] mm: memcg/percpu: per-memcg percpu memory
 statistics
Message-ID: <20200622032635.GC293939@carbon.DHCP.thefacebook.com>
References: <20200608230819.832349-1-guro@fb.com>
 <20200608230819.832349-4-guro@fb.com>
 <20200622014803.GA2916179@ubuntu-n2-xlarge-x86>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622014803.GA2916179@ubuntu-n2-xlarge-x86>
X-ClientProxiedBy: BY5PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::40) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:aad7) by BY5PR03CA0030.namprd03.prod.outlook.com (2603:10b6:a03:1e0::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23 via Frontend Transport; Mon, 22 Jun 2020 03:26:37 +0000
X-Originating-IP: [2620:10d:c090:400::5:aad7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 492e7a4f-9efe-4788-779b-08d8165c12ff
X-MS-TrafficTypeDiagnostic: BYAPR15MB2933:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB29331B82577B418137B33062BE970@BYAPR15MB2933.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:284;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WMc7xRs9VruRtLIsc2RTqv0oUBNqMHZz0J/MRykYVRBGxmO1FVqcXEfQqFgHARgakv6EQlLSI/7UrX2tVO6P6pPOEM7rrWgmaxaq0cW6g8PDTDHHiuMI0I+pfHBDiKa5dG21lGJXmGwvqXNRbBNP67BHQNWDgh8/Y1Q+JrwMd0jq+oiJXOSb56lpcdWix0kz//yF8ODXY/gaOmTPxQKLKD/k9BGMAl/BcfBrzjaIVPsnPYXD2H2Z7GCb8/Sg1QkgIX20kbonUBvTVf8F8B9D3Hyse44dLZjfy1isU6lryiZKoTdqjvk+Uvpy4uuRGTd6dHgxRRR2CeTxvG1asMpiY4JKfis2yfpaX1zF9fZ+Xbw+eTTEIwpmGhnssVMJeC6l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(39860400002)(396003)(136003)(366004)(33656002)(6506007)(9686003)(86362001)(7416002)(8676002)(5660300002)(66946007)(8936002)(66556008)(16526019)(186003)(66476007)(52116002)(7696005)(2906002)(55016002)(4326008)(1076003)(54906003)(83380400001)(316002)(478600001)(6916009)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Qd4F7OxXibuBG2uucAu3wW77fQzGhqIrTB/lJPt7YYfvhvv6aJxg29+dDm1Y04Wn5QlXrrvl/yjB7AdoFXlWR0s3IAb7IxlgEIuTnaKPs1oBOdyNFEUxVN1LPvyPQWw7y5NyOjMly/SX2HMb2UDu5w/Tzrl5BUKuOfdpsd/iw8cqOzeW/uh/CA73l/A9m/HBW5SZO/nj16Hby8/BCYrsffzRkipphWtp9HTEzRV8cbHnc7t9jCnEkKIRNb1mfNbe0B9uDNf4lqWZ2qivGqYDXDMVTl5ZuCrHMYdUFZFgKySevA7Si2WmTI1Gjk3ZGzF9QSTr6deJ0EKqLQaDPIBRpT7MHwtNWq97xNMV3GeZXfQLoCrGbgJ1VX+qi7L3GDColJwPglQymEttSNa/I78u3/6JM7wL+DG8HnHT/WhGOYOf4goi5JmjXUrWj2hruJ/H+6eF0GJHwz+6FNtnBwwdWfn7spF+aQj/bnxHL/R63Qv/zyBC0NuOY8a2OexKGZ6yykWlH5uV/p5qAU7MNB+CjA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 492e7a4f-9efe-4788-779b-08d8165c12ff
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 03:26:38.6720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J0PPTV69yH/791bqUPlQGq7miXIU4Da+QeXiI11z/OJUF8kTvqnUj0i9YtR72pe7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2933
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-21_14:2020-06-19,2020-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 spamscore=0 clxscore=1011 priorityscore=1501 suspectscore=1
 impostorscore=0 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006220024
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 21, 2020 at 06:48:03PM -0700, Nathan Chancellor wrote:
> On Mon, Jun 08, 2020 at 04:08:17PM -0700, Roman Gushchin wrote:
> > Percpu memory can represent a noticeable chunk of the total
> > memory consumption, especially on big machines with many CPUs.
> > Let's track percpu memory usage for each memcg and display
> > it in memory.stat.
> > 
> > A percpu allocation is usually scattered over multiple pages
> > (and nodes), and can be significantly smaller than a page.
> > So let's add a byte-sized counter on the memcg level:
> > MEMCG_PERCPU_B. Byte-sized vmstat infra created for slabs
> > can be perfectly reused for percpu case.
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Acked-by: Dennis Zhou <dennis@kernel.org>
> > ---
> >  Documentation/admin-guide/cgroup-v2.rst |  4 ++++
> >  include/linux/memcontrol.h              |  8 ++++++++
> >  mm/memcontrol.c                         |  4 +++-
> >  mm/percpu.c                             | 10 ++++++++++
> >  4 files changed, 25 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > index ce3e05e41724..7c1e784239bf 100644
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -1274,6 +1274,10 @@ PAGE_SIZE multiple when read back.
> >  		Amount of memory used for storing in-kernel data
> >  		structures.
> >  
> > +	  percpu
> > +		Amount of memory used for storing per-cpu kernel
> > +		data structures.
> > +
> >  	  sock
> >  		Amount of memory used in network transmission buffers
> >  
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index eede46c43573..7ed3af71a6fb 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -32,11 +32,19 @@ struct kmem_cache;
> >  enum memcg_stat_item {
> >  	MEMCG_SWAP = NR_VM_NODE_STAT_ITEMS,
> >  	MEMCG_SOCK,
> > +	MEMCG_PERCPU_B,
> >  	/* XXX: why are these zone and not node counters? */
> >  	MEMCG_KERNEL_STACK_KB,
> >  	MEMCG_NR_STAT,
> >  };
> >  
> > +static __always_inline bool memcg_stat_item_in_bytes(enum memcg_stat_item item)
> > +{
> > +	if (item == MEMCG_PERCPU_B)
> > +		return true;
> > +	return vmstat_item_in_bytes(item);
> 
> This patch is now in -next and this line causes a warning from clang,
> which shows up in every translation unit that includes this header,
> which is a lot:
> 
> include/linux/memcontrol.h:45:30: warning: implicit conversion from
> enumeration type 'enum memcg_stat_item' to different enumeration type
> 'enum node_stat_item' [-Wenum-conversion]
>         return vmstat_item_in_bytes(item);
>                ~~~~~~~~~~~~~~~~~~~~ ^~~~
> 1 warning generated.
> 
> I assume this conversion is intentional; if so, it seems like expecting
> a specific enum is misleading. Perhaps this should be applied on top?

Hi Nathan!

Yeah, these enums are kind of stacked on each other, so memcg_stat values
extend node_stat values. And I think your patch is correct.

I'm going to refresh the series with some small fixups. If you're not against
it, I'll merge your patch into the corresponding patches.

And thank you for reporting the problem!

> 
> Cheers,
> Nathan
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 2499f78cf32d..bddeb4ce7a4f 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -38,7 +38,7 @@ enum memcg_stat_item {
>  	MEMCG_NR_STAT,
>  };
>  
> -static __always_inline bool memcg_stat_item_in_bytes(enum memcg_stat_item item)
> +static __always_inline bool memcg_stat_item_in_bytes(int item)
>  {
>  	if (item == MEMCG_PERCPU_B)
>  		return true;
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 084ee1c17160..52d7961a24f0 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -211,7 +211,7 @@ enum node_stat_item {
>   * measured in pages). This defines the API part, the internal representation
>   * might be different.
>   */
> -static __always_inline bool vmstat_item_in_bytes(enum node_stat_item item)
> +static __always_inline bool vmstat_item_in_bytes(int item)
>  {
>  	/*
>  	 * Global and per-node slab counters track slab pages.
