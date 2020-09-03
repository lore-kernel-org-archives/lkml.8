Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C551C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F066F2072A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="pJdk/xUI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbgICQkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 12:40:51 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:24285 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728085AbgICQko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 12:40:44 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f511c890000>; Fri, 04 Sep 2020 00:40:41 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Thu, 03 Sep 2020 09:40:41 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Thu, 03 Sep 2020 09:40:41 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Sep
 2020 16:40:36 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.57) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 3 Sep 2020 16:40:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQydSs04/YmJf1RuTx25UfXEnHTJKxK0hWY4EJR++ySUDDQf4HtNvDr6K2tl3d4Ko9OqWVBh4lyGA/BcybB9+THBJVcqXyLI6KMXZgna+6yzg7pZyE4OW0oAcYTX/xwRrqMaeeoVln6CxOt96IoZgTDZu/WPCtiW//BmtWeBjWlE/p8fH254r16hLEH/i8CxtxNTSaXPc+lYihKj6OpZ4g/fDjEvtYJfYOXIBFGLgiBUeljz+GotOAXtpbbBzEt2feCR+1eR1bdoahin30CRdRt9sJihwaKxuTeu0OWDJytWhVy9QHpmZ7qcW7gNDxsSk7hqsQdr+Zh0Y6tmsf4DJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HasdGhxox5G8vFNGd5kKcKgUFo1QqettRANZpnjzgAc=;
 b=n5YJ1AyWYQlondjITN9bSyfwcGaRki3QpLVLWuwvKq1mHjg307XC1e+1MhUDEssObhBZrbp2sVGf5lOHvvpEv+78Dhube8t6WsNfDN0R6qN0n7a4o/zg+dYT/cJCGZe74nCfKD25ADxVRUUPkr6jEvV2HR2P2bap+gB+8GpQsET928ZM5sl706vEj7uDRANuFjPzNOXYdJGRVSE0oWdJ4D0jR6gY10stcJB5hiDs6HL/UoyVtGsnr2hZumZgc7cbSX+7buRiX/hqIezEMt4GvMj3AwTmc68zhRZXJJPmPSfuFBziCzFrNUJuaSfdm4HQw1arjZ6HSNVr7BiatmtRzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1434.namprd12.prod.outlook.com (2603:10b6:3:77::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 16:40:34 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Thu, 3 Sep 2020
 16:40:33 +0000
Date:   Thu, 3 Sep 2020 13:40:32 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zi Yan <ziy@nvidia.com>
CC:     <linux-mm@kvack.org>, Roman Gushchin <guro@fb.com>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 00/16] 1GB THP support on x86_64
Message-ID: <20200903164032.GM24045@ziepe.ca>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200902184053.GF24045@ziepe.ca>
 <E78A0F18-223C-44A8-BCBA-73CF7AF6F8A5@nvidia.com>
 <20200902184852.GH24045@ziepe.ca>
 <C5EFA1CC-311C-47D5-9506-D087D9AE58D1@nvidia.com>
 <20200902195739.GI24045@ziepe.ca>
 <C12C60A2-43EA-4AD3-9077-FFB61CCC964C@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <C12C60A2-43EA-4AD3-9077-FFB61CCC964C@nvidia.com>
X-ClientProxiedBy: MN2PR22CA0021.namprd22.prod.outlook.com
 (2603:10b6:208:238::26) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR22CA0021.namprd22.prod.outlook.com (2603:10b6:208:238::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend Transport; Thu, 3 Sep 2020 16:40:33 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDsHo-006cdc-5E; Thu, 03 Sep 2020 13:40:32 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a42f65e5-2fd2-4b07-98e6-08d8502813d4
X-MS-TrafficTypeDiagnostic: DM5PR12MB1434:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1434355527A36F94BA560B51C22C0@DM5PR12MB1434.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HXflp/YxWLHkn5A6gmlHYTov5MM8R5vQjWsZi0jOKKYHd5SB2i9pOY81WSRbyzj7wIjKA/FlibfsamxURRUvTOZqVf/al5pUuWcHardpPXntc7yxczXhjAD+mdON3yQPRDt70Gfq+UjklX5OjOZqV0So9gBmrDyi+WzrY9ntjRUSQHN+PLonmZ0eeIOldFNviECnJB1t/BDYQ6bEadRweqIfEFeynf7F5V65Qg/LEK61u1q+TvXtoxAqLr3pqvNCQAOaAbAp/ijegidbtDXKtR+1KUQclsYARlmqDxU+2P5OO3xg+SidKB6gxWHMzCyxDZj7LezLw0xicvVjUaKskg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(8936002)(53546011)(9686003)(9786002)(316002)(9746002)(426003)(33656002)(26005)(36756003)(186003)(2906002)(66476007)(66946007)(66556008)(6636002)(8676002)(1076003)(6862004)(5660300002)(83380400001)(86362001)(4326008)(54906003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: QVioe5zttpeAC3p8L0izPio/dk8WHLqOTUKAOnOTMLPwTmNr4pn71q7wV+iYY/UGPfQLC6bH+83qzr8gJwIq41nLlx3rGNTh5Aqv2sClu4g3ACVqIRKLqXcTH6tsYyMbwKLnZlA2O5H8aDVQUeNnsEyJ79FApRz9UN2ozO8YXEkQEt74XvJT7VRpaLN0iXG2KZSky1bcO9RVbRUxvkeI0LOTm+EyeldRH42Fc6YTHt0X0iUaarVt+sWm4FaBmnIBeEjsu1hNHcUEXlp/XPPyz0FVSqhWwmdM5buwKipPlgxWit10sFLhK5qzNVQQSwmQ0eoAiGQMixt6epsb0FVKTM0AnzBOr3X6Me2wQRQFR5/mBfDnKZxtUrkck/0PxdP8SjvCj5k7UZ2QNVjU6BbQPUglqeeDsAbb2S5AUug4BJQ9Eop9B7Ai33x2h9NvlqrDJC4pP7wMqz6oK/E26p8uANlhPTbLCx444HJwrtg3bOvYWS248j+B/dnz9Bz2SZIK0NNVnO9rf9jT7RZ5/3t+cJbQbxMo8zF1yiElY325L8+ymEw2sWJLtkSRTyNijnFNiAsnfMolbpD8yFjpLD54s5tnsTEHk32wjuFs8uxddDpBKdgmtyvOh92xnwwA/dZjXlPnO1M7eJpin7PsyHwLjA==
X-MS-Exchange-CrossTenant-Network-Message-Id: a42f65e5-2fd2-4b07-98e6-08d8502813d4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 16:40:33.8336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6NcUZCL+wT8qXiYV0tzeXMGPouwkOmIb1YbT+0AFP1x+PGwy9UC5TYxa1/q7JlxI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1434
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599151241; bh=HasdGhxox5G8vFNGd5kKcKgUFo1QqettRANZpnjzgAc=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=pJdk/xUIkP4V9R/+g6vHnX5hDKnYgHaoaZsdiDp3AjwcEf4I3SDlzTTwbf+9gwa4r
         Llbd1bfXX6Q8qXnQ9o1axKJ++Xz86ewaqBENRvRM5EavA7QYv4IbOe/Ga9qeYdr5wV
         ubXtLDfHqhFsgu6g9uG0MH/9gzOktpscX/8KE3+bVoic3flWcgZLLOAOOhzqmz0qc0
         8ho4/klO9HG08ZlhJL8vn4Iskm9fuyeaSqq7y/6QGJoGhCGcfDvDHn/pBoGGdYfWFG
         AyiP5+Pox3vnu36yHxqKJPwwGGky1lj/8XKRnRz3W6jJeTUNVLprzMJJ5ZamuOGpOp
         nI44cf1O6rT3Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 04:29:46PM -0400, Zi Yan wrote:
> On 2 Sep 2020, at 15:57, Jason Gunthorpe wrote:
> 
> > On Wed, Sep 02, 2020 at 03:05:39PM -0400, Zi Yan wrote:
> >> On 2 Sep 2020, at 14:48, Jason Gunthorpe wrote:
> >>
> >>> On Wed, Sep 02, 2020 at 02:45:37PM -0400, Zi Yan wrote:
> >>>
> >>>>> Surprised this doesn't touch mm/pagewalk.c ?
> >>>>
> >>>> 1GB PUD page support is present for DAX purpose, so the code is there
> >>>> in mm/pagewalk.c already. I only needed to supply ops->pud_entry when using
> >>>> the functions in mm/pagewalk.c. :)
> >>>
> >>> Yes, but doesn't this change what is possible under the mmap_sem
> >>> without the page table locks?
> >>>
> >>> ie I would expect some thing like pmd_trans_unstable() to be required
> >>> as well for lockless walkers. (and I don't think the pmd code is 100%
> >>> right either)
> >>>
> >>
> >> Right. I missed that. Thanks for pointing it out.
> >> The code like this, right?
> >
> > Technically all those *pud's are racy too, the design here with the
> > _unstable function call always seemed weird. I strongly suspect it
> > should mirror how get_user_pages_fast works for lockless walking
> 
> You mean READ_ONCE on page table entry pointer first, then use the value
> for the rest of the loop? I am not quite familiar with this racy check
> part of the code and happy to hear more about it.

There are two main issues with the THPs and lockless walks
 
- The *pXX value can change at any time, as THPs can be split at any
  moment. However, once observed to be a sub page table pointer the
  value is fixed under the read side of the mmap (I think, I never
  did find the code path supporting this, but everything is busted if
  it isn't true...)
 
- Reading the *pXX without load tearing is difficult on 32 bit arches

So if you do READ_ONCE() it defeats the first problem.

However if the sizeof(*pXX) is 8 on a 32 bit platform then load
tearing is a problem. At lest the various pXX_*() test functions
operate on a single 32 bit word so don't tear, but to to convert the
*pXX to a lower level page table pointer a coherent, untorn, read is
required.

So, looking again, I remember now, I could never quite figure out why
gup_pmd_range() was safe to do:

                pmd_t pmd = READ_ONCE(*pmdp);
[..]
                } else if (!gup_pte_range(pmd, addr, next, flags, pages, nr))
[..]
        ptem = ptep = pte_offset_map(&pmd, addr);

As I don't see what prevents load tearing a 64 bit pmd.. Eg no
pmd_trans_unstable() or equivalent here.

But we see gup_get_pte() using an anti-load tearing technique.. 

Jason
