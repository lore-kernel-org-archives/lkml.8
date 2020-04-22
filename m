Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53148C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37DA320767
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgDVPx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 11:53:56 -0400
Received: from smtprelay0251.hostedemail.com ([216.40.44.251]:36456 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726494AbgDVPxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:53:55 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id B5D6B100E7B52;
        Wed, 22 Apr 2020 15:53:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: flock01_794fcb3173706
X-Filterd-Recvd-Size: 2052
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Wed, 22 Apr 2020 15:53:53 +0000 (UTC)
Message-ID: <2539aded26601a969999065fb1b4c780a22e307f.camel@perches.com>
Subject: Re: [PATCH v4 4/7] kernel.h: Split out min()/max() et al helpers
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Apr 2020 08:51:35 -0700
In-Reply-To: <20200422154402.GK185537@smile.fi.intel.com>
References: <20200422125201.37618-1-andriy.shevchenko@linux.intel.com>
         <20200422125201.37618-4-andriy.shevchenko@linux.intel.com>
         <5b413a379b8bba39fb75469699b7fd0d50d67e96.camel@perches.com>
         <20200422154402.GK185537@smile.fi.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-04-22 at 18:44 +0300, Andy Shevchenko wrote:
> On Wed, Apr 22, 2020 at 07:52:32AM -0700, Joe Perches wrote:
> > On Wed, 2020-04-22 at 15:51 +0300, Andy Shevchenko wrote:
> > > kernel.h is being used as a dump for all kinds of stuff for a long time.
> > > Here is the attempt to start cleaning it up by splitting out min()/max()
> > > et al helpers.
> > 
> > While adding organization into kernel.h by splitting
> > out various bits into separate files is a fine idea,
> > I believe removing the generic #include <linux/kernel.h>
> > from various files and substituting the sub-includes
> > is not a good idea.
> 
> Are you sure?

Yes.

> Perhaps we may just cat include/linux/* > include/linux/kernel.h?

Silly argument,  There's a real argument to be made to
tmove many of the files in include/linux to separate
directories or out of include/ altogether to subsystem
specific locations.


