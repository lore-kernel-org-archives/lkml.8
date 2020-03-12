Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FE7C0044D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 02:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE23F20754
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 02:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="dFP2s9vG";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="KHwZOBZn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387685AbgCLCkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 22:40:23 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:21050 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387501AbgCLCkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 22:40:22 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02C2abJU005154;
        Wed, 11 Mar 2020 19:40:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=91x4rGKCyl0zkLe+VeUvCOA3JF6YTfXIXxtujR146FU=;
 b=dFP2s9vG5srrXKAos6ICxYlj1KZFWrbsVY7P0oH9GhmWF5xk4ax1Ym5gMAzbMEFXO63d
 gi6t9dMop8tFWFqjTdJ+ajJ4+/3Dqveo9C46X/oJNX/gh9osnmXlfwKgV64nrPz/vDiV
 wt5U2s+FxvwlRBPh7sWhVJIeCM3fRwnSjtM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2yqadx8euc-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 11 Mar 2020 19:40:00 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 11 Mar 2020 19:39:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUDmqiO7TXWB9itgRtxrO8nx+fxdQlXyheiErVnZXjGaiHNKay8UG3JbruCs/KmceVXT1mcSc/WaCEpf4KV4f3J+TKSChTbkUqoi+sg81lP5qju/yKwtY5pfstDCYvwzxpQX4lIP5cD6u0USYOoHl+EyATOmH4xsr1mLct+Nx4l9KtRHo6H+EnseAI+Y629epVl0vpwo5SJ4CNmwbso0O8S3+ZIndhKpTiQrGUydpx6ku6CkQ903KxPiKkIptIpLwE4aIQ8+4B9wkmTlWeNFIGFQsR1v231TFCjapid+guSIjykFWC16+Fq17W6MTAIhhegZcj+Vcj4MfPlqK/BZnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91x4rGKCyl0zkLe+VeUvCOA3JF6YTfXIXxtujR146FU=;
 b=lv7wxqN0Ul4BL1uBgUcIJI8wpWjrFhSI0NP9zbRzInn9UddDhzEh1pT5zHmypFJXjhUpdTo1DAZAbqtPLo8GI0hTYEusVqX5gGi+vbjQC/8APsilk4X00hJnYPdv11yAV/SfqjEITW0PmvjANIUZAdR55ktdLB65hsCEf/V/6fn+uOYcHNpipuMeRXXUWu45XSdqjhEBJvhN7BUU+094yZoUQaZ1f+fBLDtc5eUxtE/mhTtbwfX7HtUZwbw4bOTeSI98YYi74RcUVqG9p6EmmzDRQX3w9nL9+ZCIL9m0Ml/nYJslfKQcxody+5YR33rFdlLQuoBLMG1xDPWy3ksPGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91x4rGKCyl0zkLe+VeUvCOA3JF6YTfXIXxtujR146FU=;
 b=KHwZOBZnP1r+nyMN3TbVFNKYEFhwj+Ex0nE1N05pISDU6A5dzhHR5mJiirnbqZPLppCiANYpDvsDgvqK555a0sZjnuXjNM1tx8zWnFpGbMIcRks83711JsNlOQufeM9DvfQnigUD/kb4dayULor6CLC59/gGWgR8AnObVbHbuSU=
Received: from DM5PR15MB1659.namprd15.prod.outlook.com (2603:10b6:3:124::22)
 by DM5PR15MB1659.namprd15.prod.outlook.com (2603:10b6:3:124::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Thu, 12 Mar
 2020 02:39:58 +0000
Received: from DM5PR15MB1659.namprd15.prod.outlook.com
 ([fe80::c4cb:24b7:22b8:811d]) by DM5PR15MB1659.namprd15.prod.outlook.com
 ([fe80::c4cb:24b7:22b8:811d%12]) with mapi id 15.20.2793.013; Thu, 12 Mar
 2020 02:39:57 +0000
Date:   Wed, 11 Mar 2020 19:39:52 -0700
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
Message-ID: <20200312023952.GA3040@carbon.lan>
References: <20200306150102.3e77354b@imladris.surriel.com>
 <8e67d88f-3ec8-4795-35dc-47e3735e530e@suse.cz>
 <20200311173526.GH96999@carbon.dhcp.thefacebook.com>
 <CAAmzW4PRCGdZXGceSCfzpesUXNd8GU-zLt-m+t762=WH-BjmoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAmzW4PRCGdZXGceSCfzpesUXNd8GU-zLt-m+t762=WH-BjmoA@mail.gmail.com>
X-ClientProxiedBy: MWHPR12CA0071.namprd12.prod.outlook.com
 (2603:10b6:300:103::33) To DM5PR15MB1659.namprd15.prod.outlook.com
 (2603:10b6:3:124::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:9ced) by MWHPR12CA0071.namprd12.prod.outlook.com (2603:10b6:300:103::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16 via Frontend Transport; Thu, 12 Mar 2020 02:39:56 +0000
X-Originating-IP: [2620:10d:c090:400::5:9ced]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc25c921-3e04-4f1e-d944-08d7c62ea760
X-MS-TrafficTypeDiagnostic: DM5PR15MB1659:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR15MB16592F5FE8A541859FBA1D7ABEFD0@DM5PR15MB1659.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(366004)(376002)(136003)(199004)(81166006)(81156014)(186003)(6666004)(66476007)(52116002)(966005)(53546011)(7696005)(66556008)(4326008)(54906003)(6506007)(316002)(5660300002)(478600001)(55016002)(8676002)(66946007)(6916009)(16526019)(8886007)(8936002)(2906002)(86362001)(7416002)(36756003)(1076003)(33656002)(9686003)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1659;H:DM5PR15MB1659.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R3+yNvH2MCGkF6YEo8NTJe1fzZJ7ULgxSDXvJtBzg1teFsD2ad9AE+LNfEhqLfmvy3yRNFwI+ESQZcmmriNm3KdCu5pBAg9Kr0X7V5SQsNuTQp4yU+kwPeFy1MREngmi5XkgSXJvyW2cD2p7K+/c5vyJ2SYaui7gIEsS3LhzwOF5/QQSMpOh9xgLV9CvBn9HZ6UCGDMBxSNArzKKyBG9KyTCs4tdxn6IDMASBW/oytkAZl3+QKYvpIgITcoaVuhOyFO31NIIO5e7UTsAasX0SJhyLF1WenQroeSFFManFW6TUj2Ij78AdHdE1iF1yKd2Oic8jGqTM8IiCwj8mBGISiC2vGeVdmO7s2dMzXEIVjAIIrnCITc9cBPcFShkGIwEvht9n1MaMwvGL6sSaqTE62+Zv6lW1cNP77yNjEVBKYygc1nPnUGJPOcbyCk4ZBI7mgW/ckXTT3VDBnrgr6d5Qj23vP8DlcEmOm1DguKfdPQrLHY4uYAXlCNd8ACaNgX9jiMBY/xVi1ogU94IjnQvUuUsDYVljvufIrd2UdgajKdCRW3cYK8BNv9f7SP/VOCt
X-MS-Exchange-AntiSpam-MessageData: HvZLb7v8razOjKvaLlNYqObXowmQ3z3DmT+Hp2HZIQAvrfBy/NIpttrXECE5qCD1OVHe8qqFpbdBy0/NQxbpxfoivKtcGsVRIy6tYk8jHONDK7caGMgbnjQ8xJqG/6IOfvvQ7Mt77os9usmfThsQcSYNFuLJy9Y4vRVN0N3YbstAGB+9BEToHvmNWSsXa6SC
X-MS-Exchange-CrossTenant-Network-Message-Id: cc25c921-3e04-4f1e-d944-08d7c62ea760
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 02:39:57.8430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2S6bXhrgN2eRr0/GbR5ekPlwX80WqNFrpFr00lIq6IjkzMNS0it2UfJnbbBjFb65
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1659
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-11_15:2020-03-11,2020-03-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 phishscore=0 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003120011
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 10:41:28AM +0900, Joonsoo Kim wrote:
> Hello, Roman.

Hello, Joonsoo!

> 
> 2020년 3월 12일 (목) 오전 2:35, Roman Gushchin <guro@fb.com>님이 작성:
> >
> > On Wed, Mar 11, 2020 at 09:51:07AM +0100, Vlastimil Babka wrote:
> > > On 3/6/20 9:01 PM, Rik van Riel wrote:
> > > > Posting this one for Roman so I can deal with any upstream feedback and
> > > > create a v2 if needed, while scratching my head over the next piece of
> > > > this puzzle :)
> > > >
> > > > ---8<---
> > > >
> > > > From: Roman Gushchin <guro@fb.com>
> > > >
> > > > Currently a cma area is barely used by the page allocator because
> > > > it's used only as a fallback from movable, however kswapd tries
> > > > hard to make sure that the fallback path isn't used.
> > >
> > > Few years ago Joonsoo wanted to fix these kinds of weird MIGRATE_CMA corner
> > > cases by using ZONE_MOVABLE instead [1]. Unfortunately it was reverted due to
> > > unresolved bugs. Perhaps the idea could be resurrected now?
> >
> > Hi Vlastimil!
> >
> > Thank you for this reminder! I actually looked at it and also asked Joonsoo in private
> > about the state of this patch(set). As I understand, Joonsoo plans to resubmit
> > it later this year.
> >
> > What Rik and I are suggesting seems to be much simpler, however it's perfectly
> > possible that Joonsoo's solution is preferable long-term.
> >
> > So if the proposed patch looks ok for now, I'd suggest to go with it and return
> > to this question once we'll have a new version of ZONE_MOVABLE solution.
> 
> Hmm... utilization is not the only matter for CMA user. The more
> important one is
> success guarantee of cma_alloc() and this patch would have a bad impact on it.
> 
> A few years ago, I have tested this kind of approach and found that increasing
> utilization increases cma_alloc() failure. Reason is that the page
> allocated with
> __GFP_MOVABLE, especially, by sb_bread(), is sometimes pinned by someone.
> 
> Until now, cma memory isn't used much so this problem doesn't occur easily.
> However, with this patch, it would happen.

Sure, but the whole point of cma is to be able to use the cma area
effectively by movable pages. Otherwise we can just reserve it and
have 100% reliability.

So I'd focus on fixing page migration issues, rather than trying
to keep it empty most of the time.

Btw, I've fixed two issues, which dramatically increased the success
rate of 1 GB page allocation in my case:

https://patchwork.kernel.org/patch/11420997/
https://lore.kernel.org/patchwork/patch/1202868/

(They both are on the way to upstream, but not there yet)

Can you, please, pull them and try?

Thanks!

Roman
