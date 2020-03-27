Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C25CC2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 23:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A042071B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 23:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XurJei6Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgC0X4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 19:56:11 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34870 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgC0X4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 19:56:11 -0400
Received: by mail-ot1-f65.google.com with SMTP id v2so7112256oto.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 16:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K0NZbCLQ3EXESvGxt7BooZUrPODG0bjvoacB9E61EEM=;
        b=XurJei6Y0zK73hOuGlwQ5mXHRF0bCiHRG6oKmYdCjlws+X/5KoM9fDGdLuEEL5nngn
         /T94i7uCchViIvOMy3pUWqFsU6MyiWxQMJqkkYxOfcAa6Pez0iNRZP9a8UNG4KrQUQSc
         wWxmaPyr8eDYV5niFJGTjV+W6mUa9Szj3OZ9KDoHLRDo5P2OI9GY5yUuc1rBTGX5SRZp
         8dD++OkavrllEVjwGwV/NXLnWhmnfKlTxJ7By2Rl+Zyctfpdz/YCI8beVj474am+z4Ar
         GRWq2yI/rKZKnRVyz2tYFsCC4AKmpZnAioCE+t3sHDINPDVgLWtObc0qhWhJHliaB1cy
         4Jkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K0NZbCLQ3EXESvGxt7BooZUrPODG0bjvoacB9E61EEM=;
        b=h4EUPrEjxnGxYXAGldI4ckaWN6EhljaITXVTyaKligeHY1sS9/MTF/SFfurDufrT7Y
         13eh0pSZ2I3a/ROXR+v5tQw6lNRByTrw+IXBko4hnFA8Ousns4FXx3mvzKQf03SDq5mL
         b9ieiu6YMDTc5c8LETFnF10j0WGgW07HbGihxqDPR+B0XGdGToUK21WHIsxFCQlIzjdN
         rpCTpAYwJWJMPVHh8EiJO3qK+sId3q3KHZKipWtUny4OLz05WKxbO8xxgBzUoINTMxfs
         w0mbhj+URzr7ARK2wKoz9xaBCnIs3Lp+HX54813Jhi1orwOYEHMK2SBBtJuOgC02nRK8
         6Fzg==
X-Gm-Message-State: ANhLgQ3kYIP9dl1uXPPKszTJOSQ7A+uo07AzzbZYgpPJhIYlK4by3HHg
        H8jspN4v/Ccxw/o7PCFDnkynDv1fx5ZX6zHHhWuX/A==
X-Google-Smtp-Source: ADFU+vt2lzCYLjMmDYQ7QI1GbWZ1pzJp/+PeDaT91MG7KWT2Q1Bu9ZCCfiT78aA9hpd2w88mP12gYjj3WbX9G70dP+M=
X-Received: by 2002:a9d:42f:: with SMTP id 44mr959944otc.236.1585353370394;
 Fri, 27 Mar 2020 16:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200327170132.17275-1-grant.likely@arm.com> <CAGETcx8CJqMQaHBj1r5MhNBTw7Smz4BRHPkB0kCUCJPSmW6KwA@mail.gmail.com>
 <2885b440-77a5-f2be-7524-d5fba2b0c08a@arm.com>
In-Reply-To: <2885b440-77a5-f2be-7524-d5fba2b0c08a@arm.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 27 Mar 2020 16:55:34 -0700
Message-ID: <CAGETcx_0=W6P_Zf-6fvDfncXUrPvt31bf6de-RWwHaXtwJizmQ@mail.gmail.com>
Subject: Re: [PATCH] Add documentation on meaning of -EPROBE_DEFER
To:     Grant Likely <grant.likely@arm.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, nd@arm.com,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 4:25 PM Grant Likely <grant.likely@arm.com> wrote:
>
>
>
> On 27/03/2020 18:10, Saravana Kannan wrote:
> > On Fri, Mar 27, 2020 at 10:01 AM Grant Likely <grant.likely@arm.com> wrote:
> >>
> >> Add a bit of documentation on what it means when a driver .probe() hook
> >> returns the -EPROBE_DEFER error code, including the limitation that
> >> -EPROBE_DEFER should be returned as early as possible, before the driver
> >> starts to register child devices.
> >>
> >> Also: minor markup fixes in the same file
> >>
> >> Signed-off-by: Grant Likely <grant.likely@arm.com>
> >> Cc: Jonathan Corbet <corbet@lwn.net>
> >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> Cc: Saravana Kannan <saravanak@google.com>
> >> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >> ---
> >>   .../driver-api/driver-model/driver.rst        | 32 ++++++++++++++++---
> >>   1 file changed, 27 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/Documentation/driver-api/driver-model/driver.rst b/Documentation/driver-api/driver-model/driver.rst
> >> index baa6a85c8287..63057d9bc8a6 100644
> >> --- a/Documentation/driver-api/driver-model/driver.rst
> >> +++ b/Documentation/driver-api/driver-model/driver.rst
> >> @@ -4,7 +4,6 @@ Device Drivers
> >>
> >>   See the kerneldoc for the struct device_driver.
> >>
> >> -
> >>   Allocation
> >>   ~~~~~~~~~~
> >>
> >> @@ -167,9 +166,26 @@ the driver to that device.
> >>
> >>   A driver's probe() may return a negative errno value to indicate that
> >>   the driver did not bind to this device, in which case it should have
> >> -released all resources it allocated::
> >> +released all resources it allocated.
> >> +
> >> +Optionally, probe() may return -EPROBE_DEFER if the driver depends on
> >> +resources that are not yet available (e.g., supplied by a driver that
> >> +hasn't initialized yet).  The driver core will put the device onto the
> >> +deferred probe list and will try to call it again later. If a driver
> >> +must defer, it should return -EPROBE_DEFER as early as possible to
> >> +reduce the amount of time spent on setup work that will need to be
> >> +unwound and reexecuted at a later time.
> >> +
> >> +.. warning::
> >> +      -EPROBE_DEFER must not be returned if probe() has already created
> >> +      child devices, even if those child devices are removed again
> >> +      in a cleanup path. If -EPROBE_DEFER is returned after a child
> >> +      device has been registered, it may result in an infinite loop of
> >> +      .probe() calls to the same driver.
> >
> > The infinite loop is a current implementation behavior. Not an
> > intentional choice. So, maybe we can say the behavior is undefined
> > instead?
>
> If you feel strongly about it, but I don't have any problem with
> documenting it as the current implementation behaviour, and then
> changing the text if that ever changes.

Assuming Greg is okay with this doc update, I'm kinda leaning towards
"undefined" because if documented as "infinite loop" people might be
hesitant towards removing that behavior. But I'll let Greg make the
final call. Not going to NACK for this point.

-Saravana
