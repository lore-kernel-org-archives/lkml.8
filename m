Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227A1C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 14:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E642320787
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 14:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K/gEutRu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733093AbgDAOpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 10:45:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:32832 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732897AbgDAOpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 10:45:31 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 031EhrW0070278;
        Wed, 1 Apr 2020 14:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=sCJYoI8k6b3QVvtYdeNl6B+/zvls9nEm6ZlXsvG8LBY=;
 b=K/gEutRunVUlx7PC8FLrMH7eM0gI0XsGimzCeXdUiKSFF35+aJFQYz/41eLTPOB97Qs3
 yA01XZTN8BNz2qBLDcjY3dXkURtOSykowTG2tLWcXyZgwbviLvi5bnggPjg6iBhcCmcK
 cZmspK87XmtK3BXpDXkGaF3RKXLXII90UuDwDX83yrqXCr1JyOzt8TclaJr3AQuvllD3
 g0GVQzBnB6Ot/xvgUHA8QWWRd6J9JB11N2RPW4SEpirJDST+kbcBP/lfgGNDhJR4Z9bw
 TnnqmLTnsk01PAgKhHL/OrE4FvEmc0UeVthi46a2iNy6dQGr+zI9NY1Otm/mwJebP6Ei KA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 303yun8gjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Apr 2020 14:45:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 031EgH8F030718;
        Wed, 1 Apr 2020 14:45:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 302g4tvqvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Apr 2020 14:45:14 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 031EjAJJ026251;
        Wed, 1 Apr 2020 14:45:10 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 01 Apr 2020 07:45:09 -0700
Date:   Wed, 1 Apr 2020 10:45:29 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Duyck <alexander.duyck@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Yiqian Wei <yiwei@redhat.com>
Subject: Re: [PATCH v1 0/2] mm/page_alloc: fix stalls/soft lockups with huge
 VMs
Message-ID: <20200401144529.7zkqq4rfdnitg32h@ca-dmjordan1.us.oracle.com>
References: <20200401104156.11564-1-david@redhat.com>
 <596d593e-7f36-0e24-6c67-311bd6971e89@redhat.com>
 <CAM9Jb+hYPUZXVLr2T8x6Njcscw_+W0e2SCmr_B1fLZuOwgLZuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9Jb+hYPUZXVLr2T8x6Njcscw_+W0e2SCmr_B1fLZuOwgLZuw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9577 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004010131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9577 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 impostorscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004010131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 04:31:51PM +0200, Pankaj Gupta wrote:
> > On 01.04.20 12:41, David Hildenbrand wrote:
> > > Two fixes for misleading stall messages / soft lockups with huge nodes /
> > > zones during boot without CONFIG_PREEMPT.
> > >
> > > David Hildenbrand (2):
> > >   mm/page_alloc: fix RCU stalls during deferred page initialization
> > >   mm/page_alloc: fix watchdog soft lockups during set_zone_contiguous()
> > >
> > >  mm/page_alloc.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> >
> > Patch #1 requires "[PATCH v3] mm: fix tick timer stall during deferred
> > page init"
> >
> > https://lkml.kernel.org/r/20200311123848.118638-1-shile.zhang@linux.alibaba.com
> 
> Thanks! Took me some time to figure it out.

FYI, I'm planning to post an alternate version of that fix, hopefully today if
all goes well with my testing.
