Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A62DC352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E2820733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581352200;
	bh=tQ8Yqx/VGmUaDG8o3r3dJfWbDgS3mR2SZOWq9DChmnw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=J+OkrzCnXkhJP2pPGxPA2kcP/3nVNhcEa0LrWrc4au4M6aNKYRyIM/NLz47lFJb2H
	 jJ9lL8hHjNHTXpX3B8+rYWEMenDFu0DZrtw6xz2Jh8uvwHI3BIAN82yTnH0DpvPNIO
	 FEfCSSOIfbog8t43m9lyS0zPV3+OcLGaoMfHVLz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgBJQ37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 11:29:59 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:37182 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727640AbgBJQ36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 11:29:58 -0500
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 01AGTWAB004482
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 01:29:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 01AGTWAB004482
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1581352173;
        bh=HycPV7Mkj4QnSFFsFiEueWGYGGUyEjD3VBh9xNpQMb8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VPQJAi+KkzkDvW78eQaSBoH1xnWLgJuftnSnTqzs3LD1VjDAizXRFAAzjqfXdL9qf
         eZDzi0GEj60nJLcsnv0rpMM9yEJ6pXRkHsbJ0REplrd8OXn+sarTgZKx9riFXzRkNz
         NWXRuC2+24G4tTBClwcI5bTESNgZZpVB+YCAJ+10obezWv23KuQK5rOUufczqK7mme
         zd7n9KUfDQZm68emu/jJGhBHD5GdEzLnIMG/dXEII/EV0BVM4mRS+A9PuCxMwUv09p
         5MlEMKrUOmbyo8wUeyAOJOrvnoiU4Y3nE9MU8ev7syW7whQmZgnabmX9f4gj429lah
         UoDkkgtIJGAPA==
X-Nifty-SrcIP: [209.85.217.52]
Received: by mail-vs1-f52.google.com with SMTP id a2so4523942vso.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 08:29:33 -0800 (PST)
X-Gm-Message-State: APjAAAU2IsROos1+b2x5ZfHwtwG/lq+0+WLEjXshgvV1XAe2CNgwQsSZ
        RPgocH703DmXbyIfYpy/U87PHxKtFzFRymFJMtU=
X-Google-Smtp-Source: APXvYqwtLclfxfGlnoiknShXii5/mcAaSPQ+my41UYm1gNXtq5kQQccZ8LFx6VIDEpWS6QEiq5Gnf8mIqaOPApiUP+s=
X-Received: by 2002:a05:6102:48b:: with SMTP id n11mr6863775vsa.181.1581352172252;
 Mon, 10 Feb 2020 08:29:32 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNAQs-KVCM7xXqJchQrMG+nnajPFRMB2Z+RJ9VTsg7XGRAQ@mail.gmail.com>
 <20200210070130.1029-1-youling257@gmail.com> <CAOzgRdYxL0RLq4Jqz1B_XXrUaQK5hMcWaazdvZzsNBUFy4CBFw@mail.gmail.com>
In-Reply-To: <CAOzgRdYxL0RLq4Jqz1B_XXrUaQK5hMcWaazdvZzsNBUFy4CBFw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 11 Feb 2020 01:28:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS2tbxmDHrRRpTAPbEbHi7rKXa9UcsscqBdpM0sxNjx=A@mail.gmail.com>
Message-ID: <CAK7LNAS2tbxmDHrRRpTAPbEbHi7rKXa9UcsscqBdpM0sxNjx=A@mail.gmail.com>
Subject: Re: [GIT PULL] more Kbuild updates for v5.6-rc1
To:     youling 257 <youling257@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.


On Mon, Feb 10, 2020 at 4:15 PM youling 257 <youling257@gmail.com> wrote:
>
> revert 8d60526999aace135de37220ec94ba40bc792234 scripts/kallsyms:
> change table to store (strcut sym_entry *), can build success.
>
> 2020-02-10 15:01 GMT+08:00, youling257 <youling257@gmail.com>:
> > this branch cause 64bit kernel build failed on 32bit userspace.
> >
> > kallsyms: malloc.c:2379: sysmalloc: Assertion `(old_top == initial_top (av)
> > && old_size == 0) || ((unsigned long) (old_size) >= MINSIZE && prev_inuse
> > (old_top) && ((unsigned long) old_end & (pagesize - 1)) == 0)' failed.
> >
> >

Sorry, this should fix the crash.

https://patchwork.kernel.org/patch/11373579/


-- 
Best Regards
Masahiro Yamada
