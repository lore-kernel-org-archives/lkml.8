Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E60C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12F6B20781
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FaQBXdVw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgF2Xay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:30:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26274 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726317AbgF2Xay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 19:30:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593473452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J4yvYvAixEsOBHxzNK+u9dCnbkwzUtROOEW2TKDDrHo=;
        b=FaQBXdVwDofc0Gy7q03QDxPh6SOxNC2py8ZrZXf2MefRJ8VmDEnomnzax7ajn4x8t1LsFX
        umSUWg55Z30Do4DSoGrQNqDni80oCkQKOvSTlxDCFQiTL65xHPm9zv7YfMCNDdU+RePFyd
        wAPtDU/GKOTHkOgVajkD8iwvfIlcpUQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-kG66Rb4yN2SGdD26cHNb3A-1; Mon, 29 Jun 2020 19:30:48 -0400
X-MC-Unique: kG66Rb4yN2SGdD26cHNb3A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8443107ACCA;
        Mon, 29 Jun 2020 23:30:46 +0000 (UTC)
Received: from localhost (ovpn-12-47.pek2.redhat.com [10.72.12.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1019D5D9D7;
        Mon, 29 Jun 2020 23:30:45 +0000 (UTC)
Date:   Tue, 30 Jun 2020 07:30:43 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ben.widawsky@intel.com, alex.shi@linux.alibaba.com,
        dwagner@suse.de, tobin@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, stable@kernel.org
Subject: Re: [PATCH] mm/vmscan: restore zone_reclaim_mode ABI
Message-ID: <20200629233043.GK3346@MiWiFi-R3L-srv>
References: <20200626003459.D8E015CA@viggo.jf.intel.com>
 <20200629065203.GJ3346@MiWiFi-R3L-srv>
 <3ba94f19-3b18-9d52-a070-f652620c88e6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ba94f19-3b18-9d52-a070-f652620c88e6@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/29/20 at 07:27am, Dave Hansen wrote:
> On 6/28/20 11:52 PM, Baoquan He wrote:
> > On 06/25/20 at 05:34pm, Dave Hansen wrote:
> >>
> >> From: Dave Hansen <dave.hansen@linux.intel.com>
> >>
> >> I went to go add a new RECLAIM_* mode for the zone_reclaim_mode
> >> sysctl.  Like a good kernel developer, I also went to go update the
> >> documentation.  I noticed that the bits in the documentation didn't
> >> match the bits in the #defines.
> >>
> >> The VM evidently stopped caring about RECLAIM_ZONE at some point (or
> >> never cared) and the #define itself was later removed as a cleanup.
> > 
> >>From git history, it seems to never care about the RECLAIM_ZONE bit.
> > 
> > I think this patch is justified. I have one question about adding back
> > the RECLAIM_ZONE bit. Since we introduced RECLAIM_ZONE in the first
> > place, but never use it, removing it truly may fail some existing
> > script, does it mean we will never have chance to fix/clean up this kind
> > of mess?
> 
> Our #1 rule is "don't break userspace".  We only break userspace when we
> have no other choice.
> 
> This case a bit fuzzier because we don't know if anyone is depending on
> the ignored bit to do anything.  But, it *was* documented.  To me, that
> means it might have been used, even though it would have been a
> "placebo" bit.
> 
> > Do we have possibility to remove it in mainline tree, let distos or
> > stable kernel maintainer take care of the back porting? Like this, any
> > stable kernel after 5.8, or any distrols which chooses post v5.8 kenrel
> > as base won't have this confusion. I am not objecting this patch, just
> > be curious if we have a way to fix/clean up for this type of issue.
> 
> The only way I can plausibly think of "cleaning up" the RECLAIM_ZONE bit
> would be to raise our confidence that it is truly unused.  That takes
> time, and probably a warning if we see it being set.  If we don't run
> into anybody setting it or depending on it being set in a few years, we
> can remove it.

So adding the old bit back for compatibility looks good, thanks.

Then we have to be very careful when adding and reviewing new
interface introducing, should not leave one which might be used
in the future.

In fact, RECLAIM_ZONE is not completely useless. At least, when the old
bit 0 is set, it may enter into node_reclaim() in get_page_from_freelist(),
that makes it like a switch.

get_page_from_freelist {

	...
                        if (node_reclaim_mode == 0 ||                                                                                             
                            !zone_allows_reclaim(ac->preferred_zoneref->zone, zone))
                                continue;
	...
}


> 
> Backporting a _warning_ into the -stable trees might be an interesting
> way to find users of older kernels mucking with it.
> 

