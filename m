Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D797BC34047
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A773D2176D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyGhJImP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgBRUSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:18:41 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:44193 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgBRUSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:18:41 -0500
Received: by mail-il1-f195.google.com with SMTP id s85so18477742ill.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 12:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=C/jE0M3pRJqHgG/Qvsb/JFfEhjljeMExkov2qbtmNjM=;
        b=RyGhJImPMvR6Wtbli41ycF+ATihWtFKW+/qGlg/Qy/YSqgmXcgHFwRS+VyEV7xc7t5
         OoQJa7S1KjwVWlVrJ9nrmwln2LTPRC+AThG33C08oI9cJTgEsT98GMfM9dZq7kwXZINm
         oouOeyIjOEhk6hyDLnACdPupsfwna+DZIA6sL8S0FVn58yiq0EI4Kms/BO++OvuX8DV9
         9Fg4065RriLmC9e3Fbf5BpFwnVu4nzkVLOdj+62yEMihlJMYxK+gATAVBtHDgAjCjlp/
         MppwLYcuwrBppHpzmGWAr7cuwVVwV8xGhpo2u4nzZ8YAlR+k5LrG3pyOfARdxL5VhNgK
         x2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C/jE0M3pRJqHgG/Qvsb/JFfEhjljeMExkov2qbtmNjM=;
        b=X+O83WNrzqOoAk2wgVBkzn7Si5uWaLV5J294OOt0Dwfk8g024hvuXRln2VXyXeCKOY
         q3mt6UzEeJVy+J+2X+8sHR4ROe0baeJctH6+DyOhVErKvJIp4uQuOHxFYy4vL2DNVSBs
         +6zEyPT4R9XTzmHyxBL3IZzjJAWYnASTstX+domn2KtP0Jqy7/lRj1G1ebd6v5x2+hJq
         lAoEQP3jXGTj0CVtw6+K7Q7PpvzAf1rp1MJws+WWXQFScVWYPviouNMQXL5mh3Wbv7HY
         fyDt9x8OQ8ytohlLpv6cGqBq2Dsotpa65Pi03yOdxrSQYuzdvPKDCFMOGQZjKVd/6Yn2
         eYxQ==
X-Gm-Message-State: APjAAAWzaVw1NKy9eDU1l9FHjTEGlijpcPnYC89OtKFmTu+pZxA6zMj4
        4zTt9QB+PQpZEM64clx1IwWrnJy9l/vNmlpbdI4=
X-Google-Smtp-Source: APXvYqznkbjgK0ySLJ4wyZ6Dzg7UjUSJk/sItJeUIW4Xj9s65eqHE9Acrr6GcmDvvcA39mUByeam0pq/eRA7YCMfZZU=
X-Received: by 2002:a92:b749:: with SMTP id c9mr20564091ilm.143.1582057120658;
 Tue, 18 Feb 2020 12:18:40 -0800 (PST)
MIME-Version: 1.0
References: <20200217222803.6723-1-idryomov@gmail.com> <202002171546.A291F23F12@keescook>
 <CAOi1vP-2uAD83Vi=Eebu_GPzq5DUt+z9zogA7BNGF1B1jUgAVw@mail.gmail.com>
 <CAHk-=whj0vMcdVPC0=9aAsN2-tsCyFKF4beb2gohFeFK_Z-Y9g@mail.gmail.com>
 <20200218193136.GA22499@angband.pl> <CAHk-=wjEd-gZ1g52kgi_g8gq-QCF2E01TkQd5Hmj4W5aThLw3A@mail.gmail.com>
In-Reply-To: <CAHk-=wjEd-gZ1g52kgi_g8gq-QCF2E01TkQd5Hmj4W5aThLw3A@mail.gmail.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Tue, 18 Feb 2020 21:19:06 +0100
Message-ID: <CAOi1vP_Ned9QG32+o9KT-Bh3qMTb6h0SaP8W74Am_gkVX3mcSQ@mail.gmail.com>
Subject: Re: [PATCH] vsprintf: don't obfuscate NULL and error pointers
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Adam Borowski <kilobyte@angband.pl>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Tobin C . Harding" <me@tobin.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 8:39 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Feb 18, 2020 at 11:31 AM Adam Borowski <kilobyte@angband.pl> wrot=
e:
> >
> > Either "0" or "NULL" (or "=E2=88=85" if you allow cp437-subset Unicode =
) wouldn't
> > cause such confusion.
>
> An all-uppercase "NULL" probably matches the error code printout
> syntax better too, and is more clearly a pointer.
>
> And with %pe you can't assume columnar output anyway (unless you
> explicitly ask for some width), so the length of the output cannot
> matter.
>
> So yeah, I agree. To extend on Ilya's example:
>
>                               ptr        error-ptr             NULL
>   %p:            0000000001f8cc5b fffffffffffffff2 0000000000000000
>   %pK, kptr =3D 0: 0000000001f8cc5b fffffffffffffff2 0000000000000000
>   %px:           ffff888048c04020 fffffffffffffff2 0000000000000000
>   %pK, kptr =3D 1: ffff888048c04020 fffffffffffffff2 0000000000000000
>   %pK, kptr =3D 2: 0000000000000000 0000000000000000 0000000000000000
>   %p:            0000000001f8cc5b -EFAULT NULL

    ^^^
I assume you meant %pe here.

>
> would seem to be a sane output format. Hmm?

Looks sensible to me.  Without this patch NULL is obfuscated for
both %p and %pe though.  Do you want this patch amended or prefer
a follow-up for %pe "0000000000000000" -> "NULL" so that it can be
discussed separately?

Thanks,

                Ilya
