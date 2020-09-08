Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF3DC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E8BD20658
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="C3MAktlH";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="hanF/dHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730799AbgIHT7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:59:54 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41590 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730926AbgIHT72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 15:59:28 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 088JsJmo015578;
        Tue, 8 Sep 2020 12:59:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=RTN3tVmaMqbYZsFKBs+ATnrWiVexfh6nnR3iCJl2duc=;
 b=C3MAktlHgmpqyrIktKazSWpcEK/P/xO0pKvBjyYxj+PWEWRVPMNUCkQiPlIJhNpALyrR
 NPnBjun6ntz/GeKDqeo1Qd52je2wX/h2k5VPiWHpqMUKOa9Gv779xRUAzV2EX31AFmLo
 B4lk6RgMnj+XD/ESbW3Q+bTqyUv7gmXoKjo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33c86mebqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 08 Sep 2020 12:59:05 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 8 Sep 2020 12:59:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmHUAlafqIcgYbUVn+jTiPegDzxwUY31y81Ik1qMc52NMazPQMSSI4NBOdG4loBsd1x3sFnQ7A+bJpAWVZiMKyHb6LMoNPdc9mB8AJfHUuwL97pruh4hTAPjArMBoZKVTA/g1xvK+DLsgoVAEem8OpiyuyFK4fiLYT8ANxEIWf2PClFBJ9b+cT2DU27U+O5E2rQ023LjC1+v7Vchl0P3lEDNMll0zETm+6UKkhLN1ruzaid0OY0iaRZspBeyJKXO6oQyYxhwEPnIuSqBZjJq3aQLGo0T/R7aG7vws0J47jy84O0YPaRMq1Xn3ut8XiHoAbcnjJFWuvKyqVOWpwGAeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTN3tVmaMqbYZsFKBs+ATnrWiVexfh6nnR3iCJl2duc=;
 b=jY3CKy4/5+C/ST2/0DQP/I68ljEXmZwQlFeP6PTCv/2EFGrTxhrbEIMD9jHEsWIYyqlRVoyuhkxWD88zQ05QtH2gHsjMsk199PqkxIwIyHbM+QBedA/+iUc1BPUkuVQFHqHuscXXW/mIEzCRz04dW8y+tKOz7NRFeABeZqG6eos/v/rkBgsblafBKb4hlDuUnhukLPjsEq+gFN+KRQwYDeTpiYdef8Dm4loscm7c3wqUcckrRH0bjmBHB6+gf4vAlB6OpyenuewPF1JlStk1HiZSu1ClP535LMV3uGspvi6FYmKJdxpxoQEppKD3BhRjY4NmXmRv82O4ooP58oGAsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTN3tVmaMqbYZsFKBs+ATnrWiVexfh6nnR3iCJl2duc=;
 b=hanF/dHKfXulw8r5Wk5Wmyo5HdTDknQMn5B4SM+ERwJKFxRz4zah74kZW3rx7oRcEpTCIxZv1s5NZtg42zgdH38SakBLX0Nf9KtTkMrIJvZS2eQoiVQy2EJdFIfvLQCvMgkgY5vi5ATz9M1KNIPAT7CZboW2zGPLYM/oVlCQZb8=
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3681.namprd15.prod.outlook.com (2603:10b6:a03:1fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 8 Sep
 2020 19:59:03 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e%6]) with mapi id 15.20.3370.016; Tue, 8 Sep 2020
 19:59:03 +0000
Date:   Tue, 8 Sep 2020 12:58:59 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Zi Yan <ziy@nvidia.com>
CC:     Michal Hocko <mhocko@suse.com>, <linux-mm@kvack.org>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 00/16] 1GB THP support on x86_64
Message-ID: <20200908195859.GC567128@carbon.DHCP.thefacebook.com>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200903073254.GP4617@dhcp22.suse.cz>
 <20200903162527.GF60440@carbon.dhcp.thefacebook.com>
 <20200904074207.GC15277@dhcp22.suse.cz>
 <20200904211045.GA567128@carbon.DHCP.thefacebook.com>
 <20200907072014.GD30144@dhcp22.suse.cz>
 <3CDAD67E-23A1-4D84-BF19-FFE1CF956779@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3CDAD67E-23A1-4D84-BF19-FFE1CF956779@nvidia.com>
X-ClientProxiedBy: BYAPR11CA0105.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::46) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:1faf) by BYAPR11CA0105.namprd11.prod.outlook.com (2603:10b6:a03:f4::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend Transport; Tue, 8 Sep 2020 19:59:02 +0000
X-Originating-IP: [2620:10d:c090:400::5:1faf]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0731fd3-8e7b-428e-7283-08d85431a26d
X-MS-TrafficTypeDiagnostic: BY5PR15MB3681:
X-Microsoft-Antispam-PRVS: <BY5PR15MB3681B927E802B9DDEC85B268BE290@BY5PR15MB3681.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: buXGVovtSVVYdwf3Ub/5BKS9zeD1xcqPbywmqgieLlgFCcpMTl7e4My5rjaTzRJmDAovfwsB5D9jYYnlSX9lcF89lhetxNdPLERrKueCschp+aPjatyLs/WO6GgT2LnOBB6eS/T77MB1kjh5vQ4LAUspZAMIdRDtYLWclXs0+Nf4/6ZdaN1LMQiIKImDl9gY4+z69cMYFpmxeSJIEV6JLQF8ZMNmxnNwEbCpTmy920TVhZkBohIQrb97y2mNktSikE7s51i/fdmVRoHVoJJ3R++2GQW1H1j/d9zOgdQx4MGeWCaBrmdKALXDQxOKRrmpR8XU7VaZPzojOU/7QlhIag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(376002)(346002)(39850400004)(6666004)(2906002)(186003)(16526019)(6506007)(53546011)(86362001)(54906003)(1076003)(478600001)(9686003)(4326008)(55016002)(8676002)(33656002)(6916009)(66946007)(66476007)(8936002)(66556008)(7416002)(52116002)(7696005)(316002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 0CdQ4rF68q9Z8J6MBVFxmqLECsjXSwXuVZ013iVoSY0e/dWjZj4TVwqDFvNPEyfLNLGp48D7ILMrsxwxwkqGM5Wj03WLm2bD+QqKZyaum95nxtnAu602Cc+lGgOcxs+TzTxGBZ1NKy7K/Iu570TE+m6AGkhiKdmO5czEXD/g8cZYbxFhSRMpmemiESCCzJVnRPtZS2XAbFE5XBqj1u+l62wVNK2S7REL3iMd3UD3Z7GvNh5fvQI+mw0saMJroDpXxYiRdX5fPdGRndsQDi0HOMKUpJGOoRq3g6pkauzRBAh8lPs7rseYuaZ8w2DcevwXbKOB1esuWtd6gONnOecUAyH3tIIk6v7ZsZCma8nFRIQpSa2ztOEP581LPIisZFz419R6qMPpvNr9Nd6daNDV17Gb0MEqosL5lYc2qg95g7qQ+igKUdjqnAM79HEyBDFqB58yL2chf8lOSM66so15TmHC0QHqmzie/+6usIaZN7otCbesbECNT/OJIxI2Enoyp/Q9N+T3U9N7XY4Zz4ICUD5au5VL67kWNvw9DN/YlGWPMhb5k+EEiciGouDDN2NbJ4mSr7QmAJzxDMhNWOZdzXltYC39jI1hCB3X5Afo9g+tGgggTxnSSQwrz8+r5AwhrTTGgRgbEaVQrTSAoiRc1qRJF/2zaoHovof4GqlH2Po=
X-MS-Exchange-CrossTenant-Network-Message-Id: b0731fd3-8e7b-428e-7283-08d85431a26d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2020 19:59:03.0416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XzYksWftDdbEIW8Wh+4cqT8a/yAUJVrInhssnttZjjCvUEXSBn5yAa9YWekaorLD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3681
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-08_09:2020-09-08,2020-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 suspectscore=1 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009080182
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 11:09:25AM -0400, Zi Yan wrote:
> On 7 Sep 2020, at 3:20, Michal Hocko wrote:
> 
> > On Fri 04-09-20 14:10:45, Roman Gushchin wrote:
> >> On Fri, Sep 04, 2020 at 09:42:07AM +0200, Michal Hocko wrote:
> > [...]
> >>> An explicit opt-in sounds much more appropriate to me as well. If we go
> >>> with a specific API then I would not make it 1GB pages specific. Why
> >>> cannot we have an explicit interface to "defragment" address space
> >>> range into large pages and the kernel would use large pages where
> >>> appropriate? Or is the additional copying prohibitively expensive?
> >>
> >> Can you, please, elaborate a bit more here? It seems like madvise(MADV_HUGEPAGE)
> >> provides something similar to what you're describing, but there are lot
> >> of details here, so I'm probably missing something.
> >
> > MADV_HUGEPAGE is controlling a preference for THP to be used for a
> > particular address range. So it looks similar but the historical
> > behavior is to control page faults as well and the behavior depends on
> > the global setup.
> >
> > I've had in mind something much simpler. Effectively an API to invoke
> > khugepaged (like) functionality synchronously from the calling context
> > on the specific address range. It could be more aggressive than the
> > regular khugepaged and create even 1G pages (or as large THPs as page
> > tables can handle on the particular arch for that matter).
> >
> > As this would be an explicit call we do not have to be worried about
> > the resulting latency because it would be an explicit call by the
> > userspace.  The default khugepaged has a harder position there because
> > has no understanding of the target address space and cannot make any
> > cost/benefit evaluation so it has to be more conservative.
> 
> Something like MADV_HUGEPAGE_SYNC? It would be useful, since users have
> better and clearer control of getting huge pages from the kernel and
> know when they will pay the cost of getting the huge pages.
> 
> I would think the suggestion is more about the huge page control options
> currently provided by the kernel do not have predictable performance
> outcome, since MADV_HUGEPAGE is a best-effort option and does not tell
> users whether the marked virtual address range is backed by huge pages
> or not when the madvise returns. MADV_HUGEPAGE_SYNC would provide a
> deterministic result to users on whether the huge page(s) are formed
> or not.

Yeah, I agree with Michal here, we need a more straightforward interface.

The hard question here is how hard the kernel should try to allocate
a gigantic page and how fast it should give up and return an error?
I'd say to try really hard if there are some chances to succeed,
so that if an error is returned, there are no more reasons to retry.
Any objections/better ideas here?

Given that we need to pass a page size, we probably need either to introduce
a new syscall (madvise2?) with an additional argument, or add a bunch
of new madvise flags, like MADV_HUGEPAGE_SYNC + encoded 2MB, 1GB etc.

Idk what is better long-term, but new madvise flags are probably slightly
easier to deal with in the development process.

Thanks!
