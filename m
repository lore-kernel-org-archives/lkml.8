Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFEFC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 01:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7E012083B
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 01:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="XeCP1FVS";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="c/zW+SQ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgHABSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 21:18:41 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58436 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726535AbgHABSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 21:18:40 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07113Yrg011296;
        Fri, 31 Jul 2020 18:18:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=cz0TDT3xWmp9vaqAaxhOg54weg57kGnyv9nOrf/jfTA=;
 b=XeCP1FVSe54Ha1vUfTkbX+qY5wsu7okeu49kEFINzagjQmlvRIpvqnItvKspHcB9icAh
 Zoh0XILDgFmYYIVusRIp1Y6Ks0RYP6MkGF12dbj8uvO7FPHt9O2biq7f49hdICoJU2/w
 lG4vuMmTd6IGxGDUhevk16/aEfOWZCG3jFs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32m01crcc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 31 Jul 2020 18:18:28 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 31 Jul 2020 18:18:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ql0OYd5wdxLDKJ6s0y4ZdN+9LO9m/n5kzw6UDqxeJnuiusGb7Y+1xvkCdHfNDBPkVlJR/GnqBNQHonymirG0/uHSRKwytl4Bocca/OxBdduc+FKcwmrLYxJvlK4zrpn3HtwYaU64LrjLhfBbrCN7bubIoxDfJ0SLeg/2h+/eop5Inzq2XnmruSDLnvBdUqugtclP0Lqyr6FVhZdV0S6WhQqRhYfnYrfFYcNHSftPVXD3++htRtRm9kLJir2+5SVp5mXHcJ53Muzy8KBm27HqHP8SAl0vEC+9U+csVrPSx//+qBBw0yuPQ4U8EhEb38a/0DuhYaLfoZ5c2cKEpBFnrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cz0TDT3xWmp9vaqAaxhOg54weg57kGnyv9nOrf/jfTA=;
 b=m9Tgcl1i5Sb2QTPeEwpvyHi7Lw0KdB7EKJycF7KCE0mGDBgOzE8bz+6fQR6svooUbK//IUyA2GZSqMQVa6/s1e66MjgQysi1+G/tYlrXLXuYtHRjbRlK8EULEdaUWIoO3aAqJ/cG5zRMyqcFtD6m9iTREgtHx0RT0HTB1ntRMASFaYWQ1RoKBlSBXMPwGaWcB9SIZ4V9Nko4D5NBVF/qqcDm5wnHj27q0d6PLnOITC5ROb3w99+UKungzSnw0WXypZ0kr18dYaXdtCv27PaWUa8Efyr7oNy5kLvQyZnkr3RptniQGSsltKCuUPfIYxC1G1zvmUMVnxM+GylOG/7bzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cz0TDT3xWmp9vaqAaxhOg54weg57kGnyv9nOrf/jfTA=;
 b=c/zW+SQ5HlDzIdy9qyNzE/P1MEJwMH/yngGnc5hCzem0boNSEyQzWcPE/fPTzNwMx3VaojLZHW2x7+q3HwDzLpVkm3GTRSzlAo2c6Gln/iADJHzm6lQ0ZqFhf8AWQ/DMbhH78SZzn0jTiTktBeXcdLPliwA5ayVy22/fh8nUzYc=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2936.namprd15.prod.outlook.com (2603:10b6:a03:f9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.19; Sat, 1 Aug
 2020 01:18:24 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e%6]) with mapi id 15.20.3239.017; Sat, 1 Aug 2020
 01:18:24 +0000
Date:   Fri, 31 Jul 2020 18:18:21 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Hugh Dickins <hughd@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm: vmstat: fix /proc/sys/vm/stat_refresh generating
 false warnings
Message-ID: <20200801011821.GA859734@carbon.dhcp.thefacebook.com>
References: <20200714173920.3319063-1-guro@fb.com>
 <alpine.LSU.2.11.2007291902340.6363@eggly.anvils>
 <20200730162348.GA679955@carbon.dhcp.thefacebook.com>
 <alpine.LSU.2.11.2007302018350.2410@eggly.anvils>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2007302018350.2410@eggly.anvils>
X-ClientProxiedBy: BY3PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:a03:254::35) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:562c) by BY3PR05CA0030.namprd05.prod.outlook.com (2603:10b6:a03:254::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.9 via Frontend Transport; Sat, 1 Aug 2020 01:18:23 +0000
X-Originating-IP: [2620:10d:c090:400::5:562c]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d421d02-beca-448a-2418-08d835b8c941
X-MS-TrafficTypeDiagnostic: BYAPR15MB2936:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB29362FE7E1AD73CE4D1C04EEBE4F0@BYAPR15MB2936.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GtkPtSXgP5zdr6AQD58y2VMKg4t/8cEQeJjDezAh1jgYBTQjtvDvGW9JJP3OsR23cJSPDd4U4UCWiAu5KTvsmGKtZnHerUtsf/5pmdf5G0xyyv+3wLlqoj+5MHbspEtRBOPmeVG5Vq75sfAXnRYF4UhA0u/y+2HRYBfWN749B/P34jD9t62guZ48ZyMIph1EsY0j1dza28mGS3tTE1uIxrryjz+xeiagFJJhAqYRHagpnYwKxuKss6mEe6SaC5qWZZTEfLf1LXnmEF7qPHYbPzpXsVr3PnNuTYvycJaqGEZG1Ba2+ktB/OSIVRtApkJHkePyI0L7oZDSfb/uxU9Niw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(39860400002)(346002)(396003)(376002)(136003)(2906002)(186003)(6506007)(86362001)(66476007)(83380400001)(1076003)(7696005)(16526019)(52116002)(8936002)(66946007)(33656002)(8676002)(4326008)(66556008)(6916009)(9686003)(5660300002)(55016002)(54906003)(478600001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 4vWe4MxczjAogj4bHhd5NaL/6a7KD4XY7VRe2YT/BiZ+8SSSVte8YazqWloeVE5BTxImJ/J3KSZp8fPQ1DD4oiPj4n2YnrTgZpUG1NU/iziEDtoJj7a1ge5MoA6eq7YxMPaDXfQyYzm5i1Mlalcju89RK88WyBaRDxGTniTShyU2SPNNFrjUhPYKTdN86+QFIRNdzMwUaSizdEvtrVXoUzH16ALCJ9D3ut8bZ6JMk9kxZK290czp8RjHf6EoiDu+/rSfooOC4wRhTRDfxqfssgKPR4gRfDZTd9w5+dhla28lFFhB/040V9GTBDH7wyfCQTU491MiON8P/qW5/Pks42epZZr0aLys+L1u1iN7sf0bsTsc4isPWnnT8aEJ/K3Ka6N99QjaD62U27pkedTis5f+HK7vRObNT8bEgHJxgaaUSAZDz4rS/WFggCjkKSbCpzcvH2EjyGlrdMN3zc78zkT6sZeCY7snd8yQh6DmaTiwsHstDMuIe+mLRxRd4cbwGeV691oqGlPf1+QuNbqbqT/QB3Of+HAZ5N8tvFXbzfzDHBJ4wsqyd1KK9vIvLz1BbVIYvZhmdRgNui7BtQyTBev39L25C8glmW5L8hqJQQM/WiyZaB6jO0wKonMC9Dby/dYmC/6rI9QDbygfNUb3cmf3aDpimYo47Cf9vDFOdJ0=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d421d02-beca-448a-2418-08d835b8c941
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2020 01:18:24.3077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iOAbYSdbS0vsJcG3prVk/Worb/d/hVFJbYP+AgsLCyhc0yx17JOavrXVcUH8qXag
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2936
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-31_09:2020-07-31,2020-07-31 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 suspectscore=1 mlxlogscore=999
 phishscore=0 clxscore=1015 impostorscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008010005
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 09:06:55PM -0700, Hugh Dickins wrote:
> On Thu, 30 Jul 2020, Roman Gushchin wrote:
> > On Wed, Jul 29, 2020 at 08:45:47PM -0700, Hugh Dickins wrote:
> > > 
> > > But a better idea is perhaps to redefine the behavior of
> > > "echo >/proc/sys/vm/stat_refresh".  What if
> > > "echo someparticularstring >/proc/sys/vm/stat_refresh" were to
> > > disable or enable the warning (permanently? or just that time?):
> > > disable would be more "back-compatible", but I think it's okay
> > > if you prefer enable.  Or "someparticularstring" could actually
> > > specify the warning threshold you want to use - you might echo
> > > 125 or 16000, I might echo 0.  We can haggle over the default.
> > 
> > May I ask you, what kind of problems you have in your in mind,
> > which can be revealed by these warnings? Or maybe there is some
> > history attached?
> 
> Yes: 52b6f46bc163 mentions finding a bug of mine in NR_ISOLATED_FILE
> accounting, but IIRC (though I might be making this up) there was
> also a bug in the NR_ACTIVE or NR_INACTIVE FILE or ANON accounting.
> 
> When one of the stats used for balancing or limiting in vmscan.c
> trends increasingly negative, it becomes increasingly difficult
> for those heuristics (adding on to others, comparing with others)
> to do what they're intended to do: they behave increasingly weirdly.
> 
> Now the same (or the opposite) is true if one of those stats trends
> increasingly positive: but if it leaks positive, it's visible in
> /proc/vmstat; whereas if it leaks negative, it's presented there as 0.
> 
> And most of the time (when unsynchronized) showing 0 is much better
> than showing a transient negative.  But to help fix bugs, we do need
> some way of seeing the negatives, and vm/stat_refresh provides an
> opportunity to do so, when it synchronizes.
> 
> I'd be glad not to show the transients if I knew them: set a flag
> on any that go negative, and only show if negative twice or more
> in a row?  Perhaps, but I don't relish adding that, and think it
> would be over-engineering.
> 
> It does sound to me like echoing the warning threshold into
> /proc/sys/vm/stat_refresh is the best way to satisfy us both.
> 
> Though another alternative did occur to me overnight: we could
> scrap the logged warning, and show "nr_whatever -53" as output
> from /proc/sys/vm/stat_refresh: that too would be acceptable
> to me, and you redirect to /dev/null.

It sounds like a good idea to me. Do you want me to prepare a patch?

> 
> (Why did I choose -53 in my example?  An in-joke: when I looked
> through our machines for these warnings, on old kernels with my
> old shmem hugepage implementation, there were a striking number
> with "nr_shmem_freeholes -53"; but I'm a few years too late to
> investigate what was going on there.)

:)

> 
> > 
> > If it's all about some particular counters, which are known to be
> > strictly positive, maybe we should do the opposite, and check only
> > those counters? Because in general it's not an indication of a problem.
> 
> Yet it's very curious how few stats ever generate such warnings:
> you're convinced they're just transient noise, and you're probably right;
> but I am a little suspicious of whether they are accounted correctly.

Yeah, I was initially very suspicious too, but I didn't find any issues
and still think it's not an indication of a problem.

Thank you!
