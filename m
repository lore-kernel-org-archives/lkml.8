Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65265C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 446A62078A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598609008;
	bh=RQlCnu43eUxNNFUssnsTP3qzoHz2WEO8IwmtO5lhNC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1dubvT4ZgWY/gIopLDqkkiuI5ZI/pmE8HASa2bYmdLygZt9CpOM9s2V/7O2+LlhPI
	 3Il0DRxsK4rP7fkgBxz9uGZLrp0pShfRCmYb+eayXQMG7B0ceNybiQzSLxvEMcSkQ8
	 PXgvEhqprq+yEWoLCuEJIwCt05gUhJgaGFnevseI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbgH1KD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 06:03:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728554AbgH1KDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 06:03:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB12A2078A;
        Fri, 28 Aug 2020 10:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598609003;
        bh=RQlCnu43eUxNNFUssnsTP3qzoHz2WEO8IwmtO5lhNC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TH5buM50h70sZhztUtst0nYI+ozLU9ONQohRaIK+i6v8/tsTU6NhiOahWQaodUgMq
         ZklCd5rArUrJJqYb+J46rZitgiLMZx8nv6KAgZ57m/64sB5Vsc7Ga5HJ7YeRHMZJ5G
         E5FnlL3QjkH97l4xfKwHDjZc51RfIBljd1OZyJNo=
Date:   Fri, 28 Aug 2020 12:03:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Rajmohan Mani <rajmohan.mani@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jithu Joseph <jithu.joseph@intel.com>,
        =?utf-8?B?Qmxhxb4=?= Hrastnik <blaz@mxxn.io>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-usb@vger.kernel.org, pmalani@chromium.org,
        bleung@chromium.org
Subject: Re: [PATCH v2 1/3] platform/x86: Add Intel Input Output Manager
 (IOM) driver
Message-ID: <20200828100335.GB1229122@kroah.com>
References: <20200822040508.23510-1-rajmohan.mani@intel.com>
 <20200822040508.23510-2-rajmohan.mani@intel.com>
 <20200828074359.GC942935@kroah.com>
 <20200828090832.GB174928@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828090832.GB174928@kuha.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 12:08:32PM +0300, Heikki Krogerus wrote:
> Hi Greg,
> 
> On Fri, Aug 28, 2020 at 09:43:59AM +0200, Greg Kroah-Hartman wrote:
> > I still find this crazy that a whole separate driver is created just to
> > read a single 32bit value.
> > 
> > Why not put this logic in the driver that wants to read that value?
> > That would be much simpler, smaller, and more obvious.
> 
> That would mean that we start maintaining something like DMI quirk
> table in those drivers. Unfortunately the IOM device is not available
> on every platform. Also, even on platforms that do have it, there is
> no guarantee that the device is always going to be mapped to the same
> address.

Ok, but putting it in another driver has the same problem as you are now
depending on that driver with the driver that calls this, right?

The quirk table would go in here, but not somewhere else?

And if this really is only for typec stuff, put it in the typec
directory, not burried off in the platform driver subdir please.

> Nevertheless, I was originally hoping that we could hide the handling
> of IOM somehow in ACPI without the need for an actual device object,
> but it now turns out that the other features of the IOM chip have
> created interest. At least our i915 guys probable have some use for it
> (I don't know exactly what they are planning to use it for).
> 
> So the fact that we may later need the device for something else, on
> top of the clumsiness and most importantly risks involved with using
> ACPI to take care of extra tasks (ASL tends to have bugs - bugs that
> may never ever get fixed), I think the IOM device object, and the
> driver that binds to it, do have a valid reason for existing.

Handle the situation today, if, in the future, someone else needs/wants
this, _then_ work on splitting it out into separate pieces.  Don't
create additional complexity today, for no benefit today.  It's already
caused numerous review comments/complaints the way this is designed...

thanks,

greg k-h
