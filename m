Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C034C54FD3
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A7B208CA
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TF2wKrnB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgCYOXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 10:23:30 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:28274 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727566AbgCYOX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 10:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585146207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GSFdRidEnIhtkPZ+oc94MfcptNw43s+nSxOUqCIguho=;
        b=TF2wKrnB46Sxgc5gAFmuqrqxltOKPkkT0EA0wtCnTFKZYzx4+Tr1kwrhOMJo3wfLrTKFWA
        mkoYWG72fc09isJwb0Qm905ugOzveTY/Gk93/Nph2xiIo5ZCu8QQaQ8jx2dL/tFE9syrQw
        z0eY9l/tNvaSQgGUB8S5E5SOIxvIEZA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-TMqCBrEgNSy-dYZve-7NeQ-1; Wed, 25 Mar 2020 10:23:23 -0400
X-MC-Unique: TMqCBrEgNSy-dYZve-7NeQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B966418A8C88;
        Wed, 25 Mar 2020 14:23:20 +0000 (UTC)
Received: from localhost (ovpn-12-88.pek2.redhat.com [10.72.12.88])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 154C291293;
        Wed, 25 Mar 2020 14:23:18 +0000 (UTC)
Date:   Wed, 25 Mar 2020 22:23:15 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Rientjes <rientjes@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        iamjoonsoo.kim@lge.com, hannes@cmpxchg.org, vbabka@suse.cz,
        mgorman@techsingularity.net
Subject: Re: [PATCH 4/5] mm/vmstat.c: move the per-node stats to the front of
 /proc/zoneinfo
Message-ID: <20200325142315.GC9942@MiWiFi-R3L-srv>
References: <20200324142229.12028-1-bhe@redhat.com>
 <20200324142229.12028-5-bhe@redhat.com>
 <alpine.DEB.2.21.2003241220360.34058@chino.kir.corp.google.com>
 <20200325055331.GB9942@MiWiFi-R3L-srv>
 <20200325085537.GZ19542@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325085537.GZ19542@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/25/20 at 09:55am, Michal Hocko wrote:
> On Wed 25-03-20 13:53:31, Baoquan He wrote:
> > On 03/24/20 at 12:25pm, David Rientjes wrote:
> > > On Tue, 24 Mar 2020, Baoquan He wrote:
> > > 
> > > > This moving makes the layout of /proc/zoneinfo more sensible. And there
> > > > are 4 zones at most currently, it doesn't need to scroll down much to get
> > > > to the 1st populated zone, even though the 1st populated zone is MOVABLE
> > > > zone.
> > > > 
> > > 
> > > Doesn't this introduce risk that it will break existing parsers of 
> > > /proc/zoneinfo in subtle ways?
> > > 
> > > In some cases /proc/zoneinfo is a tricky file to correctly parse because 
> > > you have to rely on the existing order in which it is printed to determine 
> > > which zone is being described.  We need to print zones even with unmanaged 
> > > pages, for instance, otherwise userspace may be unaware of which zones are 
> > > supported and what order they are in.  That's important to be able to 
> > > construct the proper string to use when writing vm.lowmem_reserve_ratio.
> > > 
> > > I'd prefer not changing the order of /proc/zoneinfo if it can be avoided 
> > > just because the risk outweighs the reward that we may break some 
> > > initscript parsers.
> > 
> > Oh, I may not describe the change and result clearly. This patch doesn't
> > change zone order at all.  I only move the per-node stats to the front of
> > each node, the zone order is completely kept the same, still DMA, DMA32,
> > NORMAL, MOVABLE.
> 
> Even this can break existing parsers. Fixing that up is likely not hard
> and existing parsers would be mostly debugging hacks here and there but
> I do miss any actual justification except for you considering it more
> sensible. I do not remember this would be a common pain point for people
> parsing this file. If anything the overal structure of the file makes it
> hard to parse and your patches do not really address that. We are likely
> too late to make the output much more sensible TBH.
> 
> That being said, I haven't looked more closely on your patches because I
> do not have spare cycles for that. Your justification for touching the
> code which seems to be working relatively well is quite weak IMHO, yet
> it adds a non zero risk for breaking existing parsers.

I would take the saying of non zero risk for breaking existing parsers.
When considering this change, I thought about the possible risk. However,
found out the per-node stats was added in 2016 which is not so late, and
assume nobody will rely on the order of per-node stats embeded into a
zone. But I have to admit any concern or worry of risk is worth being
considerred carefully since /proc/zoneinfo is a classic interface.

So, in view of objections from you and David, I would like to drop this
patch and patch 5. It's a small improvement, not worth taking any risk.
But if it goes back to this time of 2017, I would like to spend some
time to defend it :-)

commit e2ecc8a79ed49f7838b4fdf352c4c48cec9424ac
Author: Mel Gorman <mgorman@techsingularity.net>
Date:   Thu Jul 28 15:47:02 2016 -0700

    mm, vmstat: print node-based stats in zoneinfo file


