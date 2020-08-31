Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437A9C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27ED3208DB
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598898133;
	bh=9r8aaloGtB05zuDygzwP8Oanncg7sLU/0FTx/zIqTpY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lzPTiYp6JSUU18Nji+Y4Czb9fNjvWLOXeiab2sDkM1U8GHXARkznYfpAoJtDvpL5H
	 stwl9ZEY2lzHVU8mqx4l8CJ5ci2/IdBDZxGIVN2FLPlkYtMymZvdh8FffiOQ50gO6h
	 WHQtouL4YRGDiSpVWoCsxTHTl+hmuuCrqjmXVnD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbgHaSWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729043AbgHaSWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:22:11 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2049C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 11:22:10 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e11so7818593ljn.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 11:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jTgzspytD7DuzYJj7jRzial3MrRwpGnfxvjiXd0RJrg=;
        b=N2g1q/JlCxdx+13x2JZxaLmluk+WXW7bphbyfghBpkD0grHOsaVxOS8iWElJyflhut
         uEXYE1QCTv5zYzdWdWQOCnGSPE6RMGzxGSXeCBlSKmDD75jiddhL9VLF8BzVEifBSp3x
         TiMDN4tgP6a/sYMe98YwS0rxdCl8ccDfbJ8cU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jTgzspytD7DuzYJj7jRzial3MrRwpGnfxvjiXd0RJrg=;
        b=VU/6KrOuSvlueAKvy/7s0OXYaPsVD9jUWK+OHcP4zZboIMZPl3tFPLegEC1gw9JGo4
         08AZVaiF6v2BsoY8iy11sjE6zyYs06NOu9TCrHowpv5fq/fQhw1gRd3/hJCnQfxyMtMV
         lAyF6z2xVihj2VXPCpOW00Ld2WWDHa+jkFf4qBXtIzFIEIvys3NbC9YOjhxY/Rn7DXJf
         xTAgqMfhi1dACHhktQsQ39Q46PPMW9wVEofScji6WkME1SgNwR+L8n/HL6lKrs2/VeNp
         EXtrzIQSYW5u5zgvJVM4X1z6YvGjWw58V/A7LoJ5+di/eguLcUiyOYn0t0HZ2ZvH7PGO
         VY4A==
X-Gm-Message-State: AOAM533Gg3CLPGnF65nzby6oVO3o2hsMwyrPcCWJ5M0ViSyWN9MlUkJU
        6hIfqN8IiU57XizZVPHSQLS0lFRMohduIQ==
X-Google-Smtp-Source: ABdhPJyQrsP66qcwcyN2WdCCFySIsALrE3oYy6giCGAT/nCAJJZSC0Cz1XPZTnC7ul9nr898CGiqqg==
X-Received: by 2002:a2e:8e7a:: with SMTP id t26mr1279173ljk.72.1598898128580;
        Mon, 31 Aug 2020 11:22:08 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id w4sm466689ljm.50.2020.08.31.11.22.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 11:22:07 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id e11so7818460ljn.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 11:22:07 -0700 (PDT)
X-Received: by 2002:a05:651c:219:: with SMTP id y25mr1144547ljn.314.1598898126633;
 Mon, 31 Aug 2020 11:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d3a33205add2f7b2@google.com> <20200828100755.GG7072@quack2.suse.cz>
 <20200831100340.GA26519@quack2.suse.cz>
In-Reply-To: <20200831100340.GA26519@quack2.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 31 Aug 2020 11:21:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wivRS_1uy326sLqKuwerbL0APyKYKwa+vWVGsQg8sxhLw@mail.gmail.com>
Message-ID: <CAHk-=wivRS_1uy326sLqKuwerbL0APyKYKwa+vWVGsQg8sxhLw@mail.gmail.com>
Subject: Re: kernel BUG at fs/ext4/inode.c:LINE!
To:     Jan Kara <jack@suse.cz>
Cc:     syzbot <syzbot+3622cea378100f45d59f@syzkaller.appspotmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Linux-MM <linux-mm@kvack.org>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 3:03 AM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 28-08-20 12:07:55, Jan Kara wrote:
> >
> > Doh, so this is:
> >
> >                         wait_on_page_writeback(page);
> > >>>                     BUG_ON(PageWriteback(page));
> >
> > in mpage_prepare_extent_to_map(). So we have PageWriteback() page after we
> > have called wait_on_page_writeback() on a locked page. Not sure how this
> > could ever happen even less how ext4 could cause this...
>
> I was poking a bit into this and there were actually recent changes into
> page bit waiting logic by Linus. Linus, any idea?

So the main change is that now if somebody does a wake_up_page(), the
page waiter will be released - even if somebody else then set the bit
again (or possible if the waker never cleared it!).

It used to be that the waiter went back to sleep.

Which really shouldn't matter, but if we had any code that did something like

        end_page_writeback();
        .. something does set_page_writeback() on the page again ..

then the old BUG_ON() would likely never have triggered (because the
waiter would have seen the writeback bit being set again and gone back
to sleep), but now it will.

So I would suspect a pre-existing issue that was just hidden by the
old behavior and was basically impossible to trigger unless you hit
*just* the right timing.

And now it's easy to trigger, because the first time somebody clears
PG_writeback, the wait_on_page_writeback() will just return *without*
re-testing and *without* going back to sleep.

Could there be somebody who does set_page_writeback() without holding
the page lock?

Maybe adding a

        WARN_ON_ONCE(!PageLocked(page));

at the top of __test_set_page_writeback() might find something?

Note that it looks like this problem has been reported on Android
before according to that syzbot thing. Ie, this thing:

    https://groups.google.com/g/syzkaller-android-bugs/c/2CfEdQd4EE0/m/xk_GRJEHBQAJ

looks very similar, and predates the wake_up_page() changes.

So it was probably just much _harder_ to hit before, and got easier to hit.

Hmm. In fact, googling for

        mpage_prepare_extent_to_map "kernel BUG"

seems to find stuff going back years. Here's a patchwork discussion
where you had a debug patch to try to figure it out back in 2016:

    https://patchwork.ozlabs.org/project/linux-ext4/patch/20161122133452.GF3973@quack2.suse.cz/

although that one seems to be a different BUG_ON() in the same area.

Maybe entirely unrelated, but the fact that this function shows up a
fair amount is perhaps a sign of some long-running issue..

              Linus
