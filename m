Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1963C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 01:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF6E0206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 01:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="T6IphPJk";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="AkMKzV5M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730261AbgFSBah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 21:30:37 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:18678 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727045AbgFSBag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 21:30:36 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05J1LL1k026875;
        Thu, 18 Jun 2020 18:30:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=lMFGv7atYc9XhJ3PYcm4if2cm7k752AJ1GScReb/bd4=;
 b=T6IphPJkvujCJ1D+qHlxHxogXvFYvBC1+fcVT7y4cqnyIo/XS7K5BwTA09igtBwpHSCW
 6+BlKJIGx/IjnaEqNj4BtQzd0+xV8SGptcCWnIaiR2QNOIJATZWKdSDfftF+ci8hy98U
 JQaaNYcwnZwtSRKAhvKVvFaj4gx5HzG+v3U= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31r092dfvs-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Jun 2020 18:30:21 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Jun 2020 18:30:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBds+tpQr1OmYMk1LTHy6MdQADJRY5Rwgrp93fO42oRHvrka58Ly65QFmtqlhkAQQBw2f7G83lXRvBPhLdeAPBoqZ8fEQI48/D+lJEZseFtK4WGe18Xsn9spNLHr4izmaXRV5xWe/MX2kg7RiLCoU81zSoO6141xnZ/P/65jRMbW/i7LAjN2nvEz9i9ABrpWg9A8CbJOOcqRjyuqJXnspVkLvYFr45u75UBMp+BzFkAQTxl3nw/7xj8gfeoLZyro7CyOwDmrm5H70SIMjP7DFHWVTHFXS7M3ezgGbKFO0XxRBwKBFbIk2EvtyO/r8M2mUlX6We+fq16fHmcLkdBKbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMFGv7atYc9XhJ3PYcm4if2cm7k752AJ1GScReb/bd4=;
 b=Fh2bCdhAWeTC0hbM+5F3p5OWyyGcAodYRSolMwCr0Rp3dFUHjduUKxPGQtEmfB5EqXYVilq8wOGi7orQNx78aGEAEkUcsMTI0lbmW2zCRchVDq36ZW5umCcobc1dVCZ6A38MmMyecDw4H8wO7bBkmjAVxXHU1D/YubVw4fc2MdXBrYyuv4QiKbxgEPvzwikfWPeN3m23N1hHCDWrSOaz50KZDqmbHIZFabAZR1RsGSOvxOeK+YUbizzUFCzACNTnBeDsVN/smmKCchhs/N9hin3qWFLG2KBkpEcPD1kMtUSgR+ao3y8MWLLwn/9IdTZt6OFyuL1MGOF1YUQrERE7Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMFGv7atYc9XhJ3PYcm4if2cm7k752AJ1GScReb/bd4=;
 b=AkMKzV5MPx8FGxCUCm1jiFRCpaLfcXahy7YS1/fML6JPCOfMu95u9C/uLIynR/dKSewidymT7w2EmmxddBqHJNOO63TVkNKSYkCzwhWLEAyPfKTAyVlGlWI0CAS04Sb686U89sBmOT0nV8YHDri1dg550ibk6fMcLR9XAEFRGL0=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3601.namprd15.prod.outlook.com (2603:10b6:a03:1fb::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Fri, 19 Jun
 2020 01:30:16 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 01:30:16 +0000
Date:   Thu, 18 Jun 2020 18:30:13 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
CC:     Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH v6 00/19] The new cgroup slab memory controller
Message-ID: <20200619013013.GE135965@carbon.dhcp.thefacebook.com>
References: <20200608230654.828134-1-guro@fb.com>
 <CALvZod7ThL=yMwxzCLvrTtq=+Dr5ooUSX-iFP8AhiAGURByFBA@mail.gmail.com>
 <20200617024147.GA10812@carbon.lan>
 <CALvZod4vLQb4kns=ao8btL_g--9axZfcaxhMnj+CoTrCkyWoWQ@mail.gmail.com>
 <20200617033217.GE10812@carbon.lan>
 <e510e964-2703-d123-120c-816bbdd35743@suse.cz>
 <20200618012928.GD24694@carbon.DHCP.thefacebook.com>
 <20200618104344.6a96ac04@carbon>
 <20200618113121.78a6a2ca@carbon>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618113121.78a6a2ca@carbon>
X-ClientProxiedBy: BYAPR07CA0083.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::24) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:32ff) by BYAPR07CA0083.namprd07.prod.outlook.com (2603:10b6:a03:12b::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 01:30:15 +0000
X-Originating-IP: [2620:10d:c090:400::5:32ff]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0eda2ae2-8dee-40aa-dc5f-08d813f05228
X-MS-TrafficTypeDiagnostic: BY5PR15MB3601:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR15MB360140D1DBDD6B951570EE85BE980@BY5PR15MB3601.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BdPsm6IRifv256jbf3fjCogEL/ZiaK5DCBYUnWueBuyCa6/3yzWFSuK4vyyr4wKCkf9GrDZ18WzEW8WxYPaybkWZlZnvY9TYHAVf4/Aofnc4xYiWikR9Wwy00NAYFnQK6oPhXcz38TpU8JYGAuGuh+MDthyb7z1zDfMTMQlghJ4BrWg//B3NOiaZHjERTN96hnFhOB3BjusRKVwqpm5fTvyuHju5hTFeSl07GzcNdaSWbiRg9l5zjISOVySTzMvQcZTN9Dec9bKD1d9U8GKv7uRCK7/uCEFd2m5rPzahYL5AI+sQ/Xg/4pbi3m4PX8dFow9H8PkPEr6AuVxQHLOvxexOgVksQlaADiukCJk7bdExdtKpEOBZiNDJVoUTjwha1NBw3/BU0iP1x2TydJvfvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(346002)(366004)(39860400002)(376002)(396003)(1076003)(8676002)(5660300002)(2906002)(7416002)(478600001)(8936002)(6916009)(966005)(4326008)(9686003)(55016002)(316002)(54906003)(66946007)(66476007)(66556008)(52116002)(7696005)(186003)(16526019)(33656002)(53546011)(6506007)(86362001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: WjgmCvdO8AUHWb6gRY0sPay4d/zDhNxsCbTX6CDPcFGDrHW4Pw1F/wH4FV/quKiWiEXv9HtXeVshK6s4XM2MZQhVPTnXmhRE2fpcY9/jMvd+RJrdjpDnjWYgcS+hkHDqFP0sjFsj+eNGSCTrB091DPyDyjXIEU3KdhRb3VP7DJqk4VVh4RjOFqdk7v7TorJp9jswbAdMzxyUGl8Ej/f236+dordCwST+EUL4n62Sdd1mdXlNr8Bxy09I+ixafAYtYrFvLap6kUNXgViO4DU7Dy7Kj+oDxhNtfKSz1sXCVVCbF8wqJQw+/v/Uuit4kfM+3dLP1JBjbFLXK/D8HXOdMh3hylb9s9UaHTdXsOr5vQKne8CaZXhrlp817pgEoHtsw66bP7ybjMl6QMCXBkHMuAauyefafd2OxaHWjyPPS56FDBpjWJ8t0DVWhrlxyslw4VSnF6bYwE7dQP/VhNtLZGOqIoiDFxUb8E7r1byr/8VibFhupf04+S43c7M5plgioKzYmGM9S7btEzLHdPPCdA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eda2ae2-8dee-40aa-dc5f-08d813f05228
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 01:30:16.7268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HeiCxNadiyzFMyFAVhGrRFBz5+u4oZNFhf8oYdIEozvjUHlY3h5JTRjcsgfBhBSC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3601
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_21:2020-06-18,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 mlxlogscore=999
 spamscore=0 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 cotscore=-2147483648 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190007
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 11:31:21AM +0200, Jesper Dangaard Brouer wrote:
> On Thu, 18 Jun 2020 10:43:44 +0200
> Jesper Dangaard Brouer <brouer@redhat.com> wrote:
> 
> > On Wed, 17 Jun 2020 18:29:28 -0700
> > Roman Gushchin <guro@fb.com> wrote:
> > 
> > > On Wed, Jun 17, 2020 at 01:24:21PM +0200, Vlastimil Babka wrote:  
> > > > On 6/17/20 5:32 AM, Roman Gushchin wrote:    
> > > > > On Tue, Jun 16, 2020 at 08:05:39PM -0700, Shakeel Butt wrote:    
> > > > >> On Tue, Jun 16, 2020 at 7:41 PM Roman Gushchin <guro@fb.com> wrote:    
> > > > >> >
> > > > >> > On Tue, Jun 16, 2020 at 06:46:56PM -0700, Shakeel Butt wrote:    
> > > > >> > > On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:    
> > > > >> > > >    
> > > > >> [...]    
> > > > >> > >
> > > > >> > > Have you performed any [perf] testing on SLAB with this patchset?    
> > > > >> >
> > > > >> > The accounting part is the same for SLAB and SLUB, so there should be no
> > > > >> > significant difference. I've checked that it compiles, boots and passes
> > > > >> > kselftests. And that memory savings are there.
> > > > >> >    
> > > > >> 
> > > > >> What about performance? Also you mentioned that sharing kmem-cache
> > > > >> between accounted and non-accounted can have additional overhead. Any
> > > > >> difference between SLAB and SLUB for such a case?    
> > > > > 
> > > > > Not really.
> > > > > 
> > > > > Sharing a single set of caches adds some overhead to root- and non-accounted
> > > > > allocations, which is something I've tried hard to avoid in my original version.
> > > > > But I have to admit, it allows to simplify and remove a lot of code, and here
> > > > > it's hard to argue with Johanness, who pushed on this design.
> > > > > 
> > > > > With performance testing it's not that easy, because it's not obvious what
> > > > > we wanna test. Obviously, per-object accounting is more expensive, and
> > > > > measuring something like 1000000 allocations and deallocations in a line from
> > > > > a single kmem_cache will show a regression. But in the real world the relative
> > > > > cost of allocations is usually low, and we can get some benefits from a smaller
> > > > > working set and from having shared kmem_cache objects cache hot.
> > > > > Not speaking about some extra memory and the fragmentation reduction.
> > > > > 
> > > > > We've done an extensive testing of the original version in Facebook production,
> > > > > and we haven't noticed any regressions so far. But I have to admit, we were
> > > > > using an original version with two sets of kmem_caches.
> > > > > 
> > > > > If you have any specific tests in mind, I can definitely run them. Or if you
> > > > > can help with the performance evaluation, I'll appreciate it a lot.    
> > > > 
> > > > Jesper provided some pointers here [1], it would be really great if you could
> > > > run at least those microbenchmarks. With mmtests it's the major question of
> > > > which subset/profiles to run, maybe the referenced commits provide some hints,
> > > > or maybe Mel could suggest what he used to evaluate SLAB vs SLUB not so long ago.
> > > > 
> > > > [1] https://lore.kernel.org/linux-mm/20200527103545.4348ac10@carbon/    
> > > 
> > > Oh, Jesper, I'm really sorry, somehow I missed your mail.
> > > Thank you, Vlastimil, for pointing at it.
> > > 
> > > I've got some results (slab_bulk_test01), but honestly I fail to interpret them.
> > > 
> > > I ran original vs patched with SLUB and SLAB, each test several times and picked
> > > 3 which looked most consistently. But it still looks very noisy.
> > > 
> > > I ran them on my desktop (8-core Ryzen 1700, 16 GB RAM, Fedora 32),
> > > it's 5.8-rc1 + slab controller v6 vs 5.8-rc1 (default config from Fedora 32).  
> > 
> > What about running these tests on the server level hardware, that you
> > intent to run this on?  
> 
> To give you an idea of the performance difference I ran the same test
> on a Broadwell Intel(R) Xeon(R) CPU E5-1650 v4 @ 3.60GHz.
> 
> The SLUB fastpath:
>  Type:kmem fastpath reuse Per elem: 60 cycles(tsc) 16.822 ns
> 
> 
> > > 
> > > How should I interpret this data?  
> > 
> > First of all these SLUB+SLAB microbenchmarks use object size 256 bytes,
> > because network stack alloc object of this size for SKBs/sk_buff (due
> > to cache-align as used size is 224 bytes). Checked SLUB: Each slab use
> > 2 pages (8192 bytes) and contain 32 object of size 256 (256*32=8192).
> > 
> >   The SLUB allocator have a per-CPU slab which speedup fast-reuse, in this
> > case up-to 32 objects. For SLUB the "fastpath reuse" test this behaviour,
> > and it serves as a baseline for optimal 1-object performance (where my bulk
> > API tries to beat that, which is possible even for 1-object due to knowing
> > bulk API cannot be used from IRQ context).
> > 
> > SLUB fastpath: 3 measurements reporting cycles(tsc)
> >  - SLUB-patched : fastpath reuse: 184 - 177 - 176  cycles(tsc)
> >  - SLUB-original: fastpath reuse: 178 - 153 - 156  cycles(tsc)
> > 
> 
> For your SLAB results:
> 
>  SLAB fastpath: 3 measurements reporting cycles(tsc)
>   - SLAB-patched : 161 - 160 - 163  cycles(tsc)
>   - SLAB-original: 174 - 170 - 159  cycles(tsc)
> 
> I find it strange that SLAB is slightly better than SLUB (in many
> measurements), because SLUB should have an advantage on this fast-path
> quick reuse due to the per-CPU slabs.  Maybe this is also related to
> the CPU arch you are using?
> 
> 
> > There are some stability concerns as you mention, but it seems pretty
> > consistently that patched version is slower. If you compile with
> > no-PREEMPT you can likely get more stable results (and remove a slight
> > overhead for SLUB fastpath).
> > 
> > The microbenchmark also measures the bulk-API, which is AFAIK only used
> > by network stack (and io_uring). I guess you shouldn't focus too much
> > on these bulk measurements. When bulk-API cross this objects per slab
> > threshold, or is unlucky is it use two per-CPU slab, then the
> > measurements can fluctuate a bit.
> > 
> > Your numbers for SLUB bulk-API:
> > 
> > SLUB-patched - bulk-API
> >  - SLUB-patched : bulk_quick_reuse objects=1 : 187 -  90 - 224  cycles(tsc)
> >  - SLUB-patched : bulk_quick_reuse objects=2 : 110 -  53 - 133  cycles(tsc)
> >  - SLUB-patched : bulk_quick_reuse objects=3 :  88 -  95 -  42  cycles(tsc)
> >  - SLUB-patched : bulk_quick_reuse objects=4 :  91 -  85 -  36  cycles(tsc)
> >  - SLUB-patched : bulk_quick_reuse objects=8 :  32 -  66 -  32  cycles(tsc)
> > 
> > SLUB-original -  bulk-API
> >  - SLUB-original: bulk_quick_reuse objects=1 :  87 -  87 - 142  cycles(tsc)
> >  - SLUB-original: bulk_quick_reuse objects=2 :  52 -  53 -  53  cycles(tsc)
> >  - SLUB-original: bulk_quick_reuse objects=3 :  42 -  42 -  91  cycles(tsc)
> >  - SLUB-original: bulk_quick_reuse objects=4 :  91 -  37 -  37  cycles(tsc)
> >  - SLUB-original: bulk_quick_reuse objects=8 :  31 -  79 -  76  cycles(tsc)
> 
> Your numbers for SLAB bulk-API:
> 
> SLAB-patched -  bulk-API
>  - SLAB-patched : bulk_quick_reuse objects=1 :  67 -  67 - 140  cycles(tsc)
>  - SLAB-patched : bulk_quick_reuse objects=2 :  55 -  46 -  46  cycles(tsc)
>  - SLAB-patched : bulk_quick_reuse objects=3 :  93 -  94 -  39  cycles(tsc)
>  - SLAB-patched : bulk_quick_reuse objects=4 :  35 -  88 -  85  cycles(tsc)
>  - SLAB-patched : bulk_quick_reuse objects=8 :  30 -  30 -  30  cycles(tsc)
> 
> SLAB-original-  bulk-API
>  - SLAB-original: bulk_quick_reuse objects=1 : 143 - 136 -  67  cycles(tsc)
>  - SLAB-original: bulk_quick_reuse objects=2 :  45 -  46 -  46  cycles(tsc)
>  - SLAB-original: bulk_quick_reuse objects=3 :  38 -  39 -  39  cycles(tsc)
>  - SLAB-original: bulk_quick_reuse objects=4 :  35 -  87 -  87  cycles(tsc)
>  - SLAB-original: bulk_quick_reuse objects=8 :  29 -  66 -  30  cycles(tsc)
> 
> In case of SLAB I expect the bulk-API to be slightly faster than SLUB,
> as the SLUB bulk code is much more advanced.

So again it looks like a patched version is only slightly worse if we're taking
the smallest number in each series. Is it a correct assumption?

Thanks!
