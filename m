Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E23C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1DD82173E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="bC38AaV2";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="gGYi6dPW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgHFXi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 19:38:27 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36208 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726071AbgHFXiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 19:38:22 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 076NZudU018128;
        Thu, 6 Aug 2020 16:38:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Axx3uzYJkcGLNIJwuepaIbiT+OCkIkYvvznDoJgrYnY=;
 b=bC38AaV2JnE05jtbnm1b4Wj4bBKS4FUERpv0rrzPuld9yUkpDLrO4jY+DsGSWOD8EepD
 s5QtxXFzX1QyPDXEFzAivpasI3nB/7nKGvKxR/j1HAUVVKiz3AnyB9ixMk6GOSmA1xoM
 JaSAK9+QAFQC0oypRJgx/1c6JqqNGHQ/B8M= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 32qy1yfufy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 06 Aug 2020 16:38:10 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 6 Aug 2020 16:38:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yg7nT/l7SYPV7CWHmw3TAdGYpIw/yaVxOjzpo9Bu7XByb16dGSgHqSOI1JkM0shWbahs8iaMVBZjhUvB3NR7VlW+gw0GvkqpykPel+AxvCk9d32ErN+7GPCAiqkE8hWFTSIjKtPyEfR7HRxiybKgFZxjTpGl59bcccLM3HT2Qa+yifwM8HQoGLtCFJojSrXPb2LsyoZftBA8ZWWFS+JAeFmqgFUtlrilhP+sCmwzfuQJf4yKMaT1wHaMqiiAUEe56R4F8Ipe6q7Bb/T6hvx3MbT3N9Ew86nbURX241noUU+K2ec3FkVtR5GuJD2lNdwBr3sILZG1i0mvk5wTNfZ07w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Axx3uzYJkcGLNIJwuepaIbiT+OCkIkYvvznDoJgrYnY=;
 b=odl4WqHqcGYNPVU1jX4/qn+MvveNmiyzZkZK6lBrxjSQk6NthJ56UxQzQ51cQlSxQJh5kqF6cH+EzU7A0s5KilGMGE8YCVntGQAwFJgAp3OaE9SGj6h+ekTem4CDs11GH1wqdoYz62RVmxV32U2vRWTOIHDr1yyGj6ZFO44fry1O9Wx3349v61CazaBhos9Zd0s7bduaaN/m+XafdTTSdfZNKxzwAUz11YXddJ/Egaudg6zpmER/m+2G3xdoFAHHnRTQABBtobulep77IPsXmRM869c9OY/7BLIAYu2oazvTQn4ynrJNBg9emJQd0V/X3fDc1Yeh+P+w0Aiv78UOnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Axx3uzYJkcGLNIJwuepaIbiT+OCkIkYvvznDoJgrYnY=;
 b=gGYi6dPWrd1dBDcqC1hpJnZ4BflAu4uRF7a/FdESp4oWYF6VU4Gigfeu6EuPrQabHtUtG0vpEzpkFqvgIeudQ2gQiXCtzX6RHxuUSjMVnQr02gHTZNvHasgiSAPbvnYTzBbQcg6ui2uQ5z9M+fSXmUZFjDk76cTzNYHE38VT3n0=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2760.namprd15.prod.outlook.com (2603:10b6:a03:159::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Thu, 6 Aug
 2020 23:38:07 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e%6]) with mapi id 15.20.3239.022; Thu, 6 Aug 2020
 23:38:07 +0000
Date:   Thu, 6 Aug 2020 16:38:04 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm: vmstat: fix /proc/sys/vm/stat_refresh generating
 false warnings
Message-ID: <20200806233804.GB1217906@carbon.dhcp.thefacebook.com>
References: <20200714173920.3319063-1-guro@fb.com>
 <alpine.LSU.2.11.2007291902340.6363@eggly.anvils>
 <20200730162348.GA679955@carbon.dhcp.thefacebook.com>
 <alpine.LSU.2.11.2007302018350.2410@eggly.anvils>
 <20200801011821.GA859734@carbon.dhcp.thefacebook.com>
 <alpine.LSU.2.11.2007311915130.9716@eggly.anvils>
 <20200804004012.GA1049259@carbon.dhcp.thefacebook.com>
 <alpine.LSU.2.11.2008051913580.8184@eggly.anvils>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2008051913580.8184@eggly.anvils>
X-ClientProxiedBy: BY5PR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:a03:180::23) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:9943) by BY5PR13CA0010.namprd13.prod.outlook.com (2603:10b6:a03:180::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.12 via Frontend Transport; Thu, 6 Aug 2020 23:38:07 +0000
X-Originating-IP: [2620:10d:c090:400::5:9943]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f503d457-0a53-44e8-83ff-08d83a61c5c3
X-MS-TrafficTypeDiagnostic: BYAPR15MB2760:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2760ACC62935F675A8C65666BE480@BYAPR15MB2760.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QEm2HpT4BQI+FgApLGYZd+fx6vORWBqA3c3WH+QiDQa11T5pWyJwD7IfGcZ665OdVq/5RzzCLKTVcJ4rIdS6DQWLEQI7uB5zF/r8br3FqjsWD2p+Bm9opqVjSfhEC29iqAwJfBG/tbkoY2sP6e5ygIYdFakOUy4haaaR/2tRFY+gGLoKIWkiPJb4ZvxyFTMblF7IW/qkAjDDl/UpKGNIPJLWT23Q8aVyIf20x27rRt9bObmmdp5BkpDSTRAhW8mIAkgiYIoNtaQ39Uq1UK/R/1QNvTdh3LlPVBE34cOdqlLEZ4tp7O3xRCIWw8pG0s0iredc7c+wQhu0J+8b9IAM5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(366004)(39860400002)(136003)(396003)(346002)(8676002)(316002)(8936002)(83380400001)(478600001)(66946007)(33656002)(66476007)(66556008)(4326008)(5660300002)(9686003)(6506007)(186003)(16526019)(6916009)(6666004)(55016002)(86362001)(1076003)(54906003)(2906002)(52116002)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: N5Fb+DSgIUtZM/U0z4qbin+e8YoR/99j8/3C3C64vzynDEMRuncOjc1DjrB7LpW2iUGGjGkOZ3wmpJfXoQ+cf/X/ZRCYRg8M1d5+9ry0t/s4grKxjcqhUDaW3YfvgSGofA9YhgczGzZoDYsoWec45pwhXlMsVwOVH6aUX7OkcSqLGGhya+Jkx4qelZndBaRZfdydHmSE5ZaKJ5MgjKY52XfLVg+koLBHLYpSEzCT9ZGNZ2I3ZFwSlMSyxkSwht+iMfGxE5L1ZlmhWmzxY+b2x/llnAzeT6+0qH64sKRcID9tPrA9/UkfpgFeNzjvjUSPklvdZQG06dKt4DlNGYZ9GvjxCgdoC+WfrhMx8YeAGixT8Z4KnqzBE5+8H+XDAusO6Bt55bnY5yEVSaAWo3xPF+Yok+zl9R3QIdpND1udqZ/Yzn5zJI11h2UjMCbrllc7kHRWgnWxmnY7x6p4UuRUkX4MugvGO/xmvP6OTMm1ftWJ+bnXHQQUhmGe6T1aSKvWftUDIEhrg6c8QG7CskhoifeiJAo4+XFJo3cKCK0GjmgRqbztN1uXPx6YxgMevl2tBSSq2nycvZw2Af3AIfpuauRhnE+Tw30XBu6QAGPi6I+aMfQ//psOVqVec6TaA3LwwrpRBlEcUmkPIlC9BZAbEBEjm/snANLtMytLJlrCqrE=
X-MS-Exchange-CrossTenant-Network-Message-Id: f503d457-0a53-44e8-83ff-08d83a61c5c3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2020 23:38:07.8198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XPINQ6CiyxmRHrvpENgBsT9VOFMamGlk3GxMr4Ew+IyvxKBwccvfk6tb2wwoDe0k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2760
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-06_17:2020-08-06,2020-08-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 suspectscore=5 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0
 adultscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008060152
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Aug 05, 2020 at 08:01:33PM -0700, Hugh Dickins wrote:
> On Mon, 3 Aug 2020, Roman Gushchin wrote:
> > On Fri, Jul 31, 2020 at 07:17:05PM -0700, Hugh Dickins wrote:
> > > On Fri, 31 Jul 2020, Roman Gushchin wrote:
> > > > On Thu, Jul 30, 2020 at 09:06:55PM -0700, Hugh Dickins wrote:
> > > > > 
> > > > > Though another alternative did occur to me overnight: we could
> > > > > scrap the logged warning, and show "nr_whatever -53" as output
> > > > > from /proc/sys/vm/stat_refresh: that too would be acceptable
> > > > > to me, and you redirect to /dev/null.
> > > > 
> > > > It sounds like a good idea to me. Do you want me to prepare a patch?
> > > 
> > > Yes, if you like that one best, please do prepare a patch - thanks!
> > 
> > Hi Hugh,
> > 
> > I mastered a patch (attached below), but honestly I can't say I like it.
> > The resulting interface is confusing: we don't generally use sysctls to
> > print debug data and/or warnings.
> 
> Since you confessed to not liking it yourself, I paid it very little
> attention.  Yes, when I made that suggestion, I wasn't really thinking
> of how stat_refresh is a /proc/sys/vm sysctl thing; and I'm not at all
> sure how issuing output from a /proc file intended for input works out
> (perhaps there are plenty of good examples, and you followed one, but
> it smells fishy to me now).
> 
> > 
> > I thought about treating a write to this sysctls as setting the threshold,
> > so that "echo 0 > /proc/sys/vm/stat_refresh" would warn on all negative
> > entries, and "cat /proc/sys/vm/stat_refresh" would use the default threshold
> > as in my patch. But this breaks  to some extent the current ABI, as passing
> > an incorrect value will result in -EINVAL instead of passing (as now).
> 
> I expect we could handle that well enough, by more lenient validation
> of the input; though my comment above on output versus input sheds doubt.
> 
> > 
> > Overall I still think we shouldn't warn on any values inside the possible
> > range, as it's not an indication of any kind of error. The only reason
> > why we see some values going negative and some not, is that some of them
> > are updated more frequently than others, and some are bouncing around
> > zero, while other can't reach zero too easily (like the number of free pages).
> 
> We continue to disagree on that (and it amuses me that you who are so
> sure they can be ignored, cannot ignore them; whereas I who am so curious
> to investigate them, have not actually found the time to do so in years).
> It was looking as if nothing could satisfy us both, but...
> 
> > 
> > Actually, if someone wants to ensure that numbers are accurate,
> > we have to temporarily set the threshold to 0, then flush the percpu data
> > and only then check atomics. In the current design flushing percpu data
> > matters for only slowly updated counters, as all others will run away while
> > we're waiting for the flush. So if we're targeting some slowly updating
> > counters, maybe we should warn only on them being negative, Idk.
> 
> I was going to look into that angle, though it would probably add a little
> unjustifiable overhead to fast paths, and be rejected on that basis.
> 
> But in going to do so, came up against an earlier comment of yours, of
> which I had misunderstood the significance. I had said and you replied:
> 
> > > nr_zone_write_pending: yes, I've looked at our machines, and see that
> > > showing up for us too (-49 was the worst I saw).  Not at all common,
> > > but seen.  And not followed by increasingly worse numbers, so a state
> > > that corrects itself.  nr_dirty too (fewer instances, bigger numbers);
> > > but never nr_writeback, which you'd expect to go along with those.
> > 
> > NR_DIRTY and NR_WRITEBACK are node counters, so we don't check them?
> 
> Wow. Now I see what you were pointing out: when v4.8's 75ef71840539
> ("mm, vmstat: add infrastructure for per-node vmstats") went in, it
> missed updating vmstat_refresh() to check all the NR_VM_NODE_STAT items.
> 
> And I've never noticed, and have interpreted its silence on those items
> as meaning they're all good (and the nr_dirty ones I mentioned above,
> must have been from residual old kernels, hence the fewer instances).
> I see the particularly tricky NR_ISOLATED ones are in that category.
> Maybe they are all good, but I have been mistaken.
> 
> I shall certainly want to reintroduce those stats to checking for
> negatives, even if it's in a patch that never earns your approval,
> and just ends up kept internal for debugging.  But equally certainly,
> I must not suddenly reintroduce that checking without gaining some
> experience of it (and perhaps getting as irritated as you by more
> transient negatives).
> 
> I said earlier that I'd prefer you to rip out all that checking for
> negatives, rather than retaining it with the uselessly over-generous
> 125 * nr_cpus leeway.  Please, Roman, would you send Andrew a patch
> doing that, to replace the patch in this thread?  Or if you prefer,
> I can do so.

Hi Andrew,

it seems that Hugh and me haven't reached a consensus here.
Can, you, please, not merge this patch into 5.9, so we would have
more time to find a solution, acceptable for all?

Thank you!

Roman
