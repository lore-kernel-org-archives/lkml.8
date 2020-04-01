Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED716C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 17:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D32A206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 17:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pSJmxzDk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732755AbgDARNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 13:13:31 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38896 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgDARNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 13:13:31 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 031H9btK006195;
        Wed, 1 Apr 2020 17:13:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=QSpo2rWwvgOU28GQ7Bz4BpJhWkG9i7/4mOFtHSMz2wE=;
 b=pSJmxzDkZBIG8vBLJ6HQLYoLckpuC5Q+oCDKbWy9xpGR5QcrC381FuJSGevOv+UI0Czf
 Qcv2yZs2gWKPp0/UZ5fupBTr1+aMiLIJR3JEignjj+dqCCZLETum+y03muqbX1pVE8RB
 JRkrRqiBzbWDvTjIFPybafgABnqGH6mKLvAdSuvPkWn/lsneV/3c4BjdsA+VoRb7uE68
 r/6qKbEXFMXBmFPsAxydXnAQhXMDLQD9BslLdivlyfy2oQUSkchMrVlc0WaliewXoxyt
 03+Kg/WR4O6lCoz5rNiLPxjXf3yc27Oz2v7QdEtxFsityVIcXhYDYC1kPEcUdPeDwSbY dg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 303cev6rd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Apr 2020 17:13:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 031H7BQG103658;
        Wed, 1 Apr 2020 17:13:15 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 304sjkvjk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Apr 2020 17:13:14 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 031HDBEB010071;
        Wed, 1 Apr 2020 17:13:11 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 01 Apr 2020 10:13:11 -0700
Date:   Wed, 1 Apr 2020 13:13:31 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] mm: fix tick timer stall during deferred page init
Message-ID: <20200401171331.26v6th25ezhixwpt@ca-dmjordan1.us.oracle.com>
References: <20200401154217.GQ22681@dhcp22.suse.cz>
 <dfc0014a-9b85-5eeb-70ea-d622ccf5d988@redhat.com>
 <20200401160048.GU22681@dhcp22.suse.cz>
 <20200401160929.jwekhr24tb44odea@ca-dmjordan1.us.oracle.com>
 <20200401161243.GW22681@dhcp22.suse.cz>
 <20200401161810.xvqikca2x46yqrlx@ca-dmjordan1.us.oracle.com>
 <20200401162655.GX22681@dhcp22.suse.cz>
 <CA+CK2bCGpG6kBjkGd-QP06kNtwezj8mW13Jdvbxs6ExzRaJSpQ@mail.gmail.com>
 <20200401164654.GY22681@dhcp22.suse.cz>
 <CA+CK2bCKxok9Ho2NJd0kWR=YCi+eQqyfv6fg1Je3Lmov9PqzwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bCKxok9Ho2NJd0kWR=YCi+eQqyfv6fg1Je3Lmov9PqzwQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=0 mlxlogscore=616 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004010146
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 clxscore=1011 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 impostorscore=0 mlxlogscore=663 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004010146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 12:51:56PM -0400, Pavel Tatashin wrote:
> > > I do not remember seeing any real failures, this was a theoretical
> > > window. So, we could potentially simply remove these locks until we
> > > see a real boot failure in some interrupt thread. The allocation has
> > > to be rather large as well.
> >
> > Yes please! We are really great at over complicating and over
> > engineering stuff based on theoretical issues and build on top of that
> > and make the code even more complex because nobody dares to re-evaluate
> > and so on.
> 
> I will submit a patch (or revert) whichever is cleaner.

I had thought people would be concerned about that window.  I believe the quote
from the time it was being discussed was "rare failures suck."  They very much
do :) but in this case I think any failure would be relatively easy to
diagnose.

So great, simpler is always better, and I'll wait for what you send, Pasha.

Alternatively, if you won't be able to get to it for a while, I can write it
up, having thoroughly paged all this in over the past week.
