Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78302C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 03:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DBC920707
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 03:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="DgRKr0z5";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="BuQ9GxHa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgFQDUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 23:20:18 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:63624 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726789AbgFQDUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 23:20:17 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05H3J1xC012992;
        Tue, 16 Jun 2020 20:20:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=DxI796Z9HX58ceCDuCCqR4W93D84EPRgJspJDL/VPHI=;
 b=DgRKr0z5JCQf1Y4xYLtuGcolXbdGgKKVJjYjmqZqqu83GjJYTJ4Rl8aVLYmRJ0qMuGlx
 Jlxfelk23paat2nBfvg76V2tO4/N9GqKi4iZomru7VlC643gQoc137N7e1APBII3bxcs
 6twrN/NNqzFE6wUHbxQxgIrsRdkplKj5nac= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31q8u68ewv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 16 Jun 2020 20:20:06 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 16 Jun 2020 20:20:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bj8rkT5YiyNWuZXYnqPKKN/eeAfXIWiqmcw6786CQLqQZ0qx0Kjow1QUoxhFbVUyzjM+idgQjxaKSx1XUMAWbrH9j+gfORTkX/LF7TjAgczxDJZJEIRSEVYxIprI5oa0fwSvNHNDLeKf+Gy+pSRdJI74/PM6yL7oum82Mj9R48s+c++q8semFtCN0uSx9ihx+KXxFdSCc3ferB/mWA7uHRh6Px8d/xXC1AERh4cc0+rEeHiQC/sMA1iQ9WPX23dOBISNFYFRhSJzpsW6BerXoI0ZrNEq3SNqiGa+zcvrF/7pCFhdmTFLMOYJ2yfeMXE62EZf9h5F3vzVjT7IjmDmUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxI796Z9HX58ceCDuCCqR4W93D84EPRgJspJDL/VPHI=;
 b=gW0EfHWf/Sg0Vs8cKIuelX1Pi7k1eEbAMIpQOzycmUuXZ6fKsJ5ZiELmHG6MOsW3xbU3IJ/ziaZ+hP721d6VX4VjCRB+uYMPaNOe6TWN/zhKDC4FveOkpee52v2fflv4fmbCmyRgy0ZlpW61zkzwhCKBtryDTeUV5DtZW8BrORBV3UzjHTdWndQ712mPsb6YwUQhea9KFwI7ngmW3aU20CcrboGgwjaalbJIjzZyMt3qPZofOJS+/MKp4dM8kjNU/mtSW4YK7kqasGUUt6Myhi89mpv2+A0mylNMLJ05yDUp8Ybi32jhF+W8UT+8dW/a4oM7DCUhVygiDfCF818aWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxI796Z9HX58ceCDuCCqR4W93D84EPRgJspJDL/VPHI=;
 b=BuQ9GxHaWtK1Rqnrkc2aRrIGmjGzVzeIhGibFrYucUNxDkp4zjvrIiOLqzhUFjrSjtWehebtlSi+/z4wCRZUFM0/zKjMpyicj0X8GNukR5GcMbrtkplWqDOqDlcTJBE7QDuTSTMShnZG7k8h7N0tq34Ux/GqDOX7QAyt14pi10w=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3652.namprd15.prod.outlook.com (2603:10b6:a03:1f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.24; Wed, 17 Jun
 2020 03:20:01 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3088.029; Wed, 17 Jun 2020
 03:20:01 +0000
Date:   Tue, 16 Jun 2020 20:19:58 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 01/19] mm: memcg: factor out memcg- and lruvec-level
 changes out of __mod_lruvec_state()
Message-ID: <20200617031958.GD10812@carbon.lan>
References: <20200608230654.828134-1-guro@fb.com>
 <20200608230654.828134-2-guro@fb.com>
 <CALvZod7yPUMuakhmaKV8Z0DVr0RO1pyw9vW7YOkmDH=oW3xyDA@mail.gmail.com>
 <20200617025014.GB10812@carbon.lan>
 <CALvZod5CiU8qKNCo7gjh5O=BSGkM8Hj3Jr9ppmoWq+YY7w19Nw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5CiU8qKNCo7gjh5O=BSGkM8Hj3Jr9ppmoWq+YY7w19Nw@mail.gmail.com>
X-ClientProxiedBy: BYAPR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:a03:40::36) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:d0dc) by BYAPR04CA0023.namprd04.prod.outlook.com (2603:10b6:a03:40::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21 via Frontend Transport; Wed, 17 Jun 2020 03:20:00 +0000
X-Originating-IP: [2620:10d:c090:400::5:d0dc]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cea247eb-edc5-4507-f987-08d8126d51f5
X-MS-TrafficTypeDiagnostic: BY5PR15MB3652:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR15MB36521746E1C38C5D8BE230F6BE9A0@BY5PR15MB3652.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04371797A5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aXabvkMPDTEitRqYubVou9WdXfFljiNAd0g9JBpBKweSbYrkx1afGSmrNVzuEdV+7z07+7tFlv6bRRWVgXFBlgDkl1VK02LDbcW+LVxlaHCyeBaqoseDgAETPuRtd6P8txIJDGCROoP3MS4IEWD1u5F1i+ZHzCMJOAX2vAty1+Nlyyz6JLKWCv2TwnQf+FhgHcJlfgiSw8ec1ja7zeGZ34jFumP/eUHsNukNxNP4a4p95AYL74ZGZpToq/4m15Veo8sc0q5Njts4C2UwJkbl6CDnBjV0z6M73M+sQej9Tg486bDfJ5Ed8irJ3ITfC9J83EEPHEmLmi8HEsALMNXqEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(376002)(346002)(39860400002)(366004)(136003)(83380400001)(33656002)(8676002)(4326008)(316002)(55016002)(9686003)(478600001)(7696005)(54906003)(8886007)(2906002)(8936002)(52116002)(5660300002)(66556008)(36756003)(6916009)(66476007)(86362001)(16526019)(53546011)(1076003)(186003)(66946007)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: fm/p7lVAl8jASJt//Ay6WUaTRsSphgHh8I/0BeBYAO+TEdXOlqBHnaXpgODbrcozZYLlr6F8pQ60kgYrmxHRQ2kfYSSmHtzn9R3lo2zgsnC6tSMWxgrJdPkpObs4JXB++lPM8iWeFmEgtgS2DY22pHWtuSEXKq+SJiEZ5ga7M/twFRjdAB+ERBVxiiwWa+QyfXSRA4ndH44HwVMD+YE/FdyOQ8YKwolYqBVdmA0qOUj5GXmOfWgYUf5NYpDATZK68LgBx//IZTYZjby+OtT0aqH7pew4IL0qfmCslBeSfFnR+4oLqSHkKf9CzFkgtnw2ZFzvHcibiHiz8Huqoy59lR+AvO13wPO4VFrEPuWzUtqNKGdCwxmz96CW+DRK/xB3ONYkr96FRH+0Dw+/UMA5pzH3RxHuetwbJHA8iAIoxjEa/9wztk+gB4rjc+wAwoHUeOQSqtJDFTd8X9l5QLmJI6LE0jKMY3FPdGuv0e4Aa7oPUigbuYYzAMSFQ0O5yjnvFora5KCoDylzbWYOSKuD9A==
X-MS-Exchange-CrossTenant-Network-Message-Id: cea247eb-edc5-4507-f987-08d8126d51f5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2020 03:20:01.0843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C99EK29drfy2kiOFNz41U9nEZGO3hFeGYnkGG3rGUUR4fTJ2q74X4xkgmsHdsLmT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3652
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-16_13:2020-06-16,2020-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 cotscore=-2147483648 malwarescore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=1 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006170026
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 07:59:40PM -0700, Shakeel Butt wrote:
> On Tue, Jun 16, 2020 at 7:50 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Tue, Jun 16, 2020 at 06:52:09PM -0700, Shakeel Butt wrote:
> > > On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:
> > > >
> > > > To convert memcg and lruvec slab counters to bytes there must be
> > > > a way to change these counters without touching node counters.
> > > > Factor out __mod_memcg_lruvec_state() out of __mod_lruvec_state().
> > > >
> > > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > > > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > > > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > > > ---
> > > >  include/linux/memcontrol.h | 17 +++++++++++++++
> > > >  mm/memcontrol.c            | 43 +++++++++++++++++++++-----------------
> > > >  2 files changed, 41 insertions(+), 19 deletions(-)
> > > >
> > > > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > > > index bbf624a7f5a6..93dbc7f9d8b8 100644
> > > > --- a/include/linux/memcontrol.h
> > > > +++ b/include/linux/memcontrol.h
> > > > @@ -679,11 +679,23 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
> > > >         return x;
> > > >  }
> > > >
> > > > +void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
> > > > +                             int val);
> > > >  void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
> > > >                         int val);
> > > >  void __mod_lruvec_slab_state(void *p, enum node_stat_item idx, int val);
> > > >  void mod_memcg_obj_state(void *p, int idx, int val);
> > > >
> > > > +static inline void mod_memcg_lruvec_state(struct lruvec *lruvec,
> > > > +                                         enum node_stat_item idx, int val)
> > >
> > > Is this function used in later patches? Any benefit introducing it
> > > here instead of in the patch where it is used for the first time?
> >
> > Yes, it's used in "mm: memcg/slab: charge individual slab objects instead of pages".
> >
> > It's a fairly large patchset with many internal dependencies, so there is
> > always a trade-off between putting everything into a single patch, which is
> > hard to review, and splitting out some changes, which make not much sense
> > without seeing the whole picture.
> >
> > In this particular case splitting out a formal and easy-to-verify change makes
> > the actual non-trivial patch smaller and hopefully easier for a review.
> >
> > But of course it's all subjective.
> >
> > Thanks!
> 
> I am fine with that.
> 
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Thank you! Appreciate it!
