Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D475C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 04:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B8FA20720
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 04:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgGEEz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 00:55:28 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:38201 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgGEEz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 00:55:27 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 0654t5TB003005;
        Sun, 5 Jul 2020 06:55:05 +0200
Date:   Sun, 5 Jul 2020 06:55:05 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     torvalds@linux-foundation.org, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>, Chris Mason <clm@fb.clm>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        tech-board-discuss@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CodingStyle: Inclusive Terminology
Message-ID: <20200705045505.GA2962@1wt.eu>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 04, 2020 at 01:02:51PM -0700, Dan Williams wrote:
> +Non-inclusive terminology has that same distracting effect which is why
> +it is a style issue for Linux, it injures developer efficiency.

I'm personally thinking that for a non-native speaker it's already
difficult to find the best term to describe something, but having to
apply an extra level of filtering on the found words to figure whether
they are allowed by the language police is even more difficult. *This*
injures developers efficiency. What could improve developers efficiency
is to take care of removing *all* idiomatic or cultural words then. For
example I've been participating to projects using the term "blueprint",
I didn't understand what that meant. It was once explained to me and
given that it had no logical reason for being called this way, I now
forgot. If we follow your reasoning, Such words should be banned for
exactly the same reasons. Same for colors that probably don't mean
anything to those born blind.

For example if in my local culture we eat tomatoes at starters and
apples for dessert, it could be convenient for me to use "tomato" and
"apple" as list elements to name the pointers leading to the beginning
and the end of the list, and it might sound obvious to many people, but
not at all for many others.

Maybe instead of providing an explicit list of a few words it should
simply say that terms that take their roots in the non-technical world
and whose meaning can only be understood based on history or local
culture ought to be avoided, because *that* actually is the real
root cause of the problem you're trying to address.

Willy
