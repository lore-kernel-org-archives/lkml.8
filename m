Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B6FC18E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DACA2078A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585127866;
	bh=O5zuwJl91AFd7MscBmhUtsj5ZFC4U3siLzGGEaEkN2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E5lBHjaIFub50x78BJF25YpCWXQhsou2BW/4ZiujT/MPc7OM9uoW9GgJU8ZVLqT2L
	 Ljo3w7QP3ltuIq1c7x9jme4xji3SliOBYXnFiWfr0QFevu4vjeYhHQYVQz0gtZ/PCA
	 /iid/qdcYQTVAzFGrGytO7Dl3H6Zcu741YwgE9p0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgCYJRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 05:17:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:56536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbgCYJRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 05:17:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AD47206F6;
        Wed, 25 Mar 2020 09:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585127864;
        bh=O5zuwJl91AFd7MscBmhUtsj5ZFC4U3siLzGGEaEkN2A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=knk5nCIcbeXtOdvYzVxPIwATrwKYVedED8x5V9y+WFcUIBJWuX2xTpBZswXV35Am6
         rI68eowXopJxOdZBm8qxAzm4UYv/fGGtb4jYTI3+IaM9Wc2K1EL6fxrtNcAPKWPF+4
         zH7o6hXN4PhRAt5FQ2y3kgRs4WMhiD4xUKqWyTvA=
Date:   Wed, 25 Mar 2020 10:17:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Davide Caratti <dcaratti@redhat.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vladimir Benes <vbenes@redhat.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] driver core: Skip unnecessary work when device
 doesn't have sync_state()
Message-ID: <20200325091734.GA3073501@kroah.com>
References: <20200221080510.197337-1-saravanak@google.com>
 <20200221080510.197337-4-saravanak@google.com>
 <f22b7cd6fb6256f56e908e021f4fe389f3a6ee07.camel@redhat.com>
 <20200325074428.GA3014101@kroah.com>
 <e1733a5fd6f6bbeeae82c0cbc62c17675818bb6c.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1733a5fd6f6bbeeae82c0cbc62c17675818bb6c.camel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 10:11:19AM +0100, Davide Caratti wrote:
> On Wed, 2020-03-25 at 08:44 +0100, Greg Kroah-Hartman wrote:
> > On Tue, Mar 24, 2020 at 09:03:28PM +0100, Davide Caratti wrote:
> > > On Fri, 2020-02-21 at 00:05 -0800, Saravana Kannan wrote:
> > > > A bunch of busy work is done for devices that don't have sync_state()
> > > > support. Stop doing the busy work.
> > > > 
> > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > ---
> > > >  drivers/base/core.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > 
> > > 
> > > hello Greg,
> > > 
> > > this patch and patch 2/3 of the same series proved to fix systematic
> > > crashes (NULL pointer dereference in device_links_flush_sync_list() while
> > > loading mac80211_hwsim.ko, see [1]) on Fedora 31, that are triggered by
> > > NetworkManager-ci [2]. May I ask to queue these two patches for the next
> > > 5.5 stable?
> > 
> > What are the git commit ids of these patches in Linus's tree that you
> > want backported?
> 
> right, I should have mentioned them also here: 
> 
> ac338acf514e "(driver core: Add dev_has_sync_state())" <-- patch 2/3 
> 77036165d8bc "(driver core: Skip unnecessary work when device doesn't have sync_state())" <-- patch 3/3
> 
> like Saravana mentioned, the problem is probably introduced by patch
> 1/3 of the series, 
> 
> 77036165d8bc "(driver core: Skip unnecessary work when device doesn't have sync_state())"
> 
> that's already in stable 5.5.

Now queued up, thanks!

greg k-h
