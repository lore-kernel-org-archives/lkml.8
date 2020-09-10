Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC4EC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 775DB20BED
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ecTzReWD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbgIJKGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:06:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35564 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730260AbgIJKGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 06:06:18 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08A9wWVq118520;
        Thu, 10 Sep 2020 10:04:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=yKCTtiGzPUIRtEV0H7rFdmSehfsK8C0E+KdRzhKe1j8=;
 b=ecTzReWDjakbs0DI5D8yLBG0FlZZqPvLqkLO873YmIdsB6G/AXP8InIqQoIrDg1sS2vP
 KWBdb9vdcwkn0AxAr2VFysALJHDhbWonL0a0373/hU3KC9EGXJhnlKjSXCKDc+ca8Qyy
 SOL1j1oTkh/B9U65SPJcPaTny8n+22L8GBiSa8FeEIaXpFFDD9eDrmTKwEBUiBxYehMi
 1+els2laUsqHBZVrplo4zDskqxO01pejfbvasvHs9ayKjxG/7MENVd5bVTYKBd/ifa4L
 vqHudTmiD8dPTYCADCEDrea6ig2yQpCt4ML85Q8yFJQfMxuGYYWrBpiWDU9VW3O10qjd yw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 33c2mm72re-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Sep 2020 10:04:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08AA0SjN118538;
        Thu, 10 Sep 2020 10:02:51 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 33cmm0prwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Sep 2020 10:02:51 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08AA2jhR031400;
        Thu, 10 Sep 2020 10:02:45 GMT
Received: from localhost.localdomain (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Sep 2020 03:02:45 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.0.3.2.26\))
Subject: Re: [RFC PATCH 00/16] 1GB THP support on x86_64
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <53b360d4-8d16-892b-0f7f-5c4cd95208d8@redhat.com>
Date:   Thu, 10 Sep 2020 04:02:44 -0600
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>,
        Roman Gushchin <guro@fb.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F8242D9A-AB1C-4652-A0EC-C4F4CC670034@oracle.com>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200903142300.bjq2um5y5nwocvar@box>
 <20200903163020.GG60440@carbon.dhcp.thefacebook.com>
 <8e677ead-206d-08dd-d73e-569bd3803e3b@redhat.com>
 <7E20392E-5ED7-4C22-9555-F3BAABF3CBE9@nvidia.com>
 <20200908142758.GF27537@casper.infradead.org>
 <20200909121117.GD87483@ziepe.ca>
 <20200909123244.GD6583@casper.infradead.org>
 <20200909131449.GF87483@ziepe.ca>
 <53b360d4-8d16-892b-0f7f-5c4cd95208d8@redhat.com>
To:     David Hildenbrand <david@redhat.com>
X-Mailer: Apple Mail (2.3654.0.3.2.26)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9739 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009100093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9739 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 clxscore=1011 mlxlogscore=999
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009100093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 9, 2020, at 7:27 AM, David Hildenbrand <david@redhat.com> =
wrote:
>=20
> On 09.09.20 15:14, Jason Gunthorpe wrote:
>> On Wed, Sep 09, 2020 at 01:32:44PM +0100, Matthew Wilcox wrote:
>>=20
>>> But here's the thing ... we already allow
>>> 	mmap(MAP_POPULATE | MAP_HUGETLB | MAP_HUGE_1GB)
>>>=20
>>> So if we're not doing THP, what's the point of this thread?
>>=20
>> I wondered that too..
>>=20
>>> An madvise flag is a different beast; that's just letting the kernel
>>> know what the app thinks its behaviour will be.  The kernel can pay
>>=20
>> But madvise is too late, the VMA already has an address, if it is not
>> 1G aligned it cannot be 1G THP already.
>=20
> That's why user space (like QEMU) is THP-aware and selects an address
> that is aligned to the expected THP granularity (e.g., 2MB on x86_64).


To me it's always seemed like there are two major divisions among THP =
use
cases:

1) Applications that KNOW they would benefit from use of THPs, so they
call madvise() with an appropriate parameter and explicitly inform the
kernel of such

2) Applications that know nothing about THP but there may be an
advantage that comes from "automatic" THP mapping when possible.

This is an approach that I am more familiar with that comes down to:

    1) Is a VMA properly aligned for a (whatever size) THP?

    2) Is the mapping request for a length >=3D (whatever size) THP?

    3) Let's try allocating memory to map the space using (whatever =
size)
       THP, and:

        -- If we succeed, great, awesome, let's do it.
        -- If not, no big deal, map using as large a page as we CAN get.

There of course are myriad performance implications to this. Processes
that start early after boot have a better chance of getting a THP,
but that also means frequently mapped large memory spaces have a better
chance of being mapped in a shared manner via a THP, e.g. libc, X =
servers
or Firefox/Chrome. It also means that processes that would be mapped
using THPs early in boot may not be if they should crash and need to be
restarted.

There are all sorts of tunables that would likely need to be in place to =
make
the second approach more viable, but I think it's certainly worth =
investigating.

The address selection you suggest is the basis of one of the patches I =
wrote
for a previous iteration of THP support (and that is in Matthew's THP =
tree)
that will try to round VM addresses to the proper alignment if possible =
so a
THP can then be used to map the area.



