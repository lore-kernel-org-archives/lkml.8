Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE02C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1DA42076E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgHETze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:55:34 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37526 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgHEQrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:47:22 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k3LAB-0001gn-UM; Wed, 05 Aug 2020 15:17:08 +0000
Date:   Wed, 5 Aug 2020 17:17:07 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] fork cleanup for v5.9
Message-ID: <20200805151707.boubg3h4vetewxow@wittgenstein>
References: <20200804112801.72380-1-christian.brauner@ubuntu.com>
 <20200805083128.GA27209@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200805083128.GA27209@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 09:31:28AM +0100, Christoph Hellwig wrote:
> On Tue, Aug 04, 2020 at 01:28:01PM +0200, Christian Brauner wrote:
> > High-level this does two main things:
> > 1. Remove the double export of both do_fork() and _do_fork() where do_fork()
> >    used the incosistent legacy clone calling convention. Now we only export
> >    _do_fork() which is based on struct kernel_clone_args.
> 
> Can we retire the _do_fork name as well please?  For one we really don't
> use single underscore prefix in the kernel, and we also try to avoid our
> normal __ prefixes if there is no non-prefixed vesion.  Also the name
> feels wrong, as this implements all of clone and not just fork.
> What about kernel_clone to match the name of the args structure?

Yep, sounds good. I actually had a patch for that but it introduced a
lot of jitter into the series because there's quite a few odd places
where _do_fork() is used.

> 
> Also none of them actaully is exported (thankfully!).

Ah, sorry that was confusing. What I meant was "exported" in the sense
of visible outside of the file not actually in the "useable from
modules" sense.

Thanks!
Christian
