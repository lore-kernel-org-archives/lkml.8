Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D75C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 20:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008EF21744
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 20:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="KlxNRaOO";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="IAVRlmKA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgBCU7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 15:59:20 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:13962 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725372AbgBCU7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 15:59:19 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 013Kx17u003255;
        Mon, 3 Feb 2020 12:59:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=xzcYuStL/nTYbdOoM2xji+pWcSjFchmV5w42vZus8uo=;
 b=KlxNRaOOH6dsVXonyhJLkgKnTAeW+gIuYfwA5hgw2IE+nZshIpt2ajAI5HXTmd0PyNxO
 kMkCeDQId4CVrxpLl3dIidXDUxsM9+gjW1cDemgSB7x1NhvTmFXAdv6GL+oL4CNQJYM1
 pIa3kcDRE3QK2sDeYr95wcL2LeZcB8sMSpA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2xwsx06gxj-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 03 Feb 2020 12:59:10 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 3 Feb 2020 12:58:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Te5JCFGdTMtKDYh3AG+8VVwueKK2NOmh1chIbQuIUZrY24QcSBOW586m+pSAESxstU6FNHjZz34nIj6aZZNLBEwhKFFQejEKE5mXUax4BvdVT3pJ5/s3lrwO7wDUDK/3gb1vd0SXWZjmYCRqGTSganPd80ibS4rRgAbevnKUxDI5Qlnx9BsRq1g8LBIjj72Hb6INu8qY+MJHZ/Ldj69lZg+eLd0Jnveah8AWpzBi+i552sZAtimecq3kbnd2eCPi2BPqAHHswYyhUxeKYyaXZKqCyhZC7aBuUgArIlIXKler3SNtyknD9wEXAe6x2xr93M+MNi7EVvANcbXxEqRfEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzcYuStL/nTYbdOoM2xji+pWcSjFchmV5w42vZus8uo=;
 b=O0/aG+TvSmEy0zWHX3TkK8RM8olEpylAOPBTGzWO3iDM4T9GLEYtVaQGJs6pl0bU7s7Cnzi6EoeKVcE+RzvUx5rzPd/fd38DrWFaXs+ii03/DRJDYgaILQF2UlAecRtUVUO2ZGS0Vk0gvH7AEZB/mLP/cZDPfH3vcUWlLI8umFvJ3nDDDCkSLUEpaDdWBrwgqtTm1MvfWQCLtKC2xNblwjiFUprpEXIhFue1cBp96bWKxPRO86s5sP1XS+y3MYr9iE6JBNRO7+l7jhjy60PN3AmE8o37/U3QALGlvi4o+UPpJ9kZt0/9Lk0ZrX1cb6SD4c6dKSoEr/Q4/4to6bABig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzcYuStL/nTYbdOoM2xji+pWcSjFchmV5w42vZus8uo=;
 b=IAVRlmKANOp6JgnUwMIsfaFA7Ek7gmQ+NdRQeXsfwAnQ7HjlZ4Uz9YfVxBD56HGb0WjiIkH0pzRweV+jZtpGdsdz3N64+P4f8SMUkNQtX/sI522pM6syZhz8xPFJ06cpb2yLF6SVFNoU5CJTFLLVL/I6fF4R9m502BKOy9GtS3I=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.155.147) by
 BYAPR15MB3208.namprd15.prod.outlook.com (20.179.58.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Mon, 3 Feb 2020 20:58:41 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308%7]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 20:58:41 +0000
Date:   Mon, 3 Feb 2020 12:58:34 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v2 21/28] mm: memcg/slab: use a single set of kmem_caches
 for all memory cgroups
Message-ID: <20200203205834.GA6781@xps.dhcp.thefacebook.com>
References: <20200127173453.2089565-1-guro@fb.com>
 <20200127173453.2089565-22-guro@fb.com>
 <20200203195048.GA4396@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203195048.GA4396@cmpxchg.org>
X-ClientProxiedBy: MN2PR15CA0057.namprd15.prod.outlook.com
 (2603:10b6:208:237::26) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:150::19)
MIME-Version: 1.0
Received: from xps.dhcp.thefacebook.com (2620:10d:c091:480::b502) by MN2PR15CA0057.namprd15.prod.outlook.com (2603:10b6:208:237::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.32 via Frontend Transport; Mon, 3 Feb 2020 20:58:38 +0000
X-Originating-IP: [2620:10d:c091:480::b502]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d192fe9-779a-457a-64ca-08d7a8ebd90d
X-MS-TrafficTypeDiagnostic: BYAPR15MB3208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3208CC20238245CA7EB0D266BE000@BYAPR15MB3208.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0302D4F392
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(346002)(136003)(39860400002)(189003)(199004)(8936002)(4326008)(186003)(16526019)(316002)(8676002)(81156014)(81166006)(1076003)(5660300002)(6506007)(54906003)(33656002)(2906002)(6666004)(478600001)(7696005)(9686003)(52116002)(55016002)(66946007)(66556008)(86362001)(6916009)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3208;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EMWzOBLiwJsTwc6DvvwPmOiY7/bWvAqf2qXn0G9p4egmr7WTOcn8e+BES5FQ756VvfmyfUGRhEMu5sfx27gfqj38FccUEHDXlHwde/+fCMgT9k9QltgDVSeGWSJdOP/4v68KTRIcVsxg3QgqxFH0QUKXYs054JLy0s7nqpRJRNcbH+MPOJEkcAS0HpDNCCVaA0z35WLBiCSAF9SP2B0OaF39BfVUK70vNTfvIYeoHWKxU601HqzQ+U/1F5UNheCudqOi1hGpFwT1ZXugs2y1doiUJFmYkEkFbYDix3UWMM/Hq2/NGI28918COlnyeFaa05eV4DK37SGHSY/G6EpjdJPBx/Hgl7yES4R1SPbAdE8N0zG537YBnteVksNIc5cPzHRi/TBnOpZHFZ18W/GO1VXIjhJBNJRMruZWFG2aThgQHEnhPknoGhKewXwSKK9y
X-MS-Exchange-AntiSpam-MessageData: tTvUHTtk/2foWARfQJMBpOeypmml3BFhjQGRiBGRa/Br5H4zdP0JnEKq7Ao1VO9DJngPul/93L4P/Gf3DxzL1DyjBhhLuvTWi9s8EwnwojWnyYtd95De8HzF2wd83X7lP658D7/j+8ZilTJ3MusVMp4EpeUOS2qgaYYbsGwzA34=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d192fe9-779a-457a-64ca-08d7a8ebd90d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2020 20:58:41.0497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OglGjPtZS5HuT7ix1pwTHqVtPChxRqaxHeunQNB5/PW576Y/ZAtbqzbo64ksMl2Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3208
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-03_07:2020-02-02,2020-02-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxlogscore=964 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0 clxscore=1011
 suspectscore=5 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2002030152
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 02:50:48PM -0500, Johannes Weiner wrote:
> On Mon, Jan 27, 2020 at 09:34:46AM -0800, Roman Gushchin wrote:
> > This is fairly big but mostly red patch, which makes all non-root
> > slab allocations use a single set of kmem_caches instead of
> > creating a separate set for each memory cgroup.
> > 
> > Because the number of non-root kmem_caches is now capped by the number
> > of root kmem_caches, there is no need to shrink or destroy them
> > prematurely. They can be perfectly destroyed together with their
> > root counterparts. This allows to dramatically simplify the
> > management of non-root kmem_caches and delete a ton of code.
> 
> This is definitely going in the right direction. But it doesn't quite
> explain why we still need two sets of kmem_caches?
> 
> In the old scheme, we had completely separate per-cgroup caches with
> separate slab pages. If a cgrouped process wanted to allocate a slab
> object, we'd go to the root cache and used the cgroup id to look up
> the right cgroup cache. On slab free we'd use page->slab_cache.
> 
> Now we have slab pages that have a page->objcg array. Why can't all
> allocations go through a single set of kmem caches? If an allocation
> is coming from a cgroup and the slab page the allocator wants to use
> doesn't have an objcg array yet, we can allocate it on the fly, no?

Well, arguably it can be done, but there are few drawbacks:

1) On the release path you'll need to make some extra work even for
   root allocations: calculate the offset only to find the NULL objcg pointer.

2) There will be a memory overhead for root allocations
   (which might or might not be compensated by the increase
   of the slab utilization).

3) I'm working on percpu memory accounting that resembles the same scheme,
   except that obj_cgroups vector is created for the whole percpu block.
   There will be root- and memcg-blocks, and it will be expensive to merge them.
   I kinda like using the same scheme here and there.

Upsides?

1) slab utilization might increase a little bit (but I doubt it will have
   a huge effect, because both merging sets should be relatively big and well
   utilized)
2) eliminate memcg kmem_cache dynamic creation/destruction. it's nice,
   but there isn't so much code left anyway.


So IMO it's an interesting direction to explore, but not something
that necessarily has to be done in the context of this patchset.
