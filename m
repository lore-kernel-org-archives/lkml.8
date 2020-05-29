Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47335C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22115207F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b/01V9h7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgE2OfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 10:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbgE2OfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 10:35:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4898BC03E969;
        Fri, 29 May 2020 07:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eotZInlRHpN85VcSCrKjyPgUPm24so4mrB7VDMd4spg=; b=b/01V9h7i0Ky/455ye/bNJS4nz
        /SBaLDsFxGWGk3pq0Td7IPNIlKXZOyOHRiS3h2vwxS61xVmjwG7lwo2dIeUPbwoULNR5tdyfOYY5X
        VW6EKSuVJGfH+vquqGObUp3T70vuSsKWrjO6z4K/9dz7Yb73iznaY+0qEv9YChw29+PofoXGJEN5e
        fVMZL0eefL38sVAtLCaF0KB5Q3zmBUnHtXVMczLmdOt6wkCv+RyE0PbFv2ETgm0V1EjvEpRM1ZApf
        Yw5XILO1CMI35vnBAlPCC6H9BucGtca+WLUDCRCgwVaV0jqFpZjKnVlFSuOavCfprWyAjN5tU3VSZ
        bD58wMtw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeg6N-0003SQ-NS; Fri, 29 May 2020 14:35:15 +0000
Date:   Fri, 29 May 2020 07:35:15 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Rich Felker <dalias@libc.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org,
        ysato@users.sourceforge.jp, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, Rob Landley <rob@landley.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] sh: remove sh5 support
Message-ID: <20200529143515.GB25475@infradead.org>
References: <20200424221948.1120587-1-arnd@arndb.de>
 <20200507143552.GA28683@infradead.org>
 <20200528054600.GA29717@infradead.org>
 <20200528161416.GY1079@brightrain.aerifal.cx>
 <20200528221450.GF1079@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528221450.GF1079@brightrain.aerifal.cx>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 06:14:51PM -0400, Rich Felker wrote:
> To follow up, I see that there was a patch series of yours (3/24) I
> missed ack'ing fairly recently. At first glance it looks good.

Well, I need a formal ACK, or even better have the arch maintainer
pick it up, as that is how development is normally supposed to work.

> In general, most of the patches I see are things that the linux-sh
> list and myself end up cc'd on that are only tangentially related to
> arch/sh or even not related at all. In that case I normally trust
> other maintainers familiar with the cross-arch changes being made that
> the small arch/sh part of the change is ok if the broader change is
> abstractly ok.

FYI, if you want to reduce the amount of crap you get Cced on, you can
add yourself to .get_maintainer.ignore file in the kernel tree, as
that at least removes a lot of the pass by cleanups found from git
log.

> Part of why I really disliked the "just kill it all" response to this
> thread is that the sh5 removal is specifically for the sake of making
> the arch more maintainable. That, along with forward-porting Sato's
> SH4 device tree patches (I've tried this but ran into problems, and
> need some help with it), has long been on my agenda for the arch, to
> reduce (and ultimately eliminate) the amount of legacy "only on
> arch/sh" stuff left so that it's not a burden on other maintainers and
> contributors. Seeing sentiment along the lines of "why don't you just
> remove it all while you're at it?" as a response is disheartening and
> also dismissive of Arnd's work making the sh5 removal happen.

We had the discussion before and things like the sh5 removal and
device tree switch came out of it.  But since then exactly nothing
has happened - the arch code is still pretty much unmaintained and
impossible to get a review for.  No one expects super quick responses
for a legacy architecture, but if there is no way to get feedback
or patches queued up while the code keeps on bitrotting the architecture
is effectively dead.  I have no personal problem with the sh hardware,
but if we want a Linux port to survive it will need at least a minimum
amount of active maintainance.
