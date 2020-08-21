Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA64DC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 14:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A496E20FC3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 14:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgHUOHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 10:07:34 -0400
Received: from elvis.franken.de ([193.175.24.41]:54781 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgHUOHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 10:07:30 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1k97hX-00029F-00; Fri, 21 Aug 2020 16:07:27 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id D6277C0D89; Fri, 21 Aug 2020 16:07:03 +0200 (CEST)
Date:   Fri, 21 Aug 2020 16:07:03 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     He Zhe <zhe.he@windriver.com>, rric@kernel.org,
        oprofile-list@lists.sf.net, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH] mips/oprofile: Fix fallthrough placement
Message-ID: <20200821140703.GA13949@alpha.franken.de>
References: <20200820125440.350184-1-zhe.he@windriver.com>
 <20200821074821.GD8336@alpha.franken.de>
 <5e86b824-4c92-3cfe-fc36-493425e85f2a@windriver.com>
 <99d6dd20-8fe7-8b65-3ff0-839f19fe6b00@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99d6dd20-8fe7-8b65-3ff0-839f19fe6b00@embeddedor.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 04:23:28AM -0500, Gustavo A. R. Silva wrote:
> 
> 
> On 8/21/20 03:46, He Zhe wrote:
> > 
> > 
> > On 8/21/20 3:48 PM, Thomas Bogendoerfer wrote:
> >> On Thu, Aug 20, 2020 at 08:54:40PM +0800, zhe.he@windriver.com wrote:
> >>> From: He Zhe <zhe.he@windriver.com>
> >>>
> >>> We want neither
> >>> "
> >>> include/linux/compiler_attributes.h:201:41: warning: statement will never
> >>> be executed [-Wswitch-unreachable]
> >>>   201 | # define fallthrough __attribute__((__fallthrough__))
> >>>       |                      ^~~~~~~~~~~~~
> >>> "
> >>> nor
> >>> "
> >>> include/linux/compiler_attributes.h:201:41: warning: attribute
> >>> 'fallthrough' not preceding a case label or default label
> >>>   201 | # define fallthrough __attribute__((__fallthrough__))
> >>>       |                      ^~~~~~~~~~~~~
> >>> "
> >>>
> >>> It's not worth adding one more macro. Let's simply place the fallthrough
> >>> in between the expansions.
> >>>
> >>> Signed-off-by: He Zhe <zhe.he@windriver.com>
> >> there is already another patch for the problem, which I've applied
> >> to mips-fixes.
> > 
> > You mean the below one?
> > https://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/commit/?h=mips-fixes&id=5900acb374fe2f4f42bbcb2c84db64f582d917a1
> > 
> > That patch handles the first warning in my commit log but does not handle the
> > second one which is introduced since gcc v10.1.0 commit 6c80b1b56dec
> > ("Make more bad uses of fallthrough attribute into pedwarns.").
> > 
> 
> This is true.
> 
> Thomas, please apply this patch instead of mine. Also, consider adding
> the Fixes tag and CC stable due to the non-executable code error, and
> my Reviewed-by:
> 
> Fixes: c9b029903466 ("MIPS: Use fallthrough for arch/mips")
> Cc: stable@vger.kernel.org
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

done.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
