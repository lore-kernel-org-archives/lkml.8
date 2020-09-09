Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2FAC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 12:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBA8621941
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 12:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599655107;
	bh=kLzIbSajdRz1W80PzG78m/ukaUR6VgdyxOemY3uuv9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Bu9bID6jbBv2r16ur34lFZkkGCk5JUi7c4Qe0SS89keuqfOQCQipGpJqvfsCA0/3O
	 xspCjLPC+3voJ8UD5dAl2rbtoMNBAj3y77ohxUK3/ZB0CFZN6jqL1AgApiLkoxmEvB
	 nAOPKqZunyUS16NRTC6IwDAjDORUdrkwUO1Y2WWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgIIMhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 08:37:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:32920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730030AbgIIMae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 08:30:34 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0D0321D93;
        Wed,  9 Sep 2020 12:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599654591;
        bh=kLzIbSajdRz1W80PzG78m/ukaUR6VgdyxOemY3uuv9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XN1JLSjxX3db+1p0W9RYsRlQf4MqjgINmFg8dNg6De2EpU8/rLho7nnPFUQL3/bhs
         HaUn5avZLdYnGTOzc/XwLBALpYkHBCOm5SDTmUg0Z/saMCr8AguCOwFjMhtiwROwir
         F7bHFc4TnVjoLe4AO9CKYFvgTrBgp57hEi7rzq6U=
Date:   Wed, 9 Sep 2020 14:30:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
        Oscar Salvador <osalvador@suse.de>, rafael@kernel.org,
        nathanl@linux.ibm.com, cheloha@linux.ibm.com,
        stable@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: don't rely on system state to detect hot-plug
 operations
Message-ID: <20200909123001.GA670250@kroah.com>
References: <5cbd92e1-c00a-4253-0119-c872bfa0f2bc@redhat.com>
 <20200908170835.85440-1-ldufour@linux.ibm.com>
 <20200909074011.GD7348@dhcp22.suse.cz>
 <9faac1ce-c02d-7dbc-f79a-4aaaa5a73d28@linux.ibm.com>
 <20200909090953.GE7348@dhcp22.suse.cz>
 <4cdb54be-1a92-4ba4-6fee-3b415f3468a9@linux.ibm.com>
 <9ad553f2-ebbf-cae5-5570-f60d2c965c41@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ad553f2-ebbf-cae5-5570-f60d2c965c41@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 11:24:24AM +0200, David Hildenbrand wrote:
> >> I am not sure an enum is going to make the existing situation less
> >> messy. Sure we somehow have to distinguish boot init and runtime hotplug
> >> because they have different constrains. I am arguing that a) we should
> >> have a consistent way to check for those and b) we shouldn't blow up
> >> easily just because sysfs infrastructure has failed to initialize.
> > 
> > For the point a, using the enum allows to know in register_mem_sect_under_node() 
> > if the link operation is due to a hotplug operation or done at boot time.
> > 
> > For the point b, one option would be ignore the link error in the case the link 
> > is already existing, but that BUG_ON() had the benefit to highlight the root issue.
> > 
> 
> WARN_ON_ONCE() would be preferred  - not crash the system but still
> highlight the issue.

Many many systems now run with 'panic on warn' enabled, so that wouldn't
change much :(

If you can warn, you can properly just print an error message and
recover from the problem.

thanks,

greg k-h
