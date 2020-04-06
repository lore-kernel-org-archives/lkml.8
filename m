Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9029EC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6159A20769
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgDFNES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 09:04:18 -0400
Received: from verein.lst.de ([213.95.11.211]:33475 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728077AbgDFNES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 09:04:18 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7904768BEB; Mon,  6 Apr 2020 15:04:16 +0200 (CEST)
Date:   Mon, 6 Apr 2020 15:04:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeremy Kerr <jk@ozlabs.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] binfmt_elf: open code copy_siginfo_to_user to
 kernelspace buffer
Message-ID: <20200406130416.GB16479@lst.de>
References: <20200406120312.1150405-1-hch@lst.de> <20200406120312.1150405-3-hch@lst.de> <CAK8P3a02LQNOehukgaCj81wg1D2XhW1=_mQZ72cT6nQdO=mhOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a02LQNOehukgaCj81wg1D2XhW1=_mQZ72cT6nQdO=mhOw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 03:01:24PM +0200, Arnd Bergmann wrote:
> >  static void fill_siginfo_note(struct memelfnote *note, user_siginfo_t *csigdata,
> >                 const kernel_siginfo_t *siginfo)
> >  {
> > -       mm_segment_t old_fs = get_fs();
> > -       set_fs(KERNEL_DS);
> > -       copy_siginfo_to_user((user_siginfo_t __user *) csigdata, siginfo);
> > -       set_fs(old_fs);
> > +       memcpy(csigdata, siginfo, sizeof(struct kernel_siginfo));
> > +       memset((char *)csigdata + sizeof(struct kernel_siginfo), 0,
> > +               SI_EXPANSION_SIZE);
> >         fill_note(note, "CORE", NT_SIGINFO, sizeof(*csigdata), csigdata);
> >  }
> 
> I think this breaks compat binfmt-elf mode, which relies on this trick:
> 
> fs/compat_binfmt_elf.c:#define copy_siginfo_to_user     copy_siginfo_to_user32
> fs/compat_binfmt_elf.c#include "binfmt_elf.c"
> 
> At least we seem to only have one remaining implementation of
> __copy_siginfo_to_user32(), so fixing this won't require touching all
> architectures, but I don't see an obvious way to do it right. Maybe
> compat-binfmt-elf.c should just override fill_siginfo_note() itself
> rather than overriding copy_siginfo_to_user().

Ooops.  Yes, this will need some manual handling.
