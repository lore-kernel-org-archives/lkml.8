Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D21C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32A5320663
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Z7tn9F7G";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="hcHe3BI/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbgEZPpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 11:45:36 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59196 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730145AbgEZPpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 11:45:35 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04QFcXAW030739;
        Tue, 26 May 2020 08:45:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=lmIqcxqDWsnycd080LgSoxy5B38SnfJJQ+0KEcsrxJU=;
 b=Z7tn9F7GPzLuHAotHZNZdqQePaNggNvpfhOgavBa46v70uTn7ZtVJR9adry7qUdpXAhU
 UC0xnDS2Vyv4mHiu/9knu0Z6d2XZjwae4icHPmIUR/ViTXm34QRPLmgnk2vx3CQM9C1f
 yLPNw9QKbgd2UV/UEYi2AU0gFNnomk5fuY8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3171nhhtnf-16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 26 May 2020 08:45:27 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 26 May 2020 08:45:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFAZQh6/u19lDcPKf8wYct4MAT6GmKAhPY1ws6U65rtFXBqYnFGU1lsEZTmTMjOaqbc2lCuwD9hBPCcV1Ib8zx/D2jBLeDcalbfW27kOH5AJOme0uIi2SfieW5U/K/W52AF1oqKJkFzyG5cE9Y5wmgkYnhxxn7h80J2pps6g9dOfLrqe5buQRpuYm+X1CdFxwcuxDaQbEFBRydwmH43a+wfVvjWfmiiRegF5HOMg5Br0MuXgYeZEYV8LoeuxC5O0pNHD0uSY4y93rONZVK7Ohvm0rm0cJA0DQhzTTZAlg6PZR8YHeoGit67Y15luS10NtY9gkeJM8QG2ctbhbGf8qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmIqcxqDWsnycd080LgSoxy5B38SnfJJQ+0KEcsrxJU=;
 b=TBbhIWRp0uvekFEZHo2LOwz1Ys8nOh5WiBOX2KNyXw76RvoWAWs2y7XAgaeV5z/bTOrkFAeoIWlJAvwvZhXh0Qz+/B0jyTLEjYxPvVaHhht8tzd3NnnI6xj2VYzCn8pqHpFD0Ep9uRT1A7ZD01y8D/9GIaNG9t3Y6x9Ec2m3Wk2MfPb94ga85FLZRqHn4vzYl2klHSY7w81BmCWSHMn7Mx00fUmFW+mWUJiCSmZxmo5O4OJEVpFaz0wKNMQry8CuowRWuxvfq6JAWRKjPo9f0qxyB0JIfpcUsOiqbcmuGzHNFUYJwgZBE5ez/n74RBKnX9uj4+GpUMTNW5qcL5SNIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmIqcxqDWsnycd080LgSoxy5B38SnfJJQ+0KEcsrxJU=;
 b=hcHe3BI/E5K7ERnFuDF9u5RAazE7oe/Y3sNp7Rjeo3ZKHxGm/tB+EHB87tG4cRRFyZdhs6yLavzLCYQc1WnFT2RG4iqY1ZqPhFtmt7DdYrBl/vDIEe8KxNQZ8IShuZWNJXxqPBdpt9KGYccSC/kYe0LCC2BtQvsSBC5Ymr4PzFA=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14) by SN6PR1501MB4110.namprd15.prod.outlook.com
 (2603:10b6:805:5e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Tue, 26 May
 2020 15:45:14 +0000
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::3046:2fa:5da3:73be]) by SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::3046:2fa:5da3:73be%7]) with mapi id 15.20.3021.029; Tue, 26 May 2020
 15:45:13 +0000
Date:   Tue, 26 May 2020 08:45:08 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 18/19] kselftests: cgroup: add kernel memory
 accounting tests
Message-ID: <20200526154508.GA364753@carbon.DHCP.thefacebook.com>
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-19-guro@fb.com>
 <d980935c-fecc-9682-7dab-bdcf33c12a9c@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d980935c-fecc-9682-7dab-bdcf33c12a9c@suse.cz>
X-ClientProxiedBy: BY3PR10CA0025.namprd10.prod.outlook.com
 (2603:10b6:a03:255::30) To SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:c3d5) by BY3PR10CA0025.namprd10.prod.outlook.com (2603:10b6:a03:255::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.29 via Frontend Transport; Tue, 26 May 2020 15:45:10 +0000
X-Originating-IP: [2620:10d:c090:400::5:c3d5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40feedb6-dfbd-4a05-a03a-08d8018bc668
X-MS-TrafficTypeDiagnostic: SN6PR1501MB4110:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR1501MB411077196569E02673F26225BEB00@SN6PR1501MB4110.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 041517DFAB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vXFo+66C2Z2Ow5Fx2AyvL+MrqzNvID85rUjJBOUtuze3DI7aBMHrqCL++50am/K/Sj0EpXKFahm8A8fVt0sibhzjjalM3Yai3iF3umomXqLCJBabNFWwewSFzCUyuDBocJwitaS0ODS1xTj3gE9YgLusmuHYM208jz5Yys0NcUfCRDRiLtquQg9KsY8baavv+4iA0GAEfl4NMcGkdAys4OECfQIeWEcaWxniIPOid0EDbjtw4UvAE7D479pQ77lM74tQ6wWjw2K+dBfzeC2o7mEt6Bm7S7IwmTBPPdQdluV72d18cfEbd5gauZk8lWVaBXNomUUw6gLg5ggbRI1jTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB4141.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(346002)(376002)(39860400002)(136003)(396003)(9686003)(55016002)(316002)(33656002)(54906003)(8676002)(5660300002)(15650500001)(4326008)(86362001)(8936002)(1076003)(2906002)(53546011)(6506007)(186003)(16526019)(478600001)(6916009)(7696005)(66476007)(52116002)(66556008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: pGbhUO5r49vXSWrdKh8XzEyG/TKGEhxn3H3zMOW58hySv2PwbrfKV38OK9hZV5z4G9pBt5r3w1JAkz6qZYtDA21W6oWe0YSf9h8FPvsqM9BL7yEXc1tLcTk/eq6DDQfvbmGWCVKXJxgbetYzczmlGHvMdoKnyS71R7RRC66gtPDL4Lke20U1k38tE17JtyxL4VyI68xrh4490LbVSksgRkdT0+tbU0wpTZxz6RwuT5d7hTBBaKqCrxMrUtuiTBXPxhaOGofFyhFV3rSkrdLsLlPwAj/BAYLiX/zUNhM/sJlOcayuLtAMyGA4F8NWL5LGF55Xyfkdi0JqN2Va7ignCzo6LLXkxWmIVi+2gY0nroW3ejNzAd5zKw8/4Zj9rJtWzgW9n+lEKc/oEAUTfH3KySuQKefPPcjcThZn/7IBRGXtRd+TlPrGIGtG4l1F0MwL8YYupTH1emv+uraUF3OHhH/uu3N4e1+xreQF9MU/zJNkRVSikBaLT++PY2RkqepsoHSVVKHrSeNHWAG+Gpa2TA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 40feedb6-dfbd-4a05-a03a-08d8018bc668
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2020 15:45:13.5460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ey+qLwhARDOfqo6KF/4L9LYnXBZ3C7t+RoYLRQeoDkok5Dx5CCxpiGCsM6U2fQcG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB4110
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-26_02:2020-05-26,2020-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=2 cotscore=-2147483648 priorityscore=1501 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005260121
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 05:24:46PM +0200, Vlastimil Babka wrote:
> On 4/22/20 10:47 PM, Roman Gushchin wrote:
> > Add some tests to cover the kernel memory accounting functionality.
> > These are covering some issues (and changes) we had recently.
> > 
> > 1) A test which allocates a lot of negative dentries, checks memcg
> > slab statistics, creates memory pressure by setting memory.max
> > to some low value and checks that some number of slabs was reclaimed.
> > 
> > 2) A test which covers side effects of memcg destruction: it creates
> > and destroys a large number of sub-cgroups, each containing a
> > multi-threaded workload which allocates and releases some kernel
> > memory. Then it checks that the charge ans memory.stats do add up
> > on the parent level.
> > 
> > 3) A test which reads /proc/kpagecgroup and implicitly checks that it
> > doesn't crash the system.
> > 
> > 4) A test which spawns a large number of threads and checks that
> > the kernel stacks accounting works as expected.
> > 
> > 5) A test which checks that living charged slab objects are not
> > preventing the memory cgroup from being released after being deleted
> > by a user.
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > ---
> >  tools/testing/selftests/cgroup/.gitignore  |   1 +
> >  tools/testing/selftests/cgroup/Makefile    |   2 +
> >  tools/testing/selftests/cgroup/test_kmem.c | 382 +++++++++++++++++++++
> >  3 files changed, 385 insertions(+)
> >  create mode 100644 tools/testing/selftests/cgroup/test_kmem.c
> > 
> > diff --git a/tools/testing/selftests/cgroup/.gitignore b/tools/testing/selftests/cgroup/.gitignore
> > index aa6de65b0838..84cfcabea838 100644
> > --- a/tools/testing/selftests/cgroup/.gitignore
> > +++ b/tools/testing/selftests/cgroup/.gitignore
> > @@ -2,3 +2,4 @@
> >  test_memcontrol
> >  test_core
> >  test_freezer
> > +test_kmem
> > \ No newline at end of file
> > diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/selftests/cgroup/Makefile
> > index 967f268fde74..4794844a228e 100644
> > --- a/tools/testing/selftests/cgroup/Makefile
> > +++ b/tools/testing/selftests/cgroup/Makefile
> > @@ -6,11 +6,13 @@ all:
> >  TEST_FILES     := with_stress.sh
> >  TEST_PROGS     := test_stress.sh
> >  TEST_GEN_PROGS = test_memcontrol
> > +TEST_GEN_PROGS = test_kmem
> 
> Should be +=
> 
> >  TEST_GEN_PROGS += test_core
> >  TEST_GEN_PROGS += test_freezer
> >  
> >  include ../lib.mk
> >  
> >  $(OUTPUT)/test_memcontrol: cgroup_util.c ../clone3/clone3_selftests.h
> > +$(OUTPUT)/test_kmem: cgroup_util.c ../clone3/clone3_selftests.h
> >  $(OUTPUT)/test_core: cgroup_util.c ../clone3/clone3_selftests.h
> >  $(OUTPUT)/test_freezer: cgroup_util.c ../clone3/clone3_selftests.h
> > diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
> > new file mode 100644
> > index 000000000000..5bc1132fec6b
> > --- /dev/null
> > +++ b/tools/testing/selftests/cgroup/test_kmem.c
> > @@ -0,0 +1,382 @@
> ...
> > +/*
> > + * This test allocates 100000 of negative dentries with long names.
> > + * Then it checks that "slab" in memory.stat is larger than 1M.
> > + * Then it sets memory.high to 1M and checks that at least 1/2
> > + * of slab memory has been reclaimed.
> > + */
> > +static int test_kmem_basic(const char *root)
> > +{
> > +	int ret = KSFT_FAIL;
> > +	char *cg = NULL;
> > +	long slab0, slab1, current;
> > +
> > +	cg = cg_name(root, "kmem_basic_test");
> > +	if (!cg)
> > +		goto cleanup;
> > +
> > +	if (cg_create(cg))
> > +		goto cleanup;
> > +
> > +	if (cg_run(cg, alloc_dcache, (void *)100000))
> > +		goto cleanup;
> > +
> > +	slab0 = cg_read_key_long(cg, "memory.stat", "slab ");
> > +	if (slab0 < (1 >> 20))
> 
> 1 << 20 ?
> 
> Anyway I was getting this:
> not ok 1 test_kmem_basic
> ok 2 test_kmem_memcg_deletion
> ok 3 test_kmem_proc_kpagecgroup
> not ok 4 test_kmem_kernel_stacks
> ok 5 test_kmem_dead_cgroups
> 
> Adding some debugging into kmem_basic I found I get memory.stat == 0 at this
> point thus it fails the fixed test (otherwise it was failing the <= 0 test after
> writing to memory.high). But it's just a VM spinned by virtme which has a very
> simple init, so perhaps things are not as initialized as expected.

Hm, it's strange, do you have any values in memory.stat::slab for any cgroups?
Or can you send me your config (and kvm setup), I'll take a look.

Btw, thank you very much for reviewing the series! I appreciate it.
I'll integrate your feedback into the next version, which I'm working on right now.

Thanks!
