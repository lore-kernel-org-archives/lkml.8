Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804CEC2D0ED
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 18:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB112071B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 18:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AAOuHu6m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgC0SLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 14:11:21 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36133 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbgC0SLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 14:11:20 -0400
Received: by mail-ot1-f66.google.com with SMTP id l23so10718794otf.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 11:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AS7mvCEIh3pfi107as5vEH/QpwGnWQ91Bq23h2zKukA=;
        b=AAOuHu6msnb0522EGCRpK5xZtBD58kCNF61e9Hh//c38fWvY0k+cdPmoykV4JIxRPF
         ql4vdYzydpzORHqlk4VlQTcwQuJ8Kk/83bg19CB+gkem47HMZMzklPdg2aMSVbGCRlFB
         3fc5RNFdO3bHVh18AOj67uALOTnbnV8NjLr7on5LJpRbDz6+cMAT28nIZYNVMCbyP8ri
         VP+Vxi8PEN3wxPULWQSY2ioic0SD8MqCzWs/M6FKR15/ftOgU2YyMDdpofWYCZ1dWS/H
         YfUHBPrj0f6haCuibFeFc+lga6BjN5idf9AE9BRy/dOjSkc68DEvAIFFBQ+wZsVpXqvv
         mIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AS7mvCEIh3pfi107as5vEH/QpwGnWQ91Bq23h2zKukA=;
        b=qZTGF1zX3aBy4iGEg3z6IjZjd4k/AKk2TOwK7IXZFZwSyJnHI8mHB9CurxQ0bGM11o
         Y2/1kw6QDRUsPB9Mizfl3kuq5BPJnmg3uLeK/l0xt4nuQwZEIYBs12EiCgjGIhqj5lpi
         lhdoK/FR3FYiKS5NkANH9GkkFw7sf6cra9VzlKyfsl+HhRJp/Itg7GX+PM2YU6zBUiS6
         lIfiyo1CN/R792F8Pb0RiUkrfbZgq69+qKfMkCQFRSvwLOQuYbb9k4fIvy7jaPIWKbaU
         j4GYfPXffWwItIakFdfax0C+NvKtS5N/f8QcdDhZhSqTBag1h3C3j6gSjt8AdKuBLpE0
         neXA==
X-Gm-Message-State: ANhLgQ3d1/DnycvQt839pz9y17mnh720OPWHr1rm55zReaed1WKbJkp6
        TyI4pxi42dbMWMNTHQrmkfCTAGv35HctptjKiaPnUg==
X-Google-Smtp-Source: ADFU+vvOv8c9JQm5kJNhUDWGfgsraRLePI5O5SCd/PtS/FVJ+qQm9TfMsznMckxhjSugQh0d2JMqHv913HiGhIhwIlA=
X-Received: by 2002:a05:6830:1ac1:: with SMTP id r1mr11748856otc.139.1585332679671;
 Fri, 27 Mar 2020 11:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200327170132.17275-1-grant.likely@arm.com>
In-Reply-To: <20200327170132.17275-1-grant.likely@arm.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 27 Mar 2020 11:10:43 -0700
Message-ID: <CAGETcx8CJqMQaHBj1r5MhNBTw7Smz4BRHPkB0kCUCJPSmW6KwA@mail.gmail.com>
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

On Fri, Mar 27, 2020 at 10:01 AM Grant Likely <grant.likely@arm.com> wrote:
>
> Add a bit of documentation on what it means when a driver .probe() hook
> returns the -EPROBE_DEFER error code, including the limitation that
> -EPROBE_DEFER should be returned as early as possible, before the driver
> starts to register child devices.
>
> Also: minor markup fixes in the same file
>
> Signed-off-by: Grant Likely <grant.likely@arm.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  .../driver-api/driver-model/driver.rst        | 32 ++++++++++++++++---
>  1 file changed, 27 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/driver-api/driver-model/driver.rst b/Documentation/driver-api/driver-model/driver.rst
> index baa6a85c8287..63057d9bc8a6 100644
> --- a/Documentation/driver-api/driver-model/driver.rst
> +++ b/Documentation/driver-api/driver-model/driver.rst
> @@ -4,7 +4,6 @@ Device Drivers
>
>  See the kerneldoc for the struct device_driver.
>
> -
>  Allocation
>  ~~~~~~~~~~
>
> @@ -167,9 +166,26 @@ the driver to that device.
>
>  A driver's probe() may return a negative errno value to indicate that
>  the driver did not bind to this device, in which case it should have
> -released all resources it allocated::
> +released all resources it allocated.
> +
> +Optionally, probe() may return -EPROBE_DEFER if the driver depends on
> +resources that are not yet available (e.g., supplied by a driver that
> +hasn't initialized yet).  The driver core will put the device onto the
> +deferred probe list and will try to call it again later. If a driver
> +must defer, it should return -EPROBE_DEFER as early as possible to
> +reduce the amount of time spent on setup work that will need to be
> +unwound and reexecuted at a later time.
> +
> +.. warning::
> +      -EPROBE_DEFER must not be returned if probe() has already created
> +      child devices, even if those child devices are removed again
> +      in a cleanup path. If -EPROBE_DEFER is returned after a child
> +      device has been registered, it may result in an infinite loop of
> +      .probe() calls to the same driver.

The infinite loop is a current implementation behavior. Not an
intentional choice. So, maybe we can say the behavior is undefined
instead?

-Saravana
