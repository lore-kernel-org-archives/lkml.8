Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95217C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 05:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F7AF20825
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 05:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgHVFaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 01:30:25 -0400
Received: from smtprelay0234.hostedemail.com ([216.40.44.234]:38314 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725863AbgHVFaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 01:30:25 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 407F4182CED28;
        Sat, 22 Aug 2020 05:30:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cover17_5f1646f2703f
X-Filterd-Recvd-Size: 2530
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Sat, 22 Aug 2020 05:30:22 +0000 (UTC)
Message-ID: <3836b482434bd0b9a609959d3696cc6113a93f2f.camel@perches.com>
Subject: Re: [Cocci] coccinelle: Convert comma to semicolons (was Re:
 [PATCH] checkpatch: Add test for comma use that should be semicolon)
From:   Joe Perches <joe@perches.com>
To:     Valdis =?UTF-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        cocci <cocci@systeme.lip6.fr>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@shadowen.org>
Date:   Fri, 21 Aug 2020 22:30:21 -0700
In-Reply-To: <162653.1598067338@turing-police>
References: <20200818184107.f8af232fb58b17160c570874@linux-foundation.org>
         <3bf27caf462007dfa75647b040ab3191374a59de.camel@perches.com>
         <b0fd63e4b379eda69ee85ab098353582b8c054bb.camel@perches.com>
         <alpine.DEB.2.22.394.2008201021400.2524@hadrien>
         <a5713d8597065ef986f780499428fcc4cd31c003.camel@perches.com>
         <alpine.DEB.2.22.394.2008201856110.2524@hadrien>
         <744af177c09f8ce22c99d6e1df458bced558518b.camel@perches.com>
         <162653.1598067338@turing-police>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-08-21 at 23:35 -0400, Valdis Klētnieks wrote:
> On Fri, 21 Aug 2020 18:08:08 -0700, Joe Perches said:
> > (forwarding on to kernel-janitors/mentees and kernelnewbies)
> > 
> > Just fyi for anyone that cares:
> > 
> > A janitorial task for someone might be to use Julia's coccinelle
> > script below to convert the existing instances of commas that
> > separate statements into semicolons.
> 
> Note that you need to *really* check for possible changes in semantics.
> It's *usually* OK to do that, but sometimes it's not...
> 
> for (i=0; i++, last++; !last) {
> 
> changing that comma to a ; will break the compile.  In other cases, it can
> introduce subtle bugs.

True enough for a general statement, though the coccinelle
script Julia provided does not change a single instance of
for loop expressions with commas.

As far as I can tell, no logic defect is introduced by the
script at all.


