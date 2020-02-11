Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40711C35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 23:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 112A420708
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 23:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oJdxQzfC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgBKXsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 18:48:32 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33365 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgBKXsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 18:48:32 -0500
Received: by mail-wr1-f68.google.com with SMTP id u6so452wrt.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 15:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tKZVKd7LefiyWeQ0F2PuNMLHXMThkRotLuzYefuE5rc=;
        b=oJdxQzfCxBdsUpaXuR3MdBuCWDzZwSB+Jo1UxVNnw86Ms70GwIxxKD/6QYko2IyH2W
         yvF4XlGbc1jJfuDgM9BEJSme/WhY6lGm7BL7WKPG+5zBgNhGHoldlwm3eNzEI9lRBSsK
         OgVBN+dMbDU0frPADxuudeG1r4i8tcy9KbYcvpLsmYIkh/5qwYUsyIa0/8phC29yXqJE
         oFSnw9UkCLhShWSYyozwzNdXwzqMR+wKNN+NXrPnH19KTr9R4VKkCITGg257Z5JAfSwZ
         HfILBc5Jd1qt0PQ6irlIoHA1NYEhYB2zOKsGMp/Hh61sUvKBeLznK4i7be8TeXck/D7/
         QoWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tKZVKd7LefiyWeQ0F2PuNMLHXMThkRotLuzYefuE5rc=;
        b=e8Uz+i0a1yu2CzMZuRawFEZmOzWvtKp2IppT9p+A3PVCiWbaraktRGO+cysDpX68yY
         bUK6Pn3GGohpUkP8VqOLjeMiEL1ZXYxOMFtDSw56eeJs5L0mHNbC34/OiPhtALwtqL3m
         JAwX7shsMM7tsTfOsPkUB9DfMrTL0qJh8FeSfUcwYDQ9tb2ODDN9DmTWQEpzv6SBmprB
         nPpAHFUi8wsvY4wPxyQWVfVkicUTqNFIahrbdy6kP1jmmcb+lH8RI2bSEVEkoHNAjUn6
         yx1LbBn8WzKDQ+S9ZfqzqVpq3ZBBz09znqge1aIaDblDzovq7eaoYUQOx9vsnj7oEPL7
         KFKQ==
X-Gm-Message-State: APjAAAULesEckwPnPnoOLeensWeauFo8S2q3T7Hagrlb7dBck0mM7Ayx
        A4hyttanRWkGaVRNgcUdmZospQNFU4n9PxRfU9Od5A==
X-Google-Smtp-Source: APXvYqzgPjm+6Ae93vV5GdgaxMOW+fUqoGME9hOeqCh/2kKErwHSyduMJTR409IMY5lgfqSel9EpaPO2WyLJIHU6PS8=
X-Received: by 2002:adf:dd51:: with SMTP id u17mr10871983wrm.290.1581464909891;
 Tue, 11 Feb 2020 15:48:29 -0800 (PST)
MIME-Version: 1.0
References: <20200115182816.33892-1-trishalfonso@google.com> <CACT4Y+bPzRbWw-dPQkLVENPKy_DBdjrbSce0f6XE3=W7RhfhBA@mail.gmail.com>
In-Reply-To: <CACT4Y+bPzRbWw-dPQkLVENPKy_DBdjrbSce0f6XE3=W7RhfhBA@mail.gmail.com>
From:   Patricia Alfonso <trishalfonso@google.com>
Date:   Tue, 11 Feb 2020 15:48:18 -0800
Message-ID: <CAKFsvUKhwAOV9O+LWBr=-zLEJCFJvKOH-ePsXMMVJzHotqd3Ug@mail.gmail.com>
Subject: Re: [RFC PATCH] UML: add support for KASAN under x86_64
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-um@lists.infradead.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 12:44 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Wed, Jan 15, 2020 at 7:28 PM Patricia Alfonso
> <trishalfonso@google.com> wrote:
> > +config KASAN_SHADOW_OFFSET
> > +       hex
> > +       depends on KASAN
> > +       default 0x100000000000
> > +       help
> > +         This is the offset at which the ~2.25TB of shadow memory is
> > +         initialized and used by KASAN for memory debugging. The default
> > +         is 0x100000000000.
>
> What are restrictions on this value?
The only restriction is that there is enough space there to map all of
the KASAN shadow memory without conflicting with anything else.

> In user-space we use 0x7fff8000 as a base (just below 2GB) and it's
> extremely profitable wrt codegen since it fits into immediate of most
> instructions.
> We can load and add the base with a short instruction:
>     2d8c: 48 81 c2 00 80 ff 7f    add    $0x7fff8000,%rdx
> Or even add base, load shadow and check it with a single 7-byte instruction:
>      1e4: 80 b8 00 80 ff 7f 00    cmpb   $0x0,0x7fff8000(%rax)
>
I just tested with 0x7fff8000 as the KASAN_SHADOW_OFFSET and it worked
so I can make that the default if it will be more efficient.

-- 
Patricia Alfonso
