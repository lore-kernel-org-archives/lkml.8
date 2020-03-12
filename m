Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A863C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588FB206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="O7Jmh8qu";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="JucBbRYs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgCLRHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:07:42 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:25080 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726085AbgCLRHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 13:07:42 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02CH6jwG014722;
        Thu, 12 Mar 2020 10:07:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=2MVioacD/H7eOK1hLafJmanRgPVlFOqC+u6lk9Q37Yc=;
 b=O7Jmh8quV+OEHftR/MyM4/p59DGFev+jBi0zfDTgq1Y/cO/DFyO3JlLHVj193tPHALko
 RZhHESnkhj4K7pHmaK2Y142Mgnz2mFlx+CzYMugOP01qJfzed8DMt6Bp/S0hIg2y+Ef2
 kdHWVWjomr7fEOaTyPolnNfs/FeERq8LQLk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2yqacsbrng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 12 Mar 2020 10:07:22 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 12 Mar 2020 10:07:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E70GuMEQYsa83FIStaV9JemRX907zOQrNcrMYnzghYHUVRbyKxCeu6pmK93X7L37jk4tT+9HKQ3OHyzwWb815jv7h5SbXBNs/0ZKBb//JpNvz03Wz/SLfYZaI18fsRx85eUpHjela1eQmbEfRX0EJaWAHeD5Q+RApLKbm68MtJ59fpdE2j4canml95DP4GzbXBwIW91UjzfVsm2l++IyHzJjGWsMns79oWtvNbZTgNGHJ+UM/jpqm1ahOiuqGoo4VchA6xEF7e+oR4dffPEKxMXn2jyMAT/eWEz2MLDl6uTDn2WKKzHzuHolMaY/A41ulm64gh++cPvJ1LmST71vHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MVioacD/H7eOK1hLafJmanRgPVlFOqC+u6lk9Q37Yc=;
 b=DINVr1IqxlpD6VRMxXMLiw7dXCgwPcBQpW69WzoibdYjHa79I/NEfR+vDvHcvKuqK19yNgiazEBLqXPU+/uBtHQzFic+jRb/n7+2+qKP6u2DU6wE8pEBW+2wwtQSzplZchBH5wq72f6HXNK03o4CCd+OUJjLMk83OzCwYbsc1CbCYwuAUaIyfhxHwDBse0BKDB6/pJzNyPdFlJyjKt4g6gQH6SEdWk5ZME/O4dkqczzBBb4oLLO8uI4kRJ21jZjdSY6f21EM/3/p+A+Xv1dMeIYZip9DzbIjEF9l+d5b8mYi4dwBc5wefFbI8aAg/ohlIt7NpUdq470qFqipxJeLJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MVioacD/H7eOK1hLafJmanRgPVlFOqC+u6lk9Q37Yc=;
 b=JucBbRYsiJ/AuMpBtZXOB03uEyf0GyptWQXmm7QMk//MjVHn0nrip7xlF3VnNRwPXGZoGndESsgeVRAQY+nEBcj5R9e75r0GbND38bLH7XPTLoRNlMe9dDOj6r6WAcI89kesschNU3Ect+MpstC7L5zgptHa6f0UepZ+2sZ18E4=
Received: from MWHPR15MB1661.namprd15.prod.outlook.com (2603:10b6:300:124::23)
 by MWHPR15MB1487.namprd15.prod.outlook.com (2603:10b6:300:b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Thu, 12 Mar
 2020 17:07:19 +0000
Received: from MWHPR15MB1661.namprd15.prod.outlook.com
 ([fe80::f930:6bf2:6d2:93ef]) by MWHPR15MB1661.namprd15.prod.outlook.com
 ([fe80::f930:6bf2:6d2:93ef%8]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 17:07:19 +0000
Date:   Thu, 12 Mar 2020 10:07:15 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Joonsoo Kim <js1304@gmail.com>
CC:     Vlastimil Babka <vbabka@suse.cz>, Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Qian Cai <cai@lca.pw>,
        Mel Gorman <mgorman@techsingularity.net>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH] mm,page_alloc,cma: conditionally prefer cma pageblocks
 for movable allocations
Message-ID: <20200312170715.GA5764@carbon.DHCP.thefacebook.com>
References: <20200306150102.3e77354b@imladris.surriel.com>
 <8e67d88f-3ec8-4795-35dc-47e3735e530e@suse.cz>
 <20200311173526.GH96999@carbon.dhcp.thefacebook.com>
 <CAAmzW4PRCGdZXGceSCfzpesUXNd8GU-zLt-m+t762=WH-BjmoA@mail.gmail.com>
 <20200312023952.GA3040@carbon.lan>
 <CAAmzW4MMV8jgboSgHizUoH6wuuztCTJRY7AGN95869rrfH++=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAmzW4MMV8jgboSgHizUoH6wuuztCTJRY7AGN95869rrfH++=Q@mail.gmail.com>
X-ClientProxiedBy: MWHPR20CA0008.namprd20.prod.outlook.com
 (2603:10b6:300:13d::18) To MWHPR15MB1661.namprd15.prod.outlook.com
 (2603:10b6:300:124::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:b75) by MWHPR20CA0008.namprd20.prod.outlook.com (2603:10b6:300:13d::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17 via Frontend Transport; Thu, 12 Mar 2020 17:07:18 +0000
X-Originating-IP: [2620:10d:c090:400::5:b75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81675679-ebd5-4118-d9cf-08d7c6a7d262
X-MS-TrafficTypeDiagnostic: MWHPR15MB1487:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR15MB1487428568E8F178B41F59D6BEFD0@MWHPR15MB1487.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(39860400002)(346002)(366004)(199004)(54906003)(966005)(66476007)(478600001)(66946007)(66556008)(186003)(16526019)(316002)(81166006)(8676002)(81156014)(86362001)(7416002)(8936002)(9686003)(4326008)(6916009)(55016002)(5660300002)(52116002)(53546011)(7696005)(6666004)(1076003)(6506007)(33656002)(2906002)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1487;H:MWHPR15MB1661.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uKISOI0cwE951KrvpuON7gtknD4NWUPOoWjrpSiyLsxI57brqkrlV9iPPQoh6bXAIJOWjg5oTHkxwQgQ/ta1GtfcJgZHJMYv7dTziLWe24o7o9cMqm34Kp6WZ+ffLlGo/mo710tx8CUNB0wHf/edjdZgtA4EzgWMO4HIHv0vbAc7Hl4kG+meg4lmn41ioZHiIMpw+Z7bV0aCCHcfVi71IOuxLFuQkblE+q6CEen46Rl7hx40ggw7/scA/K7HLCoi1DNCWWjt/19NwGrWbsEWf3puc7CsrQpiaoEHFkKotIRNJWNi05oW60r5ahZnf2dVXt7AwKbSl2uI+o25Irzmosc4xJNySas3KUBdRWSTzK6wwC8qM9p+PN3h4Pg2DW47ipsOPhjG5OEj7sQzoo4XFT/sWAhTcyY0EmweTG4kwxwwAZstAtMi474m+DUkKyE74ib0ng0PfhnfOoga6p9oNY6mKufmTV3m6y91rYTgUBl3NAgKeBrpkjUSCWFaVhsF1bQGV5eQHE4/x2EkvuQm2xt88i7wpYQdIY4bonvEugfjuoflEOr620Eyw1FvQs/C
X-MS-Exchange-AntiSpam-MessageData: d8v/c5XnSrJ8z1DSuU4gShDjlFngCIB7ycCRN5vNmZg1Vmwiow4ngWXAohtnXPK94wk0uHWqzA7sKFMXHefRmDjzOkEayl/yN0cE1HcsaYHtTwwAhWQRJ3xBA9g8RAZbUP0217XgQeFl+mPE0OMq1JD533RAtqrDjiKruOqRVRrOpG/d7lfYJXilKmuf63dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 81675679-ebd5-4118-d9cf-08d7c6a7d262
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 17:07:19.3083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1101fO8ZM2JOsIMXTnDrcEridGshbtBqojtI7oHm50iqpHjGyUtR0Xj1BDFLXxgi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1487
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-12_11:2020-03-11,2020-03-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003120087
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 05:56:34PM +0900, Joonsoo Kim wrote:
> 2020년 3월 12일 (목) 오전 11:40, Roman Gushchin <guro@fb.com>님이 작성:
> >
> > On Thu, Mar 12, 2020 at 10:41:28AM +0900, Joonsoo Kim wrote:
> > > Hello, Roman.
> >
> > Hello, Joonsoo!
> >
> > >
> > > 2020년 3월 12일 (목) 오전 2:35, Roman Gushchin <guro@fb.com>님이 작성:
> > > >
> > > > On Wed, Mar 11, 2020 at 09:51:07AM +0100, Vlastimil Babka wrote:
> > > > > On 3/6/20 9:01 PM, Rik van Riel wrote:
> > > > > > Posting this one for Roman so I can deal with any upstream feedback and
> > > > > > create a v2 if needed, while scratching my head over the next piece of
> > > > > > this puzzle :)
> > > > > >
> > > > > > ---8<---
> > > > > >
> > > > > > From: Roman Gushchin <guro@fb.com>
> > > > > >
> > > > > > Currently a cma area is barely used by the page allocator because
> > > > > > it's used only as a fallback from movable, however kswapd tries
> > > > > > hard to make sure that the fallback path isn't used.
> > > > >
> > > > > Few years ago Joonsoo wanted to fix these kinds of weird MIGRATE_CMA corner
> > > > > cases by using ZONE_MOVABLE instead [1]. Unfortunately it was reverted due to
> > > > > unresolved bugs. Perhaps the idea could be resurrected now?
> > > >
> > > > Hi Vlastimil!
> > > >
> > > > Thank you for this reminder! I actually looked at it and also asked Joonsoo in private
> > > > about the state of this patch(set). As I understand, Joonsoo plans to resubmit
> > > > it later this year.
> > > >
> > > > What Rik and I are suggesting seems to be much simpler, however it's perfectly
> > > > possible that Joonsoo's solution is preferable long-term.
> > > >
> > > > So if the proposed patch looks ok for now, I'd suggest to go with it and return
> > > > to this question once we'll have a new version of ZONE_MOVABLE solution.
> > >
> > > Hmm... utilization is not the only matter for CMA user. The more
> > > important one is
> > > success guarantee of cma_alloc() and this patch would have a bad impact on it.
> > >
> > > A few years ago, I have tested this kind of approach and found that increasing
> > > utilization increases cma_alloc() failure. Reason is that the page
> > > allocated with
> > > __GFP_MOVABLE, especially, by sb_bread(), is sometimes pinned by someone.
> > >
> > > Until now, cma memory isn't used much so this problem doesn't occur easily.
> > > However, with this patch, it would happen.
> >
> > Sure, but the whole point of cma is to be able to use the cma area
> > effectively by movable pages. Otherwise we can just reserve it and
> > have 100% reliability.
> 
> I agree with that cma area should be used effectively. However, cma_alloc()
> failure is functional failure in embedded system so we need to approach
> this problem more carefully. At least, to control the behaviour, configurable
> option (default is current behaviour) would be necessary.

Do we know who can test it? Adding a configuration option is a last resort
measure, I really hope we can avoid it.

> 
> > So I'd focus on fixing page migration issues, rather than trying
> > to keep it empty most of the time.
> 
> Great! Fixing page migration issue is always good thing!
> 
> > Btw, I've fixed two issues, which dramatically increased the success
> > rate of 1 GB page allocation in my case:
> >
> > https://patchwork.kernel.org/patch/11420997/
> > https://lore.kernel.org/patchwork/patch/1202868/
> >
> > (They both are on the way to upstream, but not there yet)
> >
> > Can you, please, pull them and try?
> 
> Unfortunately, I lose my test setup for this problem so cannot try it now.
> I will try it as soon as possible.

Thanks! Looking forward to it...

> 
> Anyway, AFAIR, I saw the problem while journal is continually working
> on ext4. Have you checked this case?

My ext4 fix sounds very similar to what you're describing, but it's hard to
say for sure.

Thanks!
