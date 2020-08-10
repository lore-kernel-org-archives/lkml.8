Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E00C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5DFC20729
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tUC05H8f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgHJMIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 08:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbgHJMIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 08:08:06 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CE7C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 05:08:06 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id v15so4638219pgh.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 05:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r/v3HPD/WrvvMXnw2eHuBnmRHFKNLYVuv02hfUOAA4o=;
        b=tUC05H8fFqKxeyCHN5LZ4cPCHD359odey85Kxa5I/4uZZUpgAZWlMFEdThf8AmyTBH
         UwzyFWM5sKHYQYbzzgQpAxu7okKYl53kqFcJOuOCYvsqo/SVm9fHmsWwnUwSd9Seuc/J
         MYOgvtOc0VQMbJU/y76QbU1//qmRh2W9JnrPPbJpLhkgBcFtaR6OirdXs045mWNmQF99
         LPXtOUW/OY+JI/BC2oXKu9yLagFEzxv7v1tnFZXzZAdo6a7vsFFRoeBx1op1VcLFj0lP
         lv6ADd72S4Do1TKyWGjdiZaVrWkguuH8G2Ld4WPGeKjgFfoz6KGTpRoiKMMLTT+j7j47
         Hldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r/v3HPD/WrvvMXnw2eHuBnmRHFKNLYVuv02hfUOAA4o=;
        b=K7iqafSv+GU78/Pkfv6LEYuWaywacNCPdYhEfzVnn4ZWjRE3osDB8bQuDG95CHGJMC
         54F3g2bCsAez3hJZ5FbUVMtLgLm0adUxWP5AzWEkBfQCkbRIZBxmp+ZblKrBhT/L6fUp
         +Y6JhG2TGJK+KjLwuGpYfWMJqIbnOS03LBM3icXy5YhOLmEUsAN4EhTfniF943oOiV1P
         rAvn8kwz+DhjjPaWZmW+ExX7C7QfZW+ls9yodej5QnIGojNAXRrnr0NyWxghWd6fJth7
         4VL0boLcOWsGTtVUOWwYqIOwc5z+vNp2PBAfyUFu8WiFeJa6W2XFNosUDRC1xam8Bku1
         pqmA==
X-Gm-Message-State: AOAM532JNwjN9QzZYd83nz9fclzmjWQt/FKFI87K96Nw7U8TWkazK2Jh
        RdBiWvpbE+2Li9tMt+CvYL/gQL2Y0qgOWuCeDzg=
X-Google-Smtp-Source: ABdhPJyERhCb4O3nm0s7/49mWV7vHp1usGknfIZHGCd6SUBQSdmjw/vglCnxeaKpl8iOaHV3cbahnvht43xjqmxor7U=
X-Received: by 2002:a62:758f:: with SMTP id q137mr567110pfc.170.1597061285483;
 Mon, 10 Aug 2020 05:08:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200810091100.243932-1-leon@kernel.org>
In-Reply-To: <20200810091100.243932-1-leon@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 10 Aug 2020 15:07:49 +0300
Message-ID: <CAHp75VeCzvgPR4JdCndBrgtwBwk+_jT+EaxiDGXbx6yYcyMb5A@mail.gmail.com>
Subject: Re: [PATCH rdma-next] MAINTAINERS: Update Mellanox and Cumulus
 Network addresses to new domain
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 12:13 PM Leon Romanovsky <leon@kernel.org> wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
>
> Mellanox and Cumulus Network were acquired by Nvidia, so change the
> maintainers emails to new domain name.
>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

...

>  MELLANOX HARDWARE PLATFORM SUPPORT
>  M:     Andy Shevchenko <andy@infradead.org>
>  M:     Darren Hart <dvhart@infradead.org>
> -M:     Vadim Pasternak <vadimp@mellanox.com>
> +M:     Vadim Pasternak <vadimp@nvidia.com>
>  L:     platform-driver-x86@vger.kernel.org
>  S:     Supported
>  F:     Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
> @@ -11017,7 +11017,7 @@ F:      drivers/platform/mellanox/
>  F:     include/linux/platform_data/mlxreg.h

...

>  MELLANOX PLATFORM DRIVER
> -M:     Vadim Pasternak <vadimp@mellanox.com>
> +M:     Vadim Pasternak <vadimp@nvidia.com>
>  L:     platform-driver-x86@vger.kernel.org
>  S:     Supported
>  F:     drivers/platform/x86/mlx-platform.c
> @@ -12027,8 +12027,8 @@ F:      net/ipv6/syncookies.c
>  F:     net/ipv6/tcp*.c

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
for PDx86 related bits.

-- 
With Best Regards,
Andy Shevchenko
