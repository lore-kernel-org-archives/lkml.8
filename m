Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4591CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 20:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FE4E206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 20:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgFBU2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 16:28:35 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:38216 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgFBU2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 16:28:34 -0400
Date:   Tue, 2 Jun 2020 16:28:33 -0400
From:   Rich Felker <dalias@libc.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: linux-sh for-next reactivation
Message-ID: <20200602202832.GA3776@brightrain.aerifal.cx>
References: <20200602031123.GA1079@brightrain.aerifal.cx>
 <20200602150039.780a0ac0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602150039.780a0ac0@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 03:00:39PM +1000, Stephen Rothwell wrote:
> Hi Rich,
> 
> On Mon, 1 Jun 2020 23:11:39 -0400 Rich Felker <dalias@libc.org> wrote:
> >
> > Could you reactivate linux-next pull from my arch/sh for-next branch?
> > It's where it was before, at:
> > 
> >     git://git.libc.org/linux-sh for-next
> > 
> > and has newly accepted patches ready.
> 
> I already have an SH tree from
> git://git.sourceforge.jp/gitroot/uclinux-h8/linux.git#sh-next .  Should
> I do anything with that one?
> 
> It currently contains:
> 
> $ git log --oneline origin/master..sh/sh-next 
> a193018e5290 (sh/sh-next) sh: add missing EXPORT_SYMBOL() for __delay
> 1d5fd6c33b04 sh: add missing DECLARE_EXPORT() for __ashiftrt_r4_xx
> d70f1e3d5dbd Merge remote-tracking branch 'origin/master' into sh-next
> baf58858e8b6 sh: prefer __section from compiler_attributes.h
> 8619b5a9035a sh: Drop -Werror from kernel Makefile
> 3a3a78124693 sh: kernel: disassemble: Mark expected switch fall-throughs
> fb8f77490f55 sh: kernel: hw_breakpoint: Fix missing break in switch statement
> cd10afbc932d sh: remove unneeded uapi asm-generic wrappers
> cbfc6edb6a4a sh: use __builtin_constant_p() directly instead of IS_IMMEDIATE()

Hi Stephen,

I completely forgot that you had the tree from our other co-maintainer
Yoshinori Sato on the list linux-next is pulling from. Would it be
okay to keep both? That would help with quickly identifying and
resolving any conflicting commits and make things go more smoothly
with two maintainers trying to be active.

Let me know if this doesn't work for you and we'll figure out
alternative arrangements.

Rich
