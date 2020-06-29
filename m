Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15003C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAD412064B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bEMO9AAn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbgF2StC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729332AbgF2Srn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:47:43 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010F7C02E2C0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 06:58:15 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h22so10969348lji.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 06:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uCQ8gnTNmCbw3Jp4/ShmxDGjAQ3pvSFd1R7iQkCtV0o=;
        b=bEMO9AAnWp5LTsNLVdXW9Oe7mzKQhGXAj0e5OEmfEtAkG1cNaFNZSh2Qdo5mWbPuMY
         9DiqUdT+MsXYwleFvjrGxmVJqwyvuKXhxlQUK3rtF7VdMnvX7cTOhwoxwrJJLOVzNu5i
         2XK9FlT9eHx+sLquBViH/xZ5rB5rAhbPqcP9GuagM0OXFUt9wlcNzUKNy1aLnFdNwo+V
         8Ruz/vdEgYh0uNq8BnFoCh6EqK2N49EfB0DJU88m7ryxOsAPu8lNbY+iq10lCSBY9Mui
         ZPg6x5swpeRbq9anXoM2U2j46UxRzipSI496ZyBwvvY+KYVNwgj+Iwoz/AD7OkkAul0p
         isLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uCQ8gnTNmCbw3Jp4/ShmxDGjAQ3pvSFd1R7iQkCtV0o=;
        b=K8z7CbZ7f/bIKEL2UZNNiAyqeJ+zcH+MDRnGYkjcIiq8neWjAMCYMxY2O7dpv9Pb8x
         ehcrmg7fmNYNAnpjTndqZU3Q03IG+IRfpgfgditp1nqYII2Y0JcZB/fhwEWn4pr8GTfg
         IbQa79BKkfc91sZ/RHlsT1Q+DWzLzeE9Zlbgm0AmZLVx2AIOOyoNUaksUhbwUyreII/m
         R/6qDbhVL0ygq8eimHkeQuuGCTglWqJMPsQpF2YO0eqAgX22VMjd6zuyQdN4sw34ArXU
         VsVSjfGPrXSEOZ9xUPzP+bvjw1Kze5vAPCKRZSdN6z05NZlNF1ccXNWnPi7MFyJ1dk4O
         m/Yg==
X-Gm-Message-State: AOAM530fbl4cLveudISBXg4kyHN0JroKLDY0vid0h36KLkR5UueZcxo5
        Q3eIPacDzYm+58HrABLHDjeyjs41Glu5roQCHEHOsw==
X-Google-Smtp-Source: ABdhPJyszh+KKJKX6JxEpQEiu36tPTXZ+lFvnrC92R82eADyKCIBV3+TFvVd2yAYiyqz2uUbOeMX15KpV7G5lmjJkoI=
X-Received: by 2002:a2e:3504:: with SMTP id z4mr8452019ljz.283.1593439093501;
 Mon, 29 Jun 2020 06:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200629123003.1014387-1-lee.jones@linaro.org>
In-Reply-To: <20200629123003.1014387-1-lee.jones@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 29 Jun 2020 15:58:02 +0200
Message-ID: <CACRpkdYxRsCmK+3Zu9ywMZD=Y1c4N-27gj-w4eTwpRGGd2=-hw@mail.gmail.com>
Subject: Re: [PATCH 1/1] crypto: ux500: hash: Add namespacing to hash_init()
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 2:30 PM Lee Jones <lee.jones@linaro.org> wrote:

> A recent change to the Regulator consumer API (which this driver
> utilises) add prototypes for the some suspend functions.  These
> functions require including header file include/linux/suspend.h.
>
> The following tree of includes affecting this driver will be
> present:
>
>    In file included from include/linux/elevator.h:6,
>                     from include/linux/blkdev.h:288,
>                     from include/linux/blk-cgroup.h:23,
>                     from include/linux/writeback.h:14,
>                     from include/linux/memcontrol.h:22,
>                     from include/linux/swap.h:9,
>                     from include/linux/suspend.h:5,
>                     from include/linux/regulator/consumer.h:35,
>                     from drivers/crypto/ux500/hash/hash_core.c:28:
>
> include/linux/elevator.h pulls in include/linux/hashtable.h which
> contains its own version of hash_init().  This confuses the build
> system and results in the following error (amongst others):
>
>  drivers/crypto/ux500/hash/hash_core.c:1362:19: error: passing argument 1 of '__hash_init' from incompatible pointer type [-Werror=incompatible-pointer-types]
>  1362 |  return hash_init(req);
>
> Fix this by namespacing the local hash_init() such that the
> source of confusion is removed.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: linux-crypto@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

This looks reasonable.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
