Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5340AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29BAE20720
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="iIlTIgm1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbgGFOGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 10:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729171AbgGFOGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 10:06:43 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433BEC061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 07:06:43 -0700 (PDT)
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2C02E97E;
        Mon,  6 Jul 2020 16:06:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1594044400;
        bh=Y0Dxs8yHGnMAS7O4nFNLcSPnhsF1XRUFurGKDDc2C1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iIlTIgm1Aik/z6QQROo3wt9iJVpDdvg2MnZhovSOh2B7EtM+YuYI+0QWr/3eTfOiB
         KOlUPFLn3y02tmJbMEs+p7usOW8gVlVttuUPMizP7QNCD/DJS7Y4PcZ1KU8KVrnomu
         c03J1o18JljXK4F14qbxCbOPKkPghGt7iuxWdGuc=
Date:   Mon, 6 Jul 2020 17:06:36 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Chris Mason <clm@fb.com>
Cc:     Willy Tarreau <w@1wt.eu>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>,
        Chris Mason <clm@fb.clm>
Subject: Re: [Ksummit-discuss] [PATCH] CodingStyle: Inclusive Terminology
Message-ID: <20200706140636.GA19803@pendragon.ideasonboard.com>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200705045505.GA2962@1wt.eu>
 <798B0FBF-D7A8-4631-8581-5D199DA50FF9@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <798B0FBF-D7A8-4631-8581-5D199DA50FF9@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On Mon, Jul 06, 2020 at 12:45:34PM +0000, Chris Mason via Ksummit-discuss wrote:
> On 5 Jul 2020, at 0:55, Willy Tarreau wrote:
> > On Sat, Jul 04, 2020 at 01:02:51PM -0700, Dan Williams wrote:
> >> +Non-inclusive terminology has that same distracting effect which is why
> >> +it is a style issue for Linux, it injures developer efficiency.
> >
> > I'm personally thinking that for a non-native speaker it's already
> > difficult to find the best term to describe something, but having to
> > apply an extra level of filtering on the found words to figure whether
> > they are allowed by the language police is even more difficult.
> 
> Since our discussions are public, we’ve always had to deal with 
> comments from people outside the community on a range of topics.  But 
> inside the kernel, it’s just a group of developers trying to help each 
> other produce the best quality of code.  We’ve got a long history 
> together and in general I think we’re pretty good at assuming good 
> intent.
> 
> > *This* injures developers efficiency. What could improve developers efficiency
> > is to take care of removing *all* idiomatic or cultural words then. For
> > example I've been participating to projects using the term "blueprint",
> > I didn't understand what that meant. It was once explained to me and
> > given that it had no logical reason for being called this way, I now
> > forgot. If we follow your reasoning, Such words should be banned for
> > exactly the same reasons. Same for colors that probably don't mean
> > anything to those born blind.
> >
> > For example if in my local culture we eat tomatoes at starters and
> > apples for dessert, it could be convenient for me to use "tomato" and
> > "apple" as list elements to name the pointers leading to the beginning
> > and the end of the list, and it might sound obvious to many people, but
> > not at all for many others.
> >
> > Maybe instead of providing an explicit list of a few words it should
> > simply say that terms that take their roots in the non-technical world
> > and whose meaning can only be understood based on history or local
> > culture ought to be avoided, because *that* actually is the real
> > root cause of the problem you're trying to address.
> 
> I’d definitely agree that it’s a good goal to keep out non-technical 
> terms.  Even though we already try, every subsystem has its own set of 
> patterns that reflect the most frequent contributors.

That's an interesting point, because to me, it's the exact opposite. One
of the intellectual rewards I find in working with the kernel is that
our community is international and multicultural, allowing me to learn
about other cultures. Aiming for the lowest common denominator seems to
me to be closer to erasing cultural differences than including them.

-- 
Regards,

Laurent Pinchart
