Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F33DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 03:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9F2020792
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 03:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="FshJDK4a";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="W4MFEmHm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgHFDwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 23:52:00 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41254 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726026AbgHFDv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 23:51:57 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0763nr87001015;
        Wed, 5 Aug 2020 20:51:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=s9Fd9xVoO++rO/fqckEB+6kkrT0EtClZqyn672YFtFM=;
 b=FshJDK4aTYzDccOvacQPsyhdZaczIkaZcTbZulq2szC/rOO2HwIu+9lBvAsPNkoEcV4G
 7l8EWo1rTulD/TVhS/FbRmHiyxaXD9zAlUppMDCiBj01/e6QOmonvgP9llxEwB1qzfEX
 cpwscaixFCXFkbWJAfYgrjEgZqXRUdbCtB0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32qhjexe4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 05 Aug 2020 20:51:46 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 5 Aug 2020 20:51:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWu4demAyekdEjC1dihhL5nNoD8b5/1wZMdy3OjOYrNsXEOLfcNgp7IRa/tU/yCrcylLm9cK4sxEEec/4Ss2pA5XjHCqviExL/kbaz2Vjpm3QAASuK3oW22dQEN/CQ3dT/2ncYlAolc0Rmz5NXzAI81peGxr692ckHJAkO1y72yB56EVQlspvV/qbBs1xBvHMgX2QmfbZ3IzWQKl7q8x6wgorWEPh+SVFLnuQaOGpJ+FFvZBu7cMNzUOOOKAtqswH3xUK14hD/j72LjDvAYo6lbu/eQUvVWGRWrTfOyl/JI+4tPpEeHjtL/41F38ZiYVEEQztsKn0O/4dT0sphV8bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9Fd9xVoO++rO/fqckEB+6kkrT0EtClZqyn672YFtFM=;
 b=LF4oPddwJakxX8J6UfufmCxpaqkbTo08SKBc7BiHFtcpH5huAa11ZxmMZDO1wDLt1QMcXIv6H474O8IP2Az7IEH2O6QJPkYxSqKH07eXYMUObfSxNhvvIdQlzLmPvwjhc+/iq3o9Z9QQK99spCx5OY4ed8lBYNx6y78VwD6XQq1+YH0z+6Gk5QZsDWY+WMKhYSdWghCupBr6D3ENJfQpLuKC74tS+tqRMSU6F0fhG9O60m7IpjMAFbmVfPQE0sekbrlTxBbwmmSVTkc3FfHUSeJY4YGZwD+x9pjE2rNTAv7bWDg9GjG+RjvElPIAEgSD4pyBi2ux0whoNPvar2shig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9Fd9xVoO++rO/fqckEB+6kkrT0EtClZqyn672YFtFM=;
 b=W4MFEmHmbfaXbG7+jOpJWiDrPKqGYHUoJeU7z5k+6IotTlnuyY3oT6uQwJp75EHw4VuVEetkgZu2b0D5GnN4MAja4QbfZ2po+uGnUCKoexJkCyU6bEcBArWEt75FtPRr9QYS6I6t9TI5wBbpL9aHE+alZldbz39epxXti8O/Ohg=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2504.namprd15.prod.outlook.com (2603:10b6:a02:8e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.21; Thu, 6 Aug
 2020 03:51:44 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e%6]) with mapi id 15.20.3239.022; Thu, 6 Aug 2020
 03:51:43 +0000
Date:   Wed, 5 Aug 2020 20:51:40 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Hugh Dickins <hughd@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm: vmstat: fix /proc/sys/vm/stat_refresh generating
 false warnings
Message-ID: <20200806035140.GA1162560@carbon.dhcp.thefacebook.com>
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
X-ClientProxiedBy: BYAPR08CA0009.namprd08.prod.outlook.com
 (2603:10b6:a03:100::22) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:8583) by BYAPR08CA0009.namprd08.prod.outlook.com (2603:10b6:a03:100::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19 via Frontend Transport; Thu, 6 Aug 2020 03:51:42 +0000
X-Originating-IP: [2620:10d:c090:400::5:8583]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2c00e7a-7752-4fd1-17a8-08d839bc088e
X-MS-TrafficTypeDiagnostic: BYAPR15MB2504:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB250414ACDE17137ED7A949DDBE480@BYAPR15MB2504.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EzCb9CtLOnNxedxwuo4ckYdEZEFBcZiRb9GdJVGe4QNBWuW4ilWyPbCxQmzEMaLnaT2Pp+6wzxdH0jPOLkWUHHIE/wIhdWFU9NorhEfLpC31IAXLrjzL+9efBB+grvOI6LVyA+QEbjhNavEkuo+LRcp+0XamQKroRoHbwNza0JKKYsu1Ru0m4s38e19am4eKBhqR/FMKBqSNtPueUOZ+f6eZJONy2H5L10Z+9tW3EhlR/8wFdktiCsBL9vFMLkrEClC2l9R7XjY6z5H92UVgGDt2AglO+IeW1aYtVyXjo6duI5kw76OKMGZeF02Z6BoK1iMhOZ9emHOl7Ftvi0wS/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(366004)(396003)(136003)(39860400002)(376002)(6506007)(9686003)(4326008)(55016002)(2906002)(83380400001)(316002)(5660300002)(86362001)(1076003)(66946007)(52116002)(66476007)(66556008)(54906003)(16526019)(186003)(33656002)(8936002)(8676002)(6916009)(7696005)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: KSdmPzvKWoajmJMMg6txj4CR5SnNbElEV3ho+C4/A0Cnr7XM8SohrgZOg77liyD3Cs+eZwnDlv2pkhJCZa+kxchygnS2ZsjxM7FrZwK1hXqxyPo/7NQ9LM4ZTcdkMjCpXq/xHf4wf/tWCLxKKXGRMI4GwCnm9nmuPCpwbEnMngIwtGRY2Nw6F1F9OC4pLBw3knKN/zmHFGaMf4s4JleM+OZYGanKiclbzQN4cVyTRSWLi+6pShnYiaSxSU8TFvIO/kNwxgs/g+Kky5MrYKAGS4pwV32LferOpavw7dUH9bikDgSNDTWkz5QmBvHnkN8zH5Iot3iOAO7uZ50fR7yvPXUkz8Bpj4ZfixiEi1a/VM1SaDA95CpJhXJnvF99aIyo+CnibIU3uiTzyIyeZwQ+5iTlQCbXgpD40u4OpZDkN9Re8TzMLAleCNSJ78vBc8Dou9M4gR5cZAun/gz5JmHHL4tn+wDn+F7K+FDJjkqYY5D3dZtQIN9F0dgGmhkCdBZMATaeORXwQuezdt6H72ZhTaCj4WOBgjcSfUk9W7mmaZO8A/2GXygD1Or+Saw2B0AZUX2X9a514ONjCzzUDZDDpa1NSP+ljZcZNcMJc3Cv7uv7N+e7JN3OcUMwawTwuOL8JjP1cW5mzc5dmXd0fT5PtgdAcAnF+UVsiGthS5MK4as=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c00e7a-7752-4fd1-17a8-08d839bc088e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2020 03:51:43.9466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WbCccYXCErilEejTuHYClJN5OpdmCe+NnkSY0tL3sD14FMrDGewz/8zJpchUPWGD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2504
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-05_18:2020-08-03,2020-08-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 suspectscore=5
 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008060026
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

I can only repeat my understanding here: with the current implementation
the measured number can vary in range of
  (true_value - zone_threshold * NR_CPUS,
   true_value + zone_threshold * NR_CPUS).
zone_threshold depends on the size of a zone and the number of CPUs,
but cannot exceed 125.

Of course, most likely measured numbers are mostly distributed somewhere
close to the real number, and reaching distant ends of this range is
unlikely. But it's a question of probability.

So if the true value is close to 0, there are high chances of getting
negative measured numbers. The bigger is the value, the lower are these
chances. And if it's bigger than the maximal drift, these chances are 0.

So we can be sure that a measured value can't go negative only if we know
for sure that the true number is bigger than zone_threshold * NR_CPUS.

You can, probably, say that if the chances of getting a negative value
are really really low, it's better to spawn a warning, rather than miss
a potential error. I'd happily agree, if we'd have a nice formula
to calculate the tolerance by the given probability. But if we'll treat
all negative numbers as warnings, we'll just end with a lot of false
warnings.

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

I'd expect it. What I think can be acceptable is to have different tolerance
for different counters, if there is a good reason to have more precise values
for some counters.
I did a similar thing in the "new slab controller" patchset for memcg
slab statistics, which required a different threshold because they are measured
in bytes (all other metrics were historically in pages).

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

Sure, I can do it. But can you, please, explain why you want them to be
eliminated? Is this because they will never fire, you think?

In my humble opinion they might be quite useful: any systematic under- or
overflow will eventually trigger this warning, and we'll know for sure that
something is wrong. So I'd add a similar check for node counters without
any hesitation.

I wouldn't oppose such a patch anyway, just want to make sure we are
on the same page here.

Thanks!
