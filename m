Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A857C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 08:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6495B20776
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 08:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgE3IrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 04:47:25 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:42141 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgE3IrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 04:47:24 -0400
Received: by mail-oo1-f65.google.com with SMTP id h7so404543ooc.9;
        Sat, 30 May 2020 01:47:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KUiPLW++kmcly3aCmSvWC4ZHfAAKMPb5XtSsVdINur8=;
        b=UmfvU6jccRTErgMGI74TbKpCu9+BJtaSa4L1MaZamOgvhfIUI8pvJwhi34yr/jMVg3
         cJCM8LLjJx2rJrj85ys6825mw7TXTaK8Un7EL5lQuvOS+G6TT0wL5FvMC6VPwVND8XEs
         liSP7j7t4PnF1Li1ZKsoB6lEkOfHtCF8TRU/DlkbJhQe38NnwJZWT2zKjS6zcQd6d9DR
         bH2OgyAxc2CsGfnoPyi5/XozgVOXvNewgRrbMLBZ5B6hKRf2UONHQbXyHvIZbNI8VxXn
         EBvuOLzUUMGA5d97b/5ZYK1aYLT87i//7DFPsP7Ss2i8sInWGzh6WH5cdkp5/vH6peLW
         mG2A==
X-Gm-Message-State: AOAM5320XWQ11EWwwHZYmY8xtDXNaMPGZPUqj4mMT4oadeDM/OZ5D1NG
        G1TXuehqtB8xskhLD6NcNlXjcwW3faEwOyBqYbyA2DSa
X-Google-Smtp-Source: ABdhPJy2NJ9FpsphJhj/gX+n82MSl/+XZvudQR796G9RniEocB1ZMMcgOibRyrtgCzxVQkvWB+w+wQDjUdou6A35JQs=
X-Received: by 2002:a4a:e295:: with SMTP id k21mr10042556oot.11.1590828442925;
 Sat, 30 May 2020 01:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200424221948.1120587-1-arnd@arndb.de> <20200507143552.GA28683@infradead.org>
 <20200528054600.GA29717@infradead.org> <20200528161416.GY1079@brightrain.aerifal.cx>
 <20200529143059.GA25475@infradead.org> <20200529175335.GK1079@brightrain.aerifal.cx>
 <e86e1d78-9597-811a-da0e-42a910b0c9fe@physik.fu-berlin.de>
In-Reply-To: <e86e1d78-9597-811a-da0e-42a910b0c9fe@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 30 May 2020 10:47:11 +0200
Message-ID: <CAMuHMdWsdV83C0JiGUqUDsoFpuwsfuR5Z+XLM-X28ipN4GV8JA@mail.gmail.com>
Subject: Re: [GIT PULL] sh: remove sh5 support
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Rich Felker <dalias@libc.org>,
        Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Rob Landley <rob@landley.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 30, 2020 at 10:08 AM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 5/29/20 7:53 PM, Rich Felker wrote:
> > Frustratingly, I _still_ don't have an official tree on kernel.org for
> > the purpose of being the canonical place for linux-next to pull from,
> > due to policies around pgp keys and nobody following up on signing
> > mine. This is all really silly since there are ridiculously many
> > independent channels I could cryptographically validate identity
> > through with vanishing probability that they're all compromised. For
> > the time being I'll reactivate my repo on git.musl-libc.org.
>
> May I suggest to pick up these patches, for example? There might be
> more I missed, but getting these merged should already help a lot with
> the clean-up of arch/sh.

And https://marc.info/?l=linux-arch&m=153337991312146&w=2

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
