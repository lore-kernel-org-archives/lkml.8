Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5811CC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 21:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3983A20776
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 21:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388483AbgEXV3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 17:29:00 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:57804 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388451AbgEXV2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 17:28:54 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id D0DD11C02B1; Sun, 24 May 2020 23:28:52 +0200 (CEST)
Date:   Sun, 24 May 2020 23:28:51 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Paul J Murphy <paul.j.murphy@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/1] soc: keembay: Add Keem Bay IMR driver
Message-ID: <20200524212851.GG1192@bug>
References: <cover.1587485099.git.daniele.alessandrelli@intel.com>
 <13ca92165fab2827b6d439661e75f5b91ef083c2.1587485099.git.daniele.alessandrelli@intel.com>
 <20200501081002.GA1055721@kroah.com>
 <f60aece195cd0700728fc38b0398949a82b72fc3.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f60aece195cd0700728fc38b0398949a82b72fc3.camel@linux.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Like I said above, you just broke multi-system kernels by always
> > trying
> > to do this.  Trigger off of a hardware device that only your platform
> > has in order to properly load and run.  As-is, you don't want to do
> > this.
> 
> My bad, I didn't consider the issue of multi-platform ARM kernels.
> 
> The problem is that I need this code to be run early at boot, so I
> don't think I can make this a module.

How early is early enough?

What bootloader are you using?

I believe you should simply fix your bootloader not to pass locked memory to the kernel.

Alternatively, take that memory off the "memory available" maps, and only re-add it once
it is usable.

Anything else is dangerous.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
