Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58CCC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72EF2072C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392482AbgAXOYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:24:45 -0500
Received: from elvis.franken.de ([193.175.24.41]:59877 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389799AbgAXOYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:24:42 -0500
X-Greylist: delayed 980 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Jan 2020 09:24:41 EST
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1iuzdC-0003XT-00; Fri, 24 Jan 2020 15:08:18 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 454FCC0784; Fri, 24 Jan 2020 15:07:51 +0100 (CET)
Date:   Fri, 24 Jan 2020 15:07:51 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Paul Burton <paulburton@kernel.org>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org,
        chenhc@lemote.com, paul.burton@mips.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Introduce aligned IO memory operations
Message-ID: <20200124140751.GA17030@alpha.franken.de>
References: <20200114122343.163685-1-jiaxun.yang@flygoat.com>
 <20200122184506.7zbzetn5xturxamj@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122184506.7zbzetn5xturxamj@pburton-laptop>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 10:45:06AM -0800, Paul Burton wrote:
> Hi Jiaxun,
> 
> On Tue, Jan 14, 2020 at 08:23:43PM +0800, Jiaxun Yang wrote:
> > Some platforms, such as Loongson64 or QEMU/KVM, don't support unaligned
> > instructions like lwl or lwr in IO memory access. However, our current
> > IO memcpy/memset is wired to the generic implementation, which leads
> > to a fatal result.
> 
> Hmm, I wonder if we should just do this unconditionally on all systems.
> I can't think of a reason it'd ever be a good idea to use lwl/lwr on an
> MMIO device. Any thoughts on that?

depends on the type of device. I can see benefits for framebuffers
and memory devices since memset/memcpy are more optimised than the
function in this patch.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
