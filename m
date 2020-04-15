Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EECC2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 06:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B695E206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 06:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634790AbgDOGTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 02:19:53 -0400
Received: from verein.lst.de ([213.95.11.211]:43526 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2634778AbgDOGTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 02:19:50 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9EE6768C4E; Wed, 15 Apr 2020 08:19:48 +0200 (CEST)
Date:   Wed, 15 Apr 2020 08:19:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] binfmt_elf: open code copy_siginfo_to_user to
 kernelspace buffer
Message-ID: <20200415061948.GB32392@lst.de>
References: <20200414070142.288696-1-hch@lst.de> <20200414070142.288696-5-hch@lst.de> <87y2qxih94.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2qxih94.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 01:01:59PM +1000, Michael Ellerman wrote:
> > +	to_compat_siginfo(csigdata, siginfo, compat_siginfo_flags());	\
> > +	fill_note(note, "CORE", NT_SIGINFO, sizeof(*csigdata), csigdata); \
> > +} while (0)
> 
> This doesn't build on ppc (cell_defconfig):
> 
>   ../fs/binfmt_elf.c: In function 'fill_note_info':
>   ../fs/compat_binfmt_elf.c:44:39: error: implicit declaration of function 'compat_siginfo_flags'; did you mean 'to_compat_siginfo'? [-Werror=implicit-function-d
>   eclaration]
>     to_compat_siginfo(csigdata, siginfo, compat_siginfo_flags()); \
>                                          ^~~~~~~~~~~~~~~~~~~~
>   ../fs/binfmt_elf.c:1846:2: note: in expansion of macro 'fill_siginfo_note'
>     fill_siginfo_note(&info->signote, &info->csigdata, siginfo);
>     ^~~~~~~~~~~~~~~~~
>   cc1: some warnings being treated as errors
>   make[2]: *** [../scripts/Makefile.build:266: fs/compat_binfmt_elf.o] Error 1
> 
> 
> I guess the empty version from kernel/signal.c needs to move into a
> header somewhere.

Yes, it should.  Odd that the buildbut hasn't complained yet so far..
