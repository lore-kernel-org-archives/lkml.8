Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7151EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B9D720767
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIMYWZNG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgGIQGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 12:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbgGIQG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 12:06:29 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82558C08C5CE;
        Thu,  9 Jul 2020 09:06:29 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id z5so1168505pgb.6;
        Thu, 09 Jul 2020 09:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a9l+tYk/85riUuxTuUt4kuJT2J7SexvNZ2Qs7Rkx7Yo=;
        b=UIMYWZNGO9j/+zxVwaG/pEaMhgQBDOz4sVQUc96onnh3Km64D+wPEh6h63Qz4TWSP2
         XsRY+ISPSZbxWrsDHzOqVd3DwO+jn13q7r7UYZokOo3s1FiG2nwMwWwZmqd5bFtKwxQ+
         7min4joP/kLnjFue26kvH4McDc7c5GblSG7uorFlGZ1P99NsSe0V1sqwQJZB4X76mdCu
         i6xYF2pb+ijEansklByBwX3lMG37FMLYsZDj5qGeE1VcWDp4k58yGsiDHg61qtsqLdZf
         yX2vc1mZYM0hIQBguHbDQseqkSVx1Y72XZwWvUrLszIzAplDVdOmRTluucejQGA4GE03
         8YdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a9l+tYk/85riUuxTuUt4kuJT2J7SexvNZ2Qs7Rkx7Yo=;
        b=GtX/uKXrSAitsAhJEefctt6eFVW8OGo/Dqc4bwKTr6vqnw37IBlSaeso6gF4AeuEV7
         fB9kwjhBLwgH/Ym/kdzoAZjuwj5rI/HT94aFhHJ3Y0v9fqDU6hlyONVWSt4aWZcHjgLy
         sXmUSdM1Qt6NQEczZpaJmYdD8ow8BIwjdncRSWRjgiyawBG93FAXdFvplGhYhtnefRwf
         MJE0dtXAuLkJjBQ4kw2DznBr38BDBCrg17cKcGJ4XBZEaXiKHP2wHquSCgxuZL8Yk3oW
         QYbre/xONnt4SP7xWbI1ug0wvHgOc7ry+SdRXn9i9nJLLreuuc59awri9NFfuIAV6za0
         Pf/Q==
X-Gm-Message-State: AOAM533AkOdLiMd3mF504GE6mRL2L7YnOXzD0Rr6zPDUg0bLhsc1bfm7
        QVKUTJLplXbdJ4Y5VrclU7loj58sqccTrMNq3YIiWdw/
X-Google-Smtp-Source: ABdhPJw90IfU29sKTmXTJq8bdQnP0yZs7hx9knd5n/D85O14jgfWNCfjuyKFo/9tQ7e8RF9+ZB+nLooFp1k14LQoezE=
X-Received: by 2002:a62:7657:: with SMTP id r84mr56878331pfc.130.1594310789004;
 Thu, 09 Jul 2020 09:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200601091851.5491-1-vadimp@mellanox.com> <20200601091851.5491-2-vadimp@mellanox.com>
In-Reply-To: <20200601091851.5491-2-vadimp@mellanox.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 9 Jul 2020 19:06:13 +0300
Message-ID: <CAHp75VfFdf=ZxuURpVR6LRaDm+x4VQsPgR6FLrcZPhLMn8MOpw@mail.gmail.com>
Subject: Re: [PATCH platform-next v1 1/8] platform/mellanox: mlxreg-hotplug:
 Use capability register for attribute creation
To:     Vadim Pasternak <vadimp@mellanox.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 12:19 PM Vadim Pasternak <vadimp@mellanox.com> wrote:
>
> Create the 'sysfs' attributes according to configuration provided
> through the capability register, which purpose is to indicate the
> actual number of the components within the particular group.
> Such components could be, for example the FAN or power supply units.
> The motivation is to avoid adding a new code in the future in order to
> distinct between the systems types supported different number of the

supported -> supporting a

> components like power supplies, FANs, ASICs, line cards.

...

>                 /* Go over all units within the item. */
> -               for (j = 0; j < item->count; j++, data++, id++) {
> +               for (j = 0, k = 0; j < item->count; j++, data++) {
> +                       /* Skip if bit in mask is not set. */
> +                       if (!(item->mask & BIT(j)))
> +                               continue;

Instead of splitted comments and this code, perhaps

/* Go over all unmasked units within item */
for_each_set_bit(j, &item->mask, item->count) {
...
}

It might require a mask defined as unsigned long, though. Or temporary
variables.

>                 }
> +               num_attrs += k;
>         }

-- 
With Best Regards,
Andy Shevchenko
