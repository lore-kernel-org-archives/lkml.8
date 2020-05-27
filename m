Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A191C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1552A20890
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590568510;
	bh=CNOV5d3bFjZmpLvpLSvda6AV9kWlRZtO0uGNW0qN8NU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bO7JJuhgqaEBe5zdotxN6DqbSVebRTD24MwFSKH9WrbHCIsP4axbZIDCjKseeGdl9
	 Ysdl3+gQ2FONUr4cM1HsCvkMPXRSN1rECe713wVsrJxcQo21OcvL3fxFsGy5z9/7YO
	 eoVdY4+txv0wF8HkZJHUCrP/+eHDFq7qT3sD4XHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388105AbgE0IfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:35:05 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44702 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388076AbgE0IfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:35:04 -0400
Received: by mail-oi1-f196.google.com with SMTP id y85so20988454oie.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 01:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tk1lu4BEgdRUvPTWYBSmmuJf3yyP6DSf1FkLtUc/jDQ=;
        b=LeYwXKPybS11trYxTxdwm6fhW2tRHf8VW8sbPqbjeYfovN4KVQQhpm0fyRfwn2S8TF
         nN2ZmWA8E0eO8fb3YanT2u2hBzDGPyriHZaxtkSlAPzHCyX5x8mp9X+pCyD7SezcTv8h
         7bQHM7uiw9EWv7zi23r2sgNAX8wUIwbL7q9/VCxh+3KU2JsvpCr6gE0RIMr0QYh6Jjy2
         /PwjGQHl82eJYDQWfWckmtH1XE4U/PjTHOGdjIlfVqXbC1i2nWqOIqd2Ly3BUXKR6Ygm
         IpPRTN6qNAfOtxm02l/FdvIdas9cRD+8lmy3H6kj9c31dNH7FNi/qymm/kwLQhgzG3mv
         CZHg==
X-Gm-Message-State: AOAM532D/0TAvAGPh1hAM0eeqMmhWb0rwBkxJxJLBGXpNQUo5I81cKZs
        7BFsrzfXiZaZAk6mz3OGSJFqZK3TvYvL54sJ8EaeXg==
X-Google-Smtp-Source: ABdhPJwpYbXsDA5sT9SEk9mfIZe3oDQAm3pTRUUw1YVBbPqFkQp8KMGumNGBfkLNn/tmuYQFj5LgoEAETcUg1KXndpk=
X-Received: by 2002:a05:6808:486:: with SMTP id z6mr2032157oid.103.1590568503342;
 Wed, 27 May 2020 01:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200524153041.2361-1-gregkh@linuxfoundation.org>
 <20200524153041.2361-2-gregkh@linuxfoundation.org> <CAKdAkRShA2sAMH12H_zpCm=9XJn_yEcnAaaZhLgvhaUMxC-EMw@mail.gmail.com>
 <20200526055806.GA2576013@kroah.com> <CAJZ5v0ii+hMh5DCuYuuO9auFHD0GLxmOVR1FoDmCwrNEnh9gMw@mail.gmail.com>
 <20200527075048.GD3284396@kuha.fi.intel.com>
In-Reply-To: <20200527075048.GD3284396@kuha.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 27 May 2020 10:34:51 +0200
Message-ID: <CAJZ5v0h0Xjovm-eVyiOG+j7kNEPxB=PZF4rLVEgwUW+H+61DFg@mail.gmail.com>
Subject: Re: [PATCH 2/2] kobject: send KOBJ_REMOVE uevent when the object is
 removed from sysfs
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 9:50 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Tue, May 26, 2020 at 10:26:23AM +0200, Rafael J. Wysocki wrote:
> > On Tue, May 26, 2020 at 7:58 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, May 25, 2020 at 03:49:01PM -0700, Dmitry Torokhov wrote:
> > > > On Sun, May 24, 2020 at 8:34 AM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > It is possible for a KOBJ_REMOVE uevent to be sent to userspace way
> > > > > after the files are actually gone from sysfs, due to how reference
> > > > > counting for kobjects work.  This should not be a problem, but it would
> > > > > be good to properly send the information when things are going away, not
> > > > > at some later point in time in the future.
> > > > >
> > > > > Before this move, if a kobject's parent was torn down before the child,
> > > >
> > > > ^^^^ And this is the root of the problem and what has to be fixed.
> > >
> > > I fixed that in patch one of this series.  Turns out the user of the
> > > kobject was not even expecting that to happen.
> > >
> > > > > when the call to kobject_uevent() happened, the parent walk to try to
> > > > > reconstruct the full path of the kobject could be a total mess and cause
> > > > > crashes.  It's not good to try to tear down a kobject tree from top
> > > > > down, but let's at least try to not to crash if a user does so.
> > > >
> > > > One can try, but if we keep proper reference counting then kobject
> > > > core should take care of actually releasing objects in the right
> > > > order. I do not think you should keep this patch, and instead see if
> > > > we can push call to kobject_put(kobj->parent) into kobject_cleanup().
> > >
> > > I tried that, but there was a _lot_ of underflow errors reported, so
> > > there's something else happening.  Or my attempt was incorrect :)
> >
> > So it looks like there is something in there that's been overlooked so far.
> >
> > I'll try to look at the Guenter's traces and figure out what went
> > wrong after the Heikki's patch.
>
> At least one problem with that patch was that I was releasing the
> parent reference unconditionally.

That actually may be sufficient to explain all of the problems introduced by it.
