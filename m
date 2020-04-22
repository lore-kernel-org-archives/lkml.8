Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6399AC55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 495BE2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgDVOyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 10:54:52 -0400
Received: from smtprelay0091.hostedemail.com ([216.40.44.91]:57008 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725934AbgDVOyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 10:54:52 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 31594181D3025;
        Wed, 22 Apr 2020 14:54:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: beast64_2a3913899b22e
X-Filterd-Recvd-Size: 2052
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Wed, 22 Apr 2020 14:54:50 +0000 (UTC)
Message-ID: <5b413a379b8bba39fb75469699b7fd0d50d67e96.camel@perches.com>
Subject: Re: [PATCH v4 4/7] kernel.h: Split out min()/max() et al helpers
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Apr 2020 07:52:32 -0700
In-Reply-To: <20200422125201.37618-4-andriy.shevchenko@linux.intel.com>
References: <20200422125201.37618-1-andriy.shevchenko@linux.intel.com>
         <20200422125201.37618-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-04-22 at 15:51 +0300, Andy Shevchenko wrote:
> kernel.h is being used as a dump for all kinds of stuff for a long time.
> Here is the attempt to start cleaning it up by splitting out min()/max()
> et al helpers.

While adding organization into kernel.h by splitting
out various bits into separate files is a fine idea,
I believe removing the generic #include <linux/kernel.h>
from various files and substituting the sub-includes
is not a good idea.

> At the same time convert users in header and lib folder to use new header.
> Though for time being include new header back to kernel.h to avoid twisted
> indirected includes for existing users.

Yeah, that's the difficult bit and it could make
using precompiled headers very cumbersome.

I'd rather make #include <linux/kernel.h>" _more_
common or even used as the mandatory first #include
for all kernel .c files.

That would also ensure that common kernel facilities
are not duplicated or have naming conflicts with other
files.


