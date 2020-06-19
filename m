Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A76C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 01:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C670207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 01:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="VLQsNd6R";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="lDDrnKta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbgFSB1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 21:27:34 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:6614 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730200AbgFSB1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 21:27:33 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05J1NNDG025198;
        Thu, 18 Jun 2020 18:27:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=I5yqXiJT7ynEIa9KdYK/a0q5MKrIYwKKIaJUprj65Wg=;
 b=VLQsNd6REM1Cgal/RUjT09fpQgLFx+F7fwnZFHAOvOQvWOIIIz7fJDWxrkAeqAvIoi0G
 ap/BbGPIXqMcrhUCWXSD8ejIQSNvcik595GtEVaxA8kvZlXvMEYPVuXkkKOmc7GDLlYr
 4zNMtKZ+ws29fQesOo5iqZKu0PfJ7Gps7/U= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31q8u6px2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Jun 2020 18:27:17 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Jun 2020 18:27:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxnZfhOScMTYwDgiFjMuOImn27rwfKemqTLPJtG3v9f2AoTq5cDJtY/tZ4Tq79MC6LIbeBgVZFGkdRJxfw0SqNLcCO5mhWuEiWlyt04y5vYJ4PEslwC13kHGoysTX4w5imshrdxu9c8xlfV0nyehKFSft3M1QAgZ7k2CB/PAcEA22XdZUNljmlL0cY2x7j3xzM9HfvAha+9CtISS2FNtB4csBzitHL948oDpYd3idtWsNr/m1SKWzrF3u74klcRUjuzrjPsQCNSfx/3lPgRIbE5DObogJrUmgIpKIjtq3ktLdwA16zOd9PoPkHh7hZuAAegtd2RqC5L90DYzCjG89w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5yqXiJT7ynEIa9KdYK/a0q5MKrIYwKKIaJUprj65Wg=;
 b=Oz9uDGZ2IezMF5SUuMKvcf2M0In/5fGAeBFf74OK6yW4Vm8IYOBtBw8+B26qxe2TD1XFF9+2R9LHIU464dCT6hwvDGnD5iK1PO+L7PjMVcPV2hfHjiTIUnPP5slHH8dFu9t+vMabBXgB9GHLz36BReQUpOKm5CRJgx1nxd1K9ryiATdqMZ9tRChMByv3kIi0YqGlvxWGgPV3xnOQzxo4noXbzOUbuqxtvfCKTQf9qEEdR6Ur00GnXG9A4TbFWyRnxkWzW4uk6TEWL9n+0Zll/3JVAliYjHoth0oNOqrnvUi8Ei97GzgpRHkRQ3uMyLuv7/ZYRfiQL/jYy5hiO6XgJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5yqXiJT7ynEIa9KdYK/a0q5MKrIYwKKIaJUprj65Wg=;
 b=lDDrnKtazekH7oln4HeFIVrVsaEMm/L6OMBDhY1VOlBsHRt9SrfrYUAyt18rIMpcoqXvvTm2LrzMIbvNPe8g9AMIfH3ZPefELFQZpF89dcVpN3lOyDSgez68aU+38IXnAiSkghCIbg8w05TrjQl1Igq04QCas4eNAEuEqA3zInk=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2936.namprd15.prod.outlook.com (2603:10b6:a03:f9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.24; Fri, 19 Jun
 2020 01:27:15 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 01:27:15 +0000
Date:   Thu, 18 Jun 2020 18:27:12 -0700
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
Message-ID: <20200619012712.GD135965@carbon.dhcp.thefacebook.com>
References: <20200608230654.828134-1-guro@fb.com>
 <CALvZod7ThL=yMwxzCLvrTtq=+Dr5ooUSX-iFP8AhiAGURByFBA@mail.gmail.com>
 <20200617024147.GA10812@carbon.lan>
 <CALvZod4vLQb4kns=ao8btL_g--9axZfcaxhMnj+CoTrCkyWoWQ@mail.gmail.com>
 <20200617033217.GE10812@carbon.lan>
 <e510e964-2703-d123-120c-816bbdd35743@suse.cz>
 <20200618012928.GD24694@carbon.DHCP.thefacebook.com>
 <20200618104344.6a96ac04@carbon>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618104344.6a96ac04@carbon>
X-ClientProxiedBy: BYAPR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::32) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:32ff) by BYAPR03CA0019.namprd03.prod.outlook.com (2603:10b6:a02:a8::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 01:27:14 +0000
X-Originating-IP: [2620:10d:c090:400::5:32ff]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f5f1cfb-ae4e-4e78-5de1-08d813efe634
X-MS-TrafficTypeDiagnostic: BYAPR15MB2936:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB293652C5A58AF51C38223AB7BE980@BYAPR15MB2936.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o1O0aVixV68/n62WPR+W3h2+ACZf5JPejidjSrtd1e+2cU6ag9LTdPpgXWriVOu2erHjETjvBACjhyuDrmudvfXX6jnsYBfgJBfFhwn5KDFp81Vx/SUHMeWgmUATcxsc1mDwNJNk+OzCav9Fx6v3GDPk6TrKn6R7EeN+C3uxMzR0InDBoe3FW5DqkXRrIQvWxhqtLes4jhuuBt2pSViUuel2P0S7o75V6ZJShHna2f1EcCFcVogS3httFnh5puRt2FQOhwkWtVrPj5EqoBmV1w06ImbfcG221mK+hqIYEi3jIVGeHG4UNUixeDzgJyhVIiAcmgzf0IF9G3ATAwJ9cJCePYprphssfJpBK5hNasOu2SdRZ7lrFV1/GVUwa0wY9KaStgyJoubb42vQXzM/VQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(396003)(346002)(366004)(136003)(376002)(316002)(186003)(33656002)(8676002)(5660300002)(7416002)(4326008)(966005)(6916009)(16526019)(55016002)(6506007)(83380400001)(53546011)(1076003)(52116002)(478600001)(7696005)(9686003)(54906003)(66476007)(8936002)(66946007)(86362001)(2906002)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: bX3F6o0azGJLFg0FG3gBZsoJlBekuzx387bP3v+Spmj1b6BHlniPtl8IafVxXjArBbYR+m46Kx0s1NtSdefr6Dk9P6UPJ4jn9OQLxoW/Y0Kqg5DkY6mT/KMAnaoKRzCUWNO4wXfInAWeSU3LTEATOrAAVHZLDOTa5959iQeSrNe38IDNWtWmrL6pbuTQKyRSeCCq46s1lYyWJeZmMLGqsgvCVpSvUKi/WizpZ6HvE1J7UtWBOgGA9eUjWmGc/bAniYGzB0RPkTZOcRCM2o0srKpkrU1ePvhYqfVlZ4pZVmHH0ylVWsG/ik79yviFoW4h+CFpdXFNFg5vBIyVQQg2eojiQE7kS81ft4jWZlyMJDjEx8hPBKN4jqEyEo3CTtpxNWm1YwFwy4c0Ugps8OGibvptgUC1AM26Vz7TyB/JX5LWXjL2ItIJBvjQpy6tW1PRXk2shDxe+Um2FNsINL/DK7bkqWoB7G/ydBPB6Kp9PIDelNq8SdUh2CnohzHOUYEQN3jkviiJy8Kckfbpyl16eA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5f1cfb-ae4e-4e78-5de1-08d813efe634
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 01:27:15.6117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +8ut/cBSzPL6Hg6eqV74yv6yAXItfNraS/1AP2AFq5BsuyV3Dn/VFVVhvuXNAm5t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2936
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_21:2020-06-18,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 cotscore=-2147483648 malwarescore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190007
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 10:43:44AM +0200, Jesper Dangaard Brouer wrote:
> On Wed, 17 Jun 2020 18:29:28 -0700
> Roman Gushchin <guro@fb.com> wrote:
> 
> > On Wed, Jun 17, 2020 at 01:24:21PM +0200, Vlastimil Babka wrote:
> > > On 6/17/20 5:32 AM, Roman Gushchin wrote:  
> > > > On Tue, Jun 16, 2020 at 08:05:39PM -0700, Shakeel Butt wrote:  
> > > >> On Tue, Jun 16, 2020 at 7:41 PM Roman Gushchin <guro@fb.com> wrote:  
> > > >> >
> > > >> > On Tue, Jun 16, 2020 at 06:46:56PM -0700, Shakeel Butt wrote:  
> > > >> > > On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:  
> > > >> > > >  
> > > >> [...]  
> > > >> > >
> > > >> > > Have you performed any [perf] testing on SLAB with this patchset?  
> > > >> >
> > > >> > The accounting part is the same for SLAB and SLUB, so there should be no
> > > >> > significant difference. I've checked that it compiles, boots and passes
> > > >> > kselftests. And that memory savings are there.
> > > >> >  
> > > >> 
> > > >> What about performance? Also you mentioned that sharing kmem-cache
> > > >> between accounted and non-accounted can have additional overhead. Any
> > > >> difference between SLAB and SLUB for such a case?  
> > > > 
> > > > Not really.
> > > > 
> > > > Sharing a single set of caches adds some overhead to root- and non-accounted
> > > > allocations, which is something I've tried hard to avoid in my original version.
> > > > But I have to admit, it allows to simplify and remove a lot of code, and here
> > > > it's hard to argue with Johanness, who pushed on this design.
> > > > 
> > > > With performance testing it's not that easy, because it's not obvious what
> > > > we wanna test. Obviously, per-object accounting is more expensive, and
> > > > measuring something like 1000000 allocations and deallocations in a line from
> > > > a single kmem_cache will show a regression. But in the real world the relative
> > > > cost of allocations is usually low, and we can get some benefits from a smaller
> > > > working set and from having shared kmem_cache objects cache hot.
> > > > Not speaking about some extra memory and the fragmentation reduction.
> > > > 
> > > > We've done an extensive testing of the original version in Facebook production,
> > > > and we haven't noticed any regressions so far. But I have to admit, we were
> > > > using an original version with two sets of kmem_caches.
> > > > 
> > > > If you have any specific tests in mind, I can definitely run them. Or if you
> > > > can help with the performance evaluation, I'll appreciate it a lot.  
> > > 
> > > Jesper provided some pointers here [1], it would be really great if you could
> > > run at least those microbenchmarks. With mmtests it's the major question of
> > > which subset/profiles to run, maybe the referenced commits provide some hints,
> > > or maybe Mel could suggest what he used to evaluate SLAB vs SLUB not so long ago.
> > > 
> > > [1] https://lore.kernel.org/linux-mm/20200527103545.4348ac10@carbon/  
> > 
> > Oh, Jesper, I'm really sorry, somehow I missed your mail.
> > Thank you, Vlastimil, for pointing at it.
> > 
> > I've got some results (slab_bulk_test01), but honestly I fail to interpret them.
> > 
> > I ran original vs patched with SLUB and SLAB, each test several times and picked
> > 3 which looked most consistently. But it still looks very noisy.
> > 
> > I ran them on my desktop (8-core Ryzen 1700, 16 GB RAM, Fedora 32),
> > it's 5.8-rc1 + slab controller v6 vs 5.8-rc1 (default config from Fedora 32).
> 
> What about running these tests on the server level hardware, that you
> intent to run this on?

I'm going to backport this version to the kernel version we're using internally
and will come up with more number soon.

> 
> > 
> > How should I interpret this data?
> 
> First of all these SLUB+SLAB microbenchmarks use object size 256 bytes,
> because network stack alloc object of this size for SKBs/sk_buff (due
> to cache-align as used size is 224 bytes). Checked SLUB: Each slab use
> 2 pages (8192 bytes) and contain 32 object of size 256 (256*32=8192).
> 
>   The SLUB allocator have a per-CPU slab which speedup fast-reuse, in this
> case up-to 32 objects. For SLUB the "fastpath reuse" test this behaviour,
> and it serves as a baseline for optimal 1-object performance (where my bulk
> API tries to beat that, which is possible even for 1-object due to knowing
> bulk API cannot be used from IRQ context).
> 
> SLUB fastpath: 3 measurements reporting cycles(tsc)
>  - SLUB-patched : fastpath reuse: 184 - 177 - 176  cycles(tsc)
>  - SLUB-original: fastpath reuse: 178 - 153 - 156  cycles(tsc)
> 
> There are some stability concerns as you mention, but it seems pretty
> consistently that patched version is slower. If you compile with
> no-PREEMPT you can likely get more stable results (and remove a slight
> overhead for SLUB fastpath).
> 
> The microbenchmark also measures the bulk-API, which is AFAIK only used
> by network stack (and io_uring). I guess you shouldn't focus too much
> on these bulk measurements. When bulk-API cross this objects per slab
> threshold, or is unlucky is it use two per-CPU slab, then the
> measurements can fluctuate a bit.
> 
> Your numbers for SLUB bulk-API:
> 
> SLUB-patched - bulk-API
>  - SLUB-patched : bulk_quick_reuse objects=1 : 187 -  90 - 224  cycles(tsc)
>  - SLUB-patched : bulk_quick_reuse objects=2 : 110 -  53 - 133  cycles(tsc)
>  - SLUB-patched : bulk_quick_reuse objects=3 :  88 -  95 -  42  cycles(tsc)
>  - SLUB-patched : bulk_quick_reuse objects=4 :  91 -  85 -  36  cycles(tsc)
>  - SLUB-patched : bulk_quick_reuse objects=8 :  32 -  66 -  32  cycles(tsc)
> 
> SLUB-original -  bulk-API
>  - SLUB-original: bulk_quick_reuse objects=1 :  87 -  87 - 142  cycles(tsc)
>  - SLUB-original: bulk_quick_reuse objects=2 :  52 -  53 -  53  cycles(tsc)
>  - SLUB-original: bulk_quick_reuse objects=3 :  42 -  42 -  91  cycles(tsc)
>  - SLUB-original: bulk_quick_reuse objects=4 :  91 -  37 -  37  cycles(tsc)
>  - SLUB-original: bulk_quick_reuse objects=8 :  31 -  79 -  76  cycles(tsc)
> 
> Maybe it is just noise or instability in measurements, but it seem that the
> 1-object case is consistently slower in your patched version.
> 
> Mail is too long now... I'll take a look at your SLAB results and followup.


Thank you very much for helping with the analysis!

So does it mean you're looking at the smallest number in each series?
If so, the difference is not that big?

Theoretically speaking it should get worse (especially for non-root allocations),
but if the difference is not big, it still should be better, because there is
a big expected win from memory savings/smaller working set/less fragmentation etc.

The only thing I'm slightly worried is what's the effect on root allocations
if we're sharing slab caches between root- and non-root allocations. Because if
someone depends so much on the allocation speed, memcg-based accounting can be
ignored anyway. For most users the cost of allocation is negligible.
That's why the patch which merges root- and memcg slab caches is put on top
and can be reverted if somebody will complain.

Thank you!
