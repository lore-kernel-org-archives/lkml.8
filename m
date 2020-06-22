Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8F1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C30FB2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L3h9g0M6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgFVTRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 15:17:31 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54300 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgFVTRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 15:17:30 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05MIw7Be030691;
        Mon, 22 Jun 2020 19:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=mq8kT3o8dLo2ItEFdRGaDe2nwGFwgbcNf7NesuhpOWo=;
 b=L3h9g0M6Mbl/xZQBRwuDwMjsPa6F6JpAf51cY9Iq2TfTbpp3kpiIqJ4pJgJnG2gkKopL
 e79od2xio/yt1iJ5XNp5vtnWAeyCJ/VaQO69xG+p3oRTqL4GpBxoI7HYx4rI1aEDGMa9
 o5w6Ft3NVU4RcuLEVXrw7Y53NuIrmT4mkADO5KAONgFKpFOtfgDAQ40tA1NRKQqUUe7F
 BTkRkO44C0JPiM+Awmgg0th4Kdxtk+rR8zPp2toieUzNKEnbc3OsF0BEtmYb+hLQI8Yu
 oOAxU1htMytkkjFm0lJVKHJX4KgT8greVZfGA562k84lRQ8k2j52tnJrg0516c2gi54H Vw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 31sebbh7f5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Jun 2020 19:17:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05MIw5Tx074902;
        Mon, 22 Jun 2020 19:17:15 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 31sv7qktb7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Jun 2020 19:17:14 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05MJHDKN013963;
        Mon, 22 Jun 2020 19:17:13 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Jun 2020 19:17:12 +0000
Date:   Mon, 22 Jun 2020 15:17:39 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH v2] x86/mm: use max memory block size on bare metal
Message-ID: <20200622191739.4lekqrmjnzv2vwl2@ca-dmjordan1.us.oracle.com>
References: <20200609225451.3542648-1-daniel.m.jordan@oracle.com>
 <20200619120704.GD12177@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619120704.GD12177@dhcp22.suse.cz>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9660 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006220126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9660 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 adultscore=0 impostorscore=0 cotscore=-2147483648 mlxscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006220126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Michal,

(I've been away and may be slow to respond for a little while)

On Fri, Jun 19, 2020 at 02:07:04PM +0200, Michal Hocko wrote:
> On Tue 09-06-20 18:54:51, Daniel Jordan wrote:
> [...]
> > @@ -1390,6 +1391,15 @@ static unsigned long probe_memory_block_size(void)
> >  		goto done;
> >  	}
> >  
> > +	/*
> > +	 * Use max block size to minimize overhead on bare metal, where
> > +	 * alignment for memory hotplug isn't a concern.
> 
> This really begs a clarification why this is not a concern. Bare metal
> can see physical memory hotadd as well. I just suspect that you do not
> consider that to be very common so it is not a big deal?

It's not only uncommon, it's also that boot_mem_end on bare metal may not align
with any available memory block size.  For instance, this server's boot_mem_end
is only 4M aligned and FWIW my desktop's is 2M aligned.  As far as I can tell,
the logic that picks the size wasn't intended for bare metal.

> And I would
> tend to agree but still we are just going to wait until first user
> stumbles over this.

This isn't something new with this patch, 2G has been the default on big
machines for years.  This is addressing an unintended side effect of
078eb6aa50dc50, which was for qemu, by restoring the original behavior on bare
metal to avoid oodles of sysfs files.

> Btw. memblock interface just doesn't scale and it is a terrible
> interface for large machines and for the memory hotplug in general (just
> look at ppc and their insanely small memblocks).

I agree that the status quo isn't ideal and is something to address going
forward.

> Most usecases I have seen simply want to either offline some portion of
> memory without a strong requirement of the physical memory range as long
> as it is from a particular node or simply offline and remove the full
> node.

Interesting, would've thought that removing a single bad DIMM for RAS purposes
would also be common relative to how often hotplug is done on real systems.

> I believe that we should think about a future interface rather than
> trying to ducktape the blocksize anytime it causes problems. I would be
> even tempted to simply add a kernel command line option 
> memory_hotplug=disable,legacy,new_shiny
> 
> for disable it would simply drop all the sysfs crud and speed up boot
> for most users who simply do not care about memory hotplug. new_shiny
> would ideally provide an interface that would either export logically
> hotplugable memory ranges (e.g. DIMMs) or a query/action interface which
> accepts physical ranges as input. Having gazillions of sysfs files is
> simply unsustainable.

So in this idea, presumably the default would start off being legacy and then
later be changed to new_shiny?

If new_shiny scales well, maybe 'disable' wouldn't be needed and so using the
option could be avoided most of the time.  If some users really don't want it,
they can build without it.
