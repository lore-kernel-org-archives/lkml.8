Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC546C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D72320C09
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592596482;
	bh=6Adp22+mTbZpiR77ZXXW0mIcODohmhmRvdI0E24ULMc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PVMrGioks21nwB9g7TzxWmII+4CLScv9FWj1PeKfMsOL/pa9P6F53XxgWwVz/rwLv
	 3IJaRdSyIuvtcdLLUg7IFwxqfQRmMqmFPg3MApAOk2q5F/gUH4DRDTs72aSUBRNrP5
	 Z2B3O9r4VC2pR9BrPmSqatqd3TJ2AK/b0/zweyWw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391247AbgFSTyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:54:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:53760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391181AbgFSTyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:54:40 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3322321531
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 19:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592596479;
        bh=6Adp22+mTbZpiR77ZXXW0mIcODohmhmRvdI0E24ULMc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W+OT2Lyuu3JFeuDsJLl/JoJcERMmL3CmPFRxZTfzGoNnqE3n3ZiRjRtlVdMbSKpL+
         Gvf20ylq6kFMec2wcpSnK2Mw9Xe8liINuvYLlGRVgOuNKp7RS9Kmqkl1YOCyDLiosU
         9/KBWTEJoFR7RQW9JahBKMKSzXvMhupfUnVJyqs4=
Received: by mail-wm1-f52.google.com with SMTP id g75so1401441wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 12:54:39 -0700 (PDT)
X-Gm-Message-State: AOAM531OrjnhTdMnpobQO2UF03OkdI7TlnwfXhmi9mLJZfz/bEENkBFW
        dE7iEfpo8oI+zB+Zhkfc70wUZw3zn1IGotcjYgorpQ==
X-Google-Smtp-Source: ABdhPJzykM/IIUrAFqtXVr16O2awFY2UEkEuRFlEF9GtzvBqoRQGXhGpzp9EF88Mtp3MWoA+4cQKtx8FjWFfHBcm80s=
X-Received: by 2002:a1c:2402:: with SMTP id k2mr1154043wmk.138.1592596477811;
 Fri, 19 Jun 2020 12:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <202006191236.AC3E22AAB@keescook> <CALCETrXM5gneAC40RLWyjnCeHE6JFVOKnM0ooKLooGGaVV1KOA@mail.gmail.com>
 <202006191253.B00874B22@keescook>
In-Reply-To: <202006191253.B00874B22@keescook>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 19 Jun 2020 12:54:26 -0700
X-Gmail-Original-Message-ID: <CALCETrUfsRy+SmQi9FCYKR-Nvm0=NKHXtk+O-ozk962B5-7Yyw@mail.gmail.com>
Message-ID: <CALCETrUfsRy+SmQi9FCYKR-Nvm0=NKHXtk+O-ozk962B5-7Yyw@mail.gmail.com>
Subject: Re: [PATCH] seccomp: Use -1 marker for end of mode 1 syscall list
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>, Will Drewry <wad@chromium.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 12:53 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Jun 19, 2020 at 12:42:14PM -0700, Andy Lutomirski wrote:
> > On Fri, Jun 19, 2020 at 12:37 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > The terminator for the mode 1 syscalls list was a 0, but that could be
> > > a valid syscall number (e.g. x86_64 __NR_read). By luck, __NR_read was
> > > listed first and the loop construct would not test it, so there was no
> > > bug. However, this is fragile. Replace the terminator with -1 instead,
> > > and make the variable name for mode 1 syscall lists more descriptive.
> >
> > Could the architecture instead supply the length of the list?
>
> It could, but I didn't like the way the plumbing for that looked.

Fair enough.

>
> --
> Kees Cook
