Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F851C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 02:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4CA6207C4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 02:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="VCn539PB";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Ue6WDDMF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgFQCur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 22:50:47 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:12524 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726275AbgFQCuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 22:50:46 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 05H2oWnf026248;
        Tue, 16 Jun 2020 19:50:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=MPBpPPcveZImgozmzCasG+SyQqsovUXFzgXv6m5vth0=;
 b=VCn539PB/4/IOKDb7Mdp+O7um5m/ZBL7VOaDwUteXsmwhKctO229chsXhtS3d87r8sIG
 b25yrqyt7G+KRUJPUeyD62I9OuCdJhtlpUOuqB7aU2ssHyqKTIJy77AQPKXKInRIgeST
 xSQZmhj1ra4EacM14ikqbXE6PvjeJmrOgrU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 31q65k12kf-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 16 Jun 2020 19:50:34 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 16 Jun 2020 19:50:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PxDl5o2yIUHI1DxUT7l66Bpi2o5jtL287eMiisP4ZoX4K+Js7UhMp3xhh8k8hdrtRXDs9Nsq2vjijiKXp7d4r0KwJ9uZQY1ALS+tL94WoYAJL2nCp8WTRaMMquwVqiMIrELC/ZSpxtVYrKtQOw0xmKsU4YGNXlCjgwev3GL+WTdB50cZi9ap1YCOMYs3HjwW8yv4EhclMM5/djYmwqF8LCAeG81UwJZF9d2xFrkFuBsHLWTKwghKAm3nTfCjz+gp/XfTqCCEsjgF3I49CObmN6gCsojQVYP/9tBRNpaFihl6GuiznNA7843bk16+hQxR9onyqyNKnzQhYmGow3Bl4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPBpPPcveZImgozmzCasG+SyQqsovUXFzgXv6m5vth0=;
 b=AQ/GoaJCcfuEitglZJpEhlbIbdsYOD3adaJG87YYyUtAPck74lsTjIqByn2PhOengNwwu+nJaVQ8gcrd7l22Q0JN1ykfVaq8dtXY9a3W1WmG8m1EP18ornfB1v79OxCe0FzZ13Vf5Gpm6asqKh120c5zDg+JU/+qWx36bzT+ZDv4aVj+LpW8jpUTDpuaTzCwXDk5tmaS1rUS7NHF9+4Rcg9qm6pE9+UabU091di0PGMaPerGqh11ifFKM20dhpJjiNYMN+u5CETaFyxbH4FDCn4cW5XTEhsKle9jxRyEx3aR1AeaI/PX6ULoaVMzMoZvBCRze1iGSagKwk5E5SNgaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPBpPPcveZImgozmzCasG+SyQqsovUXFzgXv6m5vth0=;
 b=Ue6WDDMFL02yCoVYZF4lg0/AGT8Ej7B4JqoLc7/KBnFdrmTGD8fUq5JCh0mSnT0F2LXvSwTKj7tTrTyI+8nuhvrZilp1NkchajRMxv826q0IaKW+u0yTzuQhjnJS6Ct19jdYKRgdAiYAPJRKFIBmUKEGkg1hg0BpMApniRveCOY=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2215.namprd15.prod.outlook.com (2603:10b6:a02:89::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.22; Wed, 17 Jun
 2020 02:50:17 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3088.029; Wed, 17 Jun 2020
 02:50:17 +0000
Date:   Tue, 16 Jun 2020 19:50:14 -0700
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
Message-ID: <20200617025014.GB10812@carbon.lan>
References: <20200608230654.828134-1-guro@fb.com>
 <20200608230654.828134-2-guro@fb.com>
 <CALvZod7yPUMuakhmaKV8Z0DVr0RO1pyw9vW7YOkmDH=oW3xyDA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7yPUMuakhmaKV8Z0DVr0RO1pyw9vW7YOkmDH=oW3xyDA@mail.gmail.com>
X-ClientProxiedBy: BYAPR02CA0071.namprd02.prod.outlook.com
 (2603:10b6:a03:54::48) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:818f) by BYAPR02CA0071.namprd02.prod.outlook.com (2603:10b6:a03:54::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21 via Frontend Transport; Wed, 17 Jun 2020 02:50:16 +0000
X-Originating-IP: [2620:10d:c090:400::5:818f]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b11cd400-9968-4685-a4dd-08d812692a94
X-MS-TrafficTypeDiagnostic: BYAPR15MB2215:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB22154CC8F365A72FCD050B06BE9A0@BYAPR15MB2215.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04371797A5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ATKia8MlD+vSNuIPcDAewNkThyxpaMOT1vxa5sojNKvm77HMiRJQh9g/hDFfpHIp4nL3UGJzUhycdMgQIrcvjJAE0RYrefMSXvshxNYdeXRVTTsSTkXK6ETe+mpOhyuaL9E+JqWEuef48lSSoupCGtu23+/S7wexf0PwcGAWtFIIVbrUpVceLbqGWceaIyx0V/OWtLcrK7zxwj/8xeb7BbS/7rVNMHPv03hnoNxRg0gUoNmu8LuRrLyx9zAVgHFJNU/pPPs6+RRaMzZ+wU9xDA+PAb9AMwGjzhCpjQU1/4HJWJ2dwFFC2K2hJbU5bfDystivuVC7x/ulP4u/NkxOAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(376002)(136003)(366004)(396003)(346002)(8886007)(478600001)(9686003)(66476007)(186003)(55016002)(16526019)(66946007)(5660300002)(54906003)(66556008)(33656002)(53546011)(6916009)(4326008)(6506007)(8936002)(1076003)(316002)(8676002)(83380400001)(86362001)(36756003)(7696005)(52116002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 9yMOi4IEZ/Nrjp+Sx0zV6jzBJGpkMEoLMby326xAY4jFXIgJtzIBuqVUk+E3D792WJ82C7x232/uxA4Fxmqc3gn4/MYnG5ngMwHM50Cs5Yq4RGII+EpMZovyhnzxgHg9o/IqiUYkTnjyu3geJppb6i4MfyCV1Ar1yJklJ/xpk08Q4WRzAHrXGPj8rQTTaB4LhGj6rj5X9JcP2sOXfic68S8tFLr0NNwAvQgBO73zK/1zU6Xi6xryPmCZzTeT3TpDTzieauFz+VqCRmnmQnXXiCHCSp3MJSGLEsqInV+ElyZEZB8m/pKmDJF2fjylat9JpgeMIpcCUz0TUM0kyt0rizqwhyLfGKbafQYWZUzIbBSKK+q1fQeS5s+r94zJW42IJScWDch4fx6CiXiPpIrHaTxwGJcHZJs+kFRdZPmga3j/JEE97tpaAkpaHwUayPUWV0M3qpGn7n9IDGj26kqMydeSsHt+9dyij4pZGd1IrDSU/RINS1TV19wYnTpXh2rpXizOp4UmP4jLCDnsY+1V0g==
X-MS-Exchange-CrossTenant-Network-Message-Id: b11cd400-9968-4685-a4dd-08d812692a94
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2020 02:50:17.0264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6jqlPLJCabaTy8MtDVRnPmcP6JV1401gkL1iXLmQP2G0RCecHCSplLYMNLIUrWkq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2215
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-16_13:2020-06-16,2020-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 cotscore=-2147483648 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 mlxscore=0 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 spamscore=0 suspectscore=1 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006170022
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 06:52:09PM -0700, Shakeel Butt wrote:
> On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > To convert memcg and lruvec slab counters to bytes there must be
> > a way to change these counters without touching node counters.
> > Factor out __mod_memcg_lruvec_state() out of __mod_lruvec_state().
> >
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > ---
> >  include/linux/memcontrol.h | 17 +++++++++++++++
> >  mm/memcontrol.c            | 43 +++++++++++++++++++++-----------------
> >  2 files changed, 41 insertions(+), 19 deletions(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index bbf624a7f5a6..93dbc7f9d8b8 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -679,11 +679,23 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
> >         return x;
> >  }
> >
> > +void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
> > +                             int val);
> >  void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
> >                         int val);
> >  void __mod_lruvec_slab_state(void *p, enum node_stat_item idx, int val);
> >  void mod_memcg_obj_state(void *p, int idx, int val);
> >
> > +static inline void mod_memcg_lruvec_state(struct lruvec *lruvec,
> > +                                         enum node_stat_item idx, int val)
> 
> Is this function used in later patches? Any benefit introducing it
> here instead of in the patch where it is used for the first time?

Yes, it's used in "mm: memcg/slab: charge individual slab objects instead of pages".

It's a fairly large patchset with many internal dependencies, so there is
always a trade-off between putting everything into a single patch, which is
hard to review, and splitting out some changes, which make not much sense
without seeing the whole picture.

In this particular case splitting out a formal and easy-to-verify change makes
the actual non-trivial patch smaller and hopefully easier for a review.

But of course it's all subjective.

Thanks!
