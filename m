Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72709C433EC
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FA2720704
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgGQIff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:35:35 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:56494 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgGQIfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 04:35:32 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 003E01C0BEB; Fri, 17 Jul 2020 10:35:28 +0200 (CEST)
Date:   Fri, 17 Jul 2020 10:35:27 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     torvalds@linux-foundation.org, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>, Chris Mason <clm@fb.clm>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        tech-board-discuss@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CodingStyle: Inclusive Terminology
Message-ID: <20200717083527.GA1027@bug>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +On the triviality of replacing words
> +====================================
> +
> +The African slave trade was a brutal system of human misery deployed at
> +global scale. Some word choice decisions in a modern software project
> +does next to nothing to compensate for that legacy. So why put any
> +effort into something so trivial in comparison? Because the goal is not
> +to repair, or erase the past. The goal is to maximize availability and
> +efficiency of the global developer community to participate in the Linux
> +kernel development process.

I'd preffer to keep politics out of kernel.

> +of 'blacklist' is devoid of a historical racial connection. However, one
> +thought exercise is to consider replacing 'blacklist/whitelist' with
> +'redlist/greenlist'. Realize that the replacement only makes sense if
> +you have been socialized with the concepts that 'red/green' implies
> +'stop/go'. Colors to represent a policy requires an indirection. The

So you are trying to blacklist colors. That's stupid.

> +socialization of 'black/white' to have the connotation of
> +'impermissible/permissible' does not support inclusion.
> +
> +Inclusion == global developer community efficiency.

It seems inclusion == reason to push politics and questionable patches
into kernel. That is opposite of efficiency.

:-(
										Pavel
 
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
