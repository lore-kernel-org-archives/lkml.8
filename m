Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3682C3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 10:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A4D2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 10:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbgBXK5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 05:57:14 -0500
Received: from elvis.franken.de ([193.175.24.41]:35154 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727281AbgBXK5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 05:57:14 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1j6BQF-0000pf-01; Mon, 24 Feb 2020 11:57:11 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 65D5CC0E4C; Mon, 24 Feb 2020 11:56:56 +0100 (CET)
Date:   Mon, 24 Feb 2020 11:56:56 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Paul Burton <paulburton@kernel.org>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v2] MAINTAINERS: Hand MIPS over to Thomas
Message-ID: <20200224105656.GB8335@alpha.franken.de>
References: <20200222170417.1531867-1-paulburton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200222170417.1531867-1-paulburton@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2020 at 09:04:17AM -0800, Paul Burton wrote:
> My time with MIPS the company has reached its end, and so at best I'll
> have little time spend on maintaining arch/mips/.
> 
> Ralf last authored a patch over 2 years ago, the last time he committed
> one is even further back & activity was sporadic for a while before
> that. The reality is that he isn't active.
> 
> Having a new maintainer with time to do things properly will be
> beneficial all round. Thomas Bogendoerfer has been involved in MIPS
> development for a long time & has offered to step up as maintainer, so
> add Thomas and remove myself & Ralf from the MIPS entry.
> 
> Ralf already has an entry in CREDITS to honor his contributions, so this
> just adds one for me.
> 
> Signed-off-by: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: linux-mips@vger.kernel.org
> ---
> Changes in v2:
> - Merge the 2 patches & add Thomas :)
> - Drop the link to Ralf's git tree
> ---
>  CREDITS     | 5 +++++
>  MAINTAINERS | 6 ++----
>  2 files changed, 7 insertions(+), 4 deletions(-)

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
