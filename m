Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02507C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C89C72088E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590612412;
	bh=WtewfCOjGK26oPHbewPKO/Ed9S5SuwHAhFqHb/iW9lI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=y/ltjyWXRx+0XRHRIuJVp7yu0Uv/gC12Att7MfX4kf/yHdnzvY8Hp3TgXV3NTBOlM
	 me+OfK5+gkxHpy/GRYlgyibDwZ1Eon1SFoGQnv4qMPpILXF4kGeH7XIeBK+mJ8W2VN
	 a1Nrsk8duZRqmA94Ogsx2np+NmSWAcJjNqIMq/Tw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgE0Uqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 16:46:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:54150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbgE0Uqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 16:46:51 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A40DF20835;
        Wed, 27 May 2020 20:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590612411;
        bh=WtewfCOjGK26oPHbewPKO/Ed9S5SuwHAhFqHb/iW9lI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NO0SQ8+GOeQNww2TBIOhZ3ZJW+IHvsP/vDuNS/adxh1+oPqQk5DDLFkJzMHP16SeD
         haki2yvy9WB+YElCIlr8hWG110jeYwuA0PmIYUQfa1umaWAdHakBpokJrnU+vrMiHN
         AqtAQIhm7u7Zu/mXSsJhv6nTrkx5Q5NqHu7d9k2g=
Date:   Wed, 27 May 2020 13:46:50 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Shakeel Butt <shakeelb@google.com>, Mel Gorman <mgorman@suse.de>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@surriel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend 3/3] mm: fix LRU balancing effect of new
 transparent huge pages
Message-Id: <20200527134650.18b3fb3f0be85bb73037da20@linux-foundation.org>
In-Reply-To: <20200527194148.GA47905@cmpxchg.org>
References: <20200527182958.252402-1-shakeelb@google.com>
        <20200527194148.GA47905@cmpxchg.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 May 2020 15:41:48 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

> On Wed, May 27, 2020 at 11:29:58AM -0700, Shakeel Butt wrote:
> > From: Johannes Weiner <hannes@cmpxchg.org>
> > 
> > Currently, THP are counted as single pages until they are split right
> > before being swapped out. However, at that point the VM is already in
> > the middle of reclaim, and adjusting the LRU balance then is useless.
> > 
> > Always account THP by the number of basepages, and remove the fixup
> > from the splitting path.
> > 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> 
> This is now already in mm as part of the "mm: balance LRU lists based
> on relative thrashing" series that I sent out last week and where it
> was originally from.

Yup.  I hope [1/3] and [2/3] weren't urgent?  Due to a horrid merge
mismatchmishmashmess I've staged them behind lots of other things,
notably

thp/khugepaged improvements and CoW semantics
http://lkml.kernel.org/r/20200416160026.16538-1-kirill.shutemov@linux.intel.com

and mm: memcontrol: charge swapin pages on instantiation
http://lkml.kernel.org/r/20200508183105.225460-1-hannes@cmpxchg.org

and mm: balance LRU lists based on relative thrashing
http://lkml.kernel.org/r/20200520232525.798933-1-hannes@cmpxchg.org


