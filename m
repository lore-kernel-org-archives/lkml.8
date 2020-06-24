Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F050C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36E24207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405914AbgFXRzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:55:52 -0400
Received: from verein.lst.de ([213.95.11.211]:45402 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405788AbgFXRzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:55:51 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 30AA068B02; Wed, 24 Jun 2020 19:55:48 +0200 (CEST)
Date:   Wed, 24 Jun 2020 19:55:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 03/11] fs: add new read_uptr and write_uptr file
 operations
Message-ID: <20200624175548.GA25939@lst.de>
References: <20200624162901.1814136-1-hch@lst.de> <20200624162901.1814136-4-hch@lst.de> <CAHk-=wit9enePELG=-HnLsr0nY5bucFNjqAqWoFTuYDGR1P4KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wit9enePELG=-HnLsr0nY5bucFNjqAqWoFTuYDGR1P4KA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 10:19:16AM -0700, Linus Torvalds wrote:
> Honestly, I think this is the wrong way to go.
> 
> All of this new complexity and messiness, just to remove a few
> unimportant final cases?
> 
> If somebody can't be bothered to convert a driver to
> iter_read/iter_write, why would they be bothered to convert it to
> read_uptr/write_uptr?
> 
> And this messiness will stay around for decades.
> 
> So let's not go down that path.
> 
> If you want to do "splice() and kernel_read() requires read_iter"
> (with a warning so that we find any cases), then that's fine. But
> let's not add yet _another_ read type.
> 
> Why did you care so much about sysctl, and why couldn't they use the iter ops?

I don't care at all.  Based on our previous chat I assumed you
wanted something like this.  We might still need the uptr_t for
setsockopt, though.
