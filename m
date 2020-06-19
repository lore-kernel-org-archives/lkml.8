Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC91AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 01:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B181D20776
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 01:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ee+4YjvZ";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="QVP01CpQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbgFSBI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 21:08:57 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43996 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728584AbgFSBIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 21:08:53 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05J10Jru021371;
        Thu, 18 Jun 2020 18:08:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=KYJ/wrsNN6El3awq/k2fAWQ9p5+k8H1jQhtH5zKzRMw=;
 b=ee+4YjvZEV+SJeNxcPF+musZJHwAl/vOj36+SujaV8ggi17SrDPFkgptAKWYRoyRnklK
 vAdLNLCHDwvcUKX4TUVJf43j/8c+mjwZyKlZak/8x2X6x2JVE77q9sgbSt9zIuxcCIbw
 HjiVVazFEWFc/Ry+7YaKH5asyEmM8lYmUYY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31q656q6pp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Jun 2020 18:08:42 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Jun 2020 18:08:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXhmHxSXvaBO/0NZ1NMxNsqMeco5z8jg4Ns3WAm8d94cuJJ8RkzownKkK9VC/eBAlSxJpJI7UnViNjapKBPVWWx9gkRbFFSMRmDckT0/GmbRmb2ur7HEjDiSFSfSbOTs+3I1Fhv/ssje9RA/8cr4D2Ys1Zhy7PpUe8n9whmH7Zy0QAlpUN0YFE1j2MZxkPtnJ6FcXGKKObUbAq2PlPqxbx5al+YQHOsahTw8U8nkjiE0XWPYNu4gp+dwx61/NjGr/8XM2Ljay8k01hFTbh44r6ApcnMSGEZxeiXMn6yvEBXCb5A1KW06/co7CTrst7s9re1JGzYo/Xp48BqVeUCzyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYJ/wrsNN6El3awq/k2fAWQ9p5+k8H1jQhtH5zKzRMw=;
 b=UvDx+0aE6yCQ4oNirpXdM+jsMhoOxwG+q4yjK1edDcQhxDC+sK5Aoi7VSTRqC9Cm3t+94gGpODrjmwFEFC14PSYAYXXX6PoQO5gDZpJqvQrAVWLBJqWRnS60m+HUfSYw8Ly28Eiwz2EqY1d9znRP/5vbcRbM7e+ohnNLYfRbSpLvi8qtDw5oa3XPSJUKNHmy9JcN7GLJUfi9/CSjTBN5QjqpCgpIXgk2ZtAd94A0Lk0pZSRbBamuDEVbE3wDwdWa1YhQw0gxwBq82KtMkY7guZgsIX3P6SOtiO543M2kT4avFHVSnCEHdwI8EfSmlz8a+U9ZQ4ZpW+UZfFS5sFMGug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYJ/wrsNN6El3awq/k2fAWQ9p5+k8H1jQhtH5zKzRMw=;
 b=QVP01CpQ1DHp0D47o//4eNqiKckNwHcTO8vhtdYQCSmVm3dbFi9U6ze69R+uhUmvwoBRV+B/HAut0fkMyd9yZbno9FkWhtgE+th1FLfcncZDNM8kAsrBs0fiCnOjxLh3wK/l10Gs2CqTf2D2HILuAjTuaWMSR0dxxibTzLNADEg=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2390.namprd15.prod.outlook.com (2603:10b6:a02:8f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 01:08:40 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 01:08:40 +0000
Date:   Thu, 18 Jun 2020 18:08:37 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 05/19] mm: memcontrol: decouple reference counting
 from page accounting
Message-ID: <20200619010837.GB135965@carbon.dhcp.thefacebook.com>
References: <20200608230654.828134-1-guro@fb.com>
 <20200608230654.828134-6-guro@fb.com>
 <CALvZod4Jur7EFPPWzoBvQgF0m3hXyohBrBirEySWoPTV23rvUg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod4Jur7EFPPWzoBvQgF0m3hXyohBrBirEySWoPTV23rvUg@mail.gmail.com>
X-ClientProxiedBy: BYAPR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::37) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:32ff) by BYAPR02CA0024.namprd02.prod.outlook.com (2603:10b6:a02:ee::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 01:08:39 +0000
X-Originating-IP: [2620:10d:c090:400::5:32ff]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d20b63b-0be5-4f50-1c45-08d813ed4d51
X-MS-TrafficTypeDiagnostic: BYAPR15MB2390:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2390BF7061D9B66E1AE18D74BE980@BYAPR15MB2390.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GTY6EMK0ss58vR4CJjxsbTeruSLbpc2GhCyT+lEev141OlwvAMB2bHvt2hnawgqOMnEi62alrot87RnDZx4t0qonkaEwdOou54wfkDGjX+T9vWfMclC4ZYf8gqWihSJV6D1Bcuy+XH/Wl3Hyxbu9vKZBs0LZqVf/iL3btxGCFK7O6rGpkj7JZLwsuGSO0UM/6YwpCfquvubtZ+rFEBPdxmfdnxC4cQ+B91p1FNF0APsRoVoo4mkzzU6eayTYnj8morwRO3hsGddvbetpZqgLPD4Wf1zB3it3LPIciKxNEO0VqadFjVLTrtWC1rhuJOthCqSzrna7C+gbBOlG8Hnm4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(346002)(39860400002)(136003)(366004)(376002)(478600001)(52116002)(7696005)(186003)(1076003)(33656002)(53546011)(16526019)(66946007)(54906003)(6506007)(316002)(55016002)(9686003)(66556008)(66476007)(83380400001)(86362001)(5660300002)(4326008)(8936002)(8676002)(6916009)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Sc3uYF9g23qWh8awAcexzCwifCOE1yzMhyq4aEsOQIGhaZlhGZNL8IyHMsvkQd0EGYNVXmu6CsqqXC/JEG4aH1+R/x6u5GJFVDS7XjPkvv5C/HloyATHoXMAxQxXteszhnlNSt/rIzHXk3u3fTXkVyUgSKmccnNlirRgpoq6JmeKiAzWIQMw6nudW48H2OD3H1HvtLtNS9Q7GObEN+RmNS/zMCoLb6bPFi2Rz2dk/Vr3vxzFhqhAJezNYUDNGiOIllxr6YloT2mvxTov0pYTF1fhqtOxxfPdZgbh1Qw9Vkw4v6liaXggsPteSli/Xj7x1jXWHGYY0TA4cXPzJR9jiuOoopPjGEOZ5Hs7zoWNQ/u1enwbhcivpv/nIkNrzq/5ZDsShVPYaur08FGF7hth3ycPRZj6L3kvzVlQXEqktANFLv4XpOWAStcbNAcEUqSkrHXcICM2f1f4E03ZYZvHwSRS9gCCqhutpqsTqgc+92uIzkPho4u1A3WesoHpGzEiT9a3byhfx66KTc8gxXCJ5A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d20b63b-0be5-4f50-1c45-08d813ed4d51
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 01:08:40.1941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qH9ZT4irHAOICR6ItYHM+uqAldFNHLPA9HFYLV2LGSnJSrPnqMIvOM1znubSfXCf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2390
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_21:2020-06-18,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=1
 bulkscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 cotscore=-2147483648 malwarescore=0
 spamscore=0 mlxscore=0 adultscore=0 impostorscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190004
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 07:55:35AM -0700, Shakeel Butt wrote:
> Not sure if my email went through, so, re-sending.
> 
> On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > From: Johannes Weiner <hannes@cmpxchg.org>
> >
> [...]
> > @@ -3003,13 +3004,16 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
> >   */
> >  void mem_cgroup_split_huge_fixup(struct page *head)
> >  {
> > +       struct mem_cgroup *memcg = head->mem_cgroup;
> >         int i;
> >
> >         if (mem_cgroup_disabled())
> >                 return;
> >
> 
> A memcg NULL check is needed here.

Hm, it seems like the only way how it can be NULL is if mem_cgroup_disabled() is true:

int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
{
	unsigned int nr_pages = hpage_nr_pages(page);
	struct mem_cgroup *memcg = NULL;
	int ret = 0;

	if (mem_cgroup_disabled())
		goto out;

	<...>

	if (!memcg)
		memcg = get_mem_cgroup_from_mm(mm);

	ret = try_charge(memcg, gfp_mask, nr_pages);
	if (ret)
		goto out_put;

	css_get(&memcg->css);
	commit_charge(page, memcg);


Did you hit this issue in reality? The only possible scenario I can imagine
is if the page was allocated before enabling memory cgroups.

Are you about this case?

Otherwise we put root_mem_cgroup there.

Thanks!
