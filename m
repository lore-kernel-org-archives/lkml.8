Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051C4C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 23:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25EC24655
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 23:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="HqINa9fE";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Z6utVYMw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbgCIXhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 19:37:48 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39364 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726937AbgCIXhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 19:37:47 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 029NYPwK008127;
        Mon, 9 Mar 2020 16:37:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=0lCMe3PD06ZzymTnDj7qnuVZoueBVfIjQ6ntSnGAZms=;
 b=HqINa9fE5u7mYqGE/r87uLF9XXSPrhfy4TDlBQFu1N4oor45vKtpXW58pirucLWsfm7r
 CPisSCruLr8wuCO9As72yj6a0o7sxIKJeB9lH1iAI/Vj/4zKT/6sw9UjXfdfsuaMEH+z
 lMqaf6qlhdyLjzhLAm8sqXmNsB7Y+UEP11Y= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2ym806t7rt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 09 Mar 2020 16:37:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Mon, 9 Mar 2020 16:37:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GH1HRelMJ7t5dECpnZL4wp3LH6WiDM+tM9vaFRZBYRxPRFFK4NskHmpqvc7au6iKH3BuvPtCyuJBI+eWHZrqdThATsIOSx0yJ5pTKJpGmZlrWkFhxruiM7MPRng+bpb1whXjeqYjbnUV6IJ4kOaBsdE8wWC0jemSQ95hQZrRX3ZGyHXRjrCG4C9BJmAQ3m6/9w05FjareIUpOontfZo3cKn1UDsTKo6qDAX/GpRj+gVW+c4y7ysZwN1kWpyqTAQPfgTohXCy7TQk6DpLdYsQDRc25uX+e5yleznL4l+6/JAA1uZ8QSotwAcfck9XqUJ37i4mxOzg/5evy5cHeiDbrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lCMe3PD06ZzymTnDj7qnuVZoueBVfIjQ6ntSnGAZms=;
 b=TriZLXWO4oONQsNVi4xMIUxPuF/IPUE1SOZVGZMZ+MystyA1c+BPm/DcCUwqyRFdATGRqUeqFIz9eUF/nGxwu8JJk7PA+0R19wt1QxbfnJrUBnL3czWGCn5C2AEEf8JQTxHaVl+D4poMUapAbcGCW3m4UavH7fLxrnCUR4QaPwXXozq5ysKs3xO1DQbMC6yqpCXgjsh7pSFoe4Tuq0+EGupl/pfELUBeZNmOQdnWThhEsa1q4FDprU/y+GISAhOR6yc+92Fg44JTMwaLR2YJn/1hqA4KXDYqkGriBC6rHnQ7pyYOfxSAO8CKrsBVdh4isNZSQ+ro8JIB8c7Z9tXF2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lCMe3PD06ZzymTnDj7qnuVZoueBVfIjQ6ntSnGAZms=;
 b=Z6utVYMwOAc+ON1Tk+2nUA37nkJt1+guGi6hCfvfh1zLtqL126S8siNtu7q/2oY9JiWK8P+C3wKeU6Uk9SpUuvDVJAeJrctLuoVNR+qqQuoqS9hO4kavKE5V9vescQx6ZjhH3y6XbyL3grTlzFWUI/Eiqf8qAOkQo2A1KChJcUA=
Received: from MWHPR15MB1661.namprd15.prod.outlook.com (2603:10b6:300:124::23)
 by MWHPR15MB1568.namprd15.prod.outlook.com (2603:10b6:300:bd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14; Mon, 9 Mar
 2020 23:37:38 +0000
Received: from MWHPR15MB1661.namprd15.prod.outlook.com
 ([fe80::f930:6bf2:6d2:93ef]) by MWHPR15MB1661.namprd15.prod.outlook.com
 ([fe80::f930:6bf2:6d2:93ef%8]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 23:37:38 +0000
Date:   Mon, 9 Mar 2020 16:37:34 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH] mm: hugetlb: optionally allocate gigantic hugepages
 using cma
Message-ID: <20200309233734.GB66037@carbon.DHCP.thefacebook.com>
References: <20200309223216.1974290-1-guro@fb.com>
 <20200309162733.3e5488f0410bffd9a9461330@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309162733.3e5488f0410bffd9a9461330@linux-foundation.org>
X-ClientProxiedBy: CO1PR15CA0113.namprd15.prod.outlook.com
 (2603:10b6:101:21::33) To MWHPR15MB1661.namprd15.prod.outlook.com
 (2603:10b6:300:124::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:71fd) by CO1PR15CA0113.namprd15.prod.outlook.com (2603:10b6:101:21::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16 via Frontend Transport; Mon, 9 Mar 2020 23:37:37 +0000
X-Originating-IP: [2620:10d:c090:400::5:71fd]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c67c46b1-996b-4075-7b35-08d7c482da0f
X-MS-TrafficTypeDiagnostic: MWHPR15MB1568:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR15MB1568622451933E7A2A8C7402BEFE0@MWHPR15MB1568.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0337AFFE9A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(366004)(136003)(376002)(199004)(189003)(81166006)(81156014)(1076003)(478600001)(8936002)(5660300002)(8676002)(9686003)(4326008)(33656002)(55016002)(52116002)(86362001)(6506007)(6666004)(316002)(66476007)(6916009)(66556008)(54906003)(2906002)(186003)(66946007)(7696005)(16526019);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1568;H:MWHPR15MB1661.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zerYz6F+RwPQLtOQblxtyEhwQFdxojKszgREsXkkHO3kuf+gRHgza1D7DS3xx5zNtkO2tK0BArXvwoGHxUnOJ88RYFZZ6e6xtZOt9fYZy5vYgLHArAMAGzROhTUjot2qa46XdiUkaX0JbJez/yTqJaqVm33KgXLcIKYjeYf0RLE+JAhRFo6kN3r3cLTd6KeEzY4EYVgvJnjTvEefQA6a4uSVPX0IpjdudvbUe+NcqeUTX3MaCK8P/wiSRRBSaiti/7kZv6aVmfGaAYwVH5FEJV6LrLVdPNOP/3T9xrXBRhWSQY1wAyrmsXHiIF+hXTYNi8FNcjABxKCfE0d+ZyjVfVUyDO4ZwOOxbSbm0avapoimthIG7WNj5zPeMqUw4yMSx9PjjImQrQaEpgNPvoRu4yxt0oMPRtyhUG1gg3f9Ztzkd1vzZv6fjuFEiNY30sCm
X-MS-Exchange-AntiSpam-MessageData: ijgH8LQ9FVwtlIYSDnBhzPVtdiHWxIQFkYIvR10pH2REdegy9l2aPyyCZADqFpdTts54W/b1XoyPuT7DWuO9ZSsjXD5eH7pV8BsNt2CsWecdVPTaCEiIiWc9mi2902jCSLIqj3eS7waB0a6TOCid7IkMTS5kwC6R+weLagw8++kRPdC6D6cdrVewxWkQpQ4r
X-MS-Exchange-CrossTenant-Network-Message-Id: c67c46b1-996b-4075-7b35-08d7c482da0f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2020 23:37:38.1014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/GyLjdQ+N5Y3ykF2pv75yJqXuL/TQmx6LtHqRqNRhzJrYDTkBuDoMJoC0kV305t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1568
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-09_13:2020-03-09,2020-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=1
 mlxlogscore=999 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 phishscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2003090142
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 04:27:33PM -0700, Andrew Morton wrote:
> On Mon, 9 Mar 2020 15:32:16 -0700 Roman Gushchin <guro@fb.com> wrote:
> 
> > Commit 944d9fec8d7a ("hugetlb: add support for gigantic page allocation
> > at runtime") has added the run-time allocation of gigantic pages. However
> > it actually works only at early stages of the system loading, when
> > the majority of memory is free. After some time the memory gets
> > fragmented by non-movable pages, so the chances to find a contiguous
> > 1 GB block are getting close to zero. Even dropping caches manually
> > doesn't help a lot.
> > 
> > At large scale rebooting servers in order to allocate gigantic hugepages
> > is quite expensive and complex. At the same time keeping some constant
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
> > In this case gigantic hugepages can be allocated successfully with a
> > high probability, however the memory isn't completely wasted if nobody
> > is using 1GB hugepages: it can be used for pagecache, anon memory,
> > THPs, etc.
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
> > Only x86 is covered by this patch, but it's trivial to extend it to
> > cover other architectures as well.
> > 
> 
> Sounds promising.
> 
> I'm not seeing any dependencies on CONFIG_CMA in there.  Does the code
> actually compile if CONFIG_CMA=n?  If yes, then does it add unneeded
> bloat?

Good question. Let me double-check it.

Thanks!
