Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11050C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 01:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA622085B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 01:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgBEBSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 20:18:51 -0500
Received: from smtprelay0098.hostedemail.com ([216.40.44.98]:33389 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727673AbgBEBSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 20:18:50 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 292C9100E7B42;
        Wed,  5 Feb 2020 01:18:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cap53_4cbb811b77b29
X-Filterd-Recvd-Size: 2755
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Wed,  5 Feb 2020 01:18:47 +0000 (UTC)
Message-ID: <ee9b52c291fe7f090d6516397db978eaaae6c657.camel@perches.com>
Subject: Re: [PATCH v2 1/2] kernel.h: Split out min()/max() et al helpers
From:   Joe Perches <joe@perches.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Trond@black.fi.intel.com,
        Myklebust@black.fi.intel.com, trond.myklebust@hammerspace.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 04 Feb 2020 17:17:36 -0800
In-Reply-To: <c02c86a1-5df3-1b94-78a7-3948bd9e64cb@rasmusvillemoes.dk>
References: <20200204170412.30106-1-andriy.shevchenko@linux.intel.com>
         <c02c86a1-5df3-1b94-78a7-3948bd9e64cb@rasmusvillemoes.dk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-02-05 at 00:23 +0100, Rasmus Villemoes wrote:
> On 04/02/2020 18.04, Andy Shevchenko wrote:
> > kernel.h is being used as a dump for all kinds of stuff for a long time.
> > Here is the attempt to start cleaning it up by splitting out min()/max()
> > et al helpers.
> > 
> > At the same time convert users in header and lib folder to use new header.
> > Though for time being include new header back to kernel.h to avoid twisted
> > indirected includes for existing users.
> 
> This is definitely long overdue, so thanks for taking this on. I think
> minmax.h is fine as a header on its own, but for the other one, I think
> you should go even further - and perhaps all these should go in a
> include/math/ dir (include/linux/ has ~1200 files), so we'd have
> math/minmax.h, math/round.h, math/ilog2.h, math/gcd.h etc., each
> containing just enough #includes to be self-contained (so if there's a
> declaration of something taking a u32, there's no way around having it
> include types.h (or wherever that's defined).

I think that's not at all desirable.

kernel.h as a monolithic include block is pretty useful.

Separating out the various bits into separate files is
OK, but kernel.h should #include them all.

One day a precompiled header of just kernel.h would be
useful to reduce overall compilation time.  Converting
all the other source files that use a small part of the
existing kernel.h into multiple includes would not allow
precompiled headers to work efficiently.



