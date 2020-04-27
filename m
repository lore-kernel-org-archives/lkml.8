Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE592C81CFF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 23:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 775842072A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 23:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588030561;
	bh=xmk7CyW+Iq+Rc+TKxRT/9WDnIkypckD7+blQ1n4svRo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=V//nxWocM8ZTspjyJLAyIp1gXxFawe4uNt4AdYcWfxI8qBSAMGVGmVBqG1Eme0Fci
	 /7vsKGoIAO6lR6rcjZtDHxEWgxkJ2WwF45LJDu146QHYhkn7Cwa87NeIAHN/NnInYG
	 zh2RXbSx0JkRiwR5kdUx3CDrw0JGHrMq+peX9tKM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgD0XgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 19:36:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:37372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbgD0XgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 19:36:00 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FDB4206D4;
        Mon, 27 Apr 2020 23:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588030559;
        bh=xmk7CyW+Iq+Rc+TKxRT/9WDnIkypckD7+blQ1n4svRo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2cpPjegOkw3YBWsW96LWmxnh3azEbh7CSJHStLSLXp5TY4TnoMr9NfVaRauY6i1R+
         proOSGIherCc6G0gUH/650UezzeWUFWcYKzAw3D1USFGbqChxVC67gwszbXI5FvtYd
         AZd7HzTIQLujQMJGLpIyy6ZZ8tf1tzRdAQRThkBc=
Date:   Mon, 27 Apr 2020 16:35:58 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] mm, oom: stop reclaiming if GFP_ATOMIC will start
 failing soon
Message-Id: <20200427163558.5b08487d63da3cc7a89bf50b@linux-foundation.org>
In-Reply-To: <alpine.DEB.2.22.394.2004271558540.248401@chino.kir.corp.google.com>
References: <alpine.DEB.2.22.394.2004241347310.70176@chino.kir.corp.google.com>
        <20200425172706.26b5011293e8dc77b1dccaf3@linux-foundation.org>
        <alpine.DEB.2.22.394.2004261959310.80211@chino.kir.corp.google.com>
        <20200427133051.b71f961c1bc53a8e72c4f003@linux-foundation.org>
        <alpine.DEB.2.22.394.2004271558540.248401@chino.kir.corp.google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Apr 2020 16:03:56 -0700 (PDT) David Rientjes <rientjes@google.com> wrote:

> On Mon, 27 Apr 2020, Andrew Morton wrote:
> 
> > > No - that would actually make the problem worse.
> > > 
> > > Today, per-zone min watermarks dictate when user allocations will loop or 
> > > oom kill.  should_reclaim_retry() currently loops if reclaim has succeeded 
> > > in the past few tries and we should be able to allocate if we are able to 
> > > reclaim the amount of memory that we think we can.
> > > 
> > > The issue is that this supposes that looping to reclaim more will result 
> > > in more free memory.  That doesn't always happen if there are concurrent 
> > > memory allocators.
> > > 
> > > GFP_ATOMIC allocators can access below these per-zone watermarks.  So the 
> > > issue is that per-zone free pages stays between ALLOC_HIGH watermarks 
> > > (the watermark that GFP_ATOMIC allocators can allocate to) and min 
> > > watermarks.  We never reclaim enough memory to get back to min watermarks 
> > > because reclaim cannot keep up with the amount of GFP_ATOMIC allocations.
> > 
> > But there should be an upper bound upon the total amount of in-flight
> > GFP_ATOMIC memory at any point in time?  These aren't like pagecache
> > which will take more if we give it more.  Setting the various
> > thresholds appropriately should ensure that blockable allocations don't
> > get their memory stolen by GPP_ATOMIC allocations?
> > 
> 
> Certainly if that upper bound is defined and enforced somewhere we would 
> not have run into this issue causing all userspace to become completely 
> unresponsive.  Do you have links to patches that proposed enforcing this 
> upper bound?

There is no such enforcement and there are no such patches, as I'm sure
you know.

No consumer of GFP_ATOMIC memory should consume an unbounded amount of
it.  Subsystems such as networking will consume a certain amount and
will then start recycling it.  The total amount in-flight will vary
over the longer term as workloads change.  A dynamically tuning
threshold system will need to adapt rapidly enough to sudden load
shifts, which might require unreasonable amounts of headroom.

Michal asked relevant questions regarding watermark tuning - an ansewr
to those would be interesting.  To amplify that, is it possible to
manually tune this system so that the problem no longer exhibits?  If
so, then why can't that tuning be performed automatically?
