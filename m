Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E941C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDBFC21D56
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="REo7BlFd";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="FK2NGiw7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgCJR6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:58:23 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:61496 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726271AbgCJR6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 13:58:23 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 02AHukjV031979;
        Tue, 10 Mar 2020 10:58:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=sackdrAnIqqkAnSW8yYKv+VTXJzLeBAaGEs9aDldACw=;
 b=REo7BlFdYnBD62EQS9aNWkmnrdrvhbjRX8DAmAwL2UZwdfccB6fvITT/DRSwd9zFvEBV
 N9Np/R9mhdJC5qVV0s2iLxXHjh2PY/8yuT5XapTuHluzkzmBxyckoKOb+HufZooBGqa0
 t+/rm6Yb1TvcPFToFD0tFuoBtnZE0/UmcjQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2yp6uw2s7p-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 10 Mar 2020 10:58:14 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 10 Mar 2020 10:58:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i80fgDyT7CbtluP5TdN8JKwWc99AuHnV2LV4reMWvKCCDaY4gHWZ41tTRGhrW5VMoIp/AURSWMbwSY0F6n6Zqfx1dw5HX5AWNnR5NuD3OJ79faLu2Cq5lLKNRRL0ntABkPKO+kHTOeH4FAoXDwZ0rXBzLezQ3ASy+EzE009FGEa5bAmDJnJN+hm9hgVPpY3M/c7BXPKN2L6xJ9n1KZ2tESC4yh+K8dP0atnPQUxrC979qHkgWsVnnphO/qRswEMRDn190bGmBzGrbtUFFdJ/ZFiGOreJSrwA+pckPDyr/CDE8anPW25POWhZvGv8OEKwNJXQO3lKqYtZ0ODWqsPGXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sackdrAnIqqkAnSW8yYKv+VTXJzLeBAaGEs9aDldACw=;
 b=JtprQOAQD4aK0BwUkCbT6a9AaFi7Axhg5mP2+sB6oTCLVDhdZrxuzjIcg+M1RyUKR2g5BOKWwM2m83cJkIlig1OgRVJiJUDkq8EFO5eK5aum4+15cVD5RWGxeB3AbIpx5nIHhpEiFooqYc444Uq8P2ouFKuCS2vPuYBekSur9dTjLGmzQUpIt822QZpc34nOAiNqfry/tVfS0yAIjSdGFiQlF1Ooi0gQSUA2KxZjJo6PxW3SZ1vjbREtFkJyG9aVBIqHxXCnZEIT8v7+RxwpDFXoq3JTsaNhiTO3P5/HXl0gLsQQorv1KNCtI06vC6sZrylYslmGcCpYSaEW4AsD+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sackdrAnIqqkAnSW8yYKv+VTXJzLeBAaGEs9aDldACw=;
 b=FK2NGiw7Cw94RFLZjk95vu7Ye3E7lTUXhTX1RP6uR0EJU+W6n9EKD/Frit7Vk9TKgH6z/kXpgVdNQk5ne5ujuc2SoDP+M2ecztgxR4Y84KvFUb0tSoT+0CWI17wgzd39j8W6T89ZzMqkppbWoR6YlsL1Y90He2v4t3ceK1tItXU=
Received: from MWHPR15MB1661.namprd15.prod.outlook.com (2603:10b6:300:124::23)
 by MWHPR15MB1742.namprd15.prod.outlook.com (2603:10b6:301:59::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Tue, 10 Mar
 2020 17:58:11 +0000
Received: from MWHPR15MB1661.namprd15.prod.outlook.com
 ([fe80::f930:6bf2:6d2:93ef]) by MWHPR15MB1661.namprd15.prod.outlook.com
 ([fe80::f930:6bf2:6d2:93ef%8]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 17:58:11 +0000
Date:   Tue, 10 Mar 2020 10:58:07 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v2] mm: hugetlb: optionally allocate gigantic hugepages
 using cma
Message-ID: <20200310175807.GC85000@carbon.dhcp.thefacebook.com>
References: <20200310002524.2291595-1-guro@fb.com>
 <20200310090121.GB8447@dhcp22.suse.cz>
 <20200310173056.GB85000@carbon.dhcp.thefacebook.com>
 <20200310173951.GX8447@dhcp22.suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310173951.GX8447@dhcp22.suse.cz>
X-ClientProxiedBy: MWHPR08CA0038.namprd08.prod.outlook.com
 (2603:10b6:300:c0::12) To MWHPR15MB1661.namprd15.prod.outlook.com
 (2603:10b6:300:124::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:390a) by MWHPR08CA0038.namprd08.prod.outlook.com (2603:10b6:300:c0::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17 via Frontend Transport; Tue, 10 Mar 2020 17:58:10 +0000
X-Originating-IP: [2620:10d:c090:400::5:390a]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22664cc2-090f-4080-db6c-08d7c51c98f7
X-MS-TrafficTypeDiagnostic: MWHPR15MB1742:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR15MB174229C8244253F05F47FF8BBEFF0@MWHPR15MB1742.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(136003)(366004)(39860400002)(376002)(396003)(199004)(189003)(6666004)(5660300002)(1076003)(478600001)(7696005)(52116002)(55016002)(86362001)(33656002)(9686003)(2906002)(6506007)(6916009)(8936002)(186003)(54906003)(8676002)(81166006)(16526019)(81156014)(316002)(66946007)(66556008)(66476007)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1742;H:MWHPR15MB1661.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AsqZshytpxhTEjWhPhxQd1wMJMatY+A8MMHfEjh3P+eQpT9zoNE9O4rM66qO//1WN9+cQ5qXJtTcLGwHTzVlvN6+tJWGEop63568e8J81RjqhbOAtMwtiSweXHl4GpuujylMZsibI26X6mj5t47bO/WCj+1QT05AWPc2XdyLm6ZwN4mkEKSErP2c/oOZQEXZSUNGbreLBS92YQNZLM57BuoqObp2qqFCeoxFXa3rxnCbplnFFxXHdCsP3aWOMZJEnWSeGpoK0AMKbRreFvTIM+K4HgNTbZKB/n+3iN8e/kvz1mwv3nqYH4hHo3msUNKnz7Bf0UIg+s/JyCiJ62bH4YcK8kF2JtMIwVGsgd+WW1ZENvMqSQEMS4/aPI78VqaSCZ2QJc7BKcNXzzevdlTmRc7HZDuKWTByDX6Gl3YsND1rY1ryio/3cSvt51F1yz3X
X-MS-Exchange-AntiSpam-MessageData: I20FDQq/cnJA7/dJUye14Wlo09aVeZI84noxAPxJlOsWOoDCFJPoKExPU4hEqEc1EECPgldYpcnT3dipehNlOl3z6K9cSeXKb6yoNaGekvdLf+KkUmRUcqM6IHIRTIqD1Wsb4wk+LKqpuWX7eFHz70/Ma5ECYfdBd7sUt4iOnehJtFeVjoy5wdCN8+KexPHF
X-MS-Exchange-CrossTenant-Network-Message-Id: 22664cc2-090f-4080-db6c-08d7c51c98f7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 17:58:11.5609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mYLE4dnBBZ2YVlIyT0/2VxGd08fZ5dagjYObTkD+C1mnsa1qQglTlvtfoQNw8zs7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1742
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-10_12:2020-03-10,2020-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=5 clxscore=1015
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2003100109
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 06:39:51PM +0100, Michal Hocko wrote:
> On Tue 10-03-20 10:30:56, Roman Gushchin wrote:
> > On Tue, Mar 10, 2020 at 10:01:21AM +0100, Michal Hocko wrote:
> > > On Mon 09-03-20 17:25:24, Roman Gushchin wrote:
> > > [...]
> > > > 2) Run-time allocations of gigantic hugepages are performed using the
> > > >    cma allocator and the dedicated cma area
> > > 
> > > [...]
> > > > @@ -1237,6 +1246,23 @@ static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
> > > >  {
> > > >  	unsigned long nr_pages = 1UL << huge_page_order(h);
> > > >  
> > > > +	if (IS_ENABLED(CONFIG_CMA) && hugetlb_cma[0]) {
> > > > +		struct page *page;
> > > > +		int nid;
> > > > +
> > > > +		for_each_node_mask(nid, *nodemask) {
> > > > +			if (!hugetlb_cma[nid])
> > > > +				break;
> > > > +
> > > > +			page = cma_alloc(hugetlb_cma[nid], nr_pages,
> > > > +					 huge_page_order(h), true);
> > > > +			if (page)
> > > > +				return page;
> > > > +		}
> > > > +
> > > > +		return NULL;
> > > 
> > > Is there any strong reason why the alloaction annot fallback to non-CMA
> > > allocator when the cma is depleted?
> > 
> > The reason is that that gigantic pages allocated using cma require
> > a special handling on releasing. It's solvable by using an additional
> > page flag, but because the current code is usually not working except
> > a short time just after the system start, I don't think it's worth it.
> 
> I am not deeply familiar with the cma much TBH but cma_release seems to
> be documented to return false if the area doesn't belong to the area so
> the free patch can try cma_release and fallback to the regular free, no?

Good point! Then the fallback is not adding too much of complexity, so
I'll add it in the next version.

Thanks!
