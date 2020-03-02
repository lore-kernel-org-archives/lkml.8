Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957F0C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 661C120842
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FHqugw6N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbgCBS2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:28:18 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34856 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgCBS2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 13:28:17 -0500
Received: by mail-wm1-f68.google.com with SMTP id m3so133195wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 10:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DVVfeNHnLShVmNI+xo5NmA/CGXvIx1qRNWkzr1ndFCk=;
        b=FHqugw6NwLRZm5V4+dSVNR4BiQEdtOjVfEaDWjKYTBxVezrgu0n7cY2wAZOYxQbjc2
         9LZJvyDGtZUmy407Lg0G7/vdxZ3t5lGc/HAW3BzX01VYMSE+/y/5eNUHRsC+DUFK3FQB
         q7fnPvss9SToolOIafdH66a2StOhVFEBc/8ydld89rK1fC+E3tZdCLmj/jInPEb7hzuh
         CMJSP0HQ/UGUWIbdejqZ0t6a7OC7rUcLb8HCQQuQTx2I6iuTgn2jiL0FFf1qx+DRRp59
         SJxC3qGcToJ2EyglhlVyy9y64xq58xaFoPnfjN6P5/FqOr2TkG0laSaPh/2bi9IrHs5I
         m82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DVVfeNHnLShVmNI+xo5NmA/CGXvIx1qRNWkzr1ndFCk=;
        b=q2FZf7vdMcfLEefwSgsXaeLVBHNRKmGUFpOC+r7mKUPautbrWvjCVNuONe1ORsZCby
         W3llviGvaXl0a2yPhzTkEzbVaEJo2XuCtlKPQ3gRwK4DK/GSO4DAsWmrm5QTcr3VUxiM
         ENMQkh5klFfwz850vAgWJmZfYT/nI5v5hDEr6gzcm8pdpB3ueMtzzyrWaFIf6Evu0/yO
         nciRDMmnFcRLPi6QPzeAKL3sP+TLb9HsZyEWMA3tfqyKzBo6HloTO1Qsyuw+uQDcL/Ku
         FoD20erK1PeNzrINw6m43e62LCY6FVaOEQsjQXKakoyx+ee2BYOWdSQEUsTdEvkMtvGR
         jWbw==
X-Gm-Message-State: ANhLgQ362Vx5x0arQK0JBfhOnc+utx86F5MYoElFOcZgnqcjtrAjJyVe
        iPMFMsDKNx9gEbVMJz6UABpeWbjYADhSmlrTFnreog==
X-Google-Smtp-Source: ADFU+vtPQGvrqx3+71+klizKiHy1WgLnxvxSsIbkpUsLQ/5J3j0JDtAVV5bqIdO+NSaFCVMRb3H9+kQUCa4EGai01ew=
X-Received: by 2002:a1c:7907:: with SMTP id l7mr309755wme.37.1583173694833;
 Mon, 02 Mar 2020 10:28:14 -0800 (PST)
MIME-Version: 1.0
References: <20200302130430.201037-1-glider@google.com> <20200302130430.201037-2-glider@google.com>
 <20200302173852.GB109022@kroah.com>
In-Reply-To: <20200302173852.GB109022@kroah.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 2 Mar 2020 19:28:03 +0100
Message-ID: <CAG_fn=WvA44J5fN=3i0WoOa-TK=1CqSrdCtR_ceZX0AzUM5s5A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] binder: do not initialize locals passed to copy_from_user()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Todd Kjos <tkjos@google.com>, Kees Cook <keescook@chromium.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 2, 2020 at 6:38 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Mar 02, 2020 at 02:04:29PM +0100, glider@google.com wrote:
> > Certain copy_from_user() invocations in binder.c are known to
> > unconditionally initialize locals before their first use, like e.g. in
> > the following case:
> >
> >       struct binder_transaction_data tr;
> >       if (copy_from_user(&tr, ptr, sizeof(tr)))
> >               return -EFAULT;
> >
> > In such cases enabling CONFIG_INIT_STACK_ALL leads to insertion of
> > redundant locals initialization that the compiler fails to remove.
> > To work around this problem till Clang can deal with it, we apply
> > __no_initialize to local Binder structures.
>
> I would like to see actual benchmark numbers showing this is
> needed/useful otherwise it's going to just be random people adding this
> marking to random places with no real reason.
This were lib[hw]binder_benchmarks.
I will update patch description with benchmark data.
> thanks,
>
> greg k-h



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
