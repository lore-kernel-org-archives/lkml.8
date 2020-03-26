Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE4EC2D0E8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 11:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D8220714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 11:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bkNe3z46"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgCZLWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 07:22:23 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:41875 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727560AbgCZLWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 07:22:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585221740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lFHzezf6iC+xOEzXT3pfauH5mGiH7h827IZ9v4hcv5o=;
        b=bkNe3z46jsKjl6xvCh3LwXb3VdoUGXroQCgkgIj7uFPmWatTrXyAkChIh0qJjXspq5/f+r
        T1G4uQHg5RUeY/9NMmxOBiQ5Aeod49HliEpCzkwW9IYeQSVt4gfNrbU8t8QGC/TxEgoJxT
        IvWCPK6KKAdPFzsk9zseHNb+V92vamQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-aMaWhWhQMXqSE2gwajnnrw-1; Thu, 26 Mar 2020 07:22:16 -0400
X-MC-Unique: aMaWhWhQMXqSE2gwajnnrw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53C548017CE;
        Thu, 26 Mar 2020 11:22:14 +0000 (UTC)
Received: from localhost (ovpn-12-117.pek2.redhat.com [10.72.12.117])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3CDEB790E0;
        Thu, 26 Mar 2020 11:22:11 +0000 (UTC)
Date:   Thu, 26 Mar 2020 19:22:09 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Rientjes <rientjes@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        iamjoonsoo.kim@lge.com, hannes@cmpxchg.org, vbabka@suse.cz,
        mgorman@techsingularity.net
Subject: Re: [PATCH 4/5] mm/vmstat.c: move the per-node stats to the front of
 /proc/zoneinfo
Message-ID: <20200326112209.GL3039@MiWiFi-R3L-srv>
References: <20200324142229.12028-1-bhe@redhat.com>
 <20200324142229.12028-5-bhe@redhat.com>
 <alpine.DEB.2.21.2003241220360.34058@chino.kir.corp.google.com>
 <20200325055331.GB9942@MiWiFi-R3L-srv>
 <20200325085537.GZ19542@dhcp22.suse.cz>
 <20200325142315.GC9942@MiWiFi-R3L-srv>
 <alpine.DEB.2.21.2003251242060.51844@chino.kir.corp.google.com>
 <20200326042454.GD9942@MiWiFi-R3L-srv>
 <20200326064339.GA27965@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326064339.GA27965@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/26/20 at 07:43am, Michal Hocko wrote:
> On Thu 26-03-20 12:24:54, Baoquan He wrote:
> > On 03/25/20 at 12:45pm, David Rientjes wrote:
> > > On Wed, 25 Mar 2020, Baoquan He wrote:
> > > 
> > > > > Even this can break existing parsers. Fixing that up is likely not hard
> > > > > and existing parsers would be mostly debugging hacks here and there but
> > > > > I do miss any actual justification except for you considering it more
> > > > > sensible. I do not remember this would be a common pain point for people
> > > > > parsing this file. If anything the overal structure of the file makes it
> > > > > hard to parse and your patches do not really address that. We are likely
> > > > > too late to make the output much more sensible TBH.
> > > > > 
> > > > > That being said, I haven't looked more closely on your patches because I
> > > > > do not have spare cycles for that. Your justification for touching the
> > > > > code which seems to be working relatively well is quite weak IMHO, yet
> > > > > it adds a non zero risk for breaking existing parsers.
> > > > 
> > > > I would take the saying of non zero risk for breaking existing parsers.
> > > > When considering this change, I thought about the possible risk. However,
> > > > found out the per-node stats was added in 2016 which is not so late, and
> > > > assume nobody will rely on the order of per-node stats embeded into a
> > > > zone. But I have to admit any concern or worry of risk is worth being
> > > > considerred carefully since /proc/zoneinfo is a classic interface.
> > > > 
> > > 
> > > For context, we started parsing /proc/zoneinfo in initscripts to be able 
> > > to determine the order in which vm.lowmem_reserve_ratio needs to be set 
> > > and this required my kernel change from 2017:
> > > 
> > > commit b2bd8598195f1b2a72130592125ac6b4218988a2
> > > Author: David Rientjes <rientjes@google.com>
> > > Date:   Wed May 3 14:52:59 2017 -0700
> > > 
> > >     mm, vmstat: print non-populated zones in zoneinfo
> > > 
> > > Otherwise, we found, it's much more difficult to determine how this array 
> > > should be structured.  So at least we parse this file very carefully, I'm 
> > > not sure how much others do, but it seems like an unnecessary risk for 
> > > little reward.  I'm happy to see it has been decided to drop this patch 
> > > and patch 5.
> > 
> > 
> > OK, I see why it is in such a situation, the empty zones were not printed. 
> > 
> > I could still not get how vm.lowmem_reserve_ratio is set with
> > /proc/zoneinfo in the old initscripts, do you see any risk if not
> > filling and showing the ->lowmem_reserve[] of empty zone in
> > patch 2 and 3?  Thanks in advance.
> 
> The point is why should we even care. Displaying that information
> shouldn't hurt anything, right?

Well, I would say why not. If saying anything hurted, I often check
/proc/zoneinfo to get information about system memory like many people,
I was wondering why the protection data is over there, but it's am
empty zone, and they protect what. I dare say it's more than once I
asked to myself, just sometime I am too lazy to start to make it clear
when focusing on another issue. Not sure if that is kind of hurting. I
would like to see it's not there to confuse me if anyone else have
stood up to fix it, I absolutely will vote for it.

Surely, we also need to evaluate if any risk or complexity is involved, 
While with my understanding, I don't see risk, and the change is quite
simple and easy to understand.

