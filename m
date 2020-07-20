Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4F6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A29D5207FC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgGTVDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 17:03:41 -0400
Received: from gate.crashing.org ([63.228.1.57]:41157 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgGTVDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 17:03:41 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 06KL2tAD003247;
        Mon, 20 Jul 2020 16:02:55 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 06KL2qPF003246;
        Mon, 20 Jul 2020 16:02:52 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 20 Jul 2020 16:02:52 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geoff Levand <geoff@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Paul Mackerras <paulus@samba.org>,
        Joel Stanley <joel@jms.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc/boot: Use address-of operator on section symbols
Message-ID: <20200720210252.GO30544@gate.crashing.org>
References: <20200624035920.835571-1-natechancellor@gmail.com> <CAMuHMdU_KfQ-RT_nev5LgN=Vj_P97Fn=nwRoC6ZREFLa3Ysj7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdU_KfQ-RT_nev5LgN=Vj_P97Fn=nwRoC6ZREFLa3Ysj7w@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Sat, Jul 18, 2020 at 09:50:50AM +0200, Geert Uytterhoeven wrote:
> On Wed, Jun 24, 2020 at 6:02 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >         /* If we have an image attached to us, it overrides anything
> >          * supplied by the loader. */
> > -       if (_initrd_end > _initrd_start) {
> > +       if (&_initrd_end > &_initrd_start) {
> 
> Are you sure that fix is correct?
> 
>     extern char _initrd_start[];
>     extern char _initrd_end[];
>     extern char _esm_blob_start[];
>     extern char _esm_blob_end[];
> 
> Of course the result of their comparison is a constant, as the addresses
> are constant.  If clangs warns about it, perhaps that warning should be moved
> to W=1?
> 
> But adding "&" is not correct, according to C.

Why not?

6.5.3.2/3
The unary & operator yields the address of its operand.  [...]
Otherwise, the result is a pointer to the object or function designated
by its operand.

This is the same as using the name of an array without anything else,
yes.  It is a bit clearer if it would not be declared as array, perhaps,
but it is correct just fine like this.


Segher
