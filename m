Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9E2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 21:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74A14206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 21:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591131810;
	bh=mMHKcYz6NBtTxAZJ8fZ/hHwtKVDjeczyhzrZQWubwTg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jcT82IVEfolV9Sgyk6Att3gwo7FQDnuAtoxPmk1ijcNvPx8m8Trp0UZu49yVqPO38
	 CCKFFKIQ16yRDeBraUGW68WIdXAT5+RpO2m9JAzXKGotT6xcFlhphDnXPj+ZMco78M
	 38AgjcCv0WrALHHBxS3vhiLjsaNjAEfDmqyFL8FM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgFBVDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 17:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgFBVD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 17:03:29 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA94FC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 14:03:28 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id u10so13121185ljj.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 14:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0bJlmus5XHXjv1rw00vbaJw33tmb8qsAo8E9SyQVB5o=;
        b=c3OO9Eib+9QFWyiyGkaP3OWFMYITgu0SqFYiihv1nDFfvPl5LG+QGROmQ0W2vvF9TH
         xFPPXbu1d1Ijk8yKx1L8kgzVX4/QMqVlDd/+mMyGn+W6nAmAlpRGjtWXYEvN82lx37MV
         fur6Zc96Tv4VAr6lx2n2EUxpsK34AWMPsgGCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0bJlmus5XHXjv1rw00vbaJw33tmb8qsAo8E9SyQVB5o=;
        b=Cm+9C3Zm0w8m9uyUCukUJBq2OoeWmRw0LGtN77XQQDf/2hYuE/y97TZ2NADFG8mYl5
         YM4E+KDluzLxhprfZwlYQ63HS3tDm0p2FAn37eZS7pe+8FUev928AwuJdzo+/GP5X0h4
         NEKPRR8wCmG8OlvCNrcU5b6O6ydU1tZfr2vX/QgcVnBn/KKkABIB66q9N/DCe9s8o5TR
         5NZmBQ6BcDRLpxZdgF0WbDtpjP7Gi+2TQcPu1YgRDngej2jjRcChq430VRmQ5tnLGYLD
         YIXEAByY+i/2VH+ZLTe+Ogs7u/sqbYmvAz3dnqLGH9L4tqsvXfOSIRJ8LSZFqqTcMvXZ
         cCHg==
X-Gm-Message-State: AOAM530tVubm1FNGKF8qjusAaxO0hE24xes2R2N5cWsH2moxUHUHFt76
        juqNx5HPm3i32+2Q835P46z35eRAbEs=
X-Google-Smtp-Source: ABdhPJxt2mk0nvaMRJbM2xnk8wiggj6vk9JQ4mpdDBQp3pKG4DQwnB5cRyVvn3cscmc/MdCsmMHiaQ==
X-Received: by 2002:a2e:88d5:: with SMTP id a21mr429346ljk.31.1591131806748;
        Tue, 02 Jun 2020 14:03:26 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id s20sm46094lfb.48.2020.06.02.14.03.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 14:03:25 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id z18so14300110lji.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 14:03:25 -0700 (PDT)
X-Received: by 2002:a2e:7e0a:: with SMTP id z10mr460164ljc.314.1591131805045;
 Tue, 02 Jun 2020 14:03:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200602204219.186620-1-christian.brauner@ubuntu.com>
In-Reply-To: <20200602204219.186620-1-christian.brauner@ubuntu.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Jun 2020 14:03:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjy234P7tvpQb6bnd1rhO78Uc+B0g1CPg9VOhJNTxmtWw@mail.gmail.com>
Message-ID: <CAHk-=wjy234P7tvpQb6bnd1rhO78Uc+B0g1CPg9VOhJNTxmtWw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] close_range()
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kyle Evans <self@kyle-evans.net>,
        Victor Stinner <victor.stinner@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 2, 2020 at 1:42 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> This is a resend of the close_range() syscall, as discussed in [1]. There weren't any outstanding
> discussions anymore and this was in mergeable shape. I simply hadn't gotten around to moving this
> into my for-next the last few cycles and then forgot about it. Thanks to Kyle and the Python people,
> and others for consistenly reminding me before every merge window and mea culpa for not moving on
> this sooner. I plan on moving this into for-next after v5.8-rc1 has been released and targeting the
> v5.9 merge window.

Btw, I did have one reaction that I can't find in the original thread,
which probably means that it got lost.

If one of the designed uses for this is for dropping file descriptors
just before execve(), it's possible that we'd want to have the option
to say "unshare my fd array" as part of close_range().

Yes, yes, you can do

        unshare(CLONE_FILES);
        close_range(3,~0u);

to do it as two operations (and you had that as the example typical
use), but it would actually be better to be able to do

        close_range(3, ~0ul, CLOSE_RANGE_UNSHARE);

instead. Because otherwise we just waste time copying the file
descriptors first in the unshare, and then closing them after.. Double
the work..

And maybe this _did_ get mentioned last time, and I just don't find
it. I also don't see anything like that in the patches, although the
flags argument is there.

            Linus
