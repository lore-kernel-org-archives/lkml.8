Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD33EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 22:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1925206DB
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 22:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="EfO2JpNX";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="BKNH27CG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgFEWrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 18:47:19 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:18250 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728013AbgFEWrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 18:47:19 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 055Mjdxs028923;
        Fri, 5 Jun 2020 15:47:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=QOjj5vwINsglsSlNswDI/WCEfYiWlzHo+FA1mWx840E=;
 b=EfO2JpNXEQ+G7oCQGYh0pv/QSB4Ote69iXT4+wzC0cJN2C2a/mNWkzcBz3fx+0UHqxuA
 TY9Eof1T8ekZbUH7hOLQHjyiilAktVpT8tn5mA64EKMwpdE8HGGzaABTXDPYUBiYMMGD
 mJjb6L36yBlnwZz1l4jx8G1YGq+YCBiqofw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 31f913nt7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 05 Jun 2020 15:47:12 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 5 Jun 2020 15:47:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PUS4uYNl8utnk3qFATk4vADj1werE+cYbT26VkjnCqCuONlbo83M/jcY221d0XCG0pUahtFfcJXKC8f7CsMWUb2wUh1W6nZ3yK0uKxQadKwAtiPTT6ULuMvzBbRtInrRuDIhhtmCZSnilpUJL5y+c7d9O/pJGw1KLLsdgZOX3KaMclQYNah69eUx+78oUh9+i3dQUJQaBtfgEB8EULbo5lcWaD7n0+ExBRF0RpVKXLibvjBaxPOQOzSDKdbE6JPaVkr/9E4WniuE/NaSbLx8XjnCgdpkA4S//y5bsnARIeDfnanlowVekdGd7t66Vawk8P/qeet6DACIyWabBAhE0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOjj5vwINsglsSlNswDI/WCEfYiWlzHo+FA1mWx840E=;
 b=WoLxy+UCu2StpuaayASKlvsRkotfGpvPE7ci7rWHeDVo06sFN+LFM/syx+uX1++cVXnyos31+mNak1/nbnqmUGf7w8r8FW0CDy0wyZNoXO6QtAYaMaaTcnMobmzi5mUrhHBOH1ezepHBiTckCZn14yOmU+akJZi49SXW0n1TvMO76YAkKJhLuJHqdYnY3ngcJ0qK65LFmctrYWok9cJCjL9B9+nSrJeJ4zvLjPqVRk1+y06yql3Q+9Vpn+gXD5bIAr/MgxIppBj3JYKsckdiDvkq3OlyKowDrQhPATmif+CLdsKFfJasIXSRd0k2SOt6aSJFJb3baUtP+BGI8ymqPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOjj5vwINsglsSlNswDI/WCEfYiWlzHo+FA1mWx840E=;
 b=BKNH27CGhQqOVuI95MxUUrr0eUuy9dpliR3Tq8oRoxoaDK2ok6kZFGl5/m4DC8/boGhoE6AXv5fGES8MKCH9FBuSMjbKGgt0LjocK8UbO44iKVNYEbu7dXSwc93OlDsh6eFpP7wNyTcD/TkllmNTJKcLjPENqMjlXkgAdsKcgAE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2695.namprd15.prod.outlook.com (2603:10b6:a03:150::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Fri, 5 Jun
 2020 22:47:08 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3066.018; Fri, 5 Jun 2020
 22:47:08 +0000
Date:   Fri, 5 Jun 2020 15:47:05 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Dennis Zhou <dennis@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 5/5] kselftests: cgroup: add perpcu memory accounting
 test
Message-ID: <20200605224705.GD561977@carbon.DHCP.thefacebook.com>
References: <20200528232508.1132382-1-guro@fb.com>
 <20200528232508.1132382-6-guro@fb.com>
 <20200605200751.GE224745@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605200751.GE224745@google.com>
X-ClientProxiedBy: BY5PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::18) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:a500) by BY5PR03CA0008.namprd03.prod.outlook.com (2603:10b6:a03:1e0::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Fri, 5 Jun 2020 22:47:07 +0000
X-Originating-IP: [2620:10d:c090:400::5:a500]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8b436bd-51da-4426-03ff-08d809a26081
X-MS-TrafficTypeDiagnostic: BYAPR15MB2695:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB269504A35788E9517071CE4EBE860@BYAPR15MB2695.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0425A67DEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dtI6WNmgYbP4aZYDpbhJTANXCvS/7ljzYN6WSK0SsVTADQVxSUMIT76So/inokCfehiSrzrDbJ4PZ5p8lVtmuXGEBjkCbdLyBIPFGqjOCflBBatFJiRcEZslzPlVc/bm8Avjt4nkPej23rVPjHBauNIt3MPvTl1V4CAvtxvzH3mVElny0ot1aQgaLaNw5RQP5C0aET96HTA3Bxwf8CI4dMnkPbqOYSDLFBv7ROVMpTlykwLxniBAVCelix4JDKTIrf1niaBOr4OlvIubPyQGf6a5UOxQcfXFdEpPnga2tMokbYQROxxJZXtrv3P3xF6bLuDuGhX9MFCWA2j8W2eYTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(346002)(366004)(39860400002)(396003)(376002)(33656002)(9686003)(478600001)(5660300002)(7696005)(1076003)(2906002)(8936002)(52116002)(6916009)(15650500001)(8676002)(83380400001)(16526019)(316002)(66556008)(6506007)(4326008)(86362001)(66946007)(66476007)(55016002)(54906003)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: +lyxj4cCoQ5KD+G5Ut31lAhqDazCb8MtQAcl5eMF2lENkLxBuy7IK4mA+9QzEYQHbleUpEP8cvxPQL1KAVNChvYo4iV3VRVf1GOrDk36QJiVvfMbCCvc1ZPIahFdbyFZD7XagoDVJX/t+YdY03+Tre+nVjHp86Gtlu16+I2b3O+YR+Lhlx3Kj07n09MjWovWmimqLug6TM19pv8YYNtUzU5BdT9UKpx8MyDXNW1PHgbY1kNrflF4qaHg+5aAwB1IznLzthdYbWkrAPq7UOEJkZvYMevpj5lUPfpuHjrWgc6qauK13sbT9ODTyWDedYJr5xxrk2rHrF7zCZvYUVwnOLYIDLFmpJP9fVMoSq8y/yE4vqJ3U9cnR7Y84BtESV5LYJpkhsH79P8fo52SvlWE9u/Yg1qttjjZ9IKubAWXScyKFOS6dD1pr4ELbObu1gWnCN7Rk9Es60c4H0cs6hEYS/bgpx6bQqZWqbvyNlq6pWk4QlBOyKaB8W2iUnFu5MmvcXy27mabfZZEg6ozlXhp7w==
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b436bd-51da-4426-03ff-08d809a26081
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2020 22:47:08.3074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PZvbZ65HASjMzmYm92spiis1KnGyaQbavJ9IN+/eRkLoxcDYt7NQ5I75JsERiY2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2695
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-05_07:2020-06-04,2020-06-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 impostorscore=0 mlxlogscore=999 cotscore=-2147483648 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=5
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006050168
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 08:07:51PM +0000, Dennis Zhou wrote:
> On Thu, May 28, 2020 at 04:25:08PM -0700, Roman Gushchin wrote:
> > Add a simple test to check the percpu memory accounting.
> > The test creates a cgroup tree with 1000 child cgroups
> > and checks values of memory.current and memory.stat::percpu.
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > ---
> >  tools/testing/selftests/cgroup/test_kmem.c | 59 ++++++++++++++++++++++
> >  1 file changed, 59 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
> > index 5224dae216e5..a0d4f1a3137d 100644
> > --- a/tools/testing/selftests/cgroup/test_kmem.c
> > +++ b/tools/testing/selftests/cgroup/test_kmem.c
> > @@ -331,6 +331,64 @@ static int test_kmem_dead_cgroups(const char *root)
> >  	return ret;
> >  }
> >  
> > +/*
> > + * This test creates a sub-tree with 1000 memory cgroups.
> > + * Then it checks that the memory.current on the parent level
> > + * is greater than 0 and approximates matches the percpu value
> > + * from memory.stat.
> > + */
> > +static int test_percpu_basic(const char *root)
> > +{
> > +	int ret = KSFT_FAIL;
> > +	char *parent, *child;
> > +	long current, percpu;
> > +	int i;
> > +
> > +	parent = cg_name(root, "percpu_basic_test");
> > +	if (!parent)
> > +		goto cleanup;
> > +
> > +	if (cg_create(parent))
> > +		goto cleanup;
> > +
> > +	if (cg_write(parent, "cgroup.subtree_control", "+memory"))
> > +		goto cleanup;
> > +
> > +	for (i = 0; i < 1000; i++) {
> > +		child = cg_name_indexed(parent, "child", i);
> > +		if (!child)
> > +			return -1;
> > +
> > +		if (cg_create(child))
> > +			goto cleanup_children;
> > +
> > +		free(child);
> > +	}
> > +
> > +	current = cg_read_long(parent, "memory.current");
> > +	percpu = cg_read_key_long(parent, "memory.stat", "percpu ");
> > +
> > +	if (current > 0 && percpu > 0 && abs(current - percpu) <
> > +	    4096 * 32 * get_nprocs())
> 
> So this is checking that we've allocated less than 32 pages per cpu over
> 1000 child cgroups that's not percpu memory? Is there a more definitive
> measurement or at least a comment we can leave saying why this limit was
> chosen.

It simple means that "current" should be approximately equal to "percpu" statistics.
Both charging and vmstat paths are using percpu batching, and the batch size is
32 pages.

I'll add a comment to make it more obvious.

Thanks!

> 
> > +		ret = KSFT_PASS;
> > +	else
> > +		printf("memory.current %ld\npercpu %ld\n",
> > +		       current, percpu);
> > +
> > +cleanup_children:
> > +	for (i = 0; i < 1000; i++) {
> > +		child = cg_name_indexed(parent, "child", i);
> > +		cg_destroy(child);
> > +		free(child);
> > +	}
> > +
> > +cleanup:
> > +	cg_destroy(parent);
> > +	free(parent);
> > +
> > +	return ret;
> > +}
> > +
> >  #define T(x) { x, #x }
> >  struct kmem_test {
> >  	int (*fn)(const char *root);
> > @@ -341,6 +399,7 @@ struct kmem_test {
> >  	T(test_kmem_proc_kpagecgroup),
> >  	T(test_kmem_kernel_stacks),
> >  	T(test_kmem_dead_cgroups),
> > +	T(test_percpu_basic),
> >  };
> >  #undef T
> >  
> > -- 
> > 2.25.4
> > 
> > 
