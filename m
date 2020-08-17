Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA8BC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1529205CB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=vfemail.net header.i=@vfemail.net header.b="XX+2rLlk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbgHQO4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:56:40 -0400
Received: from nl101-3.vfemail.net ([149.210.219.33]:36402 "EHLO
        nl101-3.vfemail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729190AbgHQO4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:56:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=vfemail.net; h=date:from
        :to:cc:subject:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; s=2018; bh=a7pGJOtdjqiT
        eAUo+PzMV64egfyuDMt0Lj3hjt/ULrk=; b=XX+2rLlkg0ezGzOgr/lC0IdmvIex
        n5ipL4MGUUsiI2e2xn9M94sMyj3A4SByw0UAnGzYuOMBw9NSz9w4pVmJYHgMk+c2
        3LDX+uCWJ4/ExFr1dLXsa7OSaUY1B3tjyjL3oWNrU4BvkWGEw7PCpE+/4PgYmsG6
        D7XFNEYCUlj2pNs=
Received: (qmail 58305 invoked from network); 17 Aug 2020 14:56:38 -0000
Received: by simscan 1.4.0 ppid: 58235, pid: 58295, t: 0.4555s
         scanners:none
Received: from unknown (HELO d3d3MTkyLnZmZW1haWwubmV0) (aGdudGt3aXNAdmZlbWFpbC5uZXQ=@MTkyLjE2OC4xLjE5Mg==)
  by nl101.vfemail.net with ESMTPA; 17 Aug 2020 14:56:38 -0000
Date:   Mon, 17 Aug 2020 10:56:04 -0400
From:   David Niklas <Hgntkwis@vfemail.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        reiserfs-devel@vger.kernel.org
Subject: Re: PROBLEM: IO lockup on reiserfs FS.
Message-ID: <20200817105604.454981dd@Phenom-II-x6.niklas.com>
In-Reply-To: <CAHk-=wiGsj_R7pspFegPgtT4on1iYk5MmBz8uZZ3338EH3HO+Q@mail.gmail.com>
References: <20200728222041.5d88b2e1@Phenom-II-x6.niklas.com>
        <20200728223440.0fd8681e@Phenom-II-x6.niklas.com>
        <20200805125317.10bf1d34@Phenom-II-x6.niklas.com>
        <CAHk-=wiGsj_R7pspFegPgtT4on1iYk5MmBz8uZZ3338EH3HO+Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Aug 2020 12:51:41 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Wed, Aug 5, 2020 at 9:53 AM <Hgntkwis@vfemail.net> wrote:
> >
> > It's been over 1 week since I sent this into the reiserfs-devel
> > mailing list. I'm escalating this as the kernel docs recommend.
> > I'm still willing to help debug and test a fix for this problem.  
> 
> The thing is, you're using an ancient 4.14 kernel, and a filesystem
> that isn't really maintained any more. You'll find very few people
> interested in trying to debug that combination.
> 
> You *might* have more luck with a more modern kernel, but even then
> ... reiserfs?
> 
>               Linus
> 

This bug appears to have been fixed some where between 4.14.X and the
5.17.X series. I don't know why the fix wasn't backported, but it doesn't
really matter to me as I can run the newer kernel.

Thanks everyone for your help.
David
