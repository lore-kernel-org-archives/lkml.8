Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99FEC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 08:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70A8B20748
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 08:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ln5la+m0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730988AbgAPIYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 03:24:33 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39528 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgAPIYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 03:24:32 -0500
Received: by mail-qt1-f193.google.com with SMTP id e5so18203786qtm.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 00:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tlgKvEyVkOCk+r5Hpx71WwyKD+4RnBChT7TjkISGEd8=;
        b=ln5la+m0459rW4oIReHBrAulHCeyb5EIDcaKL2zj3XDUElfWMPalHGBaSxYkG6YBrT
         lXc+VyHfETNRZ8fmbMrDNZZ/K7gJZqlC4EWx1KNZJD8wfYGXis15mHJ8Wt+1EDJfPB4C
         kSl6bgIW7GdfEsgwZ5JBJnqQxW1/KrN3VE7Zeqhobzg8gCwV+5INFkELSHMLRRkcJ4vL
         DHrmRrug5lSp617kLsBNUKMm3NargYY0e4kyLF1TKUwCXZO6UTYv8cHCNon1qxQf5yax
         1r7oGHh037Q9QOCSMyXGijGKDr4VkABEiv9PFCyIsZKma9m0/okJ/MX8tFIcbwDPblGp
         NRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tlgKvEyVkOCk+r5Hpx71WwyKD+4RnBChT7TjkISGEd8=;
        b=Rk6Lla/kPmJdEdbrLkyX1wUdk8GUf5qKeT+EvEwADDyPSqETsmvIN33TeT6QwOVxw4
         qrATrH1i+fmfpgKtfN8hoidfl1vj8+3SrO/KxCXUPW/ZQ8EykwUjn6Nn5qm10Db6Dk0t
         4ZOT426tQtQCU927kI5qSut9U+pi0rveGX8cbt2yhnlTxT3jQmJmvNo2ziafBV+5oOYl
         yMEBsN9Vadd6MOOUyU8XhKiW+9SclgElV1KQ9L8gaewHy6ks2uUTwe6S7rRweFqluDVw
         am6ayO8Y8YdyVbnGVntO9MRbYoj25ikkLOE3a22ugTZiDitHxrJ3hQyG+LRomDVfr6KI
         GLDw==
X-Gm-Message-State: APjAAAULNzT6zDvxvIsPJFvtIS6rlo3czj7JZaDOEoldkw2TygIs/8NX
        SgHfdVNaPjOOafOOrggue0kU1t6oFLSoTjZVnfndUA==
X-Google-Smtp-Source: APXvYqwXJiw0lfRsbwrvY4+AdPWdOcFdfOxGx4J6PeDwx1aPQxv/90sPodirMRKFVlbbGsDt/ifQFQRm5bbBJumGq4Y=
X-Received: by 2002:aed:3b6e:: with SMTP id q43mr1220224qte.57.1579163071242;
 Thu, 16 Jan 2020 00:24:31 -0800 (PST)
MIME-Version: 1.0
References: <20200115182816.33892-1-trishalfonso@google.com>
 <dce24e66d89940c8998ccc2916e57877ccc9f6ae.camel@sipsolutions.net> <CAKFsvU+sUdGC9TXK6vkg5ZM9=f7ePe7+rh29DO+kHDzFXacx2w@mail.gmail.com>
In-Reply-To: <CAKFsvU+sUdGC9TXK6vkg5ZM9=f7ePe7+rh29DO+kHDzFXacx2w@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 16 Jan 2020 09:24:20 +0100
Message-ID: <CACT4Y+ZDRtFrm5jfD+a9X=frGM=WKpoeJJZ6MRhZsATbG8aDTA@mail.gmail.com>
Subject: Re: [RFC PATCH] UML: add support for KASAN under x86_64
To:     Patricia Alfonso <trishalfonso@google.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 11:56 PM Patricia Alfonso
<trishalfonso@google.com> wrote:
> > > +++ b/kernel/Makefile
> > > @@ -32,6 +32,12 @@ KCOV_INSTRUMENT_kcov.o := n
> > >  KASAN_SANITIZE_kcov.o := n
> > >  CFLAGS_kcov.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
> > >
> > > +ifdef CONFIG_UML
> > > +# Do not istrument kasan on panic because it can be called before KASAN
> >
> > typo there - 'instrument'
> >
>
> Thanks for catching that!

Hi Patricia,

Very cool indeed! And will be a kunit killer feature!

I can't parse this sentence (even with fixed), what is "kasan on panic"?
Did you want to say "Do not instrument panic because it can be called
before KASAN is initialized"?
Or  "Do not KASAN-instrument panic because it can be called before
KASAN is initialized"? Though, "KASAN-instrument" looks somewhat
redundant in this context.
