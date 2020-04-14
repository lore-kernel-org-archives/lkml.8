Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3F5C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B591520678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TOOXbq7T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440717AbgDNPlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:41:05 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39116 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440652AbgDNPkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:40:07 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EFS5df015987;
        Tue, 14 Apr 2020 15:39:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=6eY4SulE79/R6CaiMVLknysTXv5mXE1bPdiZhdn/9Eo=;
 b=TOOXbq7TN3JIcLnVi2iCsAWLMbjOiXrgkbeIw4HbKF6bfDMKY4tMpJRX7LSOzyBPTlp1
 W9jx4cRKgkLIQBEhpRxQpBE8WUWITraPuFJT+VtaGt9q5FQnZ6g/7BW+YE2xds/K2j8y
 p5vs9SfLlUAF+vtHvEn4CkLx/Xd3F9Udm9n60fIPFffjKVia1aICNPx6s2CeF/qQAb4H
 CM6ceVawKcQKSyc0hNbC0a2736FC+Iu/G2M0tdJ7OHEOhV4OSve6VTToFUWNiwXbkh/L
 ImK19AQeG4YgdVozDy5j32aanYgerNqxK+9hUoPOfwtte0iN3ikTvY6BXTafhz0WXhye BQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 30b5um5k6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 15:39:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EFbFWJ178275;
        Tue, 14 Apr 2020 15:39:52 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 30ctaag5un-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 15:39:52 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03EFdnnf031915;
        Tue, 14 Apr 2020 15:39:49 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Apr 2020 08:39:48 -0700
Date:   Tue, 14 Apr 2020 11:40:05 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RFC PATCH 0/4] mm: Add PG_zero support
Message-ID: <20200414154005.ttgsfux6vshjfhco@ca-dmjordan1.us.oracle.com>
References: <20200412090728.GA19572@open-light-1.localdomain>
 <7de81a1c-0568-b8dd-02c5-b109a2e74a04@redhat.com>
 <CAKgT0Uf2n10YM5V0osfRmO9Qveq_i=esfCq5o2Y0dO7c5SP1HQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0Uf2n10YM5V0osfRmO9Qveq_i=esfCq5o2Y0dO7c5SP1HQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9591 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004140124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9591 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 bulkscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004140124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 08:07:32AM -0700, Alexander Duyck wrote:
> On Tue, Apr 14, 2020 at 5:01 AM David Hildenbrand <david@redhat.com> wrote:
> > Having that said, I agree with Dave here, that there might be better
> > alternatives for this somewhat-special-case.
> 
> I wonder if it wouldn't make more sense to look at the option of
> splitting the initialization work up over multiple CPUs instead of
> leaving it all single threaded. The data above was creating a VM with
> 64GB of RAM and 32 CPUs. How fast could we zero the pages if we were
> performing the zeroing over those 32 CPUs? I wonder if we couldn't
> look at recruiting other CPUs on the same node to perform the zeroing
> like what Dan had originally proposed for ZONE_DEVICE initialization a
> couple years ago[1].

This is exactly what I've done for VFIO.  Some performance results:

    https://lore.kernel.org/linux-mm/20181105165558.11698-10-daniel.m.jordan@oracle.com/

and a semi-current branch is here if anyone wants to test it:

  https://lore.kernel.org/linux-mm/20200212224731.kmss6o6agekkg3mw@ca-dmjordan1.us.oracle.com/

One of the issues with starting extra threads for paths triggered from
userspace such as VFIO is that they need to be properly throttled by relevant
resource controls such as cgroup (CPU controller especially) and
sched_setafffinity.  This type of control for kernel threads has another use
case too, async memcg reclaim.  All this is second on my list after I post a
series that multithreads deferred page init and sets up the basic
infrastructure for multithreading other paths, which I hope will be ready soon.

> [1]: https://lore.kernel.org/linux-mm/153077336359.40830.13007326947037437465.stgit@dwillia2-desk3.amr.corp.intel.com/

I haven't looked closely at memmap_init_zone, though I've tried
memmap_init_zone_device.  Will take a closer look to see how well this could be
incorporated.

Daniel
