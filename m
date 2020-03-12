Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553BCC2BAEE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 02:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7856120754
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 02:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583981893;
	bh=wJdKQS6Gj9xiXn1BGxhMdcyOYuYKUt5sQjTbx3jinXE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=FlH0m0AfoiBkKokhbsEAm+amPaoprLJXpPdYBHutgV0pBcI9UhQkhbL2Tepz649Nv
	 Re1f/3rd/GbOW0KUcIsJq+c4Jf6Lqv7a1L2HIU0bGX7MEYBJgvVtlOjNn00F46iCzV
	 uG/FAGjmCT3Yt1ini6BFYWd3seyogbGr6anANuBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387689AbgCLC6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 22:58:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:39780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387396AbgCLC6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 22:58:11 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAB4920755;
        Thu, 12 Mar 2020 02:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583981891;
        bh=wJdKQS6Gj9xiXn1BGxhMdcyOYuYKUt5sQjTbx3jinXE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K8pZg/PKbre08qAnpKHYtRQEa3Y8eHQgSJ3fgLwtnqltex4FaiU8ZEIREHiNxjpb9
         qxfNUXGPXjA4gqUzprHjQcLRywJGzvrNEi9TTFQuebfkJWWooV/O8sPMetTVryirIh
         b+RYwrkYLKzVIQ3DjUV5cnyC5qOPAdbW/iiKlw60=
Date:   Wed, 11 Mar 2020 19:58:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     paulmck@kernel.org
Cc:     David Laight <David.Laight@ACULAB.COM>,
        "'Marco Elver'" <elver@google.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] list: Prevent compiler reloads inside 'safe' list
 iteration
Message-Id: <20200311195810.959d4f40d6013ee59a238cf3@linux-foundation.org>
In-Reply-To: <20200310154749.GZ2935@paulmck-ThinkPad-P72>
References: <20200310092119.14965-1-chris@chris-wilson.co.uk>
        <2e936d8fd2c445beb08e6dd3ee1f3891@AcuMS.aculab.com>
        <158384100886.16414.15741589015363013386@build.alporthouse.com>
        <723d527a4ad349b78bf11d52eba97c0e@AcuMS.aculab.com>
        <20200310125031.GY2935@paulmck-ThinkPad-P72>
        <CANpmjNNT3HY7i9TywX0cAFqBtx2J3qOGOUG5nHzxAZ4bk_qgtg@mail.gmail.com>
        <77ff4da6b0a7448c947af6de4fb43cdb@AcuMS.aculab.com>
        <20200310154749.GZ2935@paulmck-ThinkPad-P72>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Mar 2020 08:47:49 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Tue, Mar 10, 2020 at 03:05:57PM +0000, David Laight wrote:
> > From: Marco Elver
> > > Sent: 10 March 2020 14:10
> > ...
> > > FWIW, for writes we're already being quite generous, in that plain
> > > aligned writes up to word-size are assumed to be "atomic" with the
> > > default (conservative) config, i.e. marking such writes is optional.
> > > Although, that's a generous assumption that is not always guaranteed
> > > to hold (https://lore.kernel.org/lkml/20190821103200.kpufwtviqhpbuv2n@willie-the-truck/).
> > 
> > Remind me to start writing everything in assembler.
> 
> Been there, done that.  :-/
> 
> > That and to mark all structure members 'volatile'.
> 
> Indeed.  READ_ONCE() and WRITE_ONCE() get this same effect, but without
> pessimizing non-concurrent accesses to those same members.  Plus KCSAN
> knows about READ_ONCE(), WRITE_ONCE(), and also volatile members.
> 

So I take it from all the above that we should do this.

Did anyone actually review the code? :)
