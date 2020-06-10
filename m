Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FBAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0E4E2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgFJRcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:32:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46747 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgFJRcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 13:32:12 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jj4a9-00074z-Vi; Wed, 10 Jun 2020 17:32:10 +0000
Date:   Wed, 10 Jun 2020 19:32:09 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Joe Perches <joe@perches.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] .clang-format: update column limit
Message-ID: <20200610173209.otq4nxx3ya6j4pat@wittgenstein>
References: <20200610125147.2782142-1-christian.brauner@ubuntu.com>
 <c8851256aa453461481233e8a7fea878f9580c5b.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c8851256aa453461481233e8a7fea878f9580c5b.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 10:13:24AM -0700, Joe Perches wrote:
> On Wed, 2020-06-10 at 14:51 +0200, Christian Brauner wrote:
> > The provided clang-format file wraps at 80 chars. If noone minds I'd like
> > to adjust this limit to 100 similar to what checkpatch (cf. [1]) uses now.
> > 
> > [1]: commit bdc48fa11e46 ("checkpatch/coding-style: deprecate 80-column warning")
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> []
> > diff --git a/.clang-format b/.clang-format
> []
> > @@ -52,7 +52,7 @@ BreakConstructorInitializersBeforeComma: false
> >  #BreakConstructorInitializers: BeforeComma # Unknown to clang-format-4.0
> >  BreakAfterJavaFieldAnnotations: false
> >  BreakStringLiterals: false
> > -ColumnLimit: 80
> > +ColumnLimit: 100
> 
> Ii think this is a not a good change.
> 
> If you read the commit log you provided, it ways
> "staying withing 80 columns is certainly still _preferred_"

I read it; that's why the "if noone minds" is there.

> 
> With this change, clang would _always_ wrap to 100 columns.
> 
> clang would not make any reasonable attempt to use 80 when
> it should.

You make it sounds like it caps all lines to 100 columns when really it
just does it for corner cases where we run over the 80 anwyways. I at
least don't regularly write lines of code that cross the 80 limit.
So when clang-format is called it's usually when something needs to be
reformatted at which point using the more lenient 100 char limit seems
sensible. But I don't particulary care about this patch. I can just
override the .clang-format file if this shakes the world too much.

Christian
