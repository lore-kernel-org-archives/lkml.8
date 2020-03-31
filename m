Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F866C2D0F2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194B4214DB
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585673025;
	bh=FjSFAHe7QVSkuOBQVhx+RMwcv3gaGtV+UbZ9uyd09qw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=euSSrp8RypodF+qdEBEdf3m3i+/Ya/STlvCsecih/Q0jXJMg/8bKWYsm378c2fNLU
	 D6BLkylHqtL75ICUTDgxbKKFDvDVMq9cZorrxFOLGC5fGGjIMAyDw1y97nTZEuAHiR
	 5y6iWa0ohZ/VIYm9XUp8VqjI9mHojc2DKsvZ86a4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731151AbgCaQno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:43:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:43780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730442AbgCaQnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 12:43:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C980B212CC;
        Tue, 31 Mar 2020 16:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585673023;
        bh=FjSFAHe7QVSkuOBQVhx+RMwcv3gaGtV+UbZ9uyd09qw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gtcmxeicZKh5jZZK+x/9JuKvuHOM+bXbOcLenv9uX1xXWKUeOw1FnwCwu+QDvCQ7l
         yQJtlpsdtOiejFL9dS3iUH/6OTU7tkDCInaP73vKsqt54GgF3+CkHjJZIgwriQYyea
         /qZz4D4aFQOMgPxixgZsl+mpWuU0eG4T19kuHR0k=
Date:   Tue, 31 Mar 2020 18:43:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Grant Likely <grant.likely@arm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, nd@arm.com,
        Jonathan Corbet <corbet@lwn.net>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH] Add documentation on meaning of -EPROBE_DEFER
Message-ID: <20200331164340.GA1821785@kroah.com>
References: <20200327170132.17275-1-grant.likely@arm.com>
 <20200331143355.GP1922688@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331143355.GP1922688@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 05:33:55PM +0300, Andy Shevchenko wrote:
> On Fri, Mar 27, 2020 at 05:01:32PM +0000, Grant Likely wrote:
> > Add a bit of documentation on what it means when a driver .probe() hook
> > returns the -EPROBE_DEFER error code, including the limitation that
> > -EPROBE_DEFER should be returned as early as possible, before the driver
> > starts to register child devices.
> > 
> > Also: minor markup fixes in the same file
> 
> Greg, can we at least for time being have this documented, means applied?

It's the middle of the merge window, you know I can't take anything in
my trees until after -rc1 is out.

I will queue it up then, thanks.

greg k-h
