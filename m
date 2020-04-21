Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FD1C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD17B20781
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qv7lLQEJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgDUMyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 08:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728285AbgDUMyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 08:54:40 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13578C061A10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 05:54:40 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k11so16367524wrp.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 05:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XKLt2tLOhrFeYQr9v0zgziEwqqiniTJlgpCzFjl5g3A=;
        b=qv7lLQEJ4KbfzmSp27WFTe8qKCESnFOmeVUGTaFGeKhCgf/K/AvJ7Fh7RDD+BovKub
         vg4xU/XPxtADY88BALs/2GpHG8IIjoIZynCztJQHA0k6Pu1frz62L9TUhQtdzehTbcGA
         HNAUKQHLTal9AfO2FyEWZpYfSZkXZtYcmSeDE9ijE+SeVyMJ93rsVG7vLMbG8dXGBe7L
         60x3Ml1x3zpZBQlPrtZJBxghR3u0qDKj3N+C04S5yLMIt/U920QnD7nrEKNJyNdpa4n4
         wwFFM7eh6VDskWlCWGoITe0paTXp6l+THa6Uumo5qlzR87pfKj+P+dJLHPPGByGQSOKc
         9ISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XKLt2tLOhrFeYQr9v0zgziEwqqiniTJlgpCzFjl5g3A=;
        b=Ir8INcdIAQ+ap65SnEwXU8MfoR1bN+MTOKosN22iNyuGqnt96eUzQwXfoLkN4PfJoU
         G307KGmv2bWfZqwkKOtK1NmXYwmnMYPUewzGJ/0/cYteViW6ZyCl+JdAT7X/owg/oTf2
         uiby8AtisVXpour8xwa+EInUYAMW/1gzWMuptPkZ7+PS04Z9eRh51IvQ2FrEebI8u2QK
         tYftQXDEVLUCCkYu3yaIU1a2TEDhIKcJhhAOa7Gf/MBgBrsttYS0zp2z+tB6tTgGBjCD
         uEMoNrYPFwB7qq09a20aDYFroHCSYVwmbo9Pb3Ymce5Kt069dllYnG52gWbNj+Mx1O3G
         WTNw==
X-Gm-Message-State: AGi0PuaV/jDYBHDHqMEcjuH0sDgdOdIL9tG3LseGcV24NJTxoEP9XzqW
        qA+7tThGYotP69Y52rAQoJDZUbbU2vKOZ/AfGGYW3A==
X-Google-Smtp-Source: APiQypLCmomm9CZLcXKXQhrCC5+Jlo5KICdNrvTwP2UKLCu00QK1aqSxSJLhAVlpy6xZrKIryG9gft7LhP3FI+zWwmw=
X-Received: by 2002:adf:f091:: with SMTP id n17mr23737132wro.200.1587473678527;
 Tue, 21 Apr 2020 05:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200419100848.63472-1-glider@google.com> <20200420153352.6682533e794f591dae7aafbc@linux-foundation.org>
 <202004201540.01C8F82B@keescook> <20200421034249.GB23230@ZenIV.linux.org.uk>
In-Reply-To: <20200421034249.GB23230@ZenIV.linux.org.uk>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 21 Apr 2020 14:54:23 +0200
Message-ID: <CAG_fn=X_eQ4G-0+oAO_q+_zRnkfMf4uhfMcnoYt4i1N_noKgdA@mail.gmail.com>
Subject: Re: [PATCH] fs/binfmt_elf.c: allocate initialized memory in fill_thread_core_info()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, sunhaoyl@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 5:42 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Apr 20, 2020 at 03:41:40PM -0700, Kees Cook wrote:
> > On Mon, Apr 20, 2020 at 03:33:52PM -0700, Andrew Morton wrote:
> > > On Sun, 19 Apr 2020 12:08:48 +0200 glider@google.com wrote:
> > >
> > > > KMSAN reported uninitialized data being written to disk when dumpin=
g
> > > > core. As a result, several kilobytes of kmalloc memory may be writt=
en to
> > > > the core file and then read by a non-privileged user.
> >
> > Ewww. That's been there for 12 years. Did something change in
> > regset_size() or regset->get()? Do you know what leaves the hole?
>
> Not lately and I would also like to hear the details; which regset it is?
> Should be reasonably easy to find - just memset() the damn thing to somet=
hing
> recognizable, do whatever triggers that KMSAN report and look at that
> resulting coredump.
>

Seems to be REGSET_XSTATE filled by xstateregs_get().
Is there a ptrace interface also using that function?

--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
