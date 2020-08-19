Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6652C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 03:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 896EC2063A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 03:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597808001;
	bh=d10G88ZMr5h5r4fkew2dGd31zA2OYOLhGnuJs6vtStg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=l78McH0mmGS9+Ym8FZHLhNGxcEnpMSMM8zYkNpRk71obHT7sVMKqcKkAyZJ1GVQqA
	 YAnLl3O3JAHtoDZkaE0IBnpmhGQgw7/OwsIm3jGAE3speSVtUL9adI2AAQjPCd/R6o
	 yjj7LZpK9DH4c80EF7+j5ro+ivH6YBuqxPhnMiAU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgHSDdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 23:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgHSDdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 23:33:19 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A516EC061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 20:33:18 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v9so23793769ljk.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 20:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ao/sHNcaqVhQQMi80lMo4XF+FLR+4Bj6pKAQTXaD+hQ=;
        b=gdBMzTnBa8XDbCmYcOweMIya67GSpSnewFl7/JVdiG3ga35lMroSKbu5zxClc6CsSK
         mC0NDYzTvugO0jZSRW+hASL5tVSnWq5b9kvVZJqOclf0htIfy1fqdDwLG7+hPVSyXtdg
         c9QdlMxtf3DkoyUME4EIoPQccF0B+9reRSqgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ao/sHNcaqVhQQMi80lMo4XF+FLR+4Bj6pKAQTXaD+hQ=;
        b=rol2ad5keOXqGRjcRGHHvPXebyyCFnMuay0CpshZlQ2IYFSvmUqbDy1bXTmucMLgqx
         qewkO/VyJ4Z5CxtehmM+2iKiaVWK05V4IK5XUgtOq9LeFMIhvfmpnL5W2XcFkGphBFRe
         wRZ7S61d7/vks+5i5zq0CkDVAQabv6vdkQYidG2V7UJl9N8M3/x7VvOL8qEBOaqoBsa3
         ScCW3qrBZ2Qv1qy5NVnPWG8VChLeN7OIqW22VrkK3K+ks2hNZOxwwAwZKkme6l+3QE8L
         vZsy13hkO3U+leR6iPhvkPoA5PpiNQllIlfb5wfsvQ29jYBvk6NsFah6bO3yyCkwNKUd
         dnEA==
X-Gm-Message-State: AOAM533V6ZsEpXlm287Tw1TzsFK72Uy3qG6oqCOY3ecLQqgNFtthi5dP
        7l/9a1s297jzZtDYqQfYc6iRfidI7f4O3A==
X-Google-Smtp-Source: ABdhPJygNjsMYU+/gt2+gzmAGYuRCeP4+cHGBMa8brJg5DkvTA8v4+FemLX2C0ccdh0XWt3eO55qcQ==
X-Received: by 2002:a2e:b80b:: with SMTP id u11mr11707382ljo.286.1597807996437;
        Tue, 18 Aug 2020 20:33:16 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id x205sm6907898lfa.96.2020.08.18.20.33.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 20:33:15 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id v12so23767546ljc.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 20:33:15 -0700 (PDT)
X-Received: by 2002:a2e:7615:: with SMTP id r21mr10463304ljc.371.1597807994822;
 Tue, 18 Aug 2020 20:33:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200818234307.3382306-1-nivedita@alum.mit.edu>
 <CAHk-=wik-oXnUpfZ6Hw37uLykc-_P0Apyn2XuX-odh-3Nzop8w@mail.gmail.com> <20200819030442.GA3396810@rani.riverdale.lan>
In-Reply-To: <20200819030442.GA3396810@rani.riverdale.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 18 Aug 2020 20:32:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiJLvqS1_O+yAQSZr-Lj49HdJyLpt3J_nW=otHLfEN4RA@mail.gmail.com>
Message-ID: <CAHk-=wiJLvqS1_O+yAQSZr-Lj49HdJyLpt3J_nW=otHLfEN4RA@mail.gmail.com>
Subject: Re: [PATCH] lib/string.c: Disable tree-loop-distribute-patterns
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 8:04 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Tue, Aug 18, 2020 at 05:44:03PM -0700, Linus Torvalds wrote:
> > Using -fno-tree-loop-distribute-patterns seems to really be a bit too
> > incestuous with internal compiler knowledge.
>
> Fair enough -- you ok with just the -ffreestanding? That's what protects
> the memset in arch/x86/boot/compressed/string.c.

Yeah, I think -ffreestanding makes sense. It may not be optimal, but
it doesn't smell wrong to me.

> > Looking at the implementation of "strscpy()" in the same file, and
> > then comparing that to the ludicrously simplisting "memcpy()", I
> > really get the feeling that that memcpy() is not worth having.
>
> I don't think anything actually uses the generic memcpy, and I think
> only c6x uses the generic memset.

I do think maybe we should just remove the generic memcpy and memset
and say "hey people, you really do need to implement your own".

Even if you don't have this "recognize and recurse" issue, you end up
having other issues like just tracing etc. Yeah, we've hopefully
turned everything like that off, but considering that no major
architecture uses this, I wonder how many small details we've missed
with ftrace recursion etc?

> Might be worth optimizing strnlen etc with the word-at-a-time thing though.

Yeah, possibly. Except the kernel almost never uses strnlen for
anything bigger. At least I haven't seen it very much in the profiles.

The "strncpy_from_user()" stuff shows up like a sore thumb on some
loads (lots and lots of strings from user space for pathnames and
execve), but the kernel itself tends to seldom deal a lot with any
longer strings.  Stuff like device names etc, I  guess, but any time I
see string handling in profiles, it tends to be in user space (GNU
make spends all of its time in string handling, it sometimes seems).

Of course, that may be just me looking at very particular profiles, so
maybe I've just not seen the loads where the kernel strnlen matters.

memcpy and memset? Those matter. A lot.

            Linus
