Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E501FC35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 10:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA043207FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 10:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582281158;
	bh=28w4tF8+nJO7Wfx8ImCYA2NdorvJ+P431dmFqTMjq8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MrJDjXgRWNtJR9B6Ij/d4ypXWg6rfNJiEJL7sDNUoWo2BICRry2Nzxq/uGg0Xch9v
	 8qYnRlc1RzOxuHj5BJqCvBEJ5HRpslvYTtwyiMwrCU8zDQHq3OK0ZXlvfTz7PU6EUW
	 0kWcDvBG/ugbOPsmSqqVOOpYrSQjEjt5IRw0byGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbgBUKch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 05:32:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:54470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgBUKch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 05:32:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92D88207FD;
        Fri, 21 Feb 2020 10:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582281156;
        bh=28w4tF8+nJO7Wfx8ImCYA2NdorvJ+P431dmFqTMjq8I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZnGxUZ2QpCHmhv5qOZp0G08sGbK1AztHqYn35ryNv9A3JQSFXmisDUpeivEMySmJA
         i11/TTbYcbjxnZdQ9SYpGQWTZRtTRjGrL+MzKztXlhl9gQxdRCzTksBfnbNRgk4b03
         xcYeQfq/xrqBo8zrgWM6QxoG6KjKwzMi4d9pqs5Y=
Date:   Fri, 21 Feb 2020 11:32:33 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] driver core: Call sync_state() even if supplier
 has no consumers
Message-ID: <20200221103233.GA101069@kroah.com>
References: <20200221080510.197337-1-saravanak@google.com>
 <20200221080510.197337-2-saravanak@google.com>
 <20200221092540.GA71325@kroah.com>
 <CAGETcx_yQZtU4O2KgMxVt-hSJCBtNsOpyWsSXc+OZcjjJ91M3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx_yQZtU4O2KgMxVt-hSJCBtNsOpyWsSXc+OZcjjJ91M3g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 01:48:49AM -0800, Saravana Kannan wrote:
> On Fri, Feb 21, 2020 at 1:25 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Feb 21, 2020 at 12:05:08AM -0800, Saravana Kannan wrote:
> > > The initial patch that added sync_state() support didn't handle the case
> > > where a supplier has no consumers. This was because when a device is
> > > successfully bound with a driver, only its suppliers were checked to see
> > > if they are eligible to get a sync_state(). This is not sufficient for
> > > devices that have no consumers but still need to do device state clean
> > > up. So fix this.
> > >
> > > Fixes: fc5a251d0fd7ca90 (driver core: Add sync_state driver/bus callback)
> >
> > Should be:
> > Fixes: fc5a251d0fd7 ("driver core: Add sync_state driver/bus callback")
> 
> Sorry, late night sleepy patches are never good!
> Btw I thought the sha should be only 12 characters but then saw
> another instance where you used 16 chars. What's the right one?

I used 16 chars?  12 should be all that is needed.

> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> >
> > So this needs to go to 5.5 also, right?
> 
> Did you mean 5.4? Yes.

fc5a251d0fd7 is only in 5.5, not 5.4 from what I can see, right?

thanks,

greg k-h
