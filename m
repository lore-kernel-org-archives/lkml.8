Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8BCC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 18:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0DEF206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 18:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lrrQ3nqJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbgFDSNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 14:13:51 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57320 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729856AbgFDSNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 14:13:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 054ICJmT164296;
        Thu, 4 Jun 2020 18:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=nzwZOlHPbMBuxy9DuovN5RoN5aL2B3OynDdOfCsfpvE=;
 b=lrrQ3nqJHmFQunu1FVaWsDgD5WJKNCj3+HDvqpLhwTbEuUj0MDcxk1JlU3nd/Q2JtAXX
 vq3wkA9Wi5ed4kZ4VZW3SwAorydLTGKX+rmrmM0Fbg3jj7fp2mYNBnPpdHA8PrBgJQjc
 4Dao3pk/zLbNpPBm4K+40/8v5SwYrEUlgNJQT405BSje4fqD0nJFKpzfoh1WDv03hNVV
 wT+OylcNi4ConNZzDn0RoFr1zOP2V9u8p9EZSZDQc2PmstjXKThvehoF3tg2UoX03DkM
 F2Rc/izOYUv9krZ7cVYDEMua8floww+a9rO7PHJAaGeHvXBGPdAgMaBoSOB8jH6y/hWd fQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 31ev96u679-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 04 Jun 2020 18:13:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 054I86G0096243;
        Thu, 4 Jun 2020 18:11:39 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 31dju5d81f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jun 2020 18:11:39 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 054IBade005799;
        Thu, 4 Jun 2020 18:11:37 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Jun 2020 11:11:36 -0700
Date:   Thu, 4 Jun 2020 14:12:01 -0400
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
Message-ID: <20200604181201.lqop72ihg5butlmz@ca-dmjordan1.us.oracle.com>
References: <20200604035443.3267046-1-daniel.m.jordan@oracle.com>
 <5827baaf-0eb5-bcea-5d98-727485683512@redhat.com>
 <20200604172213.f5lufktpqvqjkv4u@ca-dmjordan1.us.oracle.com>
 <ebc31650-9e98-f286-6fc2-aafdd3cd9272@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebc31650-9e98-f286-6fc2-aafdd3cd9272@redhat.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006040127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 cotscore=-2147483648 impostorscore=0
 spamscore=0 phishscore=0 mlxscore=0 clxscore=1015 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006040128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 07:45:40PM +0200, David Hildenbrand wrote:
> On 04.06.20 19:22, Daniel Jordan wrote:
> > IMHO the root cause of this is really the small block size.  Building a cache
> > on top to avoid iterating over tons of small blocks seems like papering over
> > the problem, especially when one of the two affected paths in boot is a
> 
> The memory block size dictates your memory hot(un)plug granularity.

Indeed.

> E.g., on powerpc that's 16MB so they have *a lot* of memory blocks.
> That's why that's not papering over the problem. Increasing the memory
> block size isn't always the answer.

Ok.  If you don't mind, what's the purpose of hotplugging at that granularity?
I'm simply curious.

> > cautious check that might be ready to be removed by now[0]:
> 
> Yeah, we discussed that somewhere already. My change only highlighted
> the problem. And now that it's cheap, it can just stay unless there is a
> very good reason not to do it.

Agreed.

> > Yeah, but of course it's not as bad as it was now that it's fully parallelized.
> 
> Right. I also observed that computing if a zone is contiguous can be
> expensive.

That's right, I remember that.  It's on my list :)
