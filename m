Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC798C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB7F2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gJfrFOtE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgDIT4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 15:56:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50104 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDIT4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 15:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i/Ib4BiClvleXIoK3v98aLbfzb+Rs0/mxLWIdU8QNHc=; b=gJfrFOtEqUP/OBZzznRgqVXVm0
        80qAaIzwYAgXUr/zh5LgvB+b06t7+mrAPxPKHmhgUqULxH3uALGGPjhh8ZCYGL9fi0wJdY+Nz4txt
        S7NEG+eVuhBISAg5MQl25PT0qwkif3dWp7Poj5URV0xESkr69XYfQcENplfXKEoknb+Q2QflCiku4
        BxU1IibcZ535RjuxqHmxxaHM1bJ4jdK5jDJKDVceu0YVnSe64MyptqeKt0sPWLhdrJHtzZUinXVtY
        HPQrgtQYSkbO8F2NuBxeKNqOKQDMb8ldB0Pvrxankp9cRn8L8HQpl5ZCKToW5Rldfn8Al3AZcBel5
        IATvMDoQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMdHu-0007pI-2m; Thu, 09 Apr 2020 19:56:34 +0000
Date:   Thu, 9 Apr 2020 12:56:33 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Peter Xu <peterx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 0/2] mm: Two small fixes for recent syzbot reports
Message-ID: <20200409195633.GZ21484@bombadil.infradead.org>
References: <20200408014010.80428-1-peterx@redhat.com>
 <20200408174732.bc448bbe41d190bfe5cc252e@linux-foundation.org>
 <20200409114940.GT21484@bombadil.infradead.org>
 <CACT4Y+ZvQ9UvVAwTjjD8Zxo0X_nfxa3+6n6TqWk2g+hahBwdCw@mail.gmail.com>
 <20200409111604.c778ff091c00fab5db095e48@linux-foundation.org>
 <CAHk-=wiU77DeNxQsU4XrDCk59asyTs=Hn+mnTx6-SHB1_fA2NQ@mail.gmail.com>
 <20200409121250.d6bba6965b86c8dfcf325fbc@linux-foundation.org>
 <CAHk-=wgy3XRiyRP7vdfF6bHwWGaB1RwyWJmyphh+Q3qYk6w27w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgy3XRiyRP7vdfF6bHwWGaB1RwyWJmyphh+Q3qYk6w27w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 12:46:08PM -0700, Linus Torvalds wrote:
> On Thu, Apr 9, 2020 at 12:12 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > And now the challenge is to protect your tree from the bad patches.
> 
> Well, right now, yes.
> 
> But in the longer term, I think we want to protect linux-next from the
> bad patches so that they don't poison the testing that the bots can
> do.
> 
> So that's why I suggested that linux-next and syzbot have some
> protocol to have things that cause syzbot pain to be removed from
> linux-next more aggressively.

We should probably give Stephen a cc here ...
