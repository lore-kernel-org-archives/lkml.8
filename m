Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1585FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6309206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597161948;
	bh=6VAcSjgZn3Bc1suWKT+wm6uoWCRQT4l+Ze7ZOiqRwQc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eo14ZX9f3b9OicBu/xdZ9kjcWGPcdn6wjZxjdktMV1DeVsGL1KEDUbWIkq17EI07y
	 bD2FIsJnRBpQ+fBIEeelkmmvZR8sXKvECuqvzTgy/14/ts2SzBKvPtZCXdK96hBvX2
	 9KjG2NdSamWCOa9Ifj8CccKgFmMuVaICw/i9I3ao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbgHKQFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 12:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbgHKQFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:05:42 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE3EC061787
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 09:05:41 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id f26so12716253ljc.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 09:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LM4jBsQMzRRDK/34QKUyfcJDWJhksJw26XHd2o7K/hw=;
        b=h5REYG6BLAhcl7YCtx2yrw4ToGBDJU4uXkvyEjPSm/S5Qgt/fykHaqSq3JywpXVzhk
         cx/W8MOJkg0ndiBLZgviuz2vr1RU763vUQcJdmRoZ6xko8AzSyxIh/lsVnNs/b3a8lQl
         8o4utRdytVjQvpDmIMQfxUgnL+ljmt3Z+u/5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LM4jBsQMzRRDK/34QKUyfcJDWJhksJw26XHd2o7K/hw=;
        b=qIXAp3AvfBPF2DQVK1ADmiWwB+9YWf1jwIyYoOc2CDt/GFx4OYwrqnG3JeFyPVfdxs
         7TtUVu+OFaOsvVmXvt0D6zXHY+n8B48PjYxYintVtc1cvUAS/1K2chlbocCGieFgBA7C
         N2LQ8n8nzSVzWYSUz4LAqH/Z/rW2yoQw+tZ43EP/k7BJ+JNF6Ti363fYjkBRvyT6nkYZ
         3HzoUftZ8gQGepfBZ81QQLh8c7DdGJPv2Mv111mFKJKmvcq9dHv2PzTQoAd0az2BePW5
         ym6sbXMNaFTCcYuYvNfCf7NN4ngVAprmee7F+8epXBNF4WM9FIcfvfdwiHflFoVtL1at
         nAgQ==
X-Gm-Message-State: AOAM531/TobHwNf58B5GhoO2qYTCXOTYIfvu9rudF/ppkaiX3WLTyTU4
        AcUOFHMaab+Z5YafcPpyIGEpSmK9aes=
X-Google-Smtp-Source: ABdhPJzEKSHL6r/re60xgiJ3NzqQ9qMl4mOQcpJKbeeP49WCgUGpbz3rDFLArJfxtugcvP79VZmULA==
X-Received: by 2002:a2e:2a86:: with SMTP id q128mr3039629ljq.116.1597161939440;
        Tue, 11 Aug 2020 09:05:39 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id u9sm11728760lfl.75.2020.08.11.09.05.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 09:05:39 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 185so14118080ljj.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 09:05:38 -0700 (PDT)
X-Received: by 2002:a2e:2e04:: with SMTP id u4mr3184107lju.102.1597161938384;
 Tue, 11 Aug 2020 09:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <CAJfpegtWai+5Tzxi1_G+R2wEZz0q66uaOFndNE0YEQSDjq0f_A@mail.gmail.com>
In-Reply-To: <CAJfpegtWai+5Tzxi1_G+R2wEZz0q66uaOFndNE0YEQSDjq0f_A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Aug 2020 09:05:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg_bfVf5eazwH2uXTG-auCYZUpq-xb1kDeNjY7yaXS7bw@mail.gmail.com>
Message-ID: <CAHk-=wg_bfVf5eazwH2uXTG-auCYZUpq-xb1kDeNjY7yaXS7bw@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 8:30 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> What's the disadvantage of doing it with a single lookup WITH an enabling flag?
>
> It's definitely not going to break anything, so no backward
> compatibility issues whatsoever.

No backwards compatibility issues for existing programs, no.

But your suggestion is fundamentally ambiguous, and you most
definitely *can* hit that if people start using this in new programs.

Where does that "unified" pathname come from? It will be generated
from "base filename + metadata name" in user space, and

 (a) the base filename might have double or triple slashes in it for
whatever reasons.

This is not some "made-up gotcha" thing - I see double slashes *all*
the time when we have things like Makefiles doing

    srctree=../../src/

and then people do "$(srctree)/". If you haven't seen that kind of
pattern where the pathname has two (or sometimes more!) slashes in the
middle, you've led a very sheltered life.

 (b) even if the new user space were to think about that, and remove
those (hah! when have you ever seen user space do that?), as Al
mentioned, the user *filesystem* might have pathnames with double
slashes as part of symlinks.

So now we'd have to make sure that when we traverse symlinks, that
O_ALT gets cleared. Which means that it's not a unified namespace
after all, because you can't make symlinks point to metadata.

Or we'd retroactively change the semantics of a symlink, and that _is_
a backwards compatibility issue. Not with old software, no, but it
changes the meaning of old symlinks!

So no, I don't think a unified namespace ends up working.

And I say that as somebody who actually loves the concept. Ask Al: I
have a few times pushed for "let's allow directory behavior on regular
files", so that you could do things like a tar-filesystem, and access
the contents of a tar-file by just doing

    cat my-file.tar/inside/the/archive.c

or similar.

Al has convinced me it's a horrible idea (and there you have a
non-ambiguous marker: the slash at the end of a pathname that
otherwise looks and acts as a non-directory)

               Linus
