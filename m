Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551A8C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DAE8212CC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="TGJtZrEo";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="WwbQx3bI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgFQUr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 16:47:27 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:13746 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726905AbgFQUr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 16:47:26 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05HKkGZR030163;
        Wed, 17 Jun 2020 13:47:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=acj7tO4mBqthoR024U0AWZZqjeLvIpCw5tRLK/QLfbA=;
 b=TGJtZrEoPqxPdnSOkI3p+QpiIpThXwuAfcagv4Ql0tVrGjeZUFizmeiyFyAge/DX77O4
 nYVH/hUTfBYUBy/xgd98SRfmDRhIBjM5n1aZlMw32li03lOx0LMJXbnADLiqodIF5XpL
 46YXFwfkyCTAn4D+Jdso5eOzx0c46oZRsvg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31q65d81ed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 17 Jun 2020 13:47:18 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 17 Jun 2020 13:47:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9g6lSNbVAna3tRto7zeGHtnWJFlF4lAXaN5f0y+mEEvsdztaRULmvrSYg9kUKrqHRxPbzeXc3Abas0VzG+wRRM7ifAUgwGWk2CHBXd+BzzKJ83dVQ+YB24L3KR8We8LWURFEedNJWo3yOvlMfKPo8rg9ygCULKPx/q/Xruk9UEfiuKMm74aOVZ2jHUlMwZ26Q+G+S08UdrkuE1kRwtdH5ZHJOQYOc2CBdfRItSEFkkRc2e4gHZJ5/3mPSHakWlg6iQF98gr6rvSuJJNgDP9f0UXibK4OEv0I0Jd9cFmCiGry84Wks/ll9v34KjweCUbSXb/fK6rN62U9nhC81TOFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acj7tO4mBqthoR024U0AWZZqjeLvIpCw5tRLK/QLfbA=;
 b=VDlMJvfMnYwqnvRl8VQofNUKCH7y1s4bhKRzqJrZ4d4nlkiQq0eZaut3GdlayN/OFwFBr94XWGT++8ErxQhfqjUnwu7nGN+oh8xAtxlLPiFvAy4WWCVwWlHkhAsO8ZLPiHwV+bo/9rhjXARbVr1IOQrpvO4fNyIm92ZIjPb/boQN15BZtyWVwnMJYTdUrRxuPffkuaimTg/xAOifxJkoXlzCTH37nJhsJ5c3Fi+KlEM2dKoAKNJohlu6Jgg8vl6cBduqsICsobq8HqhtRztuIuj//yCKmaepCEa9pVq8LhQFCG9KqDyvab6vki1U4r95PI/rrfF/4wXO5gZigM5GwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acj7tO4mBqthoR024U0AWZZqjeLvIpCw5tRLK/QLfbA=;
 b=WwbQx3bIOM7lHcbJsby/re5BZv8Wn5AJYn5YrghvesY2YH70sONURgas/MiXLZ/Kj1Ani/UyrnjLl1FY2GYJ/IxdH9kl2X7Mh/WvGoB3k4Ckkw4bt6aHeauTGcz+hB/uT9UpyvlrYiNPYtz9cZY0nnZ60B9mAtoYqaKdPuVJGy8=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2872.namprd15.prod.outlook.com (2603:10b6:a03:b5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.25; Wed, 17 Jun
 2020 20:47:13 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3088.029; Wed, 17 Jun 2020
 20:47:13 +0000
Date:   Wed, 17 Jun 2020 13:47:05 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Dennis Zhou <dennis@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [Potential Spoof] [PATCH v2 0/5] mm: memcg accounting of percpu
 memory
Message-ID: <20200617204705.GA24694@carbon.DHCP.thefacebook.com>
References: <20200608230819.832349-1-guro@fb.com>
 <20200616211728.GA7652@carbon.lan>
 <20200617133949.148aff08300e24a084f9bb18@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617133949.148aff08300e24a084f9bb18@linux-foundation.org>
X-ClientProxiedBy: BY5PR20CA0006.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::19) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:9687) by BY5PR20CA0006.namprd20.prod.outlook.com (2603:10b6:a03:1f4::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21 via Frontend Transport; Wed, 17 Jun 2020 20:47:13 +0000
X-Originating-IP: [2620:10d:c090:400::5:9687]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2829c92-7015-4346-5123-08d812ff9d18
X-MS-TrafficTypeDiagnostic: BYAPR15MB2872:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB28721182A62B6AC4D761056CBE9A0@BYAPR15MB2872.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 04371797A5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5WsxHN9tBaD/RwDlYLXTbufJ/xsZqLUegNr49AtEWHsjUrID36P2xrBkNeepZcHReCCu3u9S4gFxu9WgqO7k8YZQdRdhl2yK0rp6zPsrLGjVXKgQ3nxT0D7kWny7r6d02ptiJZ/JHOqkk1ZqrlyjbEbScX9IsUEUr6dr8WDYdy/bWQdZYYAs33pvglbRlGOkCSRksJgNfmh4uTL6+SRQU0g7YqQ1jnFO8YBefm8te8Qiwwq0OtWI7aOiAHkms6L6GkEBhexge1mhAVfemAvILTpPEcyE+Lx2iEb3S/uNPXw0L6t0AtSCnqF7byn9+5P3jp4D54AX2w70R6eBAFedEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(396003)(376002)(366004)(346002)(136003)(2906002)(6916009)(5660300002)(478600001)(186003)(4326008)(15650500001)(54906003)(1076003)(16526019)(9686003)(55016002)(8676002)(66946007)(6506007)(316002)(7696005)(8936002)(83380400001)(52116002)(66476007)(66556008)(33656002)(6666004)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: YdGuEMQXq7PKvdX4SQKVq2nON9PhhD9tG4D/Z/GF6DvOhL1JMTQClxdMN3B1JgkUDh6MTLuPuHuZn0DJ70wJU7E1hBrBbYxc31M0Ovzv+rdNv9ceRHif6UrtZB0oN2CDpb2sdgWXcZWalofySk5dCEZwPtcesLi0bUDZUtfbFIyu8N6OZkHgbb26pqVnxwwnF/9HNrD16QGCY/wWpiy7bF2qxdGFXN4ys9kNwfPSVFT4BGaC6H8n+G1rvN7mW32b+wKp7aJ3BwJujmapkYs4hL5EDx0esRQqA7l4PpnSG/rLdELA/lCWWM2eePIUldYbsYflbEhNTvBvHgPLPTw37fWyuzYnCwp3xpQXUw69UODWi65GVJ1lm6bN4RfUOX08B+dOHejSr12OO9Pi5KnUU09zZX1aQd1mLbWqSKS6LT1SAli7R6QAnvp9VQl89O567RDntu7fmf/Y+RxPrcE6/DC0frAO30aQehUyXPZy51D8kaXv1eviyPC+xaNAgcmmLTtWzFr0BDvgkV1pTYgtSA==
X-MS-Exchange-CrossTenant-Network-Message-Id: d2829c92-7015-4346-5123-08d812ff9d18
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2020 20:47:13.6690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PLIhM3Qy3Ya30uQOAyUml8AiRhxTUsB7GMI3JEFqqAIkDNCXSGkv+J8H+71SksQg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2872
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-17_11:2020-06-17,2020-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=1 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 cotscore=-2147483648
 phishscore=0 impostorscore=0 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006170155
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 01:39:49PM -0700, Andrew Morton wrote:
> On Tue, 16 Jun 2020 14:19:01 -0700 Roman Gushchin <guro@fb.com> wrote:
> 
> > > 
> > > This version is based on top of v6 of the new slab controller
> > > patchset. The following patches are actually required by this series:
> > >   mm: memcg: factor out memcg- and lruvec-level changes out of __mod_lruvec_state()
> > >   mm: memcg: prepare for byte-sized vmstat items
> > >   mm: memcg: convert vmstat slab counters to bytes
> > >   mm: slub: implement SLUB version of obj_to_index()
> > >   mm: memcontrol: decouple reference counting from page accounting
> > >   mm: memcg/slab: obj_cgroup API
> > 
> > Hello, Andrew!
> > 
> > How this patchset should be routed: through the mm or percpu tree?
> > 
> > It has been acked by Dennis (the percpu maintainer), but it does depend
> > on first several patches from the slab controller rework patchset.
> 
> I can grab both.

Perfect, thanks!

> 
> > The slab controller rework is ready to be merged: as in v6 most patches
> > in the series were acked by Johannes and/or Vlastimil and no questions
> > or concerns were raised after v6.
> > 
> > Please, let me know if you want me to resend both patchsets.
> 
> There was quite a bit of valuable discussion in response to [0/n] which
> really should have been in the changelog[s] from day one. 
> slab-vs-slub, performance testing, etc.
> 
> So, umm, I'll take a look at both series now but I do think an enhanced
> [0/n] description is warranted?
> 

Yes, I'm running suggested tests right now, and will update on the results.

Thanks!
