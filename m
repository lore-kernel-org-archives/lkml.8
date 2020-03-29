Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051B5C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 16:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B0E2073B
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 16:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="X4go7Hq+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgC2Quu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 12:50:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44905 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbgC2Quu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 12:50:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id m17so18037711wrw.11
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 09:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NXS8hN0Ve2GkwCQhpf4okBwifAzH4fzuO6CwUdYBArg=;
        b=X4go7Hq+6ks2H2G3MTGEZEmH85hX5rDqylpU/Z+5KnTtEs5ARvuAhkIY9mAIq8kUSn
         /s+4JhbXn45KMJ0jJVgUeVFCoMcum6vdSi93QFuFKR8M8JZbc5auEIRR5AoNGCK7bkM5
         aq9uo/QPkOG2Bgux1/HH56qVgdfNXW8WF6RcpNvMGkvqJH4k0foA0tPga/QwyCCWx32S
         RnWZ++MWc2qQlP/PhJg8BD8xsWUZS060qDtWsLe8Q2+u7lERsu7061ykeKiXddLkeCsm
         bnb4nOGtM1Ua61NrENTEGR+lzy/n9yRZ3c+gycGKn9aeeH6ACAPQ/YmW1YxM4C3U2Q3X
         jwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NXS8hN0Ve2GkwCQhpf4okBwifAzH4fzuO6CwUdYBArg=;
        b=C2J77m4yiy946aFoBuMJNC3RWDZOXiTaeNTvBj5AB7sw+zw4QNsvNkVvkQxvX3i5zD
         eVfsOCJSRNZe5CHUIk1W9Q2GcqJ1aPj2cKUOnF2OtveKez978XMKxj8piVCEHRVp4e+X
         d+W8IKxNp+e2NwMf05Zc95PBPaqdNiSte7LeyL+gslb8m3dE0Y4H23jbhh7ROCaTWbPc
         yJwTKbb5oubaOCpcVrLw8SBI7jMTGtsN6zvbikivmbxxJYA4hOc1HvaUsko82AghB6Mf
         1X818Vy4sS77JT49jrNhkdfH67rF9AX1JorgVYR9Xr3ODuUzQgosalwY/7T14Ymwy5cj
         W+Rg==
X-Gm-Message-State: ANhLgQ2DCMuoXlB58uEK5EU9Fm33EXgM0lm0+N6mu9ZVc73m0Qm7vokM
        EdeOEXtBp4zuMcXXUMQYVDXOoQRrmgiAR7WjpDqknw==
X-Google-Smtp-Source: ADFU+vvOIOGoZWhNAmJaXDM3CAcJv0HIT2X2zgUbCbLGNyidT5N6a5PvSWfpvTt+QFuqlOid6iB4CYoHWRxH39/wOKQ=
X-Received: by 2002:adf:f2c7:: with SMTP id d7mr10261609wrp.184.1585500646640;
 Sun, 29 Mar 2020 09:50:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200323183620.GD23230@ZenIV.linux.org.uk> <20200323183819.250124-1-viro@ZenIV.linux.org.uk>
 <20200328104857.GA93574@gmail.com> <20200328115936.GA23230@ZenIV.linux.org.uk>
 <20200329092602.GB93574@gmail.com>
In-Reply-To: <20200329092602.GB93574@gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Sun, 29 Mar 2020 09:50:34 -0700
Message-ID: <CALCETrX=nXN14fqu-yEMGwwN-vdSz=-0C3gcOMucmxrCUpevdA@mail.gmail.com>
Subject: Re: [RFC][PATCH 01/22] x86 user stack frame reads: switch to explicit __get_user()
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 29, 2020 at 2:26 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> > > but the __get_user() API doesn't carry the 'unsafe' tag yet.
> > >
> > > Should we add an __unsafe_get_user() alias to it perhaps, and use it
> > > in all code that adds it, like the chunk above? Or rename it to
> > > __unsafe_get_user() outright? No change to the logic, but it would be
> > > more obvious what code has inherited old __get_user() uses and which
> > > code uses __unsafe_get_user() intentionally.
> > >
> > > Even after your series there's 700 uses of __get_user(), so it would
> > > make sense to make a distinction in name at least and tag all unsafe
> > > APIs with an 'unsafe_' prefix.
> >
> > "unsafe" != "lacks access_ok", it's "done under user_access_begin".
>
> Well, I thought the principle was that we'd mark generic APIs that had
> *either* a missing access_ok() check or a missing
> user_access_begin()/end() wrapping marked unsafe_*(), right?
>
> __get_user() has __uaccess_begin()/end() on the inside, but doesn't have
> the access_ok() check, so those calls are 'unsafe' with regard to not
> being safe to untrusted (ptr,size) ranges.
>
> I agree that all of these topics need equal attention:
>
>  - leaking of cleared SMAP state (CLAC), which results in a silent
>    failure.
>
>  - running user accesses without STAC, which results in a crash.
>
>  - not doing an access_ok() check on untrusted (pointer,size) ranges,
>    which results in a silent failure as well.

My incliniation is to just get rid of the __get_user()-style APIs.
There shouldn't be any __get_user() calls that can't be directly
replaced by get_user(), and a single integer comparison is not that
expensive.  On SMAP systems, the speedup of __get_user vs get_user is
negligible.

(It's possible that some arch code somewhere uses __get_user as a way
to say "access user or kernel memory -- I know what I'm doing".  This
is crap if it exists.  It better not happen in generic code because of
sane architectures like s390x.)
