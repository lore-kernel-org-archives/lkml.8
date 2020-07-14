Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6801C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 10:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84B9A22203
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 10:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgsUSIpO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgGNKnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 06:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgGNKnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 06:43:19 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC02C061755;
        Tue, 14 Jul 2020 03:43:19 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id b9so6861956plx.6;
        Tue, 14 Jul 2020 03:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KJ/q+ccg5V+GxYEgNQmLl43Y6zP1ehsDX4DLYv49Pis=;
        b=XgsUSIpOKs9dGoG4Aetrxb1n9tAvJFdoUpuvMpD42InYlIm1HzpfKPUiMVGTYGuE0p
         vRQD+yMK4PeyRkKRx8gd0+zar4qPpyWUlpBZmX/FFNMW6II6zRfUhLRik+5yA9rMQnmF
         ZmwTDnFXfYo3GpxIAMBu/JulddFsv19gSLJ6L470MvCT5XMgHtiiJLy21AglLHEfL2x+
         D/82dLSOxkQHUdoNSZhdZ1OY3fzeA8bNefRK6rZm1F8arjuugM33vbTIgujH0z8MrkdD
         z0br2AdVWrRZIUMazR8V+3Dsfl2+Q+lVrm0TV2KWpB00U7rgMHsh6rOhB2FjOajTyD/S
         APtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KJ/q+ccg5V+GxYEgNQmLl43Y6zP1ehsDX4DLYv49Pis=;
        b=D8YuLk3mzFsTWo6sdfwxWOzzgRluUz4Zl6/oXBwaOkunbg8+InX2hfeuFV8YJ7HjHq
         PXMvtXU+BuujwReklUw4EC2EljCBYHH1wD0YfHxH3ZT/nn2ddkvoNYH7zJKt/VuJlSqq
         Ms+AIfjOPl3Djykp6z2kL03G35s3F6av0w3ihQXXe1qOhNirdgMQ7i0vsYAbC/nHIIW3
         /5uQmX9cBDXW9O2A+VyS515rZ/kZFvOgVP1y2pzn9fg2xvC+bHjhGmzjzqJtXUnkToTL
         aMMLtJg9QTwZEV4zBoHuUJP1f+ZZFFpNNEU/+PpDHc8c0ifaR+b35kjnITjm5MFiX16t
         Gf+w==
X-Gm-Message-State: AOAM5329wHVL/fj0htreS7rN+0yV1pwuj0ad9seSGK/8aSQ3llPU+hgv
        F9LOmc+H9Q7ImO7gkXqLq4TbB8vkmC9qozZ7b/UIVY17
X-Google-Smtp-Source: ABdhPJwE8FEhDNL+Ica1Irn5TRh1MnZrhWjsGjtlollROeI9dA2kOITIov0B1LrVh8JDoHxwndGqErDfscqrG1PDQf4=
X-Received: by 2002:a17:902:7288:: with SMTP id d8mr3495271pll.18.1594723398938;
 Tue, 14 Jul 2020 03:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200714081510.6070-1-hdegoede@redhat.com> <CAHp75Vd6uGNw5m3-Tc1tkABLT_Wi7CtW2yo8+B5TpYV4U8XE9A@mail.gmail.com>
 <CAHp75Ve9HF4WVkiUA77s9LsN6d8oaFPRgjLi86FnDSHgmVvTNA@mail.gmail.com> <af1a7c41-071f-4c26-9a9a-7c6ffb5dde88@redhat.com>
In-Reply-To: <af1a7c41-071f-4c26-9a9a-7c6ffb5dde88@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 Jul 2020 13:43:01 +0300
Message-ID: <CAHp75Vc=ZAH4YeDF+o-89hJZCz2r2csRDcYjBVA30nzbyikFMg@mail.gmail.com>
Subject: Re: [PATCH 5.8 regression fix] platform/x86: thinkpad_acpi: Revert:
 Use strndup_user() in dispatch_proc_write()
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Thinkpad-acpi devel ML <ibm-acpi-devel@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 12:33 PM Hans de Goede <hdegoede@redhat.com> wrote:
> On 7/14/20 10:27 AM, Andy Shevchenko wrote:
> > On Tue, Jul 14, 2020 at 11:21 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> >> On Tue, Jul 14, 2020 at 11:15 AM Hans de Goede <hdegoede@redhat.com> wrote:
> >>>
> >>> Commit 35d13c7a0512 ("platform/x86: thinkpad_acpi: Use strndup_user()
> >>> in dispatch_proc_write()") cleaned up dispatch_proc_write() by replacing
> >>> the code to copy the passed in data from userspae with strndup_user().
> >>
> >> user space
>
> Ack, do you want me to send a v2, or can you fix this up after applying.
>
> >>> But strndup_user() expects a 0 terminated input buffer and the buffer
> >>> passed to dispatch_proc_write() is NOT 0 terminated.
> >
> > Second though, perhaps it's a simple wrong count parameter?
> > strndup_user(..., min(count, PAGE_SIZE)) or so would work?
>
> I honestly have not looked at a better fix and given that you've just come
> up with 2 suggestions which may or may not work, combined with
> where we are in the 5.8 cycle I believe it would be best to just
> play it safe and go with the revert for 5.8.
>
> If you then take a second attempt at cleaning this up for 5.9 and
> send it to me, I can test it for you.

I guess there is no need to revert. I have looked at the documentation
and see that all of the procfs parameters are normal strings, but you
are right they are not NULL terminated per se. So, the problematic
place is the size of data we retrieve from user space.

I have sent a patch.


-- 
With Best Regards,
Andy Shevchenko
