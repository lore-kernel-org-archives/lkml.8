Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39581C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0653E2080C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cHfeDd+4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgCCKzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 05:55:20 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36875 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgCCKzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:55:19 -0500
Received: by mail-oi1-f193.google.com with SMTP id 5so2569147oiy.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 02:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5jOtb1BhiQGowh0BlpaOUSt5dD3Y3nnseudePnuupsw=;
        b=cHfeDd+442pgG4b/emVO6vf5Em46uyQ+GDRrlICxDJVRD47vglceX82KFDS0Vm8SD9
         oRtBchajRwoRkQB/bedPnFlMocEdFuRUAu90+bbyeU2BB7f8g3tVAzvYqyCL5oFYKZMa
         clf0GPpMGd1Jp2wMFfMqs8v7ZJSas7tD1FJRHLekgKI2Fvx/uo588hi7d2bkQ/2oQnfb
         u9MQj+B+JAUB2+3Jnh5hNxq9VdaQOR2TLuBNomFqMdrbqwJqb/GSpfw1KnGd4Da64tT6
         qQXAW3TQ8xChY33J+pD8+m0/A/FTAwV8F9twKvMkKpiPBeAWKhfEScUw9PPF6vvWW6il
         0Csw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5jOtb1BhiQGowh0BlpaOUSt5dD3Y3nnseudePnuupsw=;
        b=YGJfGgV3bn0IyPtQ4KxOyP2NB/ZS6DZuQoVX/aFxIbjk6vK5o8rsfeEVl2JAPX9ZOO
         9xCNaSu1LtAteDKH2nkTPnRhp9u9cHa6sTXcvAwesoGONwSldNAjypuiStm5NO3kDuVq
         VYT8br/xN73TW/KS/Rcgus5Lqxm48MXwB4vCuSCwywwbG4yLYGhife4FY+AaYmsYFYtT
         dVJmWvUs1BskeX0LegJTHu0EVz3vh4xjkLUQG+oHQEXBSjQkTGOdtqhNQ7QMrzat4vtr
         K3NJ5H1J+Tg2i0jeo75XXhZEMONyPUJ6WOJos8zFuU+DqviGv8hVtMqvUTS88XsPBb1P
         XybQ==
X-Gm-Message-State: ANhLgQ0x3jDv7R9tMH+pAfkdXgQyXDaKWBwSYqYGpidQXoyw32vOtTgj
        CxlUPIoQfMxf8JyfdT5pncIeNa0F3IO2l+7a4vc8IQ==
X-Google-Smtp-Source: ADFU+vt/0Pkh4xRMSjFYvG0yXIdUv50c98auM9c2ECjtGeoOY5Pb0fIzNq1xj7NtvCkYQoGZ0HC3bO8/F0nNkjluzTA=
X-Received: by 2002:aca:d954:: with SMTP id q81mr2031587oig.157.1583232918470;
 Tue, 03 Mar 2020 02:55:18 -0800 (PST)
MIME-Version: 1.0
References: <20200302195352.226103-1-jannh@google.com> <202003021434.713F5559@keescook>
In-Reply-To: <202003021434.713F5559@keescook>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 3 Mar 2020 11:54:52 +0100
Message-ID: <CAG48ez12FYHoHY8PB2r7H_JtJ8NatEuRB8Ej0y9pfpp9EnnnsA@mail.gmail.com>
Subject: Re: [PATCH] lib/refcount: Document interaction with PID_MAX_LIMIT
To:     Kees Cook <keescook@chromium.org>
Cc:     Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 2, 2020 at 11:37 PM Kees Cook <keescook@chromium.org> wrote:
> On Mon, Mar 02, 2020 at 08:53:52PM +0100, Jann Horn wrote:
> > Document the circumstances under which refcount_t's saturation mechanism
> > works deterministically.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
>
> Acked-by: Kees Cook <keescook@chromium.org>
>
> With one note below...
>
> > ---
> >  include/linux/refcount.h | 19 ++++++++++++++-----
> >  1 file changed, 14 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/refcount.h b/include/linux/refcount.h
> > index 0ac50cf62d062..cf14db393d89d 100644
> > --- a/include/linux/refcount.h
> > +++ b/include/linux/refcount.h
> > @@ -38,11 +38,20 @@
> >   * atomic operations, then the count will continue to edge closer to 0. If it
> >   * reaches a value of 1 before /any/ of the threads reset it to the saturated
> >   * value, then a concurrent refcount_dec_and_test() may erroneously free the
> > - * underlying object. Given the precise timing details involved with the
> > - * round-robin scheduling of each thread manipulating the refcount and the need
> > - * to hit the race multiple times in succession, there doesn't appear to be a
> > - * practical avenue of attack even if using refcount_add() operations with
> > - * larger increments.
> > + * underlying object.
> > + * Linux limits the maximum number of tasks to PID_MAX_LIMIT, which is currently
> > + * 0x400000 (and can't easily be raised in the future beyond FUTEX_TID_MASK).
>
> Maybe just to clarify and make readers not have to go search the source:
>
>         "... beyond FUTEX_TID_MASK, which is UAPI defined as 0x3fffffff)."

The value of that thing has changed three times in git history, and
there is a comment in threads.h that refers to it as being 0x1fffffff;
so I'm a bit hesitant to copy that around further.

> and is it worth showing the math on this, just to have it clearly
> stated?

Hm, I suppose... I'll send a v2.

> -Kees
>
> > + * With the current PID limit, if no batched refcounting operations are used and
> > + * the attacker can't repeatedly trigger kernel oopses in the middle of refcount
> > + * operations, this makes it impossible for a saturated refcount to leave the
> > + * saturation range, even if it is possible for multiple uses of the same
> > + * refcount to nest in the context of a single task.
> > + * If hundreds of references are added/removed with a single refcounting
> > + * operation, it may potentially be possible to leave the saturation range; but
> > + * given the precise timing details involved with the round-robin scheduling of
> > + * each thread manipulating the refcount and the need to hit the race multiple
> > + * times in succession, there doesn't appear to be a practical avenue of attack
> > + * even if using refcount_add() operations with larger increments.
