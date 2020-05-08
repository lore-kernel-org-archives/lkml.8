Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B993AC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92DBA20A8B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="RVuAkDh3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgEHIWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 04:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgEHIWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 04:22:21 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DF1C05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 01:22:21 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id g14so821629otg.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 01:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h/Rz9wFnZCM8W9Uzhf8hhBprPQEGzRH3w8O3PZ5rlcQ=;
        b=RVuAkDh3S7jS0Kb/CZiUVltsuZ4GokIbs2rpfwHHcTjvyFTQUDZxFDyWtlEN5er0iI
         hSUUXNvqXf+rOosk9LlyKd/N/W+72VACsQkMOb3G9XGrLE7pvfvdrxoPTJus06PP2VjP
         O0CFprR4EeKWaLwA805ecejwRnd2tAzMzpDAuA2v1kPEunCFfrIimJS6wEreBvKsWneG
         Uq/aMS1WFnv+6XebTIymmDx7gRdls9XMi/vXSsdl25lmSaOv0w9s1f+Im6B+/kbDviet
         7YaPDJaYuOBYL0plej7e8WqlURWnI6YmZEjQQtDPl044oTNusOKf3aG+poQNEDz5KpRY
         6yvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h/Rz9wFnZCM8W9Uzhf8hhBprPQEGzRH3w8O3PZ5rlcQ=;
        b=JOZuVqSoM52QISsVI+ntJyJwLOE9zOPsEQ7x2rrr9BNrO8Yxv8hwpKswqvqzLLDuPP
         oDyNLMUls+arOt/LZgwdJ5dol1mtYVJ/F5d4k3BLD/XYuSPgOt1hIiGlxMRWXIA+QyKG
         hEU/x8TI01KWDLmCkC9KF+rHSqOxSYRH+JbDTQ1xiiFBip5n4VWmtwceEfYFLzxMMog4
         3UaDxFkzmle7OdwFnwPLz9zt4W8xYqTS2SdbhGuZThdrLhrTxLcVSYTIxbRS5WCEEsJy
         p9vbky4wniMB5YYrRUyqj4KHHL28vLbSveXvJ4oN+fv1DAGAn8rXSldK0DatfTYeWQWG
         DgAQ==
X-Gm-Message-State: AGi0PuYGESJVjiQFjXm+XztaqtCu5m+Hb3xi4KtEd8DJJ2IoujrpQ3S4
        KDnM8KY2MnmfCnTxm3WgkW0Z3laKd+KP738joj6sSyQ227v1Vp/g
X-Google-Smtp-Source: APiQypKTZGwRNoLv/Ck2tgsg+o835lb5y9HwhlKTO6Il+1y7ujoxLKejI6aKpY95YigvPXJMUdRs/nSDSHVWCYQxNg4=
X-Received: by 2002:a05:6830:1212:: with SMTP id r18mr1276000otp.144.1588926140522;
 Fri, 08 May 2020 01:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAB4CAwdqo7=MvyG_PE+PGVfeA17AHF5i5JucgaKqqMX6mjArbQ@mail.gmail.com>
 <CAJZ5v0gX1gx1_zTZg=M+xEOqxPEaq8ZU-N3hwk7OGcGdzrdBTg@mail.gmail.com>
 <CAB4CAweZcN0SPe-a7jbthV=-ip9cCzJOM=NfP9YvtXw97ugKgQ@mail.gmail.com> <5029155.caIQduTdCh@kreacher>
In-Reply-To: <5029155.caIQduTdCh@kreacher>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Fri, 8 May 2020 16:22:09 +0800
Message-ID: <CAB4CAwfFeJjrxQvpUz3V6VMW4aHWd7iZD6Xpu6rAnaPv=ZpFeg@mail.gmail.com>
Subject: Re: System fails to exit s2idle by a keystroke on my laptop
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Seth Forshee <seth.forshee@canonical.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 2:05 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Thursday, May 7, 2020 5:38:11 AM CEST Chris Chiu wrote:
> > On Wed, May 6, 2020 at 6:19 PM Rafael J. Wysocki <rafael@kernel.org> wr=
ote:
> > >
> > > On Wed, May 6, 2020 at 11:32 AM Rafael J. Wysocki <rafael@kernel.org>=
 wrote:
> > > >
> > > >
> > > > Thanks for the report, the issue evidently is EC-related.
> > > >
> > > > > @@ -1024,7 +1024,7 @@ static bool acpi_s2idle_wake(void)
> > > > >                  * regarded as a spurious one.
> > > > >                  */
> > > > >                 if (!acpi_ec_dispatch_gpe())
> > > > > -                       return false;
> > > > > +                       return true;
> > > >
> > > > Have you tried commenting out simply removing the if () check and t=
he
> > > > following return statement?
> > >
> > > Scratch that.
> > >
> > > Instead, please try doing
> > >
> > > acpi_ec_dispatch_gpe()
> > >
> > > instead of the if () and the following return statement.
> >
> > Yes. I verified with the modification you suggested on my laptop. It's
> > working OK.
> > I can wake from a keystroke w/o problem.
> >
> > @ -1024,8 +1024,7 @@ static bool acpi_s2idle_wake(void)
> >                  * If the EC GPE status bit has not been set, the wakeu=
p is
> >                  * regarded as a spurious one.
> >                  */
> > -               if (!acpi_ec_dispatch_gpe())
> > -                       return false;
> > +               acpi_ec_dispatch_gpe();
> >
> >                 /*
> >                  * Cancel the wakeup and process all pending events in =
case
> >
>
> OK, great, thanks for the confirmation!
>
> Does the appended patch work for you then?
>
> It should be functionally equivalent to the above change if I didn't mess=
 it up.
>
>
> ---
>  drivers/acpi/ec.c       |   23 ++++++++++++++---------
>  drivers/acpi/internal.h |    1 -
>  drivers/acpi/sleep.c    |   14 ++------------
>  3 files changed, 16 insertions(+), 22 deletions(-)
>
> Index: linux-pm/drivers/acpi/sleep.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/acpi/sleep.c
> +++ linux-pm/drivers/acpi/sleep.c
> @@ -1013,21 +1013,11 @@ static bool acpi_s2idle_wake(void)
>                 if (acpi_check_wakeup_handlers())
>                         return true;
>
> -               /*
> -                * If the status bit is set for any enabled GPE other tha=
n the
> -                * EC one, the wakeup is regarded as a genuine one.
> -                */
> -               if (acpi_ec_other_gpes_active())
> +               /* Check non-EC GPE wakeups and dispatch the EC GPE. */
> +               if (acpi_ec_dispatch_gpe())
>                         return true;
>
>                 /*
> -                * If the EC GPE status bit has not been set, the wakeup =
is
> -                * regarded as a spurious one.
> -                */
> -               if (!acpi_ec_dispatch_gpe())
> -                       return false;
> -
> -               /*
>                  * Cancel the wakeup and process all pending events in ca=
se
>                  * there are any wakeup ones in there.
>                  *
> Index: linux-pm/drivers/acpi/ec.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/acpi/ec.c
> +++ linux-pm/drivers/acpi/ec.c
> @@ -1994,23 +1994,28 @@ void acpi_ec_set_gpe_wake_mask(u8 action
>                 acpi_set_gpe_wake_mask(NULL, first_ec->gpe, action);
>  }
>
> -bool acpi_ec_other_gpes_active(void)
> -{
> -       return acpi_any_gpe_status_set(first_ec ? first_ec->gpe : U32_MAX=
);
> -}
> -
>  bool acpi_ec_dispatch_gpe(void)
>  {
>         u32 ret;
>
>         if (!first_ec)
> -               return false;
> +               return acpi_any_gpe_status_set(U32_MAX);
>
> +       /*
> +        * Report wakeup if the status bit is set for any enabled GPE oth=
er
> +        * than the EC one.
> +        */
> +       if (acpi_any_gpe_status_set(first_ec->gpe))
> +               return true;
> +
> +       /*
> +        * Dispatch the EC GPE in-band, but do not report wakeup in any c=
ase
> +        * to allow the caller to process events properly after that.
> +        */
>         ret =3D acpi_dispatch_gpe(NULL, first_ec->gpe);
> -       if (ret =3D=3D ACPI_INTERRUPT_HANDLED) {
> +       if (ret =3D=3D ACPI_INTERRUPT_HANDLED)
>                 pm_pr_dbg("EC GPE dispatched\n");
> -               return true;
> -       }
> +
>         return false;
>  }
>  #endif /* CONFIG_PM_SLEEP */
> Index: linux-pm/drivers/acpi/internal.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/acpi/internal.h
> +++ linux-pm/drivers/acpi/internal.h
> @@ -202,7 +202,6 @@ void acpi_ec_remove_query_handler(struct
>
>  #ifdef CONFIG_PM_SLEEP
>  void acpi_ec_flush_work(void);
> -bool acpi_ec_other_gpes_active(void);
>  bool acpi_ec_dispatch_gpe(void);
>  #endif
>
>

=EF=BC=A8i Rafael,
    Thanks for your patch. I tried it on my laptop and it's also
working fine. Wake up by keystroke/power button/lid open all work as
expected. Thanks.

Chris
