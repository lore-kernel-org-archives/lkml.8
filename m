Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B0FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 22:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF406206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 22:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yxa3skTA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgFDW1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 18:27:41 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40132 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgFDW1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 18:27:39 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 054MNNch014878;
        Thu, 4 Jun 2020 22:27:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=gf9OrIA5b7YcgNgDNTGP7nLQOzt5ruNun/RvZvx7gH8=;
 b=yxa3skTAk/kS/W9Wlz/D/BXlUkwNKSM4X7CdvPkndV82k5pk/TG2OOOhrEQbfgLIL+PN
 c2Ky/3PHn0TPu5khWslcZGZpiq5ymQUSLSlYZ8ptSrbpppT/feMkjVLOKeV9C7uL7I5h
 +ItHiIQxys+vXkU6JVgYDtboZG4uC5CM633yxhkRqapXUxvqSSzieNCWpyR/DjIei0Vx
 9RRHMk9dt6ryE/Ck5I7/bPI70t4nyM2cxL3BwVgTIBJkQk0c3Itp+kTpshhAIiyu6mAG
 aukqjsbEq5gLzU9SfMZi8NuS/1o8KyHQMtukYgUuNT/uOMMb99OdS+fpANTmmJa5nahZ vA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 31f91dr4nj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 04 Jun 2020 22:27:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 054MRMoH033116;
        Thu, 4 Jun 2020 22:27:29 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 31f92rs5ck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jun 2020 22:27:28 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 054MRRwx023147;
        Thu, 4 Jun 2020 22:27:27 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Jun 2020 15:27:27 -0700
Date:   Thu, 4 Jun 2020 18:27:52 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
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
Message-ID: <20200604222752.ubwykq4himsjdult@ca-dmjordan1.us.oracle.com>
References: <20200604035443.3267046-1-daniel.m.jordan@oracle.com>
 <5827baaf-0eb5-bcea-5d98-727485683512@redhat.com>
 <20200604172213.f5lufktpqvqjkv4u@ca-dmjordan1.us.oracle.com>
 <ebc31650-9e98-f286-6fc2-aafdd3cd9272@redhat.com>
 <20200604181201.lqop72ihg5butlmz@ca-dmjordan1.us.oracle.com>
 <72066bef-866a-c2a4-d536-4212c3344045@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72066bef-866a-c2a4-d536-4212c3344045@intel.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 suspectscore=0 mlxlogscore=978 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006040156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 clxscore=1011 cotscore=-2147483648 malwarescore=0 adultscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006040155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 01:00:55PM -0700, Dave Hansen wrote:
> On 6/4/20 11:12 AM, Daniel Jordan wrote:
> >> E.g., on powerpc that's 16MB so they have *a lot* of memory blocks.
> >> That's why that's not papering over the problem. Increasing the memory
> >> block size isn't always the answer.
> > Ok.  If you don't mind, what's the purpose of hotplugging at that granularity?
> > I'm simply curious.
> 
> FWIW, the 128MB on x86 came from the original sparsemem/hotplug
> implementation.  It was the size of the smallest DIMM that my server
> system at the time would take.  ppc64's huge page size was and is 16MB
> and that's also the granularity with which hypervisors did hot-add way
> back then.  I'm not actually sure what they do now.

Interesting, that tells me a lot more than the "matt - 128 is convenient right
now" comment that has always weirdly stuck out at me.

> I actually can't think of anything that's *keeping* it at 128MB on x86
> though.  We don't, for instance, require a whole section to be
> pfn_valid().

Hm, something to look into.
