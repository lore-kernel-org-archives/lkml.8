Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A756C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 08:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE0EE20792
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 08:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ekT26djR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgHEI3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 04:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgHEI26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 04:28:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3615FC06174A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 01:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PYbyv2RjlX8KRzFyJl9c8iwgN8lvWXE2KszivzJegs8=; b=ekT26djRUIRIyMZkc4GR3Y6kTC
        qNmzrpPBeWQ+a2ceBo4s0wBLm4hhAX2ghofBlvjJ/1Uzd4W5PGLz1QqsahEumJT82N0tjytu3cf8Z
        Bf+emSr+h9rlZpxNViTZCRK77EoxxiYrzaUz749Sh5rK5p/nVyhSh8eOdKhr6XNnNapbm9mVdlaml
        HYcvSDecgsI03H6vpR1NvbsxFuc5RyDDyWgu0qpO5SP1u7R5rWNQViNzJWxminbK2PdxDTQK7awKF
        rPWM9sKv6qRdridB54smwu6D0W9CKEyNjpwodFMRT32mI4YSjUCo0/cSVVtqgz1rZN+yXlLNf/JgB
        g5UfDxJQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3Emz-00073L-ST; Wed, 05 Aug 2020 08:28:46 +0000
Date:   Wed, 5 Aug 2020 09:28:45 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Kai M??kisara <Kai.Makisara@kolumbus.fi>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Joel Becker <jlbec@evilplan.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lenny Szubowicz <lszubowi@redhat.com>
Subject: Re: [GIT PULL] configfs updates for 5.9
Message-ID: <20200805082845.GA25876@infradead.org>
References: <20200803140726.GA752014@infradead.org>
 <CAHk-=wg1h_XfPbXvisfAUsXU-WiOeCJDUibhxZGu=x9w-VKB0A@mail.gmail.com>
 <CAHk-=wg9dzJOkvysjgdHv5eFJU76EFAwCxNenRxTtq6VWof98Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg9dzJOkvysjgdHv5eFJU76EFAwCxNenRxTtq6VWof98Q@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 05:59:19PM -0700, Linus Torvalds wrote:
> So again, doing that
> 
>         if (file_count(file) > 1)
> 
> kind of check is very very wrong even outside of the fundamental race
> with two close() calls at the same time.
> 
> It is a very dangerous pattern, because it likely works in practice
> during testing, and looks like it might work.
> 
> But it is completely and unfixably wrong.
> 
> Again, the only reliable way to do that "last close" is "->release()",
> but you will never get errors from that, since (for all the same
> reasons) it might not even be done by a close. The last releaser of a
> file descriptor might be that mmap/io_uring/proc case now releasing
> the no longer used file, possibly long after the last "close()" call
> has happened.
> 
> One acceptable half-way measure *may* be
> 
>  - do the flush with the above bogus test at ->flush() time, knowing
> it might never trigger at all
> 
>  - do the flush *again* at ->release() time, in case it didn't trigger
> 
>  - add a big comment to the flush-time case to show you understand the
> issue, and understand
> 
> but I'd discourage it because of how unreliable it is.

Yes, but this is a fundamental problem with the commit on close
model that the configfs binary attributes implement, and we have to
work around that somehow.  The current behavior is to entirely ignore
errors, which of course has major issues.  I guess the alternative might
be to just commit on every ->flush as the use case (and yes I know
people could abuse it) for the configfs files is a set of simple
write syscalls.  Then again the above might be better than that.

Lenny, can you look ingo that?
