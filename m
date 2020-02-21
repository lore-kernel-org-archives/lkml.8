Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8309C35657
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC102067D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zg7t7aQs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbgBUQBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:01:43 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38360 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728822AbgBUQBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:01:43 -0500
Received: by mail-ot1-f65.google.com with SMTP id z9so2429330oth.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 08:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wLXxnQp7HIaEPOKqosq0pF27kK5rqBwu9jtY7ZzaZNg=;
        b=Zg7t7aQs1mHUnhU9aTiekAaV+Bp3+M0P+YZeKti3TISeAY9CQdUrdOFmjsqepztxOx
         48Dv1/D7WO6nWGRwPKlWwvIYThN07XeuH0zDZUdCQwJ+myRzcg5LnEG7ZVdKxGD26lTK
         KVCopA4uqWUz+vUYIyv/B2l6y8PvqMHJ0cFB6loBx4vuTfe/wfetHc0eAkd6jfENDH+p
         TXLTe/XjYDfrfxzrF+PgaQOaoeW0mhvhTp2yRu3bcltFFeuIsb7D8biIrvg7SoZduJja
         kDZBbYU7R7e3gNPkSuTe0potbG8q/lX5OTUkpIedz5/7ibHouBzgPG4LLKgPybONZvUE
         9pkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wLXxnQp7HIaEPOKqosq0pF27kK5rqBwu9jtY7ZzaZNg=;
        b=GrQU48LAfAWgVXazRGCPk0hf+sCSAGWpjjktVGDIbwffeEc7Hy44AY4uL0fB6D3zvn
         Znv9WSRI8PHU2fLALJJLijWub1fmjPUVwmJV6DXIj4URLnJEI6iWqKlP2P4s+6T/cJa8
         NvgKkD9UF+NO207acDjIjiTjMM1nS7nUe0qUMuiBCK0KEquldMJmAormsdfNPuoGFJr3
         FpLjFH16Um4l1c9RGV9WoR5SGSdF567zaNpUGDaWaJg2tpcoSt++e4EUfX6OS3eUxnol
         xVgl/035dxRLPlXDEHhYXHy4jaMSVojrfk2sN+OWz2ZDOUIcGXcxTm5f1zN2o0X23NU+
         Le8A==
X-Gm-Message-State: APjAAAXSF4mFnlCZCk7I5oNHOWKCJWNGWsBBKPYMMdg83w3zN2ky4Usd
        G+jPX5TuwkuJErHM4nBhNelGbGT21AXmKQ0kjLxafg==
X-Google-Smtp-Source: APXvYqzaURoo4lqFhOzDSfM/yflLXGfwIE9mGC1jzOlYcjOmVHK4/ZIENpO+WI50lxlAFBPJA1F5KORZeiw2+L9fEio=
X-Received: by 2002:a9d:3b09:: with SMTP id z9mr28988967otb.195.1582300888825;
 Fri, 21 Feb 2020 08:01:28 -0800 (PST)
MIME-Version: 1.0
References: <20200221080510.197337-1-saravanak@google.com> <20200221080510.197337-2-saravanak@google.com>
 <20200221092540.GA71325@kroah.com> <CAGETcx_yQZtU4O2KgMxVt-hSJCBtNsOpyWsSXc+OZcjjJ91M3g@mail.gmail.com>
 <20200221103233.GA101069@kroah.com>
In-Reply-To: <20200221103233.GA101069@kroah.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 21 Feb 2020 08:00:00 -0800
Message-ID: <CAGETcx-YhSBf2r8wAjqkupnrsYKZHkvCWyMvo01gvdPTzQa7zA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] driver core: Call sync_state() even if supplier
 has no consumers
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 2:32 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Feb 21, 2020 at 01:48:49AM -0800, Saravana Kannan wrote:
> > On Fri, Feb 21, 2020 at 1:25 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Fri, Feb 21, 2020 at 12:05:08AM -0800, Saravana Kannan wrote:
> > > > The initial patch that added sync_state() support didn't handle the case
> > > > where a supplier has no consumers. This was because when a device is
> > > > successfully bound with a driver, only its suppliers were checked to see
> > > > if they are eligible to get a sync_state(). This is not sufficient for
> > > > devices that have no consumers but still need to do device state clean
> > > > up. So fix this.
> > > >
> > > > Fixes: fc5a251d0fd7ca90 (driver core: Add sync_state driver/bus callback)
> > >
> > > Should be:
> > > Fixes: fc5a251d0fd7 ("driver core: Add sync_state driver/bus callback")
> >
> > Sorry, late night sleepy patches are never good!
> > Btw I thought the sha should be only 12 characters but then saw
> > another instance where you used 16 chars. What's the right one?
>
> I used 16 chars?  12 should be all that is needed.
>
> > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > >
> > > So this needs to go to 5.5 also, right?
> >
> > Did you mean 5.4? Yes.
>
> fc5a251d0fd7 is only in 5.5, not 5.4 from what I can see, right?

Ah, right!


-Saravana
