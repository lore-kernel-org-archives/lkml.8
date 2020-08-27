Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17888C433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 22:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF53A2080C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 22:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ZF+GyWq6";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="YwN9/pLC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgH0Whm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 18:37:42 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35396 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726234AbgH0Whm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 18:37:42 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07RMSWuU017351;
        Thu, 27 Aug 2020 15:37:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Hc+68ixxWQoHe0PNRbmwq3kIm5z6qMpJFGu2qZLJxv0=;
 b=ZF+GyWq6VNSlBBWtXDleJ3vA141s6dOqigF/vuyEhkmAoyrAETUdAPAQ9Wyy4VZOTOIe
 Jq9jMr6ilCaRx3JisM+Pxomde46ztw3Rd37nJ0ws3woVhUs+AK5UX08oYNhN1c6iiL0Q
 K/um7myanmGaw/yla1mz0QLCqmyS7Rh5r/E= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 335up7r02g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 27 Aug 2020 15:37:33 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 27 Aug 2020 15:37:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cy/9P2MscME9Vz+FsLlmkIJjz1UBEpJvj1HYONm6JhGYGtbJVJ6nVigP1erhhs9/0XUx19IJipKV5yQ9mO8EiVMcJ14rbb5yCrhCLb7HmynwEwScENq/Ypscgs2Ha3LfEI2SIjqaylCM2h3+srd0Xort1YHiaJr1a2mysRtgJmn5SFjnpWApyONEe7JfQXu6A5I+fadb7TBHN5FCOZbaQcgXHZ1PJtamqj8+PvegtYPX5Lsodg7c+o8yKJ5FHcOcfqUs7IHrYVWY59lsmW/fiEevv25oHiVNUCJK+SwbvAhHz51kBIHdO13bHi2Y+52ntTT1gJ2+ZhJWDZWcoBXOsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hc+68ixxWQoHe0PNRbmwq3kIm5z6qMpJFGu2qZLJxv0=;
 b=dKcX7H+ervQvoUcs1dmUWi/Ut5Geq+Sb5Q7+mNy8K7EC65T8LDsH0inptSy3PKNOJjEy5AcToYQ8NyCQZGkAijLlROsdDJrMXKBXvbx6gMwlNbiEOLu+yLYqkePhakbILh5+5IOnQpX2o954TCGfHoTgzfBRZMQ2wMWaZjmbw+CkUr/G5V6K6BIcQcMq/x8T4ciM1Ty1btjZkO3jutGlmHnrcfiQq5Vb4XRf8x017moKE9M/NibFmZwqGk69UgpVDDCwDvwPzIdROsxYE/5VHTTPRVJd1F2Dk0oE87CfcYi+NMdkDTdwL8e8PCxxHWTDCYCHXIHUfvkXHAXOK1WBiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hc+68ixxWQoHe0PNRbmwq3kIm5z6qMpJFGu2qZLJxv0=;
 b=YwN9/pLCtWwrjr6ez55ySWNQOxYqDzKAyADUicGLIlWY0PYTkOdVk+X4YUkrUdRAF0G5uYfDmWjkndZry4ddMt0JjE8R2OOY4IWTWezvyfGNzURb72B8Fq3mC4gBqB7bj8/ibQbUfJY9p64x+/7FalNRmzOCtndKneMncTNEkbM=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14) by SA0PR15MB3854.namprd15.prod.outlook.com
 (2603:10b6:806:80::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Thu, 27 Aug
 2020 22:37:31 +0000
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::e1a8:24c:73df:fe9a]) by SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::e1a8:24c:73df:fe9a%7]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 22:37:31 +0000
Date:   Thu, 27 Aug 2020 15:37:28 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 3/4] mm: kmem: prepare remote memcg charging infra
 for interrupt contexts
Message-ID: <20200827223728.GB2490802@carbon.dhcp.thefacebook.com>
References: <20200827175215.319780-1-guro@fb.com>
 <20200827175215.319780-4-guro@fb.com>
 <CALvZod7p3Ju-OSoYPonfjWwVm9fgxbDUzPzvrenkEqPNPLD88w@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7p3Ju-OSoYPonfjWwVm9fgxbDUzPzvrenkEqPNPLD88w@mail.gmail.com>
X-ClientProxiedBy: BYAPR07CA0052.namprd07.prod.outlook.com
 (2603:10b6:a03:60::29) To SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BYAPR07CA0052.namprd07.prod.outlook.com (2603:10b6:a03:60::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.20 via Frontend Transport; Thu, 27 Aug 2020 22:37:30 +0000
X-Originating-IP: [2620:10d:c090:400::5:4840]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 585c9952-9d83-4fc5-9480-08d84ad9c929
X-MS-TrafficTypeDiagnostic: SA0PR15MB3854:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB3854017563C70D6BC95CE39EBE550@SA0PR15MB3854.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TElxYctHTcG2OJHKLz3yoBheXIoQfa4tXDkDsXZKv6/qKSEi3Yr8zoz8JW/XM+ZOQlNe1yCHfj/NpScEtTkqBJbQrngvZIX1jntqkVtxU9HhcGX/5udRRBYwqj2Gi5tCIHlwjzY3JQIPaRKRJ8UrtmHeMu3hw5IMUg0rAB7PQ6w/cc1RmGM8QHnG63k92HdfCNr1HcVzGsE9f7Yzj5A/Wg7IHMQxF1GXjBlqQUn/fh3t9xMalqLJ4K3RiaelyjbMpHNrPmcTcfPMzpJiSuS+FhG/cTjbPXTIsfr65x+YstqluCC1UHmE7mjkv/R4iT8kfKpa9x4TMKA/ZqBylOFx/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB4141.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(39860400002)(366004)(346002)(8936002)(6916009)(54906003)(316002)(4326008)(16576012)(186003)(52116002)(53546011)(2906002)(9686003)(6486002)(33656002)(956004)(478600001)(5660300002)(8676002)(83380400001)(86362001)(66946007)(1076003)(66476007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: /gintrtXO8lJTjzY8OwEhUivvEOmCDqGXnMsplqHXatrU2hUEEem+AdX2P9+sMoQV9MLhD/QjZAXzGwI1S58zQAsjpP1YQ82lJTUQS1198eCCVeKwzfAuEJ7Nz9IttKeeQJ6TVtoWQpc2L0Drx8HvgbXchQdSk5RxFJBJiuCYySH4tLTVQoI5dg4I9VyXU0mRmNmKPbctTdx71z6nYjGU0Bl/r3/57AxDYPG3SpTeugzbjq+7/Zy170Wsz4RcQafXYZ+OnT1+gbrDrRNoY7bejRkkziyd563CBQI3WAHtATTXq9GLoNYlK9nyH9SBejBiVdMzXjpK4i3pu7d3Q3XJWixjMfx/qBHg0jsSuFcu6dlYPu3oHHLGtLFtXBTwUhZ4afudI+W9ozMD1ANyPCyDxAEka7YkT5jPTN3oYO9nY3S8NHmhIZXsiAb5ksde+xN62cwFjhCMeHYLoft+N4DQgCdFEvVLalKwjrzPQA+F0HlVqqeJxT9hjPEYfd1jE3bMJ86Cm68Ugb36V+L5NiieADQUHsecD1zYhiJZIgLEXi6ct0lEEbRHIOCBGHjNHoQSFZjCyrRWZmfoq8NVVdYLInLORRksvTPAaEKI+OV4rXQcc7mMNg97Fe/O7nRxPiUiDR2DbETpWJvPxg4jQsnBSl8wV7F9ucTUvcjTflK8Vk=
X-MS-Exchange-CrossTenant-Network-Message-Id: 585c9952-9d83-4fc5-9480-08d84ad9c929
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB4141.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 22:37:31.7408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: io9ZiXH+spRaZyyQTuCnp66NL8nBK6VVPY8DY6MQzRPgF+8ez5EP87ETz7j7ZLzJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3854
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_14:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 bulkscore=0 phishscore=0 mlxscore=0 clxscore=1015 adultscore=0
 suspectscore=1 malwarescore=0 mlxlogscore=838 lowpriorityscore=0
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008270169
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 02:58:50PM -0700, Shakeel Butt wrote:
> On Thu, Aug 27, 2020 at 10:52 AM Roman Gushchin <guro@fb.com> wrote:
> >
> > Remote memcg charging API uses current->active_memcg to store the
> > currently active memory cgroup, which overwrites the memory cgroup
> > of the current process. It works well for normal contexts, but doesn't
> > work for interrupt contexts: indeed, if an interrupt occurs during
> > the execution of a section with an active memcg set, all allocations
> > inside the interrupt will be charged to the active memcg set (given
> > that we'll enable accounting for allocations from an interrupt
> > context). But because the interrupt might have no relation to the
> > active memcg set outside, it's obviously wrong from the accounting
> > prospective.
> >
> > To resolve this problem, let's add a global percpu int_active_memcg
> > variable, which will be used to store an active memory cgroup which
> > will be sued from interrupt contexts. set_active_memcg() will
> 
> *used
> 
> > transparently use current->active_memcg or int_active_memcg depending
> > on the context.
> >
> > To make the read part simple and transparent for the caller, let's
> > introduce two new functions:
> >   - struct mem_cgroup *active_memcg(void),
> >   - struct mem_cgroup *get_active_memcg(void).
> >
> > They are returning the active memcg if it's set, hiding all
> > implementation details: where to get it depending on the current context.
> >
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> 
> I like this patch. Internally we have a similar patch which instead of
> per-cpu int_active_memcg have current->active_memcg_irq. Our use-case
> was radix tree node allocations where we use the root node's memcg to
> charge all the nodes of the tree and the reason behind was that we
> observed a lot of zombies which were stuck due to radix tree nodes
> charges while the actual pages pointed by the those nodes/entries were
> in used by active jobs (shared file system and the kernel is older
> than the kmem reparenting).
> 
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Thank you for reviews, Shakeel!

I'll fix the typo, add your acks and will resend it as v1.

Thanks!
