Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC52C10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D2120409
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bgLfa2jP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgCILqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 07:46:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55572 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbgCILqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 07:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Zl0Sz0Q18LtoA4qBTOE/SgoGN85ceLUha/oEOfM3Njc=; b=bgLfa2jPgTpBDYmEXhvrY0xma2
        t4W53a5sbVulwUw6a1rLRy4lvucVv7LUVePBkQ6gycBw/MemdfJuTLI30OV7WogTex0JgVj29dOn1
        jFyFjSAF/mUuZgN7LV7fYIZrDYBxs259gj9oSqOzLZyWNvOydrQH76HDlCVNOio7iKWKbBHv4leQe
        uAbzU8BuHMv6m/1wHxWOJztLYtNJdXZ68vBopPTLAjFd3GBHHn5fYyVB/tN3NxAiC0htooS0lEJEf
        ELxmEZXIkJTD3oyxmU9jWeaaMq0iZxvc0CWbcvopXP2ASNK+go4nwFycwQHUlGHxvaQGjLckGblTt
        MXlzmQMQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jBGrv-00039P-0v; Mon, 09 Mar 2020 11:46:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1F37F3013A4;
        Mon,  9 Mar 2020 12:46:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1766B20286A0C; Mon,  9 Mar 2020 12:46:45 +0100 (CET)
Date:   Mon, 9 Mar 2020 12:46:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>
Subject: Re: [PATCH -v2 00/10] Rewrite Motorola MMU page-table layout
Message-ID: <20200309114645.GH12561@hirez.programming.kicks-ass.net>
References: <20200131124531.623136425@infradead.org>
 <CAMuHMdX-Vj-ewD7Kh+d5FdRs16eebwtM6hykZH62ha0Wq8dukQ@mail.gmail.com>
 <CAMuHMdWz7BZ4_mbSRFbb0iDW7wMFcALD5NvHFHKX_nAoE+sHQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWz7BZ4_mbSRFbb0iDW7wMFcALD5NvHFHKX_nAoE+sHQQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 11:15:31AM +0100, Geert Uytterhoeven wrote:
> Hi Peter, Will
> 
> On Mon, Feb 10, 2020 at 12:16 PM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Fri, Jan 31, 2020 at 1:56 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > In order to faciliate Will's READ_ONCE() patches:
> > >
> > >   https://lkml.kernel.org/r/20200123153341.19947-1-will@kernel.org
> > >
> > > we need to fix m68k/motorola to not have a giant pmd_t. These patches do so and
> > > are tested using ARAnyM/68040.
> > >
> > > Michael tested the previous version on his Atari Falcon/68030.
> > >
> > > Build tested for sun3/coldfire.
> > >
> > > Please consider!
> >
> > Thanks, applied and queued for v5.7, using an immutable branch named
> > pgtable-layout-rewrite.
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git/log/?h=pgtable-layout-rewrite
> 
> Any plans to use this? Looks like it's still part of linux-next through the m68k
> tree only.

Argh, yes. So we ran into sparc32 also need fixups, and both me and Will
seem to have stalled on fixing that. I'll try and get back to that.
