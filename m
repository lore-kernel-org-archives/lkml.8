Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CC9C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 14:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B285D20836
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 14:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="kHo6MP4x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbgEFOn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 10:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbgEFOn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 10:43:28 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5752C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 07:43:27 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id g16so2269093eds.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 07:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ef/MKYQ5o7wpBd5E71PdTHAAiX3bVS8q0Det6zmMp4Q=;
        b=kHo6MP4xV9gm4/l+y1zeMl6BZmIh4tyBgNceSvc1sj4c0mBeUd+sfY5iEdBNCMVBgb
         NZFCLkjHOvl5CPqyBnzmT0ZUKNDWR3vnF7n6cNymuecK4Njt6bDFLuOBQWW5HBfeaLaW
         ZucfMCs91UG2RjL2FPRatRYJVHM/aydwKKoFyW+9sZytQn/8NMFa0VH8enDH5vpye3p3
         2GLUyWbFaQhgsxGtgpqsVdJRMCm8f6BbqHMShngToRtlL48x5zA2YBxyUKU1eJcwJaMD
         kHpUZNXKvuyOh2DML/71BOy1W5/n8qXvsevImRFjk7m4yo163Us3B2kTv4k2gN2vm98V
         nibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ef/MKYQ5o7wpBd5E71PdTHAAiX3bVS8q0Det6zmMp4Q=;
        b=gK5Hv/GG8KWxkskyD+lCDAp/7iYmC9U5lZh1rfY9HH5Xl+EY0wJ2A3lfGNO/4rEckg
         aNpccf0Kw98beQTgpju9jQLjI2iOb+wMjk/v43qr4665dhcRFksWN1wuRvc8Q4DHPUmj
         gmvo6oiI7TD25MiWUbjstxJalV6I12QMCq1yCs2ep8kYv1ESHcgoKR22Bg2fBs2Ptn27
         NPMY7YMj4yxQPwfnT8mbDIqguH/dvZhKy+b0LeYeZnm5U71DMjIAEjybQXKFp5XjgQut
         USmExZvv0JHDumr7yJJEsIGnS5TCUQNNqJRuOZExATLegWzlA76ObKMyi0n15PDG15T5
         EVvg==
X-Gm-Message-State: AGi0PuavabAZ9gdvcb2whceIpBgufTHwdduVkJWXiFQiLVp90S74ldqg
        p02f4XiJJ0vbTMzYrseX9wKLscE0sC7TIBoHX9pKRw==
X-Google-Smtp-Source: APiQypL1/pQhGhyT2fS1Xsi31EQjwmxdDLv/iuU0yAlT0rFz+35SEDcoonWukDS/42xAWz6GHbKUXAKV9/7RdIOywsI=
X-Received: by 2002:a05:6402:356:: with SMTP id r22mr7716142edw.3.1588776206549;
 Wed, 06 May 2020 07:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200505154510.93506-1-pasha.tatashin@soleen.com>
 <20200505154510.93506-3-pasha.tatashin@soleen.com> <202005051444.14B6686@keescook>
In-Reply-To: <202005051444.14B6686@keescook>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 6 May 2020 10:42:50 -0400
Message-ID: <CA+CK2bA1_5e8HCwfMJSsCuN7qjRKYTNY2Q-UbJGGVPAEfZVgaw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] pstore/platform: pass max_reason to kmesg dump
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, anton@enomsg.org,
        ccross@android.com, Tony Luck <tony.luck@intel.com>,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 5:59 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, May 05, 2020 at 11:45:07AM -0400, Pavel Tatashin wrote:
> > Add a new field to pstore_info that passes information about kmesg dump
> > maximum reason.
> >
> > This allows a finer control of what kmesg dumps are stored on pstore
> > device.
> >
> > Those clients that do not explicitly set this field (keep it equal to 0),
> > get the default behavior: dump only Oops and Panics, and dump everything
> > if printk.always_kmsg_dump is provided.
> >
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  fs/pstore/platform.c   | 4 +++-
> >  include/linux/pstore.h | 3 +++
> >  2 files changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
> > index 408277ee3cdb..75bf8a43f92a 100644
> > --- a/fs/pstore/platform.c
> > +++ b/fs/pstore/platform.c
> > @@ -602,8 +602,10 @@ int pstore_register(struct pstore_info *psi)
> >       if (pstore_is_mounted())
> >               pstore_get_records(0);
> >
> > -     if (psi->flags & PSTORE_FLAGS_DMESG)
> > +     if (psi->flags & PSTORE_FLAGS_DMESG) {
> > +             pstore_dumper.max_reason = psinfo->max_reason;
> >               pstore_register_kmsg();
> > +     }
>
> I haven't finished reading the whole series carefully, but I think
> something we can do here to make things a bit more user-friendly is to
> do the KMSG_DUMP_UNDEF value here to get us the "all" instead of INT_MAX:
>
>         if (psi->flags & PSTORE_FLAGS_DMESG) {
>                 pstore_dumper.max_reason = psinfo->max_reason;
>                 if (pstore_dumper.max_reason == KMSG_DUMP_UNDEF)
>                         pstore_dumper.max_reason = KMSG_DUMP_MAX;
>                 pstore_register_kmsg();
>         }
>
> That way setting max_reason to 0 without setting dump_oops at all will
> get "all". I think it'll need some tweaks to the next patch.

Hm, but if we change it this way, it will change the behavior for
other backends. With the current version of this patchset,
when psinfo->max_reason is left undefined (0, KMSG_DUMP_UNDEF) -> the
existing behaviour is honored, which means: printk chooses the kmesg
dump level, and users can set dump for all reasons via printk
always_kmsg_dump. This is what efi-pstore, erst, and nvram_64 are
currently doing, and I am not sure we should change that.
However, with the proposed change if the backend specifically sets
max_reason: printk will use it and ignore always_kmsg_dump.

Thank you,
Pasha
