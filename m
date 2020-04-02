Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9136EC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 02:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4326E20719
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 02:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="LMXJXKgF";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Vog45Sej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733213AbgDBCy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 22:54:28 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:13716 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732462AbgDBCy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 22:54:27 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0322sCN4008919;
        Wed, 1 Apr 2020 19:54:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=lG4bkW6Hi25hi3/zozOkOgJQ+N5Q1brdo8vGh7th7Ks=;
 b=LMXJXKgFsh9w7mF5IFTOLn8cTB6p+G1XoY9XmFN97mObmm9v6hzRumw8cFC7xDxJTNPS
 CmfWl01nrnSUWgdDA9CjLORIRcmG3UPRGw15rMeL4gldsuWoWSb35fZHtCeBvmfdTYj7
 qBrrZWoLlP8S1/n8Ku1Voh4GbbMHjKMI1GU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 304wbbb0da-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 01 Apr 2020 19:54:13 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 1 Apr 2020 19:53:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/J++0E0ekpbOJ4cw0pdx0VPEFuUzaaYQz6WEEvi9WZso/AVxJnYipP4XfpnzQ7Sx2suC3qZ4P5+dOOUyb/r2y3HFAVeupdhctD0X0c/rSreJD7Bwpxkl8+jK4hJuKAVdkz42V/ugfX7xB52FYpKLK120OdKjfsolzxQ/PjJ6PwBDtiKANMS7VXNyxbajFzZxTJZFUWGuIf9i637VZeqwj/yzcLM65AtKQj+SSONZVDqpG2tktu6IHsRdkk35gYvSBIfi5sv4gPY36XzmpcvBdHaM5dU0qGpdaFjOynLVXx1fYvCKgUDFHmjlAKK8wSB2q6/nNebosSnoiREhBjF1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lG4bkW6Hi25hi3/zozOkOgJQ+N5Q1brdo8vGh7th7Ks=;
 b=AtMdJy7FTKPQcE3+oYT0it45+ubBNikzNGpaGcgmFzOFtpllCnTXhzMJFz5EGnvRO4oZdfYZQxvsJaQqQp+AtpxTmdluZ1LnqsKO5RIMjJHtvg9gzOYs4tPyJMD4XdnpmJdJlYk/t8VQAPOAmMkHiM0Sz/QpGodZTmf8g6e8OhKTU1msmeuU2HKjBxGZ7/p4reMBA+yJGc5G0P495xMk2xFo+jHyQg6yMjkjoSPjO7OjYxKn5GzJFqtXSn/qigcWRLXXtKVWPbuhuCAtUH5EYJ9D2X+6MLPNo6WVOa3ghLaFEttTrKb9ZcKASuyrXh2zf4yCm2Xpyx5qhSKjzLrt+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lG4bkW6Hi25hi3/zozOkOgJQ+N5Q1brdo8vGh7th7Ks=;
 b=Vog45SejAjMh4+VJs+/hzfFOQEpRbbavwX3VKnOK/8auj70CdonAFcAGmXYjuWkBGRNrEQWQmsG/hn07dyY2AIOW38IY+8oE8CJxFnZGw5iaC36RZ15gpp4pC4wY+cNKej8FCcj0ROUcneAkr19um+paMAwRm7bwWc9YPDlgiuM=
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3079.namprd15.prod.outlook.com (2603:10b6:a03:f5::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Thu, 2 Apr
 2020 02:53:41 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 02:53:41 +0000
Date:   Wed, 1 Apr 2020 19:53:35 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Joonsoo Kim <js1304@gmail.com>, Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Qian Cai <cai@lca.pw>,
        Mel Gorman <mgorman@techsingularity.net>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH] mm,page_alloc,cma: conditionally prefer cma pageblocks
 for movable allocations
Message-ID: <20200402025335.GB69473@carbon.DHCP.thefacebook.com>
References: <20200306150102.3e77354b@imladris.surriel.com>
 <8e67d88f-3ec8-4795-35dc-47e3735e530e@suse.cz>
 <20200311173526.GH96999@carbon.dhcp.thefacebook.com>
 <CAAmzW4PRCGdZXGceSCfzpesUXNd8GU-zLt-m+t762=WH-BjmoA@mail.gmail.com>
 <20200401191322.a5c99b408aa8601f999a794a@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200401191322.a5c99b408aa8601f999a794a@linux-foundation.org>
X-ClientProxiedBy: MWHPR21CA0061.namprd21.prod.outlook.com
 (2603:10b6:300:db::23) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:4acf) by MWHPR21CA0061.namprd21.prod.outlook.com (2603:10b6:300:db::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.0 via Frontend Transport; Thu, 2 Apr 2020 02:53:39 +0000
X-Originating-IP: [2620:10d:c090:400::5:4acf]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d462acf-6107-4fe7-dc54-08d7d6b10c68
X-MS-TrafficTypeDiagnostic: BYAPR15MB3079:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB307990AAE43721BD2204914BBEC60@BYAPR15MB3079.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0361212EA8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(366004)(39860400002)(136003)(346002)(376002)(396003)(186003)(6506007)(81156014)(53546011)(54906003)(5660300002)(8676002)(7696005)(52116002)(7416002)(81166006)(2906002)(316002)(6666004)(1076003)(55016002)(33656002)(86362001)(6916009)(478600001)(8936002)(66946007)(9686003)(16526019)(66556008)(4326008)(66476007)(142933001);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xp1B4uG3VY9toSmmfZ5CXHQQZBHMTcpU15Vp7xnca2H5Svw7Bqn7D40Tv/ZKxPEGGSuuIYFqZaKkfHR4xKUjH9fHMV+glK5dvZam5scJWKRjR1Eul7n9XnIMUOd+ns1nwkb9OrJK3Nw+VvHzTLh22xx06wnct1S1woNd0LGGQUWfc2+kk9YNQO8wF/rcwcxw9Id615ogB234ZSyFIgMWM3pzUNbeMc4v09Je5wEaPzocaD+NH6ighml4MAvNrL7x+ayaLCDCszUCeGvYIUHfV50l50k3rivfpXNME1/4Pl8zRxHs/8vZxYfKbSEHcSIf4afE0WyNYlkuczGRzgc7laDoYVOgEln9G8rUTpsDRrc+72jmAlGlq06ldEgvxTYB5BGsSD9gEjxV0ZlxXPXLAVOfojVUIaDK99ojRSQxs7nkgoXgPd6GnlCkZhW3IgLIpKjaQlcW/YQqFyXTdsdUDHcbTNRluwHGjsNk4Djb3XetXppeV9eC+O6SaafIMIPr
X-MS-Exchange-AntiSpam-MessageData: S/YRlDOuAmk369oi4H8KNIDTuU5T/CME7AbiFFr7CJLawSN8a1L5qcB5R7BOV3Rb9y65czFnL9YAjs8qw52eEQUPYW49dIC1TJ7gMb39B0uw5cjrM7D9+c7u+uryOo6FsSFsatoQFrvQoYbjzBBLgw0qNyN8V9aSaf5DIzDLFYRca8TrxvTwPnSqtKIcdy5w
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d462acf-6107-4fe7-dc54-08d7d6b10c68
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2020 02:53:40.3078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zrh0tCnoLlemscAZPT1SS0IJ7F8tQZDTLUfa8VPIfbm4PqUdD7VLmCTPvv8gy4rD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3079
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-01_04:2020-03-31,2020-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 bulkscore=0
 suspectscore=5 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004020025
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 07:13:22PM -0700, Andrew Morton wrote:
> On Thu, 12 Mar 2020 10:41:28 +0900 Joonsoo Kim <js1304@gmail.com> wrote:
> 
> > Hello, Roman.
> > 
> > 2020년 3월 12일 (목) 오전 2:35, Roman Gushchin <guro@fb.com>님이 작성:
> > >
> > > On Wed, Mar 11, 2020 at 09:51:07AM +0100, Vlastimil Babka wrote:
> > > > On 3/6/20 9:01 PM, Rik van Riel wrote:
> > > > > Posting this one for Roman so I can deal with any upstream feedback and
> > > > > create a v2 if needed, while scratching my head over the next piece of
> > > > > this puzzle :)
> > > > >
> > > > > ---8<---
> > > > >
> > > > > From: Roman Gushchin <guro@fb.com>
> > > > >
> > > > > Currently a cma area is barely used by the page allocator because
> > > > > it's used only as a fallback from movable, however kswapd tries
> > > > > hard to make sure that the fallback path isn't used.
> > > >
> > > > Few years ago Joonsoo wanted to fix these kinds of weird MIGRATE_CMA corner
> > > > cases by using ZONE_MOVABLE instead [1]. Unfortunately it was reverted due to
> > > > unresolved bugs. Perhaps the idea could be resurrected now?
> > >
> > > Hi Vlastimil!
> > >
> > > Thank you for this reminder! I actually looked at it and also asked Joonsoo in private
> > > about the state of this patch(set). As I understand, Joonsoo plans to resubmit
> > > it later this year.
> > >
> > > What Rik and I are suggesting seems to be much simpler, however it's perfectly
> > > possible that Joonsoo's solution is preferable long-term.
> > >
> > > So if the proposed patch looks ok for now, I'd suggest to go with it and return
> > > to this question once we'll have a new version of ZONE_MOVABLE solution.
> > 
> > Hmm... utilization is not the only matter for CMA user. The more
> > important one is
> > success guarantee of cma_alloc() and this patch would have a bad impact on it.
> > 
> > A few years ago, I have tested this kind of approach and found that increasing
> > utilization increases cma_alloc() failure. Reason is that the page
> > allocated with
> > __GFP_MOVABLE, especially, by sb_bread(), is sometimes pinned by someone.
> > 
> > Until now, cma memory isn't used much so this problem doesn't occur easily.
> > However, with this patch, it would happen.
> 
> So I guess we keep Roman's patch on hold pending clarification of this
> risk?

The problem here is that we can't really find problems if we don't use CMA as intended
and just leave it free. Me and Rik are actively looking for page migration problems
in our production, and we've found and fixed some of them. Our setup is likely different
from embedded guys who are in my understanding most active cma users, so even if we
don't see any issues I can't guarantee it for everybody.

So given Joonsoo's ack down in the thread (btw, I'm sorry I've missed a good optimization
he suggested, will send a patch for that), I'd go with this patch at least until
the first complain. I can prepare a patch to add some debugging to the page migration
path so we'll get an idea what fails.

As a safety measure, we can make it conditional depending on the hugetlb_cma kernel
argument, which will exclude any regression possibility for the majority of users.
But I don't think we have a good reason for it now.

Thanks!
