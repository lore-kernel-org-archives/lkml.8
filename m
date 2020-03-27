Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28830C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 16:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E74F220737
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 16:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgC0Ql2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 12:41:28 -0400
Received: from ms.lwn.net ([45.79.88.28]:47238 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727593AbgC0Ql2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 12:41:28 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 03A11537;
        Fri, 27 Mar 2020 16:41:27 +0000 (UTC)
Date:   Fri, 27 Mar 2020 10:41:26 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     peter@bikeshed.quignogs.org.uk,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 0/1] Compactly make code examples into literal blocks
Message-ID: <20200327104126.667b5d5b@lwn.net>
In-Reply-To: <87imiqghop.fsf@intel.com>
References: <20200326192947.GM22483@bombadil.infradead.org>
        <20200326195156.11858-1-peter@bikeshed.quignogs.org.uk>
        <87imiqghop.fsf@intel.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Mar 2020 13:28:54 +0200
Jani Nikula <jani.nikula@linux.intel.com> wrote:

> IMHO the real problem is kernel-doc doing too much preprocessing on the
> input, preventing us from doing what would be the sensible thing in
> rst. The more we try to fix the problem by adding more kernel-doc
> processing, the further we dig ourselves into this hole.
> 
> If kernel-doc didn't have its own notion of section headers, such as
> "example:", we wouldn't have this problem to begin with. We could just
> use the usual rst construct; "example::" followed by an indented block.
> 
> I'm not going to stand in the way of the patch, but I'm telling you,
> this is going to get harder, not easier, on this path.

I agree with you in principle.  The problem, of course, is that this is a
legacy gift from before the RST days and it will be hard to change.

A quick grep shows that the pattern:

	* Example:

appears nearly 100 times in current kernels.  It is not inconceivable to
make a push to get rid of all of those, turning them into ordinary RST
syntax - especially since not all of those are actually kerneldoc
comments.

The same quick grep says that "returns?:" appears about 10,000 times.
*That* will be painful to change, and I can only imagine that some
resistance would have to be overcome at some point.

So what do folks think we should do? :)

I want to ponder on this for a bit.  Peter, that may mean that I hold this
patch past the 5.7 merge window, which perhaps makes sense at this point
anyway, sorry.  But I really would like to push things into a direction
that moves us away from gnarly perl hacks and toward something more
maintainable in the long term.

Thanks,

jon
