Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AA1C433F8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DF192075A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595859683;
	bh=8o1xUW78CsCXrHqPga8+TZJZSaBnLgA/nz6kryWiE20=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kC/Hb7yg9JPZYH5jSxsHNJ7yhdcO0/aBoVJ97FP6FuLuacx1obX8eXtuLg7AuwqUb
	 Z9efzKGJw5s1wnpuOYtlcQWjVvbNiZFNsZWLd8+uOBP//klcFWXW1XCj4Jpy64mZpA
	 JH1uhMSVC1u4Gs7hLZFh5iKFEHKPO6IAhk9Gpe88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731715AbgG0OVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:21:21 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36144 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731681AbgG0OVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:21:16 -0400
Received: by mail-ot1-f65.google.com with SMTP id l27so5266976oti.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 07:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B9VkZvYaPk8hX/PpnZk1Tslvy3DaFGYN1APB+k9gEkI=;
        b=ia71QoBOf2Yxz62vM48XL8uTlZTqgApiXw4Ybd123Y1CCVg0cRc9mra3eHks9q0TLo
         ZCzWNWc1pAsN0pvZrW2aUeXE+TF0gsm5/TL+dX0Dc6q53MA20jGpusdbpp2+lSeXoif0
         ksCi5joKRz6fnGHXGRh4UohFwTzxt1vzaoojOiQV6wsOUopWazODJfepE8gPICauSfKw
         nqiOlLq3PInuHgzxGs0jmp9HrhzU56O3hWGap2TLoXWrch9i7xkw7We7z6I4y1SORCIE
         daqTl12IAmaS1JYydDBSsVmnC7gZX5of7Z524mj+nCKv54Rahl0ZLRfXD1Y7ZuB0y2Z9
         EuNQ==
X-Gm-Message-State: AOAM530o289PmfznQk23B84PvIGWiWEPGjTzTYocUvvxhjg5WfbHj8Q4
        tMYhCrx5VSk3/AnbAqDD72HZZoKUn0c6bRhlkIk=
X-Google-Smtp-Source: ABdhPJzOpEicgz1kXmzLNmdZl/uWYUTogdTp6XYFaJsmPsLQaFO6kx2wKVR8yXH24Xr2YY+rawUwhkAB61UTgxRUAgU=
X-Received: by 2002:a9d:306:: with SMTP id 6mr10689700otv.167.1595859676010;
 Mon, 27 Jul 2020 07:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200724180523.1393383-1-saravanak@google.com>
In-Reply-To: <20200724180523.1393383-1-saravanak@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Jul 2020 16:21:05 +0200
Message-ID: <CAJZ5v0izVrJeQNroeNS8xu66c8LskHSiCJRQvVvrhWSZV8tL_g@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Change delimiter in devlink device's name
 to "--"
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 8:05 PM Saravana Kannan <saravanak@google.com> wrote:
>
> The devlink device name is of the form "supplier:consumer". But ":" is
> fairly common in device names and makes it visually hard to distinguish
> supplier and consumer. So, replace it with "--" to make it easier.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Well, this makes sense in principle, but I wonder how much risk of
breaking anything in user space there is?

> ---
>  Documentation/ABI/testing/sysfs-class-devlink | 2 +-
>  drivers/base/core.c                           | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-class-devlink b/Documentation/ABI/testing/sysfs-class-devlink
> index 3a24973abb83..64791b65c9a3 100644
> --- a/Documentation/ABI/testing/sysfs-class-devlink
> +++ b/Documentation/ABI/testing/sysfs-class-devlink
> @@ -4,7 +4,7 @@ Contact:        Saravana Kannan <saravanak@google.com>
>  Description:
>                 Provide a place in sysfs for the device link objects in the
>                 kernel at any given time.  The name of a device link directory,
> -               denoted as ... above, is of the form <supplier>:<consumer>
> +               denoted as ... above, is of the form <supplier>--<consumer>
>                 where <supplier> is the supplier device name and <consumer> is
>                 the consumer device name.
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index b6e8b0bb76e4..4d05868d9356 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -623,7 +623,7 @@ struct device_link *device_link_add(struct device *consumer,
>
>         link->link_dev.class = &devlink_class;
>         device_set_pm_not_required(&link->link_dev);
> -       dev_set_name(&link->link_dev, "%s:%s",
> +       dev_set_name(&link->link_dev, "%s--%s",
>                      dev_name(supplier), dev_name(consumer));
>         if (device_register(&link->link_dev)) {
>                 put_device(consumer);
> --
> 2.28.0.rc0.142.g3c755180ce-goog
>
