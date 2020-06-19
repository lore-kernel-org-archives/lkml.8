Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A7AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 18:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C66FE21531
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 18:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="qY/+QDqI";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="BbJxMEVA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392209AbgFSSsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 14:48:01 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:4048 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387933AbgFSSr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 14:47:59 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05JIXR2V029357;
        Fri, 19 Jun 2020 11:47:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=FbbnuNSVSeQv5Zog60zOpO1O537NGfRHgDR1t3p4GNo=;
 b=qY/+QDqItksJYXgRMT8rt58jhkJ/PF7W7vfAr8axpxY+ilDwieAY8Ghq/tcLdebmEl7j
 0L/Vud+Z/akS86zXXs8AGzmWFkNOwZs96BiCb+bEzfrFw3rwsY0E0wMf28SPRLi8+YML
 ATX1vNXU7ubjtSVEhxO7SpV744zJndIsVFU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31s2rcr2mx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 19 Jun 2020 11:47:43 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 19 Jun 2020 11:47:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCUeZJ3karnFIjHNalkS7diaFlRx9+ZBrwesG83WVvBAtZF5HG5IbTbhXSFpTt0KSPOne5GqxGq5E/697DeNoqR2au2kZCFPYG1bKAJvEABfPKipI7/AOnDDWluz/HkjTFQZdYAbGYTfQXrGPlE8bUh1r0OWMi9AH0oDf815H2L5wSjUxyVQ+8/APlJgaTJDn+/EVnqFsg7igDJPNUTsHVZ3qQG8fVBtZAfNHHFxCEQS6RuRIZOk7FS/iCKwe/mywzmI5S7WtxV1BN6zr/IERFU/HBGyRaOm22uyyxXU7f3K49bdpQ0KPPL27UnsbLYZcg72uDoq0h/GyQvbbLi2wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbbnuNSVSeQv5Zog60zOpO1O537NGfRHgDR1t3p4GNo=;
 b=MKocr+m9MZYB1aUXfMKFwv9r2vGQbsBuUjwPTVkHfu0cCxhlSBrSuYRkb8VFbmbweOE+n1gxSKgODdHduZXB3BmqJW4pKWwgb1Z4vduhiXzVUaK6VEW0hekIsFbMLYviL6sCYztWonsX1u5sT2dS9aiBYcCrYaH/gyYdNKv4is7dDi+ptZpBYUZ18W+T6IYXgwAj1bKliVLBUzcoAbvHCvjd6cTfffafR3+n41Y8oRZmSdRPl1l+hoheDKFhjQqXvuivlV7uKoB915IdB3+OfGz3wretL1kjKyFGfz9p5igF2zc+6G/nvjnmbdghPDOreen2xY7aEVPZqkIqdMz0QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbbnuNSVSeQv5Zog60zOpO1O537NGfRHgDR1t3p4GNo=;
 b=BbJxMEVAc5Bv2lCj1d0iRwVkbGaB3ZsMOwZf658LeP32Q7Wp35A3woCGTqJNAvjVUEnlEcf2dEGHd/FLewuuZCV/madyOb52d+24mBImMF2JZ16sEvlSd2W5X66BPhHAE0t5v/04LURGfv3eBI5AoMOa8yfKKaqscNBDL1JHu8A=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3285.namprd15.prod.outlook.com (2603:10b6:a03:103::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.24; Fri, 19 Jun
 2020 18:47:40 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 18:47:40 +0000
Date:   Fri, 19 Jun 2020 11:47:36 -0700
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
        Mel Gorman <mgorman@techsingularity.net>,
        Larry Woodman <lwoodman@redhat.com>
Subject: Re: [PATCH v6 00/19] The new cgroup slab memory controller
Message-ID: <20200619184736.GA217189@carbon.lan>
References: <20200608230654.828134-1-guro@fb.com>
 <CALvZod7ThL=yMwxzCLvrTtq=+Dr5ooUSX-iFP8AhiAGURByFBA@mail.gmail.com>
 <20200617024147.GA10812@carbon.lan>
 <CALvZod4vLQb4kns=ao8btL_g--9axZfcaxhMnj+CoTrCkyWoWQ@mail.gmail.com>
 <20200617033217.GE10812@carbon.lan>
 <e510e964-2703-d123-120c-816bbdd35743@suse.cz>
 <20200618012928.GD24694@carbon.DHCP.thefacebook.com>
 <20200618104344.6a96ac04@carbon>
 <20200619012712.GD135965@carbon.dhcp.thefacebook.com>
 <20200619113945.15ff3b15@carbon>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619113945.15ff3b15@carbon>
X-ClientProxiedBy: BYAPR07CA0057.namprd07.prod.outlook.com
 (2603:10b6:a03:60::34) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:c16d) by BYAPR07CA0057.namprd07.prod.outlook.com (2603:10b6:a03:60::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 18:47:39 +0000
X-Originating-IP: [2620:10d:c090:400::5:c16d]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 831970cc-516f-45e0-92e7-08d814813e2a
X-MS-TrafficTypeDiagnostic: BYAPR15MB3285:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB32850D903F89AD00A8FB32CBBE980@BYAPR15MB3285.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vcocUw2B+fiSsUYeyd3n7V4V2cEB/sf+EAPN0Hxb5rRNsA/q1kafIhl/K6nPy/8E1kkotaJXkio4Uci49Q1oQOHc3lijGFWe+cfjUV+uwUQhhVerX475FVfOqiKTnenu429ZNrUdNdTmZQqFbqcmvYJ+WJo4N9NqG+pIMPHQJkF6fq4pzuEHAxJEsFDkkBQvsYwZbG6Vi9F2qtMVD9wfp+gY6H3TMy99pAZBoouH9eu4b1IQt0xbJCYQAIOWCZ1hLmaAQbg97bQTSehdGRKxRF3hLhyxtHuoaMhQK03eoia0HMqVrjF5cLBVBM0XomKwYpLKvPngZQg8DlPlYV7BVP2QV86E1xIos/qhCFf1PQUSwn7OdcwrVeUm002jt9Do
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(396003)(376002)(136003)(366004)(39860400002)(6916009)(316002)(36756003)(6666004)(7416002)(5660300002)(6506007)(4326008)(54906003)(186003)(7696005)(16526019)(52116002)(8886007)(2906002)(66556008)(83380400001)(66476007)(55016002)(9686003)(8936002)(86362001)(66946007)(478600001)(33656002)(1076003)(8676002)(27376004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: j1OV765HGKYRq52kQzI2VElQVMvFaYO9bhVnh8RqtmVKVBC2l2vN1f+otN5x4T27d9Vr9U9LMzK6D/BYHT0wS+57E79BX5Fk+dXB8MyOQT/FegwJyJyTF71j5ZB1w/j3ZH98BJw0op0En+p7mF8vxZz29FgXFECL+2zl0UWbaMNwMDssAa90+U2U5vTzOEH3pSyCVfu1RyqOgWeI7SDiU8yYteZuTOJYRnW1nn8ku1GXQzRPCJSSA8qcYPNQvxlgOrhVozoESzyVtgSbfussfCruESGB1HsVoSM9PLT+TqQiFFoA3CDGvSnYhThBFteME573kpu4zzKvHm/ZWwYZYDmWZXWSP7Wq713TCdyoGUAVKyW8tx9QhBySkxIR+X79EbzukIhRzIr77+mylisTzRvpyAyWDEYjtIMoSsHTnGtlk1rvah98xIpl3Cs4EwwDDG7yJq+uTap/qhCxnN2frHoV2DlZV1WXgJOMedY0H/zsPbUocXR2cfXU2bgHCyDMrZZZHWZHqYM1oeh7soy3nQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 831970cc-516f-45e0-92e7-08d814813e2a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 18:47:40.1754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GV9De2/DLNgNO92z+Bue58pPnNfz+jE8k4OWm0dpCOQMm9DFDfu39RmmbuqKO2Fy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3285
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-19_20:2020-06-19,2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=1
 bulkscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 cotscore=-2147483648 priorityscore=1501 clxscore=1011 adultscore=0
 spamscore=0 mlxlogscore=818 impostorscore=0 phishscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190135
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 11:39:45AM +0200, Jesper Dangaard Brouer wrote:
> On Thu, 18 Jun 2020 18:27:12 -0700
> Roman Gushchin <guro@fb.com> wrote:
> 
> > Theoretically speaking it should get worse (especially for non-root allocations),
> > but if the difference is not big, it still should be better, because there is
> > a big expected win from memory savings/smaller working set/less fragmentation etc.
> > 
> > The only thing I'm slightly worried is what's the effect on root allocations
> > if we're sharing slab caches between root- and non-root allocations. Because if
> > someone depends so much on the allocation speed, memcg-based accounting can be
> > ignored anyway. For most users the cost of allocation is negligible.
> > That's why the patch which merges root- and memcg slab caches is put on top
> > and can be reverted if somebody will complain.
> 
> In general I like this work for saving memory, but you also have to be
> aware of the negative consequences of sharing slab caches.  At Red Hat
> we have experienced very hard to find kernel bugs, that point to memory
> corruption at a completely wrong kernel code, because other kernel code
> were corrupting the shared slab cache.  (Hint a workaround is to enable
> SLUB debugging to disable this sharing).

I agree, but it must be related to the sharing of slab pages between different
types of objects. We've also disabled cache sharing many times in order
to compare slab usages between different major kernel version or to debug
memory corruptions.

But what about sharing between multiple cgroups, it just brings
CONFIG_MEMCG_KMEM memory layout back to the !CONFIG_MEMCG_KMEM.
I doubt that anyone ever considered the kernel memory accounting
as a debugging mechanism. Quite opposite, we've encountered a lot of
tricky issues related to the dynamic creation and destruction of kmem_caches
and their life-time. Removing this code should make things simpler and
hopefully more reliable.

Thanks!


