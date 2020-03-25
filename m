Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982DCC1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 07:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A3720714
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 07:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585122274;
	bh=h00DKjvaMCi5zKyS+9zyKVJ8bQ5REmj0Cw5CADaalFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l1S/KHmdd45QfHuZceYIONC4N3XRm9r2rjU2bb4ghe8kDwH/YPwY4fV6JpO5r/RZ5
	 JkZorBneZhkGXfTmQnbjZilnbf8l+YS28XR5WyRzdoMB4vbPMrkCZWqhx+ZvDkm8mP
	 8cCXdK/QmPXLBQoJIQBQxhVsDa08aPUwzEgGbFVk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgCYHod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 03:44:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbgCYHod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 03:44:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B77F20409;
        Wed, 25 Mar 2020 07:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585122272;
        bh=h00DKjvaMCi5zKyS+9zyKVJ8bQ5REmj0Cw5CADaalFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rwsu0OjgZqJYC/SvFbOZS1Gjfx0P5PZ6QI8fS0u+ewiUDSTWReFy5l/bbPXBcX/1t
         3HUa+Tt+K/HiAUWzzTGYmtzyPMFlvWhNN1bVluqbQiVtPfhczOwU8rQ8GCznInt/ra
         9VwqkiGdU25MJ2fwgvjnJsBT+58pAf+G1BHr71/k=
Date:   Wed, 25 Mar 2020 08:44:28 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Davide Caratti <dcaratti@redhat.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vladimir Benes <vbenes@redhat.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] driver core: Skip unnecessary work when device
 doesn't have sync_state()
Message-ID: <20200325074428.GA3014101@kroah.com>
References: <20200221080510.197337-1-saravanak@google.com>
 <20200221080510.197337-4-saravanak@google.com>
 <f22b7cd6fb6256f56e908e021f4fe389f3a6ee07.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f22b7cd6fb6256f56e908e021f4fe389f3a6ee07.camel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 09:03:28PM +0100, Davide Caratti wrote:
> On Fri, 2020-02-21 at 00:05 -0800, Saravana Kannan wrote:
> > A bunch of busy work is done for devices that don't have sync_state()
> > support. Stop doing the busy work.
> > 
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/base/core.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> 
> hello Greg,
> 
> this patch and patch 2/3 of the same series proved to fix systematic
> crashes (NULL pointer dereference in device_links_flush_sync_list() while
> loading mac80211_hwsim.ko, see [1]) on Fedora 31, that are triggered by
> NetworkManager-ci [2]. May I ask to queue these two patches for the next
> 5.5 stable?

What are the git commit ids of these patches in Linus's tree that you
want backported?

thanks,

greg k-h
