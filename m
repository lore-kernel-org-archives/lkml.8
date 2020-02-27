Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A6EC76597
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF70021D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388454AbgB0O3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:29:08 -0500
Received: from elvis.franken.de ([193.175.24.41]:40353 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731272AbgB0O3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:29:06 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1j7K9u-0004ld-00; Thu, 27 Feb 2020 15:29:02 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 93A06C0EB2; Thu, 27 Feb 2020 15:02:11 +0100 (CET)
Date:   Thu, 27 Feb 2020 15:02:11 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        James Hogan <jhogan@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the mips-fixes tree
Message-ID: <20200227140211.GA17887@alpha.franken.de>
References: <20200227071718.5aac4713@canb.auug.org.au>
 <1582811024.3.0@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1582811024.3.0@crapouillou.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 10:43:44AM -0300, Paul Cercueil wrote:
> Le jeu., févr. 27, 2020 at 07:17, Stephen Rothwell <sfr@canb.auug.org.au> a
> écrit :
> >Hi all,
> >
> >In commit
> >
> >  3944dee0c6cd ("MIPS: Fix CONFIG_MIPS_CMDLINE_DTB_EXTEND handling")
> >
> >Fixes tag
> >
> >  Fixes: 7784cac69735 ("MIPS: cmdline: Clean up boot_command_line
> >
> >has these problem(s):
> >
> >  - Subject has leading but no trailing parentheses
> >  - Subject has leading but no trailing quotes
> >
> >Please do not split Fixes tags over more than one line.
> 
> My fault, sorry. I did not know they could not be splitted.

I've fixed it.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
