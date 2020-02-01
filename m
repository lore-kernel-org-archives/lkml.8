Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A09C33CB3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 18:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70BF2067C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 18:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580582293;
	bh=jLH4wEw8rZLMYjqJhTq87qkAor2ag91iYvNUm+b6y/M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0sTPWGdd+AWKpoy+FlwK3QNsTzpq2vEkWZ+VJBdBetv1omo9bVNHct3bDu+1ojhSW
	 Dr33HpoVvY1gpgMgjvnpyeCRKW4d5C96AW3V6boS3+HbDU464ofYj452kthBvsqBRA
	 X1/mrsimok0JZIAMjUzVidzsBhdd2kDoe4iTmehI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgBASiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 13:38:12 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34549 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgBASiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 13:38:11 -0500
Received: by mail-lf1-f67.google.com with SMTP id l18so7060860lfc.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Feb 2020 10:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FkJZcbPG3GM9ebKeh3YrJmylA5LrC+6BQTvSZ1tS0BM=;
        b=AOSqEne73JzS5Ei2xVkag6DwnX4Pcm5Bcfqq6ZhtJ1WXnP5jDZ/BcD9EG52JUlO24h
         qMqSKLfSwGlsJRuRGiD8UfUYJyvse5ov65l2TAtvz6VuaF6ELjEX+hyxZ0lOQw9HU8LS
         iGOUYTda+sYLB6Lj5gDfNSSkXhghbF+vOriz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FkJZcbPG3GM9ebKeh3YrJmylA5LrC+6BQTvSZ1tS0BM=;
        b=OurNosgSaymZZP/grCBXpUVF0EH37pNuV5aOPR6ePv1diqdz1v8arVH1949+isobPH
         EXiH9bMMfAU7eHXkN6Zuj3EMLBkRWGtRVIioRIADQeaDBj+Lff6b3m6Arvo5RtwVNMSL
         jxAjvSgGbk1wnwn3g5T5Ed0H2jQ1Am/FZ7FLxUyGlNTCE0+teFXil2GqKK/t29wMYd+W
         XYPWJGukOdkGOxTvgSoMbHSlKL8WcowYTr+1iweWwzjhzW59/8fZYJAWeWXE1PrqezYZ
         9t9StigyyWB3BkufJXB7MGjIAPyO1SLyJMk3cw8TOD7U5BCUtXdWF46K3YuxZfs88HwA
         Tuvw==
X-Gm-Message-State: APjAAAWTdt9lFpXtrpYmjvRhiani164d4dc5tPjAEknuJLs++tNtCba6
        1o0cPfiXfSXokVXh5pgNUfzzV7U3t/s=
X-Google-Smtp-Source: APXvYqzvrll5M+5RZ0cjMEYJh6OfG/Ytd0bMGtVoCx7Pag+bJsPgCWYs7Xs4aBc+4OZkbT2/vxojYg==
X-Received: by 2002:a19:5f5e:: with SMTP id a30mr8206615lfj.183.1580582289360;
        Sat, 01 Feb 2020 10:38:09 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id 14sm6360739lfz.47.2020.02.01.10.38.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2020 10:38:08 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id v201so6999649lfa.11
        for <linux-kernel@vger.kernel.org>; Sat, 01 Feb 2020 10:38:08 -0800 (PST)
X-Received: by 2002:ac2:43a7:: with SMTP id t7mr8274829lfl.125.1580582287989;
 Sat, 01 Feb 2020 10:38:07 -0800 (PST)
MIME-Version: 1.0
References: <20200201162645.GJ23230@ZenIV.linux.org.uk> <CAHk-=wgKnDkhvV44mYnJfmSeEnhF-ETBHGtq--8h3c03XoXP7w@mail.gmail.com>
 <20200201183231.GL23230@ZenIV.linux.org.uk>
In-Reply-To: <20200201183231.GL23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 1 Feb 2020 10:37:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=whXZHKJfet=DHYH7aYWvBLP87S4+NMOvXvaC0aYt-GazA@mail.gmail.com>
Message-ID: <CAHk-=whXZHKJfet=DHYH7aYWvBLP87S4+NMOvXvaC0aYt-GazA@mail.gmail.com>
Subject: Re: [PATCH] fix do_last() regression
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 1, 2020 at 10:32 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> >
> > I'm assuming you want me to apply this directly as a patch, or was it
> > meant as a heads-up with a future pull request?
>
> The former, actually, but I can throw it into #fixes and send a pull
> request if you prefer it that...

I've applied it. I just wanted to check, since you end up doing both at times..

               Linus
