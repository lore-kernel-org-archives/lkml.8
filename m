Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879F8C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588C9206F5
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585936892;
	bh=7zmbXy9Ngm7ydugKdrnEPuKqypDBIdC9kEsYoVRFRUg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ylyZImI8f+qg9wPnU7MibCN1Botc5PUDL8SyWa6U9VzIpEgQWaGYayi00XUz6KgpS
	 /yNYaZHDk8gJz904uxX83c2uwVhca+eDHBhDcZi0KLBa27VP4sOkZkZ7oQxD0U2FZ5
	 H9PKwdssTJZTSzAJMZlqhisFM4MO8YP+kpd0MG4w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404394AbgDCSBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 14:01:31 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35201 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbgDCSBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 14:01:30 -0400
Received: by mail-lj1-f196.google.com with SMTP id k21so7922872ljh.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 11:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GJVFgRSGYKBnNbBPTVD/IukQXQa7rwPwND5Kh+NTBuo=;
        b=Ys0nLdOPaMPZHWrNpQG57PugKN6mkPGdJSUx/TQDpwY2GQmZdYkhxJaiTGDykgi3DV
         b9peyP0pK7wyoIA4rX92GpUwZxOJ1gL4WdkK8qsym8w0OHPBQz5LC8Pgsely+7R6EED/
         Y1qrLKu/XLubSi3S/jM7cWoFX4dK0Vuw/7IEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GJVFgRSGYKBnNbBPTVD/IukQXQa7rwPwND5Kh+NTBuo=;
        b=CmKZ2S2rbDc0+gjPkl96Lhp+i+E5QLRYCuHdztUAYY1B4Ep702/MJjfyryq9M2T/bn
         G2RbE/tBo4oiK4MgXAnMUFDl9fMBf7+TyCi37nvcMCU/PBaCey1b/x6Ix0nWn+IakETG
         okXn4xbQlAwJrJIbVKdGPWD/MAXcbQa0fGZudEJFPXFeB7fL00pcZsol+l2u4lvk2B6H
         DrZ2Gzh1TbDUK5xfbiv3lE+oWk18LPqrxlWpTgBF8mZpUlurR7ulOBZK1d4p3PP21olV
         2VToR1VqwRQMKT69CWH3u5MWufOx3NXZ/MYApz2DIMqK3bxAjozdHQMi9riGJA2MnfxU
         5MCA==
X-Gm-Message-State: AGi0PuZEF2iWgEonyJ+6neT5B+aMNE9SJynATQLdB0SLHt0Ud/PqbNLe
        /Ha548CP40Ulil0a/dD1WYz5OMOPwuM=
X-Google-Smtp-Source: APiQypKnGS8j5JnvV6+AX+j4b7TukVykzor1tDBx+LJFEIJKj61JI0V5cgNNZqe7iqpITgbm+SOWTw==
X-Received: by 2002:a2e:91cc:: with SMTP id u12mr5875418ljg.244.1585936888402;
        Fri, 03 Apr 2020 11:01:28 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id c203sm4602756lfd.38.2020.04.03.11.01.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 11:01:27 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id t17so7848792ljc.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 11:01:27 -0700 (PDT)
X-Received: by 2002:a2e:8652:: with SMTP id i18mr5777613ljj.265.1585936886747;
 Fri, 03 Apr 2020 11:01:26 -0700 (PDT)
MIME-Version: 1.0
References: <36e43241c7f043a24b5069e78c6a7edd11043be5.1585898438.git.christophe.leroy@c-s.fr>
 <42da416106d5c1cf92bda1e058434fe240b35f44.1585898438.git.christophe.leroy@c-s.fr>
In-Reply-To: <42da416106d5c1cf92bda1e058434fe240b35f44.1585898438.git.christophe.leroy@c-s.fr>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Apr 2020 11:01:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_DY_dysMX0NuvJmMFr3+QDKOZPZqWKwLkkjgZTuyQ+A@mail.gmail.com>
Message-ID: <CAHk-=wh_DY_dysMX0NuvJmMFr3+QDKOZPZqWKwLkkjgZTuyQ+A@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] uaccess: Rename user_access_begin/end() to user_full_access_begin/end()
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, Peter Anvin <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        intel-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 3, 2020 at 12:21 AM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
> Now we have user_read_access_begin() and user_write_access_begin()
> in addition to user_access_begin().

I realize Al asked for this, but I don't think it really adds anything
to the series.

The "full" makes the names longer, but not really any more legible.

So I like 1-4, but am unconvinced about 5 and would prefer that to be
dropped. Sorry for the bikeshedding.

And I like this series much better without the cookie that was
discussed, and just making the hard rule be that they can't nest.

Some architecture may obviously use a cookie internally if they have
some nesting behavior of their own, but it doesn't look like we have
any major reason to expose that as the actual interface.

The only other question is how to synchronize this? I'm ok with it
going through the ppc tree, for example, and just let others build on
that.  Maybe using a shared immutable branch with 5.6 as a base?

                   Linus
