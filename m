Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A61AC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 21:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 157C82087C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 21:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="U1uDBXZC";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="GdD8a415"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgIDVLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 17:11:17 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:3520 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726842AbgIDVLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 17:11:15 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 084L7uNk013076;
        Fri, 4 Sep 2020 14:10:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=K2HTDtwPD5k24tUgIsA4KCAbJcdU/UcaSg5VQM8R2w8=;
 b=U1uDBXZCPj0eaE5GDKM0jE/A2Fhn3BfWwOq5nqN/SimR2vKlYWkWaM8N4r8ndZ5GU58Y
 utNFQw6KC6V51KJRSJGphFtRaLHMDelbMZ1ehlmsLPYTVPXohJwFKIG1Gg/M4RfTvdAH
 MViOAzoSpcKeyg7+OUrULDQ3SeRhCFnIMSQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 33b2heyxng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 04 Sep 2020 14:10:53 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 4 Sep 2020 14:10:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKZ8F9Dq3b788QgBTHMQSMDT8jPLJd0yIw1HhGMNoRV3vzPp+jXWgP68ikgFcOsPtSg7bqveYQCJTuwJysXeHvOKg5TxVILZ7XmBBzRNegoSkFcPVdjBmVt6eNvhV/8D3hf7Ee8QmfFgy2PwO6e+sAanzxU6xi97cTZz7j7RpSEEooQyu3TPdoIRqRkI2pj/9332xZLls0xbzbMOtjLrNSpRaCaLLa/u6DCmU9Tzl7qnEgFC6xn5+ZrYSf7iqxPMlnclHn1p4lYlNRt9W7RVqdBW0y0a7L/z4USEDx3e6rByHtfhB+JzdhfrstUPLZzGctFnq21P09tj1GwoxYLF9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2HTDtwPD5k24tUgIsA4KCAbJcdU/UcaSg5VQM8R2w8=;
 b=n0nJYUzrGZRoV2feVCcoXijtc52igUaUd/EncsQxEhoU6PgfwuciajmzPsGnFWH/9MsabJ7n/KYxOhbPR5QTTJyvdVdABAi2260g8Jd3XT9DUAqTk6pHriPlNdNQsj9yqFKziE/771MtUCJ/010HPXE/lUOkNn7hAdcNmGT7WBZr6uqWeY82X2QOR/4ckgf7UD8PgdPP/VhJfPx9SYjmtDamQVWf3jaZAbdi1fU3+61tNSCOHPaVeEQ0P+kK7KT1lrmqVI5Rxr79Ym6bt/CSsNjRDDMPogStHVQ498PKej5t9BZMimWkrmoibkbpogVmzBS/f0KLYDKflqpamFocHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2HTDtwPD5k24tUgIsA4KCAbJcdU/UcaSg5VQM8R2w8=;
 b=GdD8a415VE6mMMdcrZ4QsBZSDYWyShfe4nPs3pDWNDzEDOqMgcIe6NkhwDjByBOE9+rh4Fcuzac4N9VsufXqXqkf42GMbnOs9BuAQC6gld5fuBvcKhxz1xejy4tHWxchLp6L4Caj4yL67430NMAkqFZLplPT13VoyWUdMWRj4Ic=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3555.namprd15.prod.outlook.com (2603:10b6:a03:1f5::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Fri, 4 Sep
 2020 21:10:50 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e%6]) with mapi id 15.20.3348.016; Fri, 4 Sep 2020
 21:10:50 +0000
Date:   Fri, 4 Sep 2020 14:10:45 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     Zi Yan <ziy@nvidia.com>, <linux-mm@kvack.org>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 00/16] 1GB THP support on x86_64
Message-ID: <20200904211045.GA567128@carbon.DHCP.thefacebook.com>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200903073254.GP4617@dhcp22.suse.cz>
 <20200903162527.GF60440@carbon.dhcp.thefacebook.com>
 <20200904074207.GC15277@dhcp22.suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904074207.GC15277@dhcp22.suse.cz>
X-ClientProxiedBy: BYAPR01CA0017.prod.exchangelabs.com (2603:10b6:a02:80::30)
 To BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:e811) by BYAPR01CA0017.prod.exchangelabs.com (2603:10b6:a02:80::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend Transport; Fri, 4 Sep 2020 21:10:49 +0000
X-Originating-IP: [2620:10d:c090:400::5:e811]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f181501-50ad-4275-ace7-08d851170002
X-MS-TrafficTypeDiagnostic: BY5PR15MB3555:
X-Microsoft-Antispam-PRVS: <BY5PR15MB3555024AD6C84513AEBD8485BE2D0@BY5PR15MB3555.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yvGhUerCe8FqNGjqTgCo0SjAmiHJYjf5Y9UUQDpQV7lcWBTWb4nXSgnguOdsovAXUVvPwDpm4jtnRrCKVcZpkcJ5SMEHGCUQ+J4SJDYUIl003a2sDrarP2jANThOY+YtSoVTMsxsRZsS0/q4Cdw3+mlDRQch3Y1LFNPv+BiyWMBSOTPJLKPvooFLcejofuvs2KTTo/V5FbEb/yM6tMIJKoS1LSTxbXBv7BHVSd7hZqFJlhZ7LrNzZjvu8swiMbuHUh7PHligcJG3pdURkC/PvD6LYoiEANJhB4SCsZMSdV+NYTYSZ0I1/iyyu0sIMgP3fsnsaH5Lm8tWhDmiV93qYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(39860400002)(396003)(136003)(346002)(54906003)(7416002)(55016002)(6916009)(9686003)(86362001)(316002)(8676002)(83380400001)(8936002)(478600001)(66476007)(6666004)(186003)(16526019)(5660300002)(4326008)(1076003)(66556008)(66946007)(52116002)(2906002)(6506007)(33656002)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: tEHyDRmpBpc9AVTPsfiVGVlOky6wZ2IaWYV+5o1+NVu/kWwvvayEnfnDemQZPa9YLond6/OMNbK49eG4F/tqZaeezBtxztdE5JQkht+TApSBAHDKPXZtkvRIhnam83dcTvuSDW7mcdPQ7xshcYyNzMyxsuaxw/e0adYf8JOwWifM4MNcpOWbmscUNm9GmRHodkmvhtxA/L5ocToQ6Uih1rahA9Kl8WuvMJCxlJPm5xXAIPHxyjl/Ozgp8cd5/CO03ZpLRXLwzNHZuSRsgnwpbJOFStwJRnVPk2cux7RyBmazOmnMiLW+OlGJIb4F/xm4mDIcULsrjomI350wb8//vDNgCcejfce7UvO40v1DBiUfpgCngYQnUhNTpgzuetG7KDt8XkuQjnFj7kTjX1UzzN4CqAoF1SqAczVCRqzdN+ZsIBxSbQEO/5blQj74LyFS+9BhvXhXh0PxQQ+Tec4XI5V9VGd6mK762bbnIxMyCcy1WpuoebsuF9QpU4PTTevpSyOYgsg8kNs4jNfN0lnTWJxdbLRqyfvtsBmNr60XimhUh+13FUj5GoLikKodKuTf7XnZWSlHf47EUliQUXPjT9SrmmkVUCOXE6lu5IK0tTmJRAj7ZUGS+4v4kX1E8OQ2c+wNUgJzErNp+inAg5vZZO+H1x3xLJZ1xZOsgzvloVfeAG3bBCCEeVIKAnx9+VAk
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f181501-50ad-4275-ace7-08d851170002
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 21:10:50.7653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GQ8yXEOR8CNYGcIyd2mmSSD2TaKCX1pvodyBKWsiqWSi//orgpakso9y9GHLnK6h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3555
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-04_15:2020-09-04,2020-09-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=1
 mlxlogscore=999 mlxscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009040182
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 09:42:07AM +0200, Michal Hocko wrote:
> On Thu 03-09-20 09:25:27, Roman Gushchin wrote:
> > On Thu, Sep 03, 2020 at 09:32:54AM +0200, Michal Hocko wrote:
> > > On Wed 02-09-20 14:06:12, Zi Yan wrote:
> > > > From: Zi Yan <ziy@nvidia.com>
> > > > 
> > > > Hi all,
> > > > 
> > > > This patchset adds support for 1GB THP on x86_64. It is on top of
> > > > v5.9-rc2-mmots-2020-08-25-21-13.
> > > > 
> > > > 1GB THP is more flexible for reducing translation overhead and increasing the
> > > > performance of applications with large memory footprint without application
> > > > changes compared to hugetlb.
> > > 
> > > Please be more specific about usecases. This better have some strong
> > > ones because THP code is complex enough already to add on top solely
> > > based on a generic TLB pressure easing.
> > 
> > Hello, Michal!
> > 
> > We at Facebook are using 1 GB hugetlbfs pages and are getting noticeable
> > performance wins on some workloads.
> 
> Let me clarify. I am not questioning 1GB (or large) pages in general. I
> believe it is quite clear that there are usecases which hugely benefit
> from them.  I am mostly asking for the transparent part of it which
> traditionally means that userspace mostly doesn't have to care and get
> them. 2MB THPs have established certain expectations mostly a really    
> aggressive pro-active instanciation. This has bitten us many times and
> create a "you need to disable THP to fix your problem whatever that is"
> cargo cult. I hope we do not want to repeat that mistake here again.

Absolutely, I agree with all above. 1 GB THPs have even fewer chances
to be allocated automatically without hurting overall performance.

I believe that historically the THP allocation success rate and cost were not good
enough to have a strict interface, that's why the "best effort" approach was used.
Maybe I'm wrong here. Also in some cases (e.g. desktop) an opportunistic approach
looks like "it's some perf boost for free". However in case of large distributed
systems it's important to get a predictable and uniform performance across nodes,
so "maybe some hosts will perform better" is not giving much.

> 
> > Historically we allocated gigantic pages at the boot time, but recently moved
> > to cma-based dynamic approach. Still, hugetlbfs interface requires more management
> > than we would like to do. 1 GB THP seems to be a better alternative. So I definitely
> > see it as a very useful feature.
> > 
> > Given the cost of an allocation, I'm slightly skeptical about an automatic
> > heuristics-based approach, but if an application can explicitly mark target areas
> > with madvise(), I don't see why it wouldn't work.
> 
> An explicit opt-in sounds much more appropriate to me as well. If we go
> with a specific API then I would not make it 1GB pages specific. Why
> cannot we have an explicit interface to "defragment" address space
> range into large pages and the kernel would use large pages where
> appropriate? Or is the additional copying prohibitively expensive?

Can you, please, elaborate a bit more here? It seems like madvise(MADV_HUGEPAGE)
provides something similar to what you're describing, but there are lot
of details here, so I'm probably missing something.

Thank you!
