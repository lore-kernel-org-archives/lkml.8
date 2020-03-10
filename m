Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DA7C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F1D721927
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="SWfGYly6";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="PlYJH10J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgCJRbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:31:46 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:14778 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726271AbgCJRbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 13:31:46 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02AHSrVA028655;
        Tue, 10 Mar 2020 10:31:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=pRPhmot7wgKGObSaLKVIQ6pfR4Mfiky/UzT5Y7pbzmI=;
 b=SWfGYly6JslCAW16c1RYwmXwDWpfyz5xs/lHlYsiDeNe7Wre3KBgAdvaH/Sc7GWTdse/
 wAhbwJ6eHxOIvVIqBB5SpIKKZXmVwCEZUkc05pjrEjDIM6iAbX8WcSn95Yf4NNGTyY2G
 k77uf6q/nrp3OHcaYAa/l0Z+6FMf8Fcycck= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2yp25fkmqp-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 10 Mar 2020 10:31:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 10 Mar 2020 10:31:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6G84YT3ojmqTXUWMDoXLkFP0SDNadlbstmfDsSXnQ8i5s6HJE6bugz8c6V30JygqInVI5FQvYsv+j3T2H6N9mmAMXMcbdwxn2GWqf6LBSUnFk/y1jzfa2T69nrbhoN1r9vUpTEJpNgayOWqZuRaHVE6ow+1qPbcOKArt9M+efDpJqsLp4CyoOQWQDX0V/M4JrSp2Kjf9It+GAN/bP7JNgImntkAtVS3Lss15ni1jT6YJwTv1W3S9t+p1BqqiuT8eRFRSEltr6KEkY47XEUCIeXydIniPYyb68RBka2NlMBdZ1CTOncaDaQNirPLas/zIFhp0LYYQVXCz7T09vg3Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRPhmot7wgKGObSaLKVIQ6pfR4Mfiky/UzT5Y7pbzmI=;
 b=KSvMxiDXrpSBm8u7HgYOYpgJdDPlnm4kzduWE96MQMBc9QjJVfxqE2do+BoIG+plqRQcatHkPplwK17cI2llhV1UM3XAOSnvIWAfpMWSBNdmn44UURvnUgaDuJka7i8wwpXEmWQAFYjXN3GIGhNswSNdJ1YlBy6xmuBSmiQtgQ0uKCkvnlFNZwMhvqBH7yt4z1KIrTdxYVHIUNxMTRgKpd6GYNsuQFygdh1bNZwepI/MnK0J4Rpl8FKWodSZGvDA6lM+y2PViJwqPMgYRhLHV+x9WLZ0yed8IFsN4wA34VhX1On1IPDNgs1GAPQQfkejtb1tnRqegIv8M3LylmtgRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRPhmot7wgKGObSaLKVIQ6pfR4Mfiky/UzT5Y7pbzmI=;
 b=PlYJH10JByAvhqbExmKWostmClapZl6EEBlNOr7WjxFgQjjGaX3X3FJ3nqGVvI5QYH92Oe5lT5pcXvxfVBJdjVpkFEf3t6pw9zFw7ZPijXgEMqOs2v6DWjmfDx740paB2BUwnwSbb/GE40OnqKhd3ta6GKsnDOj7vbu9wIDwS5w=
Received: from MWHPR15MB1661.namprd15.prod.outlook.com (2603:10b6:300:124::23)
 by MWHPR15MB1262.namprd15.prod.outlook.com (2603:10b6:320:25::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Tue, 10 Mar
 2020 17:31:00 +0000
Received: from MWHPR15MB1661.namprd15.prod.outlook.com
 ([fe80::f930:6bf2:6d2:93ef]) by MWHPR15MB1661.namprd15.prod.outlook.com
 ([fe80::f930:6bf2:6d2:93ef%8]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 17:31:00 +0000
Date:   Tue, 10 Mar 2020 10:30:56 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v2] mm: hugetlb: optionally allocate gigantic hugepages
 using cma
Message-ID: <20200310173056.GB85000@carbon.dhcp.thefacebook.com>
References: <20200310002524.2291595-1-guro@fb.com>
 <20200310090121.GB8447@dhcp22.suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310090121.GB8447@dhcp22.suse.cz>
X-ClientProxiedBy: MWHPR11CA0048.namprd11.prod.outlook.com
 (2603:10b6:300:115::34) To MWHPR15MB1661.namprd15.prod.outlook.com
 (2603:10b6:300:124::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:2b00) by MWHPR11CA0048.namprd11.prod.outlook.com (2603:10b6:300:115::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16 via Frontend Transport; Tue, 10 Mar 2020 17:30:59 +0000
X-Originating-IP: [2620:10d:c090:400::5:2b00]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28cc14df-ba6b-4964-ca76-08d7c518cc72
X-MS-TrafficTypeDiagnostic: MWHPR15MB1262:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR15MB1262F30506FBB90368CA401BBEFF0@MWHPR15MB1262.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(376002)(39860400002)(396003)(189003)(199004)(33656002)(6916009)(7696005)(52116002)(6506007)(81156014)(4326008)(8936002)(6666004)(81166006)(8676002)(478600001)(54906003)(9686003)(1076003)(86362001)(66946007)(5660300002)(55016002)(66556008)(2906002)(66476007)(186003)(16526019)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1262;H:MWHPR15MB1661.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S7kf2fzoVmpaD5CMO+HPozaQi3mxLLLJoqhoSB5dkWdSsBKCyYpNrPattywVJcyZgP8Gco8/yyEp8bsIPCGlA3IveCiy360Td5OuV1UBldSWRVA7ICU9s1NzyeI6zRkW/tCZ/+zPQGKZA70a/3yrLt2Jt3YrQHrEnWkJbSzTkLaX9pwzsmynsOTjdMKc0p/pN3Z3GFjEyECJTkEkpl8V7bYWIY/Hl+B5DBGeNiDsjN866K9NPcrqa1Rjgy4DHFZ4o/cJrxfAgzLeiZIIhzcuvKdvjgDwPJJwA8QiO5Z0Afg4/2hS0TmxA63wSPG1XlhFXver/+w+RV1AZPn+92BQTcNUdSNC8wp5g0eV6ckpsQc9OYw/7fyVrrvOR8hm39vnvRLyCiUAt5g4/KBWbrO0rGbwpZmK0+ZsALqx/GSutfAxzVCFH3KEnfHXJowRA5nA
X-MS-Exchange-AntiSpam-MessageData: gq/C/MnaguDM5gQ+r/RgVru5E66emqvPNApUz4c7DKKMVJbYfomVtmtpiu7fdcsycUu3ZdIAfeN1ovE/tbsy8qWAOIj6WUvEf0juc5e+1n/Jst5WnvPG+k5tBYuVhTeS5Sh5039RIYm2DZJSRgrw1GEzD3XcuerJSgs/6zKrMnlutxVMJSuzYzuotJtUu/pp
X-MS-Exchange-CrossTenant-Network-Message-Id: 28cc14df-ba6b-4964-ca76-08d7c518cc72
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 17:31:00.0144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PvM76g3LMZAvWIxZ4kHTGSmtQ6DLLa/dsLkd9lkXaeX3RhcLFioJRjqQjz5C7iab
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1262
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-10_12:2020-03-10,2020-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 phishscore=0 malwarescore=0 suspectscore=1 clxscore=1015 spamscore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 mlxlogscore=963
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100106
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 10:01:21AM +0100, Michal Hocko wrote:
> On Mon 09-03-20 17:25:24, Roman Gushchin wrote:
> [...]
> > 2) Run-time allocations of gigantic hugepages are performed using the
> >    cma allocator and the dedicated cma area
> 
> [...]
> > @@ -1237,6 +1246,23 @@ static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
> >  {
> >  	unsigned long nr_pages = 1UL << huge_page_order(h);
> >  
> > +	if (IS_ENABLED(CONFIG_CMA) && hugetlb_cma[0]) {
> > +		struct page *page;
> > +		int nid;
> > +
> > +		for_each_node_mask(nid, *nodemask) {
> > +			if (!hugetlb_cma[nid])
> > +				break;
> > +
> > +			page = cma_alloc(hugetlb_cma[nid], nr_pages,
> > +					 huge_page_order(h), true);
> > +			if (page)
> > +				return page;
> > +		}
> > +
> > +		return NULL;
> 
> Is there any strong reason why the alloaction annot fallback to non-CMA
> allocator when the cma is depleted?

The reason is that that gigantic pages allocated using cma require
a special handling on releasing. It's solvable by using an additional
page flag, but because the current code is usually not working except
a short time just after the system start, I don't think it's worth it.

But I do not have a strong opinion here.

Thanks!
