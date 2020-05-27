Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D89FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2999E20835
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="EcX71Cbz";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="T4d3hApt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387508AbgE0UDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 16:03:39 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:26916 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726114AbgE0UDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 16:03:38 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04RK15ON015176;
        Wed, 27 May 2020 13:03:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=KSy1Ghv4m3rGqFlVgeqVGb+A503ybpJcDyBVMy6iUrs=;
 b=EcX71Cbz/UmOR/ZYVIRfkntG6tQYjcJEbHEPbz4lWHLQ72N57NAk7UNjLJ5Sik7gNFRw
 +KaTltOoP2sDr5+GS7yTyItaXv+QfWoV6HnCml4UCyzjHVsg081vULysSs8donT4xHsu
 jxD3vXDh27bekiaL5AXLSfBrwYiVIGwnROU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31999r3m0a-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 27 May 2020 13:03:24 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 27 May 2020 13:03:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLMxb6UA3AUmjE6qASlA3XgL7MVSVxDVBmIMosV/usJAXmy/KE3eXZT5rvv4Jzv5LpvY15q6hTIXeUyDd+bidyN+Q0NM63Pd9a6KdbE/r+oxZwIY5o/ofaaKt1T+sqkIovmRfkZhidBAaeZAZT31IRcerXljzLpEnXsKKGBb4owLUDUyjrbtknL8iAIQgigPes/2c4Ju4MaqHe+wK6dchpke/NB/9VAnXn8AIiPADUMldZq0c0y1UqUJ70q3ib9Zbv344V/CX9GQ4jsB32OjRc2xs9qWSJJ5sderyRCSJOkd53KuX3tbnnLYwu3TR+w9x1Vf9tdWJWnDvxB0+TC/Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSy1Ghv4m3rGqFlVgeqVGb+A503ybpJcDyBVMy6iUrs=;
 b=adNZCXLAaSynVbhO4v6bxmYAC0jPmyf9AlhddPfNu5Xrvm6ScRAEWof5KXfm2j+SKBMZyMVaefp+ENppjdiDXpNTvwe0JXM7eayVPJ2HDN6VDi5Q4KYRpi7loF9shnw+ZzNzy17VEPbdkpP/OWZfjJIgOM6H0OdPsij3OUbcYsuku8d4kg174F4SDpMORwKvVr5UDNTC9PiFDh7WnNf2sG4lvIXFKXC4btRQlngpr7AtFJChWxl2SVF+9vNKNWKi0FYT8NCz1wk7HGOZn2RYhMday9OyS7mDuTDl2RSfWmJKapXO0VTL5tY3cnN8XY8pM6TCDX+xEqgEQ97mxP6rdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSy1Ghv4m3rGqFlVgeqVGb+A503ybpJcDyBVMy6iUrs=;
 b=T4d3hAptesZ7x+MMyjhEEtwReo+Fb81qKE7TrwWk0vZkEmGsVYR3tPa4UXClPq8ipvdytWCdyXbzLSVHyaoe0J0XDwd9PxGfMoF6lVzGHHBFfX0JP4YlBo7EUL0sewlSi9HUsfHmvFbCFihxSMMXflZ7ea7yMOMoorCqkZGmZx4=
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3112.namprd15.prod.outlook.com (2603:10b6:a03:b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Wed, 27 May
 2020 20:03:16 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3045.018; Wed, 27 May 2020
 20:03:16 +0000
Date:   Wed, 27 May 2020 13:03:13 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 06/19] mm: memcg/slab: obj_cgroup API
Message-ID: <20200527200313.GD396660@carbon.dhcp.thefacebook.com>
References: <20200526214227.989341-1-guro@fb.com>
 <20200526214227.989341-7-guro@fb.com>
 <20200527195614.GC47905@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527195614.GC47905@cmpxchg.org>
X-ClientProxiedBy: BYAPR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::27) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:e713) by BYAPR02CA0014.namprd02.prod.outlook.com (2603:10b6:a02:ee::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend Transport; Wed, 27 May 2020 20:03:15 +0000
X-Originating-IP: [2620:10d:c090:400::5:e713]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 203b6b1e-4a89-4fc2-02fd-08d80278feab
X-MS-TrafficTypeDiagnostic: BYAPR15MB3112:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3112EE0FC79B27B2771A0FC4BEB10@BYAPR15MB3112.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uVCQ6IlFae5Vd+z6cRjikKP6HhCZvhafc3QW9SsVzZMP+Azohrtlgf7Cd+4UNkKhoVgW11C6miW7TqNCr8cmF4r7p0ee+1J7mNI5hdpoxX8OtTKAW39AxiX59JdW7gzqgpE1lCiZ9/SK28MK2gFipd5MbYlVU8MnraMd4LY9FDs9egxW4pgX0mcmAMN2MZG2bqOaAVLRx9ZZSqi7IZAVY8eVqN6WTzs9GqjrKt4n/rs6vtOOTOtw/HSqxRy0eogg8j4HK+5f+C6DPg3r3vQHaw6SjZ4CnYFhdkazZU3oNtMbJU/YCG+DqMQVigBu1dMvpa7nIlvF0pGsaJPB0At86g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(39860400002)(136003)(366004)(396003)(4326008)(54906003)(1076003)(66476007)(66946007)(5660300002)(316002)(66556008)(9686003)(2906002)(6916009)(8676002)(8936002)(55016002)(186003)(86362001)(7696005)(16526019)(83380400001)(6506007)(52116002)(33656002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Kp9hsFShrrUryIZ+4UJbgUS1WiehWPhWNo7/0eWUU6vhcBNzj0oK9w58uQm/DjCTaidxP5I/vaDcSLtY9Wp4BXZLrqiaIYdSM7uiAVPQHQ9/0dU1i7vAkceLWw8AW5UqedwQbLRI/bPdNHmK79lq+mtAA808xWN8i2BvsHIW8sU2zte1ks9nmn45WbmznkzWna04gp7hDeyDgrtVBjn+aL5WOtTfXOhKzXjvbAzrCVijLFiV93hzUo9ecIFneLtyJba2Qc+WcB97xDHwTS3kmIjPDubb/jP8Ha6BEOhkogJv5rvkdqy9sFWuy1or+enS7+Da46f7HZ4Jfr3n5EdC+IxeIPAo1yRVqZdu0SMYHjSMLgDXoqr7rcYQdUM4L7SF59ajB1+Vxz49iEYER+qVwcJj79/dyBVRJw+1DIkx9DiJQhgQpnkw0kwncCQJTFNkRiGP8MkuMhrK5t5JhQWqFNzNC6L5hs8GvT64RFTHtY+mN+l7SYgVMX4//FvAIPapLFoFA1uSxNKTMQW9Sxp6lw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 203b6b1e-4a89-4fc2-02fd-08d80278feab
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 20:03:16.7714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BnofW6XcE9pU64P/FxX6HIRiVKW+B5bH2vKGBwlLZGD+1dUih/i+x5XL1TY+F1QY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3112
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-27_03:2020-05-27,2020-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=1
 cotscore=-2147483648 bulkscore=0 phishscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005270153
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 03:56:14PM -0400, Johannes Weiner wrote:
> On Tue, May 26, 2020 at 02:42:14PM -0700, Roman Gushchin wrote:
> > @@ -257,6 +257,98 @@ struct cgroup_subsys_state *vmpressure_to_css(struct vmpressure *vmpr)
> >  }
> >  
> >  #ifdef CONFIG_MEMCG_KMEM
> > +extern spinlock_t css_set_lock;
> > +
> > +static void obj_cgroup_release(struct percpu_ref *ref)
> > +{
> > +	struct obj_cgroup *objcg = container_of(ref, struct obj_cgroup, refcnt);
> > +	struct mem_cgroup *memcg;
> > +	unsigned int nr_bytes;
> > +	unsigned int nr_pages;
> > +	unsigned long flags;
> > +
> > +	/*
> > +	 * At this point all allocated objects are freed, and
> > +	 * objcg->nr_charged_bytes can't have an arbitrary byte value.
> > +	 * However, it can be PAGE_SIZE or (x * PAGE_SIZE).
> > +	 *
> > +	 * The following sequence can lead to it:
> > +	 * 1) CPU0: objcg == stock->cached_objcg
> > +	 * 2) CPU1: we do a small allocation (e.g. 92 bytes),
> > +	 *          PAGE_SIZE bytes are charged
> > +	 * 3) CPU1: a process from another memcg is allocating something,
> > +	 *          the stock if flushed,
> > +	 *          objcg->nr_charged_bytes = PAGE_SIZE - 92
> > +	 * 5) CPU0: we do release this object,
> > +	 *          92 bytes are added to stock->nr_bytes
> > +	 * 6) CPU0: stock is flushed,
> > +	 *          92 bytes are added to objcg->nr_charged_bytes
> > +	 *
> > +	 * In the result, nr_charged_bytes == PAGE_SIZE.
> > +	 * This page will be uncharged in obj_cgroup_release().
> > +	 */
> 
> Thanks for adding this.
> 
> > +int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
> > +{
> > +	struct mem_cgroup *memcg;
> > +	unsigned int nr_pages, nr_bytes;
> > +	int ret;
> > +
> > +	if (consume_obj_stock(objcg, size))
> > +		return 0;
> > +
> > +	rcu_read_lock();
> > +	memcg = obj_cgroup_memcg(objcg);
> > +	css_get(&memcg->css);
> > +	rcu_read_unlock();
> 
> Can you please also add the comment here I mentioned last time? To
> explain why we're not checking objcg->nr_charged_bytes if we have
> already pre-allocated bytes that could satisfy the allocation.

I've added a comment into drain_obj_stock() where nr_charged_bytes is bumped.
But I can add another on here, np.

> 
> Otherwise, looks good to me.

Thanks!
