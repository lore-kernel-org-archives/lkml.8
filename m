Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D296FC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9C020B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rirqrzEh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732265AbgDAQPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:15:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42112 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728242AbgDAQPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:15:44 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 031G9Z4r132264;
        Wed, 1 Apr 2020 16:10:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=igQpHEyMKJTQgqY+5lVU6UpjVDCEktfMEEUoFi0hzdY=;
 b=rirqrzEhxiUQjA4Whgg0FsFwpoaHlxZOwChQKYEw30ZadyZYgDq6HwPiLXwva9g8hDl0
 JYPf85K3A9knnKbMki8AlHxaRhwzkCC8D5OnBTqx/RmadSOBuSMNAbe+4LsasSzGtR0E
 2dRImSqjm0aKO0rvUzB2xYeBlb2/tYSbxO0iaxH2uuxZxmsmXtsJ7zehIx3xnNdsJ/40
 4yLOlAduuT5vByN2HFFrx8BOgsbqLkv+ellZrWkGE+WVHP/fu5f2usD5kWGVWea5/6Na
 9vQ2Ew9fRhYxspuYlghNy6uxF376FvpaNrxM0afzpCVvqv5O8lHX4CmB1ZLRX7c7qODQ IQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 303yun911j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Apr 2020 16:10:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 031G8DX6040487;
        Wed, 1 Apr 2020 16:10:20 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 302ga0s8j5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Apr 2020 16:10:20 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 031GAHbs000767;
        Wed, 1 Apr 2020 16:10:17 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 01 Apr 2020 09:10:16 -0700
Date:   Wed, 1 Apr 2020 12:10:36 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Yiqian Wei <yiwei@redhat.com>
Subject: Re: [PATCH v1 0/2] mm/page_alloc: fix stalls/soft lockups with huge
 VMs
Message-ID: <20200401161036.oqk3dakako33bv3o@ca-dmjordan1.us.oracle.com>
References: <20200401104156.11564-1-david@redhat.com>
 <596d593e-7f36-0e24-6c67-311bd6971e89@redhat.com>
 <CAM9Jb+hYPUZXVLr2T8x6Njcscw_+W0e2SCmr_B1fLZuOwgLZuw@mail.gmail.com>
 <20200401144529.7zkqq4rfdnitg32h@ca-dmjordan1.us.oracle.com>
 <8d481b8e-7ffc-e9f5-604b-f90856b2b38a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d481b8e-7ffc-e9f5-604b-f90856b2b38a@redhat.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004010139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004010138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 05:54:40PM +0200, David Hildenbrand wrote:
> On 01.04.20 16:45, Daniel Jordan wrote:
> > On Wed, Apr 01, 2020 at 04:31:51PM +0200, Pankaj Gupta wrote:
> >>> On 01.04.20 12:41, David Hildenbrand wrote:
> >>>> Two fixes for misleading stall messages / soft lockups with huge nodes /
> >>>> zones during boot without CONFIG_PREEMPT.
> >>>>
> >>>> David Hildenbrand (2):
> >>>>   mm/page_alloc: fix RCU stalls during deferred page initialization
> >>>>   mm/page_alloc: fix watchdog soft lockups during set_zone_contiguous()
> >>>>
> >>>>  mm/page_alloc.c | 2 ++
> >>>>  1 file changed, 2 insertions(+)
> >>>>
> >>>
> >>> Patch #1 requires "[PATCH v3] mm: fix tick timer stall during deferred
> >>> page init"
> >>>
> >>> https://lkml.kernel.org/r/20200311123848.118638-1-shile.zhang@linux.alibaba.com
> >>
> >> Thanks! Took me some time to figure it out.
> > 
> > FYI, I'm planning to post an alternate version of that fix, hopefully today if
> > all goes well with my testing.
> > 
> 
> Cool, please CC me :)

Sure, in fact you already were! :)
