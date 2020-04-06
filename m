Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FD1C2BA1E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C963222273
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgDFNDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 09:03:55 -0400
Received: from verein.lst.de ([213.95.11.211]:33470 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728144AbgDFNDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 09:03:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 933A768BEB; Mon,  6 Apr 2020 15:03:51 +0200 (CEST)
Date:   Mon, 6 Apr 2020 15:03:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] binfmt_elf: remove the set_fs(KERNEL_DS) in
 elf_core_dump
Message-ID: <20200406130351.GA16479@lst.de>
References: <20200406120312.1150405-1-hch@lst.de> <20200406120312.1150405-4-hch@lst.de> <20200406130238.GT23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406130238.GT23230@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 02:02:38PM +0100, Al Viro wrote:
> On Mon, Apr 06, 2020 at 02:03:09PM +0200, Christoph Hellwig wrote:
> > There is no logic in elf_core_dump itself that uses uaccess routines
> > on kernel pointers, the file writes are nicely encapsulated in dump_emit
> > which does its own set_fs.
> 
> ... assuming you've checked the asm/elf.h to see that nobody is playing
> silly buggers in these forests of macros and the stuff called from those.
> Which is a feat that ought to be mentioned in commit message...

None of the calls should go into asm/elf.h headers, but some go to
various out of line arch callouts.  And I did look through those - spufs
was the only funky one.
