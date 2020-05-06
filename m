Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA12C38A2A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 14:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A51220B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 14:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588776112;
	bh=ZjVkDedPJdCZEWLKjLyinPSY3peY7sOSbquAGZSrSXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZOUJf/48j9eyc4CprTcU/Ww+83mbQ1KMKYBfJg9PF8O4HKvgitRIkl2nvvm2ZyQ82
	 VHEga36NYJinlRSgyipm+XFY6OkDLHpW21sSpprg4gKegrNvKDUiWSps2uIAAtMXIh
	 pjiPEaK22nH9ZVeG5La9LgTA3zH2ATlNImGrgDGA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgEFOlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 10:41:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729181AbgEFOlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 10:41:46 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F0AF20A8B;
        Wed,  6 May 2020 14:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588776106;
        bh=ZjVkDedPJdCZEWLKjLyinPSY3peY7sOSbquAGZSrSXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aaDZk0+C8BhYp1zgcDs209t79q7vERLIBTS0H5IpGR7Jws9TnJjRF7cSpG73DBdax
         1gT5PmQqxdkHOtinESnVYbItcJKanq3xAk84ateKBRjs8QzHTQYycY+aiPB3fwA+4Y
         /q/+jv6Yhaq3XW8bvsdS6DrXr6/J/fCyUOh0QjHk=
Date:   Wed, 6 May 2020 15:41:41 +0100
From:   Will Deacon <will@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        elver@google.com, linux-kernel@vger.kernel.org
Subject: Re: Please can I have a stable KCSAN branch for 5.8?
Message-ID: <20200506144141.GA12919@willie-the-truck>
References: <20200506132816.GJ8043@willie-the-truck>
 <20200506143616.GY2869@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506143616.GY2869@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Cheers for the quick reply!

On Wed, May 06, 2020 at 07:36:16AM -0700, Paul E. McKenney wrote:
> On Wed, May 06, 2020 at 02:28:17PM +0100, Will Deacon wrote:
> > I'm looking to rebase my READ_ONCE() series [1] on top of the KCSAN patches
> > so that we can get them in for 5.8. However, tip/locking/kcsan seems to be
> > missing some bits:
> > 
> >   * An update to checkpatch.pl to warn about missing comments for
> >     data_race():
> > 
> >     https://lore.kernel.org/r/20200401101714.44781-1-elver@google.com
> 
> For some reason, I thought this was going up some other tree, but I do
> not see it in -next.  So unless I hear otherwise, I will pull it into
> the v5.8 kcsan branch.

Brill, thanks.

> >   * I'm unable to apply these two patches from Marco that are needed for
> >     my READ_ONCE() work:
> > 
> >     https://lore.kernel.org/lkml/20200424154730.190041-1-elver@google.com/
> > 
> >     I think these depend on stuff that has been queued by Paul, and appears
> >     in linux-next, but to be honest with you I'm quite confused about what
> >     is queued for 5.8 and what isn't.
> 
> This one is queued, but I currently have it in the v5.9 pile (but
> tentatively for v5.8).  Unless Marco tells me otherwise, I will move it
> to the v5.8 branch, which will be part of my pull request next week.

Great, then this would all show up on tip/locking/kscan, right?

> > What's the best base for me to use?
> 
> The -next tree has the latter, but not yet the former.

That probably means -next is good enough for me to cook a new version of my
series, and then I can make a proper branch next week.

> Hopefully we can get this straightened out, and please accept my apologies
> for the hassle!

No need to apologise, I just couldn't figure out what was what and decided
it was easier to ask the experts ;)

Cheers again,

Will
