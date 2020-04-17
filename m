Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C88C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB77D20936
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730620AbgDQN1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 09:27:20 -0400
Received: from verein.lst.de ([213.95.11.211]:57695 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730370AbgDQN1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 09:27:19 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2566768BFE; Fri, 17 Apr 2020 15:27:15 +0200 (CEST)
Date:   Fri, 17 Apr 2020 15:27:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeremy Kerr <jk@ozlabs.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        x86@kernel.org
Subject: Re: [PATCH 4/8] binfmt_elf: open code copy_siginfo_to_user to
 kernelspace buffer
Message-ID: <20200417132714.GA6401@lst.de>
References: <20200414070142.288696-1-hch@lst.de> <20200414070142.288696-5-hch@lst.de> <CAK8P3a3HvbPKTkwfWr6PbZ96koO_NrJP1qgk8H1mgk=qUScGkQ@mail.gmail.com> <20200415074514.GA1393@lst.de> <CAK8P3a0QGQX85LaqKC1UuTERk6Bpr5TW6aWF+jxi2cOpa4L_AA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0QGQX85LaqKC1UuTERk6Bpr5TW6aWF+jxi2cOpa4L_AA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, Apr 15, 2020 at 10:20:11AM +0200, Arnd Bergmann wrote:
> > I'd rather keep it out of this series and to
> > an interested party.  Then again x32 doesn't seem to have a whole lot
> > of interested parties..
> 
> Fine with me. It's on my mental list of things that we want to kill off
> eventually as soon as the remaining users stop replying to questions
> about it.
> 
> In fact I should really turn that into a properly maintained list in
> Documentation/... that contains any options that someone has
> asked about removing in the past, along with the reasons for keeping
> it around and a time at which we should ask about it again.

To the newly added x86 maintainers:  Arnd brought up the point that
elf_core_dump writes the ABI siginfo format into the core dump. That
format differs for i386 vs x32.  Is there any good way to find out
which is the right format when are not in a syscall?

As far a I can tell x32 vs i386 just seems to be based around what
syscall table was used for the current syscall, but core dumps aren't
always in syscall context.
