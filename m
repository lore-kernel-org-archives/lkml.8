Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D83C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 21:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A132173E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 21:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581541384;
	bh=7Sd9AozWdi6ADgVh+KdvO22gRmfmYpItxhoTBdpX8UE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qi4jlh9KM+BQMy1HNrLLKq+DKZu9/9K69m1iPGrjyrSj6moIRsyezfpl4UKmnklGD
	 APUOGbDl4jWK1DodJg3wHDdtCDjVEDI8Q5mrm44jcXO73yT+DRFbQO7zDKqhdb8hS3
	 LefNtUKiOWSbdZcHvvAfF6ZIkCwdLostJKrJBgXg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbgBLVDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 16:03:03 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34399 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbgBLVDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 16:03:02 -0500
Received: by mail-lj1-f195.google.com with SMTP id x7so4012935ljc.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 13:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WySKsoF25f/J4EpIF80nlYeN07mmY9MX1gph6T2llNA=;
        b=Q58W0NiVVgTX+oNnbx2yak8H3LqZJhOMXKR6Ng/loJu7bqEx0qJqJdUgYoD/Insl5V
         0bdfWlwpi7ZWdHerxvV1fP32PeO3Q+Sr+beCxumaLAw59xU5UE6TavPtsaLJeIdwxKCP
         /m8KW47+oG3MYjz8Wo+heg9mc0RztoSq3bL84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WySKsoF25f/J4EpIF80nlYeN07mmY9MX1gph6T2llNA=;
        b=bkZpF9YN+CqdlVNN23n+glQvC5Jn2zU2KI6KIDCGrMWZPiSG2McnpbX+JjXlRJQeiS
         z2uApAUrmPHnr9EluV9Td6M9y0na42KbhE94X6yHVE9VUDT4chraSgF0pnCjWPHE5hiI
         yng2JXsoNwukCi9/uGLbZxoN505QW37HSV9yULiNruijgYT+Pmf21GHtEbybeoopBSNc
         8RvASLrlXrTk6XBnBJ7aIrW1MuqO8Elhfmc09uWHm/pSYOfEqE0CJTwB84ss+RlAPNmX
         z/3dGUvABpJTryOJ+9fwjir0eKgBDB02iZWRBqQpG91t9cE71TYdhSMnA8WqdgC9Yj83
         +Xtw==
X-Gm-Message-State: APjAAAXsSbjLD5wzbhFOaJkNpXECRytdOUNIlHRfWRTOeVpNikwfRNca
        xOtQBspK2DKTTwqZj+L58ri1xUqDR5Q=
X-Google-Smtp-Source: APXvYqw8otmaH52BHdOEB8oYJcqz0F0dkeM1u/raw+KOt70aTUkm09+Yt+9dDhICl6L96Z/kygfqmg==
X-Received: by 2002:a05:651c:111a:: with SMTP id d26mr8803173ljo.153.1581541379313;
        Wed, 12 Feb 2020 13:02:59 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id p9sm152018ljg.55.2020.02.12.13.02.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 13:02:57 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id d10so3988272ljl.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 13:02:57 -0800 (PST)
X-Received: by 2002:a2e:97cc:: with SMTP id m12mr8729073ljj.241.1581541376733;
 Wed, 12 Feb 2020 13:02:56 -0800 (PST)
MIME-Version: 1.0
References: <20200210150519.538333-8-gladkov.alexey@gmail.com>
 <87v9odlxbr.fsf@x220.int.ebiederm.org> <20200212144921.sykucj4mekcziicz@comp-core-i7-2640m-0182e6>
 <87tv3vkg1a.fsf@x220.int.ebiederm.org> <CAHk-=wg52stFtUxMOxs3afkwDWmWn1JXC7RJ7dPsTrJbnxpZVg@mail.gmail.com>
 <87v9obipk9.fsf@x220.int.ebiederm.org> <CAHk-=wgwmu4jpmOqW0+Lz0dcem1Fub=ThLHvmLobf_WqCq7bwg@mail.gmail.com>
 <20200212200335.GO23230@ZenIV.linux.org.uk> <CAHk-=wi+1CPShMFvJNPfnrJ8DD8uVKUOQ5TQzQUNGLUkeoahkg@mail.gmail.com>
 <20200212203833.GQ23230@ZenIV.linux.org.uk> <20200212204124.GR23230@ZenIV.linux.org.uk>
In-Reply-To: <20200212204124.GR23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Feb 2020 13:02:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi5FOGV_3tALK3n6E2fK3Oa_yCYkYQtCSaXLSEm2DUCKg@mail.gmail.com>
Message-ID: <CAHk-=wi5FOGV_3tALK3n6E2fK3Oa_yCYkYQtCSaXLSEm2DUCKg@mail.gmail.com>
Subject: Re: [PATCH v8 07/11] proc: flush task dcache entries from all procfs instances
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 12:41 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Feb 12, 2020 at 08:38:33PM +0000, Al Viro wrote:
> >
> > Wait, I thought the whole point of that had been to allow multiple
> > procfs instances for the same userns?  Confused...
>
> s/userns/pidns/, sorry

Right, but we still hold the ref to it here...

[ Looks more ]

Oooh. No we don't. Exactly because we don't hold the lock, only the
rcu lifetime, the ref can go away from under us. I see what your
concern is.

Ouch, this is more painful than I expected - the code flow looked so
simple. I really wanted to avoid a new lock during process shutdown,
because that has always been somewhat painful.

            Linus
