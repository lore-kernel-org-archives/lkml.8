Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EE4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 16:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC14520738
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 16:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gfEr3AVd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbgEUQvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 12:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728546AbgEUQva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 12:51:30 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EB7C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 09:51:30 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id z26so1565099oog.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 09:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4TWqLPA7vnjXncrWIAlaDszw6D9cKlcexzFx3uOvNJE=;
        b=gfEr3AVdKaTUGbmZijKRZy/Yx4AvY2AIFsCIN36BzNrL1vFSIr1tNMfHg+nTKVBelb
         1R36PWzHSum96rVmPlG5yCk+fAuoXD9uMETKByI6MJwm1Cna3NYofawm7bxgJEqIKgG5
         72KS7x/s91L2MKz51RHuYJGjA1H5p+HXSQe3lzcYzEYA6LgnJRK7DIDap3pO/gs2vqKI
         eDYN7+Oi8qZHqCXwRbQ018BdkKpXvnD6AR+T8iW0QmO/rUQJPeqJqSCYix/azPL4wPIS
         a6OkgYhqz8TYEvyHhWWeZ+V+zeRHYQR0KvTSrmEuqYE1TLKSv8zOGcP5Pv3jkSRqM9UL
         I2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4TWqLPA7vnjXncrWIAlaDszw6D9cKlcexzFx3uOvNJE=;
        b=KZsm2w0TwZB9n0hDHUqSyoN0//L+J4G6KeHE0zD5Pr4++m3XiFxmBAv+Q4rMqJIkpe
         027EJWEUmHQxgK7xJXga9SWU24tcs6gG6HJwSJCjd3AO9g35LZJCGd85gGrbcoCYrfCC
         SpGSYIqzqB7AQ5aPtaBMluxjXnVEGiI7m3p7JS9vC7JMCR6VHPp7L69HI4YLZRW5j8oy
         q0YiVexFfMopgQkrxD8xlossXVckufBbw5DeGJfdTp3D7XWa6hGQPDXd/dpGIBXX6NZ7
         AsZ95SsG1ujCKWnXGs72Ft5Wa2E0pLEZzjhuyf7pYljeqEvF/Eum3YOux7YgyokLYt/p
         Gk7w==
X-Gm-Message-State: AOAM5318ZIr2jtNf8mXZzwC7JwY+P2FLGnPdvbSrnC6UIT/wTTU2uNa7
        QqwBkcR+8BPc85MyKxEGMu9tAuhEg3x1xKDEgRJVtA==
X-Google-Smtp-Source: ABdhPJyTugXW74yznuuYG6HXU+D1WOEEiIiUn0Z3FeHplCQIWufBDUGoA5f10O9B+cFQFnle+y11C974OrCUjKUbIPo=
X-Received: by 2002:a4a:9624:: with SMTP id q33mr5637894ooi.53.1590079889547;
 Thu, 21 May 2020 09:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200520034824.79049-1-saravanak@google.com> <20200521094247.GA2861894@kroah.com>
In-Reply-To: <20200521094247.GA2861894@kroah.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 21 May 2020 09:50:53 -0700
Message-ID: <CAGETcx_5u3xXgkCBr8FixBX_VjbkT+dQNpLdRrM6JA6+9F9vTQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] driver core: Add device link related sysfs files
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 2:42 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, May 19, 2020 at 08:48:20PM -0700, Saravana Kannan wrote:
> > With fw_devlink and with sync_state() callback features, there's a lot
> > of device/device link related information that's not available in sysfs.
> >
> > Exposing these details to user space can be very useful in understanding
> > suspend/resume issues, runtime pm issues, probing issues, figuring out
> > the modules that'd be needed for first stage init, etc. In fact, an
> > earlier verion of this series was very helpful in debugging and
> > validating the recent memory leak fix[1].
> >
> > This series combines combines a bunch of patches I've sent before.
> >
> > I'm aware that I haven't added documentation for patch 1/2. I'm waiting
> > on review to make sure the file location, name and values don't change
> > before I add the documentation.
>
> You mean patch 2/4, right?

Yes.

> > This series is based on driver-core-next and [1] cherry-picked on top of
> > it.
>
> I've taken patch 1 now, as it was easy to review :)
>
> I'll wait for the next series with the documentation update before going
> further.

:( I was hoping I'll get an "okay" on where I expose the files, their
names and content, etc before I document it. I'll add documentation
now.

-Saravana
