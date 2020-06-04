Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70255C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48FEC206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oV9H7ygV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbgFDRYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:24:05 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35332 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729998AbgFDRYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 13:24:05 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 054HGWua094785;
        Thu, 4 Jun 2020 17:23:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=G/Sb2Wxr/3pPoUovNdxaMT0I7DZc8Om+RvsuQbMjB1k=;
 b=oV9H7ygV/qI6eMjxUACM2sbO+kxUYVMZApUqxByRSSulM4iu8YYwcbZepjv4kETihn7X
 Vq8nYFe/3EaD+o2fSf/1ekfvwjDuncR6ZoJ+/2FCHYfcHiT0zbAjWzlC2Rvxof6jnihU
 BXKA5HHR527TvCxqrYuxn7E3ub1Oi7/Gx9Sm9XvNUWlY8OXmS1covD0YO8CPbtKCvWZR
 03uPipzs9Dh58Qd0V4Z1gujF48OCo+h3YzT3hEQ9UQdH2BtL3iY5d+UrURgatirlJLQh
 IDVK4KMvesJYxEABchRW/ztC9v0w41lff7aeHYBLNIbTLG0m1aPPY2+tTbuPirjSMBFy 1w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 31evap2x6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 04 Jun 2020 17:23:51 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 054HI6wY029235;
        Thu, 4 Jun 2020 17:21:50 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 31dju5b6kq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jun 2020 17:21:50 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 054HLms2026140;
        Thu, 4 Jun 2020 17:21:48 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Jun 2020 10:21:48 -0700
Date:   Thu, 4 Jun 2020 13:22:13 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH] x86/mm: use max memory block size with unaligned memory
 end
Message-ID: <20200604172213.f5lufktpqvqjkv4u@ca-dmjordan1.us.oracle.com>
References: <20200604035443.3267046-1-daniel.m.jordan@oracle.com>
 <5827baaf-0eb5-bcea-5d98-727485683512@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5827baaf-0eb5-bcea-5d98-727485683512@redhat.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006040120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006040120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 09:22:03AM +0200, David Hildenbrand wrote:
> On 04.06.20 05:54, Daniel Jordan wrote:
> > Some of our servers spend 14 out of the 21 seconds of kernel boot
> > initializing memory block sysfs directories and then creating symlinks
> > between them and the corresponding nodes.  The slowness happens because
> > the machines get stuck with the smallest supported memory block size on
> > x86 (128M), which results in 16,288 directories to cover the 2T of
> > installed RAM, and each of these paths does a linear search of the
> > memory blocks for every block id, with atomic ops at each step.
> 
> With 4fb6eabf1037 ("drivers/base/memory.c: cache memory blocks in xarray
> to accelerate lookup") merged by Linus' today (strange, I thought this
> would be long upstream)

Ah, thanks for pointing this out!  It was only posted to LKML so I missed it.

> all linear searches should be gone and at least
> the performance observation in this patch no longer applies.

The performance numbers as stated, that's certainly true, but this patch on top
still improves kernel boot by 7%.  It's a savings of half a second -- I'll take
it.

IMHO the root cause of this is really the small block size.  Building a cache
on top to avoid iterating over tons of small blocks seems like papering over
the problem, especially when one of the two affected paths in boot is a
cautious check that might be ready to be removed by now[0]:

    static int init_memory_block(struct memory_block **memory,
    			     unsigned long block_id, unsigned long state)
    {
            ...
    	mem = find_memory_block_by_id(block_id);
    	if (mem) {
    		put_device(&mem->dev);
    		return -EEXIST;
    	}

Anyway, I guess I'll redo the changelog and post again.

> The memmap init should nowadays consume most time.

Yeah, but of course it's not as bad as it was now that it's fully parallelized.

[0] https://lore.kernel.org/linux-mm/a8e96df6-dc6d-037f-491c-92182d4ada8d@redhat.com/
