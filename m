Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965E9C2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 18:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B78720730
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 18:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="rnHTf7ps";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="MZofr0wt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgDGSn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 14:43:28 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60360 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726706AbgDGSn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 14:43:28 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 037IhBIa019794;
        Tue, 7 Apr 2020 11:43:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=od1lvjj19hWqNrYN+FQBr+a9k7OciRv3+R1HIB+tuZ4=;
 b=rnHTf7psnECsyAzVsmKAZJ4dC+j0jWkhX3kjjy0E5tDoBo4m1KufpJ4H0SSRYxGdhyFu
 Ew4InNKNfb0eYHy/WXWt2PfTozvqMvoSQx31aVRjErZVnKdYe1iliSWuSDwTOl2nbRQr
 PqJWJh5vVZwJy0Zs7cWRh9O2VO2cakaym8w= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 307449h0w9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 07 Apr 2020 11:43:12 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 7 Apr 2020 11:42:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPw5HSHY3djo8aCMNhvsOyXpUGk5AU/RhaeoQgrmo2ERykSZ82lOos1RBD1VcrbK25KTcU7b9JQnq/3nNHlUA3vR5OGvJito6OyUYDfAWO9+VpQ7Fd/VSJo6zEM+51rU2+hr+rJw13SOou/9NwLWcN8aSBF0FBaGu+4UgMLvJO1IundcHCrpmx324S6/V+hjC98DN+UvxRfwVNQqnG+lomTgkCrZWb/Xd/WHx52tKtrllzlRwN2YjwJ+YYkZCZr5sVYN9O7xZVBby2fvrF2YqFQkwCJlAkDNMCO1DAgjCyCBWa8pzsuTt9u1mGL1Vi9kYhFsPQ/vhhcb502T7+4uJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=od1lvjj19hWqNrYN+FQBr+a9k7OciRv3+R1HIB+tuZ4=;
 b=mjt1AzFENAVXRf6piEHfmLB8byH9DpCB6vZhY5l+Vlz5v+UBMijHeyL5gm+9tkNnR1uXuJhi9RRBJixdWm05AgY68FKCwaM1hhLvrwyTqoWotJNBzdzqjAbMMEgG/ogfJBdSI08kJwJIF2uCHpDoSHQfEJnKV9EdRfLj4JDxbTNQSUyDxmm7Msjxq6fGdtF+9Gvc6n110BqX9hXXJ8ZSvHNW+IM+ADV887v6qdp+5l10TjAVnQuGn2lte/aWjV5vAwMdgpLoppvH26K6qpBXGapRuOHFaZloiNTfjiL4+ihejjyggq/3N2wfgxqCzmIk0urMjDAgQL/ZiZyqVbk+oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=od1lvjj19hWqNrYN+FQBr+a9k7OciRv3+R1HIB+tuZ4=;
 b=MZofr0wt9yGBJJ2GiSTTCzDNHo7NhEKecHWy8DQB0fKYyOflHRKpd5uUdlZRrQJjbexCnwXhijcJGlh7xm/ojvYfa+g/QQfDSgbPkgwm0n69vVk7YdKuTUdgOwIArDYWBBy9i5sW8VM0PCUAu4IFQH2icto/GHChipyM4S1DLsE=
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2792.namprd15.prod.outlook.com (2603:10b6:a03:15c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.21; Tue, 7 Apr
 2020 18:42:45 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2878.018; Tue, 7 Apr 2020
 18:42:45 +0000
Date:   Tue, 7 Apr 2020 11:42:40 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Aslan Bakirov <aslan@fb.com>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andreas Schaufler <andreas.schaufler@gmx.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joonsoo Kim <js1304@gmail.com>
Subject: Re: [PATCH v5 2/2] mm: hugetlb: optionally allocate gigantic
 hugepages using cma
Message-ID: <20200407184240.GA22872@carbon.DHCP.thefacebook.com>
References: <20200407163840.92263-1-guro@fb.com>
 <20200407163840.92263-3-guro@fb.com>
 <20200407181546.GV18914@dhcp22.suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407181546.GV18914@dhcp22.suse.cz>
X-ClientProxiedBy: MWHPR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:300:4b::21) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:b342) by MWHPR02CA0011.namprd02.prod.outlook.com (2603:10b6:300:4b::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend Transport; Tue, 7 Apr 2020 18:42:44 +0000
X-Originating-IP: [2620:10d:c090:400::5:b342]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b2553ba-9240-4d8a-44a9-08d7db237655
X-MS-TrafficTypeDiagnostic: BYAPR15MB2792:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2792BBCD4EADC6B55519BBD7BEC30@BYAPR15MB2792.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 036614DD9C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(366004)(5660300002)(81166006)(8936002)(55016002)(66556008)(81156014)(66476007)(2906002)(8676002)(6506007)(6666004)(498600001)(186003)(33656002)(86362001)(9686003)(7696005)(54906003)(110136005)(1076003)(52116002)(16526019)(66946007)(4326008);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DF9sySCfT0WVfFFua77f1F1kNcPNiDWZ7lygoChKhe2qiYthZZTe0YFnpMxQiA1WYXB+7AHQu5EmSzg9ZU1SiC8ky4uQH0xysxJLYs2lV6VDf6iYEPjodEIDn9NzEv/YgWhS74E67vV3I4EBTMNAr92KTelpbVNRdGCGUs4TaxbV6NmSjo6cfxVs8z/o0/Bb+pKfky8k2CmB9dg7A/BHgi6+c1GvHcQTw7RAe7Bn5nRy8wvkF6hXyv1GcXF4COcFxHUJZgL5Z2tt3/XvTiJWgS5YZzdzRDxvxTpnMV3nXoBsOc4MByvTAOoSulW8b9+XzYulZgMkTxuI9n9NudVAyHbwOBx+0NQGASv27+I6z0iX/sgtYDXygrHUdP345z/sUAJY70fww8Y9/RDabd4tSbB4MM/s20JyQOXZx0PFCMqXYRgEiD/4zitd4c5iyetF
X-MS-Exchange-AntiSpam-MessageData: 2papkDdV5OMigyJbAL/sZemi04msvvODo3czzCQhxIhux+6AETdvubnrc+Ec/TJ0cVmjA0FYCVmK6KHZYfLFVpS3J4CNzETn5v5MxLNFQfTdlKspQzHkcZ71PBudR9IcgvlUYSd6wYJsSLZEWtrr7+MzpeEeTChnBzyqDDOzixuOzMySWXqFQ80cFs/TQOwf
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2553ba-9240-4d8a-44a9-08d7db237655
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2020 18:42:45.2881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GIizueJz1V1jsqiEJnsDl6VSjYEi5x8u72vkbQEuy6a/vYU8nqnydnlTDgFv/cDN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2792
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-07_08:2020-04-07,2020-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004070152
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 08:15:46PM +0200, Michal Hocko wrote:
> On Tue 07-04-20 09:38:40, Roman Gushchin wrote:
> > Commit 944d9fec8d7a ("hugetlb: add support for gigantic page allocation at
> > runtime") has added the run-time allocation of gigantic pages.  However it
> > actually works only at early stages of the system loading, when the
> > majority of memory is free.  After some time the memory gets fragmented by
> > non-movable pages, so the chances to find a contiguous 1 GB block are
> > getting close to zero.  Even dropping caches manually doesn't help a lot.
> > 
> > At large scale rebooting servers in order to allocate gigantic hugepages
> > is quite expensive and complex.  At the same time keeping some constant
> > percentage of memory in reserved hugepages even if the workload isn't
> > using it is a big waste: not all workloads can benefit from using 1 GB
> > pages.
> > 
> > The following solution can solve the problem:
> > 1) On boot time a dedicated cma area* is reserved. The size is passed
> >    as a kernel argument.
> > 2) Run-time allocations of gigantic hugepages are performed using the
> >    cma allocator and the dedicated cma area
> > 
> > In this case gigantic hugepages can be allocated successfully with a high
> > probability, however the memory isn't completely wasted if nobody is using
> > 1GB hugepages: it can be used for pagecache, anon memory, THPs, etc.
> > 
> > * On a multi-node machine a per-node cma area is allocated on each node.
> >   Following gigantic hugetlb allocation are using the first available
> >   numa node if the mask isn't specified by a user.
> > 
> > Usage:
> > 1) configure the kernel to allocate a cma area for hugetlb allocations:
> >    pass hugetlb_cma=10G as a kernel argument
> > 
> > 2) allocate hugetlb pages as usual, e.g.
> >    echo 10 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
> > 
> > If the option isn't enabled or the allocation of the cma area failed,
> > the current behavior of the system is preserved.
> > 
> > x86 and arm-64 are covered by this patch, other architectures can be
> > trivially added later.
> > 
> > The patch contains clean-ups and fixes proposed and implemented by
> > Aslan Bakirov and Randy Dunlap. It also contains ideas and suggestions
> > proposed by Rik van Riel, Michal Hocko and Mike Kravetz. Thanks!
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Tested-by: Andreas Schaufler <andreas.schaufler@gmx.de>
> > Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
> > Acked-by: Michal Hocko <mhocko@kernel.org>
> > Cc: Aslan Bakirov <aslan@fb.com>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Rik van Riel <riel@surriel.com>
> > Cc: Joonsoo Kim <js1304@gmail.com>
> 
> Thanks a lot for addressing my review feedback!

Actually thank you for looking at it!

Andrew, can you, please, pick this version up instead of current patches and
fixes in the mm tree?
It will also fix the build on the next tree.

Thanks!
