Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FE0C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 03:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D57DF20737
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 03:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Gx+sD/aG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgEEDNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 23:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726550AbgEEDNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 23:13:16 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128C6C061A0F
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 20:13:16 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id r16so590362edw.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 20:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hb3vOvaxQWUZVlEGzKRze7rfk+t0axuGNcRjVwkD3j0=;
        b=Gx+sD/aGknodR9LrZrAWAT5LsnNyPtk5ZMzq0bszMwNSMv+s9UkgohYx9BjAmr8/e+
         whkKmBLxnTytujtwYo08LjvEoq4dvTxJ4xduLkgsJWLsb+Rth8vc2zkfNCZLy6b3rfWb
         F2uHPfW2EcjiEkX1cTCnS9NIlKRlN90ZeoM0czBBEXYGWT1tB7XaI5QHOEjdXj73G6zO
         kHD64fdJ1YAfqvQL7CoGzAurC113ptBE+0CXHJPYilJtQM5d7Cb6zlg31OqPIkkBJnYG
         TtuZBjRL00+hPwMN87EkdXFT0QmNDwy93aJJjB9yDN7ah3EimaS0T17YdZ60DZDy/nS/
         vZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hb3vOvaxQWUZVlEGzKRze7rfk+t0axuGNcRjVwkD3j0=;
        b=tq2lTQzeWlvlnw+tRdfzZpe88DNqOWKv7oXl0OOyLCZvXqKo3/xgSHDxrxEfP5OPEY
         i2y3aZnjV9owYAOI53oT57p6+JlqQzHhOBrUutryYWdOFG124lD4g19r9bsLD8y1fmSC
         wwvcm1N36zUs/KruHlxmlKKNLqUyGLYG5jzvOxmZPSU7fJjrY+Xr75EgRQuOc3th4M+z
         SP/Boo19F6MVVzuvZYRUL1D9JQY5g0fno5C50vWwEM2+BNsUwfEVUSX5gPXUZeGcG/yE
         bzVH/Go/DJq82ftC4LEeOWCI4rroy9Rgs61pNHTUNOg5LBuFU2z1YiYI2wyqqPPUSlmT
         jyHA==
X-Gm-Message-State: AGi0PuawPNt7ipx9YctZ66KiKugaQ43W6rpmRrYi7LHRaXH3Mh/2Nlfm
        1TAJWTQnkHCbZGZx7imwxla9qIpBtsVqTFOBW/z9Xg==
X-Google-Smtp-Source: APiQypJZyCmhrc3iXu9oYM4b5u25pu1XHxWrGEIt6rB3xS8T/NsYMx1S8LVZl21yWSkocDZoxxo/TP9EiRq7FTAj9cM=
X-Received: by 2002:a05:6402:14c1:: with SMTP id f1mr859825edx.221.1588648394738;
 Mon, 04 May 2020 20:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200502143555.543636-1-pasha.tatashin@soleen.com>
 <20200502143555.543636-2-pasha.tatashin@soleen.com> <20200505010219.GA2282345@jagdpanzerIV.localdomain>
 <CA+CK2bASiWe=w07gsc-_fFZxPY0SSECSYh6femUCA8yugEpuRg@mail.gmail.com>
In-Reply-To: <CA+CK2bASiWe=w07gsc-_fFZxPY0SSECSYh6femUCA8yugEpuRg@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 4 May 2020 23:12:38 -0400
Message-ID: <CA+CK2bAZAAzAK7G3bJ5dOHR__5+a8LgWPVBzwM+TnbHdVKDUgQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] printk: honor the max_reason field in kmsg_dumper
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>, anton@enomsg.org,
        ccross@android.com, Tony Luck <tony.luck@intel.com>,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 4, 2020 at 10:52 PM Pavel Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> > > @@ -3157,12 +3162,9 @@ void kmsg_dump(enum kmsg_dump_reason reason)
> > >       struct kmsg_dumper *dumper;
> > >       unsigned long flags;
> > >
> > > -     if ((reason > KMSG_DUMP_OOPS) && !always_kmsg_dump)
> > > -             return;
> > > -
> > >       rcu_read_lock();
> > >       list_for_each_entry_rcu(dumper, &dump_list, list) {
> > > -             if (dumper->max_reason && reason > dumper->max_reason)
> > > +             if (reason > dumper->max_reason)
> > >                       continue;
> >
> > Why always_kmsg_dump check moved from the dumper loop entry point to the
> > dumper registration code? What if the user change always_ksmsg_dump
> > dynamically via sysfs?
>
> Hi Sergey,
>
> I changed it to make code cleaner:  for such basic operation there are
> too many conditions if we will keep it inside the kmsg_dump().
> However, if being able to set always_kmsg_dump dynamically during
> runtime is deemed important, I can change it back to be checked in
> kmsg_dump.

If you agree that we do not have to modify this variable dynamically,
I will also change the permission here:
module_param_named(always_kmsg_dump, always_kmsg_dump, bool, S_IRUGO | S_IWUSR);

>
> Thank you,
> Pasha
>
> >
> >         -ss
